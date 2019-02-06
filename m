Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510A9C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185FF217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbfBFKtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:49:10 -0500
Received: from foss.arm.com ([217.140.101.70]:51306 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbfBFKtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:49:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F0EBA78;
        Wed,  6 Feb 2019 02:49:06 -0800 (PST)
Received: from big-swifty.cambridge.arm.com (big-swifty.cambridge.arm.com [10.1.30.189])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA3F13F719;
        Wed,  6 Feb 2019 02:49:03 -0800 (PST)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Heyi Guo <guoheyi@huawei.com>, Heyi Guo <heyi.guo@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>, Pavel Machek <pavel@ucw.cz>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Zheng Xiang <zhengxiang9@huawei.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] irqchip/mmp: Only touch the PJ4 IRQ & FIQ bits on enable/disable
Date:   Wed,  6 Feb 2019 10:48:47 +0000
Message-Id: <20190206104848.12580-5-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206104848.12580-1-marc.zyngier@arm.com>
References: <20190206104848.12580-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lubomir Rintel <lkundrak@v3.sk>

Resetting bit 4 disables the interrupt delivery to the "secure
processor" core. This breaks the keyboard on a OLPC XO 1.75 laptop,
where the firmware running on the "secure processor" bit-bangs the
PS/2 protocol over the GPIO lines.

It is not clear what the rest of the bits are and Marvell was unhelpful
when asked for documentation. Aside from the SP bit, there are probably
priority bits.

Leaving the unknown bits as the firmware set them up seems to be a wiser
course of action compared to just turning them off.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>
[maz: fixed-up subject and commit message]
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-mmp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index 25f32e1d7764..3496b61a312a 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -34,6 +34,9 @@
 #define SEL_INT_PENDING		(1 << 6)
 #define SEL_INT_NUM_MASK	0x3f
 
+#define MMP2_ICU_INT_ROUTE_PJ4_IRQ	(1 << 5)
+#define MMP2_ICU_INT_ROUTE_PJ4_FIQ	(1 << 6)
+
 struct icu_chip_data {
 	int			nr_irqs;
 	unsigned int		virq_base;
@@ -190,7 +193,8 @@ static const struct mmp_intc_conf mmp_conf = {
 static const struct mmp_intc_conf mmp2_conf = {
 	.conf_enable	= 0x20,
 	.conf_disable	= 0x0,
-	.conf_mask	= 0x7f,
+	.conf_mask	= MMP2_ICU_INT_ROUTE_PJ4_IRQ |
+			  MMP2_ICU_INT_ROUTE_PJ4_FIQ,
 };
 
 static void __exception_irq_entry mmp_handle_irq(struct pt_regs *regs)
-- 
2.20.1

