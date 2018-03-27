Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AIpwx49mF4vMoHJ3EV9SrWfdQVrqMF3/7rju6fmLBu6Vgz8p3LV053u3FsQPC4osskDBzerewPu1
ARC-Seal: i=1; a=rsa-sha256; t=1522128618; cv=none;
        d=google.com; s=arc-20160816;
        b=qGDiTz0wjCbBrmkknjQ4AycnteRInbdvi+PEanIt+01So2e2NIJoIfmzdYCYWG2Snc
         amxJl/X8kNuUlNNsofC6UY6l01V0Z5LxcbUH0Az1CINn0Uq7noMwnOPp915mG3tfKblW
         98MpoN73JydD0LYbSIxv29hANL+IRUBt4oui+ug8djSoefjGAOWtKVwyB8xw6IvOmDl5
         O3G6lpmw/8Oi3fURJZdkZBelvS3IZQBDLonMqf27IWLjrU4+FZlT5spCOltgqXuoRBeP
         rhQXUNrHOPVYeqMRAnV1nRX7bJtJWw+zqzDzY40MEPKasTLXNbhZ/oFJ7r2LTmn/M/el
         C+zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=KVtfV40QbB7b1ul5DKergAyEyb2/oQLVpLcCEAFf6Z8=;
        b=gV5CUJFqAHxOOaE6SCFBtf95M7jg2ODRn9IeIt3po4ofLxr+WNYEDfmqRDc1AXdEmV
         Ln2hLBwX27iKeOOgD4KEgP7zJVbmD84qb7d65j0ih91HQ7wEhJGuI45tCZFHd81diWQl
         AAZkgWRXy68wxiIUDo3Zy4t6d+9zNXmtdbcxSGuvvArShZDjR3Og8SZIfwXi9wv2iYCE
         qkLbPpcTlmRWdoqGB/akWR2NAsQ49ECFWvfdsqWTYQ3/tAGcQATQrbJEPVY74g0pJD+L
         NzuiDwH4aVx34RxZzXS2Od6MplwUdVuXdLeZCmiNaW6P3gV+xATSdh8Z3Gm+kMjMsM5/
         pa0A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=sNVGX+6C;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=sNVGX+6C;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w2R5TaLn011947
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
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v2 04/21] kconfig: reference environments directly and remove 'option env=' syntax
Date: Tue, 27 Mar 2018 14:29:18 +0900
Message-Id: <1522128575-5326-5-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067538224428128?=
X-GMAIL-MSGID: =?utf-8?q?1596067538224428128?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

To get an environment value, Kconfig needs to define a symbol using
"option env=" syntax.  It is tedious to add a config entry for each
environment given that we need more environments such as 'CC', 'AS',
'srctree' etc. to evaluate the compiler capability in Kconfig.

Adding '$' to symbols is weird.  Kconfig can reference symbols directly
like this:

  config FOO
          string
          default BAR

So, I want to use the following syntax to get environment 'BAR' from
the system:

  config FOO
          string
          default $BAR

Looking at the code, the symbols prefixed with 'S' are expanded by:
 - conf_expand_value()
   This is used to expand 'arch/$ARCH/defconfig' and 'defconfig_list'
 - expand_string_value()
   This is used to expand strings in 'source' and 'mainmenu'

All of them are fixed values independent of user configuration.  So,
this kind of syntax should be moved to simply take the environment.

This change makes the code much cleaner.  The bounce symbols 'SRCARCH',
'ARCH', 'SUBARCH', 'KERNELVERSION' are gone.

sym_init() hard-coding 'UNAME_RELEASE' is also gone.  'UNAME_RELEASE'
should be be given from the environment.

ARCH_DEFCONFIG is a normal symbol, so it should be simply referenced
by 'default ARCH_DEFCONFIG'.

The environments are expanding in the lexer; when '$' is encountered,
it is expanded, and resulted strings are pushed back to the input
stream.  This makes the implementation simpler.

For example, the following code works.

[Example code]

  config TOOLCHAIN_LIST
          string
          default "My tools: CC=$CC, AS=$AS, CPP=$CPP"

[Result]

  $ make -s alldefconfig && tail -n 1 .config
  CONFIG_TOOLCHAIN_LIST="My tools: CC=gcc, AS=as, CPP=gcc -E"

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

I tested all 'make *config' for arch architectures.
I confirmed this commit still produced the same result
(by my kconfig test tool).


Changes in v2:
  - Move the string expansion to the lexer phase.
  - Split environment helpers to env.c

 Documentation/kbuild/kconfig-language.txt |  8 ---
 Kconfig                                   |  4 --
 Makefile                                  |  3 +-
 arch/sh/Kconfig                           |  4 +-
 arch/sparc/Kconfig                        |  4 +-
 arch/tile/Kconfig                         |  2 +-
 arch/um/Kconfig.common                    |  4 --
 arch/x86/Kconfig                          |  4 +-
 arch/x86/um/Kconfig                       |  4 +-
 init/Kconfig                              | 10 +---
 scripts/kconfig/confdata.c                | 31 +---------
 scripts/kconfig/env.c                     | 95 +++++++++++++++++++++++++++++++
 scripts/kconfig/kconf_id.c                |  1 -
 scripts/kconfig/lkc.h                     |  8 +--
 scripts/kconfig/menu.c                    |  3 -
 scripts/kconfig/symbol.c                  | 56 ------------------
 scripts/kconfig/util.c                    | 75 ++++++++----------------
 scripts/kconfig/zconf.l                   | 20 ++++++-
 scripts/kconfig/zconf.y                   |  2 +-
 19 files changed, 158 insertions(+), 180 deletions(-)
 create mode 100644 scripts/kconfig/env.c

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
index 8c4c1cb..e6ece5b 100644
--- a/Kconfig
+++ b/Kconfig
@@ -5,8 +5,4 @@
 #
 mainmenu "Linux/$ARCH $KERNELVERSION Kernel Configuration"
 
-config SRCARCH
-	string
-	option env="SRCARCH"
-
 source "arch/$SRCARCH/Kconfig"
diff --git a/Makefile b/Makefile
index 5c395ed..4ae1486 100644
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
index 97fe293..14f3ef1 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -57,7 +57,7 @@ config SUPERH
 	  <http://www.linux-sh.org/>.
 
 config SUPERH32
-	def_bool ARCH = "sh"
+	def_bool "$ARCH" = "sh"
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
 	select HAVE_IOREMAP_PROT if MMU && !X2TLB
@@ -76,7 +76,7 @@ config SUPERH32
 	select HAVE_CC_STACKPROTECTOR
 
 config SUPERH64
-	def_bool ARCH = "sh64"
+	def_bool "$ARCH" = "sh64"
 	select HAVE_EXIT_THREAD
 	select KALLSYMS
 
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 8767e45..86b852e 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -1,6 +1,6 @@
 config 64BIT
-	bool "64-bit kernel" if ARCH = "sparc"
-	default ARCH = "sparc64"
+	bool "64-bit kernel" if "$ARCH" = "sparc"
+	default "$ARCH" = "sparc64"
 	help
 	  SPARC is a family of RISC microprocessors designed and marketed by
 	  Sun Microsystems, incorporated.  They are very widely found in Sun
diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
index ef9d403..acc2182 100644
--- a/arch/tile/Kconfig
+++ b/arch/tile/Kconfig
@@ -119,7 +119,7 @@ config HVC_TILE
 # Building with ARCH=tilegx (or ARCH=tile) implies using the
 # 64-bit TILE-Gx toolchain, so force CONFIG_TILEGX on.
 config TILEGX
-	def_bool ARCH != "tilepro"
+	def_bool "$ARCH" != "tilepro"
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select GENERIC_IRQ_LEGACY_ALLOC_HWIRQ
 	select HAVE_ARCH_JUMP_LABEL
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
index 0fa71a7..986fb0a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 # Select 32 or 64 bit
 config 64BIT
-	bool "64-bit kernel" if ARCH = "x86"
-	default ARCH != "i386"
+	bool "64-bit kernel" if "$ARCH" = "x86"
+	default "$ARCH" != "i386"
 	---help---
 	  Say yes to build a 64-bit kernel - formerly known as x86_64
 	  Say no to build a 32-bit kernel - formerly known as i386
diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index 13ed827..d355413 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -16,8 +16,8 @@ config UML_X86
 	select GENERIC_FIND_FIRST_BIT
 
 config 64BIT
-	bool "64-bit kernel" if SUBARCH = "x86"
-	default SUBARCH != "i386"
+	bool "64-bit kernel" if $SUBARCH = "x86"
+	default $SUBARCH != "i386"
 
 config X86_32
 	def_bool !64BIT
diff --git a/init/Kconfig b/init/Kconfig
index df18492..b4814e6 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1,11 +1,3 @@
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
@@ -13,7 +5,7 @@ config DEFCONFIG_LIST
 	default "/lib/modules/$UNAME_RELEASE/.config"
 	default "/etc/kernel-config"
 	default "/boot/config-$UNAME_RELEASE"
-	default "$ARCH_DEFCONFIG"
+	default ARCH_DEFCONFIG
 	default "arch/$ARCH/defconfig"
 
 config CONSTRUCTORS
diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index df26c7b..98c2014 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
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
+	name = expand_string_value(conf_defname);
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
diff --git a/scripts/kconfig/env.c b/scripts/kconfig/env.c
new file mode 100644
index 0000000..9702f5c
--- /dev/null
+++ b/scripts/kconfig/env.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2018 Masahiro Yamada <yamada.masahiro@socionext.com>
+
+static LIST_HEAD(env_list);
+
+struct env {
+	char *name;
+	char *value;
+	struct list_head node;
+};
+
+static struct env *env_list_lookup(const char *name)
+{
+	struct env *e;
+
+	list_for_each_entry(e, &env_list, node) {
+		if (!strcmp(name, e->name))
+			return e;
+	}
+
+	return NULL;
+}
+
+static void env_list_add(const char *name, const char *value)
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
+static void env_list_del(struct env *e)
+{
+	list_del(&e->node);
+	free(e->name);
+	free(e->value);
+	free(e);
+}
+
+/* the returned pointer must be freed when done */
+static char *env_expand(const char *name)
+{
+	struct env *e;
+	const char *value;
+
+	e = env_list_lookup(name);
+	if (e)
+		return xstrdup(e->value);
+
+	value = getenv(name);
+	if (!value) {
+		fprintf(stderr, "environment variable \"%s\" undefined\n", name);
+		value = "";
+	}
+
+	/*
+	 * we need to remember all referenced environments.
+	 * They will be written out to include/config/auto.conf.cmd
+	 */
+	env_list_add(name, value);
+
+	return xstrdup(value);
+}
+
+/* works like env_expand, but 'name' does not need to be null-terminated */
+char *env_expand_n(const char *name, size_t n)
+{
+	char *tmp, *res;
+
+	tmp = xmalloc(n + 1);
+	memcpy(tmp, name, n);
+	*(tmp + n) = '\0';
+
+	res = env_expand(tmp);
+
+	free(tmp);
+
+	return res;
+}
+
+void env_write_dep(FILE *f, const char *autoconfig_name)
+{
+	struct env *env, *tmp;
+
+	list_for_each_entry_safe(env, tmp, &env_list, node) {
+		fprintf(f, "ifneq \"$(%s)\" \"%s\"\n", env->name, env->value);
+		fprintf(f, "%s: FORCE\n", autoconfig_name);
+		fprintf(f, "endif\n");
+		env_list_del(env);
+	}
+}
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
index c8d9e55..03d007f 100644
--- a/scripts/kconfig/lkc.h
+++ b/scripts/kconfig/lkc.h
@@ -58,7 +58,6 @@ enum conf_def_mode {
 
 #define T_OPT_MODULES		1
 #define T_OPT_DEFCONFIG_LIST	2
-#define T_OPT_ENV		3
 #define T_OPT_ALLNOCONFIG_Y	4
 
 struct kconf_id {
@@ -95,6 +94,10 @@ static inline void xfwrite(const void *str, size_t len, size_t count, FILE *out)
 		fprintf(stderr, "Error in writing or end of file.\n");
 }
 
+/* env.c */
+char *env_expand_n(const char *name, size_t n);
+void env_write_dep(FILE *f, const char *auto_conf_name);
+
 /* menu.c */
 void _menu_init(void);
 void menu_warn(struct menu *menu, const char *fmt, ...);
@@ -135,9 +138,6 @@ void str_printf(struct gstr *gs, const char *fmt, ...);
 const char *str_get(struct gstr *gs);
 
 /* symbol.c */
-extern struct expr *sym_env_list;
-
-void sym_init(void);
 void sym_clear_all_valid(void);
 struct symbol *sym_choice_default(struct symbol *sym);
 const char *sym_get_string_default(struct symbol *sym);
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
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 03143b2..7c9a88e 100644
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
@@ -1348,32 +1321,3 @@ const char *prop_get_type_name(enum prop_type type)
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
index 22201a4..136e497 100644
--- a/scripts/kconfig/util.c
+++ b/scripts/kconfig/util.c
@@ -8,16 +8,18 @@
 #include <stdarg.h>
 #include <stdlib.h>
 #include <string.h>
+
+#include "list.h"
 #include "lkc.h"
 
 /*
- * Expand symbol's names embedded in the string given in argument. Symbols'
- * name to be expanded shall be prefixed by a '$'. Unknown symbol expands to
+ * Expand environments embedded in the string given in argument. Environments
+ * to be expanded shall be prefixed by a '$'. Unknown environment expands to
  * the empty string.
  */
 char *expand_string_value(const char *in)
 {
-	const char *src;
+	const char *p, *q;
 	char *res;
 	size_t reslen;
 
@@ -25,39 +27,28 @@ char *expand_string_value(const char *in)
 	 * Note: 'in' might come from a token that's about to be
 	 * freed, so make sure to always allocate a new string
 	 */
-	reslen = strlen(in) + 1;
-	res = xmalloc(reslen);
-	res[0] = '\0';
-
-	while ((src = strchr(in, '$'))) {
-		char *p, name[SYMBOL_MAXLENGTH];
-		const char *symval = "";
-		struct symbol *sym;
-		size_t newlen;
-
-		strncat(res, in, src - in);
-		src++;
-
-		p = name;
-		while (isalnum(*src) || *src == '_')
-			*p++ = *src++;
-		*p = '\0';
-
-		sym = sym_find(name);
-		if (sym != NULL) {
-			sym_calc_value(sym);
-			symval = sym_get_string_value(sym);
-		}
+	res = xmalloc(1);
+	*res = '\0';
 
-		newlen = strlen(res) + strlen(symval) + strlen(src) + 1;
-		if (newlen > reslen) {
-			reslen = newlen;
-			res = xrealloc(res, reslen);
-		}
+	while ((p = strchr(in, '$'))) {
+		char *new;
+
+		q = p + 1;
+		while (isalnum(*q) || *q == '_')
+			q++;
 
-		strcat(res, symval);
-		in = src;
+		new = env_expand_n(p + 1, q - p - 1);
+
+		reslen = strlen(res) + (p - in) + strlen(new) + 1;
+		res = xrealloc(res, reslen);
+		strncat(res, in, p - in);
+		strcat(res, new);
+		free(new);
+		in = q;
 	}
+
+	reslen = strlen(res) + strlen(in) + 1;
+	res = xrealloc(res, reslen);
 	strcat(res, in);
 
 	return res;
@@ -87,8 +78,6 @@ struct file *file_lookup(const char *name)
 /* write a dependency file as used by kbuild to track dependencies */
 int file_write_dep(const char *name)
 {
-	struct symbol *sym, *env_sym;
-	struct expr *e;
 	struct file *file;
 	FILE *out;
 
@@ -107,21 +96,7 @@ int file_write_dep(const char *name)
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
diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
index 045093d..551ca47 100644
--- a/scripts/kconfig/zconf.l
+++ b/scripts/kconfig/zconf.l
@@ -35,6 +35,7 @@ struct buffer *current_buf;
 
 static int last_ts, first_ts;
 
+static void expand_string(const char *in);
 static void zconf_endhelp(void);
 static void zconf_endfile(void);
 
@@ -120,6 +121,7 @@ n	[A-Za-z0-9_-]
 }
 
 <PARAM>{
+	"$".*	expand_string(yytext);
 	"&&"	return T_AND;
 	"||"	return T_OR;
 	"("	return T_OPEN_PAREN;
@@ -157,12 +159,13 @@ n	[A-Za-z0-9_-]
 }
 
 <STRING>{
-	[^'"\\\n]+/\n	{
+	"$".*	expand_string(yytext);
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
@@ -249,6 +252,19 @@ n	[A-Za-z0-9_-]
 }
 
 %%
+static void expand_string(const char *in)
+{
+	char *p, *q;
+
+	p = expand_string_value(in);
+
+	q = p + strlen(p);
+	while (q > p)
+		unput(*--q);
+
+	free(p);
+}
+
 void zconf_starthelp(void)
 {
 	new_string();
diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
index 262c464..4ff4ac9 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -534,7 +534,6 @@ void conf_parse(const char *name)
 
 	zconf_initscan(name);
 
-	sym_init();
 	_menu_init();
 
 	if (getenv("ZCONF_DEBUG"))
@@ -775,6 +774,7 @@ void zconfdump(FILE *out)
 }
 
 #include "zconf.lex.c"
+#include "env.c"
 #include "util.c"
 #include "confdata.c"
 #include "expr.c"
-- 
2.7.4
