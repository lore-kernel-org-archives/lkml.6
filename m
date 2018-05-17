Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752479AbeEQG1O (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 02:27:14 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:24208 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751155AbeEQGSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 02:18:51 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w4H6HbU5002841
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v4 07/31] kconfig: add built-in function support
Date: Thu, 17 May 2018 15:16:46 +0900
Message-Id: <1526537830-22606-8-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
References: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
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

 scripts/kconfig/preprocess.c | 168 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 159 insertions(+), 9 deletions(-)

diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
index 1bf506c..5be28ec 100644
--- a/scripts/kconfig/preprocess.c
+++ b/scripts/kconfig/preprocess.c
@@ -3,12 +3,17 @@
 // Copyright (C) 2018 Masahiro Yamada <yamada.masahiro@socionext.com>
 
 #include <stdarg.h>
+#include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 
 #include "list.h"
 
+#define ARRAY_SIZE(arr)		(sizeof(arr) / sizeof((arr)[0]))
+
+static char *expand_string_with_args(const char *in, int argc, char *argv[]);
+
 static void __attribute__((noreturn)) pperror(const char *format, ...)
 {
 	va_list ap;
@@ -88,9 +93,85 @@ void env_write_dep(FILE *f, const char *autoconfig_name)
 	}
 }
 
-static char *eval_clause(const char *in)
+/*
+ * Built-in functions
+ */
+struct function {
+	const char *name;
+	unsigned int min_args;
+	unsigned int max_args;
+	bool expand_args;
+	char *(*func)(int argc, char *argv[], int old_argc, char *old_argv[]);
+};
+
+static const struct function function_table[] = {
+	/* Name		MIN	MAX	EXP?	Function */
+};
+
+#define FUNCTION_MAX_ARGS		16
+
+static char *function_expand_arg_and_call(char *(*func)(int argc, char *argv[],
+							int old_argc,
+							char *old_argv[]),
+					  int argc, char *argv[],
+					  int old_argc, char *old_argv[])
+{
+	char *expanded_argv[FUNCTION_MAX_ARGS], *res;
+	int i;
+
+	for (i = 0; i < argc; i++)
+		expanded_argv[i] = expand_string_with_args(argv[i],
+							   old_argc, old_argv);
+
+	res = func(argc, expanded_argv, 0, NULL);
+
+	for (i = 0; i < argc; i++)
+		free(expanded_argv[i]);
+
+	return res;
+}
+
+static char *function_call(const char *name, int argc, char *argv[],
+			   int old_argc, char *old_argv[])
+{
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
+		if (f->expand_args)
+			return function_expand_arg_and_call(f->func, argc, argv,
+							    old_argc, old_argv);
+		return f->func(argc, argv, old_argc, old_argv);
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
+static char *eval_clause(const char *in, int argc, char *argv[])
 {
-	char *res, *name;
+	char *tmp, *prev, *p, *res, *name;
+	int new_argc = 0;
+	char *new_argv[FUNCTION_MAX_ARGS];
+	int nest = 0;
+	int i;
 
 	/*
 	 * Returns an empty string because '$()' should be evaluated
@@ -99,10 +180,69 @@ static char *eval_clause(const char *in)
 	if (!*in)
 		return xstrdup("");
 
-	name = expand_string(in);
+	tmp = xstrdup(in);
+
+	prev = p = tmp;
+
+	/*
+	 * Split into tokens
+	 * The function name and arguments are separated by a comma.
+	 * For example, if the function call is like this:
+	 *   $(foo,abc,$(x),$(y))
+	 *
+	 * The input string for this helper should be:
+	 *   foo,abc,$(x),$(y)
+	 *
+	 * and split into:
+	 *   new_argv[0] = 'foo'
+	 *   new_argv[1] = 'abc'
+	 *   new_argv[2] = '$(x)'
+	 *   new_argv[3] = '$(y)'
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
+
+		p++;
+	}
+	new_argv[new_argc++] = prev;
 
-	res = env_expand(name);
+	/*
+	 * Shift arguments
+	 * new_argv[0] represents a function name or a variable name.  Put it
+	 * into 'name', then shift the rest of the arguments.  This simplifies
+	 * 'const' handling.
+	 */
+	name = expand_string_with_args(new_argv[0], argc, argv);
+	new_argc--;
+	for (i = 0; i < new_argc; i++)
+		new_argv[i] = new_argv[i + 1];
+
+	/* Look for built-in functions */
+	res = function_call(name, new_argc, new_argv, argc, argv);
+	if (res)
+		goto out;
+
+	/* Last, try environment variable */
+	if (new_argc == 0) {
+		res = env_expand(name);
+		if (res)
+			goto out;
+	}
+
+	res = xstrdup("");
+out:
 	free(name);
+	free(tmp);
 
 	return res;
 }
@@ -119,7 +259,7 @@ static char *eval_clause(const char *in)
  * will be
  *     $(BAR)
  */
-char *expand_dollar(const char **str)
+static char *expand_dollar_with_args(const char **str, int argc, char *argv[])
 {
 	const char *p = *str;
 	const char *q;
@@ -158,18 +298,18 @@ char *expand_dollar(const char **str)
 	memcpy(tmp, p, q - p);
 	tmp[q - p] = 0;
 	*str = q + 1;
-	out = eval_clause(tmp);
+	out = eval_clause(tmp, argc, argv);
 	free(tmp);
 
 	return out;
 }
 
 /*
- * Expand variables in the given string.  Undefined variables
+ * Expand variables, functions, etc. in the given string.  Undefined variables
  * expand to an empty string.
  * The returned string must be freed when done.
  */
-char *expand_string(const char *in)
+static char *expand_string_with_args(const char *in, int argc, char *argv[])
 {
 	const char *prev_in, *p;
 	char *new, *out;
@@ -181,7 +321,7 @@ char *expand_string(const char *in)
 	while ((p = strchr(in, '$'))) {
 		prev_in = in;
 		in = p + 1;
-		new = expand_dollar(&in);
+		new = expand_dollar_with_args(&in, argc, argv);
 		outlen = strlen(out) + (p - prev_in) + strlen(new) + 1;
 		out = xrealloc(out, outlen);
 		strncat(out, prev_in, p - prev_in);
@@ -196,6 +336,16 @@ char *expand_string(const char *in)
 	return out;
 }
 
+char *expand_string(const char *in)
+{
+	return expand_string_with_args(in, 0, NULL);
+}
+
+char *expand_dollar(const char **str)
+{
+	return expand_dollar_with_args(str, 0, NULL);
+}
+
 /*
  * Expand variables in a token.  The parsing stops when a token separater
  * (in most cases, it is a whitespace) is encountered.  'str' is updated to
-- 
2.7.4
