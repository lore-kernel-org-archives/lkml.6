Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9C8C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 992E92089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 992E92089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeJQAdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:33:39 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37017 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbeJQAdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:33:39 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7] helo=dude.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gCSQE-00060Q-OK; Tue, 16 Oct 2018 18:42:18 +0200
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de, patchwork-lst@pengutronix.de
Subject: [PATCH 2/2] irqchip: add driver for imx-irqsteer controller
Date:   Tue, 16 Oct 2018 18:42:18 +0200
Message-Id: <20181016164218.3736-2-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181016164218.3736-1-l.stach@pengutronix.de>
References: <20181016164218.3736-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The irqsteer block is a interrupt multiplexer/remapper found on the
i.MX8 line of SoCs.

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
This submission is a heavily cleaned up version of the downstream driver.
---
 drivers/irqchip/Kconfig            |   8 +
 drivers/irqchip/Makefile           |   1 +
 drivers/irqchip/irq-imx-irqsteer.c | 281 +++++++++++++++++++++++++++++
 3 files changed, 290 insertions(+)
 create mode 100644 drivers/irqchip/irq-imx-irqsteer.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 383e7b70221d..07290b30abd2 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -371,6 +371,14 @@ config QCOM_PDC
 	  Power Domain Controller driver to manage and configure wakeup
 	  IRQs for Qualcomm Technologies Inc (QTI) mobile chips.
 
+config IMX_IRQSTEER
+	bool "i.MX IRQSTEER support"
+	depends on ARCH_MXC || COMPILE_TEST
+	default ARCH_MXC
+	select IRQ_DOMAIN
+	help
+	  Support for the i.MX IRQSTEER interrupt multiplexer/remapper.
+
 endmenu
 
 config SIFIVE_PLIC
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index fbd1ec8070ef..2c77ba4cc3cc 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -88,3 +88,4 @@ obj-$(CONFIG_GOLDFISH_PIC) 		+= irq-goldfish-pic.o
 obj-$(CONFIG_NDS32)			+= irq-ativic32.o
 obj-$(CONFIG_QCOM_PDC)			+= qcom-pdc.o
 obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
+obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
new file mode 100644
index 000000000000..3ff0698ea7bd
--- /dev/null
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2017 NXP
+ * Copyright (C) 2018 Pengutronix, Lucas Stach <kernel@pengutronix.de>
+ */
+
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of_platform.h>
+#include <linux/spinlock.h>
+
+#define CHANREG_OFF(_t)	(_t * 4)
+#define CHANCTRL		0x0
+#define CHANMASK(n, t)		(0x4 + (0x4 * (n)) + (CHANREG_OFF(t) * 0))
+#define CHANSET(n, t)		(0x4 + (0x4 * (n)) + (CHANREG_OFF(t) * 1))
+#define CHANSTATUS(n, t)	(0x4 + (0x4 * (n)) + (CHANREG_OFF(t) * 2))
+#define CHAN_MINTDIS(t)		(0x4 + (CHANREG_OFF(t) * 3))
+#define CHAN_MASTRSTAT(t)	(0x8 + (CHANREG_OFF(t) * 3))
+
+struct irqsteer_irqchip_data {
+	spinlock_t lock;
+	struct platform_device *pdev;
+	void __iomem *regs;
+	struct clk *ipg_clk;
+	int irq;
+	int channum;
+	int big_endian;
+	struct irq_domain *domain;
+	int *saved_reg;
+};
+
+static int imx_irqsteer_get_reg_index(struct irqsteer_irqchip_data *data,
+				      unsigned long irqnum)
+{
+	if (data->big_endian)
+		return (data->channum - irqnum / 32 - 1);
+	else
+		return irqnum / 32;
+}
+
+static void imx_irqsteer_irq_unmask(struct irq_data *d)
+{
+	struct irqsteer_irqchip_data *data = d->chip_data;
+	int idx = imx_irqsteer_get_reg_index(data, d->hwirq);
+	u32 val;
+
+	spin_lock(&data->lock);
+	val = readl_relaxed(data->regs + CHANMASK(idx, data->channum));
+	val |= 1 << (d->hwirq % 32);
+	writel_relaxed(val, data->regs + CHANMASK(idx, data->channum));
+	spin_unlock(&data->lock);
+}
+
+static void imx_irqsteer_irq_mask(struct irq_data *d)
+{
+	struct irqsteer_irqchip_data *data = d->chip_data;
+	int idx = imx_irqsteer_get_reg_index(data, d->hwirq);
+	u32 val;
+
+	spin_lock(&data->lock);
+	val = readl_relaxed(data->regs + CHANMASK(idx, data->channum));
+	val &= ~(1 << (d->hwirq % 32));
+	writel_relaxed(val, data->regs + CHANMASK(idx, data->channum));
+	spin_unlock(&data->lock);
+}
+
+static int imx_irqsteer_set_type(struct irq_data *data, unsigned int flow_type)
+{
+	if ((flow_type & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_LEVEL_HIGH)
+		return 0;
+
+	return -EINVAL;
+}
+
+static struct irq_chip imx_irqsteer_irq_chip = {
+	.name		= "irqsteer",
+	.irq_eoi	= irq_chip_eoi_parent,
+	.irq_mask	= imx_irqsteer_irq_mask,
+	.irq_unmask	= imx_irqsteer_irq_unmask,
+	.irq_set_type	= imx_irqsteer_set_type,
+};
+
+static int imx_irqsteer_irq_map(struct irq_domain *h, unsigned int irq,
+				irq_hw_number_t hwirq)
+{
+	irq_set_chip_data(irq, h->host_data);
+	irq_set_chip_and_handler(irq, &imx_irqsteer_irq_chip, handle_level_irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops imx_irqsteer_domain_ops = {
+	.map		= imx_irqsteer_irq_map,
+	.xlate		= irq_domain_xlate_twocell,
+};
+
+static void imx_irqsteer_irq_handler(struct irq_desc *desc)
+{
+	struct irqsteer_irqchip_data *data = irq_desc_get_handler_data(desc);
+	u32 val;
+	int i;
+
+	chained_irq_enter(irq_desc_get_chip(desc), desc);
+
+	val = readl_relaxed(data->regs + CHAN_MASTRSTAT(data->channum));
+	if (!val)
+		goto out;
+
+	for (i = 0; i < data->channum; i++) {
+		int idx = data->big_endian ? (data->channum - i - 1) : i;
+		unsigned long irqmap;
+		int pos, virq;
+
+		irqmap = readl_relaxed(data->regs +
+				       CHANSTATUS(idx, data->channum));
+
+		for_each_set_bit(pos, &irqmap, 32) {
+			virq = irq_find_mapping(data->domain, pos);
+			if (virq)
+				generic_handle_irq(virq);
+		}
+	}
+
+out:
+	chained_irq_exit(irq_desc_get_chip(desc), desc);
+}
+
+static int imx_irqsteer_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct irqsteer_irqchip_data *data;
+	struct resource *res;
+	int ret;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	data->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(data->regs)) {
+		dev_err(&pdev->dev, "failed to initialize reg\n");
+		return PTR_ERR(data->regs);
+	}
+
+	data->irq = platform_get_irq(pdev, 0);
+	if (data->irq <= 0) {
+		dev_err(&pdev->dev, "failed to get irq\n");
+		return -ENODEV;
+	}
+
+	data->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(data->ipg_clk)) {
+		ret = PTR_ERR(data->ipg_clk);
+		dev_err(&pdev->dev, "failed to get ipg clk: %d\n", ret);
+		return ret;
+	}
+
+	/* default to 1 channel and little endian */
+	data->channum = 1;
+	data->big_endian  = 0;
+	data->pdev = pdev;
+	spin_lock_init(&data->lock);
+
+	of_property_read_u32(np, "fsl,channel", &data->channum);
+	of_property_read_u32(np, "fsl,endian", &data->big_endian);
+
+	if (IS_ENABLED(CONFIG_PM_SLEEP)) {
+		data->saved_reg = devm_kzalloc(&pdev->dev,
+					       sizeof(u32) * data->channum + 1,
+					       GFP_KERNEL);
+		if (!data->saved_reg)
+			return -ENOMEM;
+	}
+
+	ret = clk_prepare_enable(data->ipg_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable ipg clk: %d\n", ret);
+		return ret;
+	}
+
+	/* enable channel 1 by default */
+	writel_relaxed(1, data->regs + CHANCTRL);
+
+	data->domain = irq_domain_add_linear(np, data->channum * 32,
+					     &imx_irqsteer_domain_ops, data);
+	if (!data->domain) {
+		dev_err(&data->pdev->dev, "failed to create IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	irq_set_chained_handler_and_data(data->irq, imx_irqsteer_irq_handler,
+					 data);
+
+	platform_set_drvdata(pdev, data);
+
+	return 0;
+}
+
+static int imx_irqsteer_remove(struct platform_device *pdev)
+{
+	struct irqsteer_irqchip_data *irqsteer_data = platform_get_drvdata(pdev);
+
+	irq_set_chained_handler_and_data(irqsteer_data->irq, NULL, NULL);
+	irq_domain_remove(irqsteer_data->domain);
+
+	clk_disable_unprepare(irqsteer_data->ipg_clk);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static void imx_irqsteer_save_regs(struct irqsteer_irqchip_data *data)
+{
+	int num;
+
+	data->saved_reg[0] = readl_relaxed(data->regs + CHANCTRL);
+	for (num = 0; num < data->channum; num++)
+		data->saved_reg[num + 1] = readl_relaxed(data->regs +
+						CHANMASK(num, data->channum));
+}
+
+static void imx_irqsteer_restore_regs(struct irqsteer_irqchip_data *data)
+{
+	int num;
+
+	writel_relaxed(data->saved_reg[0], data->regs + CHANCTRL);
+	for (num = 0; num < data->channum; num++)
+		writel_relaxed(data->saved_reg[num + 1],
+			       data->regs + CHANMASK(num, data->channum));
+}
+
+static int imx_irqsteer_suspend(struct device *dev)
+{
+	struct irqsteer_irqchip_data *irqsteer_data = dev_get_drvdata(dev);
+
+	imx_irqsteer_save_regs(irqsteer_data);
+	clk_disable_unprepare(irqsteer_data->ipg_clk);
+
+	return 0;
+}
+
+static int imx_irqsteer_resume(struct device *dev)
+{
+	struct irqsteer_irqchip_data *irqsteer_data = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(irqsteer_data->ipg_clk);
+	if (ret) {
+		dev_err(dev, "failed to enable ipg clk: %d\n", ret);
+		return ret;
+	}
+	imx_irqsteer_restore_regs(irqsteer_data);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops imx_irqsteer_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(imx_irqsteer_suspend, imx_irqsteer_resume)
+};
+
+static const struct of_device_id imx_irqsteer_dt_ids[] = {
+	{ .compatible = "fsl,imx-irqsteer", },
+	{},
+};
+
+static struct platform_driver imx_irqsteer_driver = {
+	.driver = {
+		.name = "imx-irqsteer",
+		.of_match_table = imx_irqsteer_dt_ids,
+		.pm = &imx_irqsteer_pm_ops,
+	},
+	.probe = imx_irqsteer_probe,
+	.remove = imx_irqsteer_remove,
+};
+builtin_platform_driver(imx_irqsteer_driver);
-- 
2.19.0

