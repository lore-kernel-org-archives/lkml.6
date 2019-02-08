Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B94C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F88E2177B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfBHM1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:27:46 -0500
Received: from mx.socionext.com ([202.248.49.38]:27816 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbfBHM1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:27:45 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 08 Feb 2019 21:27:39 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id A010E180D62;
        Fri,  8 Feb 2019 21:27:39 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 8 Feb 2019 21:27:39 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 30DD41A04E1;
        Fri,  8 Feb 2019 21:27:39 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 1D2681202F1;
        Fri,  8 Feb 2019 21:27:39 +0900 (JST)
From:   Sugaya Taichi <sugaya.taichi@socionext.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: [PATCH v2 12/15] pinctrl: milbeaut: Add Milbeaut M10V pinctrl
Date:   Fri,  8 Feb 2019 21:28:17 +0900
Message-Id: <1549628897-32345-1-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Milbeaut M10V pinctrl.
The M10V has the pins that can be used GPIOs or take multiple other
functions.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 drivers/pinctrl/Kconfig            |   9 +
 drivers/pinctrl/Makefile           |   1 +
 drivers/pinctrl/pinctrl-milbeaut.c | 759 +++++++++++++++++++++++++++++++++++++
 3 files changed, 769 insertions(+)
 create mode 100644 drivers/pinctrl/pinctrl-milbeaut.c

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 2764d71..d968910 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -177,6 +177,15 @@ config PINCTRL_OXNAS
 	select GPIOLIB_IRQCHIP
 	select MFD_SYSCON
 
+config PINCTRL_MILBEAUT
+	bool
+	select PINMUX
+	select PINCONF
+	select GENERIC_PINCONF
+	select OF_GPIO
+	select REGMAP_MMIO
+	select GPIOLIB_IRQCHIP
+
 config PINCTRL_ROCKCHIP
 	bool
 	select PINMUX
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 712184b..ade9aea 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_PINCTRL_GEMINI)	+= pinctrl-gemini.o
 obj-$(CONFIG_PINCTRL_MAX77620)	+= pinctrl-max77620.o
 obj-$(CONFIG_PINCTRL_MCP23S08)	+= pinctrl-mcp23s08.o
 obj-$(CONFIG_PINCTRL_MESON)	+= meson/
+obj-$(CONFIG_PINCTRL_MILBEAUT)	+= pinctrl-milbeaut.o
 obj-$(CONFIG_PINCTRL_OXNAS)	+= pinctrl-oxnas.o
 obj-$(CONFIG_PINCTRL_PALMAS)	+= pinctrl-palmas.o
 obj-$(CONFIG_PINCTRL_PIC32)	+= pinctrl-pic32.o
diff --git a/drivers/pinctrl/pinctrl-milbeaut.c b/drivers/pinctrl/pinctrl-milbeaut.c
new file mode 100644
index 0000000..c9a7da4
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-milbeaut.c
@@ -0,0 +1,759 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Socionext Inc.
+ * Copyright (C) 2015 Linaro Ltd.
+ * Author: Jassi Brar <jaswinder.singh@linaro.org>
+ */
+
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/pinctrl/machine.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+
+#include "pinctrl-utils.h"
+
+#define EIMASK		0x0
+#define EISRCSEL	0x4
+#define EIREQSTA	0x8
+#define EIRAWREQSTA	0xc
+#define EIREQCLR	0x10
+#define EILVL		0x14
+#define EIEDG		0x18
+#define EISIR		0x1c
+
+#define PDR		0x0
+#define PDR_S		0x50
+#define PDR_C		0xa0
+#define DDR		0x100
+#define EPCR		0x200
+#define PUDER		0x300
+#define PUDCR		0x400
+
+#define M10V_BANKS	26
+#define PINS_PER_BANK	8
+#define M10V_TOTAL_PINS	(M10V_BANKS * PINS_PER_BANK)
+#define PINS_PER_REG	16
+
+struct pin_irq_map {
+	int pin; /* offset of pin in the managed range */
+	int irq; /* virq of the pin as fpint */
+	int type;
+	char irqname[8];
+};
+
+struct m10v_pinctrl {
+	void __iomem *base;
+	void __iomem *exiu;
+	struct gpio_chip gc;
+	struct pinctrl_desc pd;
+	char pin_names[4 * M10V_TOTAL_PINS];
+	struct pinctrl_pin_desc pins[M10V_TOTAL_PINS];
+	unsigned int gpins[M10V_TOTAL_PINS][1]; /* 1 pin-per-group */
+	struct irq_domain *irqdom;
+	spinlock_t irq_lock, lock;
+	int extints;
+	struct pin_irq_map fpint[]; /* keep at end */
+};
+
+struct milbeaut_function {
+	const char		*name;
+	const char * const	*groups;
+	unsigned int		ngroups;
+};
+
+static const char m10v_bank_name[] = {'0', '1', '2', '3', '4', '5', '6', '7',
+				 '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
+				 'G', 'H', 'W', 'J', 'K', 'L', 'M', 'N',
+				 'Y', 'P'};
+static const char * const usio0_m10v_grps[] = {"PE2", "PE3", "PF0"};
+static const char * const usio1_m10v_grps[] = {"PE4", "PE5", "PF1"};
+static const char * const usio2_m10v_grps[] = {"PE0", "PE1"};
+static const char * const usio3_m10v_grps[] = {"PY0", "PY1", "PY2"};
+static const char * const usio4_m10v_grps[] = {"PP0", "PP1", "PP2"};
+static const char * const usio5_m10v_grps[] = {"PM0", "PM1", "PM3"};
+static const char * const usio6_m10v_grps[] = {"PN0", "PN1", "PN3"};
+static const char * const usio7_m10v_grps[] = {"PY3", "PY5", "PY6"};
+static const char *gpio_m10v_grps[M10V_TOTAL_PINS];
+
+static const struct milbeaut_function m10v_functions[] = {
+#define FUNC_M10V(fname)					\
+	{						\
+		.name = #fname,				\
+		.groups = fname##_m10v_grps,		\
+		.ngroups = ARRAY_SIZE(fname##_m10v_grps),	\
+	}
+	FUNC_M10V(gpio), /* GPIO always at index 0 */
+	FUNC_M10V(usio0),
+	FUNC_M10V(usio1),
+	FUNC_M10V(usio2),
+	FUNC_M10V(usio3),
+	FUNC_M10V(usio4),
+	FUNC_M10V(usio5),
+	FUNC_M10V(usio6),
+	FUNC_M10V(usio7),
+};
+
+static const char *bank_name;
+static const struct milbeaut_function *milbeaut_functions;
+
+static int m10v_pconf_group_set(struct pinctrl_dev *pctldev,
+				 unsigned int group,
+				 unsigned long *configs,
+				 unsigned int num_configs)
+{
+	struct m10v_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	u32 pin, val, reg, offset;
+	unsigned long flags;
+	int i;
+
+	pin = pctl->gpins[group][0];
+	reg = pin / PINS_PER_REG * 4;
+	offset = pin % PINS_PER_REG;
+
+	spin_lock_irqsave(&pctl->lock, flags);
+
+	for (i = 0; i < num_configs; i++) {
+		switch (pinconf_to_config_param(configs[i])) {
+		case PIN_CONFIG_BIAS_PULL_UP:
+			/* enable Pull-Up/Down resistance */
+			val = readl_relaxed(pctl->base + PUDER + reg);
+			val |= BIT(offset);
+			writel_relaxed(val, pctl->base + PUDER + reg);
+			/* enable Pull-Up */
+			val = readl_relaxed(pctl->base + PUDCR + reg);
+			val |= BIT(offset);
+			writel_relaxed(val, pctl->base + PUDCR + reg);
+			break;
+		case PIN_CONFIG_BIAS_PULL_DOWN:
+			/* enable Pull-Up/Down resistance */
+			val = readl_relaxed(pctl->base + PUDER + reg);
+			val |= BIT(offset);
+			writel_relaxed(val, pctl->base + PUDER + reg);
+			/* enable Pull-Down */
+			val = readl_relaxed(pctl->base + PUDCR + reg);
+			val &= ~BIT(offset);
+			writel_relaxed(val, pctl->base + PUDCR + reg);
+			break;
+		case PIN_CONFIG_BIAS_DISABLE:
+			val = readl_relaxed(pctl->base + PUDER + reg);
+			val &= ~BIT(offset);
+			writel_relaxed(val, pctl->base + PUDER + reg);
+			break;
+		default:
+			break;
+		}
+	}
+
+	spin_unlock_irqrestore(&pctl->lock, flags);
+
+	return 0;
+}
+
+static const struct pinconf_ops m10v_pconf_ops = {
+	.pin_config_group_set	= m10v_pconf_group_set,
+};
+
+static int m10v_pctrl_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	return M10V_TOTAL_PINS;
+}
+
+static const char *m10v_pctrl_get_group_name(struct pinctrl_dev *pctldev,
+					      unsigned int pin)
+{
+	struct m10v_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	return &pctl->pin_names[4 * pin];
+}
+
+static int m10v_pctrl_get_group_pins(struct pinctrl_dev *pctldev,
+				      unsigned int group,
+				      const unsigned int **pins,
+				      unsigned int *num_pins)
+{
+	struct m10v_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	*pins = pctl->gpins[group];
+	*num_pins = 1;
+	return 0;
+}
+
+static const struct pinctrl_ops m10v_pctrl_ops = {
+	.get_groups_count	= m10v_pctrl_get_groups_count,
+	.get_group_name		= m10v_pctrl_get_group_name,
+	.get_group_pins		= m10v_pctrl_get_group_pins,
+	.dt_node_to_map		= pinconf_generic_dt_node_to_map_group,
+	.dt_free_map		= pinctrl_utils_free_map,
+};
+
+static int m10v_pmx_get_funcs_cnt(struct pinctrl_dev *pctldev)
+{
+	return ARRAY_SIZE(m10v_functions);
+}
+
+static const char *m10v_pmx_get_func_name(struct pinctrl_dev *pctldev,
+					   unsigned int function)
+{
+	return milbeaut_functions[function].name;
+}
+
+static int m10v_pmx_get_func_groups(struct pinctrl_dev *pctldev,
+				     unsigned int function,
+				     const char * const **groups,
+				     unsigned * const num_groups)
+{
+	*groups = milbeaut_functions[function].groups;
+	*num_groups = milbeaut_functions[function].ngroups;
+	return 0;
+}
+
+static void _set_mux(struct m10v_pinctrl *pctl, unsigned int pin, bool gpio)
+{
+	u32 val, reg, offset;
+	unsigned long flags;
+
+	reg = pin / PINS_PER_REG * 4;
+	offset = pin % PINS_PER_REG;
+
+	reg += EPCR;
+
+	spin_lock_irqsave(&pctl->lock, flags);
+
+	val = readl_relaxed(pctl->base + reg);
+
+	if (gpio)
+		val &= ~BIT(offset);
+	else
+		val |= BIT(offset);
+
+	writel_relaxed(val, pctl->base + reg);
+
+	spin_unlock_irqrestore(&pctl->lock, flags);
+}
+
+static int m10v_pmx_set_mux(struct pinctrl_dev *pctldev,
+			     unsigned int function,
+			     unsigned int group)
+{
+	struct m10v_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	u32 pin = pctl->gpins[group][0]; /* each group has exactly 1 pin */
+
+	_set_mux(pctl, pin, !function);
+
+	return 0;
+}
+
+static int _set_direction(struct m10v_pinctrl *pctl,
+			unsigned int pin, bool input)
+{
+	u32 val, reg, offset;
+	unsigned long flags;
+
+	reg = pin / PINS_PER_REG * 4;
+	offset = pin % PINS_PER_REG;
+
+	reg += DDR;
+
+	spin_lock_irqsave(&pctl->lock, flags);
+
+	val = readl_relaxed(pctl->base + reg);
+
+	if (input)
+		val &= ~BIT(offset);
+	else
+		val |= BIT(offset);
+
+	writel_relaxed(val, pctl->base + reg);
+
+	spin_unlock_irqrestore(&pctl->lock, flags);
+
+	return 0;
+}
+
+static int
+m10v_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
+			struct pinctrl_gpio_range *range,
+			unsigned int pin, bool input)
+{
+	struct m10v_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	return _set_direction(pctl, pin, input);
+}
+
+static int
+m10v_pmx_gpio_request_enable(struct pinctrl_dev *pctldev,
+			    struct pinctrl_gpio_range *range,
+			    unsigned int pin)
+{
+	struct m10v_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	_set_mux(pctl, pin, true);
+	return 0;
+}
+
+static const struct pinmux_ops m10v_pmx_ops = {
+	.get_functions_count	= m10v_pmx_get_funcs_cnt,
+	.get_function_name	= m10v_pmx_get_func_name,
+	.get_function_groups	= m10v_pmx_get_func_groups,
+	.set_mux		= m10v_pmx_set_mux,
+	.gpio_set_direction	= m10v_pmx_gpio_set_direction,
+	.gpio_request_enable	= m10v_pmx_gpio_request_enable,
+};
+
+static int m10v_gpio_get(struct gpio_chip *gc, unsigned int group)
+{
+	struct m10v_pinctrl *pctl =
+		container_of(gc, struct m10v_pinctrl, gc);
+	u32 pin, val, reg, offset;
+
+	pin = pctl->gpins[group][0];
+	reg = PDR + pin / PINS_PER_REG * 4;
+	offset = pin % PINS_PER_REG;
+	val = readl_relaxed(pctl->base + reg);
+
+	return !!(val & BIT(offset));
+}
+
+static void m10v_gpio_set(struct gpio_chip *gc, unsigned int group, int set)
+{
+	struct m10v_pinctrl *pctl =
+		container_of(gc, struct m10v_pinctrl, gc);
+	u32 pin, reg, offset, val;
+
+	pin = pctl->gpins[group][0];
+	reg = PDR + pin / PINS_PER_REG * 4;
+	offset = pin % PINS_PER_REG;
+
+	val = BIT(offset + 16);
+	if (set)
+		val |= BIT(offset);
+
+	writel_relaxed(val, pctl->base + reg);
+}
+
+static void (*gpio_set)(struct gpio_chip *, unsigned int, int);
+
+static int m10v_gpio_direction_input(struct gpio_chip *gc,
+		unsigned int offset)
+{
+	return pinctrl_gpio_direction_input(gc->base + offset);
+}
+
+static int m10v_gpio_direction_output(struct gpio_chip *gc,
+		unsigned int offset, int value)
+{
+	int ret;
+
+	ret = pinctrl_gpio_direction_output(gc->base + offset);
+	if (!ret)
+		gpio_set(gc, offset, value);
+
+	return ret;
+}
+
+static int m10v_gpio_to_irq(struct gpio_chip *gc, unsigned int offset)
+{
+	struct m10v_pinctrl *pctl =
+		container_of(gc, struct m10v_pinctrl, gc);
+
+	return irq_linear_revmap(pctl->irqdom, offset);
+}
+
+static struct lock_class_key gpio_lock_class;
+static struct lock_class_key gpio_request_class;
+
+static int pin_to_extint(struct m10v_pinctrl *pctl, int pin)
+{
+	int extint;
+
+	for (extint = 0; extint < pctl->extints; extint++)
+		if (pctl->fpint[extint].pin == pin)
+			break;
+
+	if (extint == pctl->extints)
+		return -1;
+
+	return extint;
+}
+
+static void update_trigger(struct m10v_pinctrl *pctl, int extint)
+{
+	int type = pctl->fpint[extint].type;
+	int pin = pctl->fpint[extint].pin;
+	u32 masked, val, eilvl, eiedg;
+	int lvl;
+	u32 reg, offset;
+
+	reg = pin / PINS_PER_REG * 4;
+	offset = pin % PINS_PER_REG;
+
+	/* sense gpio */
+	val = readl_relaxed(pctl->base + PDR + reg);
+	lvl = (val >> offset) & 1;
+
+	eilvl = readl_relaxed(pctl->exiu + EILVL);
+	eiedg = readl_relaxed(pctl->exiu + EIEDG);
+
+	if (type == IRQ_TYPE_LEVEL_LOW ||
+			(lvl && (type & IRQ_TYPE_LEVEL_LOW))) {
+		eilvl &= ~BIT(extint);
+		eiedg &= ~BIT(extint);
+	}
+
+	if (type == IRQ_TYPE_EDGE_FALLING ||
+			(lvl && (type & IRQ_TYPE_EDGE_FALLING))) {
+		eilvl &= ~BIT(extint);
+		eiedg |= BIT(extint);
+	}
+
+	if (type == IRQ_TYPE_LEVEL_HIGH ||
+			(!lvl && (type & IRQ_TYPE_LEVEL_HIGH))) {
+		eilvl |= BIT(extint);
+		eiedg &= ~BIT(extint);
+	}
+
+	if (type == IRQ_TYPE_EDGE_RISING ||
+			(!lvl && (type & IRQ_TYPE_EDGE_RISING))) {
+		eilvl |= BIT(extint);
+		eiedg |= BIT(extint);
+	}
+
+	/* Mask the interrupt */
+	val = readl_relaxed(pctl->exiu + EIMASK);
+	masked = val & BIT(extint); /* save status */
+	val |= BIT(extint);
+	writel_relaxed(val, pctl->exiu + EIMASK);
+
+	/* Program trigger */
+	writel_relaxed(eilvl, pctl->exiu + EILVL);
+	writel_relaxed(eiedg, pctl->exiu + EIEDG);
+
+	if (masked)
+		return;
+
+	/* UnMask the interrupt */
+	val = readl_relaxed(pctl->exiu + EIMASK);
+	val &= ~BIT(extint);
+	writel_relaxed(val, pctl->exiu + EIMASK);
+}
+
+static irqreturn_t m10v_gpio_irq_handler(int irq, void *data)
+{
+	struct m10v_pinctrl *pctl = data;
+	int i, pin;
+	u32 val;
+
+	for (i = 0; i < pctl->extints; i++)
+		if (pctl->fpint[i].irq == irq)
+			break;
+	if (i == pctl->extints) {
+		pr_err("%s:%d IRQ(%d)!\n", __func__, __LINE__, irq);
+		return IRQ_NONE;
+	}
+
+	if (!pctl->exiu)
+		return IRQ_NONE;
+
+	val = readl_relaxed(pctl->exiu + EIREQSTA);
+	if (!(val & BIT(i))) {
+		pr_err("%s:%d i=%d EIREQSTA=0x%x IRQ(%d)!\n",
+				__func__, __LINE__, i, val, irq);
+		return IRQ_NONE;
+	}
+
+	pin = pctl->fpint[i].pin;
+	generic_handle_irq(irq_linear_revmap(pctl->irqdom, pin));
+
+	return IRQ_HANDLED;
+}
+
+static void m10v_gpio_irq_enable(struct irq_data *data)
+{
+	struct m10v_pinctrl *pctl = irq_data_get_irq_chip_data(data);
+	int extint = pin_to_extint(pctl, irqd_to_hwirq(data));
+	unsigned long flags;
+	u32 val;
+
+	if (extint < 0 || !pctl->exiu)
+		return;
+
+	_set_mux(pctl, irqd_to_hwirq(data), true);
+	_set_direction(pctl, irqd_to_hwirq(data), true);
+
+	spin_lock_irqsave(&pctl->irq_lock, flags);
+
+	/* Clear before enabling */
+	writel_relaxed(BIT(extint), pctl->exiu + EIREQCLR);
+
+	/* UnMask the interrupt */
+	val = readl_relaxed(pctl->exiu + EIMASK);
+	val &= ~BIT(extint);
+	writel_relaxed(val, pctl->exiu + EIMASK);
+
+	spin_unlock_irqrestore(&pctl->irq_lock, flags);
+}
+
+static void m10v_gpio_irq_disable(struct irq_data *data)
+{
+	struct m10v_pinctrl *pctl = irq_data_get_irq_chip_data(data);
+	int extint = pin_to_extint(pctl, irqd_to_hwirq(data));
+	unsigned long flags;
+	u32 val;
+
+	if (extint < 0 || !pctl->exiu)
+		return;
+
+	spin_lock_irqsave(&pctl->irq_lock, flags);
+
+	/* Mask the interrupt */
+	val = readl_relaxed(pctl->exiu + EIMASK);
+	val |= BIT(extint);
+	writel_relaxed(val, pctl->exiu + EIMASK);
+
+	spin_unlock_irqrestore(&pctl->irq_lock, flags);
+}
+
+static int m10v_gpio_irq_set_type(struct irq_data *data, unsigned int type)
+{
+	struct m10v_pinctrl *pctl = irq_data_get_irq_chip_data(data);
+	int extint = pin_to_extint(pctl, irqd_to_hwirq(data));
+	unsigned long flags;
+
+	if (extint < 0 || !pctl->exiu)
+		return -EINVAL;
+
+	spin_lock_irqsave(&pctl->irq_lock, flags);
+
+	pctl->fpint[extint].type = type;
+	update_trigger(pctl, extint);
+
+	spin_unlock_irqrestore(&pctl->irq_lock, flags);
+
+	return 0;
+}
+
+void m10v_gpio_irq_ack(struct irq_data *data)
+{
+	struct m10v_pinctrl *pctl = irq_data_get_irq_chip_data(data);
+	int extint = pin_to_extint(pctl, irqd_to_hwirq(data));
+
+	if (extint < 0 || !pctl->exiu)
+		return;
+
+	writel_relaxed(BIT(extint), pctl->exiu + EIREQCLR);
+}
+
+void m10v_gpio_irq_mask(struct irq_data *data)
+{
+	struct m10v_pinctrl *pctl = irq_data_get_irq_chip_data(data);
+	int extint = pin_to_extint(pctl, irqd_to_hwirq(data));
+	unsigned long flags;
+	u32 val;
+
+	if (extint < 0 || !pctl->exiu)
+		return;
+
+	spin_lock_irqsave(&pctl->irq_lock, flags);
+
+	val = readl_relaxed(pctl->exiu + EIMASK);
+	val |= BIT(extint);
+	writel_relaxed(val, pctl->exiu + EIMASK);
+
+	spin_unlock_irqrestore(&pctl->irq_lock, flags);
+}
+
+void m10v_gpio_irq_unmask(struct irq_data *data)
+{
+	struct m10v_pinctrl *pctl = irq_data_get_irq_chip_data(data);
+	int extint = pin_to_extint(pctl, irqd_to_hwirq(data));
+	unsigned long flags;
+	u32 val;
+
+	if (extint < 0 || !pctl->exiu)
+		return;
+
+	spin_lock_irqsave(&pctl->irq_lock, flags);
+
+	update_trigger(pctl, extint);
+
+	val = readl_relaxed(pctl->exiu + EIMASK);
+	val &= ~BIT(extint);
+	writel_relaxed(val, pctl->exiu + EIMASK);
+
+	spin_unlock_irqrestore(&pctl->irq_lock, flags);
+}
+
+static struct irq_chip m10v_gpio_irq_chip = {
+	.name = "m10v-pin-irq",
+	.irq_enable = m10v_gpio_irq_enable,
+	.irq_disable = m10v_gpio_irq_disable,
+	.irq_set_type = m10v_gpio_irq_set_type,
+	.irq_mask = m10v_gpio_irq_mask,
+	.irq_unmask = m10v_gpio_irq_unmask,
+	.irq_ack = m10v_gpio_irq_ack,
+};
+
+static const struct of_device_id m10v_pmatch[] = {
+	{ .compatible = "socionext,milbeaut-m10v-pinctrl" },
+	{},
+};
+
+static int m10v_pinctrl_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct pinctrl_dev *pctl_dev;
+	struct pin_irq_map fpint[32];
+	struct m10v_pinctrl *pctl;
+	struct pinctrl_desc *pd;
+	struct gpio_chip *gc;
+	struct resource *res;
+	int idx, i, ret, extints, tpins;
+
+	extints = of_irq_count(np);
+
+	pctl = devm_kzalloc(&pdev->dev,	sizeof(*pctl) +
+				sizeof(struct pin_irq_map) * extints,
+				GFP_KERNEL);
+	if (!pctl)
+		return -ENOMEM;
+
+	gpio_set = m10v_gpio_set;
+	bank_name = m10v_bank_name;
+	milbeaut_functions = m10v_functions;
+	tpins = M10V_TOTAL_PINS;
+
+	pd = &pctl->pd;
+	gc = &pctl->gc;
+	spin_lock_init(&pctl->lock);
+	spin_lock_init(&pctl->irq_lock);
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pinctrl");
+	pctl->base = devm_ioremap_resource(&pdev->dev, res);
+	if (!pctl->base)
+		return -EINVAL;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "exiu");
+	if (res)
+		pctl->exiu = devm_ioremap_resource(&pdev->dev, res);
+	if (res && !IS_ERR(pctl->exiu)) {
+		writel_relaxed(~0, pctl->exiu + EIMASK); /* mask all */
+		writel_relaxed(~0, pctl->exiu + EIREQCLR); /* eoi all */
+		writel_relaxed(0, pctl->exiu + EISRCSEL); /* all fpint */
+		writel_relaxed(~0, pctl->exiu + EILVL); /* rising edge type*/
+		writel_relaxed(~0, pctl->exiu + EIEDG);
+	} else {
+		dev_info(&pdev->dev, "continuing without EXIU support\n");
+		pctl->exiu = NULL;
+	}
+
+	for (i = 0; i < tpins; i++) {
+		pctl->pins[i].number = i;
+		pctl->pins[i].name = &pctl->pin_names[4 * i];
+		snprintf(&pctl->pin_names[4 * i], 4, "P%c%d",
+			bank_name[i / PINS_PER_BANK], i % PINS_PER_BANK);
+		gpio_m10v_grps[i] = &pctl->pin_names[4 * i];
+		pctl->gpins[i][0] = i;
+	}
+	/* absent or incomplete entries allow all access */
+	pd->name = dev_name(&pdev->dev);
+	pd->pins = pctl->pins;
+	pd->npins = tpins;
+	pd->pctlops = &m10v_pctrl_ops;
+	pd->pmxops = &m10v_pmx_ops;
+	pd->confops = &m10v_pconf_ops;
+	pd->owner = THIS_MODULE;
+	pctl_dev = pinctrl_register(pd, &pdev->dev, pctl);
+	if (!pctl_dev) {
+		dev_err(&pdev->dev, "couldn't register pinctrl driver\n");
+		return -EINVAL;
+	}
+
+	pctl->extints = extints;
+
+	pctl->irqdom = irq_domain_add_linear(np, tpins,
+						&irq_domain_simple_ops, pctl);
+	idx = 0;
+	for (i = 0; i < tpins && idx < pctl->extints; i++) {
+		int irq;
+
+		snprintf(fpint[idx].irqname, 8, "pin-%d", i);
+		irq = platform_get_irq_byname(pdev, fpint[idx].irqname);
+		if (irq < 0)
+			continue;
+		fpint[idx].irq = irq;
+		fpint[idx].pin = i;
+		idx++;
+	}
+
+	for (idx = 0, i = 0; i < pctl->extints; i++) {
+		int j = 0, irq = platform_get_irq(pdev, i);
+
+		while (fpint[j].irq != irq)
+			j++;
+
+		snprintf(pctl->fpint[idx].irqname, 8, "pin-%d", fpint[j].pin);
+		pctl->fpint[idx].irq = fpint[j].irq;
+		pctl->fpint[idx].pin = fpint[j].pin;
+		idx++;
+	}
+
+	for (i = 0; i < pctl->extints; i++) {
+		int irq, err = devm_request_irq(&pdev->dev, pctl->fpint[i].irq,
+					m10v_gpio_irq_handler, IRQF_SHARED,
+					pctl->fpint[i].irqname, pctl);
+		if (err)
+			continue;
+
+		irq = irq_create_mapping(pctl->irqdom, pctl->fpint[i].pin);
+		irq_set_lockdep_class(irq, &gpio_lock_class,
+			&gpio_request_class);
+		irq_set_chip_and_handler(irq, &m10v_gpio_irq_chip,
+					 handle_level_irq);
+		irq_set_chip_data(irq, pctl);
+	}
+
+	gc->base = -1;
+	gc->ngpio = tpins;
+	gc->label = dev_name(&pdev->dev);
+	gc->owner = THIS_MODULE;
+	gc->of_node = np;
+	gc->direction_input = m10v_gpio_direction_input;
+	gc->direction_output = m10v_gpio_direction_output;
+	gc->get = m10v_gpio_get;
+	gc->set = gpio_set;
+	gc->to_irq = m10v_gpio_to_irq;
+	gc->request = gpiochip_generic_request;
+	gc->free = gpiochip_generic_free;
+	ret = gpiochip_add(gc);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed register gpiochip\n");
+		return ret;
+	}
+
+	ret = gpiochip_add_pin_range(gc, dev_name(&pdev->dev),
+					0, 0, tpins);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to add pin range\n");
+		gpiochip_remove(gc);
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct platform_driver m10v_pinctrl_driver = {
+	.probe	= m10v_pinctrl_probe,
+	.driver	= {
+		.name		= "m10v-pinctrl",
+		.of_match_table	= m10v_pmatch,
+	},
+};
+builtin_platform_driver(m10v_pinctrl_driver);
-- 
1.9.1

