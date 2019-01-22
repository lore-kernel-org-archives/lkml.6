Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C23FC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE4220879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbfAVJrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:47:23 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42257 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbfAVJrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:47:22 -0500
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so19979842lja.9;
        Tue, 22 Jan 2019 01:47:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N2Q8rqjP7PprAPrzxzhDGMrBHb/SGJ78wZd45ti5jz4=;
        b=RdZl8uP7CnS6unKhefyiiorgoIXep+vRJqewu99TEzuMsoJJLa+luSZB5x0PGMc3Qy
         65wSwURbO++Na5UznG4KNzRqQcsTVSJV1yfJjSmcJQu2HZc2B7mA7aUrtHArRYOxq4Cp
         UMiHkG5qH1pvDA6BQruXkI7PuB3bRQxYMkW70v8TpyUiWkNS0Q03vmWISmwn8WUmjmXZ
         ctv/xLD/Bzh25+epuamuN24LrhbI4RXrial4gqJS6CLZlA8PHBXceGvmmc5yWo+Dvx2A
         /Gds3AONH5XDEMb6G803UFyxyfMIZHmUkhB/V8W5Vl4tnbzkOTLmw6fGQSMReqNqEFCo
         yvmw==
X-Gm-Message-State: AJcUukflUOK8jcd7p81RuL04bA3WnLNaqgGtATogri6BfuEb9fNfyRaY
        +zaXm8IpJAKUanJnv44OaD5YuWbtqIQ=
X-Google-Smtp-Source: ALg8bN4TCJLW8WmWuvV6Hl2N0m4pm4lWgOGk7Jdm2/BDFB097vFoMh820Vfo+n9dH1nxqkpp04bRgA==
X-Received: by 2002:a2e:82d7:: with SMTP id n23-v6mr17684464ljh.143.1548150438715;
        Tue, 22 Jan 2019 01:47:18 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id k21-v6sm2753583ljc.15.2019.01.22.01.47.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 01:47:18 -0800 (PST)
Date:   Tue, 22 Jan 2019 11:47:05 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        linux@roeck-us.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: [RFC PATCH v1 10/13] gpio: Initial support for ROHM bd70528 GPIO
 block
Message-ID: <3ecb4970a13cc953c55b1270d697381686cd801f.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
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
---
 drivers/gpio/Kconfig        |  11 +++
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/gpio-bd70528.c | 192 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 204 insertions(+)
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
index 000000000000..684d6f744409
--- /dev/null
+++ b/drivers/gpio/gpio-bd70528.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 ROHM Semiconductors
+// gpio-bd70528.c ROHM BD70528MWV gpio driver
+
+#include <linux/gpio/driver.h>
+#include <linux/interrupt.h>
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
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
