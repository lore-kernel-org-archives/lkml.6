Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754359AbeE1J3Z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:29:25 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:21624 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754331AbeE1JYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:24:16 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w4S9MInP027506
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
Subject: [PATCH v5 08/31] kconfig: add built-in function support
Date: Mon, 28 May 2018 18:21:45 +0900
Message-Id: <1527499328-13213-9-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
References: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a new concept 'function' to do more text processing
in Kconfig.

A function call looks like this:

  $(function,arg1,arg2,arg3,...)

This commit adds the basic infrastructure to expand functions.
Change the text expansion helpers to take arguments.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v5:
  - Drop delayed expansion of arguments.

Changes in v4:
  - Error out if arguments more than FUNCTION_MAX_ARGS are passed
  - Use a comma as a delimiter between the function name and the
    first argument
  - Check the number of arguments accepted by each function
  - Support delayed expansion of arguments.
    This will be needed to implement 'if' function

Changes in v3:
  - Split base infrastructure and 'shell' function
    into separate patches.

Changes in v2:
  - Use 'shell' for getting stdout from the comment.
    It was 'shell-stdout' in the previous version.
  - Simplify the implementation since the expansion has been moved to
    lexer.

 scripts/kconfig/preprocess.c | 142 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 130 insertions(+), 12 deletions(-)

diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
index a2eb2eb..f32a496 100644
--- a/scripts/kconfig/preprocess.c
+++ b/scripts/kconfig/preprocess.c
@@ -10,6 +10,10 @@
 
 #include "list.h"
 
+#define ARRAY_SIZE(arr)		(sizeof(arr) / sizeof((arr)[0]))
+
+static char *expand_string_with_args(const char *in, int argc, char *argv[]);
+
 static void __attribute__((noreturn)) pperror(const char *format, ...)
 {
 	va_list ap;
@@ -92,20 +96,123 @@ void env_write_dep(FILE *f, const char *autoconfig_name)
 	}
 }
 
-static char *eval_clause(const char *str, size_t len)
+/*
+ * Built-in functions
+ */
+struct function {
+	const char *name;
+	unsigned int min_args;
+	unsigned int max_args;
+	char *(*func)(int argc, char *argv[]);
+};
+
+static const struct function function_table[] = {
+	/* Name		MIN	MAX	Function */
+};
+
+#define FUNCTION_MAX_ARGS		16
+
+static char *function_expand(const char *name, int argc, char *argv[])
 {
-	char *tmp, *name, *res;
+	const struct function *f;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(function_table); i++) {
+		f = &function_table[i];
+		if (strcmp(f->name, name))
+			continue;
+
+		if (argc < f->min_args)
+			pperror("too few function arguments passed to '%s'",
+				name);
+
+		if (argc > f->max_args)
+			pperror("too many function arguments passed to '%s'",
+				name);
+
+		return f->func(argc, argv);
+	}
+
+	return NULL;
+}
+
+/*
+ * Evaluate a clause with arguments.  argc/argv are arguments from the upper
+ * function call.
+ *
+ * Returned string must be freed when done
+ */
+static char *eval_clause(const char *str, size_t len, int argc, char *argv[])
+{
+	char *tmp, *name, *res, *prev, *p;
+	int new_argc = 0;
+	char *new_argv[FUNCTION_MAX_ARGS];
+	int nest = 0;
+	int i;
 
 	tmp = xstrndup(str, len);
 
-	name = expand_string(tmp);
+	prev = p = tmp;
+
+	/*
+	 * Split into tokens
+	 * The function name and arguments are separated by a comma.
+	 * For example, if the function call is like this:
+	 *   $(foo,$(x),$(y))
+	 *
+	 * The input string for this helper should be:
+	 *   foo,$(x),$(y)
+	 *
+	 * and split into:
+	 *   new_argv[0] = 'foo'
+	 *   new_argv[1] = '$(x)'
+	 *   new_argv[2] = '$(y)'
+	 */
+	while (*p) {
+		if (nest == 0 && *p == ',') {
+			*p = 0;
+			if (new_argc >= FUNCTION_MAX_ARGS)
+				pperror("too many function arguments");
+			new_argv[new_argc++] = prev;
+			prev = p + 1;
+		} else if (*p == '(') {
+			nest++;
+		} else if (*p == ')') {
+			nest--;
+		}
 
-	res = env_expand(name);
+		p++;
+	}
+	new_argv[new_argc++] = prev;
+
+	/*
+	 * Shift arguments
+	 * new_argv[0] represents a function name or a variable name.  Put it
+	 * into 'name', then shift the rest of the arguments.  This simplifies
+	 * 'const' handling.
+	 */
+	name = expand_string_with_args(new_argv[0], argc, argv);
+	new_argc--;
+	for (i = 0; i < new_argc; i++)
+		new_argv[i] = expand_string_with_args(new_argv[i + 1],
+						      argc, argv);
+
+	/* Look for built-in functions */
+	res = function_expand(name, new_argc, new_argv);
 	if (res)
 		goto free;
 
+	/* Last, try environment variable */
+	if (new_argc == 0) {
+		res = env_expand(name);
+		if (res)
+			goto free;
+	}
+
 	res = xstrdup("");
 free:
+	for (i = 0; i < new_argc; i++)
+		free(new_argv[i]);
 	free(name);
 	free(tmp);
 
@@ -124,14 +231,14 @@ static char *eval_clause(const char *str, size_t len)
  * after the corresponding closing parenthesis, in this case, *str will be
  *     $(BAR)
  */
-char *expand_dollar(const char **str)
+static char *expand_dollar_with_args(const char **str, int argc, char *argv[])
 {
 	const char *p = *str;
 	const char *q;
 	int nest = 0;
 
 	/*
-	 * In Kconfig, variable references always start with "$(".
+	 * In Kconfig, variable/function references always start with "$(".
 	 * Neither single-letter variables as in $A nor curly braces as in ${CC}
 	 * are supported.  '$' not followed by '(' loses its special meaning.
 	 */
@@ -158,10 +265,16 @@ char *expand_dollar(const char **str)
 	/* Advance 'str' to after the expanded initial portion of the string */
 	*str = q + 1;
 
-	return eval_clause(p, q - p);
+	return eval_clause(p, q - p, argc, argv);
+}
+
+char *expand_dollar(const char **str)
+{
+	return expand_dollar_with_args(str, 0, NULL);
 }
 
-static char *__expand_string(const char **str, bool (*is_end)(char c))
+static char *__expand_string(const char **str, bool (*is_end)(char c),
+			     int argc, char *argv[])
 {
 	const char *in, *p;
 	char *expansion, *out;
@@ -177,7 +290,7 @@ static char *__expand_string(const char **str, bool (*is_end)(char c))
 		if (*p == '$') {
 			in_len = p - in;
 			p++;
-			expansion = expand_dollar(&p);
+			expansion = expand_dollar_with_args(&p, argc, argv);
 			out_len += in_len + strlen(expansion);
 			out = xrealloc(out, out_len);
 			strncat(out, in, in_len);
@@ -210,13 +323,18 @@ static bool is_end_of_str(char c)
 }
 
 /*
- * Expand variables in the given string.  Undefined variables
+ * Expand variables and functions in the given string.  Undefined variables
  * expand to an empty string.
  * The returned string must be freed when done.
  */
+static char *expand_string_with_args(const char *in, int argc, char *argv[])
+{
+	return __expand_string(&in, is_end_of_str, argc, argv);
+}
+
 char *expand_string(const char *in)
 {
-	return __expand_string(&in, is_end_of_str);
+	return expand_string_with_args(in, 0, NULL);
 }
 
 static bool is_end_of_token(char c)
@@ -234,5 +352,5 @@ static bool is_end_of_token(char c)
  */
 char *expand_one_token(const char **str)
 {
-	return __expand_string(str, is_end_of_token);
+	return __expand_string(str, is_end_of_token, 0, NULL);
 }
-- 
2.7.4
