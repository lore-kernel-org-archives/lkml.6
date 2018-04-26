Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756937AbeDZQVL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 12:21:11 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:20435 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756791AbeDZQTR (ORCPT
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
Subject: [PATCH 06/11] irqchip: stm32: prepare common functions
Date: Thu, 26 Apr 2018 18:18:29 +0200
Message-ID: <1524759514-12392-7-git-send-email-ludovic.Barre@st.com>
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

This patch prepares functions which could be reused by
next variant of stm32 exti controller.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/irqchip/irq-stm32-exti.c | 91 +++++++++++++++++++++++++---------------
 1 file changed, 58 insertions(+), 33 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 9655a57..b38c655 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -145,37 +145,50 @@ static void stm32_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static int stm32_irq_set_type(struct irq_data *data, unsigned int type)
+static int stm32_exti_set_type(struct irq_data *d,
+			       unsigned int type, u32 *rtsr, u32 *ftsr)
 {
-	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
-	struct stm32_exti_chip_data *chip_data = gc->private;
-	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
-	int pin = data->hwirq % IRQS_PER_BANK;
-	u32 rtsr, ftsr;
-
-	irq_gc_lock(gc);
-
-	rtsr = irq_reg_readl(gc, stm32_bank->rtsr_ofst);
-	ftsr = irq_reg_readl(gc, stm32_bank->ftsr_ofst);
+	u32 mask = BIT(d->hwirq % IRQS_PER_BANK);
 
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
-		rtsr |= BIT(pin);
-		ftsr &= ~BIT(pin);
+		*rtsr |= mask;
+		*ftsr &= ~mask;
 		break;
 	case IRQ_TYPE_EDGE_FALLING:
-		rtsr &= ~BIT(pin);
-		ftsr |= BIT(pin);
+		*rtsr &= ~mask;
+		*ftsr |= mask;
 		break;
 	case IRQ_TYPE_EDGE_BOTH:
-		rtsr |= BIT(pin);
-		ftsr |= BIT(pin);
+		*rtsr |= mask;
+		*ftsr |= mask;
 		break;
 	default:
-		irq_gc_unlock(gc);
 		return -EINVAL;
 	}
 
+	return 0;
+}
+
+static int stm32_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct stm32_exti_chip_data *chip_data = gc->private;
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+	u32 rtsr, ftsr;
+	int err;
+
+	irq_gc_lock(gc);
+
+	rtsr = irq_reg_readl(gc, stm32_bank->rtsr_ofst);
+	ftsr = irq_reg_readl(gc, stm32_bank->ftsr_ofst);
+
+	err = stm32_exti_set_type(d, type, &rtsr, &ftsr);
+	if (err) {
+		irq_gc_unlock(gc);
+		return err;
+	}
+
 	irq_reg_writel(gc, rtsr, stm32_bank->rtsr_ofst);
 	irq_reg_writel(gc, ftsr, stm32_bank->ftsr_ofst);
 
@@ -184,35 +197,47 @@ static int stm32_irq_set_type(struct irq_data *data, unsigned int type)
 	return 0;
 }
 
-static void stm32_irq_suspend(struct irq_chip_generic *gc)
+static void stm32_chip_suspend(struct stm32_exti_chip_data *chip_data,
+			       u32 wake_active)
 {
-	struct stm32_exti_chip_data *chip_data = gc->private;
 	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
-
-	irq_gc_lock(gc);
+	void __iomem *base = chip_data->host_data->base;
 
 	/* save rtsr, ftsr registers */
-	chip_data->rtsr_cache = irq_reg_readl(gc, stm32_bank->rtsr_ofst);
-	chip_data->ftsr_cache = irq_reg_readl(gc, stm32_bank->ftsr_ofst);
+	chip_data->rtsr_cache = readl_relaxed(base + stm32_bank->rtsr_ofst);
+	chip_data->ftsr_cache = readl_relaxed(base + stm32_bank->ftsr_ofst);
 
-	irq_reg_writel(gc, gc->wake_active, stm32_bank->imr_ofst);
+	writel_relaxed(wake_active, base + stm32_bank->imr_ofst);
+}
 
-	irq_gc_unlock(gc);
+static void stm32_chip_resume(struct stm32_exti_chip_data *chip_data,
+			      u32 mask_cache)
+{
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+	void __iomem *base = chip_data->host_data->base;
+
+	/* restore rtsr, ftsr, registers */
+	writel_relaxed(chip_data->rtsr_cache, base + stm32_bank->rtsr_ofst);
+	writel_relaxed(chip_data->ftsr_cache, base + stm32_bank->ftsr_ofst);
+
+	writel_relaxed(mask_cache, base + stm32_bank->imr_ofst);
 }
 
-static void stm32_irq_resume(struct irq_chip_generic *gc)
+static void stm32_irq_suspend(struct irq_chip_generic *gc)
 {
 	struct stm32_exti_chip_data *chip_data = gc->private;
-	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
 
 	irq_gc_lock(gc);
+	stm32_chip_suspend(chip_data, gc->wake_active);
+	irq_gc_unlock(gc);
+}
 
-	/* restore rtsr, ftsr registers */
-	irq_reg_writel(gc, chip_data->rtsr_cache, stm32_bank->rtsr_ofst);
-	irq_reg_writel(gc, chip_data->ftsr_cache, stm32_bank->ftsr_ofst);
-
-	irq_reg_writel(gc, gc->mask_cache, stm32_bank->imr_ofst);
+static void stm32_irq_resume(struct irq_chip_generic *gc)
+{
+	struct stm32_exti_chip_data *chip_data = gc->private;
 
+	irq_gc_lock(gc);
+	stm32_chip_resume(chip_data, gc->mask_cache);
 	irq_gc_unlock(gc);
 }
 
-- 
2.7.4
