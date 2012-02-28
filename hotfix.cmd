CLS
@ECHO off
COLOR 70
MODE CON COLS=70 LINES=20
IF /I "%1" == "" (
    SET NoBackup=/passive /norestart
    SET NoBackup_Comment=^(將備份系統檔^)
) ELSE (
    IF /I "%1" == "/NoBackup" (
        SET NoBackup=/passive /norestart /nobackup
	SET NoBackup_Comment=^(不備份系統檔^)
           ) ELSE (
              IF /I "%1" == "/?" GOTO help
              IF /I "%1" == "/help" GOTO help
        ECHO 無效的參數 - "%1".
	ECHO.
	GOTO Help
    )
)
ECHO.
ECHO ------------------------------------------------------------------
ECHO   以下將自動安裝的軟體 (Update to 2012/01)
ECHO   1. Windows XP SP3 之後的所有修正檔%NoBackup_Comment%
ECHO   2. Windows Internet Explorer 8 之後的所有修正檔%NoBackup_Comment%
ECHO   3. Windows Media Player 11 之後的所有修正檔%NoBackup_Comment%
ECHO.
ECHO                                           更新日期：2012/02/28
ECHO ------------------------------------------------------------------
ECHO.
ECHO   1. 正在安裝 Windows XP SP3 之後的所有修正檔，請稍後...
ECHO      ├正在安裝 HotFix Type 1，請稍後...
FOR %%i in (wxpsp3\hotfix1\Windows*.exe) do start /wait %%i %NoBackup%
ECHO      ├正在安裝 HotFix Type 2，請稍後...
FOR %%i in (wxpsp3\hotfix2\*.exe) do start /wait %%i /Q:U /R:N
ECHO      ├正在安裝 HotFix Type 3，請稍後...
FOR %%i in (wxpsp3\hotfix3\*.exe) do start /wait %%i %NoBackup%
FOR %%i in (wxpsp3\hotfix3\*.msi) do start /wait %%i /passive /norestart
ECHO      ├正在安裝 HotFix Type 4，請稍後...
FOR %%i in (wxpsp3\hotfix4\*.exe) do start /wait %%i /Q
ECHO      ├正在安裝 Microsoft Update 元件，請稍後...
xcopy wxpsp3\hotfix5\muweb.dll %SystemRoot%\System32\ /y > nul
start /wait regsvr32 /s muweb.dll
start /wait wxpsp3\hotfix5\wuSETup.exe /quiet /norestart
ECHO      安裝完成。
ECHO.
ECHO   2. 正在安裝 Windows Internet Explorer 8 之後的所有修正檔，請稍後..
ECHO      ├正在安裝 HotFix Type 1，請稍後...
FOR %%i in (ie8\hotfix1\*.exe) do start /wait %%i %NoBackup%
ECHO      ├正在安裝 HotFix Type 2，請稍後...
FOR %%i in (ie8\hotfix2\*.exe) do start /wait %%i %NoBackup%
ECHO      ├正在安裝 HotFix Type 3，請稍後...
FOR %%i in (ie8\hotfix3\*.exe) do start /wait %%i %NoBackup%
ECHO      安裝完成。
ECHO.
ECHO   2. 正在安裝 Windows Media Player 11 之後的所有修正檔，請稍後..
ECHO      ├正在安裝 HotFix Type 1，請稍後...
FOR %%i in (wmp11\hotfix1\*.exe) do start /wait %%i %NoBackup%
ECHO      ├正在安裝 HotFix Type 2，請稍後...
FOR %%i in (wmp11\hotfix2\*.exe) do start /wait %%i %NoBackup%
ECHO      安裝完成。
ECHO.
GOTO End

:Help
ECHO.
ECHO HOTFIX [/NoBackup ^| /Help]
ECHO.
ECHO    hotfix.cmd 可用參數：
ECHO      無              安裝修正檔時，將備份系統檔案，可供移除修正檔。
ECHO      /NoBackup       安裝修正檔時，不備份系統檔案，不可移除修正檔。
ECHO      /Help           顯示本說明資訊。
ECHO.
ECHO.
ECHO    請按任意鍵關閉視窗。
PAUSE
GOTO end

:End
EXIT

