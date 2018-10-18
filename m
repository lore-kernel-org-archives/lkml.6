Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA5DC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 943D02098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hfOcOwyA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 943D02098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbeJRW7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 18:59:00 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:46347 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726816AbeJRW67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 18:58:59 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 6f6b3f04;
        Thu, 18 Oct 2018 14:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=mail; bh=ONxB0XP9Yn5tIjT3u3An/COyc
        Jk=; b=hfOcOwyADrLvmwpMbP51DiNlBWlkKgpGQtXvU69aYhayNdsIa4ox25Q85
        UqeDmnPuNN0EcFzY42C/LRai22vpxyrI1JZlS36o+UDKnjizB+fmps2iobZifpIS
        vIf33HKMSTgAqpqUWoKYWl0E6ZcBnMHLMP5TdU4ToefcmdDqEFETRMsG7R928lwB
        qo8qeWz/r+dRmiYt6XQ5hxcTdwjWjCS2LAhKSe6HBfXfbZuvQ9GVGHp8ceT0Re3C
        bmFNePIhJi4PGClTu3HDRfMXXUxvPJB8I2LPG6NvBjJSDKvt96scvyVjiejokZyM
        AORh8kj+lJ9kWaVEdcrI3ItDhD0cg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a3718c39 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Thu, 18 Oct 2018 14:55:33 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-crypto@vger.kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net-next v8 01/28] ARM: makefile: use ARMv3M mode for RiscPC
Date:   Thu, 18 Oct 2018 16:56:45 +0200
Message-Id: <20181018145712.7538-2-Jason@zx2c4.com>
In-Reply-To: <20181018145712.7538-1-Jason@zx2c4.com>
References: <20181018145712.7538-1-Jason@zx2c4.com>
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
---

Notes:
    This commit has been submitted to the proper ARM tree and is working its
    way upstream. It's included in this series here so that kbuild 0-day bot
    doesn't get too nervous about RiscPC, but is already entering the tree
    through arm-next.

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
2.19.1

