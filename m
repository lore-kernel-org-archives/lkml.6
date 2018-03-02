Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164775AbeCBDw2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 22:52:28 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35178 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164224AbeCBDwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 22:52:24 -0500
X-Google-Smtp-Source: AG47ELtmlCIp3KCOQYmOUy9dDOB65Dn9Jvy5BXi1WwDR/xlLtLqGxuGImLa5u+/5FHscdvrbHqcSyQ==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: linus.walleij@linaro.org, robh+dt@kernel.org, afaerber@suse.de
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 08/10] gpio: Add gpio driver for Actions OWL S900 SoC
Date: Fri,  2 Mar 2018 09:20:43 +0530
Message-Id: <20180302035045.14660-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180302035045.14660-1-manivannan.sadhasivam@linaro.org>
References: <20180302035045.14660-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gpio driver for Actions Semi OWL family S900 SoC. Set of registers
controlling the gpio shares the same register range with pinctrl block.

GPIO registers are organized as 6 banks and each bank controls the
maximum of 32 gpios.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/gpio/Kconfig    |   8 ++
 drivers/gpio/Makefile   |   1 +
 drivers/gpio/gpio-owl.c | 218 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 227 insertions(+)
 create mode 100644 drivers/gpio/gpio-owl.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 8dbb2280538d..75533f55ad0e 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -364,6 +364,14 @@ config GPIO_OMAP
 	help
 	  Say yes here to enable GPIO support for TI OMAP SoCs.
 
+config GPIO_OWL
+	tristate "Actions Semi OWL GPIO support"
+	default ARCH_ACTIONS
+	depends on ARCH_ACTIONS || COMPILE_TEST
+	depends on OF_GPIO
+	help
+	  Say yes here to enable GPIO support for Actions Semi OWL SoCs.
+
 config GPIO_PL061
 	bool "PrimeCell PL061 GPIO support"
 	depends on ARM_AMBA
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index cccb0d40846c..b2bb11d4675f 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -91,6 +91,7 @@ obj-$(CONFIG_GPIO_MXC)		+= gpio-mxc.o
 obj-$(CONFIG_GPIO_MXS)		+= gpio-mxs.o
 obj-$(CONFIG_GPIO_OCTEON)	+= gpio-octeon.o
 obj-$(CONFIG_GPIO_OMAP)		+= gpio-omap.o
+obj-$(CONFIG_GPIO_OWL)		+= gpio-owl.o
 obj-$(CONFIG_GPIO_PCA953X)	+= gpio-pca953x.o
 obj-$(CONFIG_GPIO_PCF857X)	+= gpio-pcf857x.o
 obj-$(CONFIG_GPIO_PCH)		+= gpio-pch.o
diff --git a/drivers/gpio/gpio-owl.c b/drivers/gpio/gpio-owl.c
new file mode 100644
index 000000000000..88d88cd82d2a
--- /dev/null
+++ b/drivers/gpio/gpio-owl.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * OWL SoC's GPIO driver
+ *
+ * Copyright (c) 2018 Linaro Ltd.
+ * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+ */
+
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/gpio/driver.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define GPIO_OUTEN	0x0000
+#define GPIO_INEN	0x0004
+#define GPIO_DAT	0x0008
+
+#define OWL_GPIO_PORT_A 0
+#define OWL_GPIO_PORT_B 1
+#define OWL_GPIO_PORT_C 2
+#define OWL_GPIO_PORT_D 3
+#define OWL_GPIO_PORT_E 4
+#define OWL_GPIO_PORT_F 5
+
+struct owl_gpio_port {
+	const char *name;
+	unsigned int offset;
+	unsigned int pins;
+};
+
+struct owl_gpio {
+	struct gpio_chip gpio;
+	const struct owl_gpio_port *port;
+	void __iomem *base;
+	int id;
+};
+
+static void owl_gpio_set_reg(void __iomem *base, unsigned int pin, int flag)
+{
+	u32 val;
+
+	val = readl_relaxed(base);
+
+	if (flag)
+		val |= BIT(pin);
+	else
+		val &= ~BIT(pin);
+
+	writel_relaxed(val, base);
+}
+
+static int owl_gpio_request(struct gpio_chip *chip, unsigned int offset)
+{
+	struct owl_gpio *gpio = gpiochip_get_data(chip);
+	const struct owl_gpio_port *port = gpio->port;
+	void __iomem *gpio_base = gpio->base + port->offset;
+
+	/*
+	 * GPIOs have higher priority over other modules, so either setting
+	 * them as OUT or IN is sufficient
+	 */
+	owl_gpio_set_reg(gpio_base + GPIO_OUTEN, offset, true);
+
+	return 0;
+}
+
+static void owl_gpio_free(struct gpio_chip *chip, unsigned int offset)
+{
+	struct owl_gpio *gpio = gpiochip_get_data(chip);
+	const struct owl_gpio_port *port = gpio->port;
+	void __iomem *gpio_base = gpio->base + port->offset;
+
+	/* disable gpio output */
+	owl_gpio_set_reg(gpio_base + GPIO_OUTEN, offset, false);
+
+	/* disable gpio input */
+	owl_gpio_set_reg(gpio_base + GPIO_INEN, offset, false);
+}
+
+static int owl_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct owl_gpio *gpio = gpiochip_get_data(chip);
+	const struct owl_gpio_port *port = gpio->port;
+	void __iomem *gpio_base = gpio->base + port->offset;
+	u32 val;
+
+	val = readl_relaxed(gpio_base + GPIO_DAT);
+
+	return !!(val & BIT(offset));
+}
+
+static void owl_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
+{
+	struct owl_gpio *gpio = gpiochip_get_data(chip);
+	const struct owl_gpio_port *port = gpio->port;
+	void __iomem *gpio_base = gpio->base + port->offset;
+	u32 val;
+
+	val = readl_relaxed(gpio_base + GPIO_DAT);
+
+	if (value)
+		val |= BIT(offset);
+	else
+		val &= ~BIT(offset);
+
+	writel_relaxed(val, gpio_base + GPIO_DAT);
+}
+
+static int owl_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
+{
+	struct owl_gpio *gpio = gpiochip_get_data(chip);
+	const struct owl_gpio_port *port = gpio->port;
+	void __iomem *gpio_base = gpio->base + port->offset;
+
+	owl_gpio_set_reg(gpio_base + GPIO_OUTEN, offset, false);
+	owl_gpio_set_reg(gpio_base + GPIO_INEN, offset, true);
+
+	return 0;
+}
+
+static int owl_gpio_direction_output(struct gpio_chip *chip,
+				unsigned int offset, int value)
+{
+	struct owl_gpio *gpio = gpiochip_get_data(chip);
+	const struct owl_gpio_port *port = gpio->port;
+	void __iomem *gpio_base = gpio->base + port->offset;
+
+	owl_gpio_set_reg(gpio_base + GPIO_INEN, offset, false);
+	owl_gpio_set_reg(gpio_base + GPIO_OUTEN, offset, true);
+	owl_gpio_set(chip, offset, value);
+
+	return 0;
+}
+
+#define OWL_GPIO_PORT(port, base, count)		\
+	[OWL_GPIO_PORT_##port] = {			\
+		.name = #port,				\
+		.offset = base,				\
+		.pins = count,				\
+	}
+
+static const struct owl_gpio_port s900_gpio_ports[] = {
+	OWL_GPIO_PORT(A, 0x0000, 32),
+	OWL_GPIO_PORT(B, 0x000C, 32),
+	OWL_GPIO_PORT(C, 0x0018, 12),
+	OWL_GPIO_PORT(D, 0x0024, 30),
+	OWL_GPIO_PORT(E, 0x0030, 32),
+	OWL_GPIO_PORT(F, 0x00F0, 8)
+};
+
+static int owl_gpio_probe(struct platform_device *pdev)
+{
+	struct owl_gpio *gpio;
+	const struct owl_gpio_port *port;
+	int ret;
+
+	gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
+	if (!gpio)
+		return -ENOMEM;
+
+	gpio->base = of_iomap(pdev->dev.of_node, 0);
+	if (IS_ERR(gpio->base))
+		return PTR_ERR(gpio->base);
+
+	gpio->id = of_alias_get_id(pdev->dev.of_node, "gpio");
+	if (gpio->id < 0)
+		return gpio->id;
+
+	port = &s900_gpio_ports[gpio->id];
+
+	gpio->gpio.request = owl_gpio_request;
+	gpio->gpio.free = owl_gpio_free;
+	gpio->gpio.get = owl_gpio_get;
+	gpio->gpio.set = owl_gpio_set;
+	gpio->gpio.direction_input = owl_gpio_direction_input;
+	gpio->gpio.direction_output = owl_gpio_direction_output;
+
+	gpio->gpio.base = -1;
+	gpio->gpio.parent = &pdev->dev;
+	gpio->gpio.label = port->name;
+	gpio->gpio.ngpio = port->pins;
+
+	gpio->port = port;
+
+	platform_set_drvdata(pdev, gpio);
+
+	ret = devm_gpiochip_add_data(&pdev->dev, &gpio->gpio, gpio);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register gpiochip\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id owl_gpio_of_match[] = {
+	{ .compatible = "actions,s900-gpio", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, owl_gpio_of_match);
+
+static struct platform_driver owl_gpio_driver = {
+	.driver		= {
+		.name	= "owl-gpio",
+		.of_match_table = owl_gpio_of_match,
+	},
+	.probe		= owl_gpio_probe
+};
+module_platform_driver(owl_gpio_driver);
+
+MODULE_AUTHOR("Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>");
+MODULE_DESCRIPTION("Actions Semi OWL SoCs GPIO driver");
+MODULE_LICENSE("GPL");
-- 
2.14.1
