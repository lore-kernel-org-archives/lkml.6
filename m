Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752586AbeEQGYU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 02:24:20 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:25008 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752149AbeEQGTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 02:19:16 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w4H6HbU9002841
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v4 11/31] kconfig: support user-defined function and recursively expanded variable
Date: Thu, 17 May 2018 15:16:50 +0900
Message-Id: <1526537830-22606-12-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
References: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, we got a basic ability to test compiler capability in Kconfig.

config CC_HAS_STACKPROTECTOR
        def_bool $(shell, ($(CC) -Werror -fstack-protector -E -x c /dev/null -o /dev/null 2>/dev/null) && echo y || echo n)

This works, but it is ugly to repeat this long boilerplate.

We want to describe like this:

config CC_HAS_STACKPROTECTOR
        bool
        default $(cc-option, -fstack-protector)

It is straight-forward to add a new function, but I do not like to
hard-code specialized functions like that.  Hence, here is another
feature, user-defined function.  This works as a textual shorthand
with parameterization.

A user-defined function is defined by using the = operator, and can
be referenced in the same way as built-in functions.  A user-defined
function in Make is referenced like $(call my-func,arg1,arg2), but I
omitted the 'call' to make the syntax shorter.

The definition of a user-defined function contains $(1), $(2), etc.
in its body to reference the parameters.  It is grammatically valid
to pass more or fewer arguments when calling it.  We already exploit
this feature in our makefiles; scripts/Kbuild.include defines cc-option
which takes two arguments at most, but most of the callers pass only
one argument.

By the way, a variable is supported as a subset of this feature since
a variable is "a user-defined function with zero argument".  In this
context, I mean "variable" as recursively expanded variable.  I will
add a different flavored variable in the next commit.

The code above can be written as follows:

[Example Code]

  success = $(shell, ($(1)) >/dev/null 2>&1 && echo y || echo n)
  cc-option = $(success, $(CC) -Werror $(1) -c -x c /dev/null -o /dev/null)

  config CC_HAS_STACKPROTECTOR
          def_bool $(cc-option, -fstack-protector)

[Result]
  $ make -s alldefconfig && tail -n 1 .config
  CONFIG_CC_HAS_STACKPROTECTOR=y

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v4: None
Changes in v3:
  - Re-implement the parse logic
  - Use = operator to define a user-defined function

Changes in v2:
  - Use 'macro' directly instead of inside the string type symbol.

 scripts/kconfig/lkc_proto.h  |   2 +
 scripts/kconfig/preprocess.c | 108 ++++++++++++++++++++++++++++++++++++++++++-
 scripts/kconfig/zconf.l      |  17 ++++++-
 scripts/kconfig/zconf.y      |  19 +++++++-
 4 files changed, 142 insertions(+), 4 deletions(-)

diff --git a/scripts/kconfig/lkc_proto.h b/scripts/kconfig/lkc_proto.h
index c46929f..2b16d6e 100644
--- a/scripts/kconfig/lkc_proto.h
+++ b/scripts/kconfig/lkc_proto.h
@@ -50,6 +50,8 @@ const char * prop_get_type_name(enum prop_type type);
 
 /* preprocess.c */
 void env_write_dep(FILE *f, const char *auto_conf_name);
+void variable_add(const char *name, const char *value);
+void variable_all_del(void);
 char *expand_string(const char *in);
 char *expand_dollar(const char **str);
 char *expand_one_token(const char **str);
diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
index d8c5f60..88580c4 100644
--- a/scripts/kconfig/preprocess.c
+++ b/scripts/kconfig/preprocess.c
@@ -201,18 +201,110 @@ static char *function_call(const char *name, int argc, char *argv[],
 }
 
 /*
+ * Variables (and user-defined functions)
+ */
+static LIST_HEAD(variable_list);
+
+struct variable {
+	char *name;
+	char *value;
+	struct list_head node;
+};
+
+static struct variable *variable_lookup(const char *name)
+{
+	struct variable *v;
+
+	list_for_each_entry(v, &variable_list, node) {
+		if (!strcmp(name, v->name))
+			return v;
+	}
+
+	return NULL;
+}
+
+static char *variable_expand(const char *name, int argc, char *argv[],
+			     int old_argc, char *old_argv[])
+{
+	struct variable *v;
+	char *expanded_argv[FUNCTION_MAX_ARGS], *res;
+	int i;
+
+	v = variable_lookup(name);
+	if (!v)
+		return NULL;
+
+	for (i = 0; i < argc; i++)
+		expanded_argv[i] = expand_string_with_args(argv[i],
+							   old_argc, old_argv);
+
+	res = expand_string_with_args(v->value, argc, expanded_argv);
+
+	for (i = 0; i < argc; i++)
+		free(expanded_argv[i]);
+
+	return res;
+}
+
+void variable_add(const char *name, const char *value)
+{
+	struct variable *v;
+
+	v = variable_lookup(name);
+	if (v) {
+		free(v->value);
+	} else {
+		v = xmalloc(sizeof(*v));
+		v->name = xstrdup(name);
+		list_add_tail(&v->node, &variable_list);
+	}
+
+	v->value = xstrdup(value);
+}
+
+static void variable_del(struct variable *v)
+{
+	list_del(&v->node);
+	free(v->name);
+	free(v->value);
+	free(v);
+}
+
+void variable_all_del(void)
+{
+	struct variable *v, *tmp;
+
+	list_for_each_entry_safe(v, tmp, &variable_list, node)
+		variable_del(v);
+}
+
+/*
  * Evaluate a clause with arguments.  argc/argv are arguments from the upper
  * function call.
  *
+ * Let's say 'foo' is defined as:
+ *   foo = ABC$(1)PQR(2)XYZ
+ * and you want to evaluate $(foo x,y)
+ *
+ * First, this helper is called with:
+ *   in  :    foo x,y
+ *   argc:    0
+ * and then, recursively called with:
+ *   in:      ABC$(1)PQR(2)XYZ
+ *   argc:    2
+ *   argv[0]: x
+ *   argv[1]: y
+ *
  * Returned string must be freed when done
  */
 static char *eval_clause(const char *in, int argc, char *argv[])
 {
-	char *tmp, *prev, *p, *res, *name;
+	char *tmp, *prev, *p, *res, *endptr, *name;
 	int new_argc = 0;
 	char *new_argv[FUNCTION_MAX_ARGS];
 	int nest = 0;
 	int i;
+	unsigned long n;
 
 	/*
 	 * Returns an empty string because '$()' should be evaluated
@@ -221,6 +313,15 @@ static char *eval_clause(const char *in, int argc, char *argv[])
 	if (!*in)
 		return xstrdup("");
 
+	/*
+	 * If variable name is '1', '2', etc.  It is generally an argument
+	 * from a user-function call (i.e. local-scope variable).  If not
+	 * available, then look-up global-scope variables.
+	 */
+	n = strtoul(in, &endptr, 10);
+	if (!*endptr && n > 0 && n <= argc)
+		return xstrdup(argv[n - 1]);
+
 	tmp = xstrdup(in);
 
 	prev = p = tmp;
@@ -268,6 +369,11 @@ static char *eval_clause(const char *in, int argc, char *argv[])
 	for (i = 0; i < new_argc; i++)
 		new_argv[i] = new_argv[i + 1];
 
+	/* Search for variables */
+	res = variable_expand(name, new_argc, new_argv, argc, argv);
+	if (res)
+		goto out;
+
 	/* Look for built-in functions */
 	res = function_call(name, new_argc, new_argv, argc, argv);
 	if (res)
diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
index 5e53348..19e5ebf 100644
--- a/scripts/kconfig/zconf.l
+++ b/scripts/kconfig/zconf.l
@@ -1,12 +1,13 @@
 %option nostdinit noyywrap never-interactive full ecs
 %option 8bit nodefault yylineno
-%x COMMAND HELP STRING PARAM
+%x COMMAND HELP STRING PARAM ASSIGN_VAL
 %{
 /*
  * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
  * Released under the terms of the GNU GPL v2.0.
  */
 
+#include <assert.h>
 #include <limits.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -111,8 +112,10 @@ n	[A-Za-z0-9_-]
 		}
 		alloc_string(yytext, yyleng);
 		yylval.string = text;
-		return T_WORD;
+		return T_VARIABLE;
 	}
+	"="	{ BEGIN(ASSIGN_VAL); return T_ASSIGN; }
+	[[:blank:]]+
 	.	warn_ignored_character(*yytext);
 	\n	{
 		BEGIN(INITIAL);
@@ -120,6 +123,16 @@ n	[A-Za-z0-9_-]
 	}
 }
 
+<ASSIGN_VAL>{
+	[^[:blank:]\n]+.*	{
+		alloc_string(yytext, yyleng);
+		yylval.string = text;
+		return T_ASSIGN_VAL;
+	}
+	\n	{ BEGIN(INITIAL); return T_EOL; }
+	.
+}
+
 <PARAM>{
 	"&&"	return T_AND;
 	"||"	return T_OR;
diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
index 22e318c..6201119 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -77,6 +77,9 @@ static struct menu *current_menu, *current_entry;
 %token T_CLOSE_PAREN
 %token T_OPEN_PAREN
 %token T_EOL
+%token <string> T_VARIABLE
+%token T_ASSIGN
+%token <string> T_ASSIGN_VAL
 
 %left T_OR
 %left T_AND
@@ -92,7 +95,7 @@ static struct menu *current_menu, *current_entry;
 %type <id> end
 %type <id> option_name
 %type <menu> if_entry menu_entry choice_entry
-%type <string> symbol_option_arg word_opt
+%type <string> symbol_option_arg word_opt assign_val
 
 %destructor {
 	fprintf(stderr, "%s:%d: missing end statement for this entry\n",
@@ -143,6 +146,7 @@ common_stmt:
 	| config_stmt
 	| menuconfig_stmt
 	| source_stmt
+	| assignment_stmt
 ;
 
 option_error:
@@ -511,6 +515,15 @@ symbol:	  nonconst_symbol
 word_opt: /* empty */			{ $$ = NULL; }
 	| T_WORD
 
+/* assignment statement */
+
+assignment_stmt:  T_VARIABLE T_ASSIGN assign_val T_EOL	{ variable_add($1, $3); free($1); free($3); }
+
+assign_val:
+	/* empty */		{ $$ = xstrdup(""); };
+	| T_ASSIGN_VAL
+;
+
 %%
 
 void conf_parse(const char *name)
@@ -525,6 +538,10 @@ void conf_parse(const char *name)
 	if (getenv("ZCONF_DEBUG"))
 		yydebug = 1;
 	yyparse();
+
+	/* Variables are expanded in the parse phase. We can free them here. */
+	variable_all_del();
+
 	if (yynerrs)
 		exit(1);
 	if (!modules_sym)
-- 
2.7.4
