Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933854AbeE1J2L (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:28:11 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:21663 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754335AbeE1JYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:24:17 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w4S9MInK027506
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
Subject: [PATCH v5 03/31] kconfig: reference environment variables directly and remove 'option env='
Date: Mon, 28 May 2018 18:21:40 +0900
Message-Id: <1527499328-13213-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
References: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To get access to environment variables, Kconfig needs to define a
symbol using "option env=" syntax.  It is tedious to add a symbol entry
for each environment variable given that we need to define much more
such as 'CC', 'AS', 'srctree' etc. to evaluate the compiler capability
in Kconfig.

Adding '$' for symbol references is grammatically inconsistent.
Looking at the code, the symbols prefixed with 'S' are expanded by:
 - conf_expand_value()
   This is used to expand 'arch/$ARCH/defconfig' and 'defconfig_list'
 - sym_expand_string_value()
   This is used to expand strings in 'source' and 'mainmenu'

All of them are fixed values independent of user configuration.  So,
they can be changed into the direct expansion instead of symbols.

This change makes the code much cleaner.  The bounce symbols 'SRCARCH',
'ARCH', 'SUBARCH', 'KERNELVERSION' are gone.

sym_init() hard-coding 'UNAME_RELEASE' is also gone.  'UNAME_RELEASE'
should be replaced with an environment variable.

ARCH_DEFCONFIG is a normal symbol, so it should be simply referenced
without '$' prefix.

The new syntax is addicted by Make.  The variable reference needs
parentheses, like $(FOO), but you can omit them for single-letter
variables, like $F.  Yet, in Makefiles, people tend to use the
parenthetical form for consistency / clarification.

At this moment, only the environment variable is supported, but I will
extend the concept of 'variable' later on.

The variables are expanded in the lexer so we can simplify the token
handling on the parser side.

For example, the following code works.

[Example code]

  config MY_TOOLCHAIN_LIST
          string
          default "My tools: CC=$(CC), AS=$(AS), CPP=$(CPP)"

[Result]

  $ make -s alldefconfig && tail -n 1 .config
  CONFIG_MY_TOOLCHAIN_LIST="My tools: CC=gcc, AS=as, CPP=gcc -E"

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---

Changes in v5:
  - More comments like "advance pointer to ..."
  - Factor out the duplicated code into __expand_string()
  - Move the empty name check to env_expand().
  - Remove escape sequence of '$'

Changes in v4:
  - Enclose ARCH in conf_defname
  - Drop single-letter support

Changes in v3:
  - Reimplement
  - Variable reference need parentheses except single-letter variable

Changes in v2:
  - Move the string expansion to the lexer phase.
  - Split environment helpers to env.c

 Documentation/kbuild/kconfig-language.txt |   8 -
 Kconfig                                   |   8 +-
 Makefile                                  |   3 +-
 arch/sh/Kconfig                           |   4 +-
 arch/sparc/Kconfig                        |   4 +-
 arch/um/Kconfig.common                    |   4 -
 arch/x86/Kconfig                          |   4 +-
 arch/x86/um/Kconfig                       |   6 +-
 init/Kconfig                              |  16 +-
 scripts/kconfig/confdata.c                |  33 +----
 scripts/kconfig/kconf_id.c                |   1 -
 scripts/kconfig/lkc.h                     |   5 +-
 scripts/kconfig/lkc_proto.h               |   6 +
 scripts/kconfig/menu.c                    |   3 -
 scripts/kconfig/preprocess.c              | 238 ++++++++++++++++++++++++++++++
 scripts/kconfig/symbol.c                  |  56 -------
 scripts/kconfig/util.c                    |  29 ++--
 scripts/kconfig/zconf.l                   |  67 ++++++++-
 scripts/kconfig/zconf.y                   |   2 +-
 19 files changed, 343 insertions(+), 154 deletions(-)
 create mode 100644 scripts/kconfig/preprocess.c

diff --git a/Documentation/kbuild/kconfig-language.txt b/Documentation/kbuild/kconfig-language.txt
index f5b9493..0e966e8 100644
--- a/Documentation/kbuild/kconfig-language.txt
+++ b/Documentation/kbuild/kconfig-language.txt
@@ -198,14 +198,6 @@ applicable everywhere (see syntax).
     enables the third modular state for all config symbols.
     At most one symbol may have the "modules" option set.
 
-  - "env"=<value>
-    This imports the environment variable into Kconfig. It behaves like
-    a default, except that the value comes from the environment, this
-    also means that the behaviour when mixing it with normal defaults is
-    undefined at this point. The symbol is currently not exported back
-    to the build environment (if this is desired, it can be done via
-    another symbol).
-
   - "allnoconfig_y"
     This declares the symbol as one that should have the value y when
     using "allnoconfig". Used for symbols that hide other symbols.
diff --git a/Kconfig b/Kconfig
index 8c4c1cb..4af1b42 100644
--- a/Kconfig
+++ b/Kconfig
@@ -3,10 +3,6 @@
 # For a description of the syntax of this configuration file,
 # see Documentation/kbuild/kconfig-language.txt.
 #
-mainmenu "Linux/$ARCH $KERNELVERSION Kernel Configuration"
+mainmenu "Linux/$(ARCH) $(KERNELVERSION) Kernel Configuration"
 
-config SRCARCH
-	string
-	option env="SRCARCH"
-
-source "arch/$SRCARCH/Kconfig"
+source "arch/$(SRCARCH)/Kconfig"
diff --git a/Makefile b/Makefile
index 58afa07..59b8654 100644
--- a/Makefile
+++ b/Makefile
@@ -284,7 +284,8 @@ include scripts/Kbuild.include
 # Read KERNELRELEASE from include/config/kernel.release (if it exists)
 KERNELRELEASE = $(shell cat include/config/kernel.release 2> /dev/null)
 KERNELVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
-export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION
+UNAME_RELEASE := $(shell uname --release)
+export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION UNAME_RELEASE
 
 # SUBARCH tells the usermode build what the underlying arch is.  That is set
 # first, and if a usermode build is happening, the "ARCH=um" on the command
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 1851eae..c8400e3 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -58,7 +58,7 @@ config SUPERH
 	  <http://www.linux-sh.org/>.
 
 config SUPERH32
-	def_bool ARCH = "sh"
+	def_bool "$(ARCH)" = "sh"
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
 	select HAVE_IOREMAP_PROT if MMU && !X2TLB
@@ -77,7 +77,7 @@ config SUPERH32
 	select HAVE_CC_STACKPROTECTOR
 
 config SUPERH64
-	def_bool ARCH = "sh64"
+	def_bool "$(ARCH)" = "sh64"
 	select HAVE_EXIT_THREAD
 	select KALLSYMS
 
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 8767e45..df7410c 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -1,6 +1,6 @@
 config 64BIT
-	bool "64-bit kernel" if ARCH = "sparc"
-	default ARCH = "sparc64"
+	bool "64-bit kernel" if "$(ARCH)" = "sparc"
+	default "$(ARCH)" = "sparc64"
 	help
 	  SPARC is a family of RISC microprocessors designed and marketed by
 	  Sun Microsystems, incorporated.  They are very widely found in Sun
diff --git a/arch/um/Kconfig.common b/arch/um/Kconfig.common
index c68add8..07f84c8 100644
--- a/arch/um/Kconfig.common
+++ b/arch/um/Kconfig.common
@@ -54,10 +54,6 @@ config HZ
 	int
 	default 100
 
-config SUBARCH
-	string
-	option env="SUBARCH"
-
 config NR_CPUS
 	int
 	range 1 1
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c07f492..2236505 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 # Select 32 or 64 bit
 config 64BIT
-	bool "64-bit kernel" if ARCH = "x86"
-	default ARCH != "i386"
+	bool "64-bit kernel" if "$(ARCH)" = "x86"
+	default "$(ARCH)" != "i386"
 	---help---
 	  Say yes to build a 64-bit kernel - formerly known as x86_64
 	  Say no to build a 32-bit kernel - formerly known as i386
diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index 13ed827..6a15c4d 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-mainmenu "User Mode Linux/$SUBARCH $KERNELVERSION Kernel Configuration"
+mainmenu "User Mode Linux/$(SUBARCH) $(KERNELVERSION) Kernel Configuration"
 
 source "arch/um/Kconfig.common"
 
@@ -16,8 +16,8 @@ config UML_X86
 	select GENERIC_FIND_FIRST_BIT
 
 config 64BIT
-	bool "64-bit kernel" if SUBARCH = "x86"
-	default SUBARCH != "i386"
+	bool "64-bit kernel" if "$(SUBARCH)" = "x86"
+	default "$(SUBARCH)" != "i386"
 
 config X86_32
 	def_bool !64BIT
diff --git a/init/Kconfig b/init/Kconfig
index 15aae32..1217fc6 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1,20 +1,12 @@
-config ARCH
-	string
-	option env="ARCH"
-
-config KERNELVERSION
-	string
-	option env="KERNELVERSION"
-
 config DEFCONFIG_LIST
 	string
 	depends on !UML
 	option defconfig_list
-	default "/lib/modules/$UNAME_RELEASE/.config"
+	default "/lib/modules/$(UNAME_RELEASE)/.config"
 	default "/etc/kernel-config"
-	default "/boot/config-$UNAME_RELEASE"
-	default "$ARCH_DEFCONFIG"
-	default "arch/$ARCH/defconfig"
+	default "/boot/config-$(UNAME_RELEASE)"
+	default ARCH_DEFCONFIG
+	default "arch/$(ARCH)/defconfig"
 
 config CONSTRUCTORS
 	bool
diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index df26c7b..f72587c 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -30,7 +30,7 @@ static void conf_message(const char *fmt, ...)
 static const char *conf_filename;
 static int conf_lineno, conf_warnings;
 
-const char conf_defname[] = "arch/$ARCH/defconfig";
+const char conf_defname[] = "arch/$(ARCH)/defconfig";
 
 static void conf_warning(const char *fmt, ...)
 {
@@ -81,39 +81,13 @@ const char *conf_get_autoconfig_name(void)
 	return name ? name : "include/config/auto.conf";
 }
 
-static char *conf_expand_value(const char *in)
-{
-	struct symbol *sym;
-	const char *src;
-	static char res_value[SYMBOL_MAXLENGTH];
-	char *dst, name[SYMBOL_MAXLENGTH];
-
-	res_value[0] = 0;
-	dst = name;
-	while ((src = strchr(in, '$'))) {
-		strncat(res_value, in, src - in);
-		src++;
-		dst = name;
-		while (isalnum(*src) || *src == '_')
-			*dst++ = *src++;
-		*dst = 0;
-		sym = sym_lookup(name, 0);
-		sym_calc_value(sym);
-		strcat(res_value, sym_get_string_value(sym));
-		in = src;
-	}
-	strcat(res_value, in);
-
-	return res_value;
-}
-
 char *conf_get_default_confname(void)
 {
 	struct stat buf;
 	static char fullname[PATH_MAX+1];
 	char *env, *name;
 
-	name = conf_expand_value(conf_defname);
+	name = expand_string(conf_defname);
 	env = getenv(SRCTREE);
 	if (env) {
 		sprintf(fullname, "%s/%s", env, name);
@@ -274,7 +248,8 @@ int conf_read_simple(const char *name, int def)
 			if (expr_calc_value(prop->visible.expr) == no ||
 			    prop->expr->type != E_SYMBOL)
 				continue;
-			name = conf_expand_value(prop->expr->left.sym->name);
+			sym_calc_value(prop->expr->left.sym);
+			name = sym_get_string_value(prop->expr->left.sym);
 			in = zconf_fopen(name);
 			if (in) {
 				conf_message(_("using defaults found in %s"),
diff --git a/scripts/kconfig/kconf_id.c b/scripts/kconfig/kconf_id.c
index 3ea9c5f..b3e0ea0 100644
--- a/scripts/kconfig/kconf_id.c
+++ b/scripts/kconfig/kconf_id.c
@@ -32,7 +32,6 @@ static struct kconf_id kconf_id_array[] = {
 	{ "on",			T_ON,			TF_PARAM },
 	{ "modules",		T_OPT_MODULES,		TF_OPTION },
 	{ "defconfig_list",	T_OPT_DEFCONFIG_LIST,	TF_OPTION },
-	{ "env",		T_OPT_ENV,		TF_OPTION },
 	{ "allnoconfig_y",	T_OPT_ALLNOCONFIG_Y,	TF_OPTION },
 };
 
diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
index f4394af..658efb0 100644
--- a/scripts/kconfig/lkc.h
+++ b/scripts/kconfig/lkc.h
@@ -58,7 +58,6 @@ enum conf_def_mode {
 
 #define T_OPT_MODULES		1
 #define T_OPT_DEFCONFIG_LIST	2
-#define T_OPT_ENV		3
 #define T_OPT_ALLNOCONFIG_Y	4
 
 struct kconf_id {
@@ -117,6 +116,7 @@ void *xmalloc(size_t size);
 void *xcalloc(size_t nmemb, size_t size);
 void *xrealloc(void *p, size_t size);
 char *xstrdup(const char *s);
+char *xstrndup(const char *s, size_t n);
 
 struct gstr {
 	size_t len;
@@ -134,9 +134,6 @@ void str_printf(struct gstr *gs, const char *fmt, ...);
 const char *str_get(struct gstr *gs);
 
 /* symbol.c */
-extern struct expr *sym_env_list;
-
-void sym_init(void);
 void sym_clear_all_valid(void);
 struct symbol *sym_choice_default(struct symbol *sym);
 const char *sym_get_string_default(struct symbol *sym);
diff --git a/scripts/kconfig/lkc_proto.h b/scripts/kconfig/lkc_proto.h
index 9dc8abf..9f465fe 100644
--- a/scripts/kconfig/lkc_proto.h
+++ b/scripts/kconfig/lkc_proto.h
@@ -49,5 +49,11 @@ const char * sym_get_string_value(struct symbol *sym);
 
 const char * prop_get_type_name(enum prop_type type);
 
+/* preprocess.c */
+void env_write_dep(FILE *f, const char *auto_conf_name);
+char *expand_string(const char *in);
+char *expand_dollar(const char **str);
+char *expand_one_token(const char **str);
+
 /* expr.c */
 void expr_print(struct expr *e, void (*fn)(void *, struct symbol *, const char *), void *data, int prevtoken);
diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index 5c5c137..8148305 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -214,9 +214,6 @@ void menu_add_option(int token, char *arg)
 			zconf_error("trying to redefine defconfig symbol");
 		sym_defconfig_list->flags |= SYMBOL_AUTO;
 		break;
-	case T_OPT_ENV:
-		prop_add_env(arg);
-		break;
 	case T_OPT_ALLNOCONFIG_Y:
 		current_entry->sym->flags |= SYMBOL_ALLNOCONFIG_Y;
 		break;
diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
new file mode 100644
index 0000000..a2eb2eb
--- /dev/null
+++ b/scripts/kconfig/preprocess.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2018 Masahiro Yamada <yamada.masahiro@socionext.com>
+
+#include <stdarg.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "list.h"
+
+static void __attribute__((noreturn)) pperror(const char *format, ...)
+{
+	va_list ap;
+
+	fprintf(stderr, "%s:%d: ", current_file->name, yylineno);
+	va_start(ap, format);
+	vfprintf(stderr, format, ap);
+	va_end(ap);
+	fprintf(stderr, "\n");
+
+	exit(1);
+}
+
+/*
+ * Environment variables
+ */
+static LIST_HEAD(env_list);
+
+struct env {
+	char *name;
+	char *value;
+	struct list_head node;
+};
+
+static void env_add(const char *name, const char *value)
+{
+	struct env *e;
+
+	e = xmalloc(sizeof(*e));
+	e->name = xstrdup(name);
+	e->value = xstrdup(value);
+
+	list_add_tail(&e->node, &env_list);
+}
+
+static void env_del(struct env *e)
+{
+	list_del(&e->node);
+	free(e->name);
+	free(e->value);
+	free(e);
+}
+
+/* The returned pointer must be freed when done */
+static char *env_expand(const char *name)
+{
+	struct env *e;
+	const char *value;
+
+	if (!*name)
+		return NULL;
+
+	list_for_each_entry(e, &env_list, node) {
+		if (!strcmp(name, e->name))
+			return xstrdup(e->value);
+	}
+
+	value = getenv(name);
+	if (!value)
+		return NULL;
+
+	/*
+	 * We need to remember all referenced environment variables.
+	 * They will be written out to include/config/auto.conf.cmd
+	 */
+	env_add(name, value);
+
+	return xstrdup(value);
+}
+
+void env_write_dep(FILE *f, const char *autoconfig_name)
+{
+	struct env *e, *tmp;
+
+	list_for_each_entry_safe(e, tmp, &env_list, node) {
+		fprintf(f, "ifneq \"$(%s)\" \"%s\"\n", e->name, e->value);
+		fprintf(f, "%s: FORCE\n", autoconfig_name);
+		fprintf(f, "endif\n");
+		env_del(e);
+	}
+}
+
+static char *eval_clause(const char *str, size_t len)
+{
+	char *tmp, *name, *res;
+
+	tmp = xstrndup(str, len);
+
+	name = expand_string(tmp);
+
+	res = env_expand(name);
+	if (res)
+		goto free;
+
+	res = xstrdup("");
+free:
+	free(name);
+	free(tmp);
+
+	return res;
+}
+
+/*
+ * Expand a string that follows '$'
+ *
+ * For example, if the input string is
+ *     ($(FOO)$($(BAR)))$(BAZ)
+ * this helper evaluates
+ *     $($(FOO)$($(BAR)))
+ * and returns a new string containing the expansion (note that the string is
+ * recursively expanded), also advancing 'str' to point to the next character
+ * after the corresponding closing parenthesis, in this case, *str will be
+ *     $(BAR)
+ */
+char *expand_dollar(const char **str)
+{
+	const char *p = *str;
+	const char *q;
+	int nest = 0;
+
+	/*
+	 * In Kconfig, variable references always start with "$(".
+	 * Neither single-letter variables as in $A nor curly braces as in ${CC}
+	 * are supported.  '$' not followed by '(' loses its special meaning.
+	 */
+	if (*p != '(') {
+		*str = p;
+		return xstrdup("$");
+	}
+
+	p++;
+	q = p;
+	while (*q) {
+		if (*q == '(') {
+			nest++;
+		} else if (*q == ')') {
+			if (nest-- == 0)
+				break;
+		}
+		q++;
+	}
+
+	if (!*q)
+		pperror("unterminated reference to '%s': missing ')'", p);
+
+	/* Advance 'str' to after the expanded initial portion of the string */
+	*str = q + 1;
+
+	return eval_clause(p, q - p);
+}
+
+static char *__expand_string(const char **str, bool (*is_end)(char c))
+{
+	const char *in, *p;
+	char *expansion, *out;
+	size_t in_len, out_len;
+
+	out = xmalloc(1);
+	*out = 0;
+	out_len = 1;
+
+	p = in = *str;
+
+	while (1) {
+		if (*p == '$') {
+			in_len = p - in;
+			p++;
+			expansion = expand_dollar(&p);
+			out_len += in_len + strlen(expansion);
+			out = xrealloc(out, out_len);
+			strncat(out, in, in_len);
+			strcat(out, expansion);
+			free(expansion);
+			in = p;
+			continue;
+		}
+
+		if (is_end(*p))
+			break;
+
+		p++;
+	}
+
+	in_len = p - in;
+	out_len += in_len;
+	out = xrealloc(out, out_len);
+	strncat(out, in, in_len);
+
+	/* Advance 'str' to the end character */
+	*str = p;
+
+	return out;
+}
+
+static bool is_end_of_str(char c)
+{
+	return !c;
+}
+
+/*
+ * Expand variables in the given string.  Undefined variables
+ * expand to an empty string.
+ * The returned string must be freed when done.
+ */
+char *expand_string(const char *in)
+{
+	return __expand_string(&in, is_end_of_str);
+}
+
+static bool is_end_of_token(char c)
+{
+	/* Why are '.' and '/' valid characters for symbols? */
+	return !(isalnum(c) || c == '_' || c == '-' || c == '.' || c == '/');
+}
+
+/*
+ * Expand variables in a token.  The parsing stops when a token separater
+ * (in most cases, it is a whitespace) is encountered.  'str' is updated to
+ * point to the next character.
+ *
+ * The returned string must be freed when done.
+ */
+char *expand_one_token(const char **str)
+{
+	return __expand_string(str, is_end_of_token);
+}
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index f0b2e3b..2460648 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -33,33 +33,6 @@ struct symbol *sym_defconfig_list;
 struct symbol *modules_sym;
 tristate modules_val;
 
-struct expr *sym_env_list;
-
-static void sym_add_default(struct symbol *sym, const char *def)
-{
-	struct property *prop = prop_alloc(P_DEFAULT, sym);
-
-	prop->expr = expr_alloc_symbol(sym_lookup(def, SYMBOL_CONST));
-}
-
-void sym_init(void)
-{
-	struct symbol *sym;
-	struct utsname uts;
-	static bool inited = false;
-
-	if (inited)
-		return;
-	inited = true;
-
-	uname(&uts);
-
-	sym = sym_lookup("UNAME_RELEASE", 0);
-	sym->type = S_STRING;
-	sym->flags |= SYMBOL_AUTO;
-	sym_add_default(sym, uts.release);
-}
-
 enum symbol_type sym_get_type(struct symbol *sym)
 {
 	enum symbol_type type = sym->type;
@@ -1401,32 +1374,3 @@ const char *prop_get_type_name(enum prop_type type)
 	}
 	return "unknown";
 }
-
-static void prop_add_env(const char *env)
-{
-	struct symbol *sym, *sym2;
-	struct property *prop;
-	char *p;
-
-	sym = current_entry->sym;
-	sym->flags |= SYMBOL_AUTO;
-	for_all_properties(sym, prop, P_ENV) {
-		sym2 = prop_get_symbol(prop);
-		if (strcmp(sym2->name, env))
-			menu_warn(current_entry, "redefining environment symbol from %s",
-				  sym2->name);
-		return;
-	}
-
-	prop = prop_alloc(P_ENV, sym);
-	prop->expr = expr_alloc_symbol(sym_lookup(env, SYMBOL_CONST));
-
-	sym_env_list = expr_alloc_one(E_LIST, sym_env_list);
-	sym_env_list->right.sym = sym;
-
-	p = getenv(env);
-	if (p)
-		sym_add_default(sym, p);
-	else
-		menu_warn(current_entry, "environment variable %s undefined", env);
-}
diff --git a/scripts/kconfig/util.c b/scripts/kconfig/util.c
index c6f6e21..703ee49 100644
--- a/scripts/kconfig/util.c
+++ b/scripts/kconfig/util.c
@@ -34,8 +34,6 @@ struct file *file_lookup(const char *name)
 /* write a dependency file as used by kbuild to track dependencies */
 int file_write_dep(const char *name)
 {
-	struct symbol *sym, *env_sym;
-	struct expr *e;
 	struct file *file;
 	FILE *out;
 
@@ -54,21 +52,7 @@ int file_write_dep(const char *name)
 	fprintf(out, "\n%s: \\\n"
 		     "\t$(deps_config)\n\n", conf_get_autoconfig_name());
 
-	expr_list_for_each_sym(sym_env_list, e, sym) {
-		struct property *prop;
-		const char *value;
-
-		prop = sym_get_env_prop(sym);
-		env_sym = prop_get_symbol(prop);
-		if (!env_sym)
-			continue;
-		value = getenv(env_sym->name);
-		if (!value)
-			value = "";
-		fprintf(out, "ifneq \"$(%s)\" \"%s\"\n", env_sym->name, value);
-		fprintf(out, "%s: FORCE\n", conf_get_autoconfig_name());
-		fprintf(out, "endif\n");
-	}
+	env_write_dep(out, conf_get_autoconfig_name());
 
 	fprintf(out, "\n$(deps_config): ;\n");
 	fclose(out);
@@ -165,3 +149,14 @@ char *xstrdup(const char *s)
 	fprintf(stderr, "Out of memory.\n");
 	exit(1);
 }
+
+char *xstrndup(const char *s, size_t n)
+{
+	char *p;
+
+	p = strndup(s, n);
+	if (p)
+		return p;
+	fprintf(stderr, "Out of memory.\n");
+	exit(1);
+}
diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
index 045093d..b385590 100644
--- a/scripts/kconfig/zconf.l
+++ b/scripts/kconfig/zconf.l
@@ -1,6 +1,5 @@
 %option nostdinit noyywrap never-interactive full ecs
 %option 8bit nodefault yylineno
-%option noinput
 %x COMMAND HELP STRING PARAM
 %{
 /*
@@ -35,6 +34,8 @@ struct buffer *current_buf;
 
 static int last_ts, first_ts;
 
+static char *expand_token(const char *in, size_t n);
+static void append_expanded_string(const char *in);
 static void zconf_endhelp(void);
 static void zconf_endfile(void);
 
@@ -147,6 +148,13 @@ n	[A-Za-z0-9_-]
 		yylval.string = text;
 		return T_WORD;
 	}
+	({n}|[/.$])+	{
+		/* this token includes at least one '$' */
+		yylval.string = expand_token(yytext, yyleng);
+		if (strlen(yylval.string))
+			return T_WORD;
+		free(yylval.string);
+	}
 	#.*	/* comment */
 	\\\n	;
 	[[:blank:]]+
@@ -157,12 +165,13 @@ n	[A-Za-z0-9_-]
 }
 
 <STRING>{
-	[^'"\\\n]+/\n	{
+	"$".*	append_expanded_string(yytext);
+	[^$'"\\\n]+/\n	{
 		append_string(yytext, yyleng);
 		yylval.string = text;
 		return T_WORD_QUOTE;
 	}
-	[^'"\\\n]+	{
+	[^$'"\\\n]+	{
 		append_string(yytext, yyleng);
 	}
 	\\.?/\n	{
@@ -249,6 +258,58 @@ n	[A-Za-z0-9_-]
 }
 
 %%
+static char *expand_token(const char *in, size_t n)
+{
+	char *out;
+	int c;
+	char c2;
+	const char *rest, *end;
+
+	new_string();
+	append_string(in, n);
+
+	/* get the whole line because we do not know the end of token. */
+	while ((c = input()) != EOF) {
+		if (c == '\n') {
+			unput(c);
+			break;
+		}
+		c2 = c;
+		append_string(&c2, 1);
+	}
+
+	rest = text;
+	out = expand_one_token(&rest);
+
+	/* push back unused characters to the input stream */
+	end = rest + strlen(rest);
+	while (end > rest)
+		unput(*--end);
+
+	free(text);
+
+	return out;
+}
+
+static void append_expanded_string(const char *str)
+{
+	const char *end;
+	char *res;
+
+	str++;
+
+	res = expand_dollar(&str);
+
+	/* push back unused characters to the input stream */
+	end = str + strlen(str);
+	while (end > str)
+		unput(*--end);
+
+	append_string(res, strlen(res));
+
+	free(res);
+}
+
 void zconf_starthelp(void)
 {
 	new_string();
diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
index ad6305b..3a4a0fa 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -534,7 +534,6 @@ void conf_parse(const char *name)
 
 	zconf_initscan(name);
 
-	sym_init();
 	_menu_init();
 
 	if (getenv("ZCONF_DEBUG"))
@@ -780,3 +779,4 @@ void zconfdump(FILE *out)
 #include "expr.c"
 #include "symbol.c"
 #include "menu.c"
+#include "preprocess.c"
-- 
2.7.4
