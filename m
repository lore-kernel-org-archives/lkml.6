Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79F7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6268320652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="rKDoGcNT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6268320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbeGTIfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:35:08 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:28747 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727748AbeGTIfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:35:07 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w6K7kdit008048;
        Fri, 20 Jul 2018 16:46:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w6K7kdit008048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532072801;
        bh=UtJFHkFTAqjinjSTmU9cVhuQt6CxhteUa18fp6U9CLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rKDoGcNTGwuU8hEmgZrlV3sFsSksiS5t24xBbHAtM+1nibfTdSwQKYb57CGdFMZgT
         RDJe17w9ncIqhwF+LMHJPYpH73FUYtwWtIAOJpJBBpOBN2dSRX3hdALC0f9lii63+/
         Ej05qIEf72pE39Uic3ZhOI5e4v/B77QFXOFwY4tdRiMv9HLa91n3xnzQNh7CU0QhpL
         clHkw/ba1281n32MjaUumkzGLLb9J0OSILgfNR27Vr31Y6HdCt//54DAMYXkaleJKD
         pozMa0sImr9hfDPCCx7lu9YWo0xjpju9L3R4/3HumOGFJ5nKcPB46pIOdhrFrHBIPs
         k7A40EIYvrEWg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Dirk Gouders <dirk@gouders.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/11] kconfig: remove unneeded directory generation from local*config
Date:   Fri, 20 Jul 2018 16:46:28 +0900
Message-Id: <1532072796-7947-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532072796-7947-1-git-send-email-yamada.masahiro@socionext.com>
References: <1532072796-7947-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 17263baf958b ("kconfig: Create include/generated for
localmodconfig") added the 'mkdir' line because local{yes,mod}config
ran streamline_config.pl followed by silentoldconfig at that time.

Since commit 81d2bc227305 ("kconfig: invoke oldconfig instead of
silentoldconfig from local*config"), no sub-directory is required.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v4: None

 scripts/kconfig/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index f3c0e62..96a1c3d 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -41,7 +41,6 @@ syncconfig: $(obj)/conf
 	$< $(silent) --$@ $(Kconfig)
 
 localyesconfig localmodconfig: $(obj)/conf
-	$(Q)mkdir -p include/config include/generated
 	$(Q)perl $(srctree)/$(src)/streamline_config.pl --$@ $(srctree) $(Kconfig) > .tmp.config
 	$(Q)if [ -f .config ]; then 					\
 			cmp -s .tmp.config .config ||			\
-- 
2.7.4

