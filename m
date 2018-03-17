Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753813AbeCQX3x (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 19:29:53 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:36700 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753714AbeCQX3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 19:29:47 -0400
From: Paul Cercueil <paul@crapouillou.net>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>
Cc: James Hogan <jhogan@kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v4 5/8] irqchip: Add the ingenic-tcu-intc driver
Date: Sun, 18 Mar 2018 00:28:58 +0100
Message-Id: <20180317232901.14129-6-paul@crapouillou.net>
In-Reply-To: <20180317232901.14129-1-paul@crapouillou.net>
References: <20180110224838.16711-2-paul@crapouillou.net>
 <20180317232901.14129-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This simple driver handles the IRQ chip of the TCU
(Timer Counter Unit) of the JZ47xx Ingenic SoCs.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/irqchip/Kconfig           |   6 ++
 drivers/irqchip/Makefile          |   1 +
 drivers/irqchip/irq-ingenic-tcu.c | 161 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 168 insertions(+)
 create mode 100644 drivers/irqchip/irq-ingenic-tcu.c

 v2: - Use SPDX identifier for the license
     - Make KConfig option select CONFIG_IRQ_DOMAIN since we depend on it
 v3: - Move documentation to its own patch
     - Add comment explaining why we only use IRQCHIP_DECLARE
 v4: - Rename variables to avoid splitting long lines
     - Add comment about the multiple IRQ parents

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index d913aec85109..2b56587d04ed 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -267,6 +267,12 @@ config INGENIC_IRQ
 	depends on MACH_INGENIC
 	default y
 
+config INGENIC_TCU_IRQ
+	bool
+	depends on MACH_INGENIC || COMPILE_TEST
+	select IRQ_DOMAIN
+	default y
+
 config RENESAS_H8300H_INTC
         bool
 	select IRQ_DOMAIN
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index d27e3e3619e0..48b0bdf2b1a2 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_RENESAS_H8300H_INTC)	+= irq-renesas-h8300h.o
 obj-$(CONFIG_RENESAS_H8S_INTC)		+= irq-renesas-h8s.o
 obj-$(CONFIG_ARCH_SA1100)		+= irq-sa11x0.o
 obj-$(CONFIG_INGENIC_IRQ)		+= irq-ingenic.o
+obj-$(CONFIG_INGENIC_TCU_IRQ)		+= irq-ingenic-tcu.o
 obj-$(CONFIG_IMX_GPCV2)			+= irq-imx-gpcv2.o
 obj-$(CONFIG_PIC32_EVIC)		+= irq-pic32-evic.o
 obj-$(CONFIG_MVEBU_GICP)		+= irq-mvebu-gicp.o
diff --git a/drivers/irqchip/irq-ingenic-tcu.c b/drivers/irqchip/irq-ingenic-tcu.c
new file mode 100644
index 000000000000..add3e9cc6f82
--- /dev/null
+++ b/drivers/irqchip/irq-ingenic-tcu.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * JZ47xx SoCs TCU IRQ driver
+ * Copyright (C) 2018 Paul Cercueil <paul@crapouillou.net>
+ */
+
+#include <linux/bitops.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/regmap.h>
+
+#include <linux/mfd/syscon/ingenic-tcu.h>
+
+static void ingenic_tcu_intc_cascade(struct irq_desc *desc)
+{
+	struct irq_chip *irq_chip = irq_data_get_irq_chip(&desc->irq_data);
+	struct irq_domain *domain = irq_desc_get_handler_data(desc);
+	struct irq_chip_generic *gc = irq_get_domain_generic_chip(domain, 0);
+	struct regmap *map = gc->private;
+	uint32_t irq_reg, irq_mask;
+	unsigned int i;
+
+	regmap_read(map, TCU_REG_TFR, &irq_reg);
+	regmap_read(map, TCU_REG_TMR, &irq_mask);
+
+	chained_irq_enter(irq_chip, desc);
+
+	irq_reg &= ~irq_mask;
+
+	for (i = 0; i < 32; i++) {
+		if (irq_reg & BIT(i))
+			generic_handle_irq(irq_linear_revmap(domain, i));
+	}
+
+	chained_irq_exit(irq_chip, desc);
+}
+
+static void ingenic_tcu_gc_unmask_enable_reg(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
+	struct regmap *map = gc->private;
+	u32 mask = d->mask;
+
+	irq_gc_lock(gc);
+	regmap_write(map, ct->regs.ack, mask);
+	regmap_write(map, ct->regs.enable, mask);
+	*ct->mask_cache |= mask;
+	irq_gc_unlock(gc);
+}
+
+static void ingenic_tcu_gc_mask_disable_reg(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
+	struct regmap *map = gc->private;
+	u32 mask = d->mask;
+
+	irq_gc_lock(gc);
+	regmap_write(map, ct->regs.disable, mask);
+	*ct->mask_cache &= ~mask;
+	irq_gc_unlock(gc);
+}
+
+static void ingenic_tcu_gc_mask_disable_reg_and_ack(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
+	struct regmap *map = gc->private;
+	u32 mask = d->mask;
+
+	irq_gc_lock(gc);
+	regmap_write(map, ct->regs.ack, mask);
+	regmap_write(map, ct->regs.disable, mask);
+	irq_gc_unlock(gc);
+}
+
+static int __init ingenic_tcu_intc_of_init(struct device_node *node,
+	struct device_node *parent)
+{
+	struct irq_domain *domain;
+	struct irq_chip_generic *gc;
+	struct irq_chip_type *ct;
+	int err, i, irqs;
+	u32 parent_irqs[3];
+	struct regmap *map;
+
+	irqs = of_property_count_elems_of_size(node, "interrupts", sizeof(u32));
+	if (irqs < 0 || irqs > ARRAY_SIZE(parent_irqs))
+		return -EINVAL;
+
+	map = syscon_node_to_regmap(node->parent);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
+	domain = irq_domain_add_linear(node, 32, &irq_generic_chip_ops, NULL);
+	if (!domain)
+		return -ENOMEM;
+
+	err = irq_alloc_domain_generic_chips(domain, 32, 1, "TCU",
+			handle_level_irq, 0, IRQ_NOPROBE | IRQ_LEVEL, 0);
+	if (err)
+		goto out_domain_remove;
+
+	gc = irq_get_domain_generic_chip(domain, 0);
+	ct = gc->chip_types;
+
+	gc->wake_enabled = IRQ_MSK(32);
+	gc->private = map;
+
+	ct->regs.disable = TCU_REG_TMSR;
+	ct->regs.enable = TCU_REG_TMCR;
+	ct->regs.ack = TCU_REG_TFCR;
+	ct->chip.irq_unmask = ingenic_tcu_gc_unmask_enable_reg;
+	ct->chip.irq_mask = ingenic_tcu_gc_mask_disable_reg;
+	ct->chip.irq_mask_ack = ingenic_tcu_gc_mask_disable_reg_and_ack;
+	ct->chip.flags = IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_SKIP_SET_WAKE;
+
+	/* Mask all IRQs by default */
+	regmap_write(map, TCU_REG_TMSR, IRQ_MSK(32));
+
+	/* On JZ4740, timer 0 and timer 1 have their own interrupt line;
+	 * timers 2-7 share one interrupt.
+	 * On SoCs >= JZ4770, timer 5 has its own interrupt line;
+	 * timers 0-4 and 6-7 share one single interrupt.
+	 *
+	 * To keep things simple, we just register the same handler to
+	 * all parent interrupts. The handler will properly detect which
+	 * channel fired the interrupt.
+	 */
+	for (i = 0; i < irqs; i++) {
+		parent_irqs[i] = irq_of_parse_and_map(node, i);
+		if (!parent_irqs[i]) {
+			err = -EINVAL;
+			goto out_unmap_irqs;
+		}
+
+		irq_set_chained_handler_and_data(parent_irqs[i],
+				ingenic_tcu_intc_cascade, domain);
+	}
+
+	return 0;
+
+out_unmap_irqs:
+	for (; i > 0; i--)
+		irq_dispose_mapping(parent_irqs[i - 1]);
+out_domain_remove:
+	irq_domain_remove(domain);
+	return err;
+}
+
+/* We only probe via devicetree, no need for a platform driver */
+IRQCHIP_DECLARE(jz4740_tcu_intc, "ingenic,jz4740-tcu-intc",
+		ingenic_tcu_intc_of_init);
+IRQCHIP_DECLARE(jz4770_tcu_intc, "ingenic,jz4770-tcu-intc",
+		ingenic_tcu_intc_of_init);
+IRQCHIP_DECLARE(jz4780_tcu_intc, "ingenic,jz4780-tcu-intc",
+		ingenic_tcu_intc_of_init);
-- 
2.11.0
