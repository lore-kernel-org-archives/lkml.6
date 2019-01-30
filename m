Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A8BC282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97F82184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730508AbfA3JMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:12:07 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40327 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfA3JMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:12:06 -0500
Received: by mail-lf1-f68.google.com with SMTP id v5so16803492lfe.7;
        Wed, 30 Jan 2019 01:12:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AvluvHbI2AqPoGdOpq2XGABjFr+RufaKUEWajSIDPmY=;
        b=ny3Il3y+JXTLTw1VBlLU4P7maP+4URG5uUBr2erFwVRBLq1tdDomkodHT+qeI100/6
         jeTwrtEw0akmHb+phnpLxPvwNGnfhOxYhMOJ0QU4dRahlJCGxqEYzFDyzkQ3xA9ZAdj9
         PMJHGEOY0JE4wsaIIALkzNqMXmEIjiFu4TNZya4weBmwZkm7YPrjbCfnoPBTCc6C1DM1
         8AhyzFbF8zotjQ67nJr+ZLI920e8LSpvPDtFDzaNu9AXnIrxYmf1qVDZJsCuBaEX9yp4
         HIMbfketY2YgfArkfI27SAJhw+n4KjDSmRa01aF5QNgAZEU4lUesVz34H5FTu8XH9wjt
         fksw==
X-Gm-Message-State: AJcUuke1/XreesYDFtYm2SJpG0VWB/MVGGV8Sx5KyyiSl0hUyKKYsMdH
        UAFkQsgRniMxNsNFQnNbfI0=
X-Google-Smtp-Source: ALg8bN4eJgGrSzTW4u0GDdIjX1wi66T7YxDHJxB5i0/q0ZjmKUJ0XZvPiso6pn2XJus3iR7ZuYEFgw==
X-Received: by 2002:a19:f619:: with SMTP id x25mr22846034lfe.163.1548839521994;
        Wed, 30 Jan 2019 01:12:01 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id f8sm200221lfe.72.2019.01.30.01.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 01:12:01 -0800 (PST)
Date:   Wed, 30 Jan 2019 11:11:47 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        linux@roeck-us.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [RFC PATCH v3 07/10] gpio: Initial support for ROHM bd70528 GPIO
 block
Message-ID: <f3993aeff320af1ac6ce2161a180b88e59402ab0.1548838724.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1548838724.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1548838724.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ROHM BD70528 PMIC has 4 GPIO pins. Allow them to be
controlled by GPIO framework.

IRQs are handled by regmap-irq and GPIO driver is not
aware of the irq usage.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/Kconfig        |  11 +++
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/gpio-bd70528.c | 191 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 203 insertions(+)
 create mode 100644 drivers/gpio/gpio-bd70528.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b5a2845347ec..c82187648630 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -962,6 +962,17 @@ config GPIO_ARIZONA
 	help
 	  Support for GPIOs on Wolfson Arizona class devices.
 
+config GPIO_BD70528
+	tristate "ROHM BD70528 GPIO support"
+	depends on MFD_ROHM_BD70528
+	help
+	  Support for GPIOs on ROHM BD70528 PMIC. There are four GPIOs
+	  available on the ROHM PMIC in total. The GPIOs can also
+	  generate interrupts.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called gpio-bd70528.
+
 config GPIO_BD9571MWV
 	tristate "ROHM BD9571 GPIO support"
 	depends on MFD_BD9571MWV
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 37628f8dbf70..6f12c83598fc 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_GPIO_ATH79)	+= gpio-ath79.o
 obj-$(CONFIG_GPIO_ASPEED)	+= gpio-aspeed.o
 obj-$(CONFIG_GPIO_RASPBERRYPI_EXP)	+= gpio-raspberrypi-exp.o
 obj-$(CONFIG_GPIO_BCM_KONA)	+= gpio-bcm-kona.o
+obj-$(CONFIG_GPIO_BD70528) 	+= gpio-bd70528.o
 obj-$(CONFIG_GPIO_BD9571MWV)	+= gpio-bd9571mwv.o
 obj-$(CONFIG_GPIO_BRCMSTB)	+= gpio-brcmstb.o
 obj-$(CONFIG_GPIO_BT8XX)	+= gpio-bt8xx.o
diff --git a/drivers/gpio/gpio-bd70528.c b/drivers/gpio/gpio-bd70528.c
new file mode 100644
index 000000000000..6a8149721aaf
--- /dev/null
+++ b/drivers/gpio/gpio-bd70528.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 ROHM Semiconductors
+// gpio-bd70528.c ROHM BD70528MWV gpio driver
+
+#include <linux/gpio/driver.h>
+#include <linux/mfd/rohm-bd70528.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define GPIO_IN_REG(offset) (BD70528_REG_GPIO1_IN + offset*2)
+#define GPIO_OUT_REG(offset) (BD70528_REG_GPIO1_OUT + offset*2)
+
+struct bd70528_gpio {
+	struct rohm_regmap_dev chip;
+	struct gpio_chip gpio;
+};
+
+static int bd70528_set_debounce(struct bd70528_gpio *bdgpio,
+				unsigned int offset, unsigned int debounce)
+{
+	u8 val;
+
+	switch (debounce) {
+	case 0:
+		val = BD70528_DEBOUNCE_DISABLE;
+		break;
+	case 1 ... 15:
+		val = BD70528_DEBOUNCE_15MS;
+		break;
+	case 16 ... 30:
+		val = BD70528_DEBOUNCE_30MS;
+		break;
+	case 31 ... 50:
+		val = BD70528_DEBOUNCE_50MS;
+		break;
+	default:
+		dev_err(bdgpio->chip.dev,
+			"Invalid debouce value %u\n", debounce);
+		return -EINVAL;
+	}
+	return regmap_update_bits(bdgpio->chip.regmap, GPIO_IN_REG(offset),
+				 BD70528_DEBOUNCE_MASK, val);
+}
+
+static int bd70528_get_direction(struct gpio_chip *chip, unsigned int offset)
+{
+	struct bd70528_gpio *bdgpio = gpiochip_get_data(chip);
+	int val, ret;
+
+	/* Do we need to do something to IRQs here? */
+	ret = regmap_read(bdgpio->chip.regmap, GPIO_OUT_REG(offset), &val);
+	if (ret) {
+		dev_err(bdgpio->chip.dev, "Could not read gpio direction\n");
+		return ret;
+	}
+
+	return !(val & BD70528_GPIO_OUT_EN_MASK);
+}
+
+static int bd70528_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
+				   unsigned long config)
+{
+	struct bd70528_gpio *bdgpio = gpiochip_get_data(chip);
+
+	switch (pinconf_to_config_param(config)) {
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		return regmap_update_bits(bdgpio->chip.regmap,
+					  GPIO_OUT_REG(offset),
+					  BD70528_GPIO_DRIVE_MASK,
+					  BD70528_GPIO_OPEN_DRAIN);
+		break;
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		return regmap_update_bits(bdgpio->chip.regmap,
+					  GPIO_OUT_REG(offset),
+					  BD70528_GPIO_DRIVE_MASK,
+					  BD70528_GPIO_PUSH_PULL);
+		break;
+	case PIN_CONFIG_INPUT_DEBOUNCE:
+		return bd70528_set_debounce(bdgpio, offset,
+					    pinconf_to_config_argument(config));
+		break;
+	default:
+		break;
+	}
+	return -ENOTSUPP;
+}
+
+static int bd70528_direction_input(struct gpio_chip *chip, unsigned int offset)
+{
+	struct bd70528_gpio *bdgpio = gpiochip_get_data(chip);
+
+	/* Do we need to do something to IRQs here? */
+	return regmap_update_bits(bdgpio->chip.regmap, GPIO_OUT_REG(offset),
+				 BD70528_GPIO_OUT_EN_MASK,
+				 BD70528_GPIO_OUT_DISABLE);
+}
+static void bd70528_gpio_set(struct gpio_chip *chip, unsigned int offset,
+			     int value)
+{
+	int ret;
+	struct bd70528_gpio *bdgpio = gpiochip_get_data(chip);
+	u8 val = (value) ? BD70528_GPIO_OUT_HI : BD70528_GPIO_OUT_LO;
+
+	ret = regmap_update_bits(bdgpio->chip.regmap, GPIO_OUT_REG(offset),
+				  BD70528_GPIO_OUT_MASK, val);
+	if (ret)
+		dev_err(bdgpio->chip.dev, "Could not set gpio to %d\n", value);
+}
+
+static int bd70528_direction_output(struct gpio_chip *chip, unsigned int offset,
+				    int value)
+{
+	struct bd70528_gpio *bdgpio = gpiochip_get_data(chip);
+
+	bd70528_gpio_set(chip, offset, value);
+	return regmap_update_bits(bdgpio->chip.regmap, GPIO_OUT_REG(offset),
+				 BD70528_GPIO_OUT_EN_MASK,
+				 BD70528_GPIO_OUT_ENABLE);
+}
+
+#define GPIO_STATE_MASK(offset) (BD70528_GPIO_IN_STATE_BASE << offset)
+
+static int bd70528_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	unsigned int val;
+	int ret = -EINVAL;
+	struct bd70528_gpio *bdgpio = gpiochip_get_data(chip);
+
+	ret = regmap_read(bdgpio->chip.regmap, BD70528_REG_GPIO_STATE, &val);
+
+	if (!ret)
+		ret = !(val & GPIO_STATE_MASK(offset));
+
+	return ret;
+}
+
+static int  bd70528_probe(struct platform_device *pdev)
+{
+	struct bd70528_gpio *bdgpio;
+	struct bd70528 *bd70528;
+	int ret;
+
+	bd70528 = dev_get_drvdata(pdev->dev.parent);
+	if (!bd70528) {
+		dev_err(&pdev->dev, "No MFD driver data\n");
+		return -EINVAL;
+	}
+
+	bdgpio = devm_kzalloc(&pdev->dev, sizeof(*bdgpio),
+				    GFP_KERNEL);
+	if (!bdgpio)
+		return -ENOMEM;
+	bdgpio->chip.dev = &pdev->dev;
+	bdgpio->gpio.parent = pdev->dev.parent;
+	bdgpio->gpio.label = "bd70528-gpio";
+	bdgpio->gpio.owner = THIS_MODULE;
+	bdgpio->gpio.get_direction = &bd70528_get_direction;
+	bdgpio->gpio.direction_input = &bd70528_direction_input;
+	bdgpio->gpio.direction_output = &bd70528_direction_output;
+	bdgpio->gpio.set_config = &bd70528_gpio_set_config;
+	bdgpio->gpio.can_sleep = true;
+	bdgpio->gpio.get = &bd70528_gpio_get;
+	bdgpio->gpio.set = &bd70528_gpio_set;
+	bdgpio->gpio.ngpio = 4;
+	bdgpio->gpio.base = -1;
+#ifdef CONFIG_OF_GPIO
+	bdgpio->gpio.of_node = pdev->dev.parent->of_node;
+#endif
+	bdgpio->chip.regmap = bd70528->chip.regmap;
+
+	ret = devm_gpiochip_add_data(&pdev->dev, &bdgpio->gpio,
+				     bdgpio);
+	if (ret)
+		dev_err(&pdev->dev, "gpio_init: Failed to add bd70528-gpio\n");
+
+	return ret;
+}
+
+static struct platform_driver bd70528_gpio = {
+	.driver = {
+		.name = "bd70528-gpio"
+	},
+	.probe = bd70528_probe,
+};
+
+module_platform_driver(bd70528_gpio);
+
+MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
+MODULE_DESCRIPTION("BD70528 voltage regulator driver");
+MODULE_LICENSE("GPL");
-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
