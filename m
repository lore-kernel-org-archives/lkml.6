Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751972AbeB1BWJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 20:22:09 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39281 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751885AbeB1BVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 20:21:47 -0500
X-Google-Smtp-Source: AH8x227qHVFlp1XKZKnyvwKcfTVG2536Ldt16xCgqRWU6LcQlnHgMNU6f6lkTotpOytW/juQKNUTLw==
From: Tim Harvey <tharvey@gateworks.com>
To: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [RFC 3/4] hwmon: add Gateworks System Controller support
Date: Tue, 27 Feb 2018 17:21:13 -0800
Message-Id: <1519780874-8558-4-git-send-email-tharvey@gateworks.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519780874-8558-1-git-send-email-tharvey@gateworks.com>
References: <1519780874-8558-1-git-send-email-tharvey@gateworks.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Gateworks System Controller has a hwmon sub-component that exposes
up to 16 ADC's, some of which are temperature sensors, others which are
voltage inputs. The ADC configuration (register mapping and name) is
configured via device-tree and varies board to board.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/hwmon/Kconfig     |   6 +
 drivers/hwmon/Makefile    |   1 +
 drivers/hwmon/gsc-hwmon.c | 299 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 306 insertions(+)
 create mode 100644 drivers/hwmon/gsc-hwmon.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 7ad0176..9cdc3cb 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -475,6 +475,12 @@ config SENSORS_F75375S
 	  This driver can also be built as a module.  If so, the module
 	  will be called f75375s.
 
+config SENSORS_GSC
+        tristate "Gateworks System Controller ADC"
+        depends on MFD_GSC
+        help
+          Support for the Gateworks System Controller A/D converters.
+
 config SENSORS_MC13783_ADC
         tristate "Freescale MC13783/MC13892 ADC"
         depends on MFD_MC13XXX
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 0fe489f..835a536 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_SENSORS_G760A)	+= g760a.o
 obj-$(CONFIG_SENSORS_G762)	+= g762.o
 obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
 obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
+obj-$(CONFIG_SENSORS_GSC)	+= gsc-hwmon.o
 obj-$(CONFIG_SENSORS_GPIO_FAN)	+= gpio-fan.o
 obj-$(CONFIG_SENSORS_HIH6130)	+= hih6130.o
 obj-$(CONFIG_SENSORS_ULTRA45)	+= ultra45_env.o
diff --git a/drivers/hwmon/gsc-hwmon.c b/drivers/hwmon/gsc-hwmon.c
new file mode 100644
index 0000000..3e14bea
--- /dev/null
+++ b/drivers/hwmon/gsc-hwmon.c
@@ -0,0 +1,299 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Gateworks Corporation
+ */
+#define DEBUG
+
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/mfd/gsc.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+/* map channel to channel info */
+struct gsc_hwmon_ch {
+	u8 reg;
+	char name[32];
+};
+static struct gsc_hwmon_ch gsc_temp_ch[16];
+static struct gsc_hwmon_ch gsc_in_ch[16];
+static struct gsc_hwmon_ch gsc_fan_ch[5];
+
+static int
+gsc_hwmon_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
+	       int ch, long *val)
+{
+	struct gsc_dev *gsc = dev_get_drvdata(dev);
+	int sz, ret;
+	u8 reg;
+	u8 buf[3];
+
+	dev_dbg(dev, "%s type=%d attr=%d ch=%d\n", __func__, type, attr, ch);
+	switch (type) {
+	case hwmon_in:
+		sz = 3;
+		reg = gsc_in_ch[ch].reg;
+		break;
+	case hwmon_temp:
+		sz = 2;
+		reg = gsc_temp_ch[ch].reg;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	ret = regmap_bulk_read(gsc->regmap_hwmon, reg, &buf, sz);
+	if (!ret) {
+		*val = 0;
+		while (sz-- > 0)
+			*val |= (buf[sz] << (8*sz));
+		if ((type == hwmon_temp) && *val > 0x8000)
+			*val -= 0xffff;
+	}
+
+	return ret;
+}
+
+static int
+gsc_hwmon_read_string(struct device *dev, enum hwmon_sensor_types type,
+		      u32 attr, int ch, const char **buf)
+{
+	dev_dbg(dev, "%s type=%d attr=%d ch=%d\n", __func__, type, attr, ch);
+	switch (type) {
+	case hwmon_in:
+	case hwmon_temp:
+	case hwmon_fan:
+		switch (attr) {
+		case hwmon_in_label:
+			*buf = gsc_in_ch[ch].name;
+			return 0;
+			break;
+		case hwmon_temp_label:
+			*buf = gsc_temp_ch[ch].name;
+			return 0;
+			break;
+		case hwmon_fan_label:
+			*buf = gsc_fan_ch[ch].name;
+			return 0;
+			break;
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return -ENOTSUPP;
+}
+
+static int
+gsc_hwmon_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
+	       int ch, long val)
+{
+	struct gsc_dev *gsc = dev_get_drvdata(dev);
+	int ret;
+	u8 reg;
+	u8 buf[3];
+
+	dev_dbg(dev, "%s type=%d attr=%d ch=%d\n", __func__, type, attr, ch);
+	switch (type) {
+	case hwmon_fan:
+		buf[0] = val & 0xff;
+		buf[1] = (val >> 8) & 0xff;
+		reg = gsc_fan_ch[ch].reg;
+		ret = regmap_bulk_write(gsc->regmap_hwmon, reg, &buf, 2);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	return ret;
+}
+
+static umode_t
+gsc_hwmon_is_visible(const void *_data, enum hwmon_sensor_types type, u32 attr,
+		     int ch)
+{
+	const struct gsc_dev *gsc = _data;
+	struct device *dev = gsc->dev;
+	umode_t mode = 0;
+
+	switch (type) {
+	case hwmon_fan:
+		if (attr == hwmon_fan_input)
+			mode = (S_IRUGO | S_IWUSR);
+		break;
+	case hwmon_temp:
+	case hwmon_in:
+		mode = S_IRUGO;
+		break;
+	default:
+		break;
+	}
+	dev_dbg(dev, "%s type=%d attr=%d ch=%d mode=0x%x\n", __func__, type,
+		attr, ch, mode);
+
+	return mode;
+}
+
+static u32 gsc_in_config[] = {
+	HWMON_I_INPUT,
+	HWMON_I_INPUT,
+	HWMON_I_INPUT,
+	HWMON_I_INPUT,
+	HWMON_I_INPUT,
+	HWMON_I_INPUT,
+	HWMON_I_INPUT,
+	HWMON_I_INPUT,
+	HWMON_I_INPUT,
+	HWMON_I_INPUT,
+	HWMON_I_INPUT,
+	HWMON_I_INPUT,
+	HWMON_I_INPUT,
+	HWMON_I_INPUT,
+	HWMON_I_INPUT,
+	HWMON_I_INPUT,
+	0
+};
+static const struct hwmon_channel_info gsc_in = {
+	.type = hwmon_in,
+	.config = gsc_in_config,
+};
+
+static u32 gsc_temp_config[] = {
+	HWMON_T_INPUT,
+	HWMON_T_INPUT,
+	HWMON_T_INPUT,
+	HWMON_T_INPUT,
+	HWMON_T_INPUT,
+	HWMON_T_INPUT,
+	HWMON_T_INPUT,
+	HWMON_T_INPUT,
+	0
+};
+static const struct hwmon_channel_info gsc_temp = {
+	.type = hwmon_temp,
+	.config = gsc_temp_config,
+};
+
+static u32 gsc_fan_config[] = {
+	HWMON_F_INPUT,
+	HWMON_F_INPUT,
+	HWMON_F_INPUT,
+	HWMON_F_INPUT,
+	HWMON_F_INPUT,
+	HWMON_F_INPUT,
+	0,
+};
+static const struct hwmon_channel_info gsc_fan = {
+	.type = hwmon_fan,
+	.config = gsc_fan_config,
+};
+
+static const struct hwmon_channel_info *gsc_info[] = {
+	&gsc_temp,
+	&gsc_in,
+	&gsc_fan,
+	NULL
+};
+
+static const struct hwmon_ops gsc_hwmon_ops = {
+	.is_visible = gsc_hwmon_is_visible,
+	.read = gsc_hwmon_read,
+	.read_string = gsc_hwmon_read_string,
+	.write = gsc_hwmon_write,
+};
+
+static const struct hwmon_chip_info gsc_chip_info = {
+	.ops = &gsc_hwmon_ops,
+	.info = gsc_info,
+};
+
+static int gsc_hwmon_probe(struct platform_device *pdev)
+{
+	struct gsc_dev *gsc = dev_get_drvdata(pdev->dev.parent);
+	struct device_node *np;
+	struct device *hwmon;
+	int temp_count = 0;
+	int in_count = 0;
+	int fan_count = 0;
+	int ret;
+
+	dev_dbg(&pdev->dev, "%s\n", __func__);
+	np = of_get_next_child(pdev->dev.of_node, NULL);
+	while (np) {
+		u32 reg, type;
+		const char *label;
+
+		of_property_read_u32(np, "reg", &reg);
+		of_property_read_u32(np, "type", &type);
+		label = of_get_property(np, "label", NULL);
+		switch(type) {
+		case 0: /* temperature sensor */
+			gsc_temp_config[temp_count] = HWMON_T_INPUT |
+						      HWMON_T_LABEL;
+			gsc_temp_ch[temp_count].reg = reg;
+			strncpy(gsc_temp_ch[temp_count].name, label, 32);
+			if (temp_count < ARRAY_SIZE(gsc_temp_config))
+				temp_count++;
+			break;
+		case 1: /* voltage sensor */
+			gsc_in_config[in_count] = HWMON_I_INPUT |
+						  HWMON_I_LABEL;
+			gsc_in_ch[in_count].reg = reg;
+			strncpy(gsc_in_ch[in_count].name, label, 32);
+			if (in_count < ARRAY_SIZE(gsc_in_config))
+				in_count++;
+			break;
+		case 2: /* fan controller setpoint */
+			gsc_fan_config[fan_count] = HWMON_F_INPUT |
+						    HWMON_F_LABEL;
+			gsc_fan_ch[fan_count].reg = reg;
+			strncpy(gsc_fan_ch[fan_count].name, label, 32);
+			if (fan_count < ARRAY_SIZE(gsc_fan_config))
+				fan_count++;
+			break;
+		}
+		np = of_get_next_child(pdev->dev.of_node, np);
+	}
+	/* terminate list */
+	gsc_in_config[in_count] = 0;
+	gsc_temp_config[temp_count] = 0;
+	gsc_fan_config[fan_count] = 0;
+
+	hwmon = devm_hwmon_device_register_with_info(&pdev->dev,
+						     KBUILD_MODNAME, gsc,
+						     &gsc_chip_info, NULL);
+	if (IS_ERR(hwmon)) {
+		ret = PTR_ERR(hwmon);
+		dev_err(&pdev->dev, "Unable to register hwmon device: %d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id gsc_hwmon_of_match[] = {
+	{ .compatible = "gw,gsc-hwmon", },
+	{}
+};
+
+static struct platform_driver gsc_hwmon_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.of_match_table = gsc_hwmon_of_match,
+	},
+	.probe = gsc_hwmon_probe,
+};
+
+module_platform_driver(gsc_hwmon_driver);
+
+MODULE_AUTHOR("Tim Harvey <tharvey@gateworks.com>");
+MODULE_DESCRIPTION("GSC hardware monitor driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
