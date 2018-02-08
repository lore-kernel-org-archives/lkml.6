Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751544AbeBHICV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 03:02:21 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44514 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbeBHICP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 03:02:15 -0500
X-Google-Smtp-Source: AH8x224HlqYrW0MBydxTvgL9l2r7pHKCSy0l1uYkVCYQugTYM6MFghehZt8JPSNHKdz3drclZ2kY1A==
From: Baolin Wang <baolin.wang@linaro.org>
To: linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, broonie@kernel.org, baolin.wang@linaro.org,
        andy.shevchenko@gmail.com
Subject: [PATCH 2/2] gpio: Add Spreadtrum EIC driver support
Date: Thu,  8 Feb 2018 16:01:43 +0800
Message-Id: <b8df099671d55de8a2f754d7598a62a9176413dd.1518076643.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <e89b91042abbbcf04cb39a3350af000cc411eee1.1518076643.git.baolin.wang@linaro.org>
References: <e89b91042abbbcf04cb39a3350af000cc411eee1.1518076643.git.baolin.wang@linaro.org>
In-Reply-To: <e89b91042abbbcf04cb39a3350af000cc411eee1.1518076643.git.baolin.wang@linaro.org>
References: <e89b91042abbbcf04cb39a3350af000cc411eee1.1518076643.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Spreadtrum platform has 2 EIC controllers, one is in digital chip and
another one is in PMIC. The digital-chip EIC controller has 4 sub-modules:
debounce EIC, latch EIC, async EIC and sync EIC, each sub-module can has
multiple groups and each group contains 8 EICs. The PMIC EIC controller has
only one debounce EIC sub-module.

Each EIC can only be used as input mode, and has the capability to trigger
interrupts when detecting input signals.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/gpio/Kconfig         |    7 +
 drivers/gpio/Makefile        |    1 +
 drivers/gpio/gpio-eic-sprd.c |  782 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 790 insertions(+)
 create mode 100644 drivers/gpio/gpio-eic-sprd.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 184b581..2414391 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -159,6 +159,13 @@ config GPIO_DWAPB
 	  Say Y or M here to build support for the Synopsys DesignWare APB
 	  GPIO block.
 
+config GPIO_EIC_SPRD
+	tristate "Spreadtrum EIC support"
+	depends on ARCH_SPRD || COMPILE_TEST
+	select GPIOLIB_IRQCHIP
+	help
+	  Say yes here to support Spreadtrum EIC device.
+
 config GPIO_EM
 	tristate "Emma Mobile GPIO"
 	depends on (ARCH_EMEV2 || COMPILE_TEST) && OF_GPIO
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 2e3d320..66eaa9e 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_GPIO_DA9055)	+= gpio-da9055.o
 obj-$(CONFIG_GPIO_DAVINCI)	+= gpio-davinci.o
 obj-$(CONFIG_GPIO_DLN2)		+= gpio-dln2.o
 obj-$(CONFIG_GPIO_DWAPB)	+= gpio-dwapb.o
+obj-$(CONFIG_GPIO_EIC_SPRD)	+= gpio-eic-sprd.o
 obj-$(CONFIG_GPIO_EM)		+= gpio-em.o
 obj-$(CONFIG_GPIO_EP93XX)	+= gpio-ep93xx.o
 obj-$(CONFIG_GPIO_ETRAXFS)	+= gpio-etraxfs.o
diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
new file mode 100644
index 0000000..ccc12a8
--- /dev/null
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -0,0 +1,782 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Spreadtrum Communications Inc.
+ * Copyright (c) 2018 Linaro Ltd.
+ */
+
+#include <linux/bitops.h>
+#include <linux/gpio/driver.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/spinlock.h>
+
+/* EIC registers definition */
+#define SPRD_EIC_DBNC_DATA		0x0
+#define SPRD_EIC_DBNC_DMSK		0x4
+#define SPRD_EIC_DBNC_IEV		0x14
+#define SPRD_EIC_DBNC_IE		0x18
+#define SPRD_EIC_DBNC_RIS		0x1c
+#define SPRD_EIC_DBNC_MIS		0x20
+#define SPRD_EIC_DBNC_IC		0x24
+#define SPRD_EIC_DBNC_TRIG		0x28
+#define SPRD_EIC_DBNC_CTRL0		0x40
+#define SPRD_EIC_DBNC_CTRL1		0x44
+#define SPRD_EIC_DBNC_CTRL2		0x48
+#define SPRD_EIC_DBNC_CTRL3		0x4c
+#define SPRD_EIC_DBNC_CTRL4		0x50
+#define SPRD_EIC_DBNC_CTRL5		0x54
+#define SPRD_EIC_DBNC_CTRL6		0x58
+#define SPRD_EIC_DBNC_CTRL7		0x5c
+
+#define SPRD_EIC_LATCH_INTEN		0x0
+#define SPRD_EIC_LATCH_INTRAW		0x4
+#define SPRD_EIC_LATCH_INTMSK		0x8
+#define SPRD_EIC_LATCH_INTCLR		0xc
+#define SPRD_EIC_LATCH_INTPOL		0x10
+#define SPRD_EIC_LATCH_INTMODE		0x14
+
+#define SPRD_EIC_ASYNC_INTIE		0x0
+#define SPRD_EIC_ASYNC_INTRAW		0x4
+#define SPRD_EIC_ASYNC_INTMSK		0x8
+#define SPRD_EIC_ASYNC_INTCLR		0xc
+#define SPRD_EIC_ASYNC_INTMODE		0x10
+#define SPRD_EIC_ASYNC_INTBOTH		0x14
+#define SPRD_EIC_ASYNC_INTPOL		0x18
+#define SPRD_EIC_ASYNC_DATA		0x1c
+
+#define SPRD_EIC_SYNC_INTIE		0x0
+#define SPRD_EIC_SYNC_INTRAW		0x4
+#define SPRD_EIC_SYNC_INTMSK		0x8
+#define SPRD_EIC_SYNC_INTCLR		0xc
+#define SPRD_EIC_SYNC_INTMODE		0x10
+#define SPRD_EIC_SYNC_INTBOTH		0x14
+#define SPRD_EIC_SYNC_INTPOL		0x18
+#define SPRD_EIC_SYNC_DATA		0x1c
+
+/*
+ * The digital-chip EIC controller can support maximum 3 groups, and each group
+ * contains 8 EICs.
+ */
+#define SPRD_EIC_MAX_GROUP		3
+#define SPRD_EIC_PER_GROUP_NR		8
+#define SPRD_EIC_DATA_MASK		GENMASK(7, 0)
+#define SPRD_EIC_BIT(x)			((x) & (SPRD_EIC_PER_GROUP_NR - 1))
+
+/*
+ * The PMIC EIC controller only has one group, and each group now can contain
+ * 16 EICs.
+ */
+#define SPRD_PMIC_EIC_PER_GROUP_NR	16
+#define SPRD_PMIC_EIC_DATA_MASK		GENMASK(15, 0)
+#define SPRD_PMIC_EIC_BIT(x)		((x) & (SPRD_PMIC_EIC_PER_GROUP_NR - 1))
+#define SPRD_PMIC_EIC_CACHE_NR_REGS	(SPRD_EIC_DBNC_TRIG + 0x4)
+
+#define SPRD_EIC_DBNC_MASK		GENMASK(11, 0)
+
+/*
+ * The Spreadtrum EIC (external interrupt controller) can only be used
+ * as input mode to generate interrupts if detecting input signals.
+ *
+ * The Spreadtrum platform has two EIC controllers, one EIC controller
+ * is in digital-chip, another one is in PMIC. There are some differences
+ * between this two EIC controllers. The digital-chip EIC controller
+ * includes 4 sub-modules: debounce EIC, latch EIC, async EIC and sync EIC,
+ * but the PMIC EIC controller only has one debounce EIC sub-module.
+ *
+ * The debounce EIC is used to capture input signal's stable status
+ * (ms grade) and a single-trigger mechanism is introduced into this
+ * sub-module to enhance the input event detection reliability. The
+ * debounce range is from 1ms to 4s with the step of 1ms.
+ *
+ * The latch EIC is used to latch some special input signal and send
+ * interrupts to MCU core.
+ *
+ * The async EIC uses 32k clock to capture short signal (us grade)
+ * to generate interrupt to MCU by level or edge trigger.
+ *
+ * The sync EIC is similar with GPIO's input function.
+ */
+enum sprd_eic_type {
+	SPRD_EIC_DEBOUNCE,
+	SPRD_EIC_LATCH,
+	SPRD_EIC_ASYNC,
+	SPRD_EIC_SYNC,
+	SPRD_EIC_PMIC_DEBOUNCE,
+	SPRD_EIC_MAX,
+};
+
+struct sprd_eic {
+	struct gpio_chip chip;
+	struct irq_chip intc;
+	void __iomem *base[SPRD_EIC_MAX_GROUP];
+	struct regmap *map;
+	u32 map_base;
+	u8 reg[SPRD_PMIC_EIC_CACHE_NR_REGS];
+	enum sprd_eic_type type;
+	spinlock_t lock;
+	struct mutex buslock;
+	int irq;
+};
+
+struct sprd_eic_data {
+	enum sprd_eic_type type;
+	u32 num_eics;
+};
+
+static const char *sprd_eic_label_name[SPRD_EIC_MAX] = {
+	"eic-debounce", "eic-latch", "eic-async",
+	"eic-sync", "eic-pmic-debounce",
+};
+
+static const struct sprd_eic_data sc9860_eic_dbnc_data = {
+	.type = SPRD_EIC_DEBOUNCE,
+	.num_eics = 8,
+};
+
+static const struct sprd_eic_data sc9860_eic_latch_data = {
+	.type = SPRD_EIC_LATCH,
+	.num_eics = 8,
+};
+
+static const struct sprd_eic_data sc9860_eic_async_data = {
+	.type = SPRD_EIC_ASYNC,
+	.num_eics = 8,
+};
+
+static const struct sprd_eic_data sc9860_eic_sync_data = {
+	.type = SPRD_EIC_SYNC,
+	.num_eics = 8,
+};
+
+static const struct sprd_eic_data pmic_eic_dbnc_data = {
+	.type = SPRD_EIC_PMIC_DEBOUNCE,
+	.num_eics = 16,
+};
+
+static inline void __iomem *sprd_eic_group_base(struct sprd_eic *sprd_eic,
+						unsigned int group)
+{
+	if (group >= SPRD_EIC_MAX_GROUP)
+		return NULL;
+
+	return sprd_eic->base[group];
+}
+
+static void sprd_eic_update(struct gpio_chip *chip, unsigned int offset,
+			    unsigned int reg, unsigned int val)
+{
+	struct sprd_eic *sprd_eic = gpiochip_get_data(chip);
+	u32 shift;
+
+	if (sprd_eic->type == SPRD_EIC_PMIC_DEBOUNCE) {
+		shift = SPRD_PMIC_EIC_BIT(offset);
+
+		regmap_update_bits(sprd_eic->map, sprd_eic->map_base + reg,
+				   BIT(shift), val << shift);
+	} else {
+		void __iomem *base = sprd_eic_group_base(sprd_eic,
+						offset / SPRD_EIC_PER_GROUP_NR);
+		unsigned long flags;
+		u32 orig, tmp;
+
+		shift = SPRD_EIC_BIT(offset);
+
+		spin_lock_irqsave(&sprd_eic->lock, flags);
+		orig = readl_relaxed(base + reg);
+
+		tmp = (orig & ~BIT(shift)) | (val << shift);
+		writel_relaxed(tmp, base + reg);
+		spin_unlock_irqrestore(&sprd_eic->lock, flags);
+	}
+}
+
+static int sprd_eic_read(struct gpio_chip *chip, unsigned int offset,
+			 unsigned int reg)
+{
+	struct sprd_eic *sprd_eic = gpiochip_get_data(chip);
+	u32 shift;
+	u32 value;
+
+	if (sprd_eic->type == SPRD_EIC_PMIC_DEBOUNCE) {
+		int ret;
+
+		shift = SPRD_PMIC_EIC_BIT(offset);
+		ret = regmap_read(sprd_eic->map, sprd_eic->map_base + reg,
+				  &value);
+		if (ret)
+			return ret;
+
+		value &= SPRD_PMIC_EIC_DATA_MASK;
+	} else {
+		void __iomem *base = sprd_eic_group_base(sprd_eic,
+						offset / SPRD_EIC_PER_GROUP_NR);
+
+		shift = SPRD_EIC_BIT(offset);
+		value = readl_relaxed(base + reg) & SPRD_EIC_DATA_MASK;
+	}
+
+	return !!(value & BIT(shift));
+}
+
+static int sprd_eic_request(struct gpio_chip *chip, unsigned int offset)
+{
+	sprd_eic_update(chip, offset, SPRD_EIC_DBNC_DMSK, 1);
+	return 0;
+}
+
+static void sprd_eic_free(struct gpio_chip *chip, unsigned int offset)
+{
+	sprd_eic_update(chip, offset, SPRD_EIC_DBNC_DMSK, 0);
+}
+
+static int sprd_eic_get(struct gpio_chip *chip, unsigned int offset)
+{
+	return sprd_eic_read(chip, offset, SPRD_EIC_DBNC_DATA);
+}
+
+static int sprd_eic_direction_input(struct gpio_chip *chip, unsigned int offset)
+{
+	/* EICs are always input, nothing need to do here. */
+	return 0;
+}
+
+static void sprd_eic_set(struct gpio_chip *chip, unsigned int offset, int value)
+{
+	/* EICs are always input, nothing need to do here. */
+}
+
+static int sprd_eic_set_debounce(struct gpio_chip *chip, unsigned int offset,
+				 unsigned int debounce)
+{
+	struct sprd_eic *sprd_eic = gpiochip_get_data(chip);
+	u32 shift, reg, value;
+
+	if (sprd_eic->type == SPRD_EIC_PMIC_DEBOUNCE) {
+		int ret;
+
+		shift = SPRD_PMIC_EIC_BIT(offset);
+		reg = SPRD_EIC_DBNC_CTRL0 + shift * 0x4;
+		ret = regmap_read(sprd_eic->map, sprd_eic->map_base + reg,
+				  &value);
+		if (ret)
+			return ret;
+
+		value &= ~SPRD_EIC_DBNC_MASK;
+		value |= debounce / 1000;
+		ret = regmap_write(sprd_eic->map, sprd_eic->map_base + reg,
+				   value);
+		if (ret)
+			return ret;
+	} else {
+		void __iomem *base = sprd_eic_group_base(sprd_eic,
+						offset / SPRD_EIC_PER_GROUP_NR);
+
+		shift = SPRD_EIC_BIT(offset);
+		reg = SPRD_EIC_DBNC_CTRL0 + shift * 0x4;
+		value = readl_relaxed(base + reg) & ~SPRD_EIC_DBNC_MASK;
+
+		value |= debounce / 1000;
+		writel_relaxed(value, base + reg);
+	}
+
+	return 0;
+}
+
+static int sprd_eic_set_config(struct gpio_chip *chip, unsigned int offset,
+			       unsigned long config)
+{
+	unsigned long param = pinconf_to_config_param(config);
+	u32 arg = pinconf_to_config_argument(config);
+
+	if (param == PIN_CONFIG_INPUT_DEBOUNCE)
+		return sprd_eic_set_debounce(chip, offset, arg);
+
+	return -ENOTSUPP;
+}
+
+static void sprd_eic_irq_mask(struct irq_data *data)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
+	struct sprd_eic *sprd_eic = gpiochip_get_data(chip);
+	u32 offset = irqd_to_hwirq(data);
+
+	switch (sprd_eic->type) {
+	case SPRD_EIC_PMIC_DEBOUNCE:
+		sprd_eic->reg[SPRD_EIC_DBNC_IE] = 0;
+		sprd_eic->reg[SPRD_EIC_DBNC_TRIG] = 0;
+		break;
+	case SPRD_EIC_DEBOUNCE:
+		sprd_eic_update(chip, offset, SPRD_EIC_DBNC_IE, 0);
+		sprd_eic_update(chip, offset, SPRD_EIC_DBNC_TRIG, 0);
+		break;
+	case SPRD_EIC_LATCH:
+		sprd_eic_update(chip, offset, SPRD_EIC_LATCH_INTEN, 0);
+		break;
+	case SPRD_EIC_ASYNC:
+		sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTIE, 0);
+		break;
+	case SPRD_EIC_SYNC:
+		sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTIE, 0);
+		break;
+	default:
+		dev_err(chip->parent, "Unsupported EIC type.\n");
+	}
+}
+
+static void sprd_eic_irq_unmask(struct irq_data *data)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
+	struct sprd_eic *sprd_eic = gpiochip_get_data(chip);
+	u32 offset = irqd_to_hwirq(data);
+
+	switch (sprd_eic->type) {
+	case SPRD_EIC_PMIC_DEBOUNCE:
+		sprd_eic->reg[SPRD_EIC_DBNC_IE] = 1;
+		sprd_eic->reg[SPRD_EIC_DBNC_TRIG] = 1;
+		break;
+	case SPRD_EIC_DEBOUNCE:
+		sprd_eic_update(chip, offset, SPRD_EIC_DBNC_IE, 1);
+		sprd_eic_update(chip, offset, SPRD_EIC_DBNC_TRIG, 1);
+		break;
+	case SPRD_EIC_LATCH:
+		sprd_eic_update(chip, offset, SPRD_EIC_LATCH_INTEN, 1);
+		break;
+	case SPRD_EIC_ASYNC:
+		sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTIE, 1);
+		break;
+	case SPRD_EIC_SYNC:
+		sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTIE, 1);
+		break;
+	default:
+		dev_err(chip->parent, "Unsupported EIC type.\n");
+	}
+}
+
+static void sprd_eic_irq_ack(struct irq_data *data)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
+	struct sprd_eic *sprd_eic = gpiochip_get_data(chip);
+	u32 offset = irqd_to_hwirq(data);
+
+	switch (sprd_eic->type) {
+	case SPRD_EIC_PMIC_DEBOUNCE:
+		break;
+	case SPRD_EIC_DEBOUNCE:
+		sprd_eic_update(chip, offset, SPRD_EIC_DBNC_IC, 1);
+		break;
+	case SPRD_EIC_LATCH:
+		sprd_eic_update(chip, offset, SPRD_EIC_LATCH_INTCLR, 1);
+		break;
+	case SPRD_EIC_ASYNC:
+		sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTCLR, 1);
+		break;
+	case SPRD_EIC_SYNC:
+		sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTCLR, 1);
+		break;
+	default:
+		dev_err(chip->parent, "Unsupported EIC type.\n");
+	}
+}
+
+static int sprd_eic_irq_set_type(struct irq_data *data,
+				 unsigned int flow_type)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
+	struct sprd_eic *sprd_eic = gpiochip_get_data(chip);
+	u32 offset = irqd_to_hwirq(data);
+
+	switch (sprd_eic->type) {
+	case SPRD_EIC_PMIC_DEBOUNCE:
+		switch (flow_type) {
+		case IRQ_TYPE_LEVEL_HIGH:
+			sprd_eic->reg[SPRD_EIC_DBNC_IEV] = 1;
+			break;
+		case IRQ_TYPE_LEVEL_LOW:
+			sprd_eic->reg[SPRD_EIC_DBNC_IEV] = 0;
+			break;
+		default:
+			return -ENOTSUPP;
+		}
+
+		irq_set_handler_locked(data, handle_level_irq);
+		break;
+	case SPRD_EIC_DEBOUNCE:
+		switch (flow_type) {
+		case IRQ_TYPE_LEVEL_HIGH:
+			sprd_eic_update(chip, offset, SPRD_EIC_DBNC_IEV, 1);
+			break;
+		case IRQ_TYPE_LEVEL_LOW:
+			sprd_eic_update(chip, offset, SPRD_EIC_DBNC_IEV, 0);
+			break;
+		default:
+			return -ENOTSUPP;
+		}
+
+		irq_set_handler_locked(data, handle_level_irq);
+		break;
+	case SPRD_EIC_LATCH:
+		switch (flow_type) {
+		case IRQ_TYPE_LEVEL_HIGH:
+			sprd_eic_update(chip, offset, SPRD_EIC_LATCH_INTPOL, 0);
+			break;
+		case IRQ_TYPE_LEVEL_LOW:
+			sprd_eic_update(chip, offset, SPRD_EIC_LATCH_INTPOL, 1);
+			break;
+		default:
+			return -ENOTSUPP;
+		}
+
+		irq_set_handler_locked(data, handle_level_irq);
+		break;
+	case SPRD_EIC_ASYNC:
+		switch (flow_type) {
+		case IRQ_TYPE_EDGE_RISING:
+			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 0);
+			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTMODE, 0);
+			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTPOL, 1);
+			irq_set_handler_locked(data, handle_edge_irq);
+			break;
+		case IRQ_TYPE_EDGE_FALLING:
+			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 0);
+			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTMODE, 0);
+			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTPOL, 0);
+			irq_set_handler_locked(data, handle_edge_irq);
+			break;
+		case IRQ_TYPE_EDGE_BOTH:
+			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 1);
+			irq_set_handler_locked(data, handle_edge_irq);
+			break;
+		case IRQ_TYPE_LEVEL_HIGH:
+			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 0);
+			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTMODE, 1);
+			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTPOL, 1);
+			irq_set_handler_locked(data, handle_level_irq);
+			break;
+		case IRQ_TYPE_LEVEL_LOW:
+			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 0);
+			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTMODE, 1);
+			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTPOL, 0);
+			irq_set_handler_locked(data, handle_level_irq);
+			break;
+		default:
+			return -ENOTSUPP;
+		}
+		break;
+	case SPRD_EIC_SYNC:
+		switch (flow_type) {
+		case IRQ_TYPE_EDGE_RISING:
+			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBOTH, 0);
+			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMODE, 0);
+			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTPOL, 1);
+			irq_set_handler_locked(data, handle_edge_irq);
+			break;
+		case IRQ_TYPE_EDGE_FALLING:
+			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBOTH, 0);
+			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMODE, 0);
+			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTPOL, 0);
+			irq_set_handler_locked(data, handle_edge_irq);
+			break;
+		case IRQ_TYPE_EDGE_BOTH:
+			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBOTH, 1);
+			irq_set_handler_locked(data, handle_edge_irq);
+			break;
+		case IRQ_TYPE_LEVEL_HIGH:
+			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBOTH, 0);
+			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMODE, 1);
+			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTPOL, 1);
+			irq_set_handler_locked(data, handle_level_irq);
+			break;
+		case IRQ_TYPE_LEVEL_LOW:
+			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBOTH, 0);
+			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMODE, 1);
+			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTPOL, 0);
+			irq_set_handler_locked(data, handle_level_irq);
+			break;
+		default:
+			return -ENOTSUPP;
+		}
+	default:
+		dev_err(chip->parent, "Unsupported EIC type.\n");
+		return -ENOTSUPP;
+	}
+
+	return 0;
+}
+
+static void sprd_eic_bus_lock(struct irq_data *data)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
+	struct sprd_eic *sprd_eic = gpiochip_get_data(chip);
+
+	mutex_lock(&sprd_eic->buslock);
+}
+
+static void sprd_eic_bus_sync_unlock(struct irq_data *data)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
+	struct sprd_eic *sprd_eic = gpiochip_get_data(chip);
+	u32 offset = irqd_to_hwirq(data);
+
+	/* Set irq type */
+	sprd_eic_update(chip, offset, SPRD_EIC_DBNC_IEV,
+			sprd_eic->reg[SPRD_EIC_DBNC_IEV]);
+	/* Set irq unmask */
+	sprd_eic_update(chip, offset, SPRD_EIC_DBNC_IE,
+			sprd_eic->reg[SPRD_EIC_DBNC_IE]);
+	/* Generate trigger start pulse for debounce EIC */
+	sprd_eic_update(chip, offset, SPRD_EIC_DBNC_TRIG,
+			sprd_eic->reg[SPRD_EIC_DBNC_TRIG]);
+
+	mutex_unlock(&sprd_eic->buslock);
+}
+
+static int sprd_eic_match_chip_by_type(struct gpio_chip *chip, void *data)
+{
+	enum sprd_eic_type type = *(enum sprd_eic_type *)data;
+
+	return !strcmp(chip->label, sprd_eic_label_name[type]);
+}
+
+static void sprd_eic_handle_one_type(struct gpio_chip *chip)
+{
+	struct sprd_eic *sprd_eic = gpiochip_get_data(chip);
+	u32 group, n, girq;
+
+	for (group = 0; group * SPRD_EIC_PER_GROUP_NR < chip->ngpio; group++) {
+		void __iomem *base = sprd_eic_group_base(sprd_eic, group);
+		unsigned long reg;
+
+		switch (sprd_eic->type) {
+		case SPRD_EIC_DEBOUNCE:
+			reg = readl_relaxed(base + SPRD_EIC_DBNC_MIS) &
+				SPRD_EIC_DATA_MASK;
+			break;
+		case SPRD_EIC_LATCH:
+			reg = readl_relaxed(base + SPRD_EIC_LATCH_INTMSK) &
+				SPRD_EIC_DATA_MASK;
+			break;
+		case SPRD_EIC_ASYNC:
+			reg = readl_relaxed(base + SPRD_EIC_ASYNC_INTMSK) &
+				SPRD_EIC_DATA_MASK;
+			break;
+		case SPRD_EIC_SYNC:
+			reg = readl_relaxed(base + SPRD_EIC_SYNC_INTMSK) &
+				SPRD_EIC_DATA_MASK;
+			break;
+		default:
+			dev_err(chip->parent, "Unsupported EIC type.\n");
+			return;
+		}
+
+		for_each_set_bit(n, &reg, SPRD_EIC_PER_GROUP_NR) {
+			girq = irq_find_mapping(chip->irq.domain,
+					group * SPRD_EIC_PER_GROUP_NR + n);
+
+			generic_handle_irq(girq);
+		}
+	}
+}
+
+static void sprd_eic_irq_handler(struct irq_desc *desc)
+{
+	struct irq_chip *ic = irq_desc_get_chip(desc);
+	struct gpio_chip *chip;
+	enum sprd_eic_type type;
+
+	chained_irq_enter(ic, desc);
+
+	/*
+	 * Since the digital-chip EIC 4 sub-modules (debounce, latch, async and
+	 * sync) share one same interrupt line, we should iterate each EIC
+	 * module to check if there are EIC interrupts were triggered.
+	 */
+	for (type = SPRD_EIC_DEBOUNCE; type < SPRD_EIC_PMIC_DEBOUNCE; type++) {
+		chip = gpiochip_find(&type, sprd_eic_match_chip_by_type);
+		if (!chip)
+			continue;
+
+		sprd_eic_handle_one_type(chip);
+	}
+
+	chained_irq_exit(ic, desc);
+}
+
+static irqreturn_t sprd_pmic_eic_irq_handler(int irq, void *data)
+{
+	struct sprd_eic *sprd_eic = data;
+	struct gpio_chip *chip = &sprd_eic->chip;
+	u32 n, girq, val;
+	int ret;
+
+	ret = regmap_read(sprd_eic->map, sprd_eic->map_base + SPRD_EIC_DBNC_MIS,
+			  &val);
+	if (ret)
+		return IRQ_RETVAL(ret);
+
+	val &= SPRD_PMIC_EIC_DATA_MASK;
+
+	for (n = 0; n < chip->ngpio; n++) {
+		if (!(BIT(n) & val))
+			continue;
+
+		sprd_eic_update(chip, n, SPRD_EIC_DBNC_IC, 1);
+
+		girq = irq_find_mapping(chip->irq.domain, n);
+		handle_nested_irq(girq);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int sprd_eic_probe(struct platform_device *pdev)
+{
+	const struct sprd_eic_data *pdata;
+	struct gpio_irq_chip *irq;
+	struct sprd_eic *sprd_eic;
+	struct resource *res;
+	int ret, i;
+
+	pdata = of_device_get_match_data(&pdev->dev);
+	if (!pdata) {
+		dev_err(&pdev->dev, "No matching driver data found.\n");
+		return -EINVAL;
+	}
+
+	sprd_eic = devm_kzalloc(&pdev->dev, sizeof(*sprd_eic), GFP_KERNEL);
+	if (!sprd_eic)
+		return -ENOMEM;
+
+	mutex_init(&sprd_eic->buslock);
+	spin_lock_init(&sprd_eic->lock);
+	sprd_eic->type = pdata->type;
+
+	sprd_eic->irq = platform_get_irq(pdev, 0);
+	if (sprd_eic->irq < 0) {
+		dev_err(&pdev->dev, "Failed to get EIC interrupt.\n");
+		return sprd_eic->irq;
+	}
+
+	if (sprd_eic->type == SPRD_EIC_PMIC_DEBOUNCE) {
+		sprd_eic->map = dev_get_regmap(pdev->dev.parent, NULL);
+		if (!sprd_eic->map)
+			return -ENODEV;
+
+		ret = of_property_read_u32(pdev->dev.of_node, "reg",
+					   &sprd_eic->map_base);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to get EIC base address\n");
+			return ret;
+		}
+
+		ret = devm_request_threaded_irq(&pdev->dev, sprd_eic->irq, NULL,
+						sprd_pmic_eic_irq_handler,
+						IRQF_TRIGGER_LOW |
+						IRQF_ONESHOT | IRQF_NO_SUSPEND,
+						dev_name(&pdev->dev), sprd_eic);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to request EIC IRQ.\n");
+			return ret;
+		}
+	} else {
+		for (i = 0; i < SPRD_EIC_MAX_GROUP; i++) {
+			/*
+			 * We can have maximum 3 groups EICs, and each EIC has
+			 * its own base address. But some platform maybe only
+			 * have one group EIC, thus base[1] and base[2] can be
+			 * optional.
+			 */
+			res = platform_get_resource(pdev, IORESOURCE_MEM, i);
+			if (!res)
+				continue;
+
+			sprd_eic->base[i] = devm_ioremap_resource(&pdev->dev,
+								  res);
+			if (IS_ERR(sprd_eic->base[i]))
+				return PTR_ERR(sprd_eic->base[i]);
+		}
+	}
+
+	sprd_eic->chip.label = sprd_eic_label_name[sprd_eic->type];
+	sprd_eic->chip.ngpio = pdata->num_eics;
+	sprd_eic->chip.base = -1;
+	sprd_eic->chip.parent = &pdev->dev;
+	sprd_eic->chip.of_node = pdev->dev.of_node;
+	sprd_eic->chip.direction_input = sprd_eic_direction_input;
+	switch (sprd_eic->type) {
+	case SPRD_EIC_PMIC_DEBOUNCE:
+		/* fall-through */
+	case SPRD_EIC_DEBOUNCE:
+		sprd_eic->chip.request = sprd_eic_request;
+		sprd_eic->chip.free = sprd_eic_free;
+		sprd_eic->chip.set_config = sprd_eic_set_config;
+		sprd_eic->chip.set = sprd_eic_set;
+		/* fall-through */
+	case SPRD_EIC_ASYNC:
+		/* fall-through */
+	case SPRD_EIC_SYNC:
+		sprd_eic->chip.get = sprd_eic_get;
+		break;
+	case SPRD_EIC_LATCH:
+		/* fall-through */
+	default:
+		break;
+	}
+
+	sprd_eic->intc.name = dev_name(&pdev->dev);
+	sprd_eic->intc.irq_ack = sprd_eic_irq_ack;
+	sprd_eic->intc.irq_mask = sprd_eic_irq_mask;
+	sprd_eic->intc.irq_unmask = sprd_eic_irq_unmask;
+	sprd_eic->intc.irq_set_type = sprd_eic_irq_set_type;
+	sprd_eic->intc.flags = IRQCHIP_SKIP_SET_WAKE;
+
+	irq = &sprd_eic->chip.irq;
+	irq->chip = &sprd_eic->intc;
+	if (sprd_eic->type == SPRD_EIC_PMIC_DEBOUNCE) {
+		sprd_eic->intc.irq_bus_lock = sprd_eic_bus_lock;
+		sprd_eic->intc.irq_bus_sync_unlock = sprd_eic_bus_sync_unlock;
+		irq->threaded = true;
+	} else {
+		irq->handler = handle_simple_irq;
+		irq->default_type = IRQ_TYPE_NONE;
+		irq->parent_handler = sprd_eic_irq_handler;
+		irq->parent_handler_data = sprd_eic;
+		irq->num_parents = 1;
+		irq->parents = &sprd_eic->irq;
+	}
+
+	ret = devm_gpiochip_add_data(&pdev->dev, &sprd_eic->chip, sprd_eic);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Could not register gpiochip %d.\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, sprd_eic);
+	return 0;
+}
+
+static const struct of_device_id sprd_eic_of_match[] = {
+	{ .compatible = "sprd,sc9860-eic-debounce", .data = &sc9860_eic_dbnc_data },
+	{ .compatible = "sprd,sc9860-eic-latch", .data = &sc9860_eic_latch_data },
+	{ .compatible = "sprd,sc9860-eic-async", .data = &sc9860_eic_async_data },
+	{ .compatible = "sprd,sc9860-eic-sync", .data = &sc9860_eic_sync_data },
+	{ .compatible = "sprd,sc27xx-eic-debounce", .data = &pmic_eic_dbnc_data },
+	{ /* end of list */ },
+};
+MODULE_DEVICE_TABLE(of, sprd_eic_of_match);
+
+static struct platform_driver sprd_eic_driver = {
+	.probe = sprd_eic_probe,
+	.driver = {
+		.name = "sprd-eic",
+		.of_match_table	= sprd_eic_of_match,
+	},
+};
+
+module_platform_driver(sprd_eic_driver);
+
+MODULE_DESCRIPTION("Spreadtrum EIC driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5
