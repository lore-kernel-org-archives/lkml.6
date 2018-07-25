Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3C6C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB5D20671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ez0KWJko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB5D20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbeGYKsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 06:48:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43090 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbeGYKsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 06:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=liX0BELlvsA0Dl8YJdUznS8FTBnVlY6yzne8y+ydW6w=; b=ez0KWJkoMHw8gAaFFqg3fYe1m
        sXS29p+3DBPm/qTcNz7kQ2WD1vjo+nUN4jUFXs10cIB6ld/10YIEirUybqaBg5EvDLQm/5+B5nJue
        cbmOUWOwEPLFcs8FqQNhte1oe2m9UPKUfiGSGMWS8M9tJfp/0bvAjmXlcExK4E7c0t4gXGkNFJDuE
        LYNoS7HBnxazVDDz7X5EJYTDCIhTxMRNZloYZbTX/gx1oMB4buP+9afdcAxl0aXNzn472mfLNn6Jz
        DJ5HCO64aYDAFakyE1sKX/+XJa9LN/90ZQHlp6jfkhD2gfL1YB9+IDCKva7pvcfaMGZMBxtXokhNz
        2RMIUpn+g==;
Received: from [91.112.108.175] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fiGEG-0005K8-TI; Wed, 25 Jul 2018 09:37:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     tglx@linutronix.de, palmer@sifive.com, jason@lakedaemon.net,
        marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 5/6] irqchip: New RISC-V PLIC Driver
Date:   Wed, 25 Jul 2018 11:36:48 +0200
Message-Id: <20180725093649.32332-6-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180725093649.32332-1-hch@lst.de>
References: <20180725093649.32332-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@dabbelt.com>

This patch adds a driver for the Platform Level Interrupt Controller
(PLIC) specified as part of the RISC-V supervisor level ISA manual.
The PLIC connects global interrupt sources to the local interrupt
controller on each hart.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
[hch: various cleanups, fixed typos, added SPDX tag]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/irqchip/Kconfig          |  13 ++
 drivers/irqchip/Makefile         |   1 +
 drivers/irqchip/irq-riscv-plic.c | 295 +++++++++++++++++++++++++++++++
 3 files changed, 309 insertions(+)
 create mode 100644 drivers/irqchip/irq-riscv-plic.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 8460fdcecc2c..d1afac8829ae 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -376,3 +376,16 @@ endmenu
 config RISCV_INTC
 	def_bool y
 	depends on RISCV
+
+config RISCV_PLIC
+	bool "Platform-Level Interrupt Controller"
+	depends on RISCV
+	default y
+	help
+	   This enables support for the PLIC chip found in standard RISC-V
+	   systems.  The PLIC controls devices interrupts and connects them to
+	   each core's local interrupt controller.  Aside from timer and
+	   software interrupts, all other interrupt sources (MSI, GPIO, etc)
+	   are subordinate to the PLIC.
+
+	   If you don't know what to do here, say Y.
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 74e333cc274c..7954f4c4a629 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -88,3 +88,4 @@ obj-$(CONFIG_GOLDFISH_PIC) 		+= irq-goldfish-pic.o
 obj-$(CONFIG_NDS32)			+= irq-ativic32.o
 obj-$(CONFIG_QCOM_PDC)			+= qcom-pdc.o
 obj-$(CONFIG_RISCV_INTC)		+= irq-riscv-intc.o
+obj-$(CONFIG_RISCV_PLIC)		+= irq-riscv-plic.o
diff --git a/drivers/irqchip/irq-riscv-plic.c b/drivers/irqchip/irq-riscv-plic.c
new file mode 100644
index 000000000000..7b80b73c28a0
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-plic.c
@@ -0,0 +1,295 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017 SiFive
+ */
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+
+/*
+ * From the RISC-V Priviledged Spec v1.10:
+ *
+ * Global interrupt sources are assigned small unsigned integer identifiers,
+ * beginning at the value 1.  An interrupt ID of 0 is reserved to mean "no
+ * interrupt".  Interrupt identifiers are also used to break ties when two or
+ * more interrupt sources have the same assigned priority. Smaller values of
+ * interrupt ID take precedence over larger values of interrupt ID.
+ *
+ * While the RISC-V supervisor spec doesn't define the maximum number of
+ * devices supported by the PLIC, the largest number supported by devices
+ * marked as 'riscv,plic0' (which is the only device type this driver supports,
+ * and is the only extant PLIC as of now) is 1024.  As mentioned above, device
+ * 0 is defined to be non-existent so this device really only supports 1023
+ * devices.
+ */
+#define MAX_DEVICES	1024
+#define MAX_CONTEXTS	15872
+
+struct plic_handler {
+	bool			present;
+	int			contextid;
+	struct plic_data	*data;
+};
+
+/*
+ * PLIC devices are named like 'riscv,plic0,%llx', this is enough space to
+ * store that name.
+ */
+#define PLIC_DATA_NAME_SIZE 30
+
+struct plic_data {
+	struct irq_chip		chip;
+	struct irq_domain	*domain;
+	u32			ndev;
+	void __iomem		*reg;
+	int			handlers;
+	struct plic_handler	*handler;
+	char			name[PLIC_DATA_NAME_SIZE];
+	spinlock_t		lock;
+};
+
+/*
+ * Each interrupt source has a priority register associated with it.
+ * We always hardwire it to one in Linux.
+ */
+static inline u32 __iomem *plic_priority(struct plic_data *data, int hwirq)
+{
+	return data->reg + hwirq * 0x04;
+}
+
+/*
+ * Each hart context has a vector of interrupt enable bits associated with it.
+ * There is one bit for each interrupt source.
+ */
+static inline u32 __iomem *plic_enable_vector(struct plic_data *data,
+		int contextid)
+{
+	return data->reg + (1 << 13) + contextid * 0x80;
+}
+
+/*
+ * Each hart context has a set of control registers associated with it.  Right
+ * now there's only two: a source priority threshold over which the hart will
+ * take an interrupt, and a register to claim interrupts.
+ */
+#define CONTEXT_THRESHOLD	0
+#define CONTEXT_CLAIM		4
+
+static inline u32 __iomem *plic_hart_data(struct plic_data *data,
+		int contextid)
+{
+	return data->reg + (1 << 21) + contextid * 0x1000;
+}
+
+/* Explicit interrupt masking. */
+static void plic_disable(struct plic_data *data, int contextid, int hwirq)
+{
+	u32 __iomem *reg = plic_enable_vector(data, contextid) + (hwirq / 32);
+	u32 mask = ~(1 << (hwirq % 32));
+
+	spin_lock(&data->lock);
+	writel(readl(reg) & mask, reg);
+	spin_unlock(&data->lock);
+}
+
+static void plic_enable(struct plic_data *data, int contextid, int hwirq)
+{
+	u32 __iomem *reg = plic_enable_vector(data, contextid) + (hwirq / 32);
+	u32 bit = 1 << (hwirq % 32);
+
+	spin_lock(&data->lock);
+	writel(readl(reg) | bit, reg);
+	spin_unlock(&data->lock);
+}
+
+/*
+ * There is no need to mask/unmask PLIC interrupts
+ * They are "masked" by reading claim and "unmasked" when writing it back.
+ */
+static void plic_irq_mask(struct irq_data *d)
+{
+}
+
+static void plic_irq_unmask(struct irq_data *d)
+{
+}
+
+static void plic_irq_enable(struct irq_data *d)
+{
+	struct plic_data *data = irq_data_get_irq_chip_data(d);
+	int i;
+
+	writel(1, plic_priority(data, d->hwirq));
+	for (i = 0; i < data->handlers; ++i)
+		if (data->handler[i].present)
+			plic_enable(data, i, d->hwirq);
+}
+
+static void plic_irq_disable(struct irq_data *d)
+{
+	struct plic_data *data = irq_data_get_irq_chip_data(d);
+	int i;
+
+	writel(0, plic_priority(data, d->hwirq));
+	for (i = 0; i < data->handlers; ++i)
+		if (data->handler[i].present)
+			plic_disable(data, i, d->hwirq);
+}
+
+static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
+			      irq_hw_number_t hwirq)
+{
+	struct plic_data *data = d->host_data;
+
+	irq_set_chip_and_handler(irq, &data->chip, handle_simple_irq);
+	irq_set_chip_data(irq, data);
+	irq_set_noprobe(irq);
+	return 0;
+}
+
+static const struct irq_domain_ops plic_irqdomain_ops = {
+	.map	= plic_irqdomain_map,
+	.xlate	= irq_domain_xlate_onecell,
+};
+
+/*
+ * Handling an interrupt is a two-step process: first you claim the interrupt
+ * by reading the claim register, then you complete the interrupt by writing
+ * that source ID back to the same claim register.  This automatically enables
+ * and disables the interrupt, so there's nothing else to do.
+ */
+static void plic_chained_handle_irq(struct irq_desc *desc)
+{
+	struct plic_handler *handler = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct irq_domain *domain = handler->data->domain;
+	void __iomem *ph = plic_hart_data(handler->data, handler->contextid);
+	u32 what;
+
+	chained_irq_enter(chip, desc);
+	while ((what = readl(ph + CONTEXT_CLAIM))) {
+		int irq = irq_find_mapping(domain, what);
+
+		if (irq > 0)
+			generic_handle_irq(irq);
+		else
+			handle_bad_irq(desc);
+		writel(what, ph + CONTEXT_CLAIM);
+	}
+	chained_irq_exit(chip, desc);
+}
+
+static int plic_init(struct device_node *node, struct device_node *parent)
+{
+	struct plic_data *data;
+	struct resource resource;
+	int i, ok = 0;
+	int out = -1;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (WARN_ON(!data))
+		return -ENOMEM;
+
+	spin_lock_init(&data->lock);
+
+	data->reg = of_iomap(node, 0);
+	if (WARN_ON(!data->reg)) {
+		out = -EIO;
+		goto free_data;
+	}
+
+	of_property_read_u32(node, "riscv,ndev", &data->ndev);
+	if (WARN_ON(!data->ndev)) {
+		out = -EINVAL;
+		goto free_reg;
+	}
+
+	data->handlers = of_irq_count(node);
+	if (WARN_ON(!data->handlers)) {
+		out = -EINVAL;
+		goto free_reg;
+	}
+
+	data->handler =
+		kcalloc(data->handlers, sizeof(*data->handler), GFP_KERNEL);
+	if (WARN_ON(!data->handler)) {
+		out = -ENOMEM;
+		goto free_reg;
+	}
+
+	data->domain = irq_domain_add_linear(node, data->ndev + 1,
+			&plic_irqdomain_ops, data);
+	if (WARN_ON(!data->domain)) {
+		out = -ENOMEM;
+		goto free_handler;
+	}
+
+	of_address_to_resource(node, 0, &resource);
+	snprintf(data->name, sizeof(data->name),
+		 "riscv,plic0,%llx", resource.start);
+	data->chip.name = data->name;
+	data->chip.irq_mask = plic_irq_mask;
+	data->chip.irq_unmask = plic_irq_unmask;
+	data->chip.irq_enable = plic_irq_enable;
+	data->chip.irq_disable = plic_irq_disable;
+
+	for (i = 0; i < data->handlers; ++i) {
+		struct plic_handler *handler = &data->handler[i];
+		struct of_phandle_args parent;
+		int parent_irq, hwirq;
+
+		handler->present = false;
+
+		if (of_irq_parse_one(node, i, &parent))
+			continue;
+		/* skip context holes */
+		if (parent.args[0] == -1)
+			continue;
+
+		/* skip any contexts that lead to inactive harts */
+		if (of_device_is_compatible(parent.np, "riscv,cpu-intc") &&
+		    parent.np->parent &&
+		    riscv_of_processor_hart(parent.np->parent) < 0)
+			continue;
+
+		parent_irq = irq_create_of_mapping(&parent);
+		if (!parent_irq)
+			continue;
+
+		handler->present = true;
+		handler->contextid = i;
+		handler->data = data;
+		/* hwirq prio must be > this to trigger an interrupt */
+		writel(0, plic_hart_data(data, i) + CONTEXT_THRESHOLD);
+
+		for (hwirq = 1; hwirq <= data->ndev; ++hwirq)
+			plic_disable(data, i, hwirq);
+		irq_set_chained_handler_and_data(parent_irq,
+				plic_chained_handle_irq, handler);
+		++ok;
+	}
+
+	pr_info("%s: mapped %d interrupts to %d/%d handlers\n",
+		data->name, data->ndev, ok, data->handlers);
+	WARN_ON(!ok);
+	return 0;
+
+free_handler:
+	kfree(data->handler);
+free_reg:
+	iounmap(data->reg);
+free_data:
+	kfree(data);
+	return out;
+}
+
+IRQCHIP_DECLARE(plic0, "riscv,plic0", plic_init);
-- 
2.18.0

