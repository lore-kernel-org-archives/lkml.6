Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932170AbeDZQWJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 12:22:09 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52613 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756661AbeDZQTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 12:19:16 -0400
From: Ludovic Barre <ludovic.Barre@st.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald BAEZA <gerald.baeza@st.com>,
        Loic PALLARDY <loic.pallardy@st.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Ludovic Barre" <ludovic.barre@st.com>
Subject: [PATCH 05/11] irqchip: stm32: add host and driver data structures
Date: Thu, 26 Apr 2018 18:18:28 +0200
Message-ID: <1524759514-12392-6-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524759514-12392-1-git-send-email-ludovic.Barre@st.com>
References: <1524759514-12392-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-26_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds host and driver data structures to support
different stm32 exti controllers with variants.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/irqchip/irq-stm32-exti.c | 152 ++++++++++++++++++++++++++-------------
 1 file changed, 104 insertions(+), 48 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 1e09667..9655a57 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -29,13 +29,23 @@ struct stm32_exti_bank {
 
 #define UNDEF_REG ~0
 
+struct stm32_exti_drv_data {
+	const struct stm32_exti_bank **exti_banks;
+	u32 bank_nr;
+};
+
 struct stm32_exti_chip_data {
+	struct stm32_exti_host_data *host_data;
 	const struct stm32_exti_bank *reg_bank;
 	u32 rtsr_cache;
 	u32 ftsr_cache;
 };
 
-static struct stm32_exti_chip_data *stm32_exti_data;
+struct stm32_exti_host_data {
+	void __iomem *base;
+	struct stm32_exti_chip_data *chips_data;
+	const struct stm32_exti_drv_data *drv_data;
+};
 
 static const struct stm32_exti_bank stm32f4xx_exti_b1 = {
 	.imr_ofst	= 0x00,
@@ -51,6 +61,11 @@ static const struct stm32_exti_bank *stm32f4xx_exti_banks[] = {
 	&stm32f4xx_exti_b1,
 };
 
+static const struct stm32_exti_drv_data stm32f4xx_drv_data = {
+	.exti_banks = stm32f4xx_exti_banks,
+	.bank_nr = ARRAY_SIZE(stm32f4xx_exti_banks),
+};
+
 static const struct stm32_exti_bank stm32h7xx_exti_b1 = {
 	.imr_ofst	= 0x80,
 	.emr_ofst	= 0x84,
@@ -87,6 +102,11 @@ static const struct stm32_exti_bank *stm32h7xx_exti_banks[] = {
 	&stm32h7xx_exti_b3,
 };
 
+static const struct stm32_exti_drv_data stm32h7xx_drv_data = {
+	.exti_banks = stm32h7xx_exti_banks,
+	.bank_nr = ARRAY_SIZE(stm32h7xx_exti_banks),
+};
+
 static unsigned long stm32_exti_pending(struct irq_chip_generic *gc)
 {
 	struct stm32_exti_chip_data *chip_data = gc->private;
@@ -237,29 +257,85 @@ static void stm32_irq_ack(struct irq_data *d)
 
 	irq_gc_unlock(gc);
 }
+static struct
+stm32_exti_host_data *stm32_exti_host_init(const struct stm32_exti_drv_data *dd,
+					   struct device_node *node)
+{
+	struct stm32_exti_host_data *host_data;
+
+	host_data = kzalloc(sizeof(*host_data), GFP_KERNEL);
+	if (!host_data)
+		return NULL;
+
+	host_data->drv_data = dd;
+	host_data->chips_data = kcalloc(dd->bank_nr,
+					sizeof(struct stm32_exti_chip_data),
+					GFP_KERNEL);
+	if (!host_data->chips_data)
+		return NULL;
+
+	host_data->base = of_iomap(node, 0);
+	if (!host_data->base) {
+		pr_err("%pOF: Unable to map registers\n", node);
+		return NULL;
+	}
 
-static int
-__init stm32_exti_init(const struct stm32_exti_bank **stm32_exti_banks,
-		       int bank_nr, struct device_node *node)
+	return host_data;
+}
+
+static struct
+stm32_exti_chip_data *stm32_exti_chip_init(struct stm32_exti_host_data *h_data,
+					   u32 bank_idx,
+					   struct device_node *node)
+{
+	const struct stm32_exti_bank *stm32_bank;
+	struct stm32_exti_chip_data *chip_data;
+	void __iomem *base = h_data->base;
+	u32 irqs_mask;
+
+	stm32_bank = h_data->drv_data->exti_banks[bank_idx];
+	chip_data = &h_data->chips_data[bank_idx];
+	chip_data->host_data = h_data;
+	chip_data->reg_bank = stm32_bank;
+
+	/* Determine number of irqs supported */
+	writel_relaxed(~0UL, base + stm32_bank->rtsr_ofst);
+	irqs_mask = readl_relaxed(base + stm32_bank->rtsr_ofst);
+
+	/*
+	 * This IP has no reset, so after hot reboot we should
+	 * clear registers to avoid residue
+	 */
+	writel_relaxed(0, base + stm32_bank->imr_ofst);
+	writel_relaxed(0, base + stm32_bank->emr_ofst);
+	writel_relaxed(0, base + stm32_bank->rtsr_ofst);
+	writel_relaxed(0, base + stm32_bank->ftsr_ofst);
+	writel_relaxed(~0UL, base + stm32_bank->rpr_ofst);
+	if (stm32_bank->fpr_ofst != UNDEF_REG)
+		writel_relaxed(~0UL, base + stm32_bank->fpr_ofst);
+
+	pr_info("%s: bank%d, External IRQs available:%#x\n",
+		node->full_name, bank_idx, irqs_mask);
+
+	return chip_data;
+}
+
+static int __init stm32_exti_init(const struct stm32_exti_drv_data *drv_data,
+				  struct device_node *node)
 {
+	struct stm32_exti_host_data *host_data;
 	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
-	int nr_irqs, nr_exti, ret, i;
+	int nr_irqs, ret, i;
 	struct irq_chip_generic *gc;
 	struct irq_domain *domain;
-	void *base;
 
-	base = of_iomap(node, 0);
-	if (!base) {
-		pr_err("%pOF: Unable to map registers\n", node);
-		return -ENOMEM;
+	host_data = stm32_exti_host_init(drv_data, node);
+	if (!host_data) {
+		ret = -ENOMEM;
+		goto out_free_mem;
 	}
 
-	stm32_exti_data = kcalloc(bank_nr, sizeof(*stm32_exti_data),
-				  GFP_KERNEL);
-	if (!stm32_exti_data)
-		return -ENOMEM;
-
-	domain = irq_domain_add_linear(node, bank_nr * IRQS_PER_BANK,
+	domain = irq_domain_add_linear(node, drv_data->bank_nr * IRQS_PER_BANK,
 				       &irq_exti_domain_ops, NULL);
 	if (!domain) {
 		pr_err("%s: Could not register interrupt domain.\n",
@@ -276,16 +352,16 @@ __init stm32_exti_init(const struct stm32_exti_bank **stm32_exti_banks,
 		goto out_free_domain;
 	}
 
-	for (i = 0; i < bank_nr; i++) {
-		const struct stm32_exti_bank *stm32_bank = stm32_exti_banks[i];
-		struct stm32_exti_chip_data *chip_data = &stm32_exti_data[i];
-		u32 irqs_mask;
+	for (i = 0; i < drv_data->bank_nr; i++) {
+		const struct stm32_exti_bank *stm32_bank;
+		struct stm32_exti_chip_data *chip_data;
 
-		chip_data->reg_bank = stm32_bank;
+		stm32_bank = drv_data->exti_banks[i];
+		chip_data = stm32_exti_chip_init(host_data, i, node);
 
 		gc = irq_get_domain_generic_chip(domain, i * IRQS_PER_BANK);
 
-		gc->reg_base = base;
+		gc->reg_base = host_data->base;
 		gc->chip_types->type = IRQ_TYPE_EDGE_BOTH;
 		gc->chip_types->chip.irq_ack = stm32_irq_ack;
 		gc->chip_types->chip.irq_mask = irq_gc_mask_clr_bit;
@@ -298,26 +374,6 @@ __init stm32_exti_init(const struct stm32_exti_bank **stm32_exti_banks,
 
 		gc->chip_types->regs.mask = stm32_bank->imr_ofst;
 		gc->private = (void *)chip_data;
-
-		/* Determine number of irqs supported */
-		writel_relaxed(~0UL, base + stm32_bank->rtsr_ofst);
-		irqs_mask = readl_relaxed(base + stm32_bank->rtsr_ofst);
-		nr_exti = fls(readl_relaxed(base + stm32_bank->rtsr_ofst));
-
-		/*
-		 * This IP has no reset, so after hot reboot we should
-		 * clear registers to avoid residue
-		 */
-		writel_relaxed(0, base + stm32_bank->imr_ofst);
-		writel_relaxed(0, base + stm32_bank->emr_ofst);
-		writel_relaxed(0, base + stm32_bank->rtsr_ofst);
-		writel_relaxed(0, base + stm32_bank->ftsr_ofst);
-		writel_relaxed(~0UL, base + stm32_bank->rpr_ofst);
-		if (stm32_bank->fpr_ofst != UNDEF_REG)
-			writel_relaxed(~0UL, base + stm32_bank->fpr_ofst);
-
-		pr_info("%s: bank%d, External IRQs available:%#x\n",
-			node->full_name, i, irqs_mask);
 	}
 
 	nr_irqs = of_irq_count(node);
@@ -333,16 +389,17 @@ __init stm32_exti_init(const struct stm32_exti_bank **stm32_exti_banks,
 out_free_domain:
 	irq_domain_remove(domain);
 out_unmap:
-	iounmap(base);
-	kfree(stm32_exti_data);
+	iounmap(host_data->base);
+out_free_mem:
+	kfree(host_data->chips_data);
+	kfree(host_data);
 	return ret;
 }
 
 static int __init stm32f4_exti_of_init(struct device_node *np,
 				       struct device_node *parent)
 {
-	return stm32_exti_init(stm32f4xx_exti_banks,
-			ARRAY_SIZE(stm32f4xx_exti_banks), np);
+	return stm32_exti_init(&stm32f4xx_drv_data, np);
 }
 
 IRQCHIP_DECLARE(stm32f4_exti, "st,stm32-exti", stm32f4_exti_of_init);
@@ -350,8 +407,7 @@ IRQCHIP_DECLARE(stm32f4_exti, "st,stm32-exti", stm32f4_exti_of_init);
 static int __init stm32h7_exti_of_init(struct device_node *np,
 				       struct device_node *parent)
 {
-	return stm32_exti_init(stm32h7xx_exti_banks,
-			ARRAY_SIZE(stm32h7xx_exti_banks), np);
+	return stm32_exti_init(&stm32h7xx_drv_data, np);
 }
 
 IRQCHIP_DECLARE(stm32h7_exti, "st,stm32h7-exti", stm32h7_exti_of_init);
-- 
2.7.4
