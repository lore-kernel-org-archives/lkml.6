Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbeCVRBa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 13:01:30 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:47944 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751758AbeCVRBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 13:01:25 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w2MH0Mr4012430
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] kconfig: use yylineno option instead of manual lineno increments
Date: Fri, 23 Mar 2018 02:00:14 +0900
Message-Id: <1521738014-18895-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521738014-18895-1-git-send-email-yamada.masahiro@socionext.com>
References: <1521738014-18895-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tracking the line number by hand is error-prone since we need to make
sure to increment it in all the \n matching patterns.

If '%option yylineno' is set, flex defines 'yylineno' to contain the
current line number and automatically updates it each time it reads a
\n character.  This is much more convenient although the lexer does
not initializes yylineno, so you need to set it to 1 each time you
start reading a new file, and restore it you go back to the previous
file.

I tested this with DEBUG_PARSE, and confirmed the same dump message
was produced.

I removed the perf-report option.  Otherwise, I see the following
message:
  %option yylineno entails a performance penalty ONLY on rules that
  can match newline characters

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/lkc.h   |  1 +
 scripts/kconfig/zconf.l | 20 +++++++++-----------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
index 2d5ec2d..f4394af 100644
--- a/scripts/kconfig/lkc.h
+++ b/scripts/kconfig/lkc.h
@@ -68,6 +68,7 @@ struct kconf_id {
 	enum symbol_type stype;
 };
 
+extern int yylineno;
 void zconfdump(FILE *out);
 void zconf_starthelp(void);
 FILE *zconf_fopen(const char *name);
diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
index 29b5d33..045093d 100644
--- a/scripts/kconfig/zconf.l
+++ b/scripts/kconfig/zconf.l
@@ -1,5 +1,5 @@
 %option nostdinit noyywrap never-interactive full ecs
-%option 8bit nodefault perf-report perf-report
+%option 8bit nodefault yylineno
 %option noinput
 %x COMMAND HELP STRING PARAM
 %{
@@ -83,7 +83,6 @@ n	[A-Za-z0-9_-]
 
 [ \t]*#.*\n	|
 [ \t]*\n	{
-	current_file->lineno++;
 	return T_EOL;
 }
 [ \t]*#.*
@@ -104,7 +103,7 @@ n	[A-Za-z0-9_-]
 		const struct kconf_id *id = kconf_id_lookup(yytext, yyleng);
 		BEGIN(PARAM);
 		current_pos.file = current_file;
-		current_pos.lineno = current_file->lineno;
+		current_pos.lineno = yylineno;
 		if (id && id->flags & TF_COMMAND) {
 			yylval.id = id;
 			return id->token;
@@ -116,7 +115,6 @@ n	[A-Za-z0-9_-]
 	.	warn_ignored_character(*yytext);
 	\n	{
 		BEGIN(INITIAL);
-		current_file->lineno++;
 		return T_EOL;
 	}
 }
@@ -138,7 +136,7 @@ n	[A-Za-z0-9_-]
 		new_string();
 		BEGIN(STRING);
 	}
-	\n	BEGIN(INITIAL); current_file->lineno++; return T_EOL;
+	\n	BEGIN(INITIAL); return T_EOL;
 	({n}|[/.])+	{
 		const struct kconf_id *id = kconf_id_lookup(yytext, yyleng);
 		if (id && id->flags & TF_PARAM) {
@@ -150,7 +148,7 @@ n	[A-Za-z0-9_-]
 		return T_WORD;
 	}
 	#.*	/* comment */
-	\\\n	current_file->lineno++;
+	\\\n	;
 	[[:blank:]]+
 	.	warn_ignored_character(*yytext);
 	<<EOF>> {
@@ -187,7 +185,6 @@ n	[A-Za-z0-9_-]
 		fprintf(stderr,
 			"%s:%d:warning: multi-line strings not supported\n",
 			zconf_curname(), zconf_lineno());
-		current_file->lineno++;
 		BEGIN(INITIAL);
 		return T_EOL;
 	}
@@ -220,12 +217,10 @@ n	[A-Za-z0-9_-]
 		}
 	}
 	[ \t]*\n/[^ \t\n] {
-		current_file->lineno++;
 		zconf_endhelp();
 		return T_HELPTEXT;
 	}
 	[ \t]*\n	{
-		current_file->lineno++;
 		append_string("\n", 1);
 	}
 	[^ \t\n].* {
@@ -304,7 +299,7 @@ void zconf_initscan(const char *name)
 	memset(current_buf, 0, sizeof(*current_buf));
 
 	current_file = file_lookup(name);
-	current_file->lineno = 1;
+	yylineno = 1;
 }
 
 void zconf_nextfile(const char *name)
@@ -325,6 +320,7 @@ void zconf_nextfile(const char *name)
 	buf->parent = current_buf;
 	current_buf = buf;
 
+	current_file->lineno = yylineno;
 	file->parent = current_file;
 
 	for (iter = current_file; iter; iter = iter->parent) {
@@ -343,7 +339,7 @@ void zconf_nextfile(const char *name)
 		}
 	}
 
-	file->lineno = 1;
+	yylineno = 1;
 	current_file = file;
 }
 
@@ -352,6 +348,8 @@ static void zconf_endfile(void)
 	struct buffer *parent;
 
 	current_file = current_file->parent;
+	if (current_file)
+		yylineno = current_file->lineno;
 
 	parent = current_buf->parent;
 	if (parent) {
-- 
2.7.4
