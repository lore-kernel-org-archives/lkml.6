Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933976AbeE1J2R (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:28:17 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:21625 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754333AbeE1JYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:24:17 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w4S9MInX027506
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v5 16/31] kconfig: add 'info', 'warning-if', and 'error-if' built-in functions
Date: Mon, 28 May 2018 18:21:53 +0900
Message-Id: <1527499328-13213-17-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
References: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syntax:
  $(info,<text>)
  $(warning-if,<condition>,<text>)
  $(error-if,<condition>,<text)

The 'info' function prints a message to stdout as in Make.

The 'warning-if' and 'error-if' are similar to 'warning' and 'error'
in Make, but take the condition parameter.  They are effective only
when the <condition> part is y.

Kconfig does not implement the lazy expansion as used in the 'if'
'and, 'or' functions in Make.  In other words, Kconfig does not
support conditional expansion.  The unconditional 'error' function
would always terminate the parsing, hence would be useless in Kconfig.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---

Changes in v5:
  - Replace 'warning', 'error' with 'warning-if', 'error-if'

Changes in v4:
  - Add 'error' function

Changes in v3: None
Changes in v2: None

 scripts/kconfig/preprocess.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
index 56aa1f0..5ee58ee 100644
--- a/scripts/kconfig/preprocess.c
+++ b/scripts/kconfig/preprocess.c
@@ -106,6 +106,21 @@ struct function {
 	char *(*func)(int argc, char *argv[]);
 };
 
+static char *do_error_if(int argc, char *argv[])
+{
+	if (!strcmp(argv[0], "y"))
+		pperror("%s", argv[1]);
+
+	return NULL;
+}
+
+static char *do_info(int argc, char *argv[])
+{
+	printf("%s\n", argv[0]);
+
+	return xstrdup("");
+}
+
 static char *do_shell(int argc, char *argv[])
 {
 	FILE *p;
@@ -146,9 +161,21 @@ static char *do_shell(int argc, char *argv[])
 	return xstrdup(buf);
 }
 
+static char *do_warning_if(int argc, char *argv[])
+{
+	if (!strcmp(argv[0], "y"))
+		fprintf(stderr, "%s:%d: %s\n",
+			current_file->name, yylineno, argv[1]);
+
+	return xstrdup("");
+}
+
 static const struct function function_table[] = {
 	/* Name		MIN	MAX	Function */
+	{ "error-if",	2,	2,	do_error_if },
+	{ "info",	1,	1,	do_info },
 	{ "shell",	1,	1,	do_shell },
+	{ "warning-if",	2,	2,	do_warning_if },
 };
 
 #define FUNCTION_MAX_ARGS		16
-- 
2.7.4
