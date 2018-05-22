Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751672AbeEVJoU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 05:44:20 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49700 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751391AbeEVJk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
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
Subject: [PATCH v2 07/16] irqchip/irq-mvebu-icu: disociate ICU and NSR
Date: Tue, 22 May 2018 11:40:33 +0200
Message-Id: <20180522094042.24770-8-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180522094042.24770-1-miquel.raynal@bootlin.com>
References: <20180522094042.24770-1-miquel.raynal@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NSR (non-secure interrupts) are handled in the ICU driver like if there
was only this type of interrupt in the ICU. Change this behavior to
prepare the introduction of SEI (System Error Interrupts) support by
moving the NSR code in a separate function. This is done under the form
of a 'probe' function to ease future migration to NSR/SEI being platform
devices part of the ICU.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/irqchip/irq-mvebu-icu.c | 58 +++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index 607948870a14..24d45186eb6b 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -205,6 +205,37 @@ static const struct irq_domain_ops mvebu_icu_domain_ops = {
 	.free      = mvebu_icu_irq_domain_free,
 };
 
+static int mvebu_icu_subset_probe(struct platform_device *pdev)
+{
+	struct device_node *msi_parent_dn;
+	struct irq_domain *irq_domain;
+	struct mvebu_icu *icu;
+
+	icu = dev_get_drvdata(&pdev->dev);
+	if (!icu)
+		return -ENODEV;
+
+	pdev->dev.msi_domain = of_msi_get_domain(&pdev->dev, pdev->dev.of_node,
+						 DOMAIN_BUS_PLATFORM_MSI);
+	if (!pdev->dev.msi_domain)
+		return -EPROBE_DEFER;
+
+	msi_parent_dn = irq_domain_get_of_node(pdev->dev.msi_domain);
+	if (!msi_parent_dn)
+		return -ENODEV;
+
+	irq_domain = platform_msi_create_device_domain(&pdev->dev, ICU_MAX_IRQS,
+						       mvebu_icu_write_msg,
+						       &mvebu_icu_domain_ops,
+						       icu);
+	if (!irq_domain) {
+		dev_err(&pdev->dev, "Failed to create ICU MSI domain\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 static struct regmap_config mvebu_icu_regmap_config = {
 	.reg_bits	= 32,
 	.val_bits	= 32,
@@ -215,9 +246,6 @@ static struct regmap_config mvebu_icu_regmap_config = {
 static int mvebu_icu_probe(struct platform_device *pdev)
 {
 	struct mvebu_icu *icu;
-	struct device_node *node = pdev->dev.of_node;
-	struct device_node *gicp_dn;
-	struct irq_domain *irq_domain;
 	struct resource *res;
 	void __iomem *regs;
 	int i;
@@ -255,19 +283,6 @@ static int mvebu_icu_probe(struct platform_device *pdev)
 	icu->irq_chip.irq_set_affinity = irq_chip_set_affinity_parent;
 #endif
 
-	/*
-	 * We're probed after MSI domains have been resolved, so force
-	 * resolution here.
-	 */
-	pdev->dev.msi_domain = of_msi_get_domain(&pdev->dev, node,
-						 DOMAIN_BUS_PLATFORM_MSI);
-	if (!pdev->dev.msi_domain)
-		return -EPROBE_DEFER;
-
-	gicp_dn = irq_domain_get_of_node(pdev->dev.msi_domain);
-	if (!gicp_dn)
-		return -ENODEV;
-
 	/*
 	 * Clean all ICU interrupts with type SPI_NSR, required to
 	 * avoid unpredictable SPI assignments done by firmware.
@@ -282,16 +297,9 @@ static int mvebu_icu_probe(struct platform_device *pdev)
 			regmap_write(icu->regmap, ICU_INT_CFG(i), 0);
 	}
 
-	irq_domain =
-		platform_msi_create_device_domain(&pdev->dev, ICU_MAX_IRQS,
-						  mvebu_icu_write_msg,
-						  &mvebu_icu_domain_ops, icu);
-	if (!irq_domain) {
-		dev_err(&pdev->dev, "Failed to create ICU domain\n");
-		return -ENOMEM;
-	}
+	platform_set_drvdata(pdev, icu);
 
-	return 0;
+	return mvebu_icu_subset_probe(pdev);
 }
 
 static const struct of_device_id mvebu_icu_of_match[] = {
-- 
2.14.1
