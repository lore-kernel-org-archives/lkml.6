Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762F5C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4B9208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="uAQoZIXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4B9208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732419AbeGLIMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:12:07 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:56399 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbeGLILp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:11:45 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w6C81cQh012716;
        Thu, 12 Jul 2018 17:01:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w6C81cQh012716
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531382502;
        bh=EG0KJF1GpFZUkaiy9xjSIY+ixmP/0UjyRpBm3mH+Qm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uAQoZIXAmyr4leAyZZA4N6MLG1D830VjkOeumcOl10FHCTBx9LhN/nG1StGpgTkem
         j/OhcHtQkFFOw+ZEJHYZxU8Z2FcUnW4J9H76AjNjrNZHsPmGzSETYeWz4M3JaMRNNE
         AoUXVVERud74oEO4HdnLhpC9NGRB20s0FMqLIHjllNIay6BWzdgcjYE3WE+3GN6qVG
         QVOeOuxb2qvIQVzydshCHgxrqmnfA8VCKafuy03pNovcy9JOiNoTmltLJttMcXMAdp
         C4Nivy31D5/8W7o8g6ct8dgtI2f0xk4wfjqWQu9g3UBJkBUPnPVGcmcTVsHeNEpPSM
         T4dePa+1PnJEw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>, x86@kernel.org,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        openrisc@lists.librecores.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Jeff Dike <jdike@addtoit.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/6] ARM: vfp: clean-up arch/arm/vfp/Makefile
Date:   Thu, 12 Jul 2018 17:01:32 +0900
Message-Id: <1531382496-3719-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531382496-3719-1-git-send-email-yamada.masahiro@socionext.com>
References: <1531382496-3719-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 799c43415442 ("kbuild: thin archives make default for
all archs"), $(AR) is used instead of $(LD) to combine object files.

  LDFLAGS         +=--no-warn-mismatch

... is unused code now.

arch/arm/Makefile already guards arch/arm/vfp/ by a boolean symbol,
CONFIG_VFP, like this:

  core-$(CONFIG_VFP)              += arch/arm/vfp/

..., so $(CONFIG_VFP) is always evaluated to y in arch/arm/vfp/Makefile.

Also, there is no point to use pseudo object, vfp.o, which never becomes
a module.  Add all objects directly to obj-y.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

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

