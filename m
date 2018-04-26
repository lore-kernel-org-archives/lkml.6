Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756862AbeDZQTa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 12:19:30 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22699 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756800AbeDZQTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 12:19:19 -0400
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
Subject: [PATCH 07/11] irqchip: stm32: add stm32mp1 support with hierarchy domain
Date: Thu, 26 Apr 2018 18:18:30 +0200
Message-ID: <1524759514-12392-8-git-send-email-ludovic.Barre@st.com>
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

Exti controller has been differently integrated on stm32mp1 SoC.
A parent irq has only one external interrupt. A hierachy domain could
be used. Handlers are call by parent, each parent interrupt could be
masked and unmasked according to the needs.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 .../interrupt-controller/st,stm32-exti.txt         |   3 +
 drivers/irqchip/irq-stm32-exti.c                   | 322 +++++++++++++++++++++
 2 files changed, 325 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
index edf03f0..136bd61 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
@@ -5,11 +5,14 @@ Required properties:
 - compatible: Should be:
     "st,stm32-exti"
     "st,stm32h7-exti"
+    "st,stm32mp1-exti"
 - reg: Specifies base physical address and size of the registers
 - interrupt-controller: Indentifies the node as an interrupt controller
 - #interrupt-cells: Specifies the number of cells to encode an interrupt
   specifier, shall be 2
 - interrupts: interrupts references to primary interrupt controller
+  (only needed for exti controller with multiple exti under
+  same parent interrupt: st,stm32-exti and st,stm32h7-exti")
 
 Example:
 
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index b38c655..ebf7146 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -15,6 +15,8 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
 #define IRQS_PER_BANK 32
 
 struct stm32_exti_bank {
@@ -29,14 +31,24 @@ struct stm32_exti_bank {
 
 #define UNDEF_REG ~0
 
+struct stm32_desc_irq {
+	u32 exti;
+	u32 irq_parent;
+};
+
 struct stm32_exti_drv_data {
 	const struct stm32_exti_bank **exti_banks;
+	const struct stm32_desc_irq *desc_irqs;
 	u32 bank_nr;
+	u32 irq_nr;
 };
 
 struct stm32_exti_chip_data {
 	struct stm32_exti_host_data *host_data;
 	const struct stm32_exti_bank *reg_bank;
+	struct raw_spinlock rlock;
+	u32 wake_active;
+	u32 mask_cache;
 	u32 rtsr_cache;
 	u32 ftsr_cache;
 };
@@ -107,6 +119,89 @@ static const struct stm32_exti_drv_data stm32h7xx_drv_data = {
 	.bank_nr = ARRAY_SIZE(stm32h7xx_exti_banks),
 };
 
+static const struct stm32_exti_bank stm32mp1_exti_b1 = {
+	.imr_ofst	= 0x80,
+	.emr_ofst	= 0x84,
+	.rtsr_ofst	= 0x00,
+	.ftsr_ofst	= 0x04,
+	.swier_ofst	= 0x08,
+	.rpr_ofst	= 0x0C,
+	.fpr_ofst	= 0x10,
+};
+
+static const struct stm32_exti_bank stm32mp1_exti_b2 = {
+	.imr_ofst	= 0x90,
+	.emr_ofst	= 0x94,
+	.rtsr_ofst	= 0x20,
+	.ftsr_ofst	= 0x24,
+	.swier_ofst	= 0x28,
+	.rpr_ofst	= 0x2C,
+	.fpr_ofst	= 0x30,
+};
+
+static const struct stm32_exti_bank stm32mp1_exti_b3 = {
+	.imr_ofst	= 0xA0,
+	.emr_ofst	= 0xA4,
+	.rtsr_ofst	= 0x40,
+	.ftsr_ofst	= 0x44,
+	.swier_ofst	= 0x48,
+	.rpr_ofst	= 0x4C,
+	.fpr_ofst	= 0x50,
+};
+
+static const struct stm32_exti_bank *stm32mp1_exti_banks[] = {
+	&stm32mp1_exti_b1,
+	&stm32mp1_exti_b2,
+	&stm32mp1_exti_b3,
+};
+
+static const struct stm32_desc_irq stm32mp1_desc_irq[] = {
+	{ .exti = 1, .irq_parent = 7 },
+	{ .exti = 2, .irq_parent = 8 },
+	{ .exti = 3, .irq_parent = 9 },
+	{ .exti = 4, .irq_parent = 10 },
+	{ .exti = 5, .irq_parent = 23 },
+	{ .exti = 6, .irq_parent = 64 },
+	{ .exti = 7, .irq_parent = 65 },
+	{ .exti = 8, .irq_parent = 66 },
+	{ .exti = 9, .irq_parent = 67 },
+	{ .exti = 10, .irq_parent = 40 },
+	{ .exti = 11, .irq_parent = 42 },
+	{ .exti = 12, .irq_parent = 76 },
+	{ .exti = 13, .irq_parent = 77 },
+	{ .exti = 14, .irq_parent = 121 },
+	{ .exti = 15, .irq_parent = 127 },
+	{ .exti = 16, .irq_parent = 1 },
+	{ .exti = 65, .irq_parent = 144 },
+	{ .exti = 68, .irq_parent = 143 },
+	{ .exti = 73, .irq_parent = 129 },
+};
+
+static const struct stm32_exti_drv_data stm32mp1_drv_data = {
+	.exti_banks = stm32mp1_exti_banks,
+	.bank_nr = ARRAY_SIZE(stm32mp1_exti_banks),
+	.desc_irqs = stm32mp1_desc_irq,
+	.irq_nr = ARRAY_SIZE(stm32mp1_desc_irq),
+};
+
+static int stm32_exti_to_irq(const struct stm32_exti_drv_data *drv_data,
+			     irq_hw_number_t hwirq)
+{
+	const struct stm32_desc_irq *desc_irq;
+	int i;
+
+	if (!drv_data->desc_irqs)
+		return -EINVAL;
+
+	for (i = 0; i < drv_data->irq_nr; i++) {
+		desc_irq = &drv_data->desc_irqs[i];
+		if (desc_irq->exti == hwirq)
+			return desc_irq->irq_parent;
+	}
+
+	return -EINVAL;
+}
+
 static unsigned long stm32_exti_pending(struct irq_chip_generic *gc)
 {
 	struct stm32_exti_chip_data *chip_data = gc->private;
@@ -282,6 +377,173 @@ static void stm32_irq_ack(struct irq_data *d)
 
 	irq_gc_unlock(gc);
 }
+
+static inline u32 stm32_exti_set_bit(struct irq_data *d, u32 reg)
+{
+	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	void __iomem *base = chip_data->host_data->base;
+	u32 val;
+
+	val = readl_relaxed(base + reg);
+	val |= BIT(d->hwirq % IRQS_PER_BANK);
+	writel_relaxed(val, base + reg);
+
+	return val;
+}
+
+static inline u32 stm32_exti_clr_bit(struct irq_data *d, u32 reg)
+{
+	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	void __iomem *base = chip_data->host_data->base;
+	u32 val;
+
+	val = readl_relaxed(base + reg);
+	val &= ~BIT(d->hwirq % IRQS_PER_BANK);
+	writel_relaxed(val, base + reg);
+
+	return val;
+}
+
+static void stm32_exti_h_eoi(struct irq_data *d)
+{
+	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+
+	raw_spin_lock(&chip_data->rlock);
+
+	stm32_exti_set_bit(d, stm32_bank->rpr_ofst);
+	if (stm32_bank->fpr_ofst != UNDEF_REG)
+		stm32_exti_set_bit(d, stm32_bank->fpr_ofst);
+
+	raw_spin_unlock(&chip_data->rlock);
+
+	if (d->parent_data->chip)
+		irq_chip_eoi_parent(d);
+}
+
+static void stm32_exti_h_mask(struct irq_data *d)
+{
+	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+
+	raw_spin_lock(&chip_data->rlock);
+	chip_data->mask_cache = stm32_exti_clr_bit(d, stm32_bank->imr_ofst);
+	raw_spin_unlock(&chip_data->rlock);
+
+	if (d->parent_data->chip)
+		irq_chip_mask_parent(d);
+}
+
+static void stm32_exti_h_unmask(struct irq_data *d)
+{
+	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+
+	raw_spin_lock(&chip_data->rlock);
+	chip_data->mask_cache = stm32_exti_set_bit(d, stm32_bank->imr_ofst);
+	raw_spin_unlock(&chip_data->rlock);
+
+	if (d->parent_data->chip)
+		irq_chip_unmask_parent(d);
+}
+
+static int stm32_exti_h_set_type(struct irq_data *d, unsigned int type)
+{
+	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+	void __iomem *base = chip_data->host_data->base;
+	u32 rtsr, ftsr;
+	int err;
+
+	raw_spin_lock(&chip_data->rlock);
+	rtsr = readl_relaxed(base + stm32_bank->rtsr_ofst);
+	ftsr = readl_relaxed(base + stm32_bank->ftsr_ofst);
+
+	err = stm32_exti_set_type(d, type, &rtsr, &ftsr);
+	if (err) {
+		raw_spin_unlock(&chip_data->rlock);
+		return err;
+	}
+
+	writel_relaxed(rtsr, base + stm32_bank->rtsr_ofst);
+	writel_relaxed(ftsr, base + stm32_bank->ftsr_ofst);
+	raw_spin_unlock(&chip_data->rlock);
+
+	return 0;
+}
+
+static int stm32_exti_h_set_wake(struct irq_data *d, unsigned int on)
+{
+	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	u32 mask = BIT(d->hwirq % IRQS_PER_BANK);
+
+	raw_spin_lock(&chip_data->rlock);
+
+	if (on)
+		chip_data->wake_active |= mask;
+	else
+		chip_data->wake_active &= ~mask;
+
+	raw_spin_unlock(&chip_data->rlock);
+
+	return 0;
+}
+
+static int stm32_exti_h_set_affinity(struct irq_data *d,
+				     const struct cpumask *dest, bool force)
+{
+	if (d->parent_data->chip)
+		return irq_chip_set_affinity_parent(d, dest, force);
+
+	return -EINVAL;
+}
+
+static struct irq_chip stm32_exti_h_chip = {
+	.name			= "stm32-exti-h",
+	.irq_eoi		= stm32_exti_h_eoi,
+	.irq_mask		= stm32_exti_h_mask,
+	.irq_unmask		= stm32_exti_h_unmask,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_type		= stm32_exti_h_set_type,
+	.irq_set_wake		= stm32_exti_h_set_wake,
+	.flags			= IRQCHIP_MASK_ON_SUSPEND,
+#ifdef CONFIG_SMP
+	.irq_set_affinity	= stm32_exti_h_set_affinity,
+#endif
+};
+
+static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
+				     unsigned int virq,
+				     unsigned int nr_irqs, void *data)
+{
+	struct stm32_exti_host_data *host_data = dm->host_data;
+	struct stm32_exti_chip_data *chip_data;
+	struct irq_fwspec *fwspec = data;
+	struct irq_fwspec p_fwspec;
+	irq_hw_number_t hwirq;
+	int p_irq, bank;
+
+	hwirq = fwspec->param[0];
+	bank  = hwirq / IRQS_PER_BANK;
+	chip_data = &host_data->chips_data[bank];
+
+	irq_domain_set_hwirq_and_chip(dm, virq, hwirq,
+				      &stm32_exti_h_chip, chip_data);
+
+	p_irq = stm32_exti_to_irq(host_data->drv_data, hwirq);
+	if (p_irq >= 0) {
+		p_fwspec.fwnode = dm->parent->fwnode;
+		p_fwspec.param_count = 3;
+		p_fwspec.param[0] = GIC_SPI;
+		p_fwspec.param[1] = p_irq;
+		p_fwspec.param[2] = IRQ_TYPE_LEVEL_HIGH;
+
+		return irq_domain_alloc_irqs_parent(dm, virq, 1, &p_fwspec);
+	}
+
+	return 0;
+}
+
 static struct
 stm32_exti_host_data *stm32_exti_host_init(const struct stm32_exti_drv_data *dd,
 					   struct device_node *node)
@@ -323,6 +585,8 @@ stm32_exti_chip_data *stm32_exti_chip_init(struct stm32_exti_host_data *h_data,
 	chip_data->host_data = h_data;
 	chip_data->reg_bank = stm32_bank;
 
+	raw_spin_lock_init(&chip_data->rlock);
+
 	/* Determine number of irqs supported */
 	writel_relaxed(~0UL, base + stm32_bank->rtsr_ofst);
 	irqs_mask = readl_relaxed(base + stm32_bank->rtsr_ofst);
@@ -421,6 +685,56 @@ static int __init stm32_exti_init(const struct stm32_exti_drv_data *drv_data,
 	return ret;
 }
 
+static const struct irq_domain_ops stm32_exti_h_domain_ops = {
+	.alloc	= stm32_exti_h_domain_alloc,
+	.free	= irq_domain_free_irqs_common,
+};
+
+static int
+__init stm32_exti_hierarchy_init(const struct stm32_exti_drv_data *drv_data,
+				 struct device_node *node,
+				 struct device_node *parent)
+{
+	struct irq_domain *parent_domain, *domain;
+	struct stm32_exti_host_data *host_data;
+	int ret, i;
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		pr_err("interrupt-parent not found\n");
+		return -EINVAL;
+	}
+
+	host_data = stm32_exti_host_init(drv_data, node);
+	if (!host_data) {
+		ret = -ENOMEM;
+		goto out_free_mem;
+	}
+
+	for (i = 0; i < drv_data->bank_nr; i++)
+		stm32_exti_chip_init(host_data, i, node);
+
+	domain = irq_domain_add_hierarchy(parent_domain, 0,
+					  drv_data->bank_nr * IRQS_PER_BANK,
+					  node, &stm32_exti_h_domain_ops,
+					  host_data);
+
+	if (!domain) {
+		pr_err("%s: Could not register exti domain.\n", node->name);
+		ret = -ENOMEM;
+		goto out_unmap;
+	}
+
+	return 0;
+
+out_unmap:
+	iounmap(host_data->base);
+out_free_mem:
+	kfree(host_data->chips_data);
+	kfree(host_data);
+	return ret;
+}
+
 static int __init stm32f4_exti_of_init(struct device_node *np,
 				       struct device_node *parent)
 {
@@ -436,3 +750,11 @@ static int __init stm32h7_exti_of_init(struct device_node *np,
 }
 
 IRQCHIP_DECLARE(stm32h7_exti, "st,stm32h7-exti", stm32h7_exti_of_init);
+
+static int __init stm32mp1_exti_of_init(struct device_node *np,
+					struct device_node *parent)
+{
+	return stm32_exti_hierarchy_init(&stm32mp1_drv_data, np, parent);
+}
+
+IRQCHIP_DECLARE(stm32mp1_exti, "st,stm32mp1-exti", stm32mp1_exti_of_init);
-- 
2.7.4
