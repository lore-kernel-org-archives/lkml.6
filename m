Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932104AbeBGPue (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 10:50:34 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44812 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754538AbeBGPuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 10:50:05 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2CB5E6029D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, asathyak@codeaurora.org,
        Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v4 1/2] drivers: irqchip: pdc: Add PDC interrupt controller for QCOM SoCs
Date: Wed,  7 Feb 2018 08:49:57 -0700
Message-Id: <20180207154958.13421-2-ilina@codeaurora.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180207154958.13421-1-ilina@codeaurora.org>
References: <20180207154958.13421-1-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From : Archana Sathyakumar <asathyak@codeaurora.org>

The Power Domain Controller (PDC) on QTI SoCs like SDM845 houses an
interrupt controller along with other domain control functions to handle
interrupt related functions like handle falling edge or active low which
are not detected at the GIC and handle wakeup interrupts.

The interrupt controller is on an always-on domain for the purpose of
waking up the processor. Only a subset of the processor's interrupts are
routed through the PDC to the GIC. The PDC powers on the processors'
domain, when in low power mode and replays pending interrupts so the GIC
may wake up the processor.

Signed-off-by: Archana Sathyakumar <asathyak@codeaurora.org>
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/irqchip/Kconfig    |   9 ++
 drivers/irqchip/Makefile   |   1 +
 drivers/irqchip/qcom-pdc.c | 311 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 321 insertions(+)
 create mode 100644 drivers/irqchip/qcom-pdc.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index c70476b34a53..506c6aa7f0b4 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -343,4 +343,13 @@ config MESON_IRQ_GPIO
        help
          Support Meson SoC Family GPIO Interrupt Multiplexer
 
+config QCOM_PDC
+	bool "QCOM PDC"
+	depends on ARCH_QCOM
+	select IRQ_DOMAIN
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  Power Domain Controller driver to manage and configure wakeup
+	  IRQs for Qualcomm Technologies Inc (QTI) mobile chips.
+
 endmenu
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index d2df34a54d38..280723d83916 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -84,3 +84,4 @@ obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
 obj-$(CONFIG_IRQ_UNIPHIER_AIDET)	+= irq-uniphier-aidet.o
 obj-$(CONFIG_ARCH_SYNQUACER)		+= irq-sni-exiu.o
 obj-$(CONFIG_MESON_IRQ_GPIO)		+= irq-meson-gpio.o
+obj-$(CONFIG_QCOM_PDC)			+= qcom-pdc.o
diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
new file mode 100644
index 000000000000..376e66c47868
--- /dev/null
+++ b/drivers/irqchip/qcom-pdc.c
@@ -0,0 +1,311 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Coyright (c) 2017-2018, The Linux Foundation. All rights reserved. */
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/spinlock.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#define PDC_MAX_IRQS		126
+
+#define CLEAR_INTR(reg, intr)	(reg & ~(1 << intr))
+#define ENABLE_INTR(reg, intr)	(reg | (1 << intr))
+
+#define IRQ_ENABLE_BANK		0x10
+#define IRQ_i_CFG		0x110
+
+struct pdc_pin_region {
+	u32 pin_base;
+	u32 parent_base;
+	u32 cnt;
+};
+
+static DEFINE_RAW_SPINLOCK(pdc_lock);
+static void __iomem *pdc_base;
+static struct pdc_pin_region *pdc_region;
+static int pdc_region_cnt;
+
+static void pdc_reg_write(int reg, u32 i, u32 val)
+{
+	writel_relaxed(val, pdc_base + reg + i * sizeof(u32));
+}
+
+static u32 pdc_reg_read(int reg, u32 i)
+{
+	return readl_relaxed(pdc_base + reg + i * sizeof(u32));
+}
+
+static void pdc_enable_intr(struct irq_data *d, bool on)
+{
+	int pin_out = d->hwirq;
+	u32 index, mask;
+	u32 enable;
+
+	index = pin_out / 32;
+	mask = pin_out % 32;
+
+	raw_spin_lock(&pdc_lock);
+	enable = pdc_reg_read(IRQ_ENABLE_BANK, index);
+	enable = on ? ENABLE_INTR(enable, mask) : CLEAR_INTR(enable, mask);
+	pdc_reg_write(IRQ_ENABLE_BANK, index, enable);
+	raw_spin_unlock(&pdc_lock);
+}
+
+static void qcom_pdc_gic_mask(struct irq_data *d)
+{
+	pdc_enable_intr(d, false);
+	irq_chip_mask_parent(d);
+}
+
+static void qcom_pdc_gic_unmask(struct irq_data *d)
+{
+	pdc_enable_intr(d, true);
+	irq_chip_unmask_parent(d);
+}
+
+/*
+ * GIC does not handle falling edge or active low. To allow falling edge and
+ * active low interrupts to be handled at GIC, PDC has an inverter that inverts
+ * falling edge into a rising edge and active low into an active high.
+ * For the inverter to work, the polarity bit in the IRQ_CONFIG register has to
+ * set as per the table below.
+ * (polarity, falling edge, rising edge ) POLARITY
+ * 3'b0 00  Level sensitive active low    LOW
+ * 3'b0 01  Rising edge sensitive         NOT USED
+ * 3'b0 10  Falling edge sensitive        LOW
+ * 3'b0 11  Dual Edge sensitive           NOT USED
+ * 3'b1 00  Level sensitive active High   HIGH
+ * 3'b1 01  Falling Edge sensitive        NOT USED
+ * 3'b1 10  Rising edge sensitive         HIGH
+ * 3'b1 11  Dual Edge sensitive           HIGH
+ */
+enum pdc_irq_config_bits {
+	PDC_POLARITY_LOW	= 0,
+	PDC_FALLING_EDGE	= 2,
+	PDC_POLARITY_HIGH	= 4,
+	PDC_RISING_EDGE		= 6,
+	PDC_DUAL_EDGE		= 7,
+};
+
+/**
+ * qcom_pdc_gic_set_type: Configure PDC for the interrupt
+ *
+ * @d: the interrupt data
+ * @type: the interrupt type
+ *
+ * If @type is edge triggered, forward that as Rising edge as PDC
+ * takes care of converting falling edge to rising edge signal
+ * If @type is level, then forward that as level high as PDC
+ * takes care of converting falling edge to rising edge signal
+ */
+static int qcom_pdc_gic_set_type(struct irq_data *d, unsigned int type)
+{
+	int pin_out = d->hwirq;
+	enum pdc_irq_config_bits pdc_type;
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+		pdc_type = PDC_RISING_EDGE;
+		type = IRQ_TYPE_EDGE_RISING;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		pdc_type = PDC_FALLING_EDGE;
+		type = IRQ_TYPE_EDGE_RISING;
+		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		pdc_type = PDC_DUAL_EDGE;
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		pdc_type = PDC_POLARITY_HIGH;
+		type = IRQ_TYPE_LEVEL_HIGH;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		pdc_type = PDC_POLARITY_LOW;
+		type = IRQ_TYPE_LEVEL_HIGH;
+		break;
+	default:
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	pdc_reg_write(IRQ_i_CFG, pin_out, pdc_type);
+
+	return irq_chip_set_type_parent(d, type);
+}
+
+static struct irq_chip qcom_pdc_gic_chip = {
+	.name			= "PDC",
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_mask		= qcom_pdc_gic_mask,
+	.irq_unmask		= qcom_pdc_gic_unmask,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_type		= qcom_pdc_gic_set_type,
+	.flags			= IRQCHIP_MASK_ON_SUSPEND |
+				  IRQCHIP_SET_TYPE_MASKED |
+				  IRQCHIP_SKIP_SET_WAKE,
+	.irq_set_vcpu_affinity	= irq_chip_set_vcpu_affinity_parent,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+};
+
+static irq_hw_number_t get_parent_hwirq(int pin)
+{
+	int i;
+	struct pdc_pin_region *region;
+
+	for (i = 0; i < pdc_region_cnt; i++) {
+		region = &pdc_region[i];
+		if (pin >= region->pin_base &&
+		   pin < region->pin_base + region->cnt)
+			return (region->parent_base + pin - region->pin_base);
+	}
+
+	WARN_ON(1);
+	return ~0UL;
+}
+
+static int qcom_pdc_translate(struct irq_domain *d,
+	struct irq_fwspec *fwspec, unsigned long *hwirq, unsigned int *type)
+{
+	if (is_of_node(fwspec->fwnode)) {
+		if (fwspec->param_count != 2)
+			return -EINVAL;
+
+		*hwirq = fwspec->param[0];
+		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int qcom_pdc_alloc(struct irq_domain *domain,
+			unsigned int virq, unsigned int nr_irqs, void *data)
+{
+	struct irq_fwspec *fwspec = data;
+	struct irq_fwspec parent_fwspec;
+	irq_hw_number_t hwirq, parent_hwirq;
+	unsigned int type;
+	int ret;
+
+	ret = qcom_pdc_translate(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return -EINVAL;
+
+	parent_hwirq = get_parent_hwirq(hwirq);
+	ret  = irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
+					    &qcom_pdc_gic_chip, NULL);
+	if (ret)
+		return ret;
+
+	if (type & IRQ_TYPE_EDGE_BOTH)
+		type = IRQ_TYPE_EDGE_RISING;
+
+	if (type & IRQ_TYPE_LEVEL_MASK)
+		type = IRQ_TYPE_LEVEL_HIGH;
+
+	parent_fwspec.fwnode = domain->parent->fwnode;
+	parent_fwspec.param_count = 3;
+	parent_fwspec.param[0] = 0;
+	parent_fwspec.param[1] = parent_hwirq;
+	parent_fwspec.param[2] = type;
+
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
+					   &parent_fwspec);
+}
+
+static const struct irq_domain_ops qcom_pdc_ops = {
+	.translate	= qcom_pdc_translate,
+	.alloc		= qcom_pdc_alloc,
+	.free		= irq_domain_free_irqs_common,
+};
+
+static int pdc_setup_pin_mapping(struct device_node *np)
+{
+	u32 *region = NULL;
+	int ret, n;
+
+	n = of_property_count_elems_of_size(np, "qcom,pdc-ranges", sizeof(u32));
+	if (n <= 0 || n % 3)
+		return -EINVAL;
+
+	region = kcalloc(n, sizeof(*region), GFP_KERNEL);
+	if (!region)
+		return -ENOMEM;
+
+	ret = of_property_read_u32_array(np, "qcom,pdc-ranges", region, n);
+	if (ret)
+		goto fail;
+
+	pdc_region_cnt = n / 3;
+	pdc_region = kcalloc(pdc_region_cnt, sizeof(*pdc_region), GFP_KERNEL);
+	if (!pdc_region) {
+		pdc_region_cnt = 0;
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	for (n = 0; n < pdc_region_cnt; n++, region += 3) {
+		pdc_region[n].pin_base    = region[0];
+		pdc_region[n].parent_base = region[1];
+		pdc_region[n].cnt         = region[2];
+	}
+
+fail:
+	kfree(region);
+	return ret;
+}
+
+static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
+{
+	struct irq_domain *parent_domain, *pdc_domain;
+	int ret;
+
+	pdc_base = of_iomap(node, 0);
+	if (!pdc_base) {
+		pr_err("%pOF: unable to map PDC registers\n", node->full_name);
+		return -ENXIO;
+	}
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		pr_err("%pOF: unable to find PDC's parent domain\n",
+		      node->full_name);
+		ret = -ENXIO;
+		goto failure;
+	}
+
+	ret = pdc_setup_pin_mapping(node);
+	if (ret) {
+		pr_err("%pOF: failed to init PDC pin-hwirq mapping\n",
+		      node->full_name);
+		goto failure;
+	}
+
+	pdc_domain = irq_domain_create_hierarchy(parent_domain, 0, PDC_MAX_IRQS,
+						of_fwnode_handle(node),
+						&qcom_pdc_ops, NULL);
+	if (!pdc_domain) {
+		pr_err("%pOF: GIC domain add failed\n", node->full_name);
+		ret = -ENOMEM;
+		goto failure;
+	}
+
+	return 0;
+
+failure:
+	kfree(pdc_region);
+	iounmap(pdc_base);
+	return ret;
+}
+
+IRQCHIP_DECLARE(pdc_sdm845, "qcom,sdm845-pdc", qcom_pdc_init);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
