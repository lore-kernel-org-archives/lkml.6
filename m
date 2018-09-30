Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAF0C43143
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 02:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFCD206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 02:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="qlCYFqX4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CFCD206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbeI3JUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 05:20:23 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:55481 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727019AbeI3JUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 05:20:22 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 371cc1ce;
        Sun, 30 Sep 2018 02:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=mail; bh=HEs5d1wDv40lXAoJ5hGdtyyyrSY=; b=qlCYFqX48DCIGGS+g2eG
        kb3b/IZWd3TZgXIBSpJlaqJge/vx98L312sSUYrSB1EW1jSXZCknEw7U0WKNDlgb
        hlIJdgRcDgzGUOx5Z3a7417D6rP0WlTzSvlbY49L2PLlpcJSMbygUvBBRUtNVvsU
        DW2bfy5pM7dzGxqMq3nRkkqhtuBZBwhPHW1XM2C2+iOhrysLGNm/vEBc54kRqsQv
        SPMgh1nMr4dlggxRb5CBzoBpGlRaUW96+GTXMXd2aavFd/ApT2fufmdHHwdq5PiU
        OIUg0mBk5Yvh01ZKg5nVhFQctTweifQVp3RHts4uwapK8njagrysLe38HCfWl1aH
        FA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8447d7cf (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Sun, 30 Sep 2018 02:30:19 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, arm@kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] ARM: makefile: pass -march=armv4 to assembler even on CPU32v3
Date:   Sun, 30 Sep 2018 04:49:04 +0200
Message-Id: <20180930024904.14240-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per the discussion about half-way down in [1], the kernel doesn't
actually support the ARMv3 ISA, but selects it for some ARMv4 ISA
hardware that benefits from ARMv3 code generation. Such a consideration,
then, only applies to the compiler but not to the assembler. This commit
passes -march=armv4 to the assembler in those cases, so that code
written for ARMv4 will continue to compile and run fine, without needing
module-specific asflags-y overrides.

[1] https://lore.kernel.org/lkml/CAKv+Gu9FoFQymp2-=rUeh14CkUKON389OCE7stYCOFwKZpaCrg@mail.gmail.com/

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
I don't have too much familiarity with hardware this old, nor access to
testing systems, so please do carefully evaluate the assertions above
before merging this, since I'm not sure I have a full understanding of
the Linux ARMv3 situation.

 arch/arm/Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index d1516f85f25d..7a264cacb482 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -76,8 +76,14 @@ arch-$(CONFIG_CPU_32v4T)	=-D__LINUX_ARM_ARCH__=4 -march=armv4t
 arch-$(CONFIG_CPU_32v4)		=-D__LINUX_ARM_ARCH__=4 -march=armv4
 arch-$(CONFIG_CPU_32v3)		=-D__LINUX_ARM_ARCH__=3 -march=armv3
 
+# We do not actually support the ARMv3 ISA and prefer it above only for
+# code generation purposes, which does not apply to assembly. So we pass
+# v4 to the assembler, so that we can still assemble all instructions.
+arch-asflags-$(CONFIG_CPU_32v3)	=-march=armv4
+
 # Evaluate arch cc-option calls now
 arch-y := $(arch-y)
+arch-asflags-y := $(arch-asflags-y)
 
 # This selects how we optimise for the processor.
 tune-$(CONFIG_CPU_ARM7TDMI)	=-mtune=arm7tdmi
@@ -130,7 +136,7 @@ endif
 
 # Need -Uarm for gcc < 3.x
 KBUILD_CFLAGS	+=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
-KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) -include asm/unified.h -msoft-float
+KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) $(arch-asflags-y) -include asm/unified.h -msoft-float
 
 CHECKFLAGS	+= -D__arm__
 
-- 
2.19.0

