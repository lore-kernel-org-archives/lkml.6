Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754478AbeE1J3s (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:29:48 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:21615 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754319AbeE1JYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:24:16 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w4S9MInY027506
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
Subject: [PATCH v5 17/31] kconfig: add 'filename' and 'lineno' built-in variables
Date: Mon, 28 May 2018 18:21:54 +0900
Message-Id: <1527499328-13213-18-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
References: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The special variables, $(filename) and $(lineno), are expanded to a
file name and its line number being parsed, respectively.

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---

Changes in v5: None
Changes in v4:
 - Newly added

Changes in v3: None
Changes in v2: None

 scripts/kconfig/preprocess.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
index 5ee58ee..0574039 100644
--- a/scripts/kconfig/preprocess.c
+++ b/scripts/kconfig/preprocess.c
@@ -114,6 +114,11 @@ static char *do_error_if(int argc, char *argv[])
 	return NULL;
 }
 
+static char *do_filename(int argc, char *argv[])
+{
+	return xstrdup(current_file->name);
+}
+
 static char *do_info(int argc, char *argv[])
 {
 	printf("%s\n", argv[0]);
@@ -121,6 +126,15 @@ static char *do_info(int argc, char *argv[])
 	return xstrdup("");
 }
 
+static char *do_lineno(int argc, char *argv[])
+{
+	char buf[16];
+
+	sprintf(buf, "%d", yylineno);
+
+	return xstrdup(buf);
+}
+
 static char *do_shell(int argc, char *argv[])
 {
 	FILE *p;
@@ -173,7 +187,9 @@ static char *do_warning_if(int argc, char *argv[])
 static const struct function function_table[] = {
 	/* Name		MIN	MAX	Function */
 	{ "error-if",	2,	2,	do_error_if },
+	{ "filename",	0,	0,	do_filename },
 	{ "info",	1,	1,	do_info },
+	{ "lineno",	0,	0,	do_lineno },
 	{ "shell",	1,	1,	do_shell },
 	{ "warning-if",	2,	2,	do_warning_if },
 };
-- 
2.7.4
