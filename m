Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C4CC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27EFF2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Yi532WXo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27EFF2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbeLKLBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:01:46 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:36701 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbeLKLBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:01:43 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wBBB1C5l017210;
        Tue, 11 Dec 2018 20:01:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wBBB1C5l017210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544526080;
        bh=azx+pnU1cXACJgUuzQ4P92840L9XD8VA47ps+ZrPfdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yi532WXoQr1Nj9YE15y7UbTWaAHCmFQLxNrYlPd1hGNIzqOnIH/bnSmFKsA5wsoMH
         TwS6z0h/Pl64Dm5/8NZf7Om3zuq0H6BNSNbNZZnWI2gA4ND4kVwgx2OG+JH2vIq4kk
         pwM7lnHJ8tZBxyKiqN60WZ1KqriEaaBukqXrrmoaP+WeLO2wlALkcHtvblpJ5R4dCU
         vho2rC7EfxPhfjTUxqY3EQUCmJ7XtozHjNAYNO1wevXORwI7udyblg0x+F8ocM5QR1
         MzPnU54F5Ndkgc6QHFbmhAOMvZgqGuyUp/4MUAWLQlf2Q/bAnva1iE690Luf62tviM
         L3yAaQ1X8GYWA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ulf Magnusson <ulfalizer@gmail.com>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 10/27] kconfig: remove grammatically ambiguous option_error
Date:   Tue, 11 Dec 2018 20:00:53 +0900
Message-Id: <1544526070-16690-11-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit decreases 6 shift/reduce conflicts, and finally achieves
conflict-free parser.

Since Kconfig has no terminator for a config block, detecting the end
of config_stmt is not easy.

For example, there are two ways for handling the error in the following
code:

  1 config FOO
  2         =

 [A] Print "unknown option" error, assuming the line 2 is a part of
     config_option_list

 [B] Print "invalid statement", assuming the line 1 is reduced into
     a config_stmt by itself

Bison actually chooses [A] because it performs the shift rather than
the reduction where both are possible.

However, there is no reason to choose one over the other since the
code above can be written as follows:

 1 config FOO
 2
 3 =

Remove the option_error, and let it fall back to [B].

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/zconf.y | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
index cef6123..a92f167 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -31,7 +31,6 @@ struct symbol *symbol_hash[SYMBOL_HASHSIZE];
 static struct menu *current_menu, *current_entry;
 
 %}
-%expect 6
 
 %union
 {
@@ -138,12 +137,6 @@ common_stmt:
 	| assignment_stmt
 ;
 
-option_error:
-	  T_WORD error T_EOL		{ zconf_error("unknown option \"%s\"", $1); }
-	| error T_EOL			{ zconf_error("invalid option"); }
-;
-
-
 /* config/menuconfig entry */
 
 config_entry_start: T_CONFIG nonconst_symbol T_EOL
@@ -180,7 +173,6 @@ config_option_list:
 	| config_option_list symbol_option
 	| config_option_list depends
 	| config_option_list help
-	| config_option_list option_error
 ;
 
 config_option: T_TYPE prompt_stmt_opt T_EOL
@@ -280,7 +272,6 @@ choice_option_list:
 	| choice_option_list choice_option
 	| choice_option_list depends
 	| choice_option_list help
-	| choice_option_list option_error
 ;
 
 choice_option: T_PROMPT prompt if_expr T_EOL
@@ -429,7 +420,6 @@ help: help_start T_HELPTEXT
 depends_list:
 	  /* empty */
 	| depends_list depends
-	| depends_list option_error
 ;
 
 depends: T_DEPENDS T_ON expr T_EOL
-- 
2.7.4

