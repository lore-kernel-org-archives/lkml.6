Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06318C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CEAD20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CEAD20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbeIJRHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:07:02 -0400
Received: from shell.v3.sk ([90.176.6.54]:36176 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727649AbeIJRHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:07:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A815CB81C1;
        Mon, 10 Sep 2018 14:13:13 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Xszom_vesaKN; Mon, 10 Sep 2018 14:13:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 369EFB8228;
        Mon, 10 Sep 2018 14:13:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SA-6GENVX_FK; Mon, 10 Sep 2018 14:13:10 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 86C72B81C1;
        Mon, 10 Sep 2018 14:13:10 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] irqchip/mmp: use cpu_is_pj4() instead of CONFIG_CPU_MMP2
Date:   Mon, 10 Sep 2018 14:13:06 +0200
Message-Id: <20180910121306.168536-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_CPU_MMP2 is not there on multiplatform kernels with MACH_MMP2_DT.
The MMP2 platform uses the PJ4 CPU.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/irqchip/irq-mmp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index 25f32e1d7764..10aa2b553145 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -22,6 +22,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 
+#include <asm/cputype.h>
 #include <asm/exception.h>
 #include <asm/hardirq.h>
 
@@ -74,11 +75,11 @@ static void icu_mask_ack_irq(struct irq_data *d)
 		r |= data->conf_disable;
 		writel_relaxed(r, mmp_icu_base + (hwirq << 2));
 	} else {
-#ifdef CONFIG_CPU_MMP2
-		if ((data->virq_base == data->clr_mfp_irq_base)
-			&& (hwirq == data->clr_mfp_hwirq))
-			mmp2_clear_pmic_int();
-#endif
+		if (cpu_is_pj4()) {
+			if ((data->virq_base == data->clr_mfp_irq_base)
+				&& (hwirq == data->clr_mfp_hwirq))
+				mmp2_clear_pmic_int();
+		}
 		r = readl_relaxed(data->reg_mask) | (1 << hwirq);
 		writel_relaxed(r, data->reg_mask);
 	}
-- 
2.17.1

