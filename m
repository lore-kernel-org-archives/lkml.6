Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752902AbeDUIu7 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 04:50:59 -0400
Received: from bert.emutex.com ([91.103.1.109]:53868 "EHLO bert.emutex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751850AbeDUIuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 04:50:52 -0400
From: Javier Arteaga <javier@emutex.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Javier Arteaga <javier@emutex.com>, "Dan O'Donovan" <dan@emutex.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH RESEND 3/3] pinctrl: upboard: Add UP2 pinctrl and gpio driver
Date: Sat, 21 Apr 2018 09:50:09 +0100
Message-Id: <20180421085009.28773-4-javier@emutex.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180421085009.28773-1-javier@emutex.com>
References: <20180421085009.28773-1-javier@emutex.com>
X-Spam-Score: -1.0 (-)
X-Spam-Report: Spam detection software, running on the system "statler.emutex.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  The UP2 board features a Raspberry Pi compatible pin header
    (HAT) and a board-specific expansion connector (EXHAT). Both expose assorted
    functions from either the SoC (such as GPIO, I2C, SPI, UART...) or other
   on-board devices (ADC, FPGA IP blocks...). [...]
 Content analysis details:   (-1.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
  0.0 T_FILL_THIS_FORM_SHORT Fill in a short form with personal information
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---

For reference, here's the relevant ASL from the UP2 platform controller.
GPO0..GPO3 are the INT3452 GPIO community controllers on Apollo Lake.

	Device (PCTL)
	{
	    Name (_HID, "AANT0F01")
	    Name (_DDN, "UP Squared FPGA-based Pin Controller")
	    [...]
	    Name (_CRS, ResourceTemplate ()
	    {
	        /*
	         * FPGA SoC GPIO Pins 0-47
	         * These GPIOs are ordered relative to the corresponding
	         * bit position in the FPGA pin direction "DIR" register
	         */
	        GpioIo (Exclusive, PullDefault, 0, 0, IoRestrictionNone, "\\_SB.GPO0", 0) {43}
	        GpioIo (Exclusive, PullDefault, 0, 0, IoRestrictionNone, "\\_SB.GPO0", 0) {42}
	        GpioIo (Exclusive, PullDefault, 0, 0, IoRestrictionNone, "\\_SB.GPO0", 0) {44}
	        [...]
	        GpioIo (Exclusive, PullDefault, 0, 0, IoRestrictionNone, "\\_SB.GPO1", 0) {44}
	    })
	
	    Name (_DSD, Package ()
	    {
	        ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
	        Package ()
	        {
	            Package () { "external-gpios", Package() { ^PCTL,  0, 0, 0,
	                                                       ^PCTL,  1, 0, 0,
	                                                       ^PCTL,  2, 0, 0,
	                                                       [...]
	                                                       ^PCTL, 47, 0, 0 }},
	               Package () { "enable-gpio",  Package() { ^PCTL, 48, 0, 0 }},
	               Package () { "strobe-gpio",  Package() { ^PCTL, 49, 0, 0 }},
	               Package () { "datain-gpio",  Package() { ^PCTL, 50, 0, 0 }},
	               Package () { "clear-gpio",   Package() { ^PCTL, 51, 0, 0 }},
	               Package () { "reset-gpio",   Package() { ^PCTL, 52, 0, 0 }},
	               Package () { "dataout-gpio", Package() { ^PCTL, 53, 0, 0 }},
	        }
	    })

 drivers/mfd/upboard.c             |   1 +
 drivers/pinctrl/Kconfig           |  13 +
 drivers/pinctrl/Makefile          |   1 +
 drivers/pinctrl/pinctrl-upboard.c | 523 ++++++++++++++++++++++++++++++
 4 files changed, 538 insertions(+)
 create mode 100644 drivers/pinctrl/pinctrl-upboard.c

diff --git a/drivers/mfd/upboard.c b/drivers/mfd/upboard.c
index 6e4767e4dc41..35111981dfdf 100644
--- a/drivers/mfd/upboard.c
+++ b/drivers/mfd/upboard.c
@@ -132,6 +132,7 @@ static struct upboard_led_data upboard_up2_led_data[] = {
 };
 
 static const struct mfd_cell upboard_up2_mfd_cells[] = {
+	{ .name = "upboard-pinctrl" },
 	UPBOARD_LED_CELL(upboard_up2_led_data, 0),
 	UPBOARD_LED_CELL(upboard_up2_led_data, 1),
 	UPBOARD_LED_CELL(upboard_up2_led_data, 2),
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 01fe8e0455a0..a973e9210d4e 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -337,6 +337,19 @@ config PINCTRL_OCELOT
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
 source "drivers/pinctrl/aspeed/Kconfig"
 source "drivers/pinctrl/bcm/Kconfig"
 source "drivers/pinctrl/berlin/Kconfig"
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 657332b121fb..a88a8be87a0c 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_PINCTRL_ZYNQ)	+= pinctrl-zynq.o
 obj-$(CONFIG_PINCTRL_INGENIC)	+= pinctrl-ingenic.o
 obj-$(CONFIG_PINCTRL_RK805)	+= pinctrl-rk805.o
 obj-$(CONFIG_PINCTRL_OCELOT)	+= pinctrl-ocelot.o
+obj-$(CONFIG_PINCTRL_UPBOARD)	+= pinctrl-upboard.o
 
 obj-$(CONFIG_ARCH_ASPEED)	+= aspeed/
 obj-y				+= bcm/
diff --git a/drivers/pinctrl/pinctrl-upboard.c b/drivers/pinctrl/pinctrl-upboard.c
new file mode 100644
index 000000000000..2be6f1a65fe6
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-upboard.c
@@ -0,0 +1,523 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * UP Board pin controller driver
+ *
+ * Copyright (c) 2018, Emutex Ltd.
+ *
+ * Authors: Javier Arteaga <javier@emutex.com>
+ *          Dan O'Donovan <dan@emutex.com>
+ */
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
+	struct regmap *regmap;
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
+};
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
+};
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
+};
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
+static struct regmap_field * __init upboard_field_alloc(struct device *dev,
+							struct regmap *regmap,
+							unsigned int base,
+							unsigned int number)
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
+static int __init upboard_pinctrl_probe(struct platform_device *pdev)
+{
+	struct acpi_device * const adev = ACPI_COMPANION(&pdev->dev);
+	struct upboard *upboard;
+	struct pinctrl_desc *pctldesc;
+	struct upboard_pinctrl *pctrl;
+	struct upboard_pin *pins;
+	unsigned int i;
+	int ret;
+
+	if (!adev)
+		return -ENODEV;
+
+	if (!pdev->dev.parent)
+		return -EINVAL;
+
+	upboard = dev_get_drvdata(pdev->dev.parent);
+	if (!upboard)
+		return -EINVAL;
+
+	if (strcmp(acpi_device_hid(adev), "AANT0F01"))
+		return -ENODEV;
+
+	pctldesc = &upboard_up2_pinctrl_desc;
+	pctldesc->name = dev_name(&pdev->dev);
+
+	pins = devm_kzalloc(&pdev->dev, sizeof(*pins) * pctldesc->npins, GFP_KERNEL);
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
+			pin->func_en = devm_regmap_field_alloc(&pdev->dev,
+							       upboard->regmap,
+							       *field);
+			if (IS_ERR(pin->func_en))
+				return PTR_ERR(pin->func_en);
+		}
+
+		pin->gpio_en = upboard_field_alloc(&pdev->dev, upboard->regmap,
+						   UPBOARD_REG_GPIO_EN0, i);
+		if (IS_ERR(pin->gpio_en))
+			return PTR_ERR(pin->gpio_en);
+
+		pin->gpio_dir = upboard_field_alloc(&pdev->dev, upboard->regmap,
+						    UPBOARD_REG_GPIO_DIR0, i);
+		if (IS_ERR(pin->gpio_dir))
+			return PTR_ERR(pin->gpio_dir);
+
+		((struct pinctrl_pin_desc *)pd)->drv_data = pin;
+	}
+
+	pctrl = devm_kzalloc(&pdev->dev, sizeof(*pctrl), GFP_KERNEL);
+	if (!pctrl)
+		return -ENOMEM;
+
+	pctrl->regmap = upboard->regmap;
+	pctrl->chip = upboard_gpio_chip;
+	pctrl->chip.parent = &pdev->dev;
+	pctrl->chip.ngpio = pctldesc->npins;
+
+	pctrl->nsoc_gpios = gpiod_count(&pdev->dev, "external");
+	pctrl->soc_gpios = devm_kzalloc(&pdev->dev,
+					pctrl->nsoc_gpios * sizeof(*pctrl->soc_gpios),
+					GFP_KERNEL);
+	if (!pctrl->soc_gpios)
+		return -ENOMEM;
+
+	pctrl->pctldev = devm_pinctrl_register(&pdev->dev, pctldesc, pctrl);
+	if (IS_ERR(pctrl->pctldev))
+		return PTR_ERR(pctrl->pctldev);
+
+	ret = devm_gpiochip_add_data(&pdev->dev, &pctrl->chip, &pctrl->chip);
+	if (ret)
+		return ret;
+
+	return gpiochip_add_pin_range(&pctrl->chip, dev_name(&pdev->dev), 0, 0,
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
+MODULE_LICENSE("GPL");
-- 
2.17.0
