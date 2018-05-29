Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754452AbeE2F51 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 01:57:27 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35455 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751852AbeE2F5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 01:57:24 -0400
X-Google-Smtp-Source: AB8JxZoc4ZAMWR1kxwcV1KgPy1XRC1QjcoDRFmbmvAhmf+7A7gBG94R0jxexUTKjLydf1bJnUT62eA==
From: Nick Desaulniers <nick.desaulniers@gmail.com>
To: jason.wessel@windriver.com, daniel.thompson@linaro.org
Cc: Nick Desaulniers <nick.desaulniers@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Randy Dunlap <rdunlap@infradead.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] kdb: prefer strlcpy to strncpy
Date: Mon, 28 May 2018 22:57:04 -0700
Message-Id: <1527573427-16569-1-git-send-email-nick.desaulniers@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes stringop-truncation and stringop-overflow warnings from gcc-8.

Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
---
 kernel/debug/kdb/kdb_io.c      | 2 +-
 kernel/debug/kdb/kdb_main.c    | 4 ++--
 kernel/debug/kdb/kdb_support.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index ed5d349..b5dfff1 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -443,7 +443,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
 char *kdb_getstr(char *buffer, size_t bufsize, const char *prompt)
 {
 	if (prompt && kdb_prompt_str != prompt)
-		strncpy(kdb_prompt_str, prompt, CMD_BUFLEN);
+		strlcpy(kdb_prompt_str, prompt, CMD_BUFLEN);
 	kdb_printf(kdb_prompt_str);
 	kdb_nextline = 1;	/* Prompt and input resets line number */
 	return kdb_read(buffer, bufsize);
diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index e405677..c30a0d8 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -1103,12 +1103,12 @@ static int handle_ctrl_cmd(char *cmd)
 	case CTRL_P:
 		if (cmdptr != cmd_tail)
 			cmdptr = (cmdptr-1) % KDB_CMD_HISTORY_COUNT;
-		strncpy(cmd_cur, cmd_hist[cmdptr], CMD_BUFLEN);
+		strlcpy(cmd_cur, cmd_hist[cmdptr], CMD_BUFLEN);
 		return 1;
 	case CTRL_N:
 		if (cmdptr != cmd_head)
 			cmdptr = (cmdptr+1) % KDB_CMD_HISTORY_COUNT;
-		strncpy(cmd_cur, cmd_hist[cmdptr], CMD_BUFLEN);
+		strlcpy(cmd_cur, cmd_hist[cmdptr], CMD_BUFLEN);
 		return 1;
 	}
 	return 0;
diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
index 990b3cc..dcfbf8f 100644
--- a/kernel/debug/kdb/kdb_support.c
+++ b/kernel/debug/kdb/kdb_support.c
@@ -236,7 +236,7 @@ int kallsyms_symbol_next(char *prefix_name, int flag)
 
 	while ((name = kdb_walk_kallsyms(&pos))) {
 		if (strncmp(name, prefix_name, prefix_len) == 0) {
-			strncpy(prefix_name, name, strlen(name)+1);
+			strlcpy(prefix_name, name, prefix_len);
 			return 1;
 		}
 	}
-- 
2.7.4
