Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA0FC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2B22082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="aViQDLRi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2B22082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbeLKLCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:02:46 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:36708 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeLKLBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:01:43 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wBBB1C5r017210;
        Tue, 11 Dec 2018 20:01:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wBBB1C5r017210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544526084;
        bh=20fylg0O/NbaIrzaAWFHS70OGtASBygIuGQ2RPgwQQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aViQDLRiEZDJZoPtq/blfU5vVvDgGIvjfpif58ddE/Jry0GNDipjMsFhtOIAmX/f+
         /ybSk0cIbi5vZhbeg7D+yEFjFX9H23DYas7uyYxmjL10MxdgzZXJ6NKUlWH3+8KNM+
         xEPNtcfohm3JcjGvON/t0e4gFMenNr4pT3kZbMOqWpLEzPFgB/vdaE70Jdl5mv7ukC
         s5OZlTeYMhkW2SzFTNcT/7uInfCo5iz0pUOiMIF6gVt3+a4ajNaomLNI+Q0LFX28vq
         BaAv6MBVgF8HYLQCydM0ERkkspJ750ta22EdelIriVQO2DC6dl8jpuSaKaJ8aPEWBM
         E3hOqzcEQjj6Q==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ulf Magnusson <ulfalizer@gmail.com>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 16/27] kconfig: use distinct tokens for type and default properties
Date:   Tue, 11 Dec 2018 20:00:59 +0900
Message-Id: <1544526070-16690-17-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit removes kconf_id::stype to prepare for the entire
removal of kconf_id.c

To simplify the lexer, I want keywords straight-mapped to tokens.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/kconf_id.c | 16 ++++++------
 scripts/kconfig/lkc.h      |  1 -
 scripts/kconfig/zconf.y    | 62 +++++++++++++++++++++++++++++-----------------
 3 files changed, 47 insertions(+), 32 deletions(-)

diff --git a/scripts/kconfig/kconf_id.c b/scripts/kconfig/kconf_id.c
index b3e0ea0..ec2c011 100644
--- a/scripts/kconfig/kconf_id.c
+++ b/scripts/kconfig/kconf_id.c
@@ -15,15 +15,15 @@ static struct kconf_id kconf_id_array[] = {
 	{ "endif",		T_ENDIF,		TF_COMMAND },
 	{ "depends",		T_DEPENDS,		TF_COMMAND },
 	{ "optional",		T_OPTIONAL,		TF_COMMAND },
-	{ "default",		T_DEFAULT,		TF_COMMAND, S_UNKNOWN },
+	{ "default",		T_DEFAULT,		TF_COMMAND },
+	{ "def_bool",		T_DEF_BOOL,		TF_COMMAND },
+	{ "def_tristate",	T_DEF_TRISTATE,		TF_COMMAND },
 	{ "prompt",		T_PROMPT,		TF_COMMAND },
-	{ "tristate",		T_TYPE,			TF_COMMAND, S_TRISTATE },
-	{ "def_tristate",	T_DEFAULT,		TF_COMMAND, S_TRISTATE },
-	{ "bool",		T_TYPE,			TF_COMMAND, S_BOOLEAN },
-	{ "def_bool",		T_DEFAULT,		TF_COMMAND, S_BOOLEAN },
-	{ "int",		T_TYPE,			TF_COMMAND, S_INT },
-	{ "hex",		T_TYPE,			TF_COMMAND, S_HEX },
-	{ "string",		T_TYPE,			TF_COMMAND, S_STRING },
+	{ "bool",		T_BOOL,			TF_COMMAND },
+	{ "tristate",		T_TRISTATE,		TF_COMMAND },
+	{ "int",		T_INT,			TF_COMMAND },
+	{ "hex",		T_HEX,			TF_COMMAND },
+	{ "string",		T_STRING,		TF_COMMAND },
 	{ "select",		T_SELECT,		TF_COMMAND },
 	{ "imply",		T_IMPLY,		TF_COMMAND },
 	{ "range",		T_RANGE,		TF_COMMAND },
diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
index 9eb7c83..b6bbcd1 100644
--- a/scripts/kconfig/lkc.h
+++ b/scripts/kconfig/lkc.h
@@ -50,7 +50,6 @@ struct kconf_id {
 	const char *name;
 	int token;
 	unsigned int flags;
-	enum symbol_type stype;
 };
 
 extern int yylineno;
diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
index 020454b..4345f9f 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -40,6 +40,7 @@ static struct menu *current_menu, *current_entry;
 	struct expr *expr;
 	struct menu *menu;
 	const struct kconf_id *id;
+	enum symbol_type type;
 	enum variable_flavor flavor;
 }
 
@@ -59,8 +60,6 @@ static struct menu *current_menu, *current_entry;
 %token <id>T_DEPENDS
 %token <id>T_OPTIONAL
 %token <id>T_PROMPT
-%token <id>T_TYPE
-%token <id>T_DEFAULT
 %token <id>T_SELECT
 %token <id>T_IMPLY
 %token <id>T_RANGE
@@ -69,8 +68,16 @@ static struct menu *current_menu, *current_entry;
 %token <id>T_ON
 %token <string> T_WORD
 %token <string> T_WORD_QUOTE
+%token T_BOOL
 %token T_CLOSE_PAREN
+%token T_DEFAULT
+%token T_DEF_BOOL
+%token T_DEF_TRISTATE
+%token T_HEX
+%token T_INT
 %token T_OPEN_PAREN
+%token T_STRING
+%token T_TRISTATE
 %token T_EOL
 %token <string> T_VARIABLE
 %token <flavor> T_ASSIGN
@@ -85,6 +92,7 @@ static struct menu *current_menu, *current_entry;
 %type <string> prompt
 %type <symbol> nonconst_symbol
 %type <symbol> symbol
+%type <type> type bool_or_tri default
 %type <expr> expr
 %type <expr> if_expr
 %type <id> end
@@ -169,12 +177,12 @@ config_option_list:
 	| config_option_list help
 ;
 
-config_option: T_TYPE prompt_stmt_opt T_EOL
+config_option: type prompt_stmt_opt T_EOL
 {
-	menu_set_type($1->stype);
+	menu_set_type($1);
 	printd(DEBUG_PARSE, "%s:%d:type(%u)\n",
 		zconf_curname(), zconf_lineno(),
-		$1->stype);
+		$1);
 };
 
 config_option: T_PROMPT prompt if_expr T_EOL
@@ -183,14 +191,14 @@ config_option: T_PROMPT prompt if_expr T_EOL
 	printd(DEBUG_PARSE, "%s:%d:prompt\n", zconf_curname(), zconf_lineno());
 };
 
-config_option: T_DEFAULT expr if_expr T_EOL
+config_option: default expr if_expr T_EOL
 {
 	menu_add_expr(P_DEFAULT, $2, $3);
-	if ($1->stype != S_UNKNOWN)
-		menu_set_type($1->stype);
+	if ($1 != S_UNKNOWN)
+		menu_set_type($1);
 	printd(DEBUG_PARSE, "%s:%d:default(%u)\n",
 		zconf_curname(), zconf_lineno(),
-		$1->stype);
+		$1);
 };
 
 config_option: T_SELECT nonconst_symbol if_expr T_EOL
@@ -274,15 +282,11 @@ choice_option: T_PROMPT prompt if_expr T_EOL
 	printd(DEBUG_PARSE, "%s:%d:prompt\n", zconf_curname(), zconf_lineno());
 };
 
-choice_option: T_TYPE prompt_stmt_opt T_EOL
+choice_option: bool_or_tri prompt_stmt_opt T_EOL
 {
-	if ($1->stype == S_BOOLEAN || $1->stype == S_TRISTATE) {
-		menu_set_type($1->stype);
-		printd(DEBUG_PARSE, "%s:%d:type(%u)\n",
-			zconf_curname(), zconf_lineno(),
-			$1->stype);
-	} else
-		YYERROR;
+	menu_set_type($1);
+	printd(DEBUG_PARSE, "%s:%d:type(%u)\n",
+	       zconf_curname(), zconf_lineno(), $1);
 };
 
 choice_option: T_OPTIONAL T_EOL
@@ -293,14 +297,26 @@ choice_option: T_OPTIONAL T_EOL
 
 choice_option: T_DEFAULT nonconst_symbol if_expr T_EOL
 {
-	if ($1->stype == S_UNKNOWN) {
-		menu_add_symbol(P_DEFAULT, $2, $3);
-		printd(DEBUG_PARSE, "%s:%d:default\n",
-			zconf_curname(), zconf_lineno());
-	} else
-		YYERROR;
+	menu_add_symbol(P_DEFAULT, $2, $3);
+	printd(DEBUG_PARSE, "%s:%d:default\n",
+	       zconf_curname(), zconf_lineno());
 };
 
+type:
+	  bool_or_tri
+	| T_INT			{ $$ = S_INT; }
+	| T_HEX			{ $$ = S_HEX; }
+	| T_STRING		{ $$ = S_STRING; }
+
+bool_or_tri:
+	  T_BOOL		{ $$ = S_BOOLEAN; }
+	| T_TRISTATE		{ $$ = S_TRISTATE; }
+
+default:
+	  T_DEFAULT		{ $$ = S_UNKNOWN; }
+	| T_DEF_BOOL		{ $$ = S_BOOLEAN; }
+	| T_DEF_TRISTATE	{ $$ = S_TRISTATE; }
+
 choice_block:
 	  /* empty */
 	| choice_block common_stmt
-- 
2.7.4

