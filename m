Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B45AC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED6F2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="EjeE9NkR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED6F2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbeLKLDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:03:11 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:36714 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbeLKLBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:01:43 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wBBB1C5o017210;
        Tue, 11 Dec 2018 20:01:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wBBB1C5o017210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544526082;
        bh=S7ukwX6NkoGsh6wmesUTz6h4J/DCsX6bNDq3MpJLeqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EjeE9NkRQZByf0FXmq6z71dWwbxkAE/bleCS/A96rOjI5u/UbEoBmF2s68du9Me4t
         +eZVn0oOt+CoDDNj4xIMaEYRTjvnwx9QxFdewaJce2cQbye3aNAQZtCCw5Iszcik5G
         PVt3lTAxy6C7g2MLbyylyZ2W6RY8XC80ozYPw+nf3QNmdo0VkblH2NbHpGfh9exECg
         7Q5s+KlH62M4je/Q9Is71f5aoaXf8+QIRwOFIJgtSJIKH09tFiiqpL76Mo0ngt3+KC
         SAQ+evHHrGqVMWaFYNTF99cejzopivFULDkCTtcFxRcgCS7wNYR2ZiWIvmiCN4wpvs
         i+YMce7aqMgUg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ulf Magnusson <ulfalizer@gmail.com>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 13/27] kconfig: loosen the order of "visible" and "depends on" in menu entry
Date:   Tue, 11 Dec 2018 20:00:56 +0900
Message-Id: <1544526070-16690-14-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, "visible" and "depends on", if defined in a menu entry,
must appear in that order.

The real example is in drivers/media/tuners/Kconfig:

  menu "Customize TV tuners"
          visible if <expr1>
          depends on <expr2>

... is fine, but you cannot change the property order like this:

  menu "Customize TV tuners"
          depends on <expr2>
          visible if <expr1>

Kconfig does not require a specific order of properties. In this case,
menu_add_visibility(() and menu_add_dep() are orthogonal.

Loosen this unreasonable restriction.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/zconf.y | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
index eeb449b..7cc8244 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -341,7 +341,7 @@ menu: T_MENU prompt T_EOL
 	printd(DEBUG_PARSE, "%s:%d:menu\n", zconf_curname(), zconf_lineno());
 };
 
-menu_entry: menu visibility_list depends_list
+menu_entry: menu menu_option_list
 {
 	$$ = menu_add_menu();
 };
@@ -357,6 +357,12 @@ menu_end: end
 menu_stmt: menu_entry stmt_list menu_end
 ;
 
+menu_option_list:
+	  /* empty */
+	| menu_option_list visible
+	| menu_option_list depends
+;
+
 source_stmt: T_SOURCE prompt T_EOL
 {
 	printd(DEBUG_PARSE, "%s:%d:source %s\n", zconf_curname(), zconf_lineno(), $2);
@@ -414,12 +420,6 @@ depends: T_DEPENDS T_ON expr T_EOL
 };
 
 /* visibility option */
-
-visibility_list:
-	  /* empty */
-	| visibility_list visible
-;
-
 visible: T_VISIBLE if_expr T_EOL
 {
 	menu_add_visibility($2);
-- 
2.7.4

