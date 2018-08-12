Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0ADBC46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 12:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F16E21A3A
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 12:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F16E21A3A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbeHLPAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 11:00:52 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:39738 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbeHLPAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 11:00:51 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 41pJ0N1cxzz1qwCt;
        Sun, 12 Aug 2018 14:22:40 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 41pJ0J4yRRz1qqlF;
        Sun, 12 Aug 2018 14:22:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id ca5mxRb0KNYR; Sun, 12 Aug 2018 14:22:38 +0200 (CEST)
X-Auth-Info: APiCeDnHo1PokcrHtITTskpO8eoNsfGnrhYTCxpNQCw=
Received: from xpert.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 12 Aug 2018 14:22:38 +0200 (CEST)
From:   Parthiban Nallathambi <pn@denx.de>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        catalin.marinas@arm.com, will.deacon@arm.com,
        manivannan.sadhasivam@linaro.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, sravanhome@gmail.com,
        thomas.liau@actions-semi.com, mp-cs@actions-semi.com,
        linux@cubietech.com, edgar.righi@lsitec.org.br,
        laisa.costa@lsitec.org.br, guilherme.simoes@lsitec.org.br,
        mkzuffo@lsi.usp.br, Parthiban Nallathambi <pn@denx.de>
Subject: [PATCH v2 2/3] drivers/irqchip: Add Actions external interrupts support
Date:   Sun, 12 Aug 2018 14:22:14 +0200
Message-Id: <20180812122215.1079590-3-pn@denx.de>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180812122215.1079590-1-pn@denx.de>
References: <20180812122215.1079590-1-pn@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actions Semi Owl family SoC's S500, S700 and S900 provides support
for 3 external interrupt controllers through SIRQ pins.

Each line can be independently configured as interrupt and triggers
on either of the edges (raising or falling) or either of the levels
(high or low) . Each line can also be masked independently.

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 drivers/irqchip/Makefile       |   1 +
 drivers/irqchip/irq-owl-sirq.c | 305 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 306 insertions(+)
 create mode 100644 drivers/irqchip/irq-owl-sirq.c

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 15f268f646bf..072c4409e7c4 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_ATH79)			+= irq-ath79-misc.o
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2836.o
 obj-$(CONFIG_ARCH_EXYNOS)		+= exynos-combiner.o
+obj-$(CONFIG_ARCH_ACTIONS)		+= irq-owl-sirq.o
 obj-$(CONFIG_FARADAY_FTINTC010)		+= irq-ftintc010.o
 obj-$(CONFIG_ARCH_HIP04)		+= irq-hip04.o
 obj-$(CONFIG_ARCH_LPC32XX)		+= irq-lpc32xx.o
diff --git a/drivers/irqchip/irq-owl-sirq.c b/drivers/irqchip/irq-owl-sirq.c
new file mode 100644
index 000000000000..b69301388300
--- /dev/null
+++ b/drivers/irqchip/irq-owl-sirq.c
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *
+ * Actions Semi Owl SoCs SIRQ interrupt controller driver
+ *
+ * Copyright (C) 2014 Actions Semi Inc.
+ * David Liu <liuwei@actions-semi.com>
+ *
+ * Author: Parthiban Nallathambi <pn@denx.de>
+ * Author: Saravanan Sekar <sravanhome@gmail.com>
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irqchip.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+#define INTC_GIC_INTERRUPT_PIN		13
+#define INTC_EXTCTL_PENDING		BIT(0)
+#define INTC_EXTCTL_CLK_SEL		BIT(4)
+#define INTC_EXTCTL_EN			BIT(5)
+#define	INTC_EXTCTL_TYPE_MASK		GENMASK(6, 7)
+#define	INTC_EXTCTL_TYPE_HIGH		0
+#define	INTC_EXTCTL_TYPE_LOW		BIT(6)
+#define	INTC_EXTCTL_TYPE_RISING		BIT(7)
+#define	INTC_EXTCTL_TYPE_FALLING	(BIT(6) | BIT(7))
+
+#define get_sirq_offset(x)	chip_data->sirq[x].offset
+
+/* Per SIRQ data */
+struct owl_sirq {
+	u16 offset;
+	/* software is responsible to clear interrupt pending bit when
+	 * type is edge triggered. This value is for per SIRQ line.
+	 */
+	bool type_edge;
+};
+
+struct owl_sirq_chip_data {
+	void __iomem *base;
+	raw_spinlock_t lock;
+	/* some SoC's share the register for all SIRQ lines, so maintain
+	 * register is shared or not here. This value is from DT.
+	 */
+	bool shared_reg;
+	struct owl_sirq *sirq;
+};
+
+static struct owl_sirq_chip_data *sirq_data;
+
+static unsigned int sirq_read_extctl(struct irq_data *data)
+{
+	struct owl_sirq_chip_data *chip_data = data->chip_data;
+	unsigned int val;
+
+	val = readl_relaxed(chip_data->base + get_sirq_offset(data->hwirq));
+	if (chip_data->shared_reg)
+		val = (val >> (2 - data->hwirq) * 8) & 0xff;
+
+	return val;
+}
+
+static void sirq_write_extctl(struct irq_data *data, unsigned int extctl)
+{
+	struct owl_sirq_chip_data *chip_data = data->chip_data;
+	unsigned int val;
+
+	if (chip_data->shared_reg) {
+		val = readl_relaxed(chip_data->base +
+				get_sirq_offset(data->hwirq));
+		val &= ~(0xff << (2 - data->hwirq) * 8);
+		extctl &= 0xff;
+		extctl = (extctl << (2 - data->hwirq) * 8) | val;
+	}
+
+	writel_relaxed(extctl, chip_data->base +
+			get_sirq_offset(data->hwirq));
+}
+
+static void owl_sirq_ack(struct irq_data *data)
+{
+	struct owl_sirq_chip_data *chip_data = data->chip_data;
+	unsigned int extctl;
+	unsigned long flags;
+
+	/* software must clear external interrupt pending, when interrupt type
+	 * is edge triggered, so we need per SIRQ based clearing.
+	 */
+	if (chip_data->sirq[data->hwirq].type_edge) {
+		raw_spin_lock_irqsave(&chip_data->lock, flags);
+
+		extctl = sirq_read_extctl(data);
+		extctl |= INTC_EXTCTL_PENDING;
+		sirq_write_extctl(data, extctl);
+
+		raw_spin_unlock_irqrestore(&chip_data->lock, flags);
+	}
+	irq_chip_ack_parent(data);
+}
+
+static void owl_sirq_mask(struct irq_data *data)
+{
+	struct owl_sirq_chip_data *chip_data = data->chip_data;
+	unsigned int extctl;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&chip_data->lock, flags);
+
+	extctl = sirq_read_extctl(data);
+	extctl &= ~(INTC_EXTCTL_EN);
+	sirq_write_extctl(data, extctl);
+
+	raw_spin_unlock_irqrestore(&chip_data->lock, flags);
+	irq_chip_mask_parent(data);
+}
+
+static void owl_sirq_unmask(struct irq_data *data)
+{
+	struct owl_sirq_chip_data *chip_data = data->chip_data;
+	unsigned int extctl;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&chip_data->lock, flags);
+
+	extctl = sirq_read_extctl(data);
+	extctl |= INTC_EXTCTL_EN;
+	sirq_write_extctl(data, extctl);
+
+	raw_spin_unlock_irqrestore(&chip_data->lock, flags);
+	irq_chip_unmask_parent(data);
+}
+
+/* PAD_PULLCTL needs to be defined in pinctrl */
+static int owl_sirq_set_type(struct irq_data *data, unsigned int flow_type)
+{
+	struct owl_sirq_chip_data *chip_data = data->chip_data;
+	unsigned int extctl, type;
+	unsigned long flags;
+
+	switch (flow_type) {
+	case IRQF_TRIGGER_LOW:
+		type = INTC_EXTCTL_TYPE_LOW;
+		break;
+	case IRQF_TRIGGER_HIGH:
+		type = INTC_EXTCTL_TYPE_HIGH;
+		break;
+	case IRQF_TRIGGER_FALLING:
+		type = INTC_EXTCTL_TYPE_FALLING;
+		chip_data->sirq[data->hwirq].type_edge = true;
+		break;
+	case IRQF_TRIGGER_RISING:
+		type = INTC_EXTCTL_TYPE_RISING;
+		chip_data->sirq[data->hwirq].type_edge = true;
+		break;
+	default:
+		return  -EINVAL;
+	}
+
+	raw_spin_lock_irqsave(&chip_data->lock, flags);
+
+	extctl = sirq_read_extctl(data);
+	extctl &= ~INTC_EXTCTL_TYPE_MASK;
+	extctl |= type;
+	sirq_write_extctl(data, extctl);
+
+	raw_spin_unlock_irqrestore(&chip_data->lock, flags);
+	data = data->parent_data;
+	return irq_chip_set_type_parent(data, flow_type);
+}
+
+static struct irq_chip owl_sirq_chip = {
+	.name		= "owl-sirq",
+	.irq_ack	= owl_sirq_ack,
+	.irq_mask	= owl_sirq_mask,
+	.irq_unmask	= owl_sirq_unmask,
+	.irq_set_type	= owl_sirq_set_type,
+	.irq_eoi	= irq_chip_eoi_parent,
+	.irq_retrigger	= irq_chip_retrigger_hierarchy,
+};
+
+static int owl_sirq_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				 unsigned int nr_irqs, void *arg)
+{
+	struct irq_fwspec *fwspec = arg;
+	struct irq_fwspec parent_fwspec = {
+		.param_count	= 3,
+		.param[0]	= GIC_SPI,
+		.param[1]	= fwspec->param[0] + INTC_GIC_INTERRUPT_PIN,
+		.param[2]	= fwspec->param[1],
+		.fwnode		= domain->parent->fwnode,
+	};
+
+	if (WARN_ON(nr_irqs != 1))
+		return -EINVAL;
+
+	irq_domain_set_hwirq_and_chip(domain, virq, fwspec->param[0],
+				      &owl_sirq_chip,
+				      domain->host_data);
+
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
+					    &parent_fwspec);
+}
+
+static const struct irq_domain_ops sirq_domain_ops = {
+	.alloc	= owl_sirq_domain_alloc,
+	.free	= irq_domain_free_irqs_common,
+};
+
+static void owl_sirq_clk_init(int offset, int hwirq)
+{
+	unsigned int val;
+
+	/* register default clock is 32Khz, change to 24Mhz only when defined */
+	val = readl_relaxed(sirq_data->base + offset);
+	if (sirq_data->shared_reg)
+		val |= INTC_EXTCTL_CLK_SEL << (2 - hwirq) * 8;
+	else
+		val |= INTC_EXTCTL_CLK_SEL;
+
+	writel_relaxed(val, sirq_data->base + offset);
+}
+
+static int __init owl_sirq_of_init(struct device_node *node,
+					struct device_node *parent)
+{
+	struct irq_domain *domain, *domain_parent;
+	int ret = 0, i, sirq_cnt = 0;
+	struct owl_sirq_chip_data *chip_data;
+
+	sirq_cnt = of_property_count_u32_elems(node, "actions,sirq-offset");
+	if (sirq_cnt <= 0) {
+		pr_err("owl_sirq: register offset not specified\n");
+		return -EINVAL;
+	}
+
+	chip_data = kzalloc(sizeof(*chip_data), GFP_KERNEL);
+	if (!chip_data)
+		return -ENOMEM;
+	sirq_data = chip_data;
+
+	chip_data->sirq = kcalloc(sirq_cnt, sizeof(*chip_data->sirq),
+				GFP_KERNEL);
+	if (!chip_data->sirq)
+		goto out_free;
+
+	raw_spin_lock_init(&chip_data->lock);
+	chip_data->base = of_iomap(node, 0);
+	if (!chip_data->base) {
+		pr_err("owl_sirq: unable to map sirq register\n");
+		ret = -ENXIO;
+		goto out_free;
+	}
+
+	chip_data->shared_reg = of_property_read_bool(node,
+						"actions,sirq-shared-reg");
+	for (i = 0; i < sirq_cnt; i++) {
+		u32 value;
+
+		ret = of_property_read_u32_index(node, "actions,sirq-offset",
+						i, &value);
+		if (ret)
+			goto out_unmap;
+
+		get_sirq_offset(i) = (u16)value;
+
+		ret = of_property_read_u32_index(node, "actions,sirq-clk-sel",
+						i, &value);
+		if (ret || !value)
+			continue;
+
+		/* external interrupt controller can be either connect to 32Khz/
+		 * 24Mhz external/internal clock. This shall be configured for
+		 * per SIRQ line. It can be defined from DT, failing defaults to
+		 * 24Mhz clock.
+		 */
+		owl_sirq_clk_init(get_sirq_offset(i), i);
+	}
+
+	domain_parent = irq_find_host(parent);
+	if (!domain_parent) {
+		pr_err("owl_sirq: interrupt-parent not found\n");
+		goto out_unmap;
+	}
+
+	domain = irq_domain_add_hierarchy(domain_parent, 0,
+			sirq_cnt, node,
+			&sirq_domain_ops, chip_data);
+	if (!domain) {
+		ret = -ENOMEM;
+		goto out_unmap;
+	}
+
+	return 0;
+
+out_unmap:
+	iounmap(chip_data->base);
+out_free:
+	kfree(chip_data);
+	kfree(chip_data->sirq);
+	return ret;
+}
+
+IRQCHIP_DECLARE(owl_sirq, "actions,owl-sirq", owl_sirq_of_init);
-- 
2.14.4

