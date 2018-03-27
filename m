Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AG47ELsQYAH3R1L2g/YjFRQO3TMPWvwko8Im70Wnqxz5GNdT8pSqgUKtPjoftgChWjM+2QRAU995
ARC-Seal: i=1; a=rsa-sha256; t=1522128618; cv=none;
        d=google.com; s=arc-20160816;
        b=QujWu6QdMaLx98saMeDbLuV2SyP/49vXGvC+1PAWnyFIVwXicunBrxmyQIQx6nziDD
         FHCWkhspgOYt4RqiNzBOkKPxldx1MCV/vYNiFKVQMyqqvlTB+I4EachNAhKra7fwovPY
         BZSdj85QY3fIv7Y9dEqTWGQ7bOL3VTnApOIJqQVmLFfP1WM4Wnn6pz1fRQROoQbYn8Xg
         dFfp5j15+YpHmyeN4WXdg9kvPy0Za3r0dles3zOeVqpoZmEZxdHoeEK2Ft/gCWxC0npT
         WJmoGa7WokKdsOqZxoqFK3OIVe+wvqgfv7rf7XYPLISYpB60LnKAcU0Ct171+It4z48h
         kryw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=TLBa4Mx3C2xuQQjXVxZRbKbObZE5qbUZMeGEuNW3JYM=;
        b=St3sOWjjSJPs15qZclX/qTgRANIM5GItRHjtTgtOnplSf2MUNTTEuEWkNHfUj465ut
         nefwPDqrMpTYap4pUnzuYbb4HSsTyQGTrhivFMvgzS7PF43q28QExYZWHXZwccyRcd+Y
         sAvGtmP8qjhYIQjQFUA/pBghI7FIekoY+ke4mezhYHTRVTby8ud2BsGVNsL3pz2g6xLn
         w1asMNbmkGoYK2Fv4h5/yBUk/4pACkQOaT7Tncyta+NXzX/wL1mSA+oPuBm9tOEtM14l
         U3LNTvk5A1KxdFn3JbQXoaljre9HdBY6B7nkZnM+jBLf/Z97YvVb5JsnaE8KQFJATEWB
         HK/A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=Vae+iBeH;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=Vae+iBeH;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w2R5TaLq011947
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Ulf Magnusson <ulfalizer@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Nicolas Pitre <nico@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/21] kconfig: add function support and implement 'shell' function
Date: Tue, 27 Mar 2018 14:29:21 +0900
Message-Id: <1522128575-5326-8-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067538101341662?=
X-GMAIL-MSGID: =?utf-8?q?1596067538101341662?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This commit adds a new concept 'function' to do more text processing
in Kconfig.

A function call looks like this:

  $(function arg1, arg2, arg3, ...)

(Actually, this syntax was inspired by make.)

Real examples will look like this:

  $(shell echo hello world)
  $(cc-option -fstackprotector)

This commit adds the basic infrastructure to add, delete, evaluate
functions, and also the first built-in function $(shell ...).  This
accepts a single command to execute.  It returns the standard output
from it.

[Example code]

  config HELLO
          string
          default "$(shell echo hello world)"

  config Y
          def_bool $(shell echo y)

[Result]

  $ make -s alldefconfig && tail -n 2 .config
  CONFIG_HELLO="hello world"
  CONFIG_Y=y

Caveat:
Like environments, functions are expanded in the lexer.  You cannot
pass symbols to function arguments.  This is a limitation to simplify
the implementation.  I want to avoid the dynamic function evaluation,
which would introduce much more complexity.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Reminder for myself:
Update Documentation/kbuild/kconfig-language.txt


Changes in v2:
  - Use 'shell' for getting stdout from the comment.
    It was 'shell-stdout' in the previous version.
  - Symplify the implementation since the expansion has been moved to
    lexer.

 scripts/kconfig/function.c  | 170 ++++++++++++++++++++++++++++++++++++++++++++
 scripts/kconfig/lkc_proto.h |   5 ++
 scripts/kconfig/util.c      |  46 +++++++++---
 scripts/kconfig/zconf.y     |   9 +++
 4 files changed, 222 insertions(+), 8 deletions(-)
 create mode 100644 scripts/kconfig/function.c

diff --git a/scripts/kconfig/function.c b/scripts/kconfig/function.c
new file mode 100644
index 0000000..913685f
--- /dev/null
+++ b/scripts/kconfig/function.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2018 Masahiro Yamada <yamada.masahiro@socionext.com>
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "list.h"
+
+#define FUNCTION_MAX_ARGS		10
+
+static LIST_HEAD(function_list);
+
+struct function {
+	char *name;
+	char *(*func)(struct function *f, int argc, char *argv[]);
+	struct list_head node;
+};
+
+static struct function *func_lookup(const char *name)
+{
+	struct function *f;
+
+	list_for_each_entry(f, &function_list, node) {
+		if (!strcmp(name, f->name))
+			return f;
+	}
+
+	return NULL;
+}
+
+static void func_add(const char *name,
+		     char *(*func)(struct function *f, int argc, char *argv[]))
+{
+	struct function *f;
+
+	f = func_lookup(name);
+	if (f) {
+		fprintf(stderr, "%s: function already exists. ignored.\n", name);
+		return;
+	}
+
+	f = xmalloc(sizeof(*f));
+	f->name = xstrdup(name);
+	f->func = func;
+
+	list_add_tail(&f->node, &function_list);
+}
+
+static void func_del(struct function *f)
+{
+	list_del(&f->node);
+	free(f->name);
+	free(f);
+}
+
+static char *func_call(int argc, char *argv[])
+{
+	struct function *f;
+
+	f = func_lookup(argv[0]);
+	if (!f) {
+		fprintf(stderr, "%s: function not found\n", argv[0]);
+		return NULL;
+	}
+
+	return f->func(f, argc, argv);
+}
+
+static char *func_eval(const char *func)
+{
+	char *expanded, *saveptr, *str, *token, *res;
+	const char *delim;
+	int argc = 0;
+	char *argv[FUNCTION_MAX_ARGS];
+
+	expanded = expand_string_value(func);
+
+	str = expanded;
+	delim = " ";
+
+	while ((token = strtok_r(str, delim, &saveptr))) {
+		argv[argc++] = token;
+		str = NULL;
+		delim = ",";
+	}
+
+	res = func_call(argc, argv);
+
+	free(expanded);
+
+	return res ?: xstrdup("");
+}
+
+char *func_eval_n(const char *func, size_t n)
+{
+	char *tmp, *res;
+
+	tmp = xmalloc(n + 1);
+	memcpy(tmp, func, n);
+	*(tmp + n) = '\0';
+
+	res = func_eval(tmp);
+
+	free(tmp);
+
+	return res;
+}
+
+/* built-in functions */
+static char *do_shell(struct function *f, int argc, char *argv[])
+{
+	static const char *pre = "(";
+	static const char *post = ") 2>/dev/null";
+	FILE *p;
+	char buf[256];
+	char *cmd;
+	int ret;
+
+	if (argc != 2)
+		return NULL;
+
+	/*
+	 * Surround the command with ( ) in case it is piped commands.
+	 * Also, redirect stderr to /dev/null.
+	 */
+	cmd = xmalloc(strlen(pre) + strlen(argv[1]) + strlen(post) + 1);
+	strcpy(cmd, pre);
+	strcat(cmd, argv[1]);
+	strcat(cmd, post);
+
+	p = popen(cmd, "r");
+	if (!p) {
+		perror(cmd);
+		goto free;
+	}
+	if (fgets(buf, sizeof(buf), p)) {
+		size_t len = strlen(buf);
+
+		if (buf[len - 1] == '\n')
+			buf[len - 1] = '\0';
+	} else {
+		buf[0] = '\0';
+	}
+
+	ret = pclose(p);
+	if (ret == -1)
+		perror(cmd);
+
+free:
+	free(cmd);
+
+	return xstrdup(buf);
+}
+
+void func_init(void)
+{
+	/* register built-in functions */
+	func_add("shell", do_shell);
+}
+
+void func_exit(void)
+{
+	struct function *f, *tmp;
+
+	/* unregister all functions */
+	list_for_each_entry_safe(f, tmp, &function_list, node)
+		func_del(f);
+}
diff --git a/scripts/kconfig/lkc_proto.h b/scripts/kconfig/lkc_proto.h
index 9884adc..09a4f53 100644
--- a/scripts/kconfig/lkc_proto.h
+++ b/scripts/kconfig/lkc_proto.h
@@ -48,5 +48,10 @@ const char * sym_get_string_value(struct symbol *sym);
 
 const char * prop_get_type_name(enum prop_type type);
 
+/* function.c */
+char *func_eval_n(const char *func, size_t n);
+void func_init(void);
+void func_exit(void);
+
 /* expr.c */
 void expr_print(struct expr *e, void (*fn)(void *, struct symbol *, const char *), void *data, int prevtoken);
diff --git a/scripts/kconfig/util.c b/scripts/kconfig/util.c
index 3d27c49..218b051 100644
--- a/scripts/kconfig/util.c
+++ b/scripts/kconfig/util.c
@@ -13,9 +13,10 @@
 #include "lkc.h"
 
 /*
- * Expand environments embedded in the string given in argument. Environments
- * to be expanded shall be prefixed by a '$'. Unknown environment expands to
- * the empty string.
+ * Expand environments and functions embedded in the string given in argument.
+ * Environments to be expanded shall be prefixed by a '$'. Functions to be
+ * evaluated shall be surrounded by $(). Unknown environment/function expands
+ * to the empty string.
  */
 char *expand_string_value(const char *in)
 {
@@ -33,11 +34,40 @@ char *expand_string_value(const char *in)
 	while ((p = strchr(in, '$'))) {
 		char *new;
 
-		q = p + 1;
-		while (isalnum(*q) || *q == '_')
-			q++;
-
-		new = env_expand_n(p + 1, q - p - 1);
+		/*
+		 * If the next character is '(', it is a function.
+		 * Otherwise, environment.
+		 */
+		if (*(p + 1) == '(') {
+			int nest = 0;
+
+			q = p + 2;
+			while (1) {
+				if (*q == '\0') {
+					fprintf(stderr,
+						"unterminated function: %s\n",
+						p);
+					new = xstrdup("");
+					break;
+				} else if (*q == '(') {
+					nest++;
+				} else if (*q == ')') {
+					if (nest-- == 0) {
+						new = func_eval_n(p + 2,
+								  q - p - 2);
+						q++;
+						break;
+					}
+				}
+				q++;
+			}
+		} else {
+			q = p + 1;
+			while (isalnum(*q) || *q == '_')
+				q++;
+
+			new = env_expand_n(p + 1, q - p - 1);
+		}
 
 		reslen = strlen(res) + (p - in) + strlen(new) + 1;
 		res = xrealloc(res, reslen);
diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
index d8120c7..feaea18 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -520,11 +520,19 @@ void conf_parse(const char *name)
 
 	zconf_initscan(name);
 
+	func_init();
 	_menu_init();
 
 	if (getenv("ZCONF_DEBUG"))
 		yydebug = 1;
 	yyparse();
+
+	/*
+	 * Currently, functions are evaluated only when Kconfig files are
+	 * parsed. We can free functions here.
+	 */
+	func_exit();
+
 	if (yynerrs)
 		exit(1);
 	if (!modules_sym)
@@ -765,4 +773,5 @@ void zconfdump(FILE *out)
 #include "confdata.c"
 #include "expr.c"
 #include "symbol.c"
+#include "function.c"
 #include "menu.c"
-- 
2.7.4
