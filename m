Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B493CC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782672081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="n9Qd2Cc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 782672081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbeLKLCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:02:06 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:36860 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbeLKLBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:01:50 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wBBB1C60017210;
        Tue, 11 Dec 2018 20:01:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wBBB1C60017210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544526090;
        bh=KZHPFlAZWooUhIS11wcnu+1SJRNuDkD/aVf/1EZWOrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n9Qd2Cc+DYgjZ3SxIOHjYtVf/sXOeR4g1bKvmidsLY+l6TwtqSDB/tAPW+4R9ruLP
         ndebAouoPY99CL0gj1Wyx2kU18m2GvGfGQO9f1K1B7ayg4HgUbJOP0V3v54vgwJnxo
         R/ckKE/RWy6RceffLUWGYZkEGYuggTUv87kL9M1Y4kTDm18kuDbT6ETI3fwxiTg8FF
         68tArtXxLEwWVNBZ8Rwmg+5tovpiTtoK+BSkH1ipREebqmHW/VI5h84PeecnnXLUml
         hUyf7EJUu58zQbkpZ235rUEasUwCGwV7XRDJb5pA2QyhXl+C/Y4gR8vGkn0oKR1s0N
         4hmBVOzdkSBCw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ulf Magnusson <ulfalizer@gmail.com>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 23/27] kconfig: refactor end token rules
Date:   Tue, 11 Dec 2018 20:01:06 +0900
Message-Id: <1544526070-16690-24-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T_ENDMENU, T_ENDCHOICE, T_ENDIF are the last users of kconf_id
associated with yylval. Refactor them to not use it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/zconf.y | 43 +++++++++++++++----------------------------
 1 file changed, 15 insertions(+), 28 deletions(-)

diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
index 3c44d67..36cffc0 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -24,7 +24,8 @@ int yylex(void);
 static void yyerror(const char *err);
 static void zconfprint(const char *err, ...);
 static void zconf_error(const char *err, ...);
-static bool zconf_endtoken(const struct kconf_id *id, int starttoken, int endtoken);
+static bool zconf_endtoken(const char *tokenname,
+			   const char *expected_tokenname);
 
 struct symbol *symbol_hash[SYMBOL_HASHSIZE];
 
@@ -98,7 +99,7 @@ static struct menu *current_menu, *current_entry;
 %type <type> type bool_or_tri default
 %type <expr> expr
 %type <expr> if_expr
-%type <id> end
+%type <string> end
 %type <menu> if_entry menu_entry choice_entry
 %type <string> word_opt assign_val
 %type <flavor> assign_op
@@ -256,7 +257,7 @@ choice_entry: choice choice_option_list
 
 choice_end: end
 {
-	if (zconf_endtoken($1, T_CHOICE, T_ENDCHOICE)) {
+	if (zconf_endtoken($1, "choice")) {
 		menu_end_menu();
 		printd(DEBUG_PARSE, "%s:%d:endchoice\n", zconf_curname(), zconf_lineno());
 	}
@@ -330,7 +331,7 @@ if_entry: T_IF expr T_EOL
 
 if_end: end
 {
-	if (zconf_endtoken($1, T_IF, T_ENDIF)) {
+	if (zconf_endtoken($1, "if")) {
 		menu_end_menu();
 		printd(DEBUG_PARSE, "%s:%d:endif\n", zconf_curname(), zconf_lineno());
 	}
@@ -355,7 +356,7 @@ menu_entry: menu menu_option_list
 
 menu_end: end
 {
-	if (zconf_endtoken($1, T_MENU, T_ENDMENU)) {
+	if (zconf_endtoken($1, "menu")) {
 		menu_end_menu();
 		printd(DEBUG_PARSE, "%s:%d:endmenu\n", zconf_curname(), zconf_lineno());
 	}
@@ -445,9 +446,9 @@ prompt:	  T_WORD
 	| T_WORD_QUOTE
 ;
 
-end:	  T_ENDMENU T_EOL	{ $$ = $1; }
-	| T_ENDCHOICE T_EOL	{ $$ = $1; }
-	| T_ENDIF T_EOL		{ $$ = $1; }
+end:	  T_ENDMENU T_EOL	{ $$ = "menu"; }
+	| T_ENDCHOICE T_EOL	{ $$ = "choice"; }
+	| T_ENDIF T_EOL		{ $$ = "if"; }
 ;
 
 if_expr:  /* empty */			{ $$ = NULL; }
@@ -530,35 +531,21 @@ void conf_parse(const char *name)
 	sym_set_change_count(1);
 }
 
-static const char *zconf_tokenname(int token)
-{
-	switch (token) {
-	case T_MENU:		return "menu";
-	case T_ENDMENU:		return "endmenu";
-	case T_CHOICE:		return "choice";
-	case T_ENDCHOICE:	return "endchoice";
-	case T_IF:		return "if";
-	case T_ENDIF:		return "endif";
-	case T_DEPENDS:		return "depends";
-	case T_VISIBLE:		return "visible";
-	}
-	return "<token>";
-}
-
-static bool zconf_endtoken(const struct kconf_id *id, int starttoken, int endtoken)
+static bool zconf_endtoken(const char *tokenname,
+			   const char *expected_tokenname)
 {
-	if (id->token != endtoken) {
+	if (strcmp(tokenname, expected_tokenname)) {
 		zconf_error("unexpected '%s' within %s block",
-			id->name, zconf_tokenname(starttoken));
+			    tokenname, expected_tokenname);
 		yynerrs++;
 		return false;
 	}
 	if (current_menu->file != current_file) {
 		zconf_error("'%s' in different file than '%s'",
-			id->name, zconf_tokenname(starttoken));
+			    tokenname, expected_tokenname);
 		fprintf(stderr, "%s:%d: location of the '%s'\n",
 			current_menu->file->name, current_menu->lineno,
-			zconf_tokenname(starttoken));
+			expected_tokenname);
 		yynerrs++;
 		return false;
 	}
-- 
2.7.4

