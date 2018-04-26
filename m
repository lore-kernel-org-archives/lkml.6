Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932227AbeDZQWR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 12:22:17 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:23546 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755709AbeDZQTQ (ORCPT
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
Subject: [PATCH 04/11] irqchip: stm32: add suspend support
Date: Thu, 26 Apr 2018 18:18:27 +0200
Message-ID: <1524759514-12392-5-git-send-email-ludovic.Barre@st.com>
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

This patch adds suspend feature.
-Use default irq_set_wake function to store wakeup request.
-Suspend function set wake_active into imr of each bank
 and save rising/falling trigger registers.
-Resume function restore the mask_cache interrupt into
 imr of each bank and restore rising/falling trigger registers.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/irqchip/irq-stm32-exti.c | 69 ++++++++++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 69a4453..1e09667 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -29,6 +29,14 @@ struct stm32_exti_bank {
 
 #define UNDEF_REG ~0
 
+struct stm32_exti_chip_data {
+	const struct stm32_exti_bank *reg_bank;
+	u32 rtsr_cache;
+	u32 ftsr_cache;
+};
+
+static struct stm32_exti_chip_data *stm32_exti_data;
+
 static const struct stm32_exti_bank stm32f4xx_exti_b1 = {
 	.imr_ofst	= 0x00,
 	.emr_ofst	= 0x04,
@@ -81,7 +89,8 @@ static const struct stm32_exti_bank *stm32h7xx_exti_banks[] = {
 
 static unsigned long stm32_exti_pending(struct irq_chip_generic *gc)
 {
-	const struct stm32_exti_bank *stm32_bank = gc->private;
+	struct stm32_exti_chip_data *chip_data = gc->private;
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
 	unsigned long pending;
 
 	pending = irq_reg_readl(gc, stm32_bank->rpr_ofst);
@@ -119,7 +128,8 @@ static void stm32_irq_handler(struct irq_desc *desc)
 static int stm32_irq_set_type(struct irq_data *data, unsigned int type)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
-	const struct stm32_exti_bank *stm32_bank = gc->private;
+	struct stm32_exti_chip_data *chip_data = gc->private;
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
 	int pin = data->hwirq % IRQS_PER_BANK;
 	u32 rtsr, ftsr;
 
@@ -154,25 +164,36 @@ static int stm32_irq_set_type(struct irq_data *data, unsigned int type)
 	return 0;
 }
 
-static int stm32_irq_set_wake(struct irq_data *data, unsigned int on)
+static void stm32_irq_suspend(struct irq_chip_generic *gc)
 {
-	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
-	const struct stm32_exti_bank *stm32_bank = gc->private;
-	int pin = data->hwirq % IRQS_PER_BANK;
-	u32 imr;
+	struct stm32_exti_chip_data *chip_data = gc->private;
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
 
 	irq_gc_lock(gc);
 
-	imr = irq_reg_readl(gc, stm32_bank->imr_ofst);
-	if (on)
-		imr |= BIT(pin);
-	else
-		imr &= ~BIT(pin);
-	irq_reg_writel(gc, imr, stm32_bank->imr_ofst);
+	/* save rtsr, ftsr registers */
+	chip_data->rtsr_cache = irq_reg_readl(gc, stm32_bank->rtsr_ofst);
+	chip_data->ftsr_cache = irq_reg_readl(gc, stm32_bank->ftsr_ofst);
+
+	irq_reg_writel(gc, gc->wake_active, stm32_bank->imr_ofst);
 
 	irq_gc_unlock(gc);
+}
 
-	return 0;
+static void stm32_irq_resume(struct irq_chip_generic *gc)
+{
+	struct stm32_exti_chip_data *chip_data = gc->private;
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+
+	irq_gc_lock(gc);
+
+	/* restore rtsr, ftsr registers */
+	irq_reg_writel(gc, chip_data->rtsr_cache, stm32_bank->rtsr_ofst);
+	irq_reg_writel(gc, chip_data->ftsr_cache, stm32_bank->ftsr_ofst);
+
+	irq_reg_writel(gc, gc->mask_cache, stm32_bank->imr_ofst);
+
+	irq_gc_unlock(gc);
 }
 
 static int stm32_exti_alloc(struct irq_domain *d, unsigned int virq,
@@ -205,7 +226,8 @@ static const struct irq_domain_ops irq_exti_domain_ops = {
 static void stm32_irq_ack(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
-	const struct stm32_exti_bank *stm32_bank = gc->private;
+	struct stm32_exti_chip_data *chip_data = gc->private;
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
 
 	irq_gc_lock(gc);
 
@@ -232,6 +254,11 @@ __init stm32_exti_init(const struct stm32_exti_bank **stm32_exti_banks,
 		return -ENOMEM;
 	}
 
+	stm32_exti_data = kcalloc(bank_nr, sizeof(*stm32_exti_data),
+				  GFP_KERNEL);
+	if (!stm32_exti_data)
+		return -ENOMEM;
+
 	domain = irq_domain_add_linear(node, bank_nr * IRQS_PER_BANK,
 				       &irq_exti_domain_ops, NULL);
 	if (!domain) {
@@ -251,8 +278,11 @@ __init stm32_exti_init(const struct stm32_exti_bank **stm32_exti_banks,
 
 	for (i = 0; i < bank_nr; i++) {
 		const struct stm32_exti_bank *stm32_bank = stm32_exti_banks[i];
+		struct stm32_exti_chip_data *chip_data = &stm32_exti_data[i];
 		u32 irqs_mask;
 
+		chip_data->reg_bank = stm32_bank;
+
 		gc = irq_get_domain_generic_chip(domain, i * IRQS_PER_BANK);
 
 		gc->reg_base = base;
@@ -261,9 +291,13 @@ __init stm32_exti_init(const struct stm32_exti_bank **stm32_exti_banks,
 		gc->chip_types->chip.irq_mask = irq_gc_mask_clr_bit;
 		gc->chip_types->chip.irq_unmask = irq_gc_mask_set_bit;
 		gc->chip_types->chip.irq_set_type = stm32_irq_set_type;
-		gc->chip_types->chip.irq_set_wake = stm32_irq_set_wake;
+		gc->chip_types->chip.irq_set_wake = irq_gc_set_wake;
+		gc->suspend = stm32_irq_suspend;
+		gc->resume = stm32_irq_resume;
+		gc->wake_enabled = IRQ_MSK(IRQS_PER_BANK);
+
 		gc->chip_types->regs.mask = stm32_bank->imr_ofst;
-		gc->private = (void *)stm32_bank;
+		gc->private = (void *)chip_data;
 
 		/* Determine number of irqs supported */
 		writel_relaxed(~0UL, base + stm32_bank->rtsr_ofst);
@@ -300,6 +334,7 @@ __init stm32_exti_init(const struct stm32_exti_bank **stm32_exti_banks,
 	irq_domain_remove(domain);
 out_unmap:
 	iounmap(base);
+	kfree(stm32_exti_data);
 	return ret;
 }
 
-- 
2.7.4
