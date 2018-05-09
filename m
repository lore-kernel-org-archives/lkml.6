Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934070AbeEIIVU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 04:21:20 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45395 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934058AbeEIIVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 04:21:14 -0400
X-Google-Smtp-Source: AB8JxZoAhyTnomSoRrL+530wxRbxumlTMK3oI3KFpGeA83Fxt2RgvVjz0LOIOFM9aYdmeNX5sJmMrQ==
From: Baolin Wang <baolin.wang@linaro.org>
To: jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc: xiaotong.lu@spreadtrum.com, baolin.wang@linaro.org, broonie@kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] leds: Add Spreadtrum SC27xx breathing light controller driver
Date: Wed,  9 May 2018 16:21:01 +0800
Message-Id: <34fe94279e976a7738c45cf9dd19452f1a2608db.1525851574.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <79934a1cf0b75920c982d60481a647fbb5c4c687.1525851574.git.baolin.wang@linaro.org>
References: <79934a1cf0b75920c982d60481a647fbb5c4c687.1525851574.git.baolin.wang@linaro.org>
In-Reply-To: <79934a1cf0b75920c982d60481a647fbb5c4c687.1525851574.git.baolin.wang@linaro.org>
References: <79934a1cf0b75920c982d60481a647fbb5c4c687.1525851574.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaotong Lu <xiaotong.lu@spreadtrum.com>

This patch adds Spreadtrum SC27xx PMIC series breathing light controller
driver, which can support 3 LEDs. Each LED can work at normal PWM mode
and breathing mode.

Signed-off-by: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes since v2:
 - Add more description for the sysfs nodes.
 - Change the sysfs nodes to RW.
 - Reset the time values to 0 when disable the LED.
 - Remove 'value' from 'struct sc27xx_led'.
 - Add 'remove' interface to destroy mutex.
 - Remove max_brightness setting when initializing the LED.
 - Other coding style fixes.

Changes since v1:
 - Add ABI documentation.
 - Add mutex protection in case of concurrent access.
 - Change the LED device name pattern.
 - Fix build warning.
---
 .../ABI/testing/sysfs-class-led-driver-sc27xx      |   30 ++
 drivers/leds/Kconfig                               |   11 +
 drivers/leds/Makefile                              |    1 +
 drivers/leds/leds-sc27xx-bltc.c                    |  524 ++++++++++++++++++++
 4 files changed, 566 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
 create mode 100644 drivers/leds/leds-sc27xx-bltc.c

diff --git a/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx b/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
new file mode 100644
index 0000000..ce9559f
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
@@ -0,0 +1,30 @@
+What:		/sys/class/leds/<led>/rise_time
+What:		/sys/class/leds/<led>/high_time
+What:		/sys/class/leds/<led>/fall_time
+What:		/sys/class/leds/<led>/low_time
+Date:		May 2018
+KernelVersion:	4.18
+Contact:	Xiaotong Lu <xiaotong.lu@spreadtrum.com>
+Description:
+		Set the pattern generator rise, high, fall and low
+		times (0..63). It's unit is 0.125s, it should be > 0.
+
+		1 - 125 ms
+		2 - 250 ms
+		3 - 375 ms
+		...
+		...
+		...
+		62 - 7.75 s
+		63 - 7.875 s
+
+		The LED can work at normal PWM mode or breathing mode.
+		For normal PWM mode, user just set the brightness value
+		to turn on/off the LED.
+
+		But for breathing mode, user not only need set the rise,
+		high, fall and low time, but also need set one brightness
+		value to turn on the breathing mode LED, and it will turn
+		off the breathing mode LED by setting brightness to 0, that
+		will also reset the rise, high, fall and low time values to
+		0.
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 2c896c0..319449b 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -647,6 +647,17 @@ config LEDS_IS31FL32XX
 	  LED controllers. They are I2C devices with multiple constant-current
 	  channels, each with independent 256-level PWM control.
 
+config LEDS_SC27XX_BLTC
+	tristate "LED support for the SC27xx breathing light controller"
+	depends on LEDS_CLASS && MFD_SC27XX_PMIC
+	depends on OF
+	help
+	  Say Y here to include support for the SC27xx breathing light controller
+	  LEDs.
+
+	  This driver can also be built as a module. If so the module will be
+	  called leds-sc27xx-bltc.
+
 comment "LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)"
 
 config LEDS_BLINKM
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 91eca81..ff6917e 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_LEDS_MLXREG)		+= leds-mlxreg.o
 obj-$(CONFIG_LEDS_NIC78BX)		+= leds-nic78bx.o
 obj-$(CONFIG_LEDS_MT6323)		+= leds-mt6323.o
 obj-$(CONFIG_LEDS_LM3692X)		+= leds-lm3692x.o
+obj-$(CONFIG_LEDS_SC27XX_BLTC)		+= leds-sc27xx-bltc.o
 
 # LED SPI Drivers
 obj-$(CONFIG_LEDS_DAC124S085)		+= leds-dac124s085.o
diff --git a/drivers/leds/leds-sc27xx-bltc.c b/drivers/leds/leds-sc27xx-bltc.c
new file mode 100644
index 0000000..3061676
--- /dev/null
+++ b/drivers/leds/leds-sc27xx-bltc.c
@@ -0,0 +1,524 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Spreadtrum Communications Inc.
+
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <uapi/linux/uleds.h>
+
+/* PMIC global control register definition */
+#define SC27XX_MODULE_EN0	0xc08
+#define SC27XX_CLK_EN0		0xc18
+#define SC27XX_RGB_CTRL		0xebc
+
+#define SC27XX_BLTC_EN		BIT(9)
+#define SC27XX_RTC_EN		BIT(7)
+#define SC27XX_RGB_PD		BIT(0)
+
+/* Breathing light controller register definition */
+#define SC27XX_LEDS_CTRL	0x00
+#define SC27XX_LEDS_PRESCALE	0x04
+#define SC27XX_LEDS_DUTY	0x08
+#define SC27XX_LEDS_CURVE0	0x0c
+#define SC27XX_LEDS_CURVE1	0x10
+
+#define SC27XX_CTRL_SHIFT	4
+#define SC27XX_LED_RUN		BIT(0)
+#define SC27XX_LED_TYPE		BIT(1)
+
+#define SC27XX_DUTY_SHIFT	8
+#define SC27XX_DUTY_MASK	GENMASK(15, 0)
+#define SC27XX_MOD_MASK		GENMASK(7, 0)
+
+#define SC27XX_CURVE_SHIFT	8
+#define SC27XX_CURVE_L_MASK	GENMASK(7, 0)
+#define SC27XX_CURVE_H_MASK	GENMASK(15, 8)
+
+#define SC27XX_LEDS_OFFSET	0x10
+#define SC27XX_LEDS_MAX		3
+#define SC27XX_LEDS_TIME_MAX	63
+
+/*
+ * The SC27xx breathing light controller can support 3 outputs: red LED,
+ * green LED and blue LED. Each LED can support normal PWM mode and breathing
+ * mode.
+ *
+ * In breathing mode, the LED output curve includes rise, high, fall and low 4
+ * stages, and the duration of each stage is configurable.
+ */
+enum sc27xx_led_config {
+	SC27XX_RISE_TIME,
+	SC27XX_FALL_TIME,
+	SC27XX_HIGH_TIME,
+	SC27XX_LOW_TIME,
+};
+
+struct sc27xx_led {
+	char name[LED_MAX_NAME_SIZE];
+	struct led_classdev ldev;
+	struct sc27xx_led_priv *priv;
+	u8 line;
+	bool breath_mode;
+	bool active;
+};
+
+struct sc27xx_led_priv {
+	struct sc27xx_led leds[SC27XX_LEDS_MAX];
+	struct regmap *regmap;
+	struct mutex lock;
+	u32 base;
+};
+
+#define to_sc27xx_led(ldev) \
+	container_of(ldev, struct sc27xx_led, ldev)
+
+static int sc27xx_led_init(struct regmap *regmap)
+{
+	int err;
+
+	err = regmap_update_bits(regmap, SC27XX_MODULE_EN0, SC27XX_BLTC_EN,
+				 SC27XX_BLTC_EN);
+	if (err)
+		return err;
+
+	err = regmap_update_bits(regmap, SC27XX_CLK_EN0, SC27XX_RTC_EN,
+				 SC27XX_RTC_EN);
+	if (err)
+		return err;
+
+	return regmap_update_bits(regmap, SC27XX_RGB_CTRL, SC27XX_RGB_PD, 0);
+}
+
+static u32 sc27xx_led_get_offset(struct sc27xx_led *leds)
+{
+	return leds->priv->base + SC27XX_LEDS_OFFSET * leds->line;
+}
+
+static int sc27xx_led_enable(struct sc27xx_led *leds, enum led_brightness value)
+{
+	u32 base = sc27xx_led_get_offset(leds);
+	u32 ctrl_base = leds->priv->base + SC27XX_LEDS_CTRL;
+	u8 ctrl_shift = SC27XX_CTRL_SHIFT * leds->line;
+	struct regmap *regmap = leds->priv->regmap;
+	int err;
+
+	err = regmap_update_bits(regmap, base + SC27XX_LEDS_DUTY,
+				 SC27XX_DUTY_MASK,
+				 (value << SC27XX_DUTY_SHIFT) |
+				 SC27XX_MOD_MASK);
+	if (err)
+		return err;
+
+	if (leds->breath_mode)
+		return regmap_update_bits(regmap, ctrl_base,
+					  SC27XX_LED_RUN << ctrl_shift,
+					  SC27XX_LED_RUN << ctrl_shift);
+
+	return regmap_update_bits(regmap, ctrl_base,
+			(SC27XX_LED_RUN | SC27XX_LED_TYPE) << ctrl_shift,
+			(SC27XX_LED_RUN | SC27XX_LED_TYPE) << ctrl_shift);
+}
+
+static int sc27xx_led_disable(struct sc27xx_led *leds)
+{
+	struct regmap *regmap = leds->priv->regmap;
+	u32 base = sc27xx_led_get_offset(leds);
+	u32 ctrl_base = leds->priv->base + SC27XX_LEDS_CTRL;
+	u8 ctrl_shift = SC27XX_CTRL_SHIFT * leds->line;
+	int err;
+
+	/* Reset the rise, high, fall and low time to zero. */
+	err = regmap_write(regmap, base + SC27XX_LEDS_CURVE0, 0);
+	if (err)
+		return err;
+
+	err = regmap_write(regmap, base + SC27XX_LEDS_CURVE1, 0);
+	if (err)
+		return err;
+
+	leds->breath_mode = false;
+
+	return regmap_update_bits(leds->priv->regmap, ctrl_base,
+			(SC27XX_LED_RUN | SC27XX_LED_TYPE) << ctrl_shift, 0);
+}
+
+static int sc27xx_led_set(struct led_classdev *ldev, enum led_brightness value)
+{
+	struct sc27xx_led *leds = to_sc27xx_led(ldev);
+	int err;
+
+	mutex_lock(&leds->priv->lock);
+
+	if (value == LED_OFF)
+		err = sc27xx_led_disable(leds);
+	else
+		err = sc27xx_led_enable(leds, value);
+
+	mutex_unlock(&leds->priv->lock);
+
+	return err;
+}
+
+static int sc27xx_led_set_config(struct sc27xx_led *leds,
+				 enum sc27xx_led_config config, u32 val)
+{
+	u32 base = sc27xx_led_get_offset(leds);
+	struct regmap *regmap = leds->priv->regmap;
+	int err;
+
+	mutex_lock(&leds->priv->lock);
+
+	switch (config) {
+	case SC27XX_RISE_TIME:
+		err = regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE0,
+					 SC27XX_CURVE_L_MASK, val);
+		break;
+	case SC27XX_FALL_TIME:
+		err = regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE0,
+					 SC27XX_CURVE_H_MASK,
+					 val << SC27XX_CURVE_SHIFT);
+		break;
+	case SC27XX_HIGH_TIME:
+		err = regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE1,
+					 SC27XX_CURVE_L_MASK, val);
+		break;
+	case SC27XX_LOW_TIME:
+		err = regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE1,
+					 SC27XX_CURVE_H_MASK,
+					 val << SC27XX_CURVE_SHIFT);
+		break;
+	default:
+		err = -ENOTSUPP;
+		break;
+	}
+
+	if (!err && !leds->breath_mode)
+		leds->breath_mode = true;
+
+	mutex_unlock(&leds->priv->lock);
+
+	return err;
+}
+
+static int sc27xx_led_read_config(struct sc27xx_led *leds,
+				  enum sc27xx_led_config config, u32 *val)
+{
+	u32 base = sc27xx_led_get_offset(leds);
+	struct regmap *regmap = leds->priv->regmap;
+	int err;
+
+	mutex_lock(&leds->priv->lock);
+
+	switch (config) {
+	case SC27XX_RISE_TIME:
+		err = regmap_read(regmap, base + SC27XX_LEDS_CURVE0, val);
+		if (err)
+			goto out;
+
+		*val &= SC27XX_CURVE_L_MASK;
+		break;
+	case SC27XX_FALL_TIME:
+		err = regmap_read(regmap, base + SC27XX_LEDS_CURVE0, val);
+		if (err)
+			goto out;
+
+		*val = (*val & SC27XX_CURVE_H_MASK) >> SC27XX_CURVE_SHIFT;
+		break;
+	case SC27XX_HIGH_TIME:
+		err = regmap_read(regmap, base + SC27XX_LEDS_CURVE1, val);
+		if (err)
+			goto out;
+
+		*val &= SC27XX_CURVE_L_MASK;
+		break;
+	case SC27XX_LOW_TIME:
+		err = regmap_read(regmap, base + SC27XX_LEDS_CURVE1, val);
+		if (err)
+			goto out;
+
+		*val = (*val & SC27XX_CURVE_H_MASK) >> SC27XX_CURVE_SHIFT;
+		break;
+	default:
+		err = -ENOTSUPP;
+		break;
+	}
+
+out:
+	mutex_unlock(&leds->priv->lock);
+
+	return err;
+}
+
+static ssize_t rise_time_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t size)
+{
+	struct led_classdev *ldev = dev_get_drvdata(dev);
+	struct sc27xx_led *leds = to_sc27xx_led(ldev);
+	u32 val;
+	int err;
+
+	if (kstrtou32(buf, 10, &val) || val > SC27XX_LEDS_TIME_MAX)
+		return -EINVAL;
+
+	err = sc27xx_led_set_config(leds, SC27XX_RISE_TIME, val);
+	if (err)
+		return err;
+
+	return size;
+}
+
+static ssize_t rise_time_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct led_classdev *ldev = dev_get_drvdata(dev);
+	struct sc27xx_led *leds = to_sc27xx_led(ldev);
+	u32 val;
+	int err;
+
+	err = sc27xx_led_read_config(leds, SC27XX_RISE_TIME, &val);
+	if (err)
+		return err;
+
+	return sprintf(buf, "%u\n", val);
+}
+
+static ssize_t fall_time_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t size)
+{
+	struct led_classdev *ldev = dev_get_drvdata(dev);
+	struct sc27xx_led *leds = to_sc27xx_led(ldev);
+	u32 val;
+	int err;
+
+	if (kstrtou32(buf, 10, &val) || val > SC27XX_LEDS_TIME_MAX)
+		return -EINVAL;
+
+	err = sc27xx_led_set_config(leds, SC27XX_FALL_TIME, val);
+	if (err)
+		return err;
+
+	return size;
+}
+
+static ssize_t fall_time_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct led_classdev *ldev = dev_get_drvdata(dev);
+	struct sc27xx_led *leds = to_sc27xx_led(ldev);
+	u32 val;
+	int err;
+
+	err = sc27xx_led_read_config(leds, SC27XX_FALL_TIME, &val);
+	if (err)
+		return err;
+
+	return sprintf(buf, "%u\n", val);
+}
+
+static ssize_t high_time_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t size)
+{
+	struct led_classdev *ldev = dev_get_drvdata(dev);
+	struct sc27xx_led *leds = to_sc27xx_led(ldev);
+	u32 val;
+	int err;
+
+	if (kstrtou32(buf, 10, &val) || val > SC27XX_LEDS_TIME_MAX)
+		return -EINVAL;
+
+	err = sc27xx_led_set_config(leds, SC27XX_HIGH_TIME, val);
+	if (err)
+		return err;
+
+	return size;
+}
+
+static ssize_t high_time_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct led_classdev *ldev = dev_get_drvdata(dev);
+	struct sc27xx_led *leds = to_sc27xx_led(ldev);
+	u32 val;
+	int err;
+
+	err = sc27xx_led_read_config(leds, SC27XX_HIGH_TIME, &val);
+	if (err)
+		return err;
+
+	return sprintf(buf, "%u\n", val);
+}
+
+static ssize_t low_time_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t size)
+{
+	struct led_classdev *ldev = dev_get_drvdata(dev);
+	struct sc27xx_led *leds = to_sc27xx_led(ldev);
+	u32 val;
+	int err;
+
+	if (kstrtou32(buf, 10, &val) || val > SC27XX_LEDS_TIME_MAX)
+		return -EINVAL;
+
+	err = sc27xx_led_set_config(leds, SC27XX_LOW_TIME, val);
+	if (err)
+		return err;
+
+	return size;
+}
+
+static ssize_t low_time_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct led_classdev *ldev = dev_get_drvdata(dev);
+	struct sc27xx_led *leds = to_sc27xx_led(ldev);
+	u32 val;
+	int err;
+
+	err = sc27xx_led_read_config(leds, SC27XX_LOW_TIME, &val);
+	if (err)
+		return err;
+
+	return sprintf(buf, "%u\n", val);
+}
+
+static DEVICE_ATTR_RW(rise_time);
+static DEVICE_ATTR_RW(fall_time);
+static DEVICE_ATTR_RW(high_time);
+static DEVICE_ATTR_RW(low_time);
+
+static struct attribute *sc27xx_led_attrs[] = {
+	&dev_attr_rise_time.attr,
+	&dev_attr_fall_time.attr,
+	&dev_attr_high_time.attr,
+	&dev_attr_low_time.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(sc27xx_led);
+
+static int sc27xx_led_register(struct device *dev, struct sc27xx_led_priv *priv)
+{
+	int i, err;
+
+	err = sc27xx_led_init(priv->regmap);
+	if (err)
+		return err;
+
+	for (i = 0; i < SC27XX_LEDS_MAX; i++) {
+		struct sc27xx_led *led = &priv->leds[i];
+
+		if (!led->active)
+			continue;
+
+		led->line = i;
+		led->priv = priv;
+		led->ldev.name = led->name;
+		led->ldev.brightness_set_blocking = sc27xx_led_set;
+		led->ldev.groups = sc27xx_led_groups;
+
+		err = devm_led_classdev_register(dev, &led->ldev);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int sc27xx_led_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node, *child;
+	struct sc27xx_led_priv *priv;
+	const char *str;
+	u32 base, count, reg;
+	int err;
+
+	count = of_get_child_count(np);
+	if (!count || count > SC27XX_LEDS_MAX)
+		return -EINVAL;
+
+	err = of_property_read_u32(np, "reg", &base);
+	if (err) {
+		dev_err(dev, "fail to get reg of property\n");
+		return err;
+	}
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+	mutex_init(&priv->lock);
+	priv->base = base;
+	priv->regmap = dev_get_regmap(dev->parent, NULL);
+	if (IS_ERR(priv->regmap)) {
+		err = PTR_ERR(priv->regmap);
+		dev_err(dev, "failed to get regmap: %d\n", err);
+		return err;
+	}
+
+	for_each_child_of_node(np, child) {
+		err = of_property_read_u32(child, "reg", &reg);
+		if (err) {
+			of_node_put(child);
+			mutex_destroy(&priv->lock);
+			return err;
+		}
+
+		if (reg >= SC27XX_LEDS_MAX || priv->leds[reg].active) {
+			of_node_put(child);
+			mutex_destroy(&priv->lock);
+			return -EINVAL;
+		}
+
+		priv->leds[reg].active = true;
+
+		err = of_property_read_string(child, "label", &str);
+		if (err)
+			snprintf(priv->leds[reg].name, LED_MAX_NAME_SIZE,
+				 "sc27xx::");
+		else
+			snprintf(priv->leds[reg].name, LED_MAX_NAME_SIZE,
+				 "sc27xx:%s", str);
+	}
+
+	err = sc27xx_led_register(dev, priv);
+	if (err)
+		mutex_destroy(&priv->lock);
+
+	return err;
+}
+
+static int sc27xx_led_remove(struct platform_device *pdev)
+{
+	struct sc27xx_led_priv *priv = platform_get_drvdata(pdev);
+
+	mutex_destroy(&priv->lock);
+	return 0;
+}
+
+static const struct of_device_id sc27xx_led_of_match[] = {
+	{ .compatible = "sprd,sc2731-bltc", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sc27xx_led_of_match);
+
+static struct platform_driver sc27xx_led_driver = {
+	.driver = {
+		.name = "sprd-bltc",
+		.of_match_table = sc27xx_led_of_match,
+	},
+	.probe = sc27xx_led_probe,
+	.remove = sc27xx_led_remove,
+};
+
+module_platform_driver(sc27xx_led_driver);
+
+MODULE_DESCRIPTION("Spreadtrum SC27xx breathing light controller driver");
+MODULE_AUTHOR("Xiaotong Lu <xiaotong.lu@spreadtrum.com>");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5
