Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeEVJoi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 05:44:38 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49694 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751371AbeEVJk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 05:40:58 -0400
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>, Haim Boot <hayim@marvell.com>,
        Hanna Hawa <hannah@marvell.com>, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 05/16] irqchip/irq-mvebu-icu: switch to regmap
Date: Tue, 22 May 2018 11:40:31 +0200
Message-Id: <20180522094042.24770-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180522094042.24770-1-miquel.raynal@bootlin.com>
References: <20180522094042.24770-1-miquel.raynal@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before splitting the code to support multiple platform devices to
be probed (one for the ICU, one per interrupt group), let's switch to
regmap first by creating one in the ->probe().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/irqchip/irq-mvebu-icu.c | 45 +++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index 0f2655d7f19e..3694c0d73c0d 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -18,6 +18,8 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
 
 #include <dt-bindings/interrupt-controller/mvebu-icu.h>
 
@@ -38,7 +40,7 @@
 
 struct mvebu_icu {
 	struct irq_chip irq_chip;
-	void __iomem *base;
+	struct regmap *regmap;
 	struct irq_domain *domain;
 	struct device *dev;
 	atomic_t initialized;
@@ -56,10 +58,10 @@ static void mvebu_icu_init(struct mvebu_icu *icu, struct msi_msg *msg)
 		return;
 
 	/* Set Clear/Set ICU SPI message address in AP */
-	writel_relaxed(msg[0].address_hi, icu->base + ICU_SETSPI_NSR_AH);
-	writel_relaxed(msg[0].address_lo, icu->base + ICU_SETSPI_NSR_AL);
-	writel_relaxed(msg[1].address_hi, icu->base + ICU_CLRSPI_NSR_AH);
-	writel_relaxed(msg[1].address_lo, icu->base + ICU_CLRSPI_NSR_AL);
+	regmap_write(icu->regmap, ICU_SETSPI_NSR_AH, msg[0].address_hi);
+	regmap_write(icu->regmap, ICU_SETSPI_NSR_AL, msg[0].address_lo);
+	regmap_write(icu->regmap, ICU_CLRSPI_NSR_AH, msg[1].address_hi);
+	regmap_write(icu->regmap, ICU_CLRSPI_NSR_AL, msg[1].address_lo);
 }
 
 static void mvebu_icu_write_msg(struct msi_desc *desc, struct msi_msg *msg)
@@ -82,7 +84,7 @@ static void mvebu_icu_write_msg(struct msi_desc *desc, struct msi_msg *msg)
 		icu_int = 0;
 	}
 
-	writel_relaxed(icu_int, icu->base + ICU_INT_CFG(d->hwirq));
+	regmap_write(icu->regmap, ICU_INT_CFG(d->hwirq), icu_int);
 
 	/*
 	 * The SATA unit has 2 ports, and a dedicated ICU entry per
@@ -94,10 +96,10 @@ static void mvebu_icu_write_msg(struct msi_desc *desc, struct msi_msg *msg)
 	 * configured (regardless of which port is actually in use).
 	 */
 	if (d->hwirq == ICU_SATA0_ICU_ID || d->hwirq == ICU_SATA1_ICU_ID) {
-		writel_relaxed(icu_int,
-			       icu->base + ICU_INT_CFG(ICU_SATA0_ICU_ID));
-		writel_relaxed(icu_int,
-			       icu->base + ICU_INT_CFG(ICU_SATA1_ICU_ID));
+		regmap_write(icu->regmap, ICU_INT_CFG(ICU_SATA0_ICU_ID),
+			     icu_int);
+		regmap_write(icu->regmap, ICU_INT_CFG(ICU_SATA1_ICU_ID),
+			     icu_int);
 	}
 }
 
@@ -204,12 +206,20 @@ static const struct irq_domain_ops mvebu_icu_domain_ops = {
 	.free      = mvebu_icu_irq_domain_free,
 };
 
+static struct regmap_config mvebu_icu_regmap_config = {
+	.reg_bits	= 32,
+	.val_bits	= 32,
+	.reg_stride	= 4,
+	.name		= "mvebu_icu",
+};
+
 static int mvebu_icu_probe(struct platform_device *pdev)
 {
 	struct mvebu_icu *icu;
 	struct device_node *node = pdev->dev.of_node;
 	struct device_node *gicp_dn;
 	struct resource *res;
+	void __iomem *regs;
 	int i;
 
 	icu = devm_kzalloc(&pdev->dev, sizeof(struct mvebu_icu),
@@ -220,12 +230,17 @@ static int mvebu_icu_probe(struct platform_device *pdev)
 	icu->dev = &pdev->dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	icu->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(icu->base)) {
+	regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(regs)) {
 		dev_err(&pdev->dev, "Failed to map icu base address.\n");
-		return PTR_ERR(icu->base);
+		return PTR_ERR(regs);
 	}
 
+	icu->regmap = devm_regmap_init_mmio(icu->dev, regs,
+					    &mvebu_icu_regmap_config);
+	if (IS_ERR(icu->regmap))
+		return PTR_ERR(icu->regmap);
+
 	icu->irq_chip.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
 					    "ICU.%x",
 					    (unsigned int)res->start);
@@ -260,11 +275,11 @@ static int mvebu_icu_probe(struct platform_device *pdev)
 	for (i = 0 ; i < ICU_MAX_IRQS ; i++) {
 		u32 icu_int, icu_grp;
 
-		icu_int = readl_relaxed(icu->base + ICU_INT_CFG(i));
+		regmap_read(icu->regmap, ICU_INT_CFG(i), &icu_int);
 		icu_grp = icu_int >> ICU_GROUP_SHIFT;
 
 		if (icu_grp == ICU_GRP_NSR)
-			writel_relaxed(0x0, icu->base + ICU_INT_CFG(i));
+			regmap_write(icu->regmap, ICU_INT_CFG(i), 0);
 	}
 
 	icu->domain =
-- 
2.14.1
