Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10768ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC8C20693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1AoBfSAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC8C20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbeGRBoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 21:44:21 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:19463 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730380AbeGRBoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 21:44:21 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w6I17q0A020074;
        Wed, 18 Jul 2018 10:07:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w6I17q0A020074
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531876073;
        bh=6rxPc8h80nyfQN75YjeoUAlslPDhEgktmJCc4d0it38=;
        h=From:To:Cc:Subject:Date:From;
        b=1AoBfSAVNBDy/QMBX8kFdwfLPh4pbyMqRkoVESZFT3RKiLJVSyh3fTVl1qGkeM0zt
         XO5MxGkviVOPaQJYCA15KnbADpUM3AfictD+FO3QI/ElqHFORPZJ73pQhc77Eq+neN
         PUQHwrL60t+G+/KrtrcnE7Q6f+mDsthW6c5gzUSfYRzQ8VfNVeIofTt645BF0XwTQr
         I84fXvFDRJvJmcJLW0dVQv/Y13lucSsQRzHsRQ54so2n4CRTXnMWcuEIxkTsMibYKG
         m6OPBX7mTgA96FN8CVBucRvBZUZ9ABNylfATlLzowkBan5IA/yXDyTyX8drGG1GNwn
         ZuIGzEhgCIZkQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     patches@arm.linux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: vfp: clean up arch/arm/vfp/Makefile
Date:   Wed, 18 Jul 2018 10:07:47 +0900
Message-Id: <1531876067-4957-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 799c43415442 ("kbuild: thin archives make default for
all archs"), $(AR) is used instead of $(LD) to combine object files.

The following code in arch/arm/vfp/Makefile:

  LDFLAGS         +=--no-warn-mismatch

... is no longer used.

Also, arch/arm/Makefile already guards arch/arm/vfp/ by a boolean
symbol, CONFIG_VFP, like this:

  core-$(CONFIG_VFP)              += arch/arm/vfp/

So, $(CONFIG_VFP) is always evaluated to y in arch/arm/vfp/Makefile.
There is no point to use pseudo object, vfp.o, which never becomes
a module.  Add all objects to obj-y directly.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

KernelVersion: v4.18-rc5


 arch/arm/vfp/Makefile | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/vfp/Makefile b/arch/arm/vfp/Makefile
index a81404c..94516c4 100644
--- a/arch/arm/vfp/Makefile
+++ b/arch/arm/vfp/Makefile
@@ -8,8 +8,5 @@
 # asflags-y := -DDEBUG
 
 KBUILD_AFLAGS	:=$(KBUILD_AFLAGS:-msoft-float=-Wa,-mfpu=softvfp+vfp -mfloat-abi=soft)
-LDFLAGS		+=--no-warn-mismatch
 
-obj-y			+= vfp.o
-
-vfp-$(CONFIG_VFP)	+= vfpmodule.o entry.o vfphw.o vfpsingle.o vfpdouble.o
+obj-y		+= vfpmodule.o entry.o vfphw.o vfpsingle.o vfpdouble.o
-- 
2.7.4

