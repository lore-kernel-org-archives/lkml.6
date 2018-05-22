Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeEVJoe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 05:44:34 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49698 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751351AbeEVJk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
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
Subject: [PATCH v2 06/16] irqchip/irq-mvebu-icu: make irq_domain local
Date: Tue, 22 May 2018 11:40:32 +0200
Message-Id: <20180522094042.24770-7-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180522094042.24770-1-miquel.raynal@bootlin.com>
References: <20180522094042.24770-1-miquel.raynal@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the current MSI irq_domain local to ease the split between ICU
platform device code and NSR platform device code.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/irqchip/irq-mvebu-icu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index 3694c0d73c0d..607948870a14 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -41,7 +41,6 @@
 struct mvebu_icu {
 	struct irq_chip irq_chip;
 	struct regmap *regmap;
-	struct irq_domain *domain;
 	struct device *dev;
 	atomic_t initialized;
 };
@@ -218,6 +217,7 @@ static int mvebu_icu_probe(struct platform_device *pdev)
 	struct mvebu_icu *icu;
 	struct device_node *node = pdev->dev.of_node;
 	struct device_node *gicp_dn;
+	struct irq_domain *irq_domain;
 	struct resource *res;
 	void __iomem *regs;
 	int i;
@@ -282,11 +282,11 @@ static int mvebu_icu_probe(struct platform_device *pdev)
 			regmap_write(icu->regmap, ICU_INT_CFG(i), 0);
 	}
 
-	icu->domain =
+	irq_domain =
 		platform_msi_create_device_domain(&pdev->dev, ICU_MAX_IRQS,
 						  mvebu_icu_write_msg,
 						  &mvebu_icu_domain_ops, icu);
-	if (!icu->domain) {
+	if (!irq_domain) {
 		dev_err(&pdev->dev, "Failed to create ICU domain\n");
 		return -ENOMEM;
 	}
-- 
2.14.1
