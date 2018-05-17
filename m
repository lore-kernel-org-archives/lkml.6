Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752583AbeEQGYP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 02:24:15 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:24993 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbeEQGTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 02:19:16 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w4H6HbUF002841
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v4 17/31] kconfig: add 'filename' and 'lineno' built-in variables
Date: Thu, 17 May 2018 15:16:56 +0900
Message-Id: <1526537830-22606-18-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
References: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The special variables, $(filename) and $(lineno), are expanded to a
file name and its line number being parsed, respectively.

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v4:
 - Newly added

Changes in v3: None
Changes in v2: None

 scripts/kconfig/preprocess.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
index 88844a7..c39e30e 100644
--- a/scripts/kconfig/preprocess.c
+++ b/scripts/kconfig/preprocess.c
@@ -111,6 +111,11 @@ static char *do_error(int argc, char *argv[], int old_argc, char *old_argv[])
 	return NULL;
 }
 
+static char *do_filename(int argc, char *argv[], int old_argc, char *old_argv[])
+{
+	return xstrdup(current_file->name);
+}
+
 static char *do_if(int argc, char *argv[], int old_argc, char *old_argv[])
 {
 	char *cond, *p, *res;
@@ -144,6 +149,15 @@ static char *do_info(int argc, char *argv[], int old_argc, char *old_argv[])
 	return xstrdup("");
 }
 
+static char *do_lineno(int argc, char *argv[], int old_argc, char *old_argv[])
+{
+	char buf[16];
+
+	sprintf(buf, "%d", yylineno);
+
+	return xstrdup(buf);
+}
+
 static char *do_shell(int argc, char *argv[], int old_argc, char *old_argv[])
 {
 	FILE *p;
@@ -194,8 +208,10 @@ static char *do_warning(int argc, char *argv[], int old_argc, char *old_argv[])
 static const struct function function_table[] = {
 	/* Name		MIN	MAX	EXP?	Function */
 	{ "error",	1,	1,	true,	do_error },
+	{ "filename",	0,	0,	false,	do_filename },
 	{ "if",		2,	3,	false,	do_if },
 	{ "info",	1,	1,	true,	do_info },
+	{ "lineno",	0,	0,	false,	do_lineno },
 	{ "shell",	1,	1,	true,	do_shell },
 	{ "warning",	1,	1,	true,	do_warning },
 };
-- 
2.7.4
