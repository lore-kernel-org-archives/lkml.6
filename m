Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3D9C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6F22081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Z00SIdjL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6F22081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeLKLCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:02:48 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:36717 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbeLKLBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:01:43 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wBBB1C5s017210;
        Tue, 11 Dec 2018 20:01:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wBBB1C5s017210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544526085;
        bh=J02b+9Zj+B1p1FUXXgB3BFEcLl7iHu0uQ5OSwehpRuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z00SIdjLHCEj9f4UhYHhbGrQmDkm8Ucwpxly4GjBjq4vC3dq8njmE/cmA3R8waCe5
         /tDKdNcOXLnotWWu3gHsWT4KIkbbSmuxB4J9UF7wILHZqb/OA+iwhjpqXEL/0t4ydJ
         lPyiHHtyxkc7RaW3lIYPlVtY+9yiuKLDxtLASzZ6ESFo2eMkQU2Nf8UVPLCjWAkn6t
         o9flduHBCJzSjsGP6xqSUFNJoJvCKgxgyfO8MvsHnlpQ6rSmlGgue7PP8TytQCXbGI
         ab7umbfKBcA/mY2hTKkv30TADvuKIHc3jQT+/IM8kVVRQVBH8xyH96CKQenP5czmgj
         rrSeTLOlOBX9A==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ulf Magnusson <ulfalizer@gmail.com>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 17/27] kconfig: refactor scanning and parsing "option" properties
Date:   Tue, 11 Dec 2018 20:01:00 +0900
Message-Id: <1544526070-16690-18-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the keywords "modules", "defconfig_list", and "allnoconfig_y",
the lexer should pass specific tokens instead of generic T_WORD.

This simplifies both the lexer and the parser.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/kconf_id.c |  3 ---
 scripts/kconfig/lkc.h      |  9 +++------
 scripts/kconfig/menu.c     | 43 ++++++++++++++++++++-----------------------
 scripts/kconfig/zconf.l    |  3 +++
 scripts/kconfig/zconf.y    | 35 +++++++++++++++--------------------
 5 files changed, 41 insertions(+), 52 deletions(-)

diff --git a/scripts/kconfig/kconf_id.c b/scripts/kconfig/kconf_id.c
index ec2c011..f8b222c 100644
--- a/scripts/kconfig/kconf_id.c
+++ b/scripts/kconfig/kconf_id.c
@@ -30,9 +30,6 @@ static struct kconf_id kconf_id_array[] = {
 	{ "visible",		T_VISIBLE,		TF_COMMAND },
 	{ "option",		T_OPTION,		TF_COMMAND },
 	{ "on",			T_ON,			TF_PARAM },
-	{ "modules",		T_OPT_MODULES,		TF_OPTION },
-	{ "defconfig_list",	T_OPT_DEFCONFIG_LIST,	TF_OPTION },
-	{ "allnoconfig_y",	T_OPT_ALLNOCONFIG_Y,	TF_OPTION },
 };
 
 #define KCONF_ID_ARRAY_SIZE (sizeof(kconf_id_array)/sizeof(struct kconf_id))
diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
index b6bbcd1..5f4880a 100644
--- a/scripts/kconfig/lkc.h
+++ b/scripts/kconfig/lkc.h
@@ -32,7 +32,6 @@ static inline const char *CONFIG_prefix(void)
 
 #define TF_COMMAND	0x0001
 #define TF_PARAM	0x0002
-#define TF_OPTION	0x0004
 
 enum conf_def_mode {
 	def_default,
@@ -42,10 +41,6 @@ enum conf_def_mode {
 	def_random
 };
 
-#define T_OPT_MODULES		1
-#define T_OPT_DEFCONFIG_LIST	2
-#define T_OPT_ALLNOCONFIG_Y	4
-
 struct kconf_id {
 	const char *name;
 	int token;
@@ -90,7 +85,9 @@ void menu_add_visibility(struct expr *dep);
 struct property *menu_add_prompt(enum prop_type type, char *prompt, struct expr *dep);
 void menu_add_expr(enum prop_type type, struct expr *expr, struct expr *dep);
 void menu_add_symbol(enum prop_type type, struct symbol *sym, struct expr *dep);
-void menu_add_option(int token, char *arg);
+void menu_add_option_modules(void);
+void menu_add_option_defconfig_list(void);
+void menu_add_option_allnoconfig_y(void);
 void menu_finalize(struct menu *parent);
 void menu_set_type(int type);
 
diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index 4cf15d4..7e2b2c9 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -195,29 +195,26 @@ void menu_add_symbol(enum prop_type type, struct symbol *sym, struct expr *dep)
 	menu_add_prop(type, NULL, expr_alloc_symbol(sym), dep);
 }
 
-void menu_add_option(int token, char *arg)
-{
-	switch (token) {
-	case T_OPT_MODULES:
-		if (modules_sym)
-			zconf_error("symbol '%s' redefines option 'modules'"
-				    " already defined by symbol '%s'",
-				    current_entry->sym->name,
-				    modules_sym->name
-				    );
-		modules_sym = current_entry->sym;
-		break;
-	case T_OPT_DEFCONFIG_LIST:
-		if (!sym_defconfig_list)
-			sym_defconfig_list = current_entry->sym;
-		else if (sym_defconfig_list != current_entry->sym)
-			zconf_error("trying to redefine defconfig symbol");
-		sym_defconfig_list->flags |= SYMBOL_NO_WRITE;
-		break;
-	case T_OPT_ALLNOCONFIG_Y:
-		current_entry->sym->flags |= SYMBOL_ALLNOCONFIG_Y;
-		break;
-	}
+void menu_add_option_modules(void)
+{
+	if (modules_sym)
+		zconf_error("symbol '%s' redefines option 'modules' already defined by symbol '%s'",
+			    current_entry->sym->name, modules_sym->name);
+	modules_sym = current_entry->sym;
+}
+
+void menu_add_option_defconfig_list(void)
+{
+	if (!sym_defconfig_list)
+		sym_defconfig_list = current_entry->sym;
+	else if (sym_defconfig_list != current_entry->sym)
+		zconf_error("trying to redefine defconfig symbol");
+	sym_defconfig_list->flags |= SYMBOL_NO_WRITE;
+}
+
+void menu_add_option_allnoconfig_y(void)
+{
+	current_entry->sym->flags |= SYMBOL_ALLNOCONFIG_Y;
 }
 
 static int menu_validate_number(struct symbol *sym, struct symbol *sym2)
diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
index 5046d3c..0265502 100644
--- a/scripts/kconfig/zconf.l
+++ b/scripts/kconfig/zconf.l
@@ -147,6 +147,9 @@ n	[A-Za-z0-9_-]
 }
 
 <PARAM>{
+	"modules"		return T_MODULES;
+	"defconfig_list"	return T_DEFCONFIG_LIST;
+	"allnoconfig_y"		return T_ALLNOCONFIG_Y;
 	"&&"	return T_AND;
 	"||"	return T_OR;
 	"("	return T_OPEN_PAREN;
diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
index 4345f9f..8db9189 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -64,18 +64,21 @@ static struct menu *current_menu, *current_entry;
 %token <id>T_IMPLY
 %token <id>T_RANGE
 %token <id>T_VISIBLE
-%token <id>T_OPTION
 %token <id>T_ON
 %token <string> T_WORD
 %token <string> T_WORD_QUOTE
+%token T_ALLNOCONFIG_Y
 %token T_BOOL
 %token T_CLOSE_PAREN
 %token T_DEFAULT
+%token T_DEFCONFIG_LIST
 %token T_DEF_BOOL
 %token T_DEF_TRISTATE
 %token T_HEX
 %token T_INT
+%token T_MODULES
 %token T_OPEN_PAREN
+%token T_OPTION
 %token T_STRING
 %token T_TRISTATE
 %token T_EOL
@@ -97,7 +100,7 @@ static struct menu *current_menu, *current_entry;
 %type <expr> if_expr
 %type <id> end
 %type <menu> if_entry menu_entry choice_entry
-%type <string> symbol_option_arg word_opt assign_val
+%type <string> word_opt assign_val
 
 %destructor {
 	fprintf(stderr, "%s:%d: missing end statement for this entry\n",
@@ -172,7 +175,6 @@ menuconfig_stmt: menuconfig_entry_start config_option_list
 config_option_list:
 	  /* empty */
 	| config_option_list config_option
-	| config_option_list symbol_option
 	| config_option_list depends
 	| config_option_list help
 ;
@@ -219,27 +221,20 @@ config_option: T_RANGE symbol symbol if_expr T_EOL
 	printd(DEBUG_PARSE, "%s:%d:range\n", zconf_curname(), zconf_lineno());
 };
 
-symbol_option: T_OPTION symbol_option_list T_EOL
-;
+config_option: T_OPTION T_MODULES T_EOL
+{
+	menu_add_option_modules();
+};
 
-symbol_option_list:
-	  /* empty */
-	| symbol_option_list T_WORD symbol_option_arg
+config_option: T_OPTION T_DEFCONFIG_LIST T_EOL
 {
-	const struct kconf_id *id = kconf_id_lookup($2, strlen($2));
-	if (id && id->flags & TF_OPTION) {
-		menu_add_option(id->token, $3);
-		free($3);
-	}
-	else
-		zconfprint("warning: ignoring unknown option %s", $2);
-	free($2);
+	menu_add_option_defconfig_list();
 };
 
-symbol_option_arg:
-	  /* empty */		{ $$ = NULL; }
-	| T_EQUAL prompt	{ $$ = $2; }
-;
+config_option: T_OPTION T_ALLNOCONFIG_Y T_EOL
+{
+	menu_add_option_allnoconfig_y();
+};
 
 /* choice entry */
 
-- 
2.7.4

