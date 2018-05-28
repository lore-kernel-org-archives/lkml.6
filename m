Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754307AbeE1JYO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:24:14 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:21449 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754133AbeE1JYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:24:12 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w4S9MInU027506
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
Subject: [PATCH v5 13/31] kconfig: support simply expanded variable
Date: Mon, 28 May 2018 18:21:50 +0900
Message-Id: <1527499328-13213-14-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
References: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
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

Changes in v5:
  - Fix multiple expansion bug of simple variables

Changes in v4: None
Changes in v3:
  - newly added

Changes in v2: None

 scripts/kconfig/lkc_proto.h  |  7 ++++++-
 scripts/kconfig/preprocess.c | 19 ++++++++++++++++---
 scripts/kconfig/zconf.l      |  3 ++-
 scripts/kconfig/zconf.y      |  5 +++--
 4 files changed, 27 insertions(+), 7 deletions(-)

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
index 46487fe..d103683 100644
--- a/scripts/kconfig/preprocess.c
+++ b/scripts/kconfig/preprocess.c
@@ -185,6 +185,7 @@ static LIST_HEAD(variable_list);
 struct variable {
 	char *name;
 	char *value;
+	enum variable_flavor flavor;
 	struct list_head node;
 };
 
@@ -203,15 +204,22 @@ static struct variable *variable_lookup(const char *name)
 static char *variable_expand(const char *name, int argc, char *argv[])
 {
 	struct variable *v;
+	char *res;
 
 	v = variable_lookup(name);
 	if (!v)
 		return NULL;
 
-	return expand_string_with_args(v->value, argc, argv);
+	if (v->flavor == VAR_RECURSIVE)
+		res = expand_string_with_args(v->value, argc, argv);
+	else
+		res = xstrdup(v->value);
+
+	return res;
 }
 
-void variable_add(const char *name, const char *value)
+void variable_add(const char *name, const char *value,
+		  enum variable_flavor flavor)
 {
 	struct variable *v;
 
@@ -224,7 +232,12 @@ void variable_add(const char *name, const char *value)
 		list_add_tail(&v->node, &variable_list);
 	}
 
-	v->value = xstrdup(value);
+	v->flavor = flavor;
+
+	if (flavor == VAR_SIMPLE)
+		v->value = expand_string(value);
+	else
+		v->value = xstrdup(value);
 }
 
 static void variable_del(struct variable *v)
diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
index dd08f7a..376af6c 100644
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
index e15e8c7..6f9b0aa 100644
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
