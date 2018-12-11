Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD32C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B3D2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="2csVzN7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B3D2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbeLKLCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:02:19 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:36859 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbeLKLBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:01:49 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wBBB1C61017210;
        Tue, 11 Dec 2018 20:01:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wBBB1C61017210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544526090;
        bh=hzYyyrxQPXTdQIdYAboEbvyEEikywwYe5oI5dt1P3mQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2csVzN7AzTqpD+zj9d5WfbxsrqC0uVfoUtK8CkVpMoiaCtmZbP1nzk5psmOgpOyi7
         zpQdQblf1K0zbT6nFKIcY23B29MLAJztgTp09YP7kqKLIGb3YBBkh3K7fS9ukzFOWh
         9SZ4YlhISEMZb4OGA1HvhjN9DENDVBugYGv7DFJJZ43zmyJAenTT4c1n6m3ahbcIea
         UceMwDr1sOXqNlcdre6bHynmjGX+IkNXK+M1wvFgw/5A2mghnCfuu7TzofdcvZxqxw
         DVOW3nioO7DTc4ZUMb7rN7YWLLWzGiMOcGNZTe0pT9I2OW8Q6hplcrLR4aWnsQuoQF
         dGjmr6J5s6sNw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ulf Magnusson <ulfalizer@gmail.com>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 24/27] kconfig: stop associating kconf_id with yylval
Date:   Tue, 11 Dec 2018 20:01:07 +0900
Message-Id: <1544526070-16690-25-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lexer has conventionally associated kconf_id data with yylval
to carry additional information to the parser.

No token is relying on this any more.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/zconf.l |  2 --
 scripts/kconfig/zconf.y | 41 ++++++++++++++++++++---------------------
 2 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
index b715af9..c8823a4 100644
--- a/scripts/kconfig/zconf.l
+++ b/scripts/kconfig/zconf.l
@@ -111,7 +111,6 @@ n	[A-Za-z0-9_-]
 		current_pos.lineno = yylineno;
 		if (id && id->flags & TF_COMMAND) {
 			BEGIN(PARAM);
-			yylval.id = id;
 			return id->token;
 		}
 		alloc_string(yytext, yyleng);
@@ -170,7 +169,6 @@ n	[A-Za-z0-9_-]
 	{n}+	{
 		const struct kconf_id *id = kconf_id_lookup(yytext, yyleng);
 		if (id && id->flags & TF_PARAM) {
-			yylval.id = id;
 			return id->token;
 		}
 		alloc_string(yytext, yyleng);
diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
index 36cffc0..c611d70 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -40,50 +40,49 @@ static struct menu *current_menu, *current_entry;
 	struct symbol *symbol;
 	struct expr *expr;
 	struct menu *menu;
-	const struct kconf_id *id;
 	enum symbol_type type;
 	enum variable_flavor flavor;
 }
 
-%token <id>T_MAINMENU
-%token <id>T_MENU
-%token <id>T_ENDMENU
-%token <id>T_SOURCE
-%token <id>T_CHOICE
-%token <id>T_ENDCHOICE
-%token <id>T_COMMENT
-%token <id>T_CONFIG
-%token <id>T_MENUCONFIG
-%token <id>T_HELP
 %token <string> T_HELPTEXT
-%token <id>T_IF
-%token <id>T_ENDIF
-%token <id>T_DEPENDS
-%token <id>T_OPTIONAL
-%token <id>T_PROMPT
-%token <id>T_SELECT
-%token <id>T_IMPLY
-%token <id>T_RANGE
-%token <id>T_VISIBLE
-%token <id>T_ON
 %token <string> T_WORD
 %token <string> T_WORD_QUOTE
 %token T_ALLNOCONFIG_Y
 %token T_BOOL
+%token T_CHOICE
 %token T_CLOSE_PAREN
 %token T_COLON_EQUAL
+%token T_COMMENT
+%token T_CONFIG
 %token T_DEFAULT
 %token T_DEFCONFIG_LIST
 %token T_DEF_BOOL
 %token T_DEF_TRISTATE
+%token T_DEPENDS
+%token T_ENDCHOICE
+%token T_ENDIF
+%token T_ENDMENU
+%token T_HELP
 %token T_HEX
+%token T_IF
+%token T_IMPLY
 %token T_INT
+%token T_MAINMENU
+%token T_MENU
+%token T_MENUCONFIG
 %token T_MODULES
+%token T_ON
 %token T_OPEN_PAREN
 %token T_OPTION
+%token T_OPTIONAL
 %token T_PLUS_EQUAL
+%token T_PROMPT
+%token T_RANGE
+%token T_SELECT
+%token T_SOURCE
 %token T_STRING
 %token T_TRISTATE
+%token T_VISIBLE
 %token T_EOL
 %token <string> T_ASSIGN_VAL
 
-- 
2.7.4

