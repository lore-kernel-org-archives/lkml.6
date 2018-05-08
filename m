Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932334AbeEHORU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 10:17:20 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:18556 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754312AbeEHORQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 10:17:16 -0400
From: Dan Murphy <dmurphy@ti.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v2 2/2] leds: lm3601x: Introduce the lm3601x LED driver
Date: Tue, 8 May 2018 09:17:04 -0500
Message-ID: <20180508141704.24271-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20180508141704.24271-1-dmurphy@ti.com>
References: <20180508141704.24271-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the family of LED devices that can
drive a torch, strobe or IR LED.

The LED driver can be configured with a strobe
timer to execute a strobe flash.  The IR LED
brightness is controlled via the torch brightness
register.

The data sheet for each the LM36010 and LM36011
LED drivers can be found here:
http://www.ti.com/product/LM36010
http://www.ti.com/product/LM36011

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v2 - Fixed kbuild issue and removed unused cdev_strobe - https://patchwork.kernel.org/patch/10384585/

 drivers/leds/Kconfig        |   9 +
 drivers/leds/Makefile       |   1 +
 drivers/leds/leds-lm3601x.c | 591 ++++++++++++++++++++++++++++++++++++
 3 files changed, 601 insertions(+)
 create mode 100644 drivers/leds/leds-lm3601x.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 2c896c0e69e1..50ae536f343f 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -145,6 +145,15 @@ config LEDS_LM3692X
 	  This option enables support for the TI LM3692x family
 	  of white LED string drivers used for backlighting.
 
+config LEDS_LM3601X
+	tristate "LED support for LM3601x Chips"
+	depends on LEDS_CLASS && I2C && OF
+	depends on LEDS_CLASS_FLASH
+	select REGMAP_I2C
+	help
+	  This option enables support for the TI LM3601x family
+	  of flash, torch and indicator classes.
+
 config LEDS_LOCOMO
 	tristate "LED Support for Locomo device"
 	depends on LEDS_CLASS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 91eca81cae82..b79807fe1b67 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_LEDS_MLXREG)		+= leds-mlxreg.o
 obj-$(CONFIG_LEDS_NIC78BX)		+= leds-nic78bx.o
 obj-$(CONFIG_LEDS_MT6323)		+= leds-mt6323.o
 obj-$(CONFIG_LEDS_LM3692X)		+= leds-lm3692x.o
+obj-$(CONFIG_LEDS_LM3601X)		+= leds-lm3601x.o
 
 # LED SPI Drivers
 obj-$(CONFIG_LEDS_DAC124S085)		+= leds-dac124s085.o
diff --git a/drivers/leds/leds-lm3601x.c b/drivers/leds/leds-lm3601x.c
new file mode 100644
index 000000000000..2d7a4a2e541f
--- /dev/null
+++ b/drivers/leds/leds-lm3601x.c
@@ -0,0 +1,591 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Flash and torch driver for Texas Instruments LM3601X LED
+ * Flash driver chip family
+ * Copyright (C) 2018 Texas Instruments
+ */
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/leds.h>
+#include <linux/led-class-flash.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <uapi/linux/uleds.h>
+
+#define LM3601X_LED_TORCH	0x0
+#define LM3601X_LED_STROBE	0x1
+#define LM3601X_LED_IR		0x2
+
+/* Registers */
+#define LM3601X_ENABLE_REG	0x01
+#define LM3601X_CFG_REG		0x02
+#define LM3601X_LED_FLASH_REG	0x03
+#define LM3601X_LED_TORCH_REG	0x04
+#define LM3601X_FLAGS_REG	0x05
+#define LM3601X_DEV_ID_REG	0x06
+
+#define LM3601X_SW_RESET	BIT(7)
+
+/* Enable Mode bits */
+#define LM3601X_MODE_STANDBY	0x00
+#define LM3601X_MODE_IR_DRV	BIT(0)
+#define LM3601X_MODE_TORCH	BIT(1)
+#define LM3601X_MODE_STROBE	(BIT(0) | BIT(1))
+#define LM3601X_STRB_EN		BIT(2)
+#define LM3601X_STRB_LVL_TRIG	~BIT(3)
+#define LM3601X_STRB_EDGE_TRIG	BIT(3)
+#define LM3601X_IVFM_EN		BIT(4)
+
+#define LM36010_BOOST_LIMIT_19	~BIT(5)
+#define LM36010_BOOST_LIMIT_28	BIT(5)
+#define LM36010_BOOST_FREQ_2MHZ	~BIT(6)
+#define LM36010_BOOST_FREQ_4MHZ	BIT(6)
+#define LM36010_BOOST_MODE_NORM	~BIT(7)
+#define LM36010_BOOST_MODE_PASS	BIT(7)
+
+/* Flag Mask */
+#define LM3601X_FLASH_TIME_OUT	BIT(0)
+#define LM3601X_UVLO_FAULT	BIT(1)
+#define LM3601X_THERM_SHUTDOWN	BIT(2)
+#define LM3601X_THERM_CURR	BIT(3)
+#define LM36010_CURR_LIMIT	BIT(4)
+#define LM3601X_SHORT_FAULT	BIT(5)
+#define LM3601X_IVFM_TRIP	BIT(6)
+#define LM36010_OVP_FAULT	BIT(7)
+
+#define LM3601X_MIN_TORCH_I_UA	2400
+#define LM3601X_MIN_STROBE_I_MA	11
+
+enum lm3601x_type {
+	CHIP_LM36010 = 0,
+	CHIP_LM36011,
+};
+
+struct lm3601x_max_timeouts {
+	int timeout;
+	int reg_val;
+};
+
+/**
+ * struct lm3601x_led -
+ * @lock - Lock for reading/writing the device
+ * @regmap - Devices register map
+ * @client - Pointer to the I2C client
+ * @cdev_torch - led class device pointer for the torch
+ * @cdev_ir - led class device pointer for infrared
+ * @fled_cdev - flash led class device pointer
+ * @strobe_node - DT device node for the strobe
+ * @torch - LED label for the torch
+ * @strobe - LED label for the strobe
+ * @ir - LED label for the infrared
+ * @last_flag - last known flags register value
+ * @strobe_timeout - the timeout for the strobe
+ * @torch_current_max - maximum current for the torch
+ * @strobe_current_max - maximum current for the strobe
+ * @max_strobe_timeout - maximum timeout for the strobe
+ */
+struct lm3601x_led {
+	struct mutex lock;
+	struct regmap *regmap;
+	struct i2c_client *client;
+
+	struct led_classdev cdev_torch;
+	struct led_classdev cdev_ir;
+
+	struct led_classdev_flash fled_cdev;
+
+	struct device_node *strobe_node;
+	struct device_node *torch_node;
+	struct device_node *ir_node;
+
+	char torch[LED_MAX_NAME_SIZE];
+	char strobe[LED_MAX_NAME_SIZE];
+	char ir[LED_MAX_NAME_SIZE];
+
+	unsigned int last_flag;
+	unsigned int strobe_timeout;
+
+	u32 torch_current_max;
+	u32 strobe_current_max;
+	u32 max_strobe_timeout;
+};
+
+static const struct lm3601x_max_timeouts strobe_timeouts[] = {
+	{ 40, 0x00 },
+	{ 80, 0x01 },
+	{ 120, 0x02 },
+	{ 160, 0x03 },
+	{ 200, 0x04 },
+	{ 240, 0x05 },
+	{ 280, 0x06 },
+	{ 320, 0x07 },
+	{ 360, 0x08 },
+	{ 400, 0x09 },
+	{ 600, 0x0a },
+	{ 800, 0x0b },
+	{ 1000, 0x0c },
+	{ 1200, 0x0d },
+	{ 1400, 0x0e },
+	{ 1600, 0x0f },
+};
+
+static const struct reg_default lm3601x_regmap_defs[] = {
+	{ LM3601X_ENABLE_REG, 0x20 },
+	{ LM3601X_CFG_REG, 0x15 },
+	{ LM3601X_LED_FLASH_REG, 0x00 },
+	{ LM3601X_LED_TORCH_REG, 0x00 },
+	{ LM3601X_FLAGS_REG, 0x00 },
+	{ LM3601X_DEV_ID_REG, 0x01 },
+};
+
+static const struct regmap_config lm3601x_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = LM3601X_DEV_ID_REG,
+	.reg_defaults = lm3601x_regmap_defs,
+	.num_reg_defaults = ARRAY_SIZE(lm3601x_regmap_defs),
+	.cache_type = REGCACHE_NONE,
+};
+
+static struct lm3601x_led *fled_cdev_to_led(
+				struct led_classdev_flash *fled_cdev)
+{
+	return container_of(fled_cdev, struct lm3601x_led, fled_cdev);
+}
+
+static int lm3601x_read_faults(struct lm3601x_led *led)
+{
+	int flags_val;
+	int ret;
+
+	ret = regmap_read(led->regmap, LM3601X_FLAGS_REG, &flags_val);
+	if (ret < 0)
+		return -EIO;
+
+	led->last_flag = flags_val;
+
+	return led->last_flag;
+}
+
+static int lm3601x_torch_brightness_set(struct led_classdev *cdev,
+					enum led_brightness brightness)
+{
+	struct lm3601x_led *led =
+	    container_of(cdev, struct lm3601x_led, cdev_torch);
+	int ret;
+	u8 brightness_val;
+
+	mutex_lock(&led->lock);
+
+	ret = lm3601x_read_faults(led);
+
+	if (brightness == LED_OFF) {
+		ret = regmap_update_bits(led->regmap, LM3601X_ENABLE_REG,
+					LM3601X_MODE_TORCH, LED_OFF);
+		goto out;
+	}
+
+	if (brightness == LED_ON)
+		brightness_val = LED_ON;
+	else
+		brightness_val = (brightness/2);
+
+	ret = regmap_write(led->regmap, LM3601X_LED_TORCH_REG, brightness_val);
+	if (ret < 0)
+		goto out;
+
+	ret = regmap_update_bits(led->regmap, LM3601X_ENABLE_REG,
+					LM3601X_MODE_TORCH,
+					LM3601X_MODE_TORCH);
+
+out:
+	mutex_unlock(&led->lock);
+	return ret;
+}
+
+static int lm3601x_strobe_set(struct led_classdev_flash *fled_cdev,
+				bool state)
+{
+	struct lm3601x_led *led = fled_cdev_to_led(fled_cdev);
+	int ret;
+	int current_timeout;
+	int reg_count;
+	int i;
+	int timeout_reg_val = 0;
+
+	mutex_lock(&led->lock);
+
+	ret = regmap_read(led->regmap, LM3601X_CFG_REG, &current_timeout);
+	if (ret < 0)
+		goto out;
+
+	reg_count = sizeof(strobe_timeouts) / sizeof(strobe_timeouts[0]);
+	for (i = 0; i < reg_count; i++) {
+		if (led->strobe_timeout > strobe_timeouts[i].timeout)
+			continue;
+
+		if (led->strobe_timeout <= strobe_timeouts[i].timeout) {
+			timeout_reg_val = (strobe_timeouts[i].reg_val << 1);
+			break;
+		}
+
+		ret = -EINVAL;
+		goto out;
+	};
+
+	if (led->strobe_timeout != current_timeout)
+		ret = regmap_update_bits(led->regmap, LM3601X_CFG_REG,
+					0x1e, timeout_reg_val);
+
+	if (state)
+		ret = regmap_update_bits(led->regmap, LM3601X_ENABLE_REG,
+					LM3601X_MODE_STROBE,
+					LM3601X_MODE_STROBE);
+	else
+		ret = regmap_update_bits(led->regmap, LM3601X_ENABLE_REG,
+					LM3601X_MODE_STROBE, LED_OFF);
+
+	ret = lm3601x_read_faults(led);
+out:
+	mutex_unlock(&led->lock);
+	return ret;
+}
+
+static int lm3601x_strobe_brightness_set(struct led_classdev *cdev,
+					 enum led_brightness brightness)
+{
+	struct led_classdev_flash *fled_cdev = lcdev_to_flcdev(cdev);
+	struct lm3601x_led *led = fled_cdev_to_led(fled_cdev);
+	int ret;
+	u8 brightness_val;
+
+	mutex_lock(&led->lock);
+	ret = lm3601x_read_faults(led);
+
+	if (brightness == LED_OFF) {
+		ret = regmap_update_bits(led->regmap, LM3601X_ENABLE_REG,
+					LM3601X_MODE_STROBE, LED_OFF);
+		goto out;
+	}
+
+	if (brightness == LED_ON)
+		brightness_val = LED_ON;
+	else
+		brightness_val = (brightness/2);
+
+	ret = regmap_write(led->regmap, LM3601X_LED_FLASH_REG, brightness_val);
+
+out:
+	mutex_unlock(&led->lock);
+	return ret;
+}
+
+static int lm3601x_strobe_timeout_set(struct led_classdev_flash *fled_cdev,
+				u32 timeout)
+{
+	struct lm3601x_led *led = fled_cdev_to_led(fled_cdev);
+	int ret = 0;
+
+	mutex_lock(&led->lock);
+
+	if (timeout > led->max_strobe_timeout)
+		ret = -EINVAL;
+	else
+		led->strobe_timeout = timeout;
+
+	mutex_unlock(&led->lock);
+
+	return ret;
+}
+
+static int lm3601x_strobe_get(struct led_classdev_flash *fled_cdev,
+				bool *state)
+{
+	struct lm3601x_led *led = fled_cdev_to_led(fled_cdev);
+	int ret;
+	int strobe_state;
+
+	mutex_lock(&led->lock);
+
+	ret = regmap_read(led->regmap, LM3601X_ENABLE_REG, &strobe_state);
+	if (ret < 0)
+		return ret;
+
+	*state = strobe_state & LM3601X_MODE_STROBE;
+
+	mutex_unlock(&led->lock);
+
+	return ret;
+}
+
+static int lm3601x_ir_brightness_set(struct led_classdev *cdev,
+					 enum led_brightness brightness)
+{
+	struct lm3601x_led *led =
+	    container_of(cdev, struct lm3601x_led, cdev_ir);
+	int ret;
+	u8 brightness_val;
+
+	mutex_lock(&led->lock);
+	ret = lm3601x_read_faults(led);
+
+	if (brightness == LED_OFF) {
+		ret = regmap_update_bits(led->regmap, LM3601X_ENABLE_REG,
+					0xfe, LED_OFF);
+		goto out;
+	}
+
+	if (brightness == LED_ON)
+		brightness_val = LED_ON;
+	else
+		brightness_val = (brightness/2);
+
+	ret = regmap_write(led->regmap, LM3601X_LED_FLASH_REG, brightness_val);
+
+	ret = regmap_update_bits(led->regmap, LM3601X_ENABLE_REG,
+					LM3601X_MODE_IR_DRV,
+					LM3601X_MODE_IR_DRV);
+
+out:
+	mutex_unlock(&led->lock);
+	return ret;
+}
+
+static int lm3601x_strobe_fault_get(struct led_classdev_flash *fled_cdev,
+				u32 *fault)
+{
+	struct lm3601x_led *led = fled_cdev_to_led(fled_cdev);
+
+	lm3601x_read_faults(led);
+
+	*fault = led->last_flag;
+
+	return 0;
+}
+
+static const struct led_flash_ops strobe_ops = {
+	.strobe_set		= lm3601x_strobe_set,
+	.strobe_get		= lm3601x_strobe_get,
+	.timeout_set		= lm3601x_strobe_timeout_set,
+	.fault_get		= lm3601x_strobe_fault_get,
+};
+
+static int lm3601x_register_leds(struct lm3601x_led *led)
+{
+	struct led_classdev_flash *fled_cdev;
+	struct led_classdev *led_cdev;
+	int err = -ENODEV;
+
+	if (led->torch_node) {
+		led->cdev_torch.name = led->torch;
+		led->cdev_torch.max_brightness = LED_FULL;
+		led->cdev_torch.brightness_set_blocking = lm3601x_torch_brightness_set;
+		err = devm_led_classdev_register(&led->client->dev,
+				&led->cdev_torch);
+		if (err < 0)
+			goto class_reg_err;
+	}
+
+	if (led->strobe_node) {
+		fled_cdev = &led->fled_cdev;
+		fled_cdev->ops = &strobe_ops;
+
+		led_cdev = &fled_cdev->led_cdev;
+		led_cdev->name = led->strobe;
+		led_cdev->max_brightness = LED_FULL;
+		led_cdev->brightness_set_blocking = lm3601x_strobe_brightness_set;
+		led_cdev->flags |= LED_DEV_CAP_FLASH;
+
+		err = led_classdev_flash_register(&led->client->dev,
+				fled_cdev);
+		if (err < 0)
+			goto class_reg_err;
+	}
+
+	if (led->ir_node) {
+		led->cdev_ir.name = led->ir;
+		led->cdev_ir.max_brightness = LED_FULL;
+		led->cdev_ir.brightness_set_blocking =
+						lm3601x_ir_brightness_set;
+
+		err = devm_led_classdev_register(&led->client->dev,
+				&led->cdev_ir);
+	}
+
+class_reg_err:
+	return err;
+}
+
+static void lm3601x_init_flash_timeout(struct lm3601x_led *led)
+{
+	struct led_flash_setting *setting;
+
+	setting = &led->fled_cdev.timeout;
+	setting->min = strobe_timeouts[0].timeout;
+	setting->max = led->max_strobe_timeout;
+	setting->step = 40;
+	setting->val = led->max_strobe_timeout;
+}
+
+static int lm3601x_parse_node(struct lm3601x_led *led,
+			      struct device_node *node)
+{
+	struct device_node *child_node;
+	const char *name;
+	int ret = -ENODEV;
+
+	for_each_available_child_of_node(node, child_node) {
+		u32 id = 0;
+
+		of_property_read_u32(child_node, "reg", &id);
+
+		switch (id) {
+		case LM3601X_LED_TORCH:
+			led->torch_node = of_node_get(child_node);
+			break;
+		case LM3601X_LED_STROBE:
+			led->strobe_node = of_node_get(child_node);
+			break;
+		case LM3601X_LED_IR:
+			led->ir_node = of_node_get(child_node);
+			break;
+		default:
+			dev_warn(&led->client->dev,
+				 "unknown LED %u encountered, ignoring\n", id);
+			break;
+		}
+	}
+
+	if (led->torch_node) {
+		ret = of_property_read_string(led->torch_node, "label", &name);
+		if (!ret)
+			snprintf(led->torch, sizeof(led->torch),
+				"%s:%s", led->torch_node->name, name);
+		else
+			snprintf(led->torch, sizeof(led->torch),
+				"%s:torch", led->torch_node->name);
+		ret = of_property_read_u32(led->torch_node, "led-max-microamp",
+					&led->torch_current_max);
+		if (ret < 0) {
+			led->torch_current_max = LM3601X_MIN_TORCH_I_UA;
+			dev_warn(&led->client->dev,
+				"led-max-microamp DT property missing\n");
+		}
+	}
+
+	if (led->strobe_node) {
+		ret = of_property_read_string(led->strobe_node, "label", &name);
+		if (!ret)
+			snprintf(led->strobe, sizeof(led->strobe),
+				"%s:%s", led->strobe_node->name, name);
+		else
+			snprintf(led->strobe, sizeof(led->strobe),
+				"%s::strobe", led->strobe_node->name);
+
+		ret = of_property_read_u32(led->strobe_node,
+					"flash-max-microamp",
+					&led->strobe_current_max);
+		if (ret < 0) {
+			led->strobe_current_max = LM3601X_MIN_STROBE_I_MA;
+			dev_warn(&led->client->dev,
+				 "flash-max-microamp DT property missing\n");
+		}
+
+		ret = of_property_read_u32(led->strobe_node,
+					"flash-max-timeout-us",
+					&led->max_strobe_timeout);
+		if (ret < 0) {
+			led->max_strobe_timeout = strobe_timeouts[0].reg_val;
+			dev_warn(&led->client->dev,
+				 "flash-max-timeout-us DT property missing\n");
+		}
+
+		lm3601x_init_flash_timeout(led);
+
+	}
+
+	if (led->ir_node) {
+		ret = of_property_read_string(led->ir_node, "label", &name);
+		if (!ret)
+			snprintf(led->ir, sizeof(led->ir),
+				"%s:%s", led->ir_node->name, name);
+		else
+			snprintf(led->ir, sizeof(led->ir),
+				"%s::infrared", led->ir_node->name);
+	}
+
+	return ret;
+}
+
+static int lm3601x_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct lm3601x_led *led;
+	int err;
+
+	led = devm_kzalloc(&client->dev,
+			    sizeof(struct lm3601x_led), GFP_KERNEL);
+	if (!led)
+		return -ENOMEM;
+
+	err = lm3601x_parse_node(led, client->dev.of_node);
+	if (err < 0)
+		return -ENODEV;
+
+	led->client = client;
+	led->regmap = devm_regmap_init_i2c(client, &lm3601x_regmap);
+	if (IS_ERR(led->regmap)) {
+		err = PTR_ERR(led->regmap);
+		dev_err(&client->dev,
+			"Failed to allocate register map: %d\n", err);
+		return err;
+	}
+
+	mutex_init(&led->lock);
+	i2c_set_clientdata(client, led);
+	err = lm3601x_register_leds(led);
+
+	return err;
+}
+
+static int lm3601x_remove(struct i2c_client *client)
+{
+	struct lm3601x_led *led = i2c_get_clientdata(client);
+
+	regmap_write(led->regmap, LM3601X_ENABLE_REG, 0);
+
+	return 0;
+}
+
+static const struct i2c_device_id lm3601x_id[] = {
+	{"LM36010", CHIP_LM36010},
+	{"LM36011", CHIP_LM36011},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, lm3601x_id);
+
+static const struct of_device_id of_lm3601x_leds_match[] = {
+	{ .compatible = "ti,lm3601x", },
+	{ .compatible = "ti,lm36010", },
+	{ .compatible = "ti,lm36011", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_lm3601x_leds_match);
+
+static struct i2c_driver lm3601x_i2c_driver = {
+	.driver = {
+		.name = "lm3601x",
+		.of_match_table = of_lm3601x_leds_match,
+	},
+	.probe = lm3601x_probe,
+	.remove = lm3601x_remove,
+	.id_table = lm3601x_id,
+};
+module_i2c_driver(lm3601x_i2c_driver);
+
+MODULE_DESCRIPTION("Texas Instruments Flash Lighting driver for LM3601X");
+MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.17.0.252.gfe0a9eaf3
