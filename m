Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8E3C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 06:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B1020869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 06:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="TKeJ2JtK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfBAGXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 01:23:03 -0500
Received: from forward102p.mail.yandex.net ([77.88.28.102]:33695 "EHLO
        forward102p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725763AbfBAGXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 01:23:02 -0500
Received: from mxback12o.mail.yandex.net (mxback12o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::63])
        by forward102p.mail.yandex.net (Yandex) with ESMTP id 457841D41C19;
        Fri,  1 Feb 2019 09:22:59 +0300 (MSK)
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [2a02:6b8:0:1a2d::26])
        by mxback12o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id URhlKJIYWY-MwuOK1gZ;
        Fri, 01 Feb 2019 09:22:59 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1549002179;
        bh=a0M/oCUL4WavEKWI8PHduKj9eDY+SA1DunxKtYXj5vU=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=TKeJ2JtKJ4BviulyVuAwVJVmU3Hq7RleMjgXW3XbBu4IfJVU5JS/NnzxCjaoDTFYa
         bD3snPZQEa6MLQqAqTQ0qMOmEQbMdBNfoFa9o4JteUrrbR2wvvfGsGG6ev/IUT93+c
         FOvAzJESQoJT/CUesCovO73onpX8yKWHwlKuhjEM=
Authentication-Results: mxback12o.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 0W2FVbEhhw-Mq1q6sHB;
        Fri, 01 Feb 2019 09:22:56 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v6 1/2] irqchip: Add driver for Loongson-1 interrupt controller
Date:   Fri,  1 Feb 2019 14:22:35 +0800
Message-Id: <20190201062236.17903-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201062236.17903-1-jiaxun.yang@flygoat.com>
References: <20190122154557.22689-1-jiaxun.yang@flygoat.com>
 <20190201062236.17903-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This controller appeared on Loongson-1 family MCUs
including Loongson-1B and Loongson-1C.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/irqchip/Kconfig    |   9 ++
 drivers/irqchip/Makefile   |   1 +
 drivers/irqchip/irq-ls1x.c | 192 +++++++++++++++++++++++++++++++++++++
 3 files changed, 202 insertions(+)
 create mode 100644 drivers/irqchip/irq-ls1x.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 3d1e60779078..5dcb5456cd14 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -406,6 +406,15 @@ config IMX_IRQSTEER
 	help
 	  Support for the i.MX IRQSTEER interrupt multiplexer/remapper.
 
+config LS1X_IRQ
+	bool "Loongson-1 Interrupt Controller"
+	depends on MACH_LOONGSON32
+	default y
+	select IRQ_DOMAIN
+	select GENERIC_IRQ_CHIP
+	help
+	  Support for the Loongson-1 platform Interrupt Controller.
+
 endmenu
 
 config SIFIVE_PLIC
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index c93713d24b86..7acd0e36d0b4 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -94,3 +94,4 @@ obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
 obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
 obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
 obj-$(CONFIG_MADERA_IRQ)		+= irq-madera.o
+obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
diff --git a/drivers/irqchip/irq-ls1x.c b/drivers/irqchip/irq-ls1x.c
new file mode 100644
index 000000000000..79967d8df53e
--- /dev/null
+++ b/drivers/irqchip/irq-ls1x.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2019, Jiaxun Yang <jiaxun.yang@flygoat.com>
+ *  Loongson-1 platform IRQ support
+ */
+
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/irqchip.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/io.h>
+#include <linux/irqchip/chained_irq.h>
+
+#define LS_REG_INTC_STATUS	0x00
+#define LS_REG_INTC_EN	0x04
+#define LS_REG_INTC_SET	0x08
+#define LS_REG_INTC_CLR	0x0c
+#define LS_REG_INTC_POL	0x10
+#define LS_REG_INTC_EDGE	0x14
+
+/**
+ * struct ls1x_intc_priv - private ls1x-intc data.
+ * @domain:		IRQ domain.
+ * @intc_base:	IO Base of intc registers.
+ */
+
+struct ls1x_intc_priv {
+	struct irq_domain	*domain;
+	void __iomem		*intc_base;
+};
+
+
+static void ls1x_chained_handle_irq(struct irq_desc *desc)
+{
+	struct ls1x_intc_priv *priv = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	u32 pending;
+
+	chained_irq_enter(chip, desc);
+	pending = readl(priv->intc_base + LS_REG_INTC_STATUS) &
+			readl(priv->intc_base + LS_REG_INTC_EN);
+
+	if (!pending)
+		spurious_interrupt();
+
+	while (pending) {
+		int bit = __ffs(pending);
+
+		generic_handle_irq(irq_find_mapping(priv->domain, bit));
+		pending &= ~BIT(bit);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void ls_intc_set_bit(struct irq_chip_generic *gc,
+							unsigned int offset,
+							u32 mask, bool set)
+{
+	if (set)
+		writel(readl(gc->reg_base + offset) | mask,
+		gc->reg_base + offset);
+	else
+		writel(readl(gc->reg_base + offset) & ~mask,
+		gc->reg_base + offset);
+}
+
+static int ls_intc_set_type(struct irq_data *data, unsigned int type)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
+	u32 mask = data->mask;
+
+	switch (type) {
+	case IRQ_TYPE_LEVEL_HIGH:
+		ls_intc_set_bit(gc, LS_REG_INTC_EDGE, mask, false);
+		ls_intc_set_bit(gc, LS_REG_INTC_POL, mask, true);
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		ls_intc_set_bit(gc, LS_REG_INTC_EDGE, mask, false);
+		ls_intc_set_bit(gc, LS_REG_INTC_POL, mask, false);
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		ls_intc_set_bit(gc, LS_REG_INTC_EDGE, mask, true);
+		ls_intc_set_bit(gc, LS_REG_INTC_POL, mask, true);
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		ls_intc_set_bit(gc, LS_REG_INTC_EDGE, mask, true);
+		ls_intc_set_bit(gc, LS_REG_INTC_POL, mask, false);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	irqd_set_trigger_type(data, type);
+	return irq_setup_alt_chip(data, type);
+}
+
+
+static int __init ls1x_intc_of_init(struct device_node *node,
+				       struct device_node *parent)
+{
+	struct irq_chip_generic *gc;
+	struct irq_chip_type *ct;
+	struct ls1x_intc_priv *priv;
+	int parent_irq, err = 0;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->intc_base = of_iomap(node, 0);
+	if (!priv->intc_base) {
+		err = -ENODEV;
+		goto out_free_priv;
+	}
+
+	parent_irq = irq_of_parse_and_map(node, 0);
+	if (!parent_irq) {
+		pr_err("ls1x-irq: unable to get parent irq\n");
+		err =  -ENODEV;
+		goto out_iounmap;
+	}
+
+	/* Set up an IRQ domain */
+	priv->domain = irq_domain_add_linear(node, 32, &irq_generic_chip_ops,
+					     NULL);
+	if (!priv->domain) {
+		pr_err("ls1x-irq: cannot add IRQ domain\n");
+		goto out_iounmap;
+	}
+
+	err = irq_alloc_domain_generic_chips(priv->domain, 32, 2,
+		node->full_name, handle_level_irq,
+		IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN, 0,
+		IRQ_GC_INIT_MASK_CACHE);
+	if (err) {
+		pr_err("ls1x-irq: unable to register IRQ domain\n");
+		goto out_free_domain;
+	}
+
+	/* Mask all irqs */
+	writel(0x0, priv->intc_base + LS_REG_INTC_EN);
+
+	/* Ack all irqs */
+	writel(0xffffffff, priv->intc_base + LS_REG_INTC_CLR);
+
+	/* Set all irqs to high level triggered */
+	writel(0xffffffff, priv->intc_base + LS_REG_INTC_POL);
+
+	gc = irq_get_domain_generic_chip(priv->domain, 0);
+
+	gc->reg_base = priv->intc_base;
+
+	ct = gc->chip_types;
+	ct[0].type = IRQ_TYPE_LEVEL_MASK;
+	ct[0].regs.mask = LS_REG_INTC_EN;
+	ct[0].regs.ack = LS_REG_INTC_CLR;
+	ct[0].chip.irq_unmask = irq_gc_mask_set_bit;
+	ct[0].chip.irq_mask = irq_gc_mask_clr_bit;
+	ct[0].chip.irq_ack = irq_gc_ack_set_bit;
+	ct[0].chip.irq_set_type = ls_intc_set_type;
+	ct[0].handler = handle_level_irq;
+
+	ct[1].type = IRQ_TYPE_EDGE_BOTH;
+	ct[1].regs.mask = LS_REG_INTC_EN;
+	ct[1].regs.ack = LS_REG_INTC_CLR;
+	ct[1].chip.irq_unmask = irq_gc_mask_set_bit;
+	ct[1].chip.irq_mask = irq_gc_mask_clr_bit;
+	ct[1].chip.irq_ack = irq_gc_ack_set_bit;
+	ct[1].chip.irq_set_type = ls_intc_set_type;
+	ct[1].handler = handle_edge_irq;
+
+	irq_set_chained_handler_and_data(parent_irq,
+		ls1x_chained_handle_irq, priv);
+
+	return 0;
+
+out_free_domain:
+	irq_domain_remove(priv->domain);
+out_iounmap:
+	iounmap(priv->intc_base);
+out_free_priv:
+	kfree(priv);
+	
+	return err;
+}
+
+IRQCHIP_DECLARE(ls1x_intc, "loongson,ls1x-intc", ls1x_intc_of_init);
-- 
2.20.1

