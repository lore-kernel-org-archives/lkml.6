Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D51EC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9B1217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbfBLBDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 20:03:12 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:43224 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728089AbfBLBDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 20:03:04 -0500
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1C11GgN001119;
        Mon, 11 Feb 2019 19:02:58 -0600
Received: from ni.com (skprod3.natinst.com [130.164.80.24])
        by mx0a-00010702.pphosted.com with ESMTP id 2qhw8uh4v6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Feb 2019 19:02:58 -0600
Received: from us-aus-exch1.ni.corp.natinst.com (us-aus-exch1.ni.corp.natinst.com [130.164.68.11])
        by us-aus-skprod3.natinst.com (8.16.0.27/8.16.0.27) with ESMTPS id x1C12uUJ016810
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 11 Feb 2019 19:02:56 -0600
Received: from us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) by
 us-aus-exch1.ni.corp.natinst.com (130.164.68.11) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Mon, 11 Feb 2019 19:02:56 -0600
Received: from nisurp-linux-2.ni.corp.natinst.com (130.164.49.7) by
 us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) with Microsoft SMTP Server
 id 15.0.1395.4 via Frontend Transport; Mon, 11 Feb 2019 19:02:56 -0600
From:   Virendra Kakade <virendra.kakade@ni.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC:     <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <sre@kernel.org>,
        <moritz.fischer@ettus.com>,
        Virendra Kakade <virendra.kakade@ni.com>
Subject: [RFC 6/6] power: supply: Ettus Research E31x battery driver
Date:   Mon, 11 Feb 2019 19:01:43 -0600
Message-ID: <20190212010143.3729-7-virendra.kakade@ni.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212010143.3729-1-virendra.kakade@ni.com>
References: <20190212010143.3729-1-virendra.kakade@ni.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-12_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for E31x devices battery which is a sub-device of E31X-PMU.
Enables query of battery properties from device tree.

Signed-off-by: Virendra Kakade <virendra.kakade@ni.com>
---
 drivers/power/supply/Kconfig        |   6 +
 drivers/power/supply/Makefile       |   1 +
 drivers/power/supply/e31x-battery.c | 357 ++++++++++++++++++++++++++++
 include/linux/mfd/e31x-pmu.h        |  15 +-
 4 files changed, 377 insertions(+), 2 deletions(-)
 create mode 100644 drivers/power/supply/e31x-battery.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 3d043b8fd49c..e05e02dffc49 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -666,4 +666,10 @@ config E31X_CHARGER
 	help
 	 This adds support for the battery charger in Ettus Research E31x PMU.
 
+config E31X_BATTERY
+	tristate "Ettus Research E31x battery support"
+	depends on MFD_E31X_PMU
+	help
+	 This adds support for the battery in Ettus Research E31x PMU.
+
 endif # POWER_SUPPLY
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 6f4f8ca5484e..3850d08db942 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -88,3 +88,4 @@ obj-$(CONFIG_CHARGER_CROS_USBPD)	+= cros_usbpd-charger.o
 obj-$(CONFIG_CHARGER_SC2731)	+= sc2731_charger.o
 obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+= sc27xx_fuel_gauge.o
 obj-$(CONFIG_E31X_CHARGER)	+= e31x-charger.o
+obj-$(CONFIG_E31X_BATTERY)	+= e31x-battery.o
diff --git a/drivers/power/supply/e31x-battery.c b/drivers/power/supply/e31x-battery.c
new file mode 100644
index 000000000000..d44a639e8bc2
--- /dev/null
+++ b/drivers/power/supply/e31x-battery.c
@@ -0,0 +1,357 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 National Instruments Corp
+ * Author: Virendra Kakade <virendra.kakade@ni.com>
+ *
+ * Ettus Research E31x battery driver
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/power_supply.h>
+#include <linux/delay.h>
+#include <linux/mfd/e31x-pmu.h>
+
+
+#define E31X_PMU_BATTERY_VOLTAGE_MASK		GENMASK(23, 8)
+#define E31X_PMU_BATTERY_VOLTAGE_SHIFT		8
+#define E31X_PMU_BATTERY_TEMP_ALERT_MASK	GENMASK(7, 6)
+#define E31X_PMU_BATTERY_TEMP_ALERT_SHIFT	6
+#define E31X_PMU_BATTERY_ONLINE_MASK		BIT(5)
+#define E31X_PMU_BATTERY_ONLINE_SHIFT		5
+#define E31X_PMU_BATTERY_HEALTH_MASK		GENMASK(4, 2)
+#define E31X_PMU_BATTERY_HEALTH_SHIFT		2
+#define E31X_PMU_BATTERY_STATUS_MASK		GENMASK(1, 0)
+#define E31X_PMU_BATTERY_STATUS_SHIFT		0
+
+#define E31X_PMU_GAUGE_TEMP_MASK		GENMASK(31, 16)
+#define E31X_PMU_GAUGE_TEMP_SHIFT		16
+#define E31X_PMU_GAUGE_CHARGE_MASK		GENMASK(15, 0)
+#define E31X_PMU_GAUGE_CHARGE_SHIFT		0
+
+#define E31X_PMU_GAUGE_VOLTAGE_MASK		GENMASK(15, 0)
+#define E31X_PMU_GAUGE_VOLTAGE_SHIFT		0
+
+#define E31X_PMU_GAUGE_CHARGE_LAST_FULL_MASK	GENMASK(15, 0)
+#define E31X_PMU_GAUGE_CHARGE_LAST_FULL_SHIFT	0
+
+#define E31X_BATTERY_CHARGE_DESIGN_FULL		(3200000)
+#define E31X_PMU_VSENSE				(6000)
+
+struct e31x_battery_dev {
+	struct regmap *regmap;
+	struct power_supply *supply;
+};
+
+static int e31x_battery_set_prop(struct power_supply *psy,
+				 enum power_supply_property psp,
+				 const union power_supply_propval *val)
+{
+	return 0;
+}
+
+static int e31x_battery_get_status(struct e31x_battery_dev *bat,
+				   union power_supply_propval *val)
+{
+	u32 value;
+	int err;
+
+	err = regmap_read(bat->regmap, E31X_PMU_REG_CHARGER, &value);
+	if (err)
+		return err;
+
+	value = E31X_PMU_GET_FIELD(CHARGER_ONLINE, value);
+
+	/* if charger is offline, we're discharging, period */
+	if (!value) {
+		val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		return 0;
+	}
+
+	err = regmap_read(bat->regmap, E31X_PMU_REG_BATTERY, &value);
+	if (err)
+		return err;
+
+	value &= E31X_PMU_BATTERY_STATUS_MASK;
+
+	switch (value) {
+	case 0x0:
+		val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		break;
+	case 0x1:
+		val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		break;
+	case 0x2:
+		val->intval = POWER_SUPPLY_STATUS_FULL;
+		break;
+	case 0x3:
+		val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		break;
+	default:
+		return -EIO;
+	};
+
+	return 0;
+}
+
+static int e31x_battery_get_health(struct e31x_battery_dev *bat,
+				   union power_supply_propval *val)
+{
+	u32 value;
+	int err;
+
+	err = regmap_read(bat->regmap, E31X_PMU_REG_BATTERY, &value);
+	if (err)
+		return err;
+
+	value = E31X_PMU_GET_FIELD(BATTERY_HEALTH, value);
+
+	switch (value) {
+	case 0x00:
+		val->intval = POWER_SUPPLY_HEALTH_GOOD;
+		break;
+	case 0x01:
+		val->intval = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
+		break;
+	case 0x02:
+		val->intval = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
+		break;
+	case 0x03:
+		val->intval = POWER_SUPPLY_HEALTH_OVERHEAT;
+		break;
+	case 0x04:
+		val->intval = POWER_SUPPLY_HEALTH_COLD;
+		break;
+	default:
+		val->intval = POWER_SUPPLY_HEALTH_UNKNOWN;
+		break;
+	}
+
+	return 0;
+}
+
+static int e31x_battery_get_online(struct e31x_battery_dev *bat,
+				   union power_supply_propval *val)
+{
+	u32 value;
+	int err;
+
+	err = regmap_read(bat->regmap, E31X_PMU_REG_BATTERY, &value);
+	if (err)
+		return err;
+
+	val->intval = !!(value & E31X_PMU_BATTERY_ONLINE_MASK);
+
+	return 0;
+}
+
+static int e31x_battery_get_voltage_now(struct e31x_battery_dev *bat,
+					union power_supply_propval *val)
+{
+	u32 value;
+	int err;
+
+	err = regmap_read(bat->regmap, E31X_PMU_REG_BATTERY, &value);
+
+	if (err)
+		return err;
+
+	value = E31X_PMU_GET_FIELD(BATTERY_VOLTAGE, value);
+
+	val->intval = 10000 * (value * E31X_PMU_VSENSE / GENMASK(15, 0));
+
+	return 0;
+}
+
+#define E31X_PMU_BIN_TO_UAH(x) ((x) * 53)
+#define E31X_PMU_UAH_TO_BIN(x) ((x) / 53)
+
+static int e31x_battery_get_charge_now(struct e31x_battery_dev *bat,
+				       union power_supply_propval *val)
+{
+	u32 value;
+	int err;
+
+	err = regmap_read(bat->regmap, E31X_PMU_REG_GAUGE, &value);
+	if (err)
+		return err;
+
+	value = E31X_PMU_GET_FIELD(GAUGE_CHARGE, value);
+	val->intval = E31X_PMU_BIN_TO_UAH(value);
+
+	return 0;
+}
+
+static int e31x_battery_get_temp(struct e31x_battery_dev *bat,
+				 union power_supply_propval *val)
+{
+	u32 value;
+	int err;
+
+	err = regmap_read(bat->regmap, E31X_PMU_REG_GAUGE, &value);
+	if (err)
+		return err;
+
+	value = E31X_PMU_GET_FIELD(GAUGE_TEMP, value);
+	val->intval = 10 * (((600 * value) / 0xffff) - 273);
+
+	return 0;
+}
+
+static int e31x_battery_get_charge_full(struct e31x_battery_dev *bat,
+					union power_supply_propval *val)
+{
+	u32 value;
+	int err;
+
+	err = regmap_read(bat->regmap, E31X_PMU_REG_LAST, &value);
+	if (err)
+		return err;
+
+	value = E31X_PMU_GET_FIELD(GAUGE_CHARGE_LAST_FULL, value);
+	val->intval = E31X_PMU_BIN_TO_UAH(value);
+
+	return 0;
+}
+
+static const int e31x_pmu_temp_values[] = {
+	600, 800, 1000, 1200
+};
+
+static int e31x_battery_get_temp_alert_max(struct e31x_battery_dev *bat,
+					   union power_supply_propval *val)
+{
+	u32 value;
+	int err;
+	int i;
+
+	err = regmap_read(bat->regmap, E31X_PMU_REG_BATTERY, &value);
+	if (err)
+		return err;
+
+	value = E31X_PMU_GET_FIELD(BATTERY_TEMP_ALERT, value);
+	for (i = 1; i < ARRAY_SIZE(e31x_pmu_temp_values); i++)
+		if (e31x_pmu_temp_values[i] > value)
+			break;
+
+	val->intval = e31x_pmu_temp_values[i - 1];
+
+	return 0;
+}
+
+static int e31x_battery_get_prop(struct power_supply *psy,
+				 enum power_supply_property psp,
+				 union power_supply_propval *val)
+{
+	struct e31x_battery_dev *battery = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		return e31x_battery_get_status(battery, val);
+	case POWER_SUPPLY_PROP_HEALTH:
+		return e31x_battery_get_health(battery, val);
+	case POWER_SUPPLY_PROP_ONLINE:
+		return e31x_battery_get_online(battery, val);
+	case POWER_SUPPLY_PROP_TECHNOLOGY:
+		val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
+		break;
+	case POWER_SUPPLY_PROP_TEMP:
+		return e31x_battery_get_temp(battery, val);
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		return e31x_battery_get_voltage_now(battery, val);
+	case POWER_SUPPLY_PROP_CHARGE_NOW:
+		return e31x_battery_get_charge_now(battery, val);
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+		return e31x_battery_get_charge_full(battery, val);
+	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
+		val->intval = E31X_BATTERY_CHARGE_DESIGN_FULL;
+		return 0;
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
+		return e31x_battery_get_temp_alert_max(battery, val);
+	default:
+		break;
+	};
+
+	return 0;
+}
+
+static enum power_supply_property e31x_battery_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
+};
+
+static int e31x_battery_prop_writeable(struct power_supply *psy,
+				       enum power_supply_property psp)
+{
+	return psp == POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN ||
+	       psp == POWER_SUPPLY_PROP_SCOPE;
+}
+
+static const struct power_supply_desc e31x_battery_desc = {
+	.name = "e31x-battery",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = e31x_battery_props,
+	.num_properties = ARRAY_SIZE(e31x_battery_props),
+	.property_is_writeable = e31x_battery_prop_writeable,
+	.get_property = e31x_battery_get_prop,
+	.set_property = e31x_battery_set_prop,
+};
+
+static const struct of_device_id e31x_battery_id[] = {
+	{ .compatible = "ni,e31x-battery" },
+	{ },
+};
+
+static int e31x_battery_probe(struct platform_device *pdev)
+{
+	struct power_supply_config psy_cfg = {};
+	struct e31x_battery_dev *battery;
+
+	if (!of_device_is_available(pdev->dev.of_node))
+		return -ENODEV;
+
+	battery = devm_kzalloc(&pdev->dev, sizeof(*battery), GFP_KERNEL);
+	if (!battery)
+		return -ENOMEM;
+
+	battery->regmap = syscon_regmap_lookup_by_phandle(\
+			pdev->dev.parent->of_node, "regmap");
+
+	psy_cfg.of_node = pdev->dev.of_node;
+	psy_cfg.drv_data = battery;
+
+	battery->supply = devm_power_supply_register(&pdev->dev,
+						     &e31x_battery_desc,
+						     &psy_cfg);
+	if (IS_ERR(battery->supply))
+		return PTR_ERR(battery->supply);
+	return 0;
+}
+
+static struct platform_driver e31x_battery_driver = {
+	.driver = {
+		.name = "e31x-battery",
+		.of_match_table = e31x_battery_id,
+	},
+	.probe = e31x_battery_probe,
+};
+module_platform_driver(e31x_battery_driver);
+
+MODULE_AUTHOR("Virendra Kakade <virendra.kakade@ni.com>");
+MODULE_DESCRIPTION("E31x battery driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/e31x-pmu.h b/include/linux/mfd/e31x-pmu.h
index e0649845fe4d..0441f8f896ca 100644
--- a/include/linux/mfd/e31x-pmu.h
+++ b/include/linux/mfd/e31x-pmu.h
@@ -11,13 +11,24 @@
 
 #include <linux/bitops.h>
 
-#define E31X_PMU_REG_MISC      0x04
-#define E31X_PMU_REG_CHARGER   0x0c
+#define E31X_PMU_REG_MISC	0x04
+#define E31X_PMU_REG_BATTERY	0x08
+#define E31X_PMU_REG_CHARGER	0x0c
+#define E31X_PMU_REG_GAUGE	0x10
+#define E31X_PMU_REG_STATUS	0x14
+#define E31X_PMU_REG_LAST	0x18
+#define E31X_PMU_REG_EEPROM	0x1c
 
 #define E31X_PMU_GET_FIELD(name, reg) \
 	(((reg) & E31X_PMU_## name ##_MASK) >> \
 	E31X_PMU_## name ##_SHIFT)
 
+/* the eeprom register */
+static const u32 E31X_PMU_EEPROM_AUTOBOOT_MASK = BIT(0);
+static const u32 E31X_PMU_EEPROM_AUTOBOOT_SHIFT;
+static const u32 E31X_PMU_EEPROM_DB_POWER_MASK = BIT(1);
+static const u32 E31X_PMU_EEPROM_DB_POWER_SHIFT = 1;
+
 #define E31X_PMU_CHARGER_ONLINE_MASK	BIT(2)
 #define E31X_PMU_CHARGER_ONLINE_SHIFT	2
 
-- 
2.17.1

