Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752715AbeDQO30 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:29:26 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:38794 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752086AbeDQO3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:29:21 -0400
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <lee.jones@linaro.org>, <linus.walleij@linaro.org>,
        <andy.shevchenko@gmail.com>, <robh+dt@kernel.org>
CC: <patches@opensource.cirrus.com>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 9/9] gpio: madera: Support Cirrus Logic Madera class codecs
Date: Tue, 17 Apr 2018 15:29:15 +0100
Message-ID: <20180417142915.15772-10-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180417142915.15772-1-rf@opensource.cirrus.com>
References: <20180417142915.15772-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1804170130
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the GPIOs on Cirrus Logic Madera class codecs.
Any pins not used for special functions (see the pinctrl driver) can be
used as general single-bit input or output lines. The number of available
GPIOs varies between codecs.

Note that this is part of a composite MFD for these codecs and can only
be used with the corresponding MFD and other child drivers on those
silicon. The GPIO block on these codecs does not exist indepedently of
the rest of the MFD.

Signed-off-by: Nariman Poushin <nariman@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes since V7:
As the changes are all small and mostly coding style, I've carried forward Linus's
previous ack.

- SPDX license headers
- can now build as a module
- fixed some coding style issues raised by Andy Shevchenko and Linus Walleij
- commented why we are calling gpiochip_add_pin_range()
- commented why there is a struct gpio_chip inside struct madera_gpio
---
 MAINTAINERS                |   1 +
 drivers/gpio/Kconfig       |   6 ++
 drivers/gpio/Makefile      |   1 +
 drivers/gpio/gpio-madera.c | 206 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 214 insertions(+)
 create mode 100644 drivers/gpio/gpio-madera.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 716c4743892d..17a5c78924fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3487,6 +3487,7 @@ S:	Supported
 F:	Documentation/devicetree/bindings/mfd/madera.txt
 F:	Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt
 F:	include/linux/mfd/madera/*
+F:	drivers/gpio/gpio-madera*
 F:	drivers/mfd/madera*
 F:	drivers/mfd/cs47l*
 F:	drivers/pinctrl/cirrus/*
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b960f6f35abd..08c2c121a6dc 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1027,6 +1027,12 @@ config GPIO_LP87565
 	  This driver can also be built as a module. If so, the module will be
 	  called gpio-lp87565.
 
+config GPIO_MADERA
+	tristate "Cirrus Logic Madera class codecs"
+	depends on PINCTRL_MADERA
+	help
+	  Support for GPIOs on Cirrus Logic Madera class codecs.
+
 config GPIO_MAX77620
 	tristate "GPIO support for PMIC MAX77620 and MAX20024"
 	depends on MFD_MAX77620
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 1324c8f966a7..22bef2e7c162 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -71,6 +71,7 @@ obj-$(CONFIG_ARCH_LPC32XX)	+= gpio-lpc32xx.o
 obj-$(CONFIG_GPIO_LP873X)	+= gpio-lp873x.o
 obj-$(CONFIG_GPIO_LP87565)	+= gpio-lp87565.o
 obj-$(CONFIG_GPIO_LYNXPOINT)	+= gpio-lynxpoint.o
+obj-$(CONFIG_GPIO_MADERA)	+= gpio-madera.o
 obj-$(CONFIG_GPIO_MAX3191X)	+= gpio-max3191x.o
 obj-$(CONFIG_GPIO_MAX730X)	+= gpio-max730x.o
 obj-$(CONFIG_GPIO_MAX7300)	+= gpio-max7300.o
diff --git a/drivers/gpio/gpio-madera.c b/drivers/gpio/gpio-madera.c
new file mode 100644
index 000000000000..7ba68d1a0932
--- /dev/null
+++ b/drivers/gpio/gpio-madera.c
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * GPIO support for Cirrus Logic Madera codecs
+ *
+ * Copyright (C) 2015-2018 Cirrus Logic
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; version 2.
+ */
+
+#include <linux/gpio/driver.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <linux/mfd/madera/core.h>
+#include <linux/mfd/madera/pdata.h>
+#include <linux/mfd/madera/registers.h>
+
+struct madera_gpio {
+	struct madera *madera;
+	/* storage space for the gpio_chip we're using */
+	struct gpio_chip gpio_chip;
+};
+
+static int madera_gpio_get_direction(struct gpio_chip *chip,
+				     unsigned int offset)
+{
+	struct madera_gpio *madera_gpio = gpiochip_get_data(chip);
+	struct madera *madera = madera_gpio->madera;
+	unsigned int reg_offset = 2 * offset;
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(madera->regmap, MADERA_GPIO1_CTRL_2 + reg_offset,
+			  &val);
+	if (ret < 0)
+		return ret;
+
+	return !!(val & MADERA_GP1_DIR_MASK);
+}
+
+static int madera_gpio_direction_in(struct gpio_chip *chip, unsigned int offset)
+{
+	struct madera_gpio *madera_gpio = gpiochip_get_data(chip);
+	struct madera *madera = madera_gpio->madera;
+	unsigned int reg_offset = 2 * offset;
+
+	return regmap_update_bits(madera->regmap,
+				  MADERA_GPIO1_CTRL_2 + reg_offset,
+				  MADERA_GP1_DIR_MASK, MADERA_GP1_DIR);
+}
+
+static int madera_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct madera_gpio *madera_gpio = gpiochip_get_data(chip);
+	struct madera *madera = madera_gpio->madera;
+	unsigned int reg_offset = 2 * offset;
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(madera->regmap, MADERA_GPIO1_CTRL_1 + reg_offset,
+			  &val);
+	if (ret < 0)
+		return ret;
+
+	return !!(val & MADERA_GP1_LVL_MASK);
+}
+
+static int madera_gpio_direction_out(struct gpio_chip *chip,
+				     unsigned int offset, int value)
+{
+	struct madera_gpio *madera_gpio = gpiochip_get_data(chip);
+	struct madera *madera = madera_gpio->madera;
+	unsigned int reg_offset = 2 * offset;
+	unsigned int reg_val = value ? MADERA_GP1_LVL : 0;
+	int ret;
+
+	ret = regmap_update_bits(madera->regmap,
+				 MADERA_GPIO1_CTRL_2 + reg_offset,
+				 MADERA_GP1_DIR_MASK, 0);
+	if (ret < 0)
+		return ret;
+
+	return regmap_update_bits(madera->regmap,
+				  MADERA_GPIO1_CTRL_1 + reg_offset,
+				  MADERA_GP1_LVL_MASK, reg_val);
+}
+
+static void madera_gpio_set(struct gpio_chip *chip, unsigned int offset,
+			    int value)
+{
+	struct madera_gpio *madera_gpio = gpiochip_get_data(chip);
+	struct madera *madera = madera_gpio->madera;
+	unsigned int reg_offset = 2 * offset;
+	unsigned int reg_val = value ? MADERA_GP1_LVL : 0;
+	int ret;
+
+	ret = regmap_update_bits(madera->regmap,
+				 MADERA_GPIO1_CTRL_1 + reg_offset,
+				 MADERA_GP1_LVL_MASK, reg_val);
+
+	/* set() doesn't return an error so log a warning */
+	if (ret)
+		dev_warn(madera->dev, "Failed to write to 0x%x (%d)\n",
+			 MADERA_GPIO1_CTRL_1 + reg_offset, ret);
+}
+
+static struct gpio_chip madera_gpio_chip = {
+	.label			= "madera",
+	.owner			= THIS_MODULE,
+	.request		= gpiochip_generic_request,
+	.free			= gpiochip_generic_free,
+	.get_direction		= madera_gpio_get_direction,
+	.direction_input	= madera_gpio_direction_in,
+	.get			= madera_gpio_get,
+	.direction_output	= madera_gpio_direction_out,
+	.set			= madera_gpio_set,
+	.set_config		= gpiochip_generic_config,
+	.can_sleep		= true,
+};
+
+static int madera_gpio_probe(struct platform_device *pdev)
+{
+	struct madera *madera = dev_get_drvdata(pdev->dev.parent);
+	struct madera_pdata *pdata = dev_get_platdata(madera->dev);
+	struct madera_gpio *madera_gpio;
+	int ret;
+
+	madera_gpio = devm_kzalloc(&pdev->dev, sizeof(*madera_gpio),
+				   GFP_KERNEL);
+	if (!madera_gpio)
+		return -ENOMEM;
+
+	madera_gpio->madera = madera;
+
+	/* Construct suitable gpio_chip from the template in madera_gpio_chip */
+	madera_gpio->gpio_chip = madera_gpio_chip;
+	madera_gpio->gpio_chip.parent = pdev->dev.parent;
+
+	switch (madera->type) {
+	case CS47L35:
+		madera_gpio->gpio_chip.ngpio = CS47L35_NUM_GPIOS;
+		break;
+	case CS47L85:
+	case WM1840:
+		madera_gpio->gpio_chip.ngpio = CS47L85_NUM_GPIOS;
+		break;
+	case CS47L90:
+	case CS47L91:
+		madera_gpio->gpio_chip.ngpio = CS47L90_NUM_GPIOS;
+		break;
+	default:
+		dev_err(&pdev->dev, "Unknown chip variant %d\n", madera->type);
+		return -EINVAL;
+	}
+
+	/* We want to be usable on systems that don't use devicetree or acpi */
+	if (pdata && pdata->gpio_base)
+		madera_gpio->gpio_chip.base = pdata->gpio_base;
+	else
+		madera_gpio->gpio_chip.base = -1;
+
+	ret = devm_gpiochip_add_data(&pdev->dev,
+				     &madera_gpio->gpio_chip,
+				     madera_gpio);
+	if (ret < 0) {
+		dev_dbg(&pdev->dev, "Could not register gpiochip, %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * This is part of a composite MFD device which can only be used with
+	 * the corresponding pinctrl driver. On all supported silicon the GPIO
+	 * to pinctrl mapping is fixed in the silicon, so we register it
+	 * explicitly instead of requiring a redundant gpio-ranges in the
+	 * devicetree.
+	 * In any case we also want to work on systems that don't use devicetree
+	 * or acpi.
+	 */
+	ret = gpiochip_add_pin_range(&madera_gpio->gpio_chip, "madera-pinctrl",
+				     0, 0, madera_gpio->gpio_chip.ngpio);
+	if (ret) {
+		dev_dbg(&pdev->dev, "Failed to add pin range (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct platform_driver madera_gpio_driver = {
+	.driver = {
+		.name	= "madera-gpio",
+	},
+	.probe		= madera_gpio_probe,
+};
+
+module_platform_driver(madera_gpio_driver);
+
+MODULE_SOFTDEP("pre: pinctrl-madera");
+MODULE_DESCRIPTION("GPIO interface for Madera codecs");
+MODULE_AUTHOR("Nariman Poushin <nariman@opensource.cirrus.com>");
+MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.cirrus.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:madera-gpio");
-- 
2.11.0
