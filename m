Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29F5C10F08
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 14:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0D021916
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 14:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfBQO21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 09:28:27 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:58971 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbfBQO2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 09:28:24 -0500
X-Originating-IP: 91.192.165.7
Received: from pc.localdomain (unknown [91.192.165.7])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 2328A1BF203;
        Sun, 17 Feb 2019 14:28:19 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Sebastian Reichel <sre@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH 5/7] power: supply: add Ingenic JZ47xx battery driver.
Date:   Sun, 17 Feb 2019 15:29:14 +0100
Message-Id: <20190217142914.17433-5-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190217142914.17433-1-contact@artur-rojek.eu>
References: <20190217142914.17433-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for battery present on Ingenic JZ47xx SoCs.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---
 drivers/power/supply/Kconfig           |  11 ++
 drivers/power/supply/Makefile          |   1 +
 drivers/power/supply/ingenic-battery.c | 182 +++++++++++++++++++++++++
 3 files changed, 194 insertions(+)
 create mode 100644 drivers/power/supply/ingenic-battery.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index e901b9879e7e..9bfb1637ec28 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -169,6 +169,17 @@ config BATTERY_COLLIE
 	  Say Y to enable support for the battery on the Sharp Zaurus
 	  SL-5500 (collie) models.
 
+config BATTERY_INGENIC
+	tristate "Ingenic JZ47xx SoCs battery driver"
+	depends on MIPS || COMPILE_TEST
+	depends on INGENIC_ADC
+	help
+	  Choose this option if you want to monitor battery status on
+	  Ingenic JZ47xx SoC based devices.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called ingenic-battery.
+
 config BATTERY_IPAQ_MICRO
 	tristate "iPAQ Atmel Micro ASIC battery driver"
 	depends on MFD_IPAQ_MICRO
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index b731c2a9b695..9e2c481d0187 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_BATTERY_PMU)	+= pmu_battery.o
 obj-$(CONFIG_BATTERY_OLPC)	+= olpc_battery.o
 obj-$(CONFIG_BATTERY_TOSA)	+= tosa_battery.o
 obj-$(CONFIG_BATTERY_COLLIE)	+= collie_battery.o
+obj-$(CONFIG_BATTERY_INGENIC)	+= ingenic-battery.o
 obj-$(CONFIG_BATTERY_IPAQ_MICRO) += ipaq_micro_battery.o
 obj-$(CONFIG_BATTERY_WM97XX)	+= wm97xx_battery.o
 obj-$(CONFIG_BATTERY_SBS)	+= sbs-battery.o
diff --git a/drivers/power/supply/ingenic-battery.c b/drivers/power/supply/ingenic-battery.c
new file mode 100644
index 000000000000..4ee75c1ac241
--- /dev/null
+++ b/drivers/power/supply/ingenic-battery.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Battery driver for the Ingenic JZ47xx SoCs
+ * Copyright (c) 2019 Artur Rojek <contact@artur-rojek.eu>
+ *
+ * based on drivers/power/supply/jz4740-battery.c
+ */
+
+#include <linux/iio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/property.h>
+
+struct ingenic_battery {
+	struct device *dev;
+	struct iio_channel *channel;
+	struct power_supply_desc desc;
+	struct power_supply *battery;
+	struct power_supply_battery_info info;
+};
+
+static int ingenic_battery_get_property(struct power_supply *psy,
+					enum power_supply_property psp,
+					union power_supply_propval *val)
+{
+	struct ingenic_battery *bat = power_supply_get_drvdata(psy);
+	struct power_supply_battery_info *info = &bat->info;
+	int ret = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_HEALTH:
+		ret = iio_read_channel_processed(bat->channel, &val->intval);
+		val->intval *= 1000;
+		if (val->intval < info->voltage_min_design_uv)
+			val->intval = POWER_SUPPLY_HEALTH_DEAD;
+		else if (val->intval > info->voltage_max_design_uv)
+			val->intval = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
+		else
+			val->intval = POWER_SUPPLY_HEALTH_GOOD;
+	break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		ret = iio_read_channel_processed(bat->channel, &val->intval);
+		val->intval *= 1000;
+	break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
+		val->intval = info->voltage_min_design_uv;
+	break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
+		val->intval = info->voltage_max_design_uv;
+	break;
+	default:
+		return -EINVAL;
+	};
+
+	return ret;
+}
+
+/* Set the most appropriate IIO channel voltage reference scale
+ * based on the battery's max voltage.
+ */
+static int ingenic_battery_set_scale(struct ingenic_battery *bat)
+{
+	const int *scale_raw;
+	int scale_len, scale_type, best_idx = -1, best_mV, max_raw, i, ret;
+	u64 max_mV;
+
+	ret = iio_read_max_channel_raw(bat->channel, &max_raw);
+	if (ret) {
+		dev_err(bat->dev, "Unable to read max raw channel value\n");
+		return ret;
+	}
+
+	ret = iio_read_avail_channel_attribute(bat->channel, &scale_raw,
+					       &scale_type, &scale_len,
+					       IIO_CHAN_INFO_SCALE);
+	if (ret < 0) {
+		dev_err(bat->dev, "Unable to read channel avail scale\n");
+		return ret;
+	}
+	if (ret != IIO_AVAIL_LIST || scale_type != IIO_VAL_FRACTIONAL_LOG2)
+		return -EINVAL;
+
+	max_mV = bat->info.voltage_max_design_uv / 1000;
+
+	for (i = 1; i < scale_len; i += 2) {
+		u64 scale_mV = (max_raw * scale_raw[i - 1]) >> scale_raw[i];
+
+		if (scale_mV < max_mV)
+			continue;
+
+		if (best_idx >= 0 && scale_mV > best_mV)
+			continue;
+
+		best_mV = scale_mV;
+		best_idx = i - 1;
+	}
+
+	if (best_idx < 0) {
+		dev_err(bat->dev, "Unable to find matching voltage scale\n");
+		return -EINVAL;
+	}
+
+	return iio_write_channel_attribute(bat->channel,
+					   scale_raw[best_idx],
+					   scale_raw[best_idx+1],
+					   IIO_CHAN_INFO_SCALE);
+}
+
+static enum power_supply_property ingenic_battery_properties[] = {
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
+};
+
+static int ingenic_battery_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ingenic_battery *bat;
+	struct power_supply_config psy_cfg = {};
+	struct power_supply_desc *desc;
+	int ret;
+
+	bat = devm_kzalloc(dev, sizeof(*bat), GFP_KERNEL);
+	if (!bat)
+		return -ENOMEM;
+
+	bat->dev = dev;
+	bat->channel = devm_iio_channel_get(dev, "battery");
+	if (IS_ERR(bat->channel))
+		return PTR_ERR(bat->channel);
+
+	desc = &bat->desc;
+	desc->name = "jz-battery";
+	desc->type = POWER_SUPPLY_TYPE_BATTERY;
+	desc->properties = ingenic_battery_properties;
+	desc->num_properties = ARRAY_SIZE(ingenic_battery_properties);
+	desc->get_property = ingenic_battery_get_property;
+	psy_cfg.drv_data = bat;
+	psy_cfg.of_node = dev->of_node;
+
+	bat->battery = devm_power_supply_register(dev, desc, &psy_cfg);
+	if (IS_ERR(bat->battery)) {
+		dev_err(dev, "Unable to register battery\n");
+		return PTR_ERR(bat->battery);
+	}
+
+	ret = power_supply_get_battery_info(bat->battery, &bat->info);
+	if (ret) {
+		dev_err(dev, "Unable to get battery info: %d\n", ret);
+		return ret;
+	}
+	if (bat->info.voltage_min_design_uv < 0) {
+		dev_err(dev, "Unable to get voltage min design\n");
+		return bat->info.voltage_min_design_uv;
+	}
+	if (bat->info.voltage_max_design_uv < 0) {
+		dev_err(dev, "Unable to get voltage max design\n");
+		return bat->info.voltage_max_design_uv;
+	}
+
+	return ingenic_battery_set_scale(bat);
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id ingenic_battery_of_match[] = {
+	{ .compatible = "ingenic,jz4740-battery", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ingenic_battery_of_match);
+#endif
+
+static struct platform_driver ingenic_battery_driver = {
+	.driver = {
+		.name = "ingenic-battery",
+		.of_match_table = of_match_ptr(ingenic_battery_of_match),
+	},
+	.probe = ingenic_battery_probe,
+};
+module_platform_driver(ingenic_battery_driver);
-- 
2.20.1

