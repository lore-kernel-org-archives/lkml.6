Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4CAC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342B020684
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gEX69S8k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 342B020684
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbeIZTWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:22:52 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55124 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbeIZTWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:22:49 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8QD9ptD014989;
        Wed, 26 Sep 2018 08:09:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537967391;
        bh=CcJYYkHEfaI49ZoD6ClXM8EAb9M+pWlXnzqBAuApOLg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gEX69S8kXmZdxZDmHwNN4c7YHP9gG6x/eUYr7lnVLl2XYMPsEEQtuFjtl1Uj9vzQo
         eAJ8XTpNUWIdanTBX/kMT6gfO9lAtodPekBNFCsrHpR0t/cj/eY0DQipqjr8x7eg0f
         8S/1pUz7Usm6PSQzirNsiWR1EW8adV1oQ1c5lPk8=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8QD9pYZ020280;
        Wed, 26 Sep 2018 08:09:51 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 26
 Sep 2018 08:09:51 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 26 Sep 2018 08:09:51 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8QD9p89013925;
        Wed, 26 Sep 2018 08:09:51 -0500
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.176.238])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w8QD9ox11659;
        Wed, 26 Sep 2018 08:09:51 -0500 (CDT)
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lee.jones@linaro.org>, <linux-omap@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [RFC PATCH 9/9] leds: lm3632: Introduce the TI LM3632 driver
Date:   Wed, 26 Sep 2018 08:09:21 -0500
Message-ID: <20180926130921.12329-10-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20180926130921.12329-1-dmurphy@ti.com>
References: <20180926130921.12329-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the dedicated TI LM3632 LED driver.  This
LED device is capable of driving a backlight display.

In addition to the backlight the device has control
of a strobe and torch output.

Data sheet:
http://www.ti.com/lit/ds/symlink/lm3632a.pdf

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/leds/Kconfig       |   9 +-
 drivers/leds/Makefile      |   1 +
 drivers/leds/leds-lm3632.c | 547 +++++++++++++++++++++++++++++++++++++
 3 files changed, 556 insertions(+), 1 deletion(-)
 create mode 100644 drivers/leds/leds-lm3632.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 1a78588d9806..7879b9048332 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -764,8 +764,15 @@ config LEDS_LM3697
           This supports the LED device LM3697.
 
 config LEDS_LM3633
-	tristate "LED driver for LM3633"
+	tristate "LED driver for LM3632"
  	depends on LEDS_TI_LMU_COMMON
+	help
+          Say Y to enable the LED driver for TI LMU devices.
+          This supports the LED device LM3632.
+
+config LEDS_LM3632
+	tristate "LED driver for LM3632"
+	depends on LEDS_TI_LMU_COMMON
 	help
           Say Y to enable the LED driver for TI LMU devices.
           This supports the LED device LM3633.
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 6ec006892fc0..53d02d7f1a0b 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -79,6 +79,7 @@ obj-$(CONFIG_LEDS_LM3692X)		+= leds-lm3692x.o
 obj-$(CONFIG_LEDS_SC27XX_BLTC)		+= leds-sc27xx-bltc.o
 obj-$(CONFIG_LEDS_LM3601X)		+= leds-lm3601x.o
 obj-$(CONFIG_LEDS_LM3697)		+= leds-lm3697.o
+obj-$(CONFIG_LEDS_LM3632)		+= leds-lm3632.o
 obj-$(CONFIG_LEDS_LM3633)		+= leds-lm3633.o
 obj-$(CONFIG_LEDS_TI_LMU_COMMON)	+= ti-lmu-led-common.o
 
diff --git a/drivers/leds/leds-lm3632.c b/drivers/leds/leds-lm3632.c
new file mode 100644
index 000000000000..7d487cf423bc
--- /dev/null
+++ b/drivers/leds/leds-lm3632.c
@@ -0,0 +1,547 @@
+// SPDX-License-Identifier: GPL-2.0
+// Flash and torch driver for Texas Instruments LM3632 LED
+// Flash driver chip family
+// Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
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
+#include "ti-lmu-led-common.h"
+
+#define LM3632_MODE_BL		0x0
+#define LM3632_MODE_TORCH	0x1
+
+/* Registers */
+#define LM3632_REV_REG		0x01
+#define LM3632_CFG1_REG		0x02
+#define LM3632_CFG2_REG		0x03
+#define LM3633_BL_BRT_LSB	0x04
+#define LM3633_BL_BRT_MSB	0x05
+#define LM3632_FLASH_TORCH_BRT	0x06
+#define LM3632_FLASH_CFG	0x07
+#define LM3632_ENABLE_REG	0x0a
+#define LM3632_FLAGS1_REG	0x0b
+#define LM3632_FLAGS2_REG	0x10
+
+/* Enable Mode bits */
+#define LM3632_BL_EN		BIT(0)
+#define LM3632_STROBE_EN	BIT(1)
+#define LM3632_FLASH_MODE	BIT(2)
+#define LM3632_BLED1_2_EN	BIT(3)
+#define LM3632_BLED1_EN		BIT(4)
+#define LM3632_BL_OVP_EN	BIT(6)
+#define LM3632_SW_RESET		BIT(7)
+
+/* Flags 1 Mask */
+#define LM3632_THERM_SHUTDOWN	BIT(0)
+#define LM3632_FLASH_TIME_OUT	BIT(1)
+#define LM3632_FLED_SHORT_FAULT	BIT(2)
+#define LM3632_VINM_SHORT_FAULT	BIT(4)
+#define LM3632_FOUT_SHORT_FAULT	BIT(5)
+#define LM3632_FLASH_OVP_FAULT	BIT(6)
+#define LM3632_BL_OVP_FAULT	BIT(7)
+
+/* Flags 2 Mask */
+#define LM3632_BL_OCP_FAULT	BIT(0)
+#define LM3632_FLASH_OCP_FAULT	BIT(1)
+#define LM3632_VNEG_SHORT_FAULT	BIT(2)
+#define LM3632_VPOS_SHORT_FAULT	BIT(3)
+#define LM3632_VNEG_OVP_FAULT	BIT(4)
+#define LM3632_LCM_OVP_FAULT	BIT(5)
+
+#define LM3632_TORCH_BRT_SHIFT	4
+#define LM3632_STROBE_REG_DIV	16
+#define LM3632_STROBE_STEP_UA	100000
+
+#define LM3632_MAX_TORCH_I_UA	375000
+#define LM3632_MIN_TORCH_I_UA	2500
+
+#define LM3632_MAX_STROBE_I_UA	1500000
+#define LM3632_MIN_STROBE_I_UA	10000
+
+#define LM3632_TIMEOUT_MASK	0x1e
+#define LM3632_ENABLE_MASK	(LM3632_BL_EN | LM3632_STROBE_EN)
+
+#define LM3632_TIMEOUT_STEP_US	32000
+#define LM3632_MIN_TIMEOUT_US	32000
+#define LM3632_MAX_TIMEOUT_US	1024000
+
+#define LM3632_TORCH_BRT_MASK	0x0f
+#define LM3632_FLASH_BRT_MASK	0xf0
+
+/**
+ * struct lm3632_led -
+ * @fled_cdev: flash LED class device pointer
+ * @led_name - LED label
+ * @led_dev - LED class device
+ * @priv - Pointer to the lm3632 struct
+ * @lmu_data - Register and setting values for common code
+ * @led_name: LED label for the Torch or IR LED
+ * @flash_timeout: the timeout for the flash
+ * @last_flag: last known flags register value
+ * @torch_current_max: maximum current for the torch
+ * @flash_current_max: maximum current for the flash
+ * @max_flash_timeout: maximum timeout for the flash
+ */
+struct lm3632_led {
+	struct led_classdev_flash fled_cdev;
+	char led_name[LED_MAX_NAME_SIZE];
+	struct led_classdev led_dev;
+	struct ti_lmu_bank lmu_data;
+	struct lm3632 *priv;
+
+	unsigned int flash_timeout;
+	unsigned int last_flag;
+
+	u32 torch_current_max;
+	u32 flash_current_max;
+	u32 max_flash_timeout;
+};
+
+/**
+ * struct lm3632 -
+ * @client: Pointer to the I2C client
+ * @regmap: Devices register map
+ * @lock: Lock for reading/writing the device
+ * @leds - Array of LED strings
+ */
+struct lm3632 {
+	struct i2c_client *client;
+	struct regmap *regmap;
+	struct device *dev;
+	struct mutex lock;
+
+	struct lm3632_led leds[];
+};
+
+static const struct reg_default lm3632_regmap_defs[] = {
+	{ LM3632_CFG1_REG, 0x30 },
+	{ LM3632_CFG2_REG, 0x0d },
+	{ LM3632_FLASH_CFG, 0x2f },
+	{ LM3632_ENABLE_REG, 0x00 },
+};
+
+static bool lm3632_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case LM3632_FLAGS1_REG:
+	case LM3632_FLAGS2_REG:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config lm3632_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = LM3632_FLAGS2_REG,
+	.reg_defaults = lm3632_regmap_defs,
+	.num_reg_defaults = ARRAY_SIZE(lm3632_regmap_defs),
+	.cache_type = REGCACHE_RBTREE,
+	.volatile_reg = lm3632_volatile_reg,
+};
+
+static struct lm3632_led *fled_cdev_to_led(struct led_classdev_flash *fled_cdev)
+{
+	return container_of(fled_cdev, struct lm3632_led, fled_cdev);
+}
+
+static int lm3632_read_faults(struct lm3632_led *led)
+{
+	struct lm3632 *priv = led->priv;
+	int flags_val;
+	int ret;
+
+	ret = regmap_read(priv->regmap, LM3632_FLAGS1_REG, &flags_val);
+	if (ret < 0)
+		return -EIO;
+
+	led->last_flag = 0;
+
+	if (flags_val & LM3632_FLASH_OVP_FAULT)
+		led->last_flag |= LED_FAULT_OVER_VOLTAGE;
+
+	if (flags_val & LM3632_THERM_SHUTDOWN)
+		led->last_flag |= LED_FAULT_OVER_TEMPERATURE;
+
+	if (flags_val & (LM3632_FLED_SHORT_FAULT | LM3632_VINM_SHORT_FAULT |
+	    LM3632_FOUT_SHORT_FAULT))
+		led->last_flag |= LED_FAULT_SHORT_CIRCUIT;
+
+	if (flags_val & LM3632_THERM_SHUTDOWN)
+		led->last_flag |= LED_FAULT_LED_OVER_TEMPERATURE;
+
+	if (flags_val & LM3632_FLASH_TIME_OUT)
+		led->last_flag |= LED_FAULT_TIMEOUT;
+
+	ret = regmap_read(priv->regmap, LM3632_FLAGS2_REG, &flags_val);
+	if (ret < 0)
+		return -EIO;
+
+	if (flags_val & (LM3632_BL_OCP_FAULT | LM3632_FLASH_OCP_FAULT))
+		led->last_flag |= LED_FAULT_OVER_CURRENT;
+
+	if (flags_val & LM3632_FLASH_OCP_FAULT)
+		led->last_flag |= LED_FAULT_OVER_CURRENT;
+
+	return led->last_flag;
+}
+
+static int lm3632_backlight_brightness_set(struct led_classdev *cdev,
+					enum led_brightness brightness)
+{
+	struct lm3632_led *led = container_of(cdev, struct lm3632_led,
+					      led_dev);
+	struct lm3632 *priv = led->priv;
+	int ret;
+
+	mutex_lock(&priv->lock);
+
+	ret = ti_lmu_common_set_brightness(&led->lmu_data, brightness);
+	if (ret)
+		dev_err(&priv->client->dev, "Cannot write brightness\n");
+
+	mutex_unlock(&priv->lock);
+	return ret;
+}
+
+static int lm3632_strobe_flash_brightness_set(struct lm3632_led *led,
+					      u8 brightness_val)
+{
+	struct lm3632 *priv = led->priv;
+	int ret;
+
+	if (brightness_val == LED_OFF) {
+		ret = regmap_update_bits(priv->regmap, LM3632_ENABLE_REG,
+					LM3632_STROBE_EN, LED_OFF);
+		return ret;
+	}
+
+	ret = regmap_update_bits(priv->regmap, LM3632_FLASH_TORCH_BRT,
+				LM3632_TORCH_BRT_MASK, brightness_val);
+	if (ret < 0)
+		return ret;
+
+	return regmap_update_bits(priv->regmap, LM3632_ENABLE_REG,
+				LM3632_STROBE_EN,
+				LM3632_STROBE_EN);
+}
+
+static int lm3632_torch_brightness_set(struct led_classdev *cdev,
+					enum led_brightness brightness)
+{
+	struct led_classdev_flash *fled_cdev = lcdev_to_flcdev(cdev);
+	struct lm3632_led *led = fled_cdev_to_led(fled_cdev);
+	struct lm3632 *priv = led->priv;
+	int ret, brightness_val;
+
+	mutex_lock(&priv->lock);
+
+	ret = lm3632_read_faults(led);
+	if (ret < 0)
+		goto out;
+
+	brightness_val = (brightness / 16);
+
+	ret = lm3632_strobe_flash_brightness_set(led, brightness_val);
+
+out:
+	mutex_unlock(&priv->lock);
+	return ret;
+}
+
+static int lm3632_strobe_set(struct led_classdev_flash *fled_cdev,
+				bool state)
+{
+	struct lm3632_led *led = fled_cdev_to_led(fled_cdev);
+	struct lm3632 *priv = led->priv;
+	int timeout_reg_val;
+	int current_timeout;
+	int ret;
+
+	mutex_lock(&priv->lock);
+
+	ret = regmap_read(priv->regmap, LM3632_FLASH_CFG, &current_timeout);
+	if (ret < 0)
+		goto out;
+
+	if (led->flash_timeout != current_timeout)
+		ret = regmap_update_bits(priv->regmap, LM3632_FLASH_CFG,
+					LM3632_TIMEOUT_MASK, timeout_reg_val);
+
+	if (state)
+		ret = regmap_update_bits(priv->regmap, LM3632_ENABLE_REG,
+					LM3632_STROBE_EN, LM3632_STROBE_EN);
+	else
+		ret = regmap_update_bits(priv->regmap, LM3632_ENABLE_REG,
+					LM3632_STROBE_EN, LED_OFF);
+
+	ret = lm3632_read_faults(led);
+out:
+	mutex_unlock(&priv->lock);
+	return ret;
+}
+
+static int lm3632_flash_brightness_set(struct led_classdev_flash *fled_cdev,
+					u32 brightness)
+{
+	struct lm3632_led *led = fled_cdev_to_led(fled_cdev);
+	struct lm3632 *priv = led->priv;
+	u8 brightness_val;
+	int ret;
+
+	mutex_lock(&priv->lock);
+	ret = lm3632_read_faults(led);
+	if (ret < 0)
+		goto out;
+
+	brightness_val = (brightness / 16) << LM3632_TORCH_BRT_SHIFT;
+
+	ret = lm3632_strobe_flash_brightness_set(led, brightness_val);
+out:
+	mutex_unlock(&priv->lock);
+	return ret;
+}
+
+static int lm3632_flash_timeout_set(struct led_classdev_flash *fled_cdev,
+				u32 timeout)
+{
+	struct lm3632_led *led = fled_cdev_to_led(fled_cdev);
+	struct lm3632 *priv = led->priv;
+
+	mutex_lock(&priv->lock);
+
+	led->flash_timeout = timeout;
+
+	mutex_unlock(&priv->lock);
+
+	return 0;
+}
+
+static int lm3632_strobe_get(struct led_classdev_flash *fled_cdev, bool *state)
+{
+	struct lm3632_led *led = fled_cdev_to_led(fled_cdev);
+	struct lm3632 *priv = led->priv;
+	int strobe_state;
+	int ret;
+
+	mutex_lock(&priv->lock);
+
+	ret = regmap_read(priv->regmap, LM3632_ENABLE_REG, &strobe_state);
+	if (ret < 0)
+		goto out;
+
+	*state = strobe_state & LM3632_STROBE_EN;
+
+out:
+	mutex_unlock(&priv->lock);
+	return ret;
+}
+
+static int lm3632_flash_fault_get(struct led_classdev_flash *fled_cdev,
+				u32 *fault)
+{
+	struct lm3632_led *led = fled_cdev_to_led(fled_cdev);
+
+	lm3632_read_faults(led);
+
+	*fault = led->last_flag;
+
+	return 0;
+}
+
+static const struct led_flash_ops flash_ops = {
+	.flash_brightness_set	= lm3632_flash_brightness_set,
+	.strobe_set		= lm3632_strobe_set,
+	.strobe_get		= lm3632_strobe_get,
+	.timeout_set		= lm3632_flash_timeout_set,
+	.fault_get		= lm3632_flash_fault_get,
+};
+
+static int lm3632_register_strobe_leds(struct lm3632_led *led)
+{
+	struct led_classdev *led_cdev;
+	struct led_flash_setting *setting;
+
+	led->fled_cdev.ops = &flash_ops;
+
+	setting = &led->fled_cdev.timeout;
+	setting->min = LM3632_MIN_TIMEOUT_US;
+	setting->max = led->max_flash_timeout;
+	setting->step = LM3632_TIMEOUT_STEP_US;
+	setting->val = led->max_flash_timeout;
+
+	setting = &led->fled_cdev.brightness;
+	setting->min = LM3632_MIN_STROBE_I_UA;
+	setting->max = led->flash_current_max;
+	setting->step = LM3632_STROBE_STEP_UA;
+	setting->val = led->flash_current_max;
+
+	led_cdev = &led->fled_cdev.led_cdev;
+	led_cdev->name = led->led_name;
+	led_cdev->brightness_set_blocking = lm3632_torch_brightness_set;
+	led_cdev->max_brightness = led->torch_current_max;
+
+	led_cdev->flags |= LED_DEV_CAP_FLASH;
+
+	return led_classdev_flash_register(&led->priv->client->dev, &led->fled_cdev);
+}
+
+static int lm3632_parse_node(struct lm3632 *priv)
+{
+	struct fwnode_handle *child = NULL;
+	struct lm3632_led *led;
+	int ret = -ENODEV;
+	const char *name;
+	u32 led_mode;
+	int i;
+
+	device_for_each_child_node(priv->dev, child) {
+		ret = fwnode_property_read_u32(child, "reg", &led_mode);
+		if (ret) {
+			dev_err(&priv->client->dev, "reg DT property missing\n");
+			goto out_err;
+		}
+
+		if (led_mode < LM3632_MODE_TORCH ||
+		    led_mode > LM3632_MODE_BL) {
+			dev_warn(&priv->client->dev, "Invalid led mode requested\n");
+			ret = -EINVAL;
+			goto out_err;
+		}
+
+		led = &priv->leds[i];
+		led->priv = priv;
+
+		ret = fwnode_property_read_string(child, "label", &name);
+		if (ret) {
+			if (led_mode == LM3632_MODE_TORCH)
+				name = "torch";
+			else
+				name = "backlight";
+		}
+
+		snprintf(led->led_name, sizeof(led->led_name),
+			"%s:%s", priv->client->name, name);
+
+		if (led_mode == LM3632_MODE_TORCH) {
+			ret = fwnode_property_read_u32(child, "led-max-microamp",
+							&led->torch_current_max);
+			if (ret) {
+				dev_warn(&priv->client->dev,
+					"led-max-microamp DT property missing\n");
+				goto out_err;
+			}
+
+			ret = fwnode_property_read_u32(child, "flash-max-microamp",
+						&led->flash_current_max);
+			if (ret) {
+				dev_warn(&priv->client->dev,
+					 "flash-max-microamp DT property missing\n");
+				goto out_err;
+			}
+
+			ret = fwnode_property_read_u32(child, "flash-max-timeout-us",
+						&led->max_flash_timeout);
+			if (ret) {
+				dev_warn(&priv->client->dev,
+					 "flash-max-timeout-us DT property missing\n");
+				goto out_err;
+			}
+
+			ret = lm3632_register_strobe_leds(led);
+			if (ret) {
+				dev_warn(&priv->client->dev,
+					 "Failed to register flash LEDs\n");
+				goto out_err;
+			}
+
+		} else {
+			led->led_dev.name = led->led_name;
+			led->led_dev.brightness_set_blocking = lm3632_backlight_brightness_set;
+			led->lmu_data.regmap = priv->regmap;
+			led->lmu_data.max_brightness = MAX_BRIGHTNESS_11BIT;
+			led->lmu_data.lsb_brightness_reg = LM3633_BL_BRT_LSB;
+			led->lmu_data.msb_brightness_reg = LM3633_BL_BRT_MSB;
+
+			ret = devm_led_classdev_register(priv->dev, &led->led_dev);
+		}
+
+		i++;
+	}
+out_err:
+	fwnode_handle_put(child);
+	return ret;
+}
+
+static int lm3632_probe(struct i2c_client *client)
+{
+	struct lm3632 *led;
+	int ret;
+
+	led = devm_kzalloc(&client->dev, sizeof(*led), GFP_KERNEL);
+	if (!led)
+		return -ENOMEM;
+
+	led->client = client;
+	led->dev = &client->dev;
+	i2c_set_clientdata(client, led);
+
+	led->regmap = devm_regmap_init_i2c(client, &lm3632_regmap);
+	if (IS_ERR(led->regmap)) {
+		ret = PTR_ERR(led->regmap);
+		dev_err(&client->dev,
+			"Failed to allocate register map: %d\n", ret);
+		return ret;
+	}
+
+	mutex_init(&led->lock);
+
+	return lm3632_parse_node(led);
+}
+
+static int lm3632_remove(struct i2c_client *client)
+{
+	struct lm3632 *led = i2c_get_clientdata(client);
+
+/*	led_classdev_flash_unregister(&led->fled_cdev);*/
+	mutex_destroy(&led->lock);
+
+	return regmap_update_bits(led->regmap, LM3632_ENABLE_REG,
+			   LM3632_ENABLE_MASK, 0x00);
+}
+
+static const struct i2c_device_id lm3632_id[] = {
+	{ "LM3632", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, lm3632_id);
+
+static const struct of_device_id of_lm3632_leds_match[] = {
+	{ .compatible = "ti,lm3632", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, of_lm3632_leds_match);
+
+static struct i2c_driver lm3632_i2c_driver = {
+	.driver = {
+		.name = "lm3632",
+		.of_match_table = of_lm3632_leds_match,
+	},
+	.probe_new = lm3632_probe,
+	.remove = lm3632_remove,
+	.id_table = lm3632_id,
+};
+module_i2c_driver(lm3632_i2c_driver);
+
+MODULE_DESCRIPTION("Texas Instruments Flash Lighting driver for LM3632");
+MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.19.0

