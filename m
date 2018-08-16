Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBADC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB41E20C0D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Mm9Vb4dY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB41E20C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392366AbeHPTgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:36:36 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:42814 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404428AbeHPTf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:35:29 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/7] pinctrl: ingenic: Merge GPIO functionality
Date:   Thu, 16 Aug 2018 18:35:40 +0200
Message-Id: <20180816163544.9072-3-paul@crapouillou.net>
In-Reply-To: <20180816163544.9072-1-paul@crapouillou.net>
References: <20180816163544.9072-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1534437353; bh=rjVXZnZOMODohZa68QkEzs/DoPLL6WwNT16sRzF5PGA=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Mm9Vb4dY+xTXmWcYlfgU2KlGXdrL5/T3S9vXryXNxvG2c4rI2e9J5L3cFZD4u0R2GgBh6ZKS2Mr35/+/Rll1rxf9IW3sIiRxajzhKkBabAvM7KvH6DExmusw+xTm9A9IJgkC1JiAnwThe+2Nvs194hqC647n0hxc5L8CxolZBEw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge the code of the gpio-ingenic driver into the pinctrl-ingenic
driver.

The reason behind this, is that the same hardware block handles both pin
config / muxing and GPIO.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../bindings/pinctrl/ingenic,pinctrl.txt           |  38 ++-
 drivers/pinctrl/Kconfig                            |   2 +
 drivers/pinctrl/pinctrl-ingenic.c                  | 337 ++++++++++++++++++++-
 3 files changed, 365 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt
index ca313a7aeaff..40a6c5c67035 100644
--- a/Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt
@@ -25,11 +25,24 @@ Required properties:
  - reg: Address range of the pinctrl registers.
 
 
-GPIO sub-nodes
---------------
+Required properties for sub-nodes (GPIO chips):
+-----------------------------------------------
 
-The pinctrl node can have optional sub-nodes for the Ingenic GPIO driver;
-please refer to ../gpio/ingenic,gpio.txt.
+ - compatible: Must contain one of:
+    - "ingenic,jz4740-gpio"
+    - "ingenic,jz4770-gpio"
+    - "ingenic,jz4780-gpio"
+ - reg: The GPIO bank number.
+ - interrupt-controller: Marks the device node as an interrupt controller.
+ - interrupts: Interrupt specifier for the controllers interrupt.
+ - #interrupt-cells: Should be 2. Refer to
+   ../interrupt-controller/interrupts.txt for more details.
+ - gpio-controller: Marks the device node as a GPIO controller.
+ - #gpio-cells: Should be 2. The first cell is the GPIO number and the second
+    cell specifies GPIO flags, as defined in <dt-bindings/gpio/gpio.h>. Only the
+    GPIO_ACTIVE_HIGH and GPIO_ACTIVE_LOW flags are supported.
+ - gpio-ranges: Range of pins managed by the GPIO controller. Refer to
+   ../gpio/gpio.txt for more details.
 
 
 Example:
@@ -38,4 +51,21 @@ Example:
 pinctrl: pin-controller@10010000 {
 	compatible = "ingenic,jz4740-pinctrl";
 	reg = <0x10010000 0x400>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	gpa: gpio@0 {
+		compatible = "ingenic,jz4740-gpio";
+		reg = <0>;
+
+		gpio-controller;
+		gpio-ranges = <&pinctrl 0 0 32>;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <28>;
+	};
 };
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index dd50371225bc..20e368b8f54a 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -315,6 +315,8 @@ config PINCTRL_INGENIC
 	select GENERIC_PINCONF
 	select GENERIC_PINCTRL_GROUPS
 	select GENERIC_PINMUX_FUNCTIONS
+	select GPIOLIB
+	select GPIOLIB_IRQCHIP
 	select REGMAP_MMIO
 
 config PINCTRL_RK805
diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index 1d6d7c6aecfc..75115733144e 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -11,6 +11,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/of_device.h>
+#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
@@ -24,6 +25,9 @@
 #include "pinconf.h"
 #include "pinmux.h"
 
+#define GPIO_PIN	0x00
+#define GPIO_MSK	0x20
+
 #define JZ4740_GPIO_DATA	0x10
 #define JZ4740_GPIO_PULL_DIS	0x30
 #define JZ4740_GPIO_FUNC	0x40
@@ -33,7 +37,6 @@
 #define JZ4740_GPIO_FLAG	0x80
 
 #define JZ4770_GPIO_INT		0x10
-#define JZ4770_GPIO_MSK		0x20
 #define JZ4770_GPIO_PAT1	0x30
 #define JZ4770_GPIO_PAT0	0x40
 #define JZ4770_GPIO_FLAG	0x50
@@ -72,6 +75,13 @@ struct ingenic_pinctrl {
 	const struct ingenic_chip_info *info;
 };
 
+struct ingenic_gpio_chip {
+	struct ingenic_pinctrl *jzpc;
+	struct gpio_chip gc;
+	struct irq_chip irq_chip;
+	unsigned int irq, reg_base;
+};
+
 static const u32 jz4740_pull_ups[4] = {
 	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
 };
@@ -438,6 +448,235 @@ static const struct ingenic_chip_info jz4770_chip_info = {
 	.pull_downs = jz4770_pull_downs,
 };
 
+static u32 gpio_ingenic_read_reg(struct ingenic_gpio_chip *jzgc, u8 reg)
+{
+	unsigned int val;
+
+	regmap_read(jzgc->jzpc->map, jzgc->reg_base + reg, &val);
+
+	return (u32) val;
+}
+
+static void gpio_ingenic_set_bit(struct ingenic_gpio_chip *jzgc,
+		u8 reg, u8 offset, bool set)
+{
+	if (set)
+		reg = REG_SET(reg);
+	else
+		reg = REG_CLEAR(reg);
+
+	regmap_write(jzgc->jzpc->map, jzgc->reg_base + reg, BIT(offset));
+}
+
+static inline bool ingenic_gpio_get_value(struct ingenic_gpio_chip *jzgc,
+					  u8 offset)
+{
+	unsigned int val = gpio_ingenic_read_reg(jzgc, GPIO_PIN);
+
+	return !!(val & BIT(offset));
+}
+
+static void ingenic_gpio_set_value(struct ingenic_gpio_chip *jzgc,
+				   u8 offset, int value)
+{
+	if (jzgc->jzpc->version >= ID_JZ4770)
+		gpio_ingenic_set_bit(jzgc, JZ4770_GPIO_PAT0, offset, !!value);
+	else
+		gpio_ingenic_set_bit(jzgc, JZ4740_GPIO_DATA, offset, !!value);
+}
+
+static void irq_set_type(struct ingenic_gpio_chip *jzgc,
+		u8 offset, unsigned int type)
+{
+	u8 reg1, reg2;
+
+	if (jzgc->jzpc->version >= ID_JZ4770) {
+		reg1 = JZ4770_GPIO_PAT1;
+		reg2 = JZ4770_GPIO_PAT0;
+	} else {
+		reg1 = JZ4740_GPIO_TRIG;
+		reg2 = JZ4740_GPIO_DIR;
+	}
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+		gpio_ingenic_set_bit(jzgc, reg2, offset, true);
+		gpio_ingenic_set_bit(jzgc, reg1, offset, true);
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		gpio_ingenic_set_bit(jzgc, reg2, offset, false);
+		gpio_ingenic_set_bit(jzgc, reg1, offset, true);
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		gpio_ingenic_set_bit(jzgc, reg2, offset, true);
+		gpio_ingenic_set_bit(jzgc, reg1, offset, false);
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+	default:
+		gpio_ingenic_set_bit(jzgc, reg2, offset, false);
+		gpio_ingenic_set_bit(jzgc, reg1, offset, false);
+		break;
+	}
+}
+
+static void ingenic_gpio_irq_mask(struct irq_data *irqd)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
+	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
+
+	gpio_ingenic_set_bit(jzgc, GPIO_MSK, irqd->hwirq, true);
+}
+
+static void ingenic_gpio_irq_unmask(struct irq_data *irqd)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
+	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
+
+	gpio_ingenic_set_bit(jzgc, GPIO_MSK, irqd->hwirq, false);
+}
+
+static void ingenic_gpio_irq_enable(struct irq_data *irqd)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
+	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
+	int irq = irqd->hwirq;
+
+	if (jzgc->jzpc->version >= ID_JZ4770)
+		gpio_ingenic_set_bit(jzgc, JZ4770_GPIO_INT, irq, true);
+	else
+		gpio_ingenic_set_bit(jzgc, JZ4740_GPIO_SELECT, irq, true);
+
+	ingenic_gpio_irq_unmask(irqd);
+}
+
+static void ingenic_gpio_irq_disable(struct irq_data *irqd)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
+	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
+	int irq = irqd->hwirq;
+
+	ingenic_gpio_irq_mask(irqd);
+
+	if (jzgc->jzpc->version >= ID_JZ4770)
+		gpio_ingenic_set_bit(jzgc, JZ4770_GPIO_INT, irq, false);
+	else
+		gpio_ingenic_set_bit(jzgc, JZ4740_GPIO_SELECT, irq, false);
+}
+
+static void ingenic_gpio_irq_ack(struct irq_data *irqd)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
+	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
+	int irq = irqd->hwirq;
+	bool high;
+
+	if (irqd_get_trigger_type(irqd) == IRQ_TYPE_EDGE_BOTH) {
+		/*
+		 * Switch to an interrupt for the opposite edge to the one that
+		 * triggered the interrupt being ACKed.
+		 */
+		high = ingenic_gpio_get_value(jzgc, irq);
+		if (high)
+			irq_set_type(jzgc, irq, IRQ_TYPE_EDGE_FALLING);
+		else
+			irq_set_type(jzgc, irq, IRQ_TYPE_EDGE_RISING);
+	}
+
+	if (jzgc->jzpc->version >= ID_JZ4770)
+		gpio_ingenic_set_bit(jzgc, JZ4770_GPIO_FLAG, irq, false);
+	else
+		gpio_ingenic_set_bit(jzgc, JZ4740_GPIO_DATA, irq, true);
+}
+
+static int ingenic_gpio_irq_set_type(struct irq_data *irqd, unsigned int type)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
+	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_BOTH:
+	case IRQ_TYPE_EDGE_RISING:
+	case IRQ_TYPE_EDGE_FALLING:
+		irq_set_handler_locked(irqd, handle_edge_irq);
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+	case IRQ_TYPE_LEVEL_LOW:
+		irq_set_handler_locked(irqd, handle_level_irq);
+		break;
+	default:
+		irq_set_handler_locked(irqd, handle_bad_irq);
+	}
+
+	if (type == IRQ_TYPE_EDGE_BOTH) {
+		/*
+		 * The hardware does not support interrupts on both edges. The
+		 * best we can do is to set up a single-edge interrupt and then
+		 * switch to the opposing edge when ACKing the interrupt.
+		 */
+		bool high = ingenic_gpio_get_value(jzgc, irqd->hwirq);
+
+		type = high ? IRQ_TYPE_EDGE_FALLING : IRQ_TYPE_EDGE_RISING;
+	}
+
+	irq_set_type(jzgc, irqd->hwirq, type);
+	return 0;
+}
+
+static int ingenic_gpio_irq_set_wake(struct irq_data *irqd, unsigned int on)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
+	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
+
+	return irq_set_irq_wake(jzgc->irq, on);
+}
+
+static void ingenic_gpio_irq_handler(struct irq_desc *desc)
+{
+	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
+	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
+	struct irq_chip *irq_chip = irq_data_get_irq_chip(&desc->irq_data);
+	unsigned long flag, i;
+
+	chained_irq_enter(irq_chip, desc);
+
+	if (jzgc->jzpc->version >= ID_JZ4770)
+		flag = gpio_ingenic_read_reg(jzgc, JZ4770_GPIO_FLAG);
+	else
+		flag = gpio_ingenic_read_reg(jzgc, JZ4740_GPIO_FLAG);
+
+	for_each_set_bit(i, &flag, 32)
+		generic_handle_irq(irq_linear_revmap(gc->irq.domain, i));
+	chained_irq_exit(irq_chip, desc);
+}
+
+static void ingenic_gpio_set(struct gpio_chip *gc,
+		unsigned int offset, int value)
+{
+	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
+
+	ingenic_gpio_set_value(jzgc, offset, value);
+}
+
+static int ingenic_gpio_get(struct gpio_chip *gc, unsigned int offset)
+{
+	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
+
+	return (int) ingenic_gpio_get_value(jzgc, offset);
+}
+
+static int ingenic_gpio_direction_input(struct gpio_chip *gc,
+		unsigned int offset)
+{
+	return pinctrl_gpio_direction_input(gc->base + offset);
+}
+
+static int ingenic_gpio_direction_output(struct gpio_chip *gc,
+		unsigned int offset, int value)
+{
+	ingenic_gpio_set(gc, offset, value);
+	return pinctrl_gpio_direction_output(gc->base + offset);
+}
+
 static inline void ingenic_config_pin(struct ingenic_pinctrl *jzpc,
 		unsigned int pin, u8 reg, bool set)
 {
@@ -479,7 +718,7 @@ static int ingenic_pinmux_set_pin_fn(struct ingenic_pinctrl *jzpc,
 
 	if (jzpc->version >= ID_JZ4770) {
 		ingenic_config_pin(jzpc, pin, JZ4770_GPIO_INT, false);
-		ingenic_config_pin(jzpc, pin, JZ4770_GPIO_MSK, false);
+		ingenic_config_pin(jzpc, pin, GPIO_MSK, false);
 		ingenic_config_pin(jzpc, pin, JZ4770_GPIO_PAT1, func & 0x2);
 		ingenic_config_pin(jzpc, pin, JZ4770_GPIO_PAT0, func & 0x1);
 	} else {
@@ -532,7 +771,7 @@ static int ingenic_pinmux_gpio_set_direction(struct pinctrl_dev *pctldev,
 
 	if (jzpc->version >= ID_JZ4770) {
 		ingenic_config_pin(jzpc, pin, JZ4770_GPIO_INT, false);
-		ingenic_config_pin(jzpc, pin, JZ4770_GPIO_MSK, true);
+		ingenic_config_pin(jzpc, pin, GPIO_MSK, true);
 		ingenic_config_pin(jzpc, pin, JZ4770_GPIO_PAT1, input);
 	} else {
 		ingenic_config_pin(jzpc, pin, JZ4740_GPIO_SELECT, false);
@@ -717,6 +956,87 @@ static const struct of_device_id ingenic_pinctrl_of_match[] = {
 	{},
 };
 
+static const struct of_device_id ingenic_gpio_of_match[] __initconst = {
+	{ .compatible = "ingenic,jz4740-gpio", },
+	{ .compatible = "ingenic,jz4770-gpio", },
+	{ .compatible = "ingenic,jz4780-gpio", },
+	{},
+};
+
+static int __init ingenic_gpio_probe(struct ingenic_pinctrl *jzpc,
+				     struct device_node *node)
+{
+	struct ingenic_gpio_chip *jzgc;
+	struct device *dev = jzpc->dev;
+	unsigned int bank;
+	int err;
+
+	err = of_property_read_u32(node, "reg", &bank);
+	if (err) {
+		dev_err(dev, "Cannot read \"reg\" property: %i\n", err);
+		return err;
+	}
+
+	jzgc = devm_kzalloc(dev, sizeof(*jzgc), GFP_KERNEL);
+	if (!jzgc)
+		return -ENOMEM;
+
+	jzgc->jzpc = jzpc;
+	jzgc->reg_base = bank * 0x100;
+
+	jzgc->gc.label = devm_kasprintf(dev, GFP_KERNEL, "GPIO%c", 'A' + bank);
+	if (!jzgc->gc.label)
+		return -ENOMEM;
+
+	/* DO NOT EXPAND THIS: FOR BACKWARD GPIO NUMBERSPACE COMPATIBIBILITY
+	 * ONLY: WORK TO TRANSITION CONSUMERS TO USE THE GPIO DESCRIPTOR API IN
+	 * <linux/gpio/consumer.h> INSTEAD.
+	 */
+	jzgc->gc.base = bank * 32;
+
+	jzgc->gc.ngpio = 32;
+	jzgc->gc.parent = dev;
+	jzgc->gc.of_node = node;
+	jzgc->gc.owner = THIS_MODULE;
+
+	jzgc->gc.set = ingenic_gpio_set;
+	jzgc->gc.get = ingenic_gpio_get;
+	jzgc->gc.direction_input = ingenic_gpio_direction_input;
+	jzgc->gc.direction_output = ingenic_gpio_direction_output;
+
+	if (of_property_read_bool(node, "gpio-ranges")) {
+		jzgc->gc.request = gpiochip_generic_request;
+		jzgc->gc.free = gpiochip_generic_free;
+	}
+
+	err = devm_gpiochip_add_data(dev, &jzgc->gc, jzgc);
+	if (err)
+		return err;
+
+	jzgc->irq = irq_of_parse_and_map(node, 0);
+	if (!jzgc->irq)
+		return -EINVAL;
+
+	jzgc->irq_chip.name = jzgc->gc.label;
+	jzgc->irq_chip.irq_enable = ingenic_gpio_irq_enable;
+	jzgc->irq_chip.irq_disable = ingenic_gpio_irq_disable;
+	jzgc->irq_chip.irq_unmask = ingenic_gpio_irq_unmask;
+	jzgc->irq_chip.irq_mask = ingenic_gpio_irq_mask;
+	jzgc->irq_chip.irq_ack = ingenic_gpio_irq_ack;
+	jzgc->irq_chip.irq_set_type = ingenic_gpio_irq_set_type;
+	jzgc->irq_chip.irq_set_wake = ingenic_gpio_irq_set_wake;
+	jzgc->irq_chip.flags = IRQCHIP_MASK_ON_SUSPEND;
+
+	err = gpiochip_irqchip_add(&jzgc->gc, &jzgc->irq_chip, 0,
+			handle_level_irq, IRQ_TYPE_NONE);
+	if (err)
+		return err;
+
+	gpiochip_set_chained_irqchip(&jzgc->gc, &jzgc->irq_chip,
+			jzgc->irq, ingenic_gpio_irq_handler);
+	return 0;
+}
+
 static int __init ingenic_pinctrl_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -727,6 +1047,7 @@ static int __init ingenic_pinctrl_probe(struct platform_device *pdev)
 	const struct of_device_id *of_id = of_match_device(
 			ingenic_pinctrl_of_match, dev);
 	const struct ingenic_chip_info *chip_info;
+	struct device_node *node;
 	unsigned int i;
 	int err;
 
@@ -815,11 +1136,11 @@ static int __init ingenic_pinctrl_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, jzpc->map);
 
-	if (dev->of_node) {
-		err = of_platform_populate(dev->of_node, NULL, NULL, dev);
-		if (err) {
-			dev_err(dev, "Failed to probe GPIO devices\n");
-			return err;
+	for_each_child_of_node(dev->of_node, node) {
+		if (of_match_node(ingenic_gpio_of_match, node)) {
+			err = ingenic_gpio_probe(jzpc, node);
+			if (err)
+				return err;
 		}
 	}
 
-- 
2.11.0

