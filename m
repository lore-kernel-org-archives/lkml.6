Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756949AbeDZQVQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 12:21:16 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52620 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756790AbeDZQTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 12:19:17 -0400
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
Subject: [PATCH 03/11] irqchip: stm32: add falling pending register support
Date: Thu, 26 Apr 2018 18:18:26 +0200
Message-ID: <1524759514-12392-4-git-send-email-ludovic.Barre@st.com>
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

This patch adds support of rising/falling pending registers.
Falling pending register (fpr) is needed for next revision.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/irqchip/irq-stm32-exti.c | 47 ++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index b91a8c2..69a4453 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -23,16 +23,20 @@ struct stm32_exti_bank {
 	u32 rtsr_ofst;
 	u32 ftsr_ofst;
 	u32 swier_ofst;
-	u32 pr_ofst;
+	u32 rpr_ofst;
+	u32 fpr_ofst;
 };
 
+#define UNDEF_REG ~0
+
 static const struct stm32_exti_bank stm32f4xx_exti_b1 = {
 	.imr_ofst	= 0x00,
 	.emr_ofst	= 0x04,
 	.rtsr_ofst	= 0x08,
 	.ftsr_ofst	= 0x0C,
 	.swier_ofst	= 0x10,
-	.pr_ofst	= 0x14,
+	.rpr_ofst	= 0x14,
+	.fpr_ofst	= UNDEF_REG,
 };
 
 static const struct stm32_exti_bank *stm32f4xx_exti_banks[] = {
@@ -45,7 +49,8 @@ static const struct stm32_exti_bank stm32h7xx_exti_b1 = {
 	.rtsr_ofst	= 0x00,
 	.ftsr_ofst	= 0x04,
 	.swier_ofst	= 0x08,
-	.pr_ofst	= 0x88,
+	.rpr_ofst	= 0x88,
+	.fpr_ofst	= UNDEF_REG,
 };
 
 static const struct stm32_exti_bank stm32h7xx_exti_b2 = {
@@ -54,7 +59,8 @@ static const struct stm32_exti_bank stm32h7xx_exti_b2 = {
 	.rtsr_ofst	= 0x20,
 	.ftsr_ofst	= 0x24,
 	.swier_ofst	= 0x28,
-	.pr_ofst	= 0x98,
+	.rpr_ofst	= 0x98,
+	.fpr_ofst	= UNDEF_REG,
 };
 
 static const struct stm32_exti_bank stm32h7xx_exti_b3 = {
@@ -63,7 +69,8 @@ static const struct stm32_exti_bank stm32h7xx_exti_b3 = {
 	.rtsr_ofst	= 0x40,
 	.ftsr_ofst	= 0x44,
 	.swier_ofst	= 0x48,
-	.pr_ofst	= 0xA8,
+	.rpr_ofst	= 0xA8,
+	.fpr_ofst	= UNDEF_REG,
 };
 
 static const struct stm32_exti_bank *stm32h7xx_exti_banks[] = {
@@ -75,8 +82,13 @@ static const struct stm32_exti_bank *stm32h7xx_exti_banks[] = {
 static unsigned long stm32_exti_pending(struct irq_chip_generic *gc)
 {
 	const struct stm32_exti_bank *stm32_bank = gc->private;
+	unsigned long pending;
+
+	pending = irq_reg_readl(gc, stm32_bank->rpr_ofst);
+	if (stm32_bank->fpr_ofst != UNDEF_REG)
+		pending |= irq_reg_readl(gc, stm32_bank->fpr_ofst);
 
-	return irq_reg_readl(gc, stm32_bank->pr_ofst);
+	return pending;
 }
 
 static void stm32_irq_handler(struct irq_desc *desc)
@@ -85,7 +97,6 @@ static void stm32_irq_handler(struct irq_desc *desc)
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int virq, nbanks = domain->gc->num_chips;
 	struct irq_chip_generic *gc;
-	const struct stm32_exti_bank *stm32_bank;
 	unsigned long pending;
 	int n, i, irq_base = 0;
 
@@ -93,7 +104,6 @@ static void stm32_irq_handler(struct irq_desc *desc)
 
 	for (i = 0; i < nbanks; i++, irq_base += IRQS_PER_BANK) {
 		gc = irq_get_domain_generic_chip(domain, irq_base);
-		stm32_bank = gc->private;
 
 		while ((pending = stm32_exti_pending(gc))) {
 			for_each_set_bit(n, &pending, IRQS_PER_BANK) {
@@ -192,6 +202,20 @@ static const struct irq_domain_ops irq_exti_domain_ops = {
 	.free	= stm32_exti_free,
 };
 
+static void stm32_irq_ack(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	const struct stm32_exti_bank *stm32_bank = gc->private;
+
+	irq_gc_lock(gc);
+
+	irq_reg_writel(gc, d->mask, stm32_bank->rpr_ofst);
+	if (stm32_bank->fpr_ofst != UNDEF_REG)
+		irq_reg_writel(gc, d->mask, stm32_bank->fpr_ofst);
+
+	irq_gc_unlock(gc);
+}
+
 static int
 __init stm32_exti_init(const struct stm32_exti_bank **stm32_exti_banks,
 		       int bank_nr, struct device_node *node)
@@ -233,12 +257,11 @@ __init stm32_exti_init(const struct stm32_exti_bank **stm32_exti_banks,
 
 		gc->reg_base = base;
 		gc->chip_types->type = IRQ_TYPE_EDGE_BOTH;
-		gc->chip_types->chip.irq_ack = irq_gc_ack_set_bit;
+		gc->chip_types->chip.irq_ack = stm32_irq_ack;
 		gc->chip_types->chip.irq_mask = irq_gc_mask_clr_bit;
 		gc->chip_types->chip.irq_unmask = irq_gc_mask_set_bit;
 		gc->chip_types->chip.irq_set_type = stm32_irq_set_type;
 		gc->chip_types->chip.irq_set_wake = stm32_irq_set_wake;
-		gc->chip_types->regs.ack = stm32_bank->pr_ofst;
 		gc->chip_types->regs.mask = stm32_bank->imr_ofst;
 		gc->private = (void *)stm32_bank;
 
@@ -255,7 +278,9 @@ __init stm32_exti_init(const struct stm32_exti_bank **stm32_exti_banks,
 		writel_relaxed(0, base + stm32_bank->emr_ofst);
 		writel_relaxed(0, base + stm32_bank->rtsr_ofst);
 		writel_relaxed(0, base + stm32_bank->ftsr_ofst);
-		writel_relaxed(~0UL, base + stm32_bank->pr_ofst);
+		writel_relaxed(~0UL, base + stm32_bank->rpr_ofst);
+		if (stm32_bank->fpr_ofst != UNDEF_REG)
+			writel_relaxed(~0UL, base + stm32_bank->fpr_ofst);
 
 		pr_info("%s: bank%d, External IRQs available:%#x\n",
 			node->full_name, i, irqs_mask);
-- 
2.7.4
