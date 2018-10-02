Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7695DC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38AA52089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="CXfCdOha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38AA52089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbeJBUFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:05:15 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:35143 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbeJBUFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:05:15 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id ad258704;
        Tue, 2 Oct 2018 13:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=mail; bh=Voc8RVmCGbPhiVACpG+UGUo1e
        yc=; b=CXfCdOhaXhhU1vVyRPEs25Yf/oStWjiTLd8N3TKcKNcEo+SkLIg6TufIW
        Ij3rSBBDp8gUqeqLWnfaTO5JYMFnqsPEEs3Qj8GqGjugI7D73gMbXawFcEHxx8JC
        SyaqwVJnolgT3QVCTZ9uZMrS4/RRK0xeDUsAlk16IZofPsKA7C7UKUGLXe5xviFw
        d4V4QFQ4XW3rgl9vNxogEpdhW2C3jfhr106D4wXKe2D5aICBZooNfLFD+g7o6WPd
        ezGsG7LzvV1LuJgYESnILlXsVz7Yn4eNtLzB5XVXFn3gpXh1glHXHsd8k0fRX23M
        6gEOHi1wnFvR0xc9L/4boTuy5Yc9Q==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c6656ade (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Tue, 2 Oct 2018 13:21:52 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        arm@kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ARM: makefile: use ARMv3M mode for RiscPC
Date:   Tue,  2 Oct 2018 15:20:26 +0200
Message-Id: <20181002132026.14931-1-Jason@zx2c4.com>
In-Reply-To: <CAKv+Gu8NXyfNAzk4Fe=J0QHEEV-txbRAoEcQmjG-6PgCyW5SZg@mail.gmail.com>
References: <CAKv+Gu8NXyfNAzk4Fe=J0QHEEV-txbRAoEcQmjG-6PgCyW5SZg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of CONFIG_CPU_32v3 is to avoid ldrh/strh on the RiscPC,
which is pretty much an ARMv4 device, except its bus will choke on the
half-words. The way to make the C compiler not output ldrh/strh is with
-march=armv3, which doesn't support them in the ISA. However, this
prevents certain cryptography code from working that uses instructions
like umull. Fortunately there's also -march=armv3m that does support
those, making it possible to continue assembling optimized cryptography
routines for our beloved RiscPC.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index d1516f85f25d..7fd4bcaf0721 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -74,7 +74,7 @@ endif
 arch-$(CONFIG_CPU_32v5)		=-D__LINUX_ARM_ARCH__=5 $(call cc-option,-march=armv5te,-march=armv4t)
 arch-$(CONFIG_CPU_32v4T)	=-D__LINUX_ARM_ARCH__=4 -march=armv4t
 arch-$(CONFIG_CPU_32v4)		=-D__LINUX_ARM_ARCH__=4 -march=armv4
-arch-$(CONFIG_CPU_32v3)		=-D__LINUX_ARM_ARCH__=3 -march=armv3
+arch-$(CONFIG_CPU_32v3)		=-D__LINUX_ARM_ARCH__=3 -march=armv3m
 
 # Evaluate arch cc-option calls now
 arch-y := $(arch-y)
-- 
2.19.0

