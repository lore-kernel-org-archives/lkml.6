Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A575C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7DA72098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jKDcYtw7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7DA72098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbeJLATl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:19:41 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48454 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730679AbeJLATl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 20:19:41 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9BGpVGY031431;
        Thu, 11 Oct 2018 11:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539276691;
        bh=yiHRg4Y5HJRHXP1rqwJbTt9p8seCtUnJxInDTKGc2KI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=jKDcYtw79NckvA5ZDmR3LICGmN0Jx4XYtf8bN3U1n2R3ZolEeeeVWK+7GZJ9WDSgx
         hDGvhHdA1HaFiMBIKmk5btg51JsFOwimgyYiUTbdDoizvE6hR6Dqy6dKNBVqIdZIwY
         tPw73Utyn6f0rE5Gfq2gohXf2NQvQIyO0UIweJKg=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9BGpV6f030245;
        Thu, 11 Oct 2018 11:51:31 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 11
 Oct 2018 11:51:31 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 11 Oct 2018 11:51:31 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9BGpVdG029936;
        Thu, 11 Oct 2018 11:51:31 -0500
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.172.124])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w9BGpVx20827;
        Thu, 11 Oct 2018 11:51:31 -0500 (CDT)
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <lee.jones@linaro.org>, <tony@atomide.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v3 9/9] leds: lm3633: Introduce the lm3633 driver
Date:   Thu, 11 Oct 2018 11:51:23 -0500
Message-ID: <20181011165123.32198-10-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20181011165123.32198-1-dmurphy@ti.com>
References: <20181011165123.32198-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the LED LM3633 driver.  This LED
driver has 9 total LED outputs with runtime
internal ramp configurations.

Data sheet:
http://www.ti.com/lit/ds/symlink/lm3633.pdf

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/leds/Kconfig       |   8 +
 drivers/leds/Makefile      |   1 +
 drivers/leds/leds-lm3633.c | 556 +++++++++++++++++++++++++++++++++++++
 3 files changed, 565 insertions(+)
 create mode 100644 drivers/leds/leds-lm3633.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 7d9a98044be4..1f9093e5d902 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -763,8 +763,16 @@ config LEDS_LM3697
           Say Y to enable the LED driver for TI LMU devices.
           This supports the LED device LM3697.
 
+config LEDS_LM3633
+	tristate "LED driver for LM3633"
+ 	depends on LEDS_TI_LMU_COMMON
+	help
+          Say Y to enable the LED driver for TI LMU devices.
+          This supports the LED device LM3633.
+
 config LEDS_TI_LMU_COMMON
 	tristate "LED driver for TI LMU"
+	depends on REGMAP
 	help
           Say Y to enable the LED driver for TI LMU devices.
           This supports common features between the TI LM3532, LM3631, LM3632,
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 6fbce7cfc41c..6ec006892fc0 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -79,6 +79,7 @@ obj-$(CONFIG_LEDS_LM3692X)		+= leds-lm3692x.o
 obj-$(CONFIG_LEDS_SC27XX_BLTC)		+= leds-sc27xx-bltc.o
 obj-$(CONFIG_LEDS_LM3601X)		+= leds-lm3601x.o
 obj-$(CONFIG_LEDS_LM3697)		+= leds-lm3697.o
+obj-$(CONFIG_LEDS_LM3633)		+= leds-lm3633.o
 obj-$(CONFIG_LEDS_TI_LMU_COMMON)	+= ti-lmu-led-common.o
 
 # LED SPI Drivers
diff --git a/drivers/leds/leds-lm3633.c b/drivers/leds/leds-lm3633.c
new file mode 100644
index 000000000000..de8eb7b83d20
--- /dev/null
+++ b/drivers/leds/leds-lm3633.c
@@ -0,0 +1,556 @@
+// SPDX-License-Identifier: GPL-2.0
+// TI LM3633 LED chip family driver
+// Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+
+#include <linux/gpio/consumer.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/ti-lmu-led-common.h>
+#include <linux/regulator/consumer.h>
+
+#define LM3633_REV			0x0
+#define LM3633_RESET			0x1
+#define LM3633_HVLED_OUTPUT_CONFIG	0x10
+#define LM3633_LVLED_OUTPUT_CONFIG	0x11
+
+#define LM3633_CTRL_A_RAMP		0x12
+#define LM3633_CTRL_B_RAMP		0x13
+#define LM3633_CTRL_C_RAMP		0x14
+#define LM3633_CTRL_D_RAMP		0x15
+#define LM3633_CTRL_E_RAMP		0x16
+#define LM3633_CTRL_F_RAMP		0x17
+#define LM3633_CTRL_G_RAMP		0x18
+#define LM3633_CTRL_H_RAMP		0x19
+
+#define LM3633_CTRL_A_B_RT_RAMP		0x1a
+#define LM3633_CTRL_A_B_RAMP_CFG	0x1b
+#define LM3633_CTRL_C_E_RT_RAMP		0x1c
+#define LM3633_CTRL_F_H_RT_RAMP		0x1d
+
+#define LM3633_CTRL_A_B_BRT_CFG		0x16
+#define LM3633_CTRL_A_FS_CURR_CFG	0x17
+#define LM3633_CTRL_B_FS_CURR_CFG	0x18
+#define LM3633_PWM_CFG			0x1c
+
+#define LM3633_CTRL_ENABLE		0x2b
+
+#define LM3633_CTRL_A_BRT_LSB		0x40
+#define LM3633_CTRL_A_BRT_MSB		0x41
+#define LM3633_CTRL_B_BRT_LSB		0x42
+#define LM3633_CTRL_B_BRT_MSB		0x43
+#define LM3633_CTRL_C_BRT		0x44
+#define LM3633_CTRL_D_BRT		0x45
+#define LM3633_CTRL_E_BRT		0x46
+#define LM3633_CTRL_F_BRT		0x47
+#define LM3633_CTRL_G_BRT		0x48
+#define LM3633_CTRL_H_BRT		0x49
+
+#define LM3633_SW_RESET		BIT(0)
+
+#define LM3633_CTRL_A_EN	BIT(0)
+#define LM3633_CTRL_B_EN	BIT(1)
+#define LM3633_CTRL_C_EN	BIT(2)
+#define LM3633_CTRL_D_EN	BIT(3)
+#define LM3633_CTRL_E_EN	BIT(4)
+#define LM3633_CTRL_F_EN	BIT(5)
+#define LM3633_CTRL_G_EN	BIT(6)
+#define LM3633_CTRL_H_EN	BIT(7)
+
+#define LM3633_MAX_HVLED_STRINGS	3
+#define LM3633_MAX_LVLED_STRINGS	6
+
+#define LM3633_CONTROL_A	0
+#define LM3633_CONTROL_B	1
+#define LM3633_CONTROL_C	2
+#define LM3633_CONTROL_D	3
+#define LM3633_CONTROL_E	4
+#define LM3633_CONTROL_F	5
+#define LM3633_CONTROL_G	6
+#define LM3633_CONTROL_H	7
+
+#define LM3633_MAX_CONTROL_BANKS 8
+
+#define LM3633_LED_ASSIGNMENT	1
+
+#define LM3633_CTRL_F_EN_MASK	0x07
+#define LM3633_CTRL_EN_OFFSET	2
+
+/**
+ * struct lm3633_led -
+ * @hvled_strings: Array of high voltage LED strings associated to control bank
+ * @lvled_strings: Array of low voltage LED strings associated to a control bank
+ * @label: LED label
+ * @led_dev: LED class device
+ * @priv: Pointer to the device struct
+ * @lmu_data: Register and setting values for common code
+ * @control_bank: Control bank the LED is associated to
+ */
+struct lm3633_led {
+	u32 hvled_strings[LM3633_MAX_HVLED_STRINGS];
+	u32 lvled_strings[LM3633_MAX_LVLED_STRINGS];
+	char label[LED_MAX_NAME_SIZE];
+	struct led_classdev led_dev;
+	struct lm3633 *priv;
+	struct ti_lmu_bank lmu_data;
+	int control_bank;
+};
+
+/**
+ * struct lm3633 -
+ * @enable_gpio - Hardware enable gpio
+ * @regulator - LED supply regulator pointer
+ * @client - Pointer to the I2C client
+ * @regmap - Devices register map
+ * @dev - Pointer to the devices device struct
+ * @lock - Lock for reading/writing the device
+ * @leds - Array of LED strings
+ */
+struct lm3633 {
+	struct gpio_desc *enable_gpio;
+	struct regulator *regulator;
+	struct i2c_client *client;
+	struct regmap *regmap;
+	struct device *dev;
+	struct mutex lock;
+	struct lm3633_led leds[];
+};
+
+static const struct reg_default lm3633_reg_defs[] = {
+	{LM3633_HVLED_OUTPUT_CONFIG, 0x6},
+	{LM3633_LVLED_OUTPUT_CONFIG, 0x36},
+	{LM3633_CTRL_A_RAMP, 0x0},
+	{LM3633_CTRL_B_RAMP, 0x0},
+	{LM3633_CTRL_A_B_RT_RAMP, 0x0},
+	{LM3633_CTRL_A_B_RAMP_CFG, 0x0},
+	{LM3633_CTRL_A_B_BRT_CFG, 0x0},
+	{LM3633_CTRL_A_FS_CURR_CFG, 0x13},
+	{LM3633_CTRL_B_FS_CURR_CFG, 0x13},
+	{LM3633_PWM_CFG, 0xc},
+	{LM3633_CTRL_A_BRT_LSB, 0x0},
+	{LM3633_CTRL_A_BRT_MSB, 0x0},
+	{LM3633_CTRL_B_BRT_LSB, 0x0},
+	{LM3633_CTRL_B_BRT_MSB, 0x0},
+	{LM3633_CTRL_ENABLE, 0x0},
+};
+
+static const struct regmap_config lm3633_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = LM3633_CTRL_H_BRT,
+	.reg_defaults = lm3633_reg_defs,
+	.num_reg_defaults = ARRAY_SIZE(lm3633_reg_defs),
+	.cache_type = REGCACHE_FLAT,
+};
+
+static int lm3633_brightness_set(struct led_classdev *led_cdev,
+				enum led_brightness brt_val)
+{
+	struct lm3633_led *led = container_of(led_cdev, struct lm3633_led,
+					      led_dev);
+	int ctrl_en_val;
+	int ret;
+
+	mutex_lock(&led->priv->lock);
+
+	switch (led->control_bank) {
+	case LM3633_CONTROL_A:
+		ctrl_en_val = LM3633_CTRL_A_EN;
+		break;
+	case LM3633_CONTROL_B:
+		ctrl_en_val = LM3633_CTRL_B_EN;
+		break;
+	case LM3633_CONTROL_C:
+		ctrl_en_val = LM3633_CTRL_C_EN;
+		break;
+	case LM3633_CONTROL_D:
+		ctrl_en_val = LM3633_CTRL_D_EN;
+		break;
+	case LM3633_CONTROL_E:
+		ctrl_en_val = LM3633_CTRL_E_EN;
+		break;
+	case LM3633_CONTROL_F:
+		ctrl_en_val = LM3633_CTRL_F_EN;
+		break;
+	case LM3633_CONTROL_G:
+		ctrl_en_val = LM3633_CTRL_G_EN;
+		break;
+	case LM3633_CONTROL_H:
+		ctrl_en_val = LM3633_CTRL_H_EN;
+		break;
+	default:
+		dev_err(&led->priv->client->dev, "Cannot write brightness\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (brt_val == LED_OFF)
+		ret = regmap_update_bits(led->priv->regmap, LM3633_CTRL_ENABLE,
+					 ctrl_en_val, ~ctrl_en_val);
+	else
+		ret = regmap_update_bits(led->priv->regmap, LM3633_CTRL_ENABLE,
+					 ctrl_en_val, ctrl_en_val);
+
+	ret = ti_lmu_common_set_brightness(&led->lmu_data, brt_val);
+	if (ret)
+		dev_err(&led->priv->client->dev, "Cannot write brightness\n");
+out:
+	mutex_unlock(&led->priv->lock);
+	return ret;
+}
+
+static void lm3633_set_control_bank_regs(struct lm3633_led *led)
+{
+	switch (led->control_bank) {
+	case LM3633_CONTROL_A:
+		led->lmu_data.msb_brightness_reg = LM3633_CTRL_A_BRT_MSB;
+		led->lmu_data.lsb_brightness_reg = LM3633_CTRL_A_BRT_LSB;
+		led->lmu_data.runtime_ramp_reg = LM3633_CTRL_A_RAMP;
+	case LM3633_CONTROL_B:
+		led->lmu_data.msb_brightness_reg = LM3633_CTRL_B_BRT_MSB;
+		led->lmu_data.lsb_brightness_reg = LM3633_CTRL_B_BRT_LSB;
+		led->lmu_data.runtime_ramp_reg = LM3633_CTRL_B_RAMP;
+		break;
+	case LM3633_CONTROL_C:
+		led->lmu_data.msb_brightness_reg = LM3633_CTRL_C_BRT;
+		led->lmu_data.runtime_ramp_reg = LM3633_CTRL_C_E_RT_RAMP;
+		break;
+	case LM3633_CONTROL_D:
+		led->lmu_data.msb_brightness_reg = LM3633_CTRL_D_BRT;
+		led->lmu_data.runtime_ramp_reg = LM3633_CTRL_C_E_RT_RAMP;
+		break;
+	case LM3633_CONTROL_E:
+		led->lmu_data.msb_brightness_reg = LM3633_CTRL_E_BRT;
+		led->lmu_data.runtime_ramp_reg = LM3633_CTRL_C_E_RT_RAMP;
+		break;
+	case LM3633_CONTROL_F:
+		led->lmu_data.msb_brightness_reg = LM3633_CTRL_F_BRT;
+		led->lmu_data.runtime_ramp_reg = LM3633_CTRL_F_H_RT_RAMP;
+		break;
+	case LM3633_CONTROL_G:
+		led->lmu_data.msb_brightness_reg = LM3633_CTRL_G_BRT;
+		led->lmu_data.runtime_ramp_reg = LM3633_CTRL_F_H_RT_RAMP;
+		break;
+	case LM3633_CONTROL_H:
+		led->lmu_data.msb_brightness_reg = LM3633_CTRL_H_BRT;
+		led->lmu_data.runtime_ramp_reg = LM3633_CTRL_F_H_RT_RAMP;
+		break;
+	default:
+		dev_err(&led->priv->client->dev,
+			"Control bank is out of bounds\n");
+	}
+}
+
+static int lm3633_set_control_bank(struct lm3633 *priv)
+{
+	u8 control_bank_config = 0;
+	struct lm3633_led *led;
+	int ret, i;
+
+	led = &priv->leds[0];
+	if (led->control_bank == LM3633_CONTROL_A) {
+		lm3633_set_control_bank_regs(led);
+		led = &priv->leds[1];
+	}
+
+	if (led->control_bank >= LM3633_CONTROL_C)
+		return 0;
+
+	lm3633_set_control_bank_regs(led);
+	for (i = 0; i < LM3633_MAX_HVLED_STRINGS; i++)
+		if (led->hvled_strings[i] == LM3633_LED_ASSIGNMENT)
+			control_bank_config |= 1 << i;
+
+	ret = regmap_write(priv->regmap, LM3633_HVLED_OUTPUT_CONFIG,
+			   control_bank_config);
+	if (ret)
+		dev_err(&priv->client->dev, "Cannot write OUTPUT config\n");
+
+	return ret;
+}
+
+static int lm3633_set_lvled_control_bank(struct lm3633 *priv)
+{
+	u8 control_bank_config = 0;
+	struct lm3633_led *led;
+	int ret, i;
+
+	for (i = 0; i <= LM3633_MAX_CONTROL_BANKS; i++) {
+		led = &priv->leds[i];
+		if (led) {
+			if (led->control_bank < LM3633_CONTROL_C)
+				continue;
+
+			if (led->lvled_strings[0]) {
+				if (led->control_bank == LM3633_CONTROL_C)
+					control_bank_config = 0x0;
+				else if (led->control_bank == LM3633_CONTROL_F)
+					control_bank_config &= LM3633_CTRL_F_EN_MASK;
+				else
+					control_bank_config |= 1 << (led->control_bank - LM3633_CTRL_EN_OFFSET);
+			}
+		} else
+			continue;
+
+		lm3633_set_control_bank_regs(led);
+	}
+
+	ret = regmap_write(priv->regmap, LM3633_LVLED_OUTPUT_CONFIG,
+			   control_bank_config);
+	if (ret)
+		dev_err(&priv->client->dev, "Cannot write OUTPUT config\n");
+
+	return ret;
+}
+
+static int lm3633_init(struct lm3633 *priv)
+{
+	struct lm3633_led *led;
+	int i, ret;
+
+	if (priv->enable_gpio) {
+		gpiod_direction_output(priv->enable_gpio, 1);
+	} else {
+		ret = regmap_write(priv->regmap, LM3633_RESET, LM3633_SW_RESET);
+		if (ret) {
+			dev_err(&priv->client->dev,
+				"Cannot reset the device\n");
+			goto out;
+		}
+	}
+
+	ret = regmap_write(priv->regmap, LM3633_CTRL_ENABLE, 0x0);
+	if (ret) {
+		dev_err(&priv->client->dev, "Cannot write ctrl enable\n");
+		goto out;
+	}
+
+	ret = lm3633_set_control_bank(priv);
+	if (ret)
+		dev_err(&priv->client->dev, "Setting the CRTL bank failed\n");
+
+	ret = lm3633_set_lvled_control_bank(priv);
+	if (ret)
+		dev_err(&priv->client->dev,
+			"Setting the lvled CRTL bank failed\n");
+
+	for (i = 0; i < LM3633_MAX_CONTROL_BANKS; i++) {
+		led = &priv->leds[i];
+		if (led->lmu_data.runtime_ramp_reg) {
+			ti_lmu_common_set_ramp(&led->lmu_data);
+			if (ret)
+				dev_err(&priv->client->dev,
+					"Setting the ramp rate failed\n");
+		}
+	}
+out:
+	return ret;
+}
+
+static int lm3633_parse_hvled_sources(struct fwnode_handle *child,
+			      struct lm3633_led *led)
+{
+	struct lm3633 *priv = led->priv;
+	int ret;
+
+	ret = fwnode_property_read_u32_array(child, "led-sources",
+			    led->hvled_strings,
+			    LM3633_MAX_HVLED_STRINGS);
+
+	if (ret)
+		dev_err(&priv->client->dev, "Cannot write OUTPUT config\n");
+
+	return ret;
+}
+
+static int lm3633_parse_lvled_sources(struct fwnode_handle *child,
+			      struct lm3633_led *led)
+{
+	struct lm3633 *priv = led->priv;
+	int ret;
+
+	ret = fwnode_property_read_u32_array(child, "led-sources",
+			    led->lvled_strings, 1);
+	if (ret)
+		dev_err(&priv->client->dev, "Cannot write OUTPUT config\n");
+
+	led->lmu_data.max_brightness = MAX_BRIGHTNESS_8BIT;
+
+	return 0;
+}
+
+static int lm3633_probe_dt(struct lm3633 *priv)
+{
+	struct fwnode_handle *child = NULL;
+	struct lm3633_led *led;
+	const char *name;
+	int control_bank;
+	size_t i = 0;
+	int ret;
+
+	priv->enable_gpio = devm_gpiod_get_optional(&priv->client->dev,
+						   "enable", GPIOD_OUT_LOW);
+	if (IS_ERR(priv->enable_gpio)) {
+		ret = PTR_ERR(priv->enable_gpio);
+		dev_err(&priv->client->dev, "Failed to get enable gpio: %d\n",
+			ret);
+		return ret;
+	}
+
+	priv->regulator = devm_regulator_get(&priv->client->dev, "vled");
+	if (IS_ERR(priv->regulator))
+		priv->regulator = NULL;
+
+	device_for_each_child_node(priv->dev, child) {
+		ret = fwnode_property_read_u32(child, "reg", &control_bank);
+		if (ret) {
+			dev_err(&priv->client->dev, "reg property missing\n");
+			fwnode_handle_put(child);
+			goto child_out;
+		}
+
+		if (control_bank > LM3633_MAX_CONTROL_BANKS) {
+			dev_err(&priv->client->dev,
+				"reg property is invalid\n");
+			ret = -EINVAL;
+			fwnode_handle_put(child);
+			goto child_out;
+		}
+
+		led = &priv->leds[i];
+		led->control_bank = control_bank;
+		led->lmu_data.bank_id = control_bank;
+		led->lmu_data.regmap = priv->regmap;
+		led->lmu_data.enable_reg = LM3633_CTRL_ENABLE;
+
+		if (control_bank > LM3633_CONTROL_B)
+			lm3633_parse_lvled_sources(child, led);
+		else
+			lm3633_parse_hvled_sources(child, led);
+
+		ret = ti_lmu_common_get_ramp_params(&priv->client->dev,
+						    child, &led->lmu_data);
+		if (ret)
+			dev_warn(&priv->client->dev,
+				 "runtime-ramp properties missing\n");
+
+		fwnode_property_read_string(child, "linux,default-trigger",
+					    &led->led_dev.default_trigger);
+
+		ret = fwnode_property_read_string(child, "label", &name);
+		if (ret)
+			snprintf(led->label, sizeof(led->label),
+				"%s::", priv->client->name);
+		else
+			snprintf(led->label, sizeof(led->label),
+				 "%s:%s", priv->client->name, name);
+
+		led->priv = priv;
+		led->led_dev.name = led->label;
+		led->led_dev.brightness_set_blocking = lm3633_brightness_set;
+
+		ret = devm_led_classdev_register(priv->dev, &led->led_dev);
+		if (ret) {
+			dev_err(&priv->client->dev, "led register err: %d\n",
+				ret);
+			fwnode_handle_put(child);
+			goto child_out;
+		}
+
+		i++;
+	}
+
+child_out:
+	return ret;
+}
+
+static int lm3633_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct lm3633 *led;
+	int count;
+	int ret;
+
+	count = device_get_child_node_count(&client->dev);
+	if (!count) {
+		dev_err(&client->dev, "LEDs are not defined in device tree!");
+		return -ENODEV;
+	}
+
+	led = devm_kzalloc(&client->dev, struct_size(led, leds, count),
+			   GFP_KERNEL);
+	if (!led)
+		return -ENOMEM;
+
+	mutex_init(&led->lock);
+	i2c_set_clientdata(client, led);
+
+	led->client = client;
+	led->dev = &client->dev;
+	led->regmap = devm_regmap_init_i2c(client, &lm3633_regmap_config);
+	if (IS_ERR(led->regmap)) {
+		ret = PTR_ERR(led->regmap);
+		dev_err(&client->dev, "Failed to allocate register map: %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = lm3633_probe_dt(led);
+	if (ret)
+		return ret;
+
+	return lm3633_init(led);
+}
+
+static int lm3633_remove(struct i2c_client *client)
+{
+	struct lm3633 *led = i2c_get_clientdata(client);
+	int ret;
+
+	ret = regmap_write(led->regmap, LM3633_CTRL_ENABLE, 0);
+	if (ret) {
+		dev_err(&led->client->dev, "Failed to disable the device\n");
+		return ret;
+	}
+
+	if (led->enable_gpio)
+		gpiod_direction_output(led->enable_gpio, 0);
+
+	if (led->regulator) {
+		ret = regulator_disable(led->regulator);
+		if (ret)
+			dev_err(&led->client->dev,
+				"Failed to disable regulator\n");
+	}
+
+	mutex_destroy(&led->lock);
+
+	return 0;
+}
+
+static const struct i2c_device_id lm3633_id[] = {
+	{ "lm3633", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, lm3633_id);
+
+static const struct of_device_id of_lm3633_leds_match[] = {
+	{ .compatible = "ti,lm3633", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_lm3633_leds_match);
+
+static struct i2c_driver lm3633_driver = {
+	.driver = {
+		.name	= "lm3633",
+		.of_match_table = of_lm3633_leds_match,
+	},
+	.probe		= lm3633_probe,
+	.remove		= lm3633_remove,
+	.id_table	= lm3633_id,
+};
+module_i2c_driver(lm3633_driver);
+
+MODULE_DESCRIPTION("Texas Instruments LM3633 LED driver");
+MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.19.0

