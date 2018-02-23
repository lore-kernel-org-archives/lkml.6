Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbeBWEpN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 23:45:13 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43665 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeBWEpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 23:45:09 -0500
X-Google-Smtp-Source: AH8x226n+NpHPQtbCvnZRM4nmoXxO4uKBGKufXKq5S+weKfOQfL9LkUnxV4qTmiOJ2dfy9cwM8neFg==
From: Baolin Wang <baolin.wang@linaro.org>
To: linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, broonie@kernel.org, baolin.wang@linaro.org,
        andy.shevchenko@gmail.com
Subject: [PATCH v4 2/2] gpio: Add GPIO driver for Spreadtrum SC9860 platform
Date: Fri, 23 Feb 2018 12:44:39 +0800
Message-Id: <2009936f10a349fc6a24796c60e7fea6551b8f0d.1519360872.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <c2db9b3b5c611cadfbe5ea97327be7ee5981fa54.1519360872.git.baolin.wang@linaro.org>
References: <c2db9b3b5c611cadfbe5ea97327be7ee5981fa54.1519360872.git.baolin.wang@linaro.org>
In-Reply-To: <c2db9b3b5c611cadfbe5ea97327be7ee5981fa54.1519360872.git.baolin.wang@linaro.org>
References: <c2db9b3b5c611cadfbe5ea97327be7ee5981fa54.1519360872.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Spreadtrum SC9860 platform GPIO controller contains 16 groups and
each group contains 16 GPIOs. Each GPIO can set input/output and has
the interrupt capability.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
Changes since v3:
 - Add OF_GPIO dependency.
 - Rename all 'group' to 'bank'.
 - Simplify the sprd_gpio_update() and sprd_gpio_read().

Changes since v2:
 - Use devm_ioremap_resource() instead of devm_ioremap_nocache().

Changes since v1:
 - Change 'bool' to 'tristate'.
 - Add reviewed tag from Andy.
---
 drivers/gpio/Kconfig     |    8 ++
 drivers/gpio/Makefile    |    1 +
 drivers/gpio/gpio-sprd.c |  290 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 299 insertions(+)
 create mode 100644 drivers/gpio/gpio-sprd.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 8dbb228..a64b29d 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -398,6 +398,14 @@ config GPIO_SPEAR_SPICS
 	help
 	  Say yes here to support ST SPEAr SPI Chip Select as GPIO device
 
+config GPIO_SPRD
+	tristate "Spreadtrum GPIO support"
+	depends on ARCH_SPRD || COMPILE_TEST
+	depends on OF_GPIO
+	select GPIOLIB_IRQCHIP
+	help
+	  Say yes here to support Spreadtrum GPIO device.
+
 config GPIO_STA2X11
 	bool "STA2x11/ConneXt GPIO support"
 	depends on MFD_STA2X11
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index cccb0d4..2e3d320 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -108,6 +108,7 @@ obj-$(CONFIG_GPIO_SCH)		+= gpio-sch.o
 obj-$(CONFIG_GPIO_SCH311X)	+= gpio-sch311x.o
 obj-$(CONFIG_GPIO_SODAVILLE)	+= gpio-sodaville.o
 obj-$(CONFIG_GPIO_SPEAR_SPICS)	+= gpio-spear-spics.o
+obj-$(CONFIG_GPIO_SPRD)		+= gpio-sprd.o
 obj-$(CONFIG_GPIO_STA2X11)	+= gpio-sta2x11.o
 obj-$(CONFIG_GPIO_STMPE)	+= gpio-stmpe.o
 obj-$(CONFIG_GPIO_STP_XWAY)	+= gpio-stp-xway.o
diff --git a/drivers/gpio/gpio-sprd.c b/drivers/gpio/gpio-sprd.c
new file mode 100644
index 0000000..d847d37
--- /dev/null
+++ b/drivers/gpio/gpio-sprd.c
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Spreadtrum Communications Inc.
+ * Copyright (C) 2018 Linaro Ltd.
+ */
+
+#include <linux/bitops.h>
+#include <linux/gpio/driver.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+
+/* GPIO registers definition */
+#define SPRD_GPIO_DATA		0x0
+#define SPRD_GPIO_DMSK		0x4
+#define SPRD_GPIO_DIR		0x8
+#define SPRD_GPIO_IS		0xc
+#define SPRD_GPIO_IBE		0x10
+#define SPRD_GPIO_IEV		0x14
+#define SPRD_GPIO_IE		0x18
+#define SPRD_GPIO_RIS		0x1c
+#define SPRD_GPIO_MIS		0x20
+#define SPRD_GPIO_IC		0x24
+#define SPRD_GPIO_INEN		0x28
+
+/* We have 16 banks GPIOs and each bank contain 16 GPIOs */
+#define SPRD_GPIO_BANK_NR	16
+#define SPRD_GPIO_NR		256
+#define SPRD_GPIO_BANK_SIZE	0x80
+#define SPRD_GPIO_BANK_MASK	GENMASK(15, 0)
+#define SPRD_GPIO_BIT(x)	((x) & (SPRD_GPIO_BANK_NR - 1))
+
+struct sprd_gpio {
+	struct gpio_chip chip;
+	void __iomem *base;
+	spinlock_t lock;
+	int irq;
+};
+
+static inline void __iomem *sprd_gpio_bank_base(struct sprd_gpio *sprd_gpio,
+						unsigned int bank)
+{
+	return sprd_gpio->base + SPRD_GPIO_BANK_SIZE * bank;
+}
+
+static void sprd_gpio_update(struct gpio_chip *chip, unsigned int offset,
+			     u16 reg, int val)
+{
+	struct sprd_gpio *sprd_gpio = gpiochip_get_data(chip);
+	void __iomem *base = sprd_gpio_bank_base(sprd_gpio,
+						 offset / SPRD_GPIO_BANK_NR);
+	unsigned long flags;
+	u32 tmp;
+
+	spin_lock_irqsave(&sprd_gpio->lock, flags);
+	tmp = readl_relaxed(base + reg);
+
+	if (val)
+		tmp |= BIT(SPRD_GPIO_BIT(offset));
+	else
+		tmp &= ~BIT(SPRD_GPIO_BIT(offset));
+
+	writel_relaxed(tmp, base + reg);
+	spin_unlock_irqrestore(&sprd_gpio->lock, flags);
+}
+
+static int sprd_gpio_read(struct gpio_chip *chip, unsigned int offset, u16 reg)
+{
+	struct sprd_gpio *sprd_gpio = gpiochip_get_data(chip);
+	void __iomem *base = sprd_gpio_bank_base(sprd_gpio,
+						 offset / SPRD_GPIO_BANK_NR);
+
+	return !!(readl_relaxed(base + reg) & BIT(SPRD_GPIO_BIT(offset)));
+}
+
+static int sprd_gpio_request(struct gpio_chip *chip, unsigned int offset)
+{
+	sprd_gpio_update(chip, offset, SPRD_GPIO_DMSK, 1);
+	return 0;
+}
+
+static void sprd_gpio_free(struct gpio_chip *chip, unsigned int offset)
+{
+	sprd_gpio_update(chip, offset, SPRD_GPIO_DMSK, 0);
+}
+
+static int sprd_gpio_direction_input(struct gpio_chip *chip,
+				     unsigned int offset)
+{
+	sprd_gpio_update(chip, offset, SPRD_GPIO_DIR, 0);
+	sprd_gpio_update(chip, offset, SPRD_GPIO_INEN, 1);
+	return 0;
+}
+
+static int sprd_gpio_direction_output(struct gpio_chip *chip,
+				      unsigned int offset, int value)
+{
+	sprd_gpio_update(chip, offset, SPRD_GPIO_DIR, 1);
+	sprd_gpio_update(chip, offset, SPRD_GPIO_INEN, 0);
+	sprd_gpio_update(chip, offset, SPRD_GPIO_DATA, value);
+	return 0;
+}
+
+static int sprd_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	return sprd_gpio_read(chip, offset, SPRD_GPIO_DATA);
+}
+
+static void sprd_gpio_set(struct gpio_chip *chip, unsigned int offset,
+			  int value)
+{
+	sprd_gpio_update(chip, offset, SPRD_GPIO_DATA, value);
+}
+
+static void sprd_gpio_irq_mask(struct irq_data *data)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
+	u32 offset = irqd_to_hwirq(data);
+
+	sprd_gpio_update(chip, offset, SPRD_GPIO_IE, 0);
+}
+
+static void sprd_gpio_irq_ack(struct irq_data *data)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
+	u32 offset = irqd_to_hwirq(data);
+
+	sprd_gpio_update(chip, offset, SPRD_GPIO_IC, 1);
+}
+
+static void sprd_gpio_irq_unmask(struct irq_data *data)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
+	u32 offset = irqd_to_hwirq(data);
+
+	sprd_gpio_update(chip, offset, SPRD_GPIO_IE, 1);
+}
+
+static int sprd_gpio_irq_set_type(struct irq_data *data,
+				  unsigned int flow_type)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
+	u32 offset = irqd_to_hwirq(data);
+
+	switch (flow_type) {
+	case IRQ_TYPE_EDGE_RISING:
+		sprd_gpio_update(chip, offset, SPRD_GPIO_IS, 0);
+		sprd_gpio_update(chip, offset, SPRD_GPIO_IBE, 0);
+		sprd_gpio_update(chip, offset, SPRD_GPIO_IEV, 1);
+		irq_set_handler_locked(data, handle_edge_irq);
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		sprd_gpio_update(chip, offset, SPRD_GPIO_IS, 0);
+		sprd_gpio_update(chip, offset, SPRD_GPIO_IBE, 0);
+		sprd_gpio_update(chip, offset, SPRD_GPIO_IEV, 0);
+		irq_set_handler_locked(data, handle_edge_irq);
+		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		sprd_gpio_update(chip, offset, SPRD_GPIO_IS, 0);
+		sprd_gpio_update(chip, offset, SPRD_GPIO_IBE, 1);
+		irq_set_handler_locked(data, handle_edge_irq);
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		sprd_gpio_update(chip, offset, SPRD_GPIO_IS, 1);
+		sprd_gpio_update(chip, offset, SPRD_GPIO_IBE, 0);
+		sprd_gpio_update(chip, offset, SPRD_GPIO_IEV, 1);
+		irq_set_handler_locked(data, handle_level_irq);
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		sprd_gpio_update(chip, offset, SPRD_GPIO_IS, 1);
+		sprd_gpio_update(chip, offset, SPRD_GPIO_IBE, 0);
+		sprd_gpio_update(chip, offset, SPRD_GPIO_IEV, 0);
+		irq_set_handler_locked(data, handle_level_irq);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void sprd_gpio_irq_handler(struct irq_desc *desc)
+{
+	struct gpio_chip *chip = irq_desc_get_handler_data(desc);
+	struct irq_chip *ic = irq_desc_get_chip(desc);
+	struct sprd_gpio *sprd_gpio = gpiochip_get_data(chip);
+	u32 bank, n, girq;
+
+	chained_irq_enter(ic, desc);
+
+	for (bank = 0; bank * SPRD_GPIO_BANK_NR < chip->ngpio; bank++) {
+		void __iomem *base = sprd_gpio_bank_base(sprd_gpio, bank);
+		unsigned long reg = readl_relaxed(base + SPRD_GPIO_MIS) &
+			SPRD_GPIO_BANK_MASK;
+
+		for_each_set_bit(n, &reg, SPRD_GPIO_BANK_NR) {
+			girq = irq_find_mapping(chip->irq.domain,
+						bank * SPRD_GPIO_BANK_NR + n);
+
+			generic_handle_irq(girq);
+		}
+
+	}
+	chained_irq_exit(ic, desc);
+}
+
+static struct irq_chip sprd_gpio_irqchip = {
+	.name = "sprd-gpio",
+	.irq_ack = sprd_gpio_irq_ack,
+	.irq_mask = sprd_gpio_irq_mask,
+	.irq_unmask = sprd_gpio_irq_unmask,
+	.irq_set_type = sprd_gpio_irq_set_type,
+	.flags = IRQCHIP_SKIP_SET_WAKE,
+};
+
+static int sprd_gpio_probe(struct platform_device *pdev)
+{
+	struct gpio_irq_chip *irq;
+	struct sprd_gpio *sprd_gpio;
+	struct resource *res;
+	int ret;
+
+	sprd_gpio = devm_kzalloc(&pdev->dev, sizeof(*sprd_gpio), GFP_KERNEL);
+	if (!sprd_gpio)
+		return -ENOMEM;
+
+	sprd_gpio->irq = platform_get_irq(pdev, 0);
+	if (sprd_gpio->irq < 0) {
+		dev_err(&pdev->dev, "Failed to get GPIO interrupt.\n");
+		return sprd_gpio->irq;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	sprd_gpio->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(sprd_gpio->base))
+		return PTR_ERR(sprd_gpio->base);
+
+	spin_lock_init(&sprd_gpio->lock);
+
+	sprd_gpio->chip.label = dev_name(&pdev->dev);
+	sprd_gpio->chip.ngpio = SPRD_GPIO_NR;
+	sprd_gpio->chip.base = -1;
+	sprd_gpio->chip.parent = &pdev->dev;
+	sprd_gpio->chip.of_node = pdev->dev.of_node;
+	sprd_gpio->chip.request = sprd_gpio_request;
+	sprd_gpio->chip.free = sprd_gpio_free;
+	sprd_gpio->chip.get = sprd_gpio_get;
+	sprd_gpio->chip.set = sprd_gpio_set;
+	sprd_gpio->chip.direction_input = sprd_gpio_direction_input;
+	sprd_gpio->chip.direction_output = sprd_gpio_direction_output;
+
+	irq = &sprd_gpio->chip.irq;
+	irq->chip = &sprd_gpio_irqchip;
+	irq->handler = handle_simple_irq;
+	irq->default_type = IRQ_TYPE_NONE;
+	irq->parent_handler = sprd_gpio_irq_handler;
+	irq->parent_handler_data = sprd_gpio;
+	irq->num_parents = 1;
+	irq->parents = &sprd_gpio->irq;
+
+	ret = devm_gpiochip_add_data(&pdev->dev, &sprd_gpio->chip, sprd_gpio);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Could not register gpiochip %d\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, sprd_gpio);
+	return 0;
+}
+
+static const struct of_device_id sprd_gpio_of_match[] = {
+	{ .compatible = "sprd,sc9860-gpio", },
+	{ /* end of list */ },
+};
+MODULE_DEVICE_TABLE(of, sprd_gpio_of_match);
+
+static struct platform_driver sprd_gpio_driver = {
+	.probe = sprd_gpio_probe,
+	.driver = {
+		.name = "sprd-gpio",
+		.of_match_table	= sprd_gpio_of_match,
+	},
+};
+
+module_platform_driver_probe(sprd_gpio_driver, sprd_gpio_probe);
+
+MODULE_DESCRIPTION("Spreadtrum GPIO driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5
