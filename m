Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753800AbeDMFOE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 01:14:04 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:54462 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751036AbeDMFIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 01:08:15 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w3D56lg7029209
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/30] kconfig: support simply expanded variable
Date: Fri, 13 Apr 2018 14:06:22 +0900
Message-Id: <1523595999-27433-14-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous commit added variable and user-defined function.  They
work similarly in the sense that the evaluation is deferred until
they are used.

This commit adds another type of variable, simply expanded variable,
as we see in Make.

The := operator defines a simply expanded variable, expanding the
righthand side immediately.  This works like traditional programming
language variables.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3:
  - newly added

Changes in v2: None

 scripts/kconfig/lkc_proto.h  | 7 ++++++-
 scripts/kconfig/preprocess.c | 6 ++++--
 scripts/kconfig/zconf.l      | 3 ++-
 scripts/kconfig/zconf.y      | 5 +++--
 4 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/scripts/kconfig/lkc_proto.h b/scripts/kconfig/lkc_proto.h
index 2b16d6e..6303193 100644
--- a/scripts/kconfig/lkc_proto.h
+++ b/scripts/kconfig/lkc_proto.h
@@ -49,8 +49,13 @@ const char * sym_get_string_value(struct symbol *sym);
 const char * prop_get_type_name(enum prop_type type);
 
 /* preprocess.c */
+enum variable_flavor {
+	VAR_SIMPLE,
+	VAR_RECURSIVE,
+};
 void env_write_dep(FILE *f, const char *auto_conf_name);
-void variable_add(const char *name, const char *value);
+void variable_add(const char *name, const char *value,
+		  enum variable_flavor flavor);
 void variable_all_del(void);
 char *expand_string(const char *in);
 char *expand_dollar(const char **str);
diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
index 1b746e0..a835c94 100644
--- a/scripts/kconfig/preprocess.c
+++ b/scripts/kconfig/preprocess.c
@@ -112,7 +112,8 @@ static char *variable_expand(const char *name, int argc, char *argv[])
 	return expand_string_with_args(v->value, argc, argv);
 }
 
-void variable_add(const char *name, const char *value)
+void variable_add(const char *name, const char *value,
+		  enum variable_flavor flavor)
 {
 	struct variable *v;
 
@@ -125,7 +126,8 @@ void variable_add(const char *name, const char *value)
 		list_add_tail(&v->node, &variable_list);
 	}
 
-	v->value = xstrdup(value);
+	v->value = (flavor == VAR_SIMPLE) ? expand_string(value) :
+								xstrdup(value);
 }
 
 static void variable_del(struct variable *v)
diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
index 19e5ebf..aa76942 100644
--- a/scripts/kconfig/zconf.l
+++ b/scripts/kconfig/zconf.l
@@ -114,7 +114,8 @@ n	[A-Za-z0-9_-]
 		yylval.string = text;
 		return T_VARIABLE;
 	}
-	"="	{ BEGIN(ASSIGN_VAL); return T_ASSIGN; }
+	"="	{ BEGIN(ASSIGN_VAL); yylval.flavor = VAR_RECURSIVE; return T_ASSIGN; }
+	":="	{ BEGIN(ASSIGN_VAL); yylval.flavor = VAR_SIMPLE; return T_ASSIGN; }
 	[[:blank:]]+
 	.	warn_ignored_character(*yytext);
 	\n	{
diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
index 493388c..1ebbf9e 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -41,6 +41,7 @@ static struct menu *current_menu, *current_entry;
 	struct expr *expr;
 	struct menu *menu;
 	const struct kconf_id *id;
+	enum variable_flavor flavor;
 }
 
 %token <id>T_MAINMENU
@@ -78,7 +79,7 @@ static struct menu *current_menu, *current_entry;
 %token T_OPEN_PAREN
 %token T_EOL
 %token <string> T_VARIABLE
-%token T_ASSIGN
+%token <flavor> T_ASSIGN
 %token <string> T_ASSIGN_VAL
 
 %left T_OR
@@ -517,7 +518,7 @@ word_opt: /* empty */			{ $$ = NULL; }
 
 /* assignment statement */
 
-assignment_stmt:  T_VARIABLE T_ASSIGN assign_val T_EOL	{ variable_add($1, $3); free($1); free($3); }
+assignment_stmt:  T_VARIABLE T_ASSIGN assign_val T_EOL	{ variable_add($1, $3, $2); free($1); free($3); }
 
 assign_val:
 	/* empty */		{ $$ = xstrdup(""); };
-- 
2.7.4
