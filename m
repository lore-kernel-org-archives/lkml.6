Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbeEVJoB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 05:44:01 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49703 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751404AbeEVJk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 05:40:59 -0400
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
Subject: [PATCH v2 08/16] irqchip/irq-mvebu-icu: support ICU subnodes
Date: Tue, 22 May 2018 11:40:34 +0200
Message-Id: <20180522094042.24770-9-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180522094042.24770-1-miquel.raynal@bootlin.com>
References: <20180522094042.24770-1-miquel.raynal@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ICU can handle several type of interrupt, each of them being handled
differently on AP side. On CP side, the ICU should be able to make the
distinction between each interrupt group by pointing to the right parent.

This is done through the introduction of new bindings, presenting the ICU
node as the parent of multiple ICU sub-nodes, each of them being an
interrupt type with a different interrupt parent. ICU interrupt 'clients'
now directly point to the right sub-node, avoiding the need for the extra
ICU_GRP_* parameter.

ICU subnodes are probed automatically with devm_platform_populate(). If
the node as no child, the probe function for NSRs will still be called
'manually' in order to preserve backward compatibility with DT using the
old binding.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/irqchip/irq-mvebu-icu.c | 90 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 75 insertions(+), 15 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index 24d45186eb6b..977e47b2716f 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -43,6 +43,7 @@ struct mvebu_icu {
 	struct regmap *regmap;
 	struct device *dev;
 	atomic_t initialized;
+	bool legacy_bindings;
 };
 
 struct mvebu_icu_irq_data {
@@ -51,6 +52,30 @@ struct mvebu_icu_irq_data {
 	unsigned int type;
 };
 
+static struct mvebu_icu *mvebu_icu_dev_get_drvdata(struct platform_device *pdev)
+{
+	struct mvebu_icu *icu;
+
+	/*
+	 * Device data being populated means we should be using legacy bindings.
+	 * Using the _parent_ device data means we should be using new bindings.
+	 */
+	icu = dev_get_drvdata(&pdev->dev);
+	if (icu) {
+		if (!icu->legacy_bindings)
+			return ERR_PTR(-EINVAL);
+	} else {
+		icu = dev_get_drvdata(pdev->dev.parent);
+		if (!icu)
+			return ERR_PTR(-ENODEV);
+
+		if (icu->legacy_bindings)
+			return ERR_PTR(-EINVAL);
+	}
+
+	return icu;
+}
+
 static void mvebu_icu_init(struct mvebu_icu *icu, struct msi_msg *msg)
 {
 	if (atomic_cmpxchg(&icu->initialized, false, true))
@@ -107,31 +132,35 @@ mvebu_icu_irq_domain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
 			       unsigned long *hwirq, unsigned int *type)
 {
 	struct mvebu_icu *icu = platform_msi_get_host_data(d);
-	unsigned int icu_group;
+	unsigned int param_count = icu->legacy_bindings ? 3 : 2;
 
 	/* Check the count of the parameters in dt */
-	if (WARN_ON(fwspec->param_count < 3)) {
+	if (WARN_ON(fwspec->param_count != param_count)) {
 		dev_err(icu->dev, "wrong ICU parameter count %d\n",
 			fwspec->param_count);
 		return -EINVAL;
 	}
 
-	/* Only ICU group type is handled */
-	icu_group = fwspec->param[0];
-	if (icu_group != ICU_GRP_NSR && icu_group != ICU_GRP_SR &&
-	    icu_group != ICU_GRP_SEI && icu_group != ICU_GRP_REI) {
-		dev_err(icu->dev, "wrong ICU group type %x\n", icu_group);
-		return -EINVAL;
+	if (icu->legacy_bindings) {
+		*hwirq = fwspec->param[1];
+		*type = fwspec->param[2];
+		if (fwspec->param[0] != ICU_GRP_NSR) {
+			dev_err(icu->dev, "wrong ICU group type %x\n",
+				fwspec->param[0]);
+			return -EINVAL;
+		}
+	} else {
+		*hwirq = fwspec->param[0];
+		*type = fwspec->param[1];
 	}
 
-	*hwirq = fwspec->param[1];
 	if (*hwirq >= ICU_MAX_IRQS) {
 		dev_err(icu->dev, "invalid interrupt number %ld\n", *hwirq);
 		return -EINVAL;
 	}
 
 	/* Mask the type to prevent wrong DT configuration */
-	*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
+	*type &= IRQ_TYPE_SENSE_MASK;
 
 	return 0;
 }
@@ -157,7 +186,10 @@ mvebu_icu_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 		goto free_irqd;
 	}
 
-	icu_irqd->icu_group = fwspec->param[0];
+	if (icu->legacy_bindings)
+		icu_irqd->icu_group = fwspec->param[0];
+	else
+		icu_irqd->icu_group = ICU_GRP_NSR;
 	icu_irqd->icu = icu;
 
 	err = platform_msi_domain_alloc(domain, virq, nr_irqs);
@@ -211,9 +243,9 @@ static int mvebu_icu_subset_probe(struct platform_device *pdev)
 	struct irq_domain *irq_domain;
 	struct mvebu_icu *icu;
 
-	icu = dev_get_drvdata(&pdev->dev);
-	if (!icu)
-		return -ENODEV;
+	icu = mvebu_icu_dev_get_drvdata(pdev);
+	if (IS_ERR(icu))
+		return PTR_ERR(icu);
 
 	pdev->dev.msi_domain = of_msi_get_domain(&pdev->dev, pdev->dev.of_node,
 						 DOMAIN_BUS_PLATFORM_MSI);
@@ -236,6 +268,22 @@ static int mvebu_icu_subset_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id mvebu_icu_subset_of_match[] = {
+	{
+		.compatible = "marvell,cp110-icu-nsr",
+	},
+	{},
+};
+
+static struct platform_driver mvebu_icu_subset_driver = {
+	.probe  = mvebu_icu_subset_probe,
+	.driver = {
+		.name = "mvebu-icu-subset",
+		.of_match_table = mvebu_icu_subset_of_match,
+	},
+};
+builtin_platform_driver(mvebu_icu_subset_driver);
+
 static struct regmap_config mvebu_icu_regmap_config = {
 	.reg_bits	= 32,
 	.val_bits	= 32,
@@ -275,6 +323,15 @@ static int mvebu_icu_probe(struct platform_device *pdev)
 	if (!icu->irq_chip.name)
 		return -ENOMEM;
 
+	/*
+	 * Legacy bindings: ICU is one node with one MSI parent: force manually
+	 *                  the probe of the NSR interrupts side.
+	 * New bindings: ICU node has children, one per interrupt controller
+	 *               having its own MSI parent: call platform_populate().
+	 */
+	if (!of_get_child_count(pdev->dev.of_node))
+		icu->legacy_bindings = true;
+
 	icu->irq_chip.irq_mask = irq_chip_mask_parent;
 	icu->irq_chip.irq_unmask = irq_chip_unmask_parent;
 	icu->irq_chip.irq_eoi = irq_chip_eoi_parent;
@@ -299,7 +356,10 @@ static int mvebu_icu_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, icu);
 
-	return mvebu_icu_subset_probe(pdev);
+	if (icu->legacy_bindings)
+		return mvebu_icu_subset_probe(pdev);
+	else
+		return devm_of_platform_populate(&pdev->dev);
 }
 
 static const struct of_device_id mvebu_icu_of_match[] = {
-- 
2.14.1
