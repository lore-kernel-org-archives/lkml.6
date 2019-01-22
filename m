Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5344DC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F2D20844
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="EMCQNF3C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbfAVPqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:46:20 -0500
Received: from forward100j.mail.yandex.net ([5.45.198.240]:50799 "EHLO
        forward100j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728669AbfAVPqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:46:19 -0500
Received: from mxback12j.mail.yandex.net (mxback12j.mail.yandex.net [IPv6:2a02:6b8:0:1619::87])
        by forward100j.mail.yandex.net (Yandex) with ESMTP id 5F80850E247A;
        Tue, 22 Jan 2019 18:46:15 +0300 (MSK)
Received: from smtp3p.mail.yandex.net (smtp3p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:8])
        by mxback12j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id YuXazfsq5q-kE4aD1AV;
        Tue, 22 Jan 2019 18:46:15 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1548171975;
        bh=G4v5w6eGKg28Woaxeh89gfls6qN6bwOiwEJGEUntx1g=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=EMCQNF3CrpbCKjN0aI31EC7Hgkz5FtgClEUQnJo5V5OE4IgaNFN8RK94KUGdW7pbF
         JMppLNF8EYgRB/ze4bPG42Ld+yU1Zcr/34nZgj9vMulmZxL/pXWJI9RDZXLccBxvrG
         5j/4+9tR+fV5wGPxdlbwuLcRpfAYbszWEb0F4Om4=
Authentication-Results: mxback12j.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp3p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id h0vAak8Ad8-k94KpeOx;
        Tue, 22 Jan 2019 18:46:12 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, paul.burton@mips.com,
        devicetree@vger.kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 1/2] irqchip: Add driver for Loongson-1 interrupt controller
Date:   Tue, 22 Jan 2019 23:45:56 +0800
Message-Id: <20190122154557.22689-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.20.1
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
 drivers/irqchip/irq-ls1x.c | 194 +++++++++++++++++++++++++++++++++++++
 3 files changed, 204 insertions(+)
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
index 000000000000..f8ca738ed25c
--- /dev/null
+++ b/drivers/irqchip/irq-ls1x.c
@@ -0,0 +1,194 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
+#include <asm/io.h>
+
+#include <asm/mach-loongson32/irq.h>
+
+struct ls_intc_data {
+	void __iomem *base;
+	unsigned int chip;
+};
+
+#define MAX_CHIPS	5
+#define LS_REG_INTC_STATUS	0x00
+#define LS_REG_INTC_EN	0x04
+#define LS_REG_INTC_SET	0x08
+#define LS_REG_INTC_CLR	0x0c
+#define LS_REG_INTC_POL 0x10
+#define LS_REG_INTC_EDGE 0x14
+#define CHIP_SIZE		0x18
+
+static irqreturn_t intc_cascade(int irq, void *data)
+{
+	struct ls_intc_data *intc = irq_get_handler_data(irq);
+	uint32_t irq_reg;
+
+	irq_reg = readl(intc->base + (CHIP_SIZE * intc->chip)
+					+ LS_REG_INTC_STATUS);
+	generic_handle_irq(__fls(irq_reg) + (intc->chip * 32) + LS1X_IRQ_BASE);
+
+	return IRQ_HANDLED;
+}
+
+static void ls_intc_set_bit(
+	struct irq_chip_generic *gc, unsigned int offset,
+	u32 mask, bool set)
+{
+	if (set)
+		writel(readl(gc->reg_base + offset) |
+		mask, gc->reg_base + offset);
+	else
+		writel(readl(gc->reg_base + offset) &
+		~mask, gc->reg_base + offset);
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
+	case IRQ_TYPE_NONE:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+
+static struct irqaction intc_cascade_action = {
+	.handler = intc_cascade,
+	.name = "intc cascade interrupt",
+};
+
+static int __init ls_intc_of_init(struct device_node *node,
+				       unsigned int num_chips)
+{
+	struct ls_intc_data *intc[MAX_CHIPS];
+	struct irq_chip_generic *gc;
+	struct irq_chip_type *ct;
+	struct irq_domain *domain;
+	void __iomem *base;
+	int parent_irq[MAX_CHIPS], err = 0;
+	unsigned int i = 0;
+
+	base = of_iomap(node, 0);
+	if (!base)
+		return -ENODEV;
+
+	for (i = 0; i < num_chips; i++) {
+		/* Mask all irqs */
+		writel(0x0, base + (i * CHIP_SIZE) +
+		       LS_REG_INTC_EN);
+
+		/* Set all irqs to high level triggered */
+		writel(0xffffffff, base + (i * CHIP_SIZE) +
+		       LS_REG_INTC_POL);
+
+		intc[i] = kzalloc(sizeof(*intc[i]), GFP_KERNEL);
+		if (!intc[i]) {
+			err = -ENOMEM;
+			goto out_err;
+		}
+
+		intc[i]->base = base;
+		intc[i]->chip = i;
+
+		parent_irq[i] = irq_of_parse_and_map(node, i);
+		if (!parent_irq[i]) {
+			pr_warn("unable to get parent irq for irqchip %u", i);
+			kfree(intc[i]);
+			intc[i] = NULL;
+			err = -EINVAL;
+			goto out_err;
+		}
+
+		err = irq_set_handler_data(parent_irq[i], intc[i]);
+		if (err)
+			goto out_err;
+
+		gc = irq_alloc_generic_chip("INTC", 1,
+					    LS1X_IRQ_BASE + (i * 32),
+					    base + (i * CHIP_SIZE),
+					    handle_level_irq);
+
+		ct = gc->chip_types;
+		ct->regs.mask = LS_REG_INTC_EN;
+		ct->regs.ack = LS_REG_INTC_CLR;
+		ct->chip.irq_unmask = irq_gc_mask_set_bit;
+		ct->chip.irq_mask = irq_gc_mask_clr_bit;
+		ct->chip.irq_ack = irq_gc_ack_set_bit;
+		ct->chip.irq_set_type = ls_intc_set_type;
+
+		irq_setup_generic_chip(gc, IRQ_MSK(32), 0, 0,
+				       IRQ_NOPROBE | IRQ_LEVEL);
+	}
+
+	domain = irq_domain_add_legacy(node, num_chips * 32, LS1X_IRQ_BASE, 0,
+				       &irq_domain_simple_ops, NULL);
+	if (!domain) {
+		pr_warn("unable to register IRQ domain\n");
+		err = -EINVAL;
+		goto out_err;
+	}
+
+	for (i = 0; i < num_chips; i++)
+		setup_irq(parent_irq[i], &intc_cascade_action);
+
+	return 0;
+
+out_err:
+	for (i = 0; i < MAX_CHIPS; i++) {
+		if (intc[i]) {
+			kfree(intc[i]);
+			irq_dispose_mapping(parent_irq[i]);
+		} else {
+			break;
+		}
+	}
+	return err;
+}
+
+static int __init intc_4chip_of_init(struct device_node *node,
+				     struct device_node *parent)
+{
+	return ls_intc_of_init(node, 4);
+}
+IRQCHIP_DECLARE(ls1b_intc, "loongson,ls1b-intc", intc_4chip_of_init);
+
+static int __init intc_5chip_of_init(struct device_node *node,
+	struct device_node *parent)
+{
+	return ls_intc_of_init(node, 5);
+}
+IRQCHIP_DECLARE(ls1c_intc, "loongson,ls1c-intc", intc_5chip_of_init);
-- 
2.20.1

