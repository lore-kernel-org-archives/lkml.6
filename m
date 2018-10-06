Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44F8C65BD0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 02:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF402075C
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 02:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="IM8XeCP6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF402075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbeJFJ7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 05:59:05 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:50073 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbeJFJ7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 05:59:04 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 2709d65b;
        Sat, 6 Oct 2018 02:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=mail; bh=cz3qBitK9lcOU4T8Q4EPHXFd1
        i8=; b=IM8XeCP63ziJoUPJuWwoJbqP94slpXYS2c6P4c5xfgLrzZdB0q0rqc7lc
        d34yjklFn4PFxbUUdoBLplyOcFc+V4qnf4S7rylzBOtZ4UYSPy8Ebm8ZUmXAQBNc
        1oF0EceoYREejc2QNh9b1xALPVJIvi/3ukOMSXayaqAX54MYmEG9s77iymom8Psm
        HsHsUEHxixcNpSK5Wa+2IUUVrxH7cUxT9SSUBgDRxj+Tig4kdTMlb7w2SRYosZRi
        T0y2KyNe2NfoOjlNb/xSsvAbYC8w1VlTz8NevispwrmYMzcKCD9XZfOmWYsk/9GL
        W2jGlU+okoH3ykqs+2iAgYsW3xeAQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4bdb2774 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Sat, 6 Oct 2018 02:57:00 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net-next v7 01/28] ARM: makefile: use ARMv3M mode for RiscPC
Date:   Sat,  6 Oct 2018 04:56:42 +0200
Message-Id: <20181006025709.4019-2-Jason@zx2c4.com>
In-Reply-To: <20181006025709.4019-1-Jason@zx2c4.com>
References: <20181006025709.4019-1-Jason@zx2c4.com>
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
2.19.0

