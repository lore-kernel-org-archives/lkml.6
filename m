Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFFEC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EABD12083C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="lKcz7piI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EABD12083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbeHURJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 13:09:55 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:41658 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbeHURJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 13:09:55 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     od@zcrc.me, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] irq: ingenic: Drop dependency on MACH_INGENIC
Date:   Tue, 21 Aug 2018 15:49:36 +0200
Message-Id: <20180821134937.3637-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1534859379; bh=ejNANrIxYupLoLVARF1zDi0ZYC+DYVPFBEiKyadRUCI=; h=From:To:Cc:Subject:Date:Message-Id; b=lKcz7piI7IL9ILAJ6TTsPXafi73uDMtVIZrkEWXFErDUrJcXhr0f9nItvVhVPvmFXjcSlLp4yU6uxDJIiVnL+NP7+MpOOvczOtpOA0si9HtCAcIN6rEISYWFBFnMB/HL72cwRhHRQ7gATq6D/GMT91dryhNSDVj8c2+DmRfMkDo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on MACH_INGENIC prevent us from creating a generic kernel
that works on more than one MIPS board. Instead, we just depend on
MIPS being set.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/irqchip/Kconfig | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index e9233db16e03..04628af89b60 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -269,9 +269,13 @@ config MIPS_GIC
 	select MIPS_CM
 
 config INGENIC_IRQ
-	bool
-	depends on MACH_INGENIC
-	default y
+	bool "Ingenic JZ47xx IRQ controller"
+	depends on MIPS
+	default MACH_INGENIC
+	help
+	  Support the interrupt controller present on JZ47xx SoCs from Ingenic.
+
+	  If compiling for an Ingenic JZ47xx SoC, you want to say Y here.
 
 config RENESAS_H8300H_INTC
         bool
-- 
2.11.0

