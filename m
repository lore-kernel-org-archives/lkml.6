Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbeEQGYN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 02:24:13 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:25000 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752153AbeEQGTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 02:19:16 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w4H6HbUD002841
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v4 15/31] kconfig: add 'info', 'warning', and 'error' built-in functions
Date: Thu, 17 May 2018 15:16:54 +0900
Message-Id: <1526537830-22606-16-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
References: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'info', 'warning', and 'error' functions as in Make.

They print messages during parsing Kconfig files. 'error' will be
useful to terminate the parsing immediately in fatal cases.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v4:
  - Add 'error' function

Changes in v3: None
Changes in v2: None

 scripts/kconfig/preprocess.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
index 47b32dc..591bcf7 100644
--- a/scripts/kconfig/preprocess.c
+++ b/scripts/kconfig/preprocess.c
@@ -104,6 +104,20 @@ struct function {
 	char *(*func)(int argc, char *argv[], int old_argc, char *old_argv[]);
 };
 
+static char *do_error(int argc, char *argv[], int old_argc, char *old_argv[])
+{
+	pperror("%s", argv[0]);
+
+	return NULL;
+}
+
+static char *do_info(int argc, char *argv[], int old_argc, char *old_argv[])
+{
+	printf("%s\n", argv[0]);
+
+	return xstrdup("");
+}
+
 static char *do_shell(int argc, char *argv[], int old_argc, char *old_argv[])
 {
 	FILE *p;
@@ -144,9 +158,19 @@ static char *do_shell(int argc, char *argv[], int old_argc, char *old_argv[])
 	return xstrdup(buf);
 }
 
+static char *do_warning(int argc, char *argv[], int old_argc, char *old_argv[])
+{
+	fprintf(stderr, "%s:%d: %s\n", current_file->name, yylineno, argv[0]);
+
+	return xstrdup("");
+}
+
 static const struct function function_table[] = {
 	/* Name		MIN	MAX	EXP?	Function */
+	{ "error",	1,	1,	true,	do_error },
+	{ "info",	1,	1,	true,	do_info },
 	{ "shell",	1,	1,	true,	do_shell },
+	{ "warning",	1,	1,	true,	do_warning },
 };
 
 #define FUNCTION_MAX_ARGS		16
-- 
2.7.4
