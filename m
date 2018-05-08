Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932117AbeEHMPI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 08:15:08 -0400
Received: from foss.arm.com ([217.140.101.70]:57514 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932082AbeEHMPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 08:15:05 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/9] irqchip/mvebu-gicp: Use level-triggered MSIs between ICU and GICP
Date: Tue,  8 May 2018 13:14:32 +0100
Message-Id: <20180508121438.11301-4-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180508121438.11301-1-marc.zyngier@arm.com>
References: <20180508121438.11301-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ICU and GICP drivers are using an ugly side-band mechanism to
find out about the "clear" doorbell when using level interrupts.

Let's convert it to level-triggered MSIs, which result in a nice
cleanup.

Tested-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-mvebu-gicp.c | 38 +++++++++++---------------------------
 drivers/irqchip/irq-mvebu-gicp.h | 12 ------------
 drivers/irqchip/irq-mvebu-icu.c  | 33 +++++++++++++++++----------------
 3 files changed, 28 insertions(+), 55 deletions(-)
 delete mode 100644 drivers/irqchip/irq-mvebu-gicp.h

diff --git a/drivers/irqchip/irq-mvebu-gicp.c b/drivers/irqchip/irq-mvebu-gicp.c
index 17a4a7b6cdbb..4e17f7081efc 100644
--- a/drivers/irqchip/irq-mvebu-gicp.c
+++ b/drivers/irqchip/irq-mvebu-gicp.c
@@ -19,8 +19,6 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
-#include "irq-mvebu-gicp.h"
-
 #define GICP_SETSPI_NSR_OFFSET	0x0
 #define GICP_CLRSPI_NSR_OFFSET	0x8
 
@@ -55,34 +53,18 @@ static int gicp_idx_to_spi(struct mvebu_gicp *gicp, int idx)
 	return -EINVAL;
 }
 
-int mvebu_gicp_get_doorbells(struct device_node *dn, phys_addr_t *setspi,
-			     phys_addr_t *clrspi)
-{
-	struct platform_device *pdev;
-	struct mvebu_gicp *gicp;
-
-	pdev = of_find_device_by_node(dn);
-	if (!pdev)
-		return -ENODEV;
-
-	gicp = platform_get_drvdata(pdev);
-	if (!gicp)
-		return -ENODEV;
-
-	*setspi = gicp->res->start + GICP_SETSPI_NSR_OFFSET;
-	*clrspi = gicp->res->start + GICP_CLRSPI_NSR_OFFSET;
-
-	return 0;
-}
-
 static void gicp_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	struct mvebu_gicp *gicp = data->chip_data;
 	phys_addr_t setspi = gicp->res->start + GICP_SETSPI_NSR_OFFSET;
-
-	msg->data = data->hwirq;
-	msg->address_lo = lower_32_bits(setspi);
-	msg->address_hi = upper_32_bits(setspi);
+	phys_addr_t clrspi = gicp->res->start + GICP_CLRSPI_NSR_OFFSET;
+
+	msg[0].data = data->hwirq;
+	msg[0].address_lo = lower_32_bits(setspi);
+	msg[0].address_hi = upper_32_bits(setspi);
+	msg[1].data = data->hwirq;
+	msg[1].address_lo = lower_32_bits(clrspi);
+	msg[1].address_hi = upper_32_bits(clrspi);
 }
 
 static struct irq_chip gicp_irq_chip = {
@@ -170,13 +152,15 @@ static const struct irq_domain_ops gicp_domain_ops = {
 static struct irq_chip gicp_msi_irq_chip = {
 	.name		= "GICP",
 	.irq_set_type	= irq_chip_set_type_parent,
+	.flags		= IRQCHIP_SUPPORTS_LEVEL_MSI,
 };
 
 static struct msi_domain_ops gicp_msi_ops = {
 };
 
 static struct msi_domain_info gicp_msi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		   MSI_FLAG_LEVEL_CAPABLE),
 	.ops	= &gicp_msi_ops,
 	.chip	= &gicp_msi_irq_chip,
 };
diff --git a/drivers/irqchip/irq-mvebu-gicp.h b/drivers/irqchip/irq-mvebu-gicp.h
deleted file mode 100644
index eaa12fb72102..000000000000
--- a/drivers/irqchip/irq-mvebu-gicp.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __MVEBU_GICP_H__
-#define __MVEBU_GICP_H__
-
-#include <linux/types.h>
-
-struct device_node;
-
-int mvebu_gicp_get_doorbells(struct device_node *dn, phys_addr_t *setspi,
-			     phys_addr_t *clrspi);
-
-#endif /* __MVEBU_GICP_H__ */
diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index e18c48d3a92e..13063339b416 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -21,8 +21,6 @@
 
 #include <dt-bindings/interrupt-controller/mvebu-icu.h>
 
-#include "irq-mvebu-gicp.h"
-
 /* ICU registers */
 #define ICU_SETSPI_NSR_AL	0x10
 #define ICU_SETSPI_NSR_AH	0x14
@@ -43,6 +41,7 @@ struct mvebu_icu {
 	void __iomem *base;
 	struct irq_domain *domain;
 	struct device *dev;
+	atomic_t initialized;
 };
 
 struct mvebu_icu_irq_data {
@@ -51,6 +50,18 @@ struct mvebu_icu_irq_data {
 	unsigned int type;
 };
 
+static void mvebu_icu_init(struct mvebu_icu *icu, struct msi_msg *msg)
+{
+	if (atomic_cmpxchg(&icu->initialized, false, true))
+		return;
+
+	/* Set Clear/Set ICU SPI message address in AP */
+	writel_relaxed(msg[0].address_hi, icu->base + ICU_SETSPI_NSR_AH);
+	writel_relaxed(msg[0].address_lo, icu->base + ICU_SETSPI_NSR_AL);
+	writel_relaxed(msg[1].address_hi, icu->base + ICU_CLRSPI_NSR_AH);
+	writel_relaxed(msg[1].address_lo, icu->base + ICU_CLRSPI_NSR_AL);
+}
+
 static void mvebu_icu_write_msg(struct msi_desc *desc, struct msi_msg *msg)
 {
 	struct irq_data *d = irq_get_irq_data(desc->irq);
@@ -59,6 +70,8 @@ static void mvebu_icu_write_msg(struct msi_desc *desc, struct msi_msg *msg)
 	unsigned int icu_int;
 
 	if (msg->address_lo || msg->address_hi) {
+		/* One off initialization */
+		mvebu_icu_init(icu, msg);
 		/* Configure the ICU with irq number & type */
 		icu_int = msg->data | ICU_INT_ENABLE;
 		if (icu_irqd->type & IRQ_TYPE_EDGE_RISING)
@@ -197,9 +210,7 @@ static int mvebu_icu_probe(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	struct device_node *gicp_dn;
 	struct resource *res;
-	phys_addr_t setspi, clrspi;
-	u32 i, icu_int;
-	int ret;
+	int i;
 
 	icu = devm_kzalloc(&pdev->dev, sizeof(struct mvebu_icu),
 			   GFP_KERNEL);
@@ -242,22 +253,12 @@ static int mvebu_icu_probe(struct platform_device *pdev)
 	if (!gicp_dn)
 		return -ENODEV;
 
-	ret = mvebu_gicp_get_doorbells(gicp_dn, &setspi, &clrspi);
-	if (ret)
-		return ret;
-
-	/* Set Clear/Set ICU SPI message address in AP */
-	writel_relaxed(upper_32_bits(setspi), icu->base + ICU_SETSPI_NSR_AH);
-	writel_relaxed(lower_32_bits(setspi), icu->base + ICU_SETSPI_NSR_AL);
-	writel_relaxed(upper_32_bits(clrspi), icu->base + ICU_CLRSPI_NSR_AH);
-	writel_relaxed(lower_32_bits(clrspi), icu->base + ICU_CLRSPI_NSR_AL);
-
 	/*
 	 * Clean all ICU interrupts with type SPI_NSR, required to
 	 * avoid unpredictable SPI assignments done by firmware.
 	 */
 	for (i = 0 ; i < ICU_MAX_IRQS ; i++) {
-		icu_int = readl(icu->base + ICU_INT_CFG(i));
+		u32 icu_int = readl_relaxed(icu->base + ICU_INT_CFG(i));
 		if ((icu_int >> ICU_GROUP_SHIFT) == ICU_GRP_NSR)
 			writel_relaxed(0x0, icu->base + ICU_INT_CFG(i));
 	}
-- 
2.14.2
