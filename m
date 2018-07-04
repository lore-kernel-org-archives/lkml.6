Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9235EC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 22:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474A224178
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 22:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q0ucstaM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474A224178
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753147AbeGDWt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 18:49:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45938 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753068AbeGDWt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 18:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PF6/w0jdEIjkJrBtTrkzUANk3iJQGNGXDB/Q3HqtJ1w=; b=Q0ucstaMDKZAAnCbE9vLzoOx0
        v2uXgAleUCtsKpYFIyY44eY9ttANIw94GvU23sCWohoGmx+xbQ8Fbc2RVKKOB/S+V7uuKoLNwHjrp
        NLtKdptINiu62fNuQxb2/WnOGyO2Iuv2FLJ0zgdBt0GvX8pEbhxPCPii0oJujtS09Svk2r5SaT6ot
        8zsO8Cs2wCBUb0eWaEdEZyNms8Vv2FHKkg0o9wh6JPcs/dNT+kM5sWylgrGPlYvExlmXUZPUn1hoi
        nRoFNGw3oezlfgoH9MtzjI7JBlHx47Cp5+Fc80WI8vjBCyw1IOE2RrvGlLFvTL0qefoXVyfihgguH
        C/qCl9GYw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1faqaz-00063y-MJ; Wed, 04 Jul 2018 22:49:57 +0000
To:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] kconfig: update user kconfig tools doc.
Message-ID: <0eb8bc34-a0e0-eea8-be62-8420bd82c717@infradead.org>
Date:   Wed, 4 Jul 2018 15:49:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Update Documentation/kbuild/kconfig.txt, which mostly contains
user help for using the kernel config tools.

- Add mention of 'nconfig' embedded help text.
- Make the section on new config symbols readable.
- Correct how to find menuconfig search help.
- Add section on 'nconfig' usage.
- Mention that gconfig has multiple viewing modes/options.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/kbuild/kconfig.txt |   51 ++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 8 deletions(-)

--- lnx-418-rc3.orig/Documentation/kbuild/kconfig.txt
+++ lnx-418-rc3/Documentation/kbuild/kconfig.txt
@@ -2,9 +2,9 @@ This file contains some assistance for u
 
 Use "make help" to list all of the possible configuration targets.
 
-The xconfig ('qconf') and menuconfig ('mconf') programs also
-have embedded help text.  Be sure to check it for navigation,
-search, and other general help text.
+The xconfig ('qconf'), menuconfig ('mconf'), and nconfig ('nconf')
+programs also have embedded help text.  Be sure to check that for
+navigation, search, and other general help text.
 
 ======================================================================
 General
@@ -17,13 +17,16 @@ this happens, using a previously working
 for you, so you may find that you need to see what NEW kernel
 symbols have been introduced.
 
-To see a list of new config symbols when using "make oldconfig", use
+To see a list of new config symbols, use
 
 	cp user/some/old.config .config
 	make listnewconfig
 
 and the config program will list any new symbols, one per line.
 
+Alternatively, you can use the brute force method:
+
+	make oldconfig
 	scripts/diffconfig .config.old .config | less
 
 ______________________________________________________________________
@@ -160,7 +163,7 @@ Searching in menuconfig:
 		This lists all config symbols that contain "hotplug",
 		e.g., HOTPLUG_CPU, MEMORY_HOTPLUG.
 
-	For search help, enter / followed TAB-TAB-TAB (to highlight
+	For search help, enter / followed by TAB-TAB (to highlight
 	<Help>) and Enter.  This will tell you that you can also use
 	regular expressions (regexes) in the search string, so if you
 	are not interested in MEMORY_HOTPLUG, you could try
@@ -203,6 +206,39 @@ Example:
 
 
 ======================================================================
+nconfig
+--------------------------------------------------
+
+nconfig is an alternate text-based configurator.  It lists function
+keys across the bottom of the terminal (window) that execute commands.
+You can also just use the corresponding numeric key to execute the
+commands unless you are in a data entry window.  E.g., instead of F6
+for Save, you can just press 6.
+
+Use F1 for Global help or F3 for the Short help menu.
+
+Searching in nconfig:
+
+	You can search either in the menu entry "prompt" strings
+	or in the configuration symbols.
+
+	Use / to begin a search through the menu entries.  This does
+	not support regular expressions.  Use <Down> or <Up> for
+	Next hit and Previous hit, respectively.  Use <Esc> to
+	terminate the search mode.
+
+	F8 (SymSearch) searches the configuration symbols for the
+	given string or regular expression (regex).
+
+NCONFIG_MODE
+--------------------------------------------------
+This mode shows all sub-menus in one large tree.
+
+Example:
+	make NCONFIG_MODE=single_menu nconfig
+
+
+======================================================================
 xconfig
 --------------------------------------------------
 
@@ -230,8 +266,7 @@ gconfig
 
 Searching in gconfig:
 
-	None (gconfig isn't maintained as well as xconfig or menuconfig);
-	however, gconfig does have a few more viewing choices than
-	xconfig does.
+	There is no search command in gconfig.  However, gconfig does
+	have several different viewing choices, modes, and options.
 
 ###

