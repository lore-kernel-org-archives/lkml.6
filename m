Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529EEECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A3D20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A3D20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388775AbeGXQJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:09:58 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:59856 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388718AbeGXQJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:09:57 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 41ZhS46Fcjz1qxDv;
        Tue, 24 Jul 2018 17:03:00 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 41ZhS43wytz1tLPC;
        Tue, 24 Jul 2018 17:03:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 4Ci_OOu-wJ6q; Tue, 24 Jul 2018 17:02:56 +0200 (CEST)
X-Auth-Info: qZG2BAFAN6E2PtDgsUIodDmsDHVqgtPcG+VV0IvZbC0=
Received: from xpert.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 24 Jul 2018 17:02:56 +0200 (CEST)
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
Subject: [PATCH 2/3] drivers/irqchip: Add Actions external interrupts support
Date:   Tue, 24 Jul 2018 17:02:18 +0200
Message-Id: <20180724150219.1807724-3-pn@denx.de>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180724150219.1807724-1-pn@denx.de>
References: <20180724150219.1807724-1-pn@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actions Semi Owl family SoC's S500, S700 and S900 provides support
for 3 external interrupt controllers through SIRQ pins.

Each line can be independently configured as interrupt or wake-up source,
and triggers either on rising, falling or both edges. Each line can also
be masked independently.

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 drivers/irqchip/Makefile       |   1 +
 drivers/irqchip/irq-owl-sirq.c | 275 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 276 insertions(+)
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
index 000000000000..8605da99d77d
--- /dev/null
+++ b/drivers/irqchip/irq-owl-sirq.c
@@ -0,0 +1,275 @@
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
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/of_irq.h>
+#include <linux/irqchip.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <linux/irqdomain.h>
+#include <linux/of_address.h>
+#include <linux/irqchip/chained_irq.h>
+
+#define OWL_MAX_NR_SIRQS	3
+
+/* INTC_EXTCTL register offset for S900 */
+#define S900_INTC_EXTCTL0	0x200
+#define S900_INTC_EXTCTL1	0x528
+#define S900_INTC_EXTCTL2	0x52C
+
+/* INTC_EXTCTL register offset for S700 */
+#define S700_INTC_EXTCTL	0x200
+
+#define INTC_EXTCTL_PENDING		BIT(0)
+#define INTC_EXTCTL_CLK_SEL		BIT(4)
+#define INTC_EXTCTL_EN			BIT(5)
+#define	INTC_EXTCTL_TYPE_MASK		GENMASK(6, 7)
+#define	INTC_EXTCTL_TYPE_HIGH		0
+#define	INTC_EXTCTL_TYPE_LOW		BIT(6)
+#define	INTC_EXTCTL_TYPE_RISING		BIT(7)
+#define	INTC_EXTCTL_TYPE_FALLING	(BIT(6) | BIT(7))
+
+struct owl_sirq_info {
+	void __iomem		*base;
+	struct irq_domain	*irq_domain;
+	unsigned long		reg;
+	unsigned long		hwirq;
+	unsigned int		virq;
+	unsigned int		parent_irq;
+	bool			share_reg;
+	spinlock_t		lock;
+};
+
+/* s900 has INTC_EXTCTL individual register to handle each line */
+static struct owl_sirq_info s900_sirq_info[OWL_MAX_NR_SIRQS] = {
+	{ .reg = S900_INTC_EXTCTL0, .share_reg = false },
+	{ .reg = S900_INTC_EXTCTL1, .share_reg = false },
+	{ .reg = S900_INTC_EXTCTL2, .share_reg = false },
+};
+
+/* s500 and s700 shares the 32 bit (24 usable) register for each line */
+static struct owl_sirq_info s700_sirq_info[OWL_MAX_NR_SIRQS] = {
+	{ .reg = S700_INTC_EXTCTL, .share_reg = true },
+	{ .reg = S700_INTC_EXTCTL, .share_reg = true },
+	{ .reg = S700_INTC_EXTCTL, .share_reg = true },
+};
+
+static unsigned int sirq_read_extctl(struct owl_sirq_info *sirq)
+{
+	unsigned int val;
+
+	val = readl_relaxed(sirq->base + sirq->reg);
+	if (sirq->share_reg)
+		val = (val >> (2 - sirq->hwirq) * 8) & 0xff;
+
+	return val;
+}
+
+static void sirq_write_extctl(struct owl_sirq_info *sirq, unsigned int extctl)
+{
+	unsigned int val;
+
+	if (sirq->share_reg) {
+		val = readl_relaxed(sirq->base + sirq->reg);
+		val &= ~(0xff << (2 - sirq->hwirq) * 8);
+		extctl &= 0xff;
+		extctl = (extctl << (2 - sirq->hwirq) * 8) | val;
+	}
+
+	writel_relaxed(extctl, sirq->base + sirq->reg);
+}
+
+static void owl_sirq_ack(struct irq_data *d)
+{
+	struct owl_sirq_info *sirq = irq_data_get_irq_chip_data(d);
+	unsigned int extctl;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sirq->lock, flags);
+
+	extctl = sirq_read_extctl(sirq);
+	extctl |= INTC_EXTCTL_PENDING;
+	sirq_write_extctl(sirq, extctl);
+
+	spin_unlock_irqrestore(&sirq->lock, flags);
+}
+
+static void owl_sirq_mask(struct irq_data *d)
+{
+	struct owl_sirq_info *sirq = irq_data_get_irq_chip_data(d);
+	unsigned int extctl;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sirq->lock, flags);
+
+	extctl = sirq_read_extctl(sirq);
+	extctl &= ~(INTC_EXTCTL_EN);
+	sirq_write_extctl(sirq, extctl);
+
+	spin_unlock_irqrestore(&sirq->lock, flags);
+}
+
+static void owl_sirq_unmask(struct irq_data *d)
+{
+	struct owl_sirq_info *sirq = irq_data_get_irq_chip_data(d);
+	unsigned int extctl;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sirq->lock, flags);
+
+	/* we don't hold the irq pending generated before irq enabled */
+	extctl = sirq_read_extctl(sirq);
+	extctl |= INTC_EXTCTL_EN;
+	sirq_write_extctl(sirq, extctl);
+
+	spin_unlock_irqrestore(&sirq->lock, flags);
+}
+
+/* PAD_PULLCTL needs to be defined in pinctrl */
+static int owl_sirq_set_type(struct irq_data *d, unsigned int flow_type)
+{
+	struct owl_sirq_info *sirq = irq_data_get_irq_chip_data(d);
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
+		break;
+	case IRQF_TRIGGER_RISING:
+		type = INTC_EXTCTL_TYPE_RISING;
+		break;
+	default:
+		return  -EINVAL;
+	}
+
+	spin_lock_irqsave(&sirq->lock, flags);
+
+	extctl = sirq_read_extctl(sirq);
+	extctl &= ~(INTC_EXTCTL_PENDING | INTC_EXTCTL_TYPE_MASK);
+	extctl |= type;
+	sirq_write_extctl(sirq, extctl);
+
+	spin_unlock_irqrestore(&sirq->lock, flags);
+
+	return 0;
+}
+
+static void owl_sirq_handler(struct irq_desc *desc)
+{
+	struct owl_sirq_info *sirq = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned int extctl;
+
+	chained_irq_enter(chip, desc);
+
+	extctl = sirq_read_extctl(sirq);
+	if (extctl & INTC_EXTCTL_PENDING)
+		generic_handle_irq(sirq->virq);
+
+	chained_irq_exit(chip, desc);
+}
+
+static struct irq_chip owl_irq_chip = {
+	.name = "owl-sirq",
+	.irq_ack = owl_sirq_ack,
+	.irq_mask = owl_sirq_mask,
+	.irq_unmask = owl_sirq_unmask,
+	.irq_set_type = owl_sirq_set_type,
+};
+
+static int __init owl_sirq_init(struct owl_sirq_info *sirq_info, int nr_sirq,
+				struct device_node *np)
+{
+	struct owl_sirq_info *sirq;
+	void __iomem *base;
+	struct irq_domain *irq_domain;
+	int i, irq_base;
+	unsigned int extctl;
+	u8 sample_clk[OWL_MAX_NR_SIRQS];
+
+	base = of_iomap(np, 0);
+	if (!base)
+		return -ENOMEM;
+
+	irq_base = irq_alloc_descs(-1, 32, nr_sirq, 0);
+	if (irq_base < 0) {
+		pr_err("sirq: failed to allocate IRQ numbers\n");
+		goto out_unmap;
+	}
+
+	irq_domain = irq_domain_add_legacy(np, nr_sirq, irq_base, 0,
+					&irq_domain_simple_ops, NULL);
+	if (!irq_domain) {
+		pr_err("sirq: irq domain init failed\n");
+		goto out_free_desc;
+	}
+
+	memset(sample_clk, 0, sizeof(sample_clk));
+	of_property_read_u8_array(np, "sampling-rate-24m", sample_clk,
+				nr_sirq);
+
+	for (i = 0; i < nr_sirq; i++) {
+		sirq = &sirq_info[i];
+
+		sirq->base = base;
+		sirq->irq_domain = irq_domain;
+		sirq->hwirq = i;
+		sirq->virq = irq_base + i;
+
+		sirq->parent_irq = irq_of_parse_and_map(np, i);
+		irq_set_handler_data(sirq->parent_irq, sirq);
+		irq_set_chained_handler_and_data(sirq->parent_irq,
+						owl_sirq_handler, sirq);
+
+		irq_set_chip_and_handler(sirq->virq, &owl_irq_chip,
+				handle_level_irq);
+		irq_set_chip_data(sirq->virq, sirq);
+
+		if (sample_clk[i]) {
+			extctl = sirq_read_extctl(sirq);
+			extctl |= INTC_EXTCTL_CLK_SEL;
+			sirq_write_extctl(sirq, extctl);
+		}
+		spin_lock_init(&sirq->lock);
+	}
+
+	return 0;
+
+out_free_desc:
+	irq_free_descs(irq_base, nr_sirq);
+out_unmap:
+	iounmap(base);
+
+	return -EINVAL;
+}
+
+static int __init s700_sirq_of_init(struct device_node *np,
+					struct device_node *parent)
+{
+	return owl_sirq_init(s700_sirq_info, ARRAY_SIZE(s700_sirq_info), np);
+}
+IRQCHIP_DECLARE(s700_sirq, "actions,s700-sirq", s700_sirq_of_init);
+
+static int __init s900_sirq_of_init(struct device_node *np,
+					struct device_node *parent)
+{
+	return owl_sirq_init(s900_sirq_info, ARRAY_SIZE(s900_sirq_info), np);
+}
+IRQCHIP_DECLARE(s900_sirq, "actions,s900-sirq", s900_sirq_of_init);
-- 
2.14.4

