Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752719AbeETRCl (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 13:02:41 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:7183 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752597AbeETRCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 13:02:22 -0400
X-UUID: 416b3f45b44c402bb796ccf51ca3988b-20180521
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linus.walleij@linaro.org>, <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 2/7] pinctrl: mediatek: refactor EINT related code for all MediaTek pinctrl can fit
Date: Mon, 21 May 2018 01:01:48 +0800
Message-ID: <7265772c758d4c56cabb95fda708550bc4d2fcb5.1526835466.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1526835466.git.sean.wang@mediatek.com>
References: <cover.1526835466.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

This patch is in preparation for adding EINT support to MT7622 pinctrl,
and the refactoring doesn't alter any existent logic.

A reason we have to refactor EINT code pieces into a generic way is that
currently, they're tightly coupled with a certain type of MediaTek pinctrl
would cause a grown in a very bad way as there is different types of
pinctrl devices getting to join.

Therefore, it is an essential or urgent thing that EINT code pieces are
refactored to eliminate any dependencies across GPIO and EINT as possible.

Additional structure mtk_eint_[xt, hw, regs] are being introduced for
indicating how maps being designed between GPIO and EINT hw number, how to
set and get GPIO state for a certain EINT pin, what characteristic on a
EINT device is present on various SoCs.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/Kconfig              |   6 +
 drivers/pinctrl/mediatek/Makefile             |   1 +
 drivers/pinctrl/mediatek/mtk-eint.c           | 492 +++++++++++++++++++++
 drivers/pinctrl/mediatek/mtk-eint.h           | 107 +++++
 drivers/pinctrl/mediatek/pinctrl-mt2701.c     |  12 +-
 drivers/pinctrl/mediatek/pinctrl-mt2712.c     |  12 +-
 drivers/pinctrl/mediatek/pinctrl-mt8127.c     |  12 +-
 drivers/pinctrl/mediatek/pinctrl-mt8135.c     |  12 +-
 drivers/pinctrl/mediatek/pinctrl-mt8173.c     |  12 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 604 +++++---------------------
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h |  13 +-
 11 files changed, 756 insertions(+), 527 deletions(-)
 create mode 100644 drivers/pinctrl/mediatek/mtk-eint.c
 create mode 100644 drivers/pinctrl/mediatek/mtk-eint.h

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index 862c5db..310db42 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -1,12 +1,18 @@
 menu "MediaTek pinctrl drivers"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 
+config EINT_MTK
+	bool "MediaTek External Interrupt Support"
+	depends on PINCTRL_MTK || COMPILE_TEST
+	select IRQ_DOMAIN
+
 config PINCTRL_MTK
 	bool
 	depends on OF
 	select PINMUX
 	select GENERIC_PINCONF
 	select GPIOLIB
+	select EINT_MTK
 	select OF_GPIO
 
 # For ARMv7 SoCs
diff --git a/drivers/pinctrl/mediatek/Makefile b/drivers/pinctrl/mediatek/Makefile
index 7959e77..3de7156 100644
--- a/drivers/pinctrl/mediatek/Makefile
+++ b/drivers/pinctrl/mediatek/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # Core
+obj-$(CONFIG_EINT_MTK)		+= mtk-eint.o
 obj-$(CONFIG_PINCTRL_MTK)	+= pinctrl-mtk-common.o
 
 # SoC Drivers
diff --git a/drivers/pinctrl/mediatek/mtk-eint.c b/drivers/pinctrl/mediatek/mtk-eint.c
new file mode 100644
index 0000000..30f3316
--- /dev/null
+++ b/drivers/pinctrl/mediatek/mtk-eint.c
@@ -0,0 +1,492 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2014-2018 MediaTek Inc.
+
+/*
+ * Library for MediaTek External Interrupt Support
+ *
+ * Author: Maoguang Meng <maoguang.meng@mediatek.com>
+ *	   Sean Wang <sean.wang@mediatek.com>
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+#include <linux/irqdomain.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+
+#include "mtk-eint.h"
+
+#define MTK_EINT_EDGE_SENSITIVE           0
+#define MTK_EINT_LEVEL_SENSITIVE          1
+#define MTK_EINT_DBNC_SET_DBNC_BITS	  4
+#define MTK_EINT_DBNC_RST_BIT		  (0x1 << 1)
+#define MTK_EINT_DBNC_SET_EN		  (0x1 << 0)
+
+static const struct mtk_eint_regs mtk_generic_eint_regs = {
+	.stat      = 0x000,
+	.ack       = 0x040,
+	.mask      = 0x080,
+	.mask_set  = 0x0c0,
+	.mask_clr  = 0x100,
+	.sens      = 0x140,
+	.sens_set  = 0x180,
+	.sens_clr  = 0x1c0,
+	.soft      = 0x200,
+	.soft_set  = 0x240,
+	.soft_clr  = 0x280,
+	.pol       = 0x300,
+	.pol_set   = 0x340,
+	.pol_clr   = 0x380,
+	.dom_en    = 0x400,
+	.dbnc_ctrl = 0x500,
+	.dbnc_set  = 0x600,
+	.dbnc_clr  = 0x700,
+};
+
+static void __iomem *mtk_eint_get_offset(struct mtk_eint *eint,
+					 unsigned int eint_num,
+					 unsigned int offset)
+{
+	unsigned int eint_base = 0;
+	void __iomem *reg;
+
+	if (eint_num >= eint->hw->ap_num)
+		eint_base = eint->hw->ap_num;
+
+	reg = eint->base + offset + ((eint_num - eint_base) / 32) * 4;
+
+	return reg;
+}
+
+static unsigned int mtk_eint_can_en_debounce(struct mtk_eint *eint,
+					     unsigned int eint_num)
+{
+	unsigned int sens;
+	unsigned int bit = BIT(eint_num % 32);
+	void __iomem *reg = mtk_eint_get_offset(eint, eint_num,
+						eint->regs->sens);
+
+	if (readl(reg) & bit)
+		sens = MTK_EINT_LEVEL_SENSITIVE;
+	else
+		sens = MTK_EINT_EDGE_SENSITIVE;
+
+	if (eint_num < eint->hw->db_cnt && sens != MTK_EINT_EDGE_SENSITIVE)
+		return 1;
+	else
+		return 0;
+}
+
+static int mtk_eint_flip_edge(struct mtk_eint *eint, int hwirq)
+{
+	int start_level, curr_level;
+	unsigned int reg_offset;
+	u32 mask = BIT(hwirq & 0x1f);
+	u32 port = (hwirq >> 5) & eint->hw->port_mask;
+	void __iomem *reg = eint->base + (port << 2);
+
+	curr_level = eint->gpio_xlate->get_gpio_state(eint->pctl, hwirq);
+
+	do {
+		start_level = curr_level;
+		if (start_level)
+			reg_offset = eint->regs->pol_clr;
+		else
+			reg_offset = eint->regs->pol_set;
+		writel(mask, reg + reg_offset);
+
+		curr_level = eint->gpio_xlate->get_gpio_state(eint->pctl,
+							      hwirq);
+	} while (start_level != curr_level);
+
+	return start_level;
+}
+
+static void mtk_eint_mask(struct irq_data *d)
+{
+	struct mtk_eint *eint = irq_data_get_irq_chip_data(d);
+	u32 mask = BIT(d->hwirq & 0x1f);
+	void __iomem *reg = mtk_eint_get_offset(eint, d->hwirq,
+						eint->regs->mask_set);
+
+	writel(mask, reg);
+}
+
+static void mtk_eint_unmask(struct irq_data *d)
+{
+	struct mtk_eint *eint = irq_data_get_irq_chip_data(d);
+	u32 mask = BIT(d->hwirq & 0x1f);
+	void __iomem *reg = mtk_eint_get_offset(eint, d->hwirq,
+						eint->regs->mask_clr);
+
+	writel(mask, reg);
+
+	if (eint->dual_edge[d->hwirq])
+		mtk_eint_flip_edge(eint, d->hwirq);
+}
+
+static unsigned int mtk_eint_get_mask(struct mtk_eint *eint,
+				      unsigned int eint_num)
+{
+	unsigned int bit = BIT(eint_num % 32);
+	void __iomem *reg = mtk_eint_get_offset(eint, eint_num,
+						eint->regs->mask);
+
+	return !!(readl(reg) & bit);
+}
+
+static void mtk_eint_ack(struct irq_data *d)
+{
+	struct mtk_eint *eint = irq_data_get_irq_chip_data(d);
+	u32 mask = BIT(d->hwirq & 0x1f);
+	void __iomem *reg = mtk_eint_get_offset(eint, d->hwirq,
+						eint->regs->ack);
+
+	writel(mask, reg);
+}
+
+static int mtk_eint_set_type(struct irq_data *d, unsigned int type)
+{
+	struct mtk_eint *eint = irq_data_get_irq_chip_data(d);
+	u32 mask = BIT(d->hwirq & 0x1f);
+	void __iomem *reg;
+
+	if (((type & IRQ_TYPE_EDGE_BOTH) && (type & IRQ_TYPE_LEVEL_MASK)) ||
+	    ((type & IRQ_TYPE_LEVEL_MASK) == IRQ_TYPE_LEVEL_MASK)) {
+		dev_err(eint->dev,
+			"Can't configure IRQ%d (EINT%lu) for type 0x%X\n",
+			d->irq, d->hwirq, type);
+		return -EINVAL;
+	}
+
+	if ((type & IRQ_TYPE_EDGE_BOTH) == IRQ_TYPE_EDGE_BOTH)
+		eint->dual_edge[d->hwirq] = 1;
+	else
+		eint->dual_edge[d->hwirq] = 0;
+
+	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_EDGE_FALLING)) {
+		reg = mtk_eint_get_offset(eint, d->hwirq, eint->regs->pol_clr);
+		writel(mask, reg);
+	} else {
+		reg = mtk_eint_get_offset(eint, d->hwirq, eint->regs->pol_set);
+		writel(mask, reg);
+	}
+
+	if (type & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING)) {
+		reg = mtk_eint_get_offset(eint, d->hwirq, eint->regs->sens_clr);
+		writel(mask, reg);
+	} else {
+		reg = mtk_eint_get_offset(eint, d->hwirq, eint->regs->sens_set);
+		writel(mask, reg);
+	}
+
+	if (eint->dual_edge[d->hwirq])
+		mtk_eint_flip_edge(eint, d->hwirq);
+
+	return 0;
+}
+
+static int mtk_eint_irq_set_wake(struct irq_data *d, unsigned int on)
+{
+	struct mtk_eint *eint = irq_data_get_irq_chip_data(d);
+	int shift = d->hwirq & 0x1f;
+	int reg = d->hwirq >> 5;
+
+	if (on)
+		eint->wake_mask[reg] |= BIT(shift);
+	else
+		eint->wake_mask[reg] &= ~BIT(shift);
+
+	return 0;
+}
+
+static void mtk_eint_chip_write_mask(const struct mtk_eint *eint,
+				     void __iomem *base, u32 *buf)
+{
+	int port;
+	void __iomem *reg;
+
+	for (port = 0; port < eint->hw->ports; port++) {
+		reg = base + (port << 2);
+		writel_relaxed(~buf[port], reg + eint->regs->mask_set);
+		writel_relaxed(buf[port], reg + eint->regs->mask_clr);
+	}
+}
+
+static void mtk_eint_chip_read_mask(const struct mtk_eint *eint,
+				    void __iomem *base, u32 *buf)
+{
+	int port;
+	void __iomem *reg;
+
+	for (port = 0; port < eint->hw->ports; port++) {
+		reg = base + eint->regs->mask + (port << 2);
+		buf[port] = ~readl_relaxed(reg);
+		/* Mask is 0 when irq is enabled, and 1 when disabled. */
+	}
+}
+
+static int mtk_eint_irq_request_resources(struct irq_data *d)
+{
+	struct mtk_eint *eint = irq_data_get_irq_chip_data(d);
+	struct gpio_chip *gpio_c;
+	unsigned int gpio_n;
+	int err;
+
+	err = eint->gpio_xlate->get_gpio_n(eint->pctl, d->hwirq,
+					   &gpio_n, &gpio_c);
+	if (err < 0) {
+		dev_err(eint->dev, "Can not find pin\n");
+		return err;
+	}
+
+	err = gpiochip_lock_as_irq(gpio_c, gpio_n);
+	if (err < 0) {
+		dev_err(eint->dev, "unable to lock HW IRQ %lu for IRQ\n",
+			irqd_to_hwirq(d));
+		return err;
+	}
+
+	err = eint->gpio_xlate->set_gpio_as_eint(eint->pctl, d->hwirq);
+	if (err < 0) {
+		dev_err(eint->dev, "Can not eint mode\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static void mtk_eint_irq_release_resources(struct irq_data *d)
+{
+	struct mtk_eint *eint = irq_data_get_irq_chip_data(d);
+	struct gpio_chip *gpio_c;
+	unsigned int gpio_n;
+
+	eint->gpio_xlate->get_gpio_n(eint->pctl, d->hwirq, &gpio_n,
+				     &gpio_c);
+
+	gpiochip_unlock_as_irq(gpio_c, gpio_n);
+}
+
+static struct irq_chip mtk_eint_irq_chip = {
+	.name = "mt-eint",
+	.irq_disable = mtk_eint_mask,
+	.irq_mask = mtk_eint_mask,
+	.irq_unmask = mtk_eint_unmask,
+	.irq_ack = mtk_eint_ack,
+	.irq_set_type = mtk_eint_set_type,
+	.irq_set_wake = mtk_eint_irq_set_wake,
+	.irq_request_resources = mtk_eint_irq_request_resources,
+	.irq_release_resources = mtk_eint_irq_release_resources,
+};
+
+static unsigned int mtk_eint_hw_init(struct mtk_eint *eint)
+{
+	void __iomem *reg = eint->base + eint->regs->dom_en;
+	unsigned int i;
+
+	for (i = 0; i < eint->hw->ap_num; i += 32) {
+		writel(0xffffffff, reg);
+		reg += 4;
+	}
+
+	return 0;
+}
+
+static inline void
+mtk_eint_debounce_process(struct mtk_eint *eint, int index)
+{
+	unsigned int rst, ctrl_offset;
+	unsigned int bit, dbnc;
+
+	ctrl_offset = (index / 4) * 4 + eint->regs->dbnc_ctrl;
+	dbnc = readl(eint->base + ctrl_offset);
+	bit = MTK_EINT_DBNC_SET_EN << ((index % 4) * 8);
+	if ((bit & dbnc) > 0) {
+		ctrl_offset = (index / 4) * 4 + eint->regs->dbnc_set;
+		rst = MTK_EINT_DBNC_RST_BIT << ((index % 4) * 8);
+		writel(rst, eint->base + ctrl_offset);
+	}
+}
+
+static void mtk_eint_irq_handler(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct mtk_eint *eint = irq_desc_get_handler_data(desc);
+	unsigned int status, eint_num;
+	int offset, index, virq;
+	void __iomem *reg =  mtk_eint_get_offset(eint, 0, eint->regs->stat);
+	int dual_edge, start_level, curr_level;
+
+	chained_irq_enter(chip, desc);
+	for (eint_num = 0; eint_num < eint->hw->ap_num; eint_num += 32,
+	     reg += 4) {
+		status = readl(reg);
+		while (status) {
+			offset = __ffs(status);
+			index = eint_num + offset;
+			virq = irq_find_mapping(eint->domain, index);
+			status &= ~BIT(offset);
+
+			dual_edge = eint->dual_edge[index];
+			if (dual_edge) {
+				/*
+				 * Clear soft-irq in case we raised it last
+				 * time.
+				 */
+				writel(BIT(offset), reg - eint->regs->stat +
+				       eint->regs->soft_clr);
+
+				start_level =
+				eint->gpio_xlate->get_gpio_state(eint->pctl,
+								 index);
+			}
+
+			generic_handle_irq(virq);
+
+			if (dual_edge) {
+				curr_level = mtk_eint_flip_edge(eint, index);
+
+				/*
+				 * If level changed, we might lost one edge
+				 * interrupt, raised it through soft-irq.
+				 */
+				if (start_level != curr_level)
+					writel(BIT(offset), reg -
+					       eint->regs->stat +
+					       eint->regs->soft_set);
+			}
+
+			if (index < eint->hw->db_cnt)
+				mtk_eint_debounce_process(eint, index);
+		}
+	}
+	chained_irq_exit(chip, desc);
+}
+
+int mtk_eint_do_suspend(struct mtk_eint *eint)
+{
+	mtk_eint_chip_read_mask(eint, eint->base, eint->cur_mask);
+	mtk_eint_chip_write_mask(eint, eint->base, eint->wake_mask);
+
+	return 0;
+}
+
+int mtk_eint_do_resume(struct mtk_eint *eint)
+{
+	mtk_eint_chip_write_mask(eint, eint->base, eint->cur_mask);
+
+	return 0;
+}
+
+int mtk_eint_set_debounce(struct mtk_eint *eint, unsigned long eint_num,
+			  unsigned int debounce)
+{
+	int virq, eint_offset;
+	unsigned int set_offset, bit, clr_bit, clr_offset, rst, i, unmask,
+		     dbnc;
+	static const unsigned int debounce_time[] = {500, 1000, 16000, 32000,
+						     64000, 128000, 256000};
+	struct irq_data *d;
+
+	virq = irq_find_mapping(eint->domain, eint_num);
+	eint_offset = (eint_num % 4) * 8;
+	d = irq_get_irq_data(virq);
+
+	set_offset = (eint_num / 4) * 4 + eint->regs->dbnc_set;
+	clr_offset = (eint_num / 4) * 4 + eint->regs->dbnc_clr;
+
+	if (!mtk_eint_can_en_debounce(eint, eint_num))
+		return -EINVAL;
+
+	dbnc = ARRAY_SIZE(debounce_time);
+	for (i = 0; i < ARRAY_SIZE(debounce_time); i++) {
+		if (debounce <= debounce_time[i]) {
+			dbnc = i;
+			break;
+		}
+	}
+
+	if (!mtk_eint_get_mask(eint, eint_num)) {
+		mtk_eint_mask(d);
+		unmask = 1;
+	} else {
+		unmask = 0;
+	}
+
+	clr_bit = 0xff << eint_offset;
+	writel(clr_bit, eint->base + clr_offset);
+
+	bit = ((dbnc << MTK_EINT_DBNC_SET_DBNC_BITS) | MTK_EINT_DBNC_SET_EN) <<
+		eint_offset;
+	rst = MTK_EINT_DBNC_RST_BIT << eint_offset;
+	writel(rst | bit, eint->base + set_offset);
+
+	/*
+	 * Delay a while (more than 2T) to wait for hw debounce counter reset
+	 * work correctly.
+	 */
+	udelay(1);
+	if (unmask == 1)
+		mtk_eint_unmask(d);
+
+	return 0;
+}
+
+int mtk_eint_find_irq(struct mtk_eint *eint, unsigned long eint_n)
+{
+	int irq;
+
+	irq = irq_find_mapping(eint->domain, eint_n);
+	if (!irq)
+		return -EINVAL;
+
+	return irq;
+}
+
+int mtk_eint_do_init(struct mtk_eint *eint)
+{
+	int i;
+
+	/* If clients don't assign a specific regs, let's use generic one */
+	if (!eint->regs)
+		eint->regs = &mtk_generic_eint_regs;
+
+	eint->wake_mask = devm_kcalloc(eint->dev, eint->hw->ports,
+				       sizeof(*eint->wake_mask), GFP_KERNEL);
+	if (!eint->wake_mask)
+		return -ENOMEM;
+
+	eint->cur_mask = devm_kcalloc(eint->dev, eint->hw->ports,
+				      sizeof(*eint->cur_mask), GFP_KERNEL);
+	if (!eint->cur_mask)
+		return -ENOMEM;
+
+	eint->dual_edge = devm_kcalloc(eint->dev, eint->hw->ap_num,
+				       sizeof(int), GFP_KERNEL);
+	if (!eint->dual_edge)
+		return -ENOMEM;
+
+	eint->domain = irq_domain_add_linear(eint->dev->of_node,
+					     eint->hw->ap_num,
+					     &irq_domain_simple_ops, NULL);
+	if (!eint->domain)
+		return -ENOMEM;
+
+	mtk_eint_hw_init(eint);
+	for (i = 0; i < eint->hw->ap_num; i++) {
+		int virq = irq_create_mapping(eint->domain, i);
+
+		irq_set_chip_and_handler(virq, &mtk_eint_irq_chip,
+					 handle_level_irq);
+		irq_set_chip_data(virq, eint);
+	}
+
+	irq_set_chained_handler_and_data(eint->irq, mtk_eint_irq_handler,
+					 eint);
+
+	return 0;
+}
diff --git a/drivers/pinctrl/mediatek/mtk-eint.h b/drivers/pinctrl/mediatek/mtk-eint.h
new file mode 100644
index 0000000..55b4d5f
--- /dev/null
+++ b/drivers/pinctrl/mediatek/mtk-eint.h
@@ -0,0 +1,107 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2014-2018 MediaTek Inc.
+ *
+ * Author: Maoguang Meng <maoguang.meng@mediatek.com>
+ *	   Sean Wang <sean.wang@mediatek.com>
+ *
+ */
+#ifndef __MTK_EINT_H
+#define __MTK_EINT_H
+
+#include <linux/irqdomain.h>
+
+struct mtk_eint_regs {
+	unsigned int	stat;
+	unsigned int	ack;
+	unsigned int	mask;
+	unsigned int	mask_set;
+	unsigned int	mask_clr;
+	unsigned int	sens;
+	unsigned int	sens_set;
+	unsigned int	sens_clr;
+	unsigned int	soft;
+	unsigned int	soft_set;
+	unsigned int	soft_clr;
+	unsigned int	pol;
+	unsigned int	pol_set;
+	unsigned int	pol_clr;
+	unsigned int	dom_en;
+	unsigned int	dbnc_ctrl;
+	unsigned int	dbnc_set;
+	unsigned int	dbnc_clr;
+};
+
+struct mtk_eint_hw {
+	const char	*name;
+	u8		port_mask;
+	u8		ports;
+	unsigned int	ap_num;
+	unsigned int	db_cnt;
+};
+
+struct mtk_eint;
+
+struct mtk_eint_xt {
+	int (*get_gpio_n)(void *data, unsigned long eint_n,
+			  unsigned int *gpio_n,
+			  struct gpio_chip **gpio_chip);
+	int (*get_gpio_state)(void *data, unsigned long eint_n);
+	int (*set_gpio_as_eint)(void *data, unsigned long eint_n);
+};
+
+struct mtk_eint {
+	struct device *dev;
+	void __iomem *base;
+	struct irq_domain *domain;
+	int irq;
+
+	int *dual_edge;
+	u32 *wake_mask;
+	u32 *cur_mask;
+
+	/* Used to fit into various EINT device */
+	const struct mtk_eint_hw *hw;
+	const struct mtk_eint_regs *regs;
+
+	/* Used to fit into various pinctrl device */
+	void *pctl;
+	const struct mtk_eint_xt *gpio_xlate;
+};
+
+#if IS_ENABLED(CONFIG_EINT_MTK)
+int mtk_eint_do_init(struct mtk_eint *eint);
+int mtk_eint_do_suspend(struct mtk_eint *eint);
+int mtk_eint_do_resume(struct mtk_eint *eint);
+int mtk_eint_set_debounce(struct mtk_eint *eint, unsigned long eint_n,
+			  unsigned int debounce);
+int mtk_eint_find_irq(struct mtk_eint *eint, unsigned long eint_n);
+
+#else
+static inline int mtk_eint_do_init(struct mtk_eint *eint)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int mtk_eint_do_suspend(struct mtk_eint *eint)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int mtk_eint_do_resume(struct mtk_eint *eint)
+{
+	return -EOPNOTSUPP;
+}
+
+int mtk_eint_set_debounce(struct mtk_eint *eint, unsigned long eint_n,
+			  unsigned int debounce)
+{
+	return -EOPNOTSUPP;
+}
+
+int mtk_eint_find_irq(struct mtk_eint *eint, unsigned long eint_n)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+#endif /* __MTK_EINT_H */
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt2701.c b/drivers/pinctrl/mediatek/pinctrl-mt2701.c
index f86f3b3..e0963c6 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt2701.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt2701.c
@@ -531,8 +531,14 @@ static const struct mtk_pinctrl_devdata mt2701_pinctrl_data = {
 	.port_shf = 4,
 	.port_mask = 0x1f,
 	.port_align = 4,
-	.eint_offsets = {
+	.eint_hw = {
 		.name = "mt2701_eint",
+		.port_mask = 6,
+		.ports     = 6,
+		.ap_num    = 169,
+		.db_cnt    = 16,
+	},
+	.eint_regs = {
 		.stat      = 0x000,
 		.ack       = 0x040,
 		.mask      = 0x080,
@@ -551,11 +557,7 @@ static const struct mtk_pinctrl_devdata mt2701_pinctrl_data = {
 		.dbnc_ctrl = 0x500,
 		.dbnc_set  = 0x600,
 		.dbnc_clr  = 0x700,
-		.port_mask = 6,
-		.ports     = 6,
 	},
-	.ap_num = 169,
-	.db_cnt = 16,
 };
 
 static int mt2701_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt2712.c b/drivers/pinctrl/mediatek/pinctrl-mt2712.c
index 81e11f9..02aff28 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt2712.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt2712.c
@@ -576,8 +576,14 @@ static const struct mtk_pinctrl_devdata mt2712_pinctrl_data = {
 	.port_shf = 4,
 	.port_mask = 0xf,
 	.port_align = 4,
-	.eint_offsets = {
+	.eint_hw = {
 		.name = "mt2712_eint",
+		.port_mask = 0xf,
+		.ports     = 8,
+		.ap_num    = 229,
+		.db_cnt    = 40,
+	},
+	.eint_regs = {
 		.stat      = 0x000,
 		.ack       = 0x040,
 		.mask      = 0x080,
@@ -596,11 +602,7 @@ static const struct mtk_pinctrl_devdata mt2712_pinctrl_data = {
 		.dbnc_ctrl = 0x500,
 		.dbnc_set  = 0x600,
 		.dbnc_clr  = 0x700,
-		.port_mask = 0xf,
-		.ports     = 8,
 	},
-	.ap_num = 229,
-	.db_cnt = 40,
 };
 
 static int mt2712_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8127.c b/drivers/pinctrl/mediatek/pinctrl-mt8127.c
index d764915..71f6258 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8127.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8127.c
@@ -300,8 +300,14 @@ static const struct mtk_pinctrl_devdata mt8127_pinctrl_data = {
 	.port_shf = 4,
 	.port_mask = 0xf,
 	.port_align = 4,
-	.eint_offsets = {
+	.eint_hw = {
 		.name = "mt8127_eint",
+		.port_mask = 7,
+		.ports     = 6,
+		.ap_num    = 143,
+		.db_cnt    = 16,
+	},
+	.eint_regs = {
 		.stat      = 0x000,
 		.ack       = 0x040,
 		.mask      = 0x080,
@@ -320,11 +326,7 @@ static const struct mtk_pinctrl_devdata mt8127_pinctrl_data = {
 		.dbnc_ctrl = 0x500,
 		.dbnc_set  = 0x600,
 		.dbnc_clr  = 0x700,
-		.port_mask = 7,
-		.ports     = 6,
 	},
-	.ap_num = 143,
-	.db_cnt = 16,
 };
 
 static int mt8127_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8135.c b/drivers/pinctrl/mediatek/pinctrl-mt8135.c
index d8c645f..fdfa357 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8135.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8135.c
@@ -313,8 +313,14 @@ static const struct mtk_pinctrl_devdata mt8135_pinctrl_data = {
 	.port_shf = 4,
 	.port_mask = 0xf,
 	.port_align = 4,
-	.eint_offsets = {
+	.eint_hw = {
 		.name = "mt8135_eint",
+		.port_mask = 7,
+		.ports     = 6,
+		.ap_num    = 192,
+		.db_cnt    = 16,
+	},
+	.eint_regs = {
 		.stat      = 0x000,
 		.ack       = 0x040,
 		.mask      = 0x080,
@@ -333,11 +339,7 @@ static const struct mtk_pinctrl_devdata mt8135_pinctrl_data = {
 		.dbnc_ctrl = 0x500,
 		.dbnc_set  = 0x600,
 		.dbnc_clr  = 0x700,
-		.port_mask = 7,
-		.ports     = 6,
 	},
-	.ap_num = 192,
-	.db_cnt = 16,
 };
 
 static int mt8135_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8173.c b/drivers/pinctrl/mediatek/pinctrl-mt8173.c
index 8bfd427..1466c95 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8173.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8173.c
@@ -340,8 +340,14 @@ static const struct mtk_pinctrl_devdata mt8173_pinctrl_data = {
 	.port_shf = 4,
 	.port_mask = 0xf,
 	.port_align = 4,
-	.eint_offsets = {
+	.eint_hw = {
 		.name = "mt8173_eint",
+		.port_mask = 7,
+		.ports     = 6,
+		.ap_num    = 224,
+		.db_cnt    = 16,
+	},
+	.eint_regs = {
 		.stat      = 0x000,
 		.ack       = 0x040,
 		.mask      = 0x080,
@@ -360,11 +366,7 @@ static const struct mtk_pinctrl_devdata mt8173_pinctrl_data = {
 		.dbnc_ctrl = 0x500,
 		.dbnc_set  = 0x600,
 		.dbnc_clr  = 0x700,
-		.port_mask = 7,
-		.ports     = 6,
 	},
-	.ap_num = 224,
-	.db_cnt = 16,
 };
 
 static int mt8173_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index c3975a0..11e0d0f 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -38,6 +38,7 @@
 #include "../core.h"
 #include "../pinconf.h"
 #include "../pinctrl-utils.h"
+#include "mtk-eint.h"
 #include "pinctrl-mtk-common.h"
 
 #define MAX_GPIO_MODE_PER_REG 5
@@ -831,243 +832,38 @@ static int mtk_gpio_get(struct gpio_chip *chip, unsigned offset)
 
 static int mtk_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 {
-	const struct mtk_desc_pin *pin;
 	struct mtk_pinctrl *pctl = gpiochip_get_data(chip);
-	int irq;
-
-	pin = pctl->devdata->pins + offset;
-	if (pin->eint.eintnum == NO_EINT_SUPPORT)
-		return -EINVAL;
-
-	irq = irq_find_mapping(pctl->domain, pin->eint.eintnum);
-	if (!irq)
-		return -EINVAL;
-
-	return irq;
-}
-
-static int mtk_pinctrl_irq_request_resources(struct irq_data *d)
-{
-	struct mtk_pinctrl *pctl = irq_data_get_irq_chip_data(d);
-	const struct mtk_desc_pin *pin;
-	int ret;
-
-	pin = mtk_find_pin_by_eint_num(pctl, d->hwirq);
-
-	if (!pin) {
-		dev_err(pctl->dev, "Can not find pin\n");
-		return -EINVAL;
-	}
-
-	ret = gpiochip_lock_as_irq(pctl->chip, pin->pin.number);
-	if (ret) {
-		dev_err(pctl->dev, "unable to lock HW IRQ %lu for IRQ\n",
-			irqd_to_hwirq(d));
-		return ret;
-	}
-
-	/* set mux to INT mode */
-	mtk_pmx_set_mode(pctl->pctl_dev, pin->pin.number, pin->eint.eintmux);
-	/* set gpio direction to input */
-	mtk_pmx_gpio_set_direction(pctl->pctl_dev, NULL, pin->pin.number, true);
-	/* set input-enable */
-	mtk_pconf_set_ies_smt(pctl, pin->pin.number, 1, PIN_CONFIG_INPUT_ENABLE);
-
-	return 0;
-}
-
-static void mtk_pinctrl_irq_release_resources(struct irq_data *d)
-{
-	struct mtk_pinctrl *pctl = irq_data_get_irq_chip_data(d);
-	const struct mtk_desc_pin *pin;
-
-	pin = mtk_find_pin_by_eint_num(pctl, d->hwirq);
-
-	if (!pin) {
-		dev_err(pctl->dev, "Can not find pin\n");
-		return;
-	}
-
-	gpiochip_unlock_as_irq(pctl->chip, pin->pin.number);
-}
-
-static void __iomem *mtk_eint_get_offset(struct mtk_pinctrl *pctl,
-	unsigned int eint_num, unsigned int offset)
-{
-	unsigned int eint_base = 0;
-	void __iomem *reg;
-
-	if (eint_num >= pctl->devdata->ap_num)
-		eint_base = pctl->devdata->ap_num;
-
-	reg = pctl->eint_reg_base + offset + ((eint_num - eint_base) / 32) * 4;
-
-	return reg;
-}
-
-/*
- * mtk_can_en_debounce: Check the EINT number is able to enable debounce or not
- * @eint_num: the EINT number to setmtk_pinctrl
- */
-static unsigned int mtk_eint_can_en_debounce(struct mtk_pinctrl *pctl,
-	unsigned int eint_num)
-{
-	unsigned int sens;
-	unsigned int bit = BIT(eint_num % 32);
-	const struct mtk_eint_offsets *eint_offsets =
-		&pctl->devdata->eint_offsets;
-
-	void __iomem *reg = mtk_eint_get_offset(pctl, eint_num,
-			eint_offsets->sens);
-
-	if (readl(reg) & bit)
-		sens = MT_LEVEL_SENSITIVE;
-	else
-		sens = MT_EDGE_SENSITIVE;
-
-	if ((eint_num < pctl->devdata->db_cnt) && (sens != MT_EDGE_SENSITIVE))
-		return 1;
-	else
-		return 0;
-}
-
-/*
- * mtk_eint_get_mask: To get the eint mask
- * @eint_num: the EINT number to get
- */
-static unsigned int mtk_eint_get_mask(struct mtk_pinctrl *pctl,
-	unsigned int eint_num)
-{
-	unsigned int bit = BIT(eint_num % 32);
-	const struct mtk_eint_offsets *eint_offsets =
-		&pctl->devdata->eint_offsets;
-
-	void __iomem *reg = mtk_eint_get_offset(pctl, eint_num,
-			eint_offsets->mask);
-
-	return !!(readl(reg) & bit);
-}
-
-static int mtk_eint_flip_edge(struct mtk_pinctrl *pctl, int hwirq)
-{
-	int start_level, curr_level;
-	unsigned int reg_offset;
-	const struct mtk_eint_offsets *eint_offsets = &(pctl->devdata->eint_offsets);
-	u32 mask = BIT(hwirq & 0x1f);
-	u32 port = (hwirq >> 5) & eint_offsets->port_mask;
-	void __iomem *reg = pctl->eint_reg_base + (port << 2);
-	const struct mtk_desc_pin *pin;
-
-	pin = mtk_find_pin_by_eint_num(pctl, hwirq);
-	curr_level = mtk_gpio_get(pctl->chip, pin->pin.number);
-	do {
-		start_level = curr_level;
-		if (start_level)
-			reg_offset = eint_offsets->pol_clr;
-		else
-			reg_offset = eint_offsets->pol_set;
-		writel(mask, reg + reg_offset);
-
-		curr_level = mtk_gpio_get(pctl->chip, pin->pin.number);
-	} while (start_level != curr_level);
-
-	return start_level;
-}
-
-static void mtk_eint_mask(struct irq_data *d)
-{
-	struct mtk_pinctrl *pctl = irq_data_get_irq_chip_data(d);
-	const struct mtk_eint_offsets *eint_offsets =
-			&pctl->devdata->eint_offsets;
-	u32 mask = BIT(d->hwirq & 0x1f);
-	void __iomem *reg = mtk_eint_get_offset(pctl, d->hwirq,
-			eint_offsets->mask_set);
-
-	writel(mask, reg);
-}
-
-static void mtk_eint_unmask(struct irq_data *d)
-{
-	struct mtk_pinctrl *pctl = irq_data_get_irq_chip_data(d);
-	const struct mtk_eint_offsets *eint_offsets =
-		&pctl->devdata->eint_offsets;
-	u32 mask = BIT(d->hwirq & 0x1f);
-	void __iomem *reg = mtk_eint_get_offset(pctl, d->hwirq,
-			eint_offsets->mask_clr);
-
-	writel(mask, reg);
-
-	if (pctl->eint_dual_edges[d->hwirq])
-		mtk_eint_flip_edge(pctl, d->hwirq);
-}
-
-static int mtk_gpio_set_debounce(struct gpio_chip *chip, unsigned offset,
-	unsigned debounce)
-{
-	struct mtk_pinctrl *pctl = dev_get_drvdata(chip->parent);
-	int eint_num, virq, eint_offset;
-	unsigned int set_offset, bit, clr_bit, clr_offset, rst, i, unmask, dbnc;
-	static const unsigned int debounce_time[] = {500, 1000, 16000, 32000, 64000,
-						128000, 256000};
 	const struct mtk_desc_pin *pin;
-	struct irq_data *d;
+	unsigned long eint_n;
 
 	pin = pctl->devdata->pins + offset;
 	if (pin->eint.eintnum == NO_EINT_SUPPORT)
 		return -EINVAL;
 
-	eint_num = pin->eint.eintnum;
-	virq = irq_find_mapping(pctl->domain, eint_num);
-	eint_offset = (eint_num % 4) * 8;
-	d = irq_get_irq_data(virq);
-
-	set_offset = (eint_num / 4) * 4 + pctl->devdata->eint_offsets.dbnc_set;
-	clr_offset = (eint_num / 4) * 4 + pctl->devdata->eint_offsets.dbnc_clr;
-	if (!mtk_eint_can_en_debounce(pctl, eint_num))
-		return -ENOSYS;
-
-	dbnc = ARRAY_SIZE(debounce_time);
-	for (i = 0; i < ARRAY_SIZE(debounce_time); i++) {
-		if (debounce <= debounce_time[i]) {
-			dbnc = i;
-			break;
-		}
-	}
+	eint_n = pin->eint.eintnum;
 
-	if (!mtk_eint_get_mask(pctl, eint_num)) {
-		mtk_eint_mask(d);
-		unmask = 1;
-	} else {
-		unmask = 0;
-	}
-
-	clr_bit = 0xff << eint_offset;
-	writel(clr_bit, pctl->eint_reg_base + clr_offset);
-
-	bit = ((dbnc << EINT_DBNC_SET_DBNC_BITS) | EINT_DBNC_SET_EN) <<
-		eint_offset;
-	rst = EINT_DBNC_RST_BIT << eint_offset;
-	writel(rst | bit, pctl->eint_reg_base + set_offset);
-
-	/* Delay a while (more than 2T) to wait for hw debounce counter reset
-	work correctly */
-	udelay(1);
-	if (unmask == 1)
-		mtk_eint_unmask(d);
-
-	return 0;
+	return mtk_eint_find_irq(pctl->eint, eint_n);
 }
 
 static int mtk_gpio_set_config(struct gpio_chip *chip, unsigned offset,
 			       unsigned long config)
 {
+	struct mtk_pinctrl *pctl = gpiochip_get_data(chip);
+	const struct mtk_desc_pin *pin;
+	unsigned long eint_n;
 	u32 debounce;
 
 	if (pinconf_to_config_param(config) != PIN_CONFIG_INPUT_DEBOUNCE)
 		return -ENOTSUPP;
 
+	pin = pctl->devdata->pins + offset;
+	if (pin->eint.eintnum == NO_EINT_SUPPORT)
+		return -EINVAL;
+
 	debounce = pinconf_to_config_argument(config);
-	return mtk_gpio_set_debounce(chip, offset, debounce);
+	eint_n = pin->eint.eintnum;
+
+	return mtk_eint_set_debounce(pctl->eint, eint_n, debounce);
 }
 
 static const struct gpio_chip mtk_gpio_chip = {
@@ -1084,117 +880,18 @@ static const struct gpio_chip mtk_gpio_chip = {
 	.of_gpio_n_cells	= 2,
 };
 
-static int mtk_eint_set_type(struct irq_data *d,
-				      unsigned int type)
-{
-	struct mtk_pinctrl *pctl = irq_data_get_irq_chip_data(d);
-	const struct mtk_eint_offsets *eint_offsets =
-		&pctl->devdata->eint_offsets;
-	u32 mask = BIT(d->hwirq & 0x1f);
-	void __iomem *reg;
-
-	if (((type & IRQ_TYPE_EDGE_BOTH) && (type & IRQ_TYPE_LEVEL_MASK)) ||
-		((type & IRQ_TYPE_LEVEL_MASK) == IRQ_TYPE_LEVEL_MASK)) {
-		dev_err(pctl->dev, "Can't configure IRQ%d (EINT%lu) for type 0x%X\n",
-			d->irq, d->hwirq, type);
-		return -EINVAL;
-	}
-
-	if ((type & IRQ_TYPE_EDGE_BOTH) == IRQ_TYPE_EDGE_BOTH)
-		pctl->eint_dual_edges[d->hwirq] = 1;
-	else
-		pctl->eint_dual_edges[d->hwirq] = 0;
-
-	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_EDGE_FALLING)) {
-		reg = mtk_eint_get_offset(pctl, d->hwirq,
-			eint_offsets->pol_clr);
-		writel(mask, reg);
-	} else {
-		reg = mtk_eint_get_offset(pctl, d->hwirq,
-			eint_offsets->pol_set);
-		writel(mask, reg);
-	}
-
-	if (type & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING)) {
-		reg = mtk_eint_get_offset(pctl, d->hwirq,
-			eint_offsets->sens_clr);
-		writel(mask, reg);
-	} else {
-		reg = mtk_eint_get_offset(pctl, d->hwirq,
-			eint_offsets->sens_set);
-		writel(mask, reg);
-	}
-
-	if (pctl->eint_dual_edges[d->hwirq])
-		mtk_eint_flip_edge(pctl, d->hwirq);
-
-	return 0;
-}
-
-static int mtk_eint_irq_set_wake(struct irq_data *d, unsigned int on)
-{
-	struct mtk_pinctrl *pctl = irq_data_get_irq_chip_data(d);
-	int shift = d->hwirq & 0x1f;
-	int reg = d->hwirq >> 5;
-
-	if (on)
-		pctl->wake_mask[reg] |= BIT(shift);
-	else
-		pctl->wake_mask[reg] &= ~BIT(shift);
-
-	return 0;
-}
-
-static void mtk_eint_chip_write_mask(const struct mtk_eint_offsets *chip,
-		void __iomem *eint_reg_base, u32 *buf)
-{
-	int port;
-	void __iomem *reg;
-
-	for (port = 0; port < chip->ports; port++) {
-		reg = eint_reg_base + (port << 2);
-		writel_relaxed(~buf[port], reg + chip->mask_set);
-		writel_relaxed(buf[port], reg + chip->mask_clr);
-	}
-}
-
-static void mtk_eint_chip_read_mask(const struct mtk_eint_offsets *chip,
-		void __iomem *eint_reg_base, u32 *buf)
-{
-	int port;
-	void __iomem *reg;
-
-	for (port = 0; port < chip->ports; port++) {
-		reg = eint_reg_base + chip->mask + (port << 2);
-		buf[port] = ~readl_relaxed(reg);
-		/* Mask is 0 when irq is enabled, and 1 when disabled. */
-	}
-}
-
 static int mtk_eint_suspend(struct device *device)
 {
-	void __iomem *reg;
 	struct mtk_pinctrl *pctl = dev_get_drvdata(device);
-	const struct mtk_eint_offsets *eint_offsets =
-			&pctl->devdata->eint_offsets;
 
-	reg = pctl->eint_reg_base;
-	mtk_eint_chip_read_mask(eint_offsets, reg, pctl->cur_mask);
-	mtk_eint_chip_write_mask(eint_offsets, reg, pctl->wake_mask);
-
-	return 0;
+	return mtk_eint_do_suspend(pctl->eint);
 }
 
 static int mtk_eint_resume(struct device *device)
 {
 	struct mtk_pinctrl *pctl = dev_get_drvdata(device);
-	const struct mtk_eint_offsets *eint_offsets =
-			&pctl->devdata->eint_offsets;
 
-	mtk_eint_chip_write_mask(eint_offsets,
-			pctl->eint_reg_base, pctl->cur_mask);
-
-	return 0;
+	return mtk_eint_do_resume(pctl->eint);
 }
 
 const struct dev_pm_ops mtk_eint_pm_ops = {
@@ -1202,117 +899,6 @@ const struct dev_pm_ops mtk_eint_pm_ops = {
 	.resume_noirq = mtk_eint_resume,
 };
 
-static void mtk_eint_ack(struct irq_data *d)
-{
-	struct mtk_pinctrl *pctl = irq_data_get_irq_chip_data(d);
-	const struct mtk_eint_offsets *eint_offsets =
-		&pctl->devdata->eint_offsets;
-	u32 mask = BIT(d->hwirq & 0x1f);
-	void __iomem *reg = mtk_eint_get_offset(pctl, d->hwirq,
-			eint_offsets->ack);
-
-	writel(mask, reg);
-}
-
-static struct irq_chip mtk_pinctrl_irq_chip = {
-	.name = "mt-eint",
-	.irq_disable = mtk_eint_mask,
-	.irq_mask = mtk_eint_mask,
-	.irq_unmask = mtk_eint_unmask,
-	.irq_ack = mtk_eint_ack,
-	.irq_set_type = mtk_eint_set_type,
-	.irq_set_wake = mtk_eint_irq_set_wake,
-	.irq_request_resources = mtk_pinctrl_irq_request_resources,
-	.irq_release_resources = mtk_pinctrl_irq_release_resources,
-};
-
-static unsigned int mtk_eint_init(struct mtk_pinctrl *pctl)
-{
-	const struct mtk_eint_offsets *eint_offsets =
-		&pctl->devdata->eint_offsets;
-	void __iomem *reg = pctl->eint_reg_base + eint_offsets->dom_en;
-	unsigned int i;
-
-	for (i = 0; i < pctl->devdata->ap_num; i += 32) {
-		writel(0xffffffff, reg);
-		reg += 4;
-	}
-	return 0;
-}
-
-static inline void
-mtk_eint_debounce_process(struct mtk_pinctrl *pctl, int index)
-{
-	unsigned int rst, ctrl_offset;
-	unsigned int bit, dbnc;
-	const struct mtk_eint_offsets *eint_offsets =
-		&pctl->devdata->eint_offsets;
-
-	ctrl_offset = (index / 4) * 4 + eint_offsets->dbnc_ctrl;
-	dbnc = readl(pctl->eint_reg_base + ctrl_offset);
-	bit = EINT_DBNC_SET_EN << ((index % 4) * 8);
-	if ((bit & dbnc) > 0) {
-		ctrl_offset = (index / 4) * 4 + eint_offsets->dbnc_set;
-		rst = EINT_DBNC_RST_BIT << ((index % 4) * 8);
-		writel(rst, pctl->eint_reg_base + ctrl_offset);
-	}
-}
-
-static void mtk_eint_irq_handler(struct irq_desc *desc)
-{
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct mtk_pinctrl *pctl = irq_desc_get_handler_data(desc);
-	unsigned int status, eint_num;
-	int offset, index, virq;
-	const struct mtk_eint_offsets *eint_offsets =
-		&pctl->devdata->eint_offsets;
-	void __iomem *reg =  mtk_eint_get_offset(pctl, 0, eint_offsets->stat);
-	int dual_edges, start_level, curr_level;
-	const struct mtk_desc_pin *pin;
-
-	chained_irq_enter(chip, desc);
-	for (eint_num = 0;
-	     eint_num < pctl->devdata->ap_num;
-	     eint_num += 32, reg += 4) {
-		status = readl(reg);
-		while (status) {
-			offset = __ffs(status);
-			index = eint_num + offset;
-			virq = irq_find_mapping(pctl->domain, index);
-			status &= ~BIT(offset);
-
-			dual_edges = pctl->eint_dual_edges[index];
-			if (dual_edges) {
-				/* Clear soft-irq in case we raised it
-				   last time */
-				writel(BIT(offset), reg - eint_offsets->stat +
-					eint_offsets->soft_clr);
-
-				pin = mtk_find_pin_by_eint_num(pctl, index);
-				start_level = mtk_gpio_get(pctl->chip,
-							   pin->pin.number);
-			}
-
-			generic_handle_irq(virq);
-
-			if (dual_edges) {
-				curr_level = mtk_eint_flip_edge(pctl, index);
-
-				/* If level changed, we might lost one edge
-				   interrupt, raised it through soft-irq */
-				if (start_level != curr_level)
-					writel(BIT(offset), reg -
-						eint_offsets->stat +
-						eint_offsets->soft_set);
-			}
-
-			if (index < pctl->devdata->db_cnt)
-				mtk_eint_debounce_process(pctl , index);
-		}
-	}
-	chained_irq_exit(chip, desc);
-}
-
 static int mtk_pctrl_build_state(struct platform_device *pdev)
 {
 	struct mtk_pinctrl *pctl = platform_get_drvdata(pdev);
@@ -1345,6 +931,97 @@ static int mtk_pctrl_build_state(struct platform_device *pdev)
 	return 0;
 }
 
+static int
+mtk_xt_get_gpio_n(void *data, unsigned long eint_n, unsigned int *gpio_n,
+		  struct gpio_chip **gpio_chip)
+{
+	struct mtk_pinctrl *pctl = (struct mtk_pinctrl *)data;
+	const struct mtk_desc_pin *pin;
+
+	pin = mtk_find_pin_by_eint_num(pctl, eint_n);
+	if (!pin)
+		return -EINVAL;
+
+	*gpio_chip = pctl->chip;
+	*gpio_n = pin->pin.number;
+
+	return 0;
+}
+
+static int mtk_xt_get_gpio_state(void *data, unsigned long eint_n)
+{
+	struct mtk_pinctrl *pctl = (struct mtk_pinctrl *)data;
+	const struct mtk_desc_pin *pin;
+
+	pin = mtk_find_pin_by_eint_num(pctl, eint_n);
+	if (!pin)
+		return -EINVAL;
+
+	return mtk_gpio_get(pctl->chip, pin->pin.number);
+}
+
+static int mtk_xt_set_gpio_as_eint(void *data, unsigned long eint_n)
+{
+	struct mtk_pinctrl *pctl = (struct mtk_pinctrl *)data;
+	const struct mtk_desc_pin *pin;
+
+	pin = mtk_find_pin_by_eint_num(pctl, eint_n);
+	if (!pin)
+		return -EINVAL;
+
+	/* set mux to INT mode */
+	mtk_pmx_set_mode(pctl->pctl_dev, pin->pin.number, pin->eint.eintmux);
+	/* set gpio direction to input */
+	mtk_pmx_gpio_set_direction(pctl->pctl_dev, NULL, pin->pin.number,
+				   true);
+	/* set input-enable */
+	mtk_pconf_set_ies_smt(pctl, pin->pin.number, 1,
+			      PIN_CONFIG_INPUT_ENABLE);
+
+	return 0;
+}
+
+static const struct mtk_eint_xt mtk_eint_xt = {
+	.get_gpio_n = mtk_xt_get_gpio_n,
+	.get_gpio_state = mtk_xt_get_gpio_state,
+	.set_gpio_as_eint = mtk_xt_set_gpio_as_eint,
+};
+
+static int mtk_eint_init(struct mtk_pinctrl *pctl, struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct resource *res;
+
+	if (!of_property_read_bool(np, "interrupt-controller"))
+		return -ENODEV;
+
+	pctl->eint = devm_kzalloc(pctl->dev, sizeof(*pctl->eint), GFP_KERNEL);
+	if (!pctl->eint)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Unable to get eint resource\n");
+		return -ENODEV;
+	}
+
+	pctl->eint->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pctl->eint->base))
+		return PTR_ERR(pctl->eint->base);
+
+	pctl->eint->irq = irq_of_parse_and_map(np, 0);
+	if (!pctl->eint->irq)
+		return -EINVAL;
+
+	pctl->eint->dev = &pdev->dev;
+	pctl->eint->regs = &pctl->devdata->eint_regs;
+	pctl->eint->hw = &pctl->devdata->eint_hw;
+	pctl->eint->pctl = pctl;
+	pctl->eint->gpio_xlate = &mtk_eint_xt;
+
+	return mtk_eint_do_init(pctl->eint);
+}
+
 int mtk_pctrl_init(struct platform_device *pdev,
 		const struct mtk_pinctrl_devdata *data,
 		struct regmap *regmap)
@@ -1353,8 +1030,7 @@ int mtk_pctrl_init(struct platform_device *pdev,
 	struct mtk_pinctrl *pctl;
 	struct device_node *np = pdev->dev.of_node, *node;
 	struct property *prop;
-	struct resource *res;
-	int i, ret, irq, ports_buf;
+	int ret, i;
 
 	pctl = devm_kzalloc(&pdev->dev, sizeof(*pctl), GFP_KERNEL);
 	if (!pctl)
@@ -1441,70 +1117,10 @@ int mtk_pctrl_init(struct platform_device *pdev,
 		goto chip_error;
 	}
 
-	if (!of_property_read_bool(np, "interrupt-controller"))
-		return 0;
-
-	/* Get EINT register base from dts. */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "Unable to get Pinctrl resource\n");
-		ret = -EINVAL;
-		goto chip_error;
-	}
-
-	pctl->eint_reg_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(pctl->eint_reg_base)) {
-		ret = -EINVAL;
-		goto chip_error;
-	}
-
-	ports_buf = pctl->devdata->eint_offsets.ports;
-	pctl->wake_mask = devm_kcalloc(&pdev->dev, ports_buf,
-					sizeof(*pctl->wake_mask), GFP_KERNEL);
-	if (!pctl->wake_mask) {
-		ret = -ENOMEM;
-		goto chip_error;
-	}
-
-	pctl->cur_mask = devm_kcalloc(&pdev->dev, ports_buf,
-					sizeof(*pctl->cur_mask), GFP_KERNEL);
-	if (!pctl->cur_mask) {
-		ret = -ENOMEM;
-		goto chip_error;
-	}
-
-	pctl->eint_dual_edges = devm_kcalloc(&pdev->dev, pctl->devdata->ap_num,
-					     sizeof(int), GFP_KERNEL);
-	if (!pctl->eint_dual_edges) {
-		ret = -ENOMEM;
-		goto chip_error;
-	}
-
-	irq = irq_of_parse_and_map(np, 0);
-	if (!irq) {
-		dev_err(&pdev->dev, "couldn't parse and map irq\n");
-		ret = -EINVAL;
-		goto chip_error;
-	}
-
-	pctl->domain = irq_domain_add_linear(np,
-		pctl->devdata->ap_num, &irq_domain_simple_ops, NULL);
-	if (!pctl->domain) {
-		dev_err(&pdev->dev, "Couldn't register IRQ domain\n");
-		ret = -ENOMEM;
+	ret = mtk_eint_init(pctl, pdev);
+	if (ret)
 		goto chip_error;
-	}
-
-	mtk_eint_init(pctl);
-	for (i = 0; i < pctl->devdata->ap_num; i++) {
-		int virq = irq_create_mapping(pctl->domain, i);
-
-		irq_set_chip_and_handler(virq, &mtk_pinctrl_irq_chip,
-			handle_level_irq);
-		irq_set_chip_data(virq, pctl);
-	}
 
-	irq_set_chained_handler_and_data(irq, mtk_eint_irq_handler, pctl);
 	return 0;
 
 chip_error:
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
index 8543bc4..346e3db 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
@@ -19,6 +19,8 @@
 #include <linux/regmap.h>
 #include <linux/pinctrl/pinconf-generic.h>
 
+#include "mtk-eint.h"
+
 #define NO_EINT_SUPPORT    255
 #define MT_EDGE_SENSITIVE           0
 #define MT_LEVEL_SENSITIVE          1
@@ -258,9 +260,8 @@ struct mtk_pinctrl_devdata {
 	unsigned char  port_shf;
 	unsigned char  port_mask;
 	unsigned char  port_align;
-	struct mtk_eint_offsets eint_offsets;
-	unsigned int	ap_num;
-	unsigned int	db_cnt;
+	struct mtk_eint_hw eint_hw;
+	struct mtk_eint_regs eint_regs;
 };
 
 struct mtk_pinctrl {
@@ -274,11 +275,7 @@ struct mtk_pinctrl {
 	const char          **grp_names;
 	struct pinctrl_dev      *pctl_dev;
 	const struct mtk_pinctrl_devdata  *devdata;
-	void __iomem		*eint_reg_base;
-	struct irq_domain	*domain;
-	int			*eint_dual_edges;
-	u32 *wake_mask;
-	u32 *cur_mask;
+	struct mtk_eint *eint;
 };
 
 int mtk_pctrl_init(struct platform_device *pdev,
-- 
2.7.4
