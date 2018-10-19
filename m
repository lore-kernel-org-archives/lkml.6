Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED76ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF2D62145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2D62145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emutex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbeJTB21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 21:28:27 -0400
Received: from mr33.theemaillaundry.net ([176.9.125.106]:33346 "EHLO
        mr33.theemaillaundry.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbeJTB20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 21:28:26 -0400
X-Greylist: delayed 317 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Oct 2018 21:28:22 EDT
Received: from localhost (localhost [127.0.0.1])
        by mr33.theemaillaundry.net (Postfix) with ESMTP id 6BBCA51C1CE9;
        Fri, 19 Oct 2018 18:16:05 +0100 (IST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mr33.theemaillaundry.net
X-Virus-Scanned: amavisd-new at theemaillaundry.net
Received: from mr33.theemaillaundry.net ([127.0.0.1])
        by localhost (mr33.theemaillaundry.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XoR9WaBJmkAu; Fri, 19 Oct 2018 18:16:02 +0100 (IST)
Received: from statler.emutex.com (unknown [92.51.199.138])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mr33.theemaillaundry.net (Postfix) with ESMTPS id 8739151C10BA;
        Fri, 19 Oct 2018 18:16:02 +0100 (IST)
Received: from [10.10.68.81] (helo=dan-Latitude-E5450.emutex.com)
        by statler.emutex.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.84)
        (envelope-from <dan@emutex.com>)
        id 1gDYNV-0005CM-AQ; Fri, 19 Oct 2018 18:16:01 +0100
From:   Dan O'Donovan <dan@emutex.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org,
        Carlos Iglesias <carlos.iglesias@emutex.com>,
        Javier Arteaga <javier@emutex.com>,
        Dan O'Donovan <dan@emutex.com>
Subject: [PATCH v2 3/3] pinctrl: upboard: Add UP2 pinctrl and gpio driver
Date:   Fri, 19 Oct 2018 18:15:34 +0100
Message-Id: <1539969334-24577-4-git-send-email-dan@emutex.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539969334-24577-1-git-send-email-dan@emutex.com>
References: <20180421085009.28773-1-javier@emutex.com>
 <1539969334-24577-1-git-send-email-dan@emutex.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Javier Arteaga <javier@emutex.com>

The UP2 board features a Raspberry Pi compatible pin header (HAT) and a
board-specific expansion connector (EXHAT). Both expose assorted
functions from either the SoC (such as GPIO, I2C, SPI, UART...) or other
on-board devices (ADC, FPGA IP blocks...).

These lines are routed through an on-board FPGA. The platform controller
in its stock firmware provides register fields to change:

- Line enable (FPGA pins enabled / high impedance)
- Line direction (SoC driven / FPGA driven)

To enable using SoC GPIOs on the pin header, this arrangement requires
both configuring the platform controller, and updating the SoC pad
registers in sync.

Add a frontend pinctrl/GPIO driver that registers a new set of GPIO
lines for the header pins. When these are requested, the driver
propagates this request to the backend SoC pinctrl/GPIO driver by
grabbing a GPIO descriptor for the matching SoC GPIO line. The needed
mapping for this is retrieved via ACPI properties.

Signed-off-by: Javier Arteaga <javier@emutex.com>
Signed-off-by: Dan O'Donovan <dan@emutex.com>
---
 drivers/pinctrl/Kconfig           |  13 +
 drivers/pinctrl/Makefile          |   1 +
 drivers/pinctrl/pinctrl-upboard.c | 519 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 533 insertions(+)
 create mode 100644 drivers/pinctrl/pinctrl-upboard.c

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index e86752b..c65438f 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -338,6 +338,19 @@ config PINCTRL_OCELOT
 	select GENERIC_PINMUX_FUNCTIONS
 	select REGMAP_MMIO
 
+config PINCTRL_UPBOARD
+	tristate "UP Squared pinctrl and GPIO driver"
+	depends on ACPI
+	depends on MFD_UPBOARD
+	select PINMUX
+	help
+	  Pinctrl driver for the pin headers on the UP Squared board. It
+	  handles pin control for lines routed through the on-board FPGA and
+	  propagates changes to the SoC pinctrl to keep them in sync.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called pinctrl-upboard.
+
 source "drivers/pinctrl/actions/Kconfig"
 source "drivers/pinctrl/aspeed/Kconfig"
 source "drivers/pinctrl/bcm/Kconfig"
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 46ef9bd..cfe59b7 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_PINCTRL_ZYNQ)	+= pinctrl-zynq.o
 obj-$(CONFIG_PINCTRL_INGENIC)	+= pinctrl-ingenic.o
 obj-$(CONFIG_PINCTRL_RK805)	+= pinctrl-rk805.o
 obj-$(CONFIG_PINCTRL_OCELOT)	+= pinctrl-ocelot.o
+obj-$(CONFIG_PINCTRL_UPBOARD)	+= pinctrl-upboard.o
 
 obj-y				+= actions/
 obj-$(CONFIG_ARCH_ASPEED)	+= aspeed/
diff --git a/drivers/pinctrl/pinctrl-upboard.c b/drivers/pinctrl/pinctrl-upboard.c
new file mode 100644
index 0000000..b74383b
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-upboard.c
@@ -0,0 +1,519 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// UP Board pin controller driver
+//
+// Copyright (c) 2018, Emutex Ltd.
+//
+// Authors: Javier Arteaga <javier@emutex.com>
+//          Dan O'Donovan <dan@emutex.com>
+//
+
+#include <linux/acpi.h>
+#include <linux/gpio/consumer.h>
+#include <linux/gpio/driver.h>
+#include <linux/kernel.h>
+#include <linux/mfd/upboard.h>
+#include <linux/module.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/string.h>
+
+#include "core.h"
+
+struct upboard_pin {
+	struct regmap_field *func_en;
+	struct regmap_field *gpio_en;
+	struct regmap_field *gpio_dir;
+};
+
+struct upboard_pinctrl {
+	struct pinctrl_dev *pctldev;
+	struct gpio_chip chip;
+	unsigned int nsoc_gpios;
+	struct gpio_desc **soc_gpios;
+};
+
+enum upboard_func0_enables {
+	UPBOARD_I2C0_EN = 8,
+	UPBOARD_I2C1_EN = 9,
+};
+
+static const struct reg_field upboard_i2c0_reg =
+	REG_FIELD(UPBOARD_REG_FUNC_EN0, UPBOARD_I2C0_EN, UPBOARD_I2C0_EN);
+
+static const struct reg_field upboard_i2c1_reg =
+	REG_FIELD(UPBOARD_REG_FUNC_EN0, UPBOARD_I2C1_EN, UPBOARD_I2C1_EN);
+
+#define UPBOARD_BIT_TO_PIN(r, bit) \
+	((r) * UPBOARD_REGISTER_SIZE + (bit))
+
+/*
+ * UP Squared data
+ */
+
+#define UPBOARD_UP2_BIT_TO_PIN(r, id) (UPBOARD_BIT_TO_PIN(r, UPBOARD_UP2_##id))
+
+#define UPBOARD_UP2_PIN_ANON(r, bit)					\
+	{								\
+		.number = UPBOARD_BIT_TO_PIN(r, bit),			\
+	}
+
+#define UPBOARD_UP2_PIN_NAME(r, id)					\
+	{								\
+		.number = UPBOARD_UP2_BIT_TO_PIN(r, id),		\
+		.name = #id,						\
+	}
+
+#define UPBOARD_UP2_PIN_FUNC(r, id, data)				\
+	{								\
+		.number = UPBOARD_UP2_BIT_TO_PIN(r, id),		\
+		.name = #id,						\
+		.drv_data = (void *)(data),				\
+	}
+
+enum upboard_up2_reg0_bit {
+	UPBOARD_UP2_UART1_TXD,
+	UPBOARD_UP2_UART1_RXD,
+	UPBOARD_UP2_UART1_RTS,
+	UPBOARD_UP2_UART1_CTS,
+	UPBOARD_UP2_GPIO3,
+	UPBOARD_UP2_GPIO5,
+	UPBOARD_UP2_GPIO6,
+	UPBOARD_UP2_GPIO11,
+	UPBOARD_UP2_EXHAT_LVDS1n,
+	UPBOARD_UP2_EXHAT_LVDS1p,
+	UPBOARD_UP2_SPI2_TXD,
+	UPBOARD_UP2_SPI2_RXD,
+	UPBOARD_UP2_SPI2_FS1,
+	UPBOARD_UP2_SPI2_FS0,
+	UPBOARD_UP2_SPI2_CLK,
+	UPBOARD_UP2_SPI1_TXD,
+};
+
+enum upboard_up2_reg1_bit {
+	UPBOARD_UP2_SPI1_RXD,
+	UPBOARD_UP2_SPI1_FS1,
+	UPBOARD_UP2_SPI1_FS0,
+	UPBOARD_UP2_SPI1_CLK,
+	UPBOARD_UP2_BIT20,
+	UPBOARD_UP2_BIT21,
+	UPBOARD_UP2_BIT22,
+	UPBOARD_UP2_BIT23,
+	UPBOARD_UP2_PWM1,
+	UPBOARD_UP2_PWM0,
+	UPBOARD_UP2_EXHAT_LVDS0n,
+	UPBOARD_UP2_EXHAT_LVDS0p,
+	UPBOARD_UP2_I2C0_SCL,
+	UPBOARD_UP2_I2C0_SDA,
+	UPBOARD_UP2_I2C1_SCL,
+	UPBOARD_UP2_I2C1_SDA,
+};
+
+enum upboard_up2_reg2_bit {
+	UPBOARD_UP2_EXHAT_LVDS3n,
+	UPBOARD_UP2_EXHAT_LVDS3p,
+	UPBOARD_UP2_EXHAT_LVDS4n,
+	UPBOARD_UP2_EXHAT_LVDS4p,
+	UPBOARD_UP2_EXHAT_LVDS5n,
+	UPBOARD_UP2_EXHAT_LVDS5p,
+	UPBOARD_UP2_I2S_SDO,
+	UPBOARD_UP2_I2S_SDI,
+	UPBOARD_UP2_I2S_WS_SYNC,
+	UPBOARD_UP2_I2S_BCLK,
+	UPBOARD_UP2_EXHAT_LVDS6n,
+	UPBOARD_UP2_EXHAT_LVDS6p,
+	UPBOARD_UP2_EXHAT_LVDS7n,
+	UPBOARD_UP2_EXHAT_LVDS7p,
+	UPBOARD_UP2_EXHAT_LVDS2n,
+	UPBOARD_UP2_EXHAT_LVDS2p,
+};
+
+static struct pinctrl_pin_desc upboard_up2_pins[] = {
+	UPBOARD_UP2_PIN_NAME(0, UART1_TXD),
+	UPBOARD_UP2_PIN_NAME(0, UART1_RXD),
+	UPBOARD_UP2_PIN_NAME(0, UART1_RTS),
+	UPBOARD_UP2_PIN_NAME(0, UART1_CTS),
+	UPBOARD_UP2_PIN_NAME(0, GPIO3),
+	UPBOARD_UP2_PIN_NAME(0, GPIO5),
+	UPBOARD_UP2_PIN_NAME(0, GPIO6),
+	UPBOARD_UP2_PIN_NAME(0, GPIO11),
+	UPBOARD_UP2_PIN_NAME(0, EXHAT_LVDS1n),
+	UPBOARD_UP2_PIN_NAME(0, EXHAT_LVDS1p),
+	UPBOARD_UP2_PIN_NAME(0, SPI2_TXD),
+	UPBOARD_UP2_PIN_NAME(0, SPI2_RXD),
+	UPBOARD_UP2_PIN_NAME(0, SPI2_FS1),
+	UPBOARD_UP2_PIN_NAME(0, SPI2_FS0),
+	UPBOARD_UP2_PIN_NAME(0, SPI2_CLK),
+	UPBOARD_UP2_PIN_NAME(0, SPI1_TXD),
+	UPBOARD_UP2_PIN_NAME(1, SPI1_RXD),
+	UPBOARD_UP2_PIN_NAME(1, SPI1_FS1),
+	UPBOARD_UP2_PIN_NAME(1, SPI1_FS0),
+	UPBOARD_UP2_PIN_NAME(1, SPI1_CLK),
+	UPBOARD_UP2_PIN_ANON(1, 4),
+	UPBOARD_UP2_PIN_ANON(1, 5),
+	UPBOARD_UP2_PIN_ANON(1, 6),
+	UPBOARD_UP2_PIN_ANON(1, 7),
+	UPBOARD_UP2_PIN_NAME(1, PWM1),
+	UPBOARD_UP2_PIN_NAME(1, PWM0),
+	UPBOARD_UP2_PIN_NAME(1, EXHAT_LVDS0n),
+	UPBOARD_UP2_PIN_NAME(1, EXHAT_LVDS0p),
+	UPBOARD_UP2_PIN_FUNC(1, I2C0_SCL, &upboard_i2c0_reg),
+	UPBOARD_UP2_PIN_FUNC(1, I2C0_SDA, &upboard_i2c0_reg),
+	UPBOARD_UP2_PIN_FUNC(1, I2C1_SCL, &upboard_i2c1_reg),
+	UPBOARD_UP2_PIN_FUNC(1, I2C1_SDA, &upboard_i2c1_reg),
+	UPBOARD_UP2_PIN_NAME(2, EXHAT_LVDS3n),
+	UPBOARD_UP2_PIN_NAME(2, EXHAT_LVDS3p),
+	UPBOARD_UP2_PIN_NAME(2, EXHAT_LVDS4n),
+	UPBOARD_UP2_PIN_NAME(2, EXHAT_LVDS4p),
+	UPBOARD_UP2_PIN_NAME(2, EXHAT_LVDS5n),
+	UPBOARD_UP2_PIN_NAME(2, EXHAT_LVDS5p),
+	UPBOARD_UP2_PIN_NAME(2, I2S_SDO),
+	UPBOARD_UP2_PIN_NAME(2, I2S_SDI),
+	UPBOARD_UP2_PIN_NAME(2, I2S_WS_SYNC),
+	UPBOARD_UP2_PIN_NAME(2, I2S_BCLK),
+	UPBOARD_UP2_PIN_NAME(2, EXHAT_LVDS6n),
+	UPBOARD_UP2_PIN_NAME(2, EXHAT_LVDS6p),
+	UPBOARD_UP2_PIN_NAME(2, EXHAT_LVDS7n),
+	UPBOARD_UP2_PIN_NAME(2, EXHAT_LVDS7p),
+	UPBOARD_UP2_PIN_NAME(2, EXHAT_LVDS2n),
+	UPBOARD_UP2_PIN_NAME(2, EXHAT_LVDS2p),
+};
+
+static int upboard_get_functions_count(struct pinctrl_dev *pctldev)
+{
+	return 0;
+}
+
+static int upboard_get_function_groups(struct pinctrl_dev *pctldev,
+				       unsigned int selector,
+				       const char * const **groups,
+				       unsigned int *num_groups)
+{
+	*groups = NULL;
+	*num_groups = 0;
+	return 0;
+}
+
+static const char *upboard_get_function_name(struct pinctrl_dev *pctldev,
+					     unsigned int selector)
+{
+	return NULL;
+}
+
+static int upboard_set_mux(struct pinctrl_dev *pctldev, unsigned int function,
+			   unsigned int group)
+{
+	return 0;
+}
+
+static int upboard_gpio_request_enable(struct pinctrl_dev *pctldev,
+				       struct pinctrl_gpio_range *range,
+				       unsigned int pin)
+{
+	const struct pin_desc * const pd = pin_desc_get(pctldev, pin);
+	const struct upboard_pin *p;
+	int ret;
+
+	if (!pd)
+		return -EINVAL;
+	p = pd->drv_data;
+
+	/* if this pin has an associated function bit, disable it first */
+	if (p->func_en) {
+		ret = regmap_field_write(p->func_en, 0);
+		if (ret)
+			return ret;
+	}
+
+	if (p->gpio_en) {
+		ret = regmap_field_write(p->gpio_en, 1);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int upboard_gpio_set_direction(struct pinctrl_dev *pctldev,
+				      struct pinctrl_gpio_range *range,
+				      unsigned int pin, bool input)
+{
+	const struct pin_desc * const pd = pin_desc_get(pctldev, pin);
+	const struct upboard_pin *p;
+
+	if (!pd)
+		return -EINVAL;
+	p = pd->drv_data;
+
+	return regmap_field_write(p->gpio_dir, input);
+}
+
+static const struct pinmux_ops upboard_pinmux_ops = {
+	.get_functions_count = upboard_get_functions_count,
+	.get_function_groups = upboard_get_function_groups,
+	.get_function_name = upboard_get_function_name,
+	.set_mux = upboard_set_mux,
+	.gpio_request_enable = upboard_gpio_request_enable,
+	.gpio_set_direction = upboard_gpio_set_direction,
+};
+
+static int upboard_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	return 0;
+}
+
+static const char *upboard_get_group_name(struct pinctrl_dev *pctldev,
+					  unsigned int selector)
+{
+	return NULL;
+}
+
+static const struct pinctrl_ops upboard_pinctrl_ops = {
+	.get_groups_count = upboard_get_groups_count,
+	.get_group_name = upboard_get_group_name,
+};
+
+static struct pinctrl_desc upboard_up2_pinctrl_desc = {
+	.pins = upboard_up2_pins,
+	.npins = ARRAY_SIZE(upboard_up2_pins),
+	.pctlops = &upboard_pinctrl_ops,
+	.pmxops = &upboard_pinmux_ops,
+	.owner = THIS_MODULE,
+};
+
+static struct gpio_desc *upboard_offset_to_soc_gpio(struct gpio_chip *gc,
+						    unsigned int offset)
+{
+	struct upboard_pinctrl *pctrl =
+		container_of(gc, struct upboard_pinctrl, chip);
+
+	if (offset + 1 > pctrl->nsoc_gpios || !pctrl->soc_gpios[offset])
+		return ERR_PTR(-ENODEV);
+
+	return pctrl->soc_gpios[offset];
+}
+
+static int upboard_gpio_request(struct gpio_chip *gc, unsigned int offset)
+{
+	struct upboard_pinctrl *pctrl =
+		container_of(gc, struct upboard_pinctrl, chip);
+	struct gpio_desc *desc;
+	int ret;
+
+	ret = pinctrl_gpio_request(gc->base + offset);
+	if (ret)
+		return ret;
+
+	desc = devm_gpiod_get_index(gc->parent, "external", offset, GPIOD_ASIS);
+	if (IS_ERR(desc))
+		return PTR_ERR(desc);
+
+	pctrl->soc_gpios[offset] = desc;
+	return 0;
+}
+
+static void upboard_gpio_free(struct gpio_chip *gc, unsigned int offset)
+{
+	struct upboard_pinctrl *pctrl =
+		container_of(gc, struct upboard_pinctrl, chip);
+
+	if (offset + 1 > pctrl->nsoc_gpios || !pctrl->soc_gpios[offset])
+		return;
+
+	devm_gpiod_put(gc->parent, pctrl->soc_gpios[offset]);
+	pctrl->soc_gpios[offset] = NULL;
+
+	pinctrl_gpio_free(gc->base + offset);
+}
+
+static int upboard_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
+{
+	struct gpio_desc *desc = upboard_offset_to_soc_gpio(gc, offset);
+
+	if (IS_ERR(desc))
+		return PTR_ERR(desc);
+
+	return gpiod_get_direction(desc);
+}
+
+static int upboard_gpio_direction_input(struct gpio_chip *gc,
+					unsigned int offset)
+{
+	struct gpio_desc *desc = upboard_offset_to_soc_gpio(gc, offset);
+	int ret;
+
+	if (IS_ERR(desc))
+		return PTR_ERR(desc);
+
+	ret = gpiod_direction_input(desc);
+	if (ret)
+		return ret;
+
+	return pinctrl_gpio_direction_input(gc->base + offset);
+}
+
+static int upboard_gpio_direction_output(struct gpio_chip *gc,
+					 unsigned int offset, int value)
+{
+	struct gpio_desc *desc = upboard_offset_to_soc_gpio(gc, offset);
+	int ret;
+
+	if (IS_ERR(desc))
+		return PTR_ERR(desc);
+
+	ret = pinctrl_gpio_direction_output(gc->base + offset);
+	if (ret)
+		return ret;
+
+	return gpiod_direction_output(desc, value);
+}
+
+static int upboard_gpio_get_value(struct gpio_chip *gc, unsigned int offset)
+{
+	struct gpio_desc *desc = upboard_offset_to_soc_gpio(gc, offset);
+
+	if (IS_ERR(desc))
+		return PTR_ERR(desc);
+
+	return gpiod_get_value(desc);
+}
+
+static void upboard_gpio_set_value(struct gpio_chip *gc, unsigned int offset,
+				   int value)
+{
+	struct gpio_desc *desc = upboard_offset_to_soc_gpio(gc, offset);
+
+	if (IS_ERR(desc))
+		return;
+
+	gpiod_set_value(desc, value);
+}
+
+static struct gpio_chip upboard_gpio_chip = {
+	.label = "UP pin controller",
+	.owner = THIS_MODULE,
+	.request = upboard_gpio_request,
+	.free = upboard_gpio_free,
+	.get_direction = upboard_gpio_get_direction,
+	.direction_input = upboard_gpio_direction_input,
+	.direction_output = upboard_gpio_direction_output,
+	.get = upboard_gpio_get_value,
+	.set = upboard_gpio_set_value,
+	.base = -1,
+};
+
+static struct regmap_field *upboard_field_alloc(struct device *dev,
+						struct regmap *regmap,
+						unsigned int base,
+						unsigned int number)
+{
+	const unsigned int reg = number / UPBOARD_REGISTER_SIZE;
+	const unsigned int bit = number % UPBOARD_REGISTER_SIZE;
+	const struct reg_field field = {
+		.reg = base + reg,
+		.msb = bit,
+		.lsb = bit,
+	};
+
+	return devm_regmap_field_alloc(dev, regmap, field);
+}
+
+static int upboard_pinctrl_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pinctrl_desc *pctldesc;
+	struct upboard_pinctrl *pctrl;
+	struct upboard_pin *pins;
+	struct acpi_device *adev;
+	struct regmap *regmap;
+	unsigned int i;
+	int ret;
+
+	adev = ACPI_COMPANION(dev);
+	if (!adev || strcmp(acpi_device_hid(adev), "AANT0F01"))
+		return -ENODEV;
+
+	if (!dev->parent)
+		return -EINVAL;
+
+	regmap = dev_get_regmap(dev->parent, NULL);
+	if (!regmap)
+		return -EINVAL;
+
+	pctldesc = &upboard_up2_pinctrl_desc;
+	pctldesc->name = dev_name(dev);
+
+	pins = devm_kzalloc(dev, sizeof(*pins) * pctldesc->npins, GFP_KERNEL);
+	if (!pins)
+		return -ENOMEM;
+
+	for (i = 0; i < pctldesc->npins; i++) {
+		struct upboard_pin *pin = &pins[i];
+		const struct pinctrl_pin_desc *pd = &pctldesc->pins[i];
+
+		pin->func_en = NULL;
+		if (pd->drv_data) {
+			struct reg_field *field = pd->drv_data;
+
+			pin->func_en = devm_regmap_field_alloc(dev, regmap,
+							       *field);
+			if (IS_ERR(pin->func_en))
+				return PTR_ERR(pin->func_en);
+		}
+
+		pin->gpio_en = upboard_field_alloc(dev, regmap,
+						   UPBOARD_REG_GPIO_EN0, i);
+		if (IS_ERR(pin->gpio_en))
+			return PTR_ERR(pin->gpio_en);
+
+		pin->gpio_dir = upboard_field_alloc(dev, regmap,
+						    UPBOARD_REG_GPIO_DIR0, i);
+		if (IS_ERR(pin->gpio_dir))
+			return PTR_ERR(pin->gpio_dir);
+
+		((struct pinctrl_pin_desc *)pd)->drv_data = pin;
+	}
+
+	pctrl = devm_kzalloc(dev, sizeof(*pctrl), GFP_KERNEL);
+	if (!pctrl)
+		return -ENOMEM;
+
+	pctrl->chip = upboard_gpio_chip;
+	pctrl->chip.parent = dev;
+	pctrl->chip.ngpio = pctldesc->npins;
+
+	pctrl->nsoc_gpios = gpiod_count(dev, "external");
+	pctrl->soc_gpios = devm_kzalloc(dev,
+					pctrl->nsoc_gpios * sizeof(*pctrl->soc_gpios),
+					GFP_KERNEL);
+	if (!pctrl->soc_gpios)
+		return -ENOMEM;
+
+	pctrl->pctldev = devm_pinctrl_register(dev, pctldesc, pctrl);
+	if (IS_ERR(pctrl->pctldev))
+		return PTR_ERR(pctrl->pctldev);
+
+	ret = devm_gpiochip_add_data(dev, &pctrl->chip, &pctrl->chip);
+	if (ret)
+		return ret;
+
+	return gpiochip_add_pin_range(&pctrl->chip, pctldesc->name, 0, 0,
+				      pctldesc->npins);
+}
+
+static struct platform_driver upboard_pinctrl_driver = {
+	.driver = {
+		.name = "upboard-pinctrl",
+	},
+};
+
+module_platform_driver_probe(upboard_pinctrl_driver, upboard_pinctrl_probe);
+
+MODULE_ALIAS("platform:upboard-pinctrl");
+MODULE_AUTHOR("Javier Arteaga <javier@emutex.com>");
+MODULE_AUTHOR("Dan O'Donovan <dan@emutex.com>");
+MODULE_DESCRIPTION("UP Board pin control and GPIO driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4


------
This email has been scanned for spam and malware by The Email Laundry.

