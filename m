Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB622C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7C520C0D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="RAnKk9mE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E7C520C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404474AbeHPTfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:35:36 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:43552 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404445AbeHPTfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:35:31 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 7/7] gpio: ingenic: Remove driver
Date:   Thu, 16 Aug 2018 18:35:44 +0200
Message-Id: <20180816163544.9072-7-paul@crapouillou.net>
In-Reply-To: <20180816163544.9072-1-paul@crapouillou.net>
References: <20180816163544.9072-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1534437356; bh=9iQZXgBIn1TFrSeTKLVzCcqToawDARoCeYUv+qX5q1A=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=RAnKk9mEyyS9jif88ZhkfO+6ZDW2jkkYTIgjcQQO0DLQQG3nSYt+N3CeFEz8hN0cN1WVqRpgUUrREP9VNIWomRNVTi6yOwzm/XgaVQdnBcbWTHd5v3nbgE5ZXGva4lDUT5aYreU7LWSUIOFpPcYAM0vJs8lCXLDqyn9qvInDPzo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pinctrl-ingenic driver is now handling the GPIO chips directly.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../devicetree/bindings/gpio/ingenic,gpio.txt      |  46 ---
 drivers/gpio/Kconfig                               |  11 -
 drivers/gpio/Makefile                              |   1 -
 drivers/gpio/gpio-ingenic.c                        | 392 ---------------------
 4 files changed, 450 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
 delete mode 100644 drivers/gpio/gpio-ingenic.c

diff --git a/Documentation/devicetree/bindings/gpio/ingenic,gpio.txt b/Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
deleted file mode 100644
index 7988aeb725f4..000000000000
--- a/Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
+++ /dev/null
@@ -1,46 +0,0 @@
-Ingenic jz47xx GPIO controller
-
-That the Ingenic GPIO driver node must be a sub-node of the Ingenic pinctrl
-driver node.
-
-Required properties:
---------------------
-
- - compatible: Must contain one of:
-    - "ingenic,jz4740-gpio"
-    - "ingenic,jz4770-gpio"
-    - "ingenic,jz4780-gpio"
- - reg: The GPIO bank number.
- - interrupt-controller: Marks the device node as an interrupt controller.
- - interrupts: Interrupt specifier for the controllers interrupt.
- - #interrupt-cells: Should be 2. Refer to
-   ../interrupt-controller/interrupts.txt for more details.
- - gpio-controller: Marks the device node as a GPIO controller.
- - #gpio-cells: Should be 2. The first cell is the GPIO number and the second
-    cell specifies GPIO flags, as defined in <dt-bindings/gpio/gpio.h>. Only the
-    GPIO_ACTIVE_HIGH and GPIO_ACTIVE_LOW flags are supported.
- - gpio-ranges: Range of pins managed by the GPIO controller. Refer to
-   'gpio.txt' in this directory for more details.
-
-Example:
---------
-
-&pinctrl {
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	gpa: gpio@0 {
-		compatible = "ingenic,jz4740-gpio";
-		reg = <0>;
-
-		gpio-controller;
-		gpio-ranges = <&pinctrl 0 0 32>;
-		#gpio-cells = <2>;
-
-		interrupt-controller;
-		#interrupt-cells = <2>;
-
-		interrupt-parent = <&intc>;
-		interrupts = <28>;
-	};
-};
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 71c0ab46f216..d8c9026010b7 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -267,17 +267,6 @@ config GPIO_ICH
 
 	  If unsure, say N.
 
-config GPIO_INGENIC
-	tristate "Ingenic JZ47xx SoCs GPIO support"
-	depends on OF
-	depends on MACH_INGENIC || COMPILE_TEST
-	select GPIOLIB_IRQCHIP
-	help
-	  Say yes here to support the GPIO functionality present on the
-	  JZ4740 and JZ4780 SoCs from Ingenic.
-
-	  If unsure, say N.
-
 config GPIO_IOP
 	tristate "Intel IOP GPIO"
 	depends on ARCH_IOP32X || ARCH_IOP33X || COMPILE_TEST
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 1324c8f966a7..b2b07c787743 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -57,7 +57,6 @@ obj-$(CONFIG_GPIO_GRGPIO)	+= gpio-grgpio.o
 obj-$(CONFIG_GPIO_HLWD)		+= gpio-hlwd.o
 obj-$(CONFIG_HTC_EGPIO)		+= gpio-htc-egpio.o
 obj-$(CONFIG_GPIO_ICH)		+= gpio-ich.o
-obj-$(CONFIG_GPIO_INGENIC)	+= gpio-ingenic.o
 obj-$(CONFIG_GPIO_IOP)		+= gpio-iop.o
 obj-$(CONFIG_GPIO_IT87)		+= gpio-it87.o
 obj-$(CONFIG_GPIO_JANZ_TTL)	+= gpio-janz-ttl.o
diff --git a/drivers/gpio/gpio-ingenic.c b/drivers/gpio/gpio-ingenic.c
deleted file mode 100644
index e738e384a5ca..000000000000
--- a/drivers/gpio/gpio-ingenic.c
+++ /dev/null
@@ -1,392 +0,0 @@
-/*
- * Ingenic JZ47xx GPIO driver
- *
- * Copyright (c) 2017 Paul Cercueil <paul@crapouillou.net>
- *
- * License terms: GNU General Public License (GPL) version 2
- */
-
-#include <linux/gpio/driver.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
-#include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
-#include <linux/pinctrl/consumer.h>
-#include <linux/regmap.h>
-
-#define GPIO_PIN	0x00
-#define GPIO_MSK	0x20
-
-#define JZ4740_GPIO_DATA	0x10
-#define JZ4740_GPIO_SELECT	0x50
-#define JZ4740_GPIO_DIR		0x60
-#define JZ4740_GPIO_TRIG	0x70
-#define JZ4740_GPIO_FLAG	0x80
-
-#define JZ4770_GPIO_INT		0x10
-#define JZ4770_GPIO_PAT1	0x30
-#define JZ4770_GPIO_PAT0	0x40
-#define JZ4770_GPIO_FLAG	0x50
-
-#define REG_SET(x) ((x) + 0x4)
-#define REG_CLEAR(x) ((x) + 0x8)
-
-enum jz_version {
-	ID_JZ4740,
-	ID_JZ4770,
-	ID_JZ4780,
-};
-
-struct ingenic_gpio_chip {
-	struct regmap *map;
-	struct gpio_chip gc;
-	struct irq_chip irq_chip;
-	unsigned int irq, reg_base;
-	enum jz_version version;
-};
-
-static u32 gpio_ingenic_read_reg(struct ingenic_gpio_chip *jzgc, u8 reg)
-{
-	unsigned int val;
-
-	regmap_read(jzgc->map, jzgc->reg_base + reg, &val);
-
-	return (u32) val;
-}
-
-static void gpio_ingenic_set_bit(struct ingenic_gpio_chip *jzgc,
-		u8 reg, u8 offset, bool set)
-{
-	if (set)
-		reg = REG_SET(reg);
-	else
-		reg = REG_CLEAR(reg);
-
-	regmap_write(jzgc->map, jzgc->reg_base + reg, BIT(offset));
-}
-
-static inline bool gpio_get_value(struct ingenic_gpio_chip *jzgc, u8 offset)
-{
-	unsigned int val = gpio_ingenic_read_reg(jzgc, GPIO_PIN);
-
-	return !!(val & BIT(offset));
-}
-
-static void gpio_set_value(struct ingenic_gpio_chip *jzgc, u8 offset, int value)
-{
-	if (jzgc->version >= ID_JZ4770)
-		gpio_ingenic_set_bit(jzgc, JZ4770_GPIO_PAT0, offset, !!value);
-	else
-		gpio_ingenic_set_bit(jzgc, JZ4740_GPIO_DATA, offset, !!value);
-}
-
-static void irq_set_type(struct ingenic_gpio_chip *jzgc,
-		u8 offset, unsigned int type)
-{
-	u8 reg1, reg2;
-
-	if (jzgc->version >= ID_JZ4770) {
-		reg1 = JZ4770_GPIO_PAT1;
-		reg2 = JZ4770_GPIO_PAT0;
-	} else {
-		reg1 = JZ4740_GPIO_TRIG;
-		reg2 = JZ4740_GPIO_DIR;
-	}
-
-	switch (type) {
-	case IRQ_TYPE_EDGE_RISING:
-		gpio_ingenic_set_bit(jzgc, reg2, offset, true);
-		gpio_ingenic_set_bit(jzgc, reg1, offset, true);
-		break;
-	case IRQ_TYPE_EDGE_FALLING:
-		gpio_ingenic_set_bit(jzgc, reg2, offset, false);
-		gpio_ingenic_set_bit(jzgc, reg1, offset, true);
-		break;
-	case IRQ_TYPE_LEVEL_HIGH:
-		gpio_ingenic_set_bit(jzgc, reg2, offset, true);
-		gpio_ingenic_set_bit(jzgc, reg1, offset, false);
-		break;
-	case IRQ_TYPE_LEVEL_LOW:
-	default:
-		gpio_ingenic_set_bit(jzgc, reg2, offset, false);
-		gpio_ingenic_set_bit(jzgc, reg1, offset, false);
-		break;
-	}
-}
-
-static void ingenic_gpio_irq_mask(struct irq_data *irqd)
-{
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
-	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
-
-	gpio_ingenic_set_bit(jzgc, GPIO_MSK, irqd->hwirq, true);
-}
-
-static void ingenic_gpio_irq_unmask(struct irq_data *irqd)
-{
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
-	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
-
-	gpio_ingenic_set_bit(jzgc, GPIO_MSK, irqd->hwirq, false);
-}
-
-static void ingenic_gpio_irq_enable(struct irq_data *irqd)
-{
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
-	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
-	int irq = irqd->hwirq;
-
-	if (jzgc->version >= ID_JZ4770)
-		gpio_ingenic_set_bit(jzgc, JZ4770_GPIO_INT, irq, true);
-	else
-		gpio_ingenic_set_bit(jzgc, JZ4740_GPIO_SELECT, irq, true);
-
-	ingenic_gpio_irq_unmask(irqd);
-}
-
-static void ingenic_gpio_irq_disable(struct irq_data *irqd)
-{
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
-	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
-	int irq = irqd->hwirq;
-
-	ingenic_gpio_irq_mask(irqd);
-
-	if (jzgc->version >= ID_JZ4770)
-		gpio_ingenic_set_bit(jzgc, JZ4770_GPIO_INT, irq, false);
-	else
-		gpio_ingenic_set_bit(jzgc, JZ4740_GPIO_SELECT, irq, false);
-}
-
-static void ingenic_gpio_irq_ack(struct irq_data *irqd)
-{
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
-	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
-	int irq = irqd->hwirq;
-	bool high;
-
-	if (irqd_get_trigger_type(irqd) == IRQ_TYPE_EDGE_BOTH) {
-		/*
-		 * Switch to an interrupt for the opposite edge to the one that
-		 * triggered the interrupt being ACKed.
-		 */
-		high = gpio_get_value(jzgc, irq);
-		if (high)
-			irq_set_type(jzgc, irq, IRQ_TYPE_EDGE_FALLING);
-		else
-			irq_set_type(jzgc, irq, IRQ_TYPE_EDGE_RISING);
-	}
-
-	if (jzgc->version >= ID_JZ4770)
-		gpio_ingenic_set_bit(jzgc, JZ4770_GPIO_FLAG, irq, false);
-	else
-		gpio_ingenic_set_bit(jzgc, JZ4740_GPIO_DATA, irq, true);
-}
-
-static int ingenic_gpio_irq_set_type(struct irq_data *irqd, unsigned int type)
-{
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
-	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
-
-	switch (type) {
-	case IRQ_TYPE_EDGE_BOTH:
-	case IRQ_TYPE_EDGE_RISING:
-	case IRQ_TYPE_EDGE_FALLING:
-		irq_set_handler_locked(irqd, handle_edge_irq);
-		break;
-	case IRQ_TYPE_LEVEL_HIGH:
-	case IRQ_TYPE_LEVEL_LOW:
-		irq_set_handler_locked(irqd, handle_level_irq);
-		break;
-	default:
-		irq_set_handler_locked(irqd, handle_bad_irq);
-	}
-
-	if (type == IRQ_TYPE_EDGE_BOTH) {
-		/*
-		 * The hardware does not support interrupts on both edges. The
-		 * best we can do is to set up a single-edge interrupt and then
-		 * switch to the opposing edge when ACKing the interrupt.
-		 */
-		bool high = gpio_get_value(jzgc, irqd->hwirq);
-
-		type = high ? IRQ_TYPE_EDGE_FALLING : IRQ_TYPE_EDGE_RISING;
-	}
-
-	irq_set_type(jzgc, irqd->hwirq, type);
-	return 0;
-}
-
-static int ingenic_gpio_irq_set_wake(struct irq_data *irqd, unsigned int on)
-{
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
-	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
-
-	return irq_set_irq_wake(jzgc->irq, on);
-}
-
-static void ingenic_gpio_irq_handler(struct irq_desc *desc)
-{
-	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
-	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
-	struct irq_chip *irq_chip = irq_data_get_irq_chip(&desc->irq_data);
-	unsigned long flag, i;
-
-	chained_irq_enter(irq_chip, desc);
-
-	if (jzgc->version >= ID_JZ4770)
-		flag = gpio_ingenic_read_reg(jzgc, JZ4770_GPIO_FLAG);
-	else
-		flag = gpio_ingenic_read_reg(jzgc, JZ4740_GPIO_FLAG);
-
-	for_each_set_bit(i, &flag, 32)
-		generic_handle_irq(irq_linear_revmap(gc->irq.domain, i));
-	chained_irq_exit(irq_chip, desc);
-}
-
-static void ingenic_gpio_set(struct gpio_chip *gc,
-		unsigned int offset, int value)
-{
-	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
-
-	gpio_set_value(jzgc, offset, value);
-}
-
-static int ingenic_gpio_get(struct gpio_chip *gc, unsigned int offset)
-{
-	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
-
-	return (int) gpio_get_value(jzgc, offset);
-}
-
-static int ingenic_gpio_direction_input(struct gpio_chip *gc,
-		unsigned int offset)
-{
-	return pinctrl_gpio_direction_input(gc->base + offset);
-}
-
-static int ingenic_gpio_direction_output(struct gpio_chip *gc,
-		unsigned int offset, int value)
-{
-	ingenic_gpio_set(gc, offset, value);
-	return pinctrl_gpio_direction_output(gc->base + offset);
-}
-
-static const struct of_device_id ingenic_gpio_of_match[] = {
-	{ .compatible = "ingenic,jz4740-gpio", .data = (void *)ID_JZ4740 },
-	{ .compatible = "ingenic,jz4770-gpio", .data = (void *)ID_JZ4770 },
-	{ .compatible = "ingenic,jz4780-gpio", .data = (void *)ID_JZ4780 },
-	{},
-};
-MODULE_DEVICE_TABLE(of, ingenic_gpio_of_match);
-
-static int ingenic_gpio_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct ingenic_gpio_chip *jzgc;
-	u32 bank;
-	int err;
-
-	jzgc = devm_kzalloc(dev, sizeof(*jzgc), GFP_KERNEL);
-	if (!jzgc)
-		return -ENOMEM;
-
-	jzgc->map = dev_get_drvdata(dev->parent);
-	if (!jzgc->map) {
-		dev_err(dev, "Cannot get parent regmap\n");
-		return -ENXIO;
-	}
-
-	err = of_property_read_u32(dev->of_node, "reg", &bank);
-	if (err) {
-		dev_err(dev, "Cannot read \"reg\" property: %i\n", err);
-		return err;
-	}
-
-	jzgc->reg_base = bank * 0x100;
-
-	jzgc->gc.label = devm_kasprintf(dev, GFP_KERNEL, "GPIO%c", 'A' + bank);
-	if (!jzgc->gc.label)
-		return -ENOMEM;
-
-	/* DO NOT EXPAND THIS: FOR BACKWARD GPIO NUMBERSPACE COMPATIBIBILITY
-	 * ONLY: WORK TO TRANSITION CONSUMERS TO USE THE GPIO DESCRIPTOR API IN
-	 * <linux/gpio/consumer.h> INSTEAD.
-	 */
-	jzgc->gc.base = bank * 32;
-
-	jzgc->gc.ngpio = 32;
-	jzgc->gc.parent = dev;
-	jzgc->gc.of_node = dev->of_node;
-	jzgc->gc.owner = THIS_MODULE;
-	jzgc->version = (enum jz_version)of_device_get_match_data(dev);
-
-	jzgc->gc.set = ingenic_gpio_set;
-	jzgc->gc.get = ingenic_gpio_get;
-	jzgc->gc.direction_input = ingenic_gpio_direction_input;
-	jzgc->gc.direction_output = ingenic_gpio_direction_output;
-
-	if (of_property_read_bool(dev->of_node, "gpio-ranges")) {
-		jzgc->gc.request = gpiochip_generic_request;
-		jzgc->gc.free = gpiochip_generic_free;
-	}
-
-	err = devm_gpiochip_add_data(dev, &jzgc->gc, jzgc);
-	if (err)
-		return err;
-
-	jzgc->irq = irq_of_parse_and_map(dev->of_node, 0);
-	if (!jzgc->irq)
-		return -EINVAL;
-
-	jzgc->irq_chip.name = jzgc->gc.label;
-	jzgc->irq_chip.irq_enable = ingenic_gpio_irq_enable;
-	jzgc->irq_chip.irq_disable = ingenic_gpio_irq_disable;
-	jzgc->irq_chip.irq_unmask = ingenic_gpio_irq_unmask;
-	jzgc->irq_chip.irq_mask = ingenic_gpio_irq_mask;
-	jzgc->irq_chip.irq_ack = ingenic_gpio_irq_ack;
-	jzgc->irq_chip.irq_set_type = ingenic_gpio_irq_set_type;
-	jzgc->irq_chip.irq_set_wake = ingenic_gpio_irq_set_wake;
-	jzgc->irq_chip.flags = IRQCHIP_MASK_ON_SUSPEND;
-
-	err = gpiochip_irqchip_add(&jzgc->gc, &jzgc->irq_chip, 0,
-			handle_level_irq, IRQ_TYPE_NONE);
-	if (err)
-		return err;
-
-	gpiochip_set_chained_irqchip(&jzgc->gc, &jzgc->irq_chip,
-			jzgc->irq, ingenic_gpio_irq_handler);
-	return 0;
-}
-
-static int ingenic_gpio_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
-static struct platform_driver ingenic_gpio_driver = {
-	.driver = {
-		.name = "gpio-ingenic",
-		.of_match_table = of_match_ptr(ingenic_gpio_of_match),
-	},
-	.probe = ingenic_gpio_probe,
-	.remove = ingenic_gpio_remove,
-};
-
-static int __init ingenic_gpio_drv_register(void)
-{
-	return platform_driver_register(&ingenic_gpio_driver);
-}
-subsys_initcall(ingenic_gpio_drv_register);
-
-static void __exit ingenic_gpio_drv_unregister(void)
-{
-	platform_driver_unregister(&ingenic_gpio_driver);
-}
-module_exit(ingenic_gpio_drv_unregister);
-
-MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
-MODULE_DESCRIPTION("Ingenic JZ47xx GPIO driver");
-MODULE_LICENSE("GPL");
-- 
2.11.0

