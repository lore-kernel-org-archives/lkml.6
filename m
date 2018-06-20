Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2FEC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE79D20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:53:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE79D20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754410AbeFTNxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:53:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37528 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754345AbeFTNxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:53:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA38480D;
        Wed, 20 Jun 2018 06:53:36 -0700 (PDT)
Received: from big-swifty.cambridge.arm.com (big-swifty.cambridge.arm.com [10.1.31.224])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 969333F578;
        Wed, 20 Jun 2018 06:53:30 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Shanker Donthineni <shankerd@codeaurora.org>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        MaJun <majun258@huawei.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Lei Zhang <zhang.lei@jp.fujitsu.com>
Subject: [PATCH 5/7] irqchip/gic-v3: Expose GICD_TYPER in the rdist structure
Date:   Wed, 20 Jun 2018 14:52:32 +0100
Message-Id: <20180620135234.32101-6-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620135234.32101-1-marc.zyngier@arm.com>
References: <20180620135234.32101-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of exposing the GIC distributor IntID field in the rdist
structure that is passed to the ITS, let's replace it with a
copy of the whole GICD_TYPER register. We are going to need
some of this information at a later time.

No functionnal change.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c   | 2 +-
 drivers/irqchip/irq-gic-v3.c       | 4 ++--
 include/linux/irqchip/arm-gic-v3.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 554c9d040c5a..8c7e8c235faf 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1600,7 +1600,7 @@ static int __init its_alloc_lpi_tables(void)
 {
 	phys_addr_t paddr;
 
-	lpi_id_bits = gic_rdists->id_bits;
+	lpi_id_bits = GICD_TYPER_ID_BITS(gic_rdists->gicd_typer);
 	gic_rdists->prop_page = its_allocate_prop_table(GFP_NOWAIT);
 	if (!gic_rdists->prop_page) {
 		pr_err("Failed to allocate PROPBASE\n");
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 76ea56d779a1..e214181b77b7 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -877,7 +877,7 @@ static struct irq_chip gic_eoimode1_chip = {
 	.flags			= IRQCHIP_SET_TYPE_MASKED,
 };
 
-#define GIC_ID_NR		(1U << gic_data.rdists.id_bits)
+#define GIC_ID_NR	(1U << GICD_TYPER_ID_BITS(gic_data.rdists.gicd_typer))
 
 static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 			      irq_hw_number_t hw)
@@ -1091,7 +1091,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	 * The GIC only supports up to 1020 interrupt sources (SGI+PPI+SPI)
 	 */
 	typer = readl_relaxed(gic_data.dist_base + GICD_TYPER);
-	gic_data.rdists.id_bits = GICD_TYPER_ID_BITS(typer);
+	gic_data.rdists.gicd_typer = typer;
 	gic_irqs = GICD_TYPER_IRQS(typer);
 	if (gic_irqs > 1020)
 		gic_irqs = 1020;
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index cbb872c1b607..396cd99af02f 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -576,8 +576,8 @@ struct rdists {
 		phys_addr_t	phys_base;
 	} __percpu		*rdist;
 	struct page		*prop_page;
-	int			id_bits;
 	u64			flags;
+	u32			gicd_typer;
 	bool			has_vlpis;
 	bool			has_direct_lpi;
 };
-- 
2.17.1

