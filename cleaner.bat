@echo off
:: Solicitar permissoes de administrador
echo Requisitando permissoes de administrador...
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo Por favor, execute como Administrador.
    pause
    exit
)

:: Apagar arquivos na pasta Temp
set "TEMP_DIR=%SYSTEMROOT%\Temp"
if exist "%TEMP_DIR%" (
    echo Limpando arquivos na pasta Temp...
    del /f /q "%TEMP_DIR%\*" >nul 2>&1
)

:: Apagar arquivos na pasta %temp%
set "USER_TEMP=%TEMP%"
if exist "%USER_TEMP%" (
    echo Limpando arquivos na pasta %%temp%%...
    del /f /q "%USER_TEMP%\*" >nul 2>&1
)

:: Apagar arquivos na pasta Prefetch
set "PREFETCH_DIR=%SYSTEMROOT%\Prefetch"
if exist "%PREFETCH_DIR%" (
    echo Limpando arquivos na pasta Prefetch...
    del /f /q "%PREFETCH_DIR%\*" >nul 2>&1
)

:: Apagar arquivos na pasta Recent
set "RECENT_DIR=%USERPROFILE%\Recent"
if exist "%RECENT_DIR%" (
    echo Limpando arquivos na pasta Recent...
    del /f /q "%RECENT_DIR%\*" >nul 2>&1
)

:: Limpar a pasta DigitalElements
echo Limpando a pasta DigitalElements...
if exist "%USERPROFILE%\AppData\Local\DigitalElements" (
    del /f /s /q "%USERPROFILE%\AppData\Local\DigitalElements\*.*" >nul 2>&1
    rd /s /q "%USERPROFILE%\AppData\Local\DigitalElements" >nul 2>&1
)

:: Definir o caminho da pasta "FiveMApplicationData"
set "FIVEM_DIR=%USERPROFILE%\AppData\Local\FiveM\FiveM.app"

:: Verificar se o diretório existe
if not exist "%FIVEM_DIR%" (
    echo A pasta "FiveM Application Data" nao foi encontrada.
    pause
    exit
)

:: Apagar todos os arquivos e pastas em "FiveM Application Data", exceto a pasta "data"
echo Limpando arquivos e pastas em "FiveM Application Data", exceto "data"...
for /f "delims=" %%i in ('dir /b /a-d "%FIVEM_DIR%"') do (
    del /f /q "%FIVEM_DIR%\%%i" >nul 2>&1
)
for /d %%i in ("%FIVEM_DIR%\*") do (
    if /i not "%%~nxi"=="data" (
        rd /s /q "%%i" >nul 2>&1
    )
)

:: Verificar se a pasta "data" existe
set "DATA_DIR=%FIVEM_DIR%\data"
if exist "%DATA_DIR%" (
    :: Apagar tudo dentro de "data", exceto "game-storage"
    echo Limpando conteudo da pasta "data", exceto "game-storage"...
    for /f "delims=" %%i in ('dir /b /a-d "%DATA_DIR%"') do (
        if /i not "%%~nxi"=="game-storage" (
            del /f /q "%DATA_DIR%\%%i" >nul 2>&1
        )
    )
    for /d %%i in ("%DATA_DIR%\*") do (
        if /i not "%%~nxi"=="game-storage" (
            rd /s /q "%%i" >nul 2>&1
        )
    )
)


echo Limpeza concluida!
pause
exit
