Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751335AbeDMFIR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 01:08:17 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:54456 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbeDMFIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 01:08:15 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w3D56lg2029209
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/30] kconfig: add built-in function support
Date: Fri, 13 Apr 2018 14:06:17 +0900
Message-Id: <1523595999-27433-9-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a new concept 'function' to do more text processing
in Kconfig.

A function call looks like this:

  $(function arg1, arg2, arg3, ...)

This commit adds the basic infrastructure to expand functions.
Change the text expansion helpers to take arguments.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3:
  - Split base infrastructure and 'shell' function
    into separate patches.

Changes in v2:
  - Use 'shell' for getting stdout from the comment.
    It was 'shell-stdout' in the previous version.
  - Symplify the implementation since the expansion has been moved to
    lexer.

 scripts/kconfig/preprocess.c | 142 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 130 insertions(+), 12 deletions(-)

diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
index fa4abc8..e77cf7c 100644
--- a/scripts/kconfig/preprocess.c
+++ b/scripts/kconfig/preprocess.c
@@ -8,6 +8,10 @@
 
 #include "list.h"
 
+#define ARRAY_SIZE(arr)		(sizeof(arr) / sizeof((arr)[0]))
+
+static char *expand_string_with_args(const char *in, int argc, char *argv[]);
+
 /*
  * Environment variables
  */
@@ -74,9 +78,47 @@ void env_write_dep(FILE *f, const char *autoconfig_name)
 	}
 }
 
-static char *eval_clause(const char *in)
+/*
+ * Built-in Functions
+ */
+struct function {
+	char *name;
+	char *(*func)(int argc, char *argv[]);
+};
+
+static const struct function function_table[] = {
+};
+
+static char *function_call(const char *name, int argc, char *argv[])
 {
-	char *res, *name;
+	const struct function *f;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(function_table); i++) {
+		f = &function_table[i];
+		if (!strcmp(f->name, name))
+			return f->func(argc, argv);
+	}
+
+	return NULL;
+}
+
+#define FUNCTION_MAX_ARGS		16
+
+/*
+ * Evaluate a clause with arguments.  argc/argv are arguments from the upper
+ * function call.
+ *
+ * Returned string must be freed when done
+ */
+static char *eval_clause(const char *in, int argc, char *argv[])
+{
+	char *tmp, *prev, *p, *res, *name;
+	char delim = ' ';
+	int new_argc = 0;
+	char *new_argv[FUNCTION_MAX_ARGS];
+	int nest = 0;
+	int i;
 
 	/*
 	 * Returns an empty string because '$()' should be evaluated
@@ -85,10 +127,73 @@ static char *eval_clause(const char *in)
 	if (!*in)
 		return xstrdup("");
 
-	name = expand_string(in);
+	tmp = xstrdup(in);
+
+	prev = p = tmp;
 
-	res = env_expand(name);
+	/*
+	 * Split into tokens
+	 * The function name and the first argument are separated by a space.
+	 * Arguments are separated by a comma.
+	 * For example, if the function call is like this:
+	 *   $(foo abc,$(x),$(y))
+	 *
+	 * The input string for this helper should be:
+	 *   foo abc,$(x),$(y)
+	 *
+	 * and split into:
+	 *   new_argv[0]: foo
+	 *   new_argv[1]: abc
+	 *   new_argv[2]: $(x)
+	 *   new_argv[3]: $(y)
+	 */
+	while (*p) {
+		if (nest == 0 && *p == delim) {
+			*p = 0;
+			new_argv[new_argc++] = prev;
+			prev = p + 1;
+			delim = ',';
+		} else if (*p == '(') {
+			nest++;
+		} else if (*p == ')') {
+			nest--;
+		}
+
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
+	free(tmp);
+
+	/* Look for built-in functions */
+	res = function_call(name, new_argc, new_argv);
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
+	for (i = 0; i < new_argc; i++)
+		free(new_argv[i]);
 
 	return res;
 }
@@ -115,7 +220,7 @@ static char *eval_clause(const char *in)
  * This is because $ABC is equivalent to $(A)BC.  (Like Make, you can omit
  * parentheses if the variable name consists of a single character.
  */
-char *expand_dollar(const char **str)
+static char *expand_dollar_with_args(const char **str, int argc, char *argv[])
 {
 	const char *p = *str;
 	const char *q;
@@ -124,6 +229,9 @@ char *expand_dollar(const char **str)
 
 	/*
 	 * A standalone '$' at the end of a token is treated as-is.
+	 * For example, the '$' before the comma in $(foo $,A) and the '$'
+	 * before the closing parenthesis in $(shell echo $) lose the special
+	 * meaning.  This is the behavior of Make 4.2 or newer.
 	 */
 	if (!*p)
 		return xstrdup("$");
@@ -140,15 +248,15 @@ char *expand_dollar(const char **str)
 		tmp[0] = *p;
 		tmp[1] = 0;
 		*str = p + 1;
-		out = eval_clause(tmp);
+		out = eval_clause(tmp, argc, argv);
 		free(tmp);
 		return out;
 	}
 
 	/*
-	 * Variables that consist of multiple letters
+	 * Variables that consist of multiple letters, and function calls
 	 * must be surrounded with parentheses.
-	 * For example, $(FOO)
+	 * For example, $(FOO), $(shell echo helloworld)
 	 */
 	p++;
 	q = p;
@@ -163,7 +271,7 @@ char *expand_dollar(const char **str)
 				memcpy(tmp, p, q - p);
 				tmp[q - p] = 0;
 				*str = q + 1;
-				out = eval_clause(tmp);
+				out = eval_clause(tmp, argc, argv);
 				free(tmp);
 				return out;
 			}
@@ -179,11 +287,11 @@ char *expand_dollar(const char **str)
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
@@ -195,7 +303,7 @@ char *expand_string(const char *in)
 	while ((p = strchr(in, '$'))) {
 		prev_in = in;
 		in = p + 1;
-		new = expand_dollar(&in);
+		new = expand_dollar_with_args(&in, argc, argv);
 		outlen = strlen(out) + (p - prev_in) + strlen(new) + 1;
 		out = xrealloc(out, outlen);
 		strncat(out, prev_in, p - prev_in);
@@ -210,6 +318,16 @@ char *expand_string(const char *in)
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
