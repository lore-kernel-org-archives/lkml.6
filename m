Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CD7C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A554A217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbfBLBDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 20:03:01 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:43170 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728089AbfBLBC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 20:02:59 -0500
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1C11GQX001115;
        Mon, 11 Feb 2019 19:02:53 -0600
Received: from ni.com (skprod2.natinst.com [130.164.80.23])
        by mx0a-00010702.pphosted.com with ESMTP id 2qhw8uh4v1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Feb 2019 19:02:53 -0600
Received: from us-aus-exhub2.ni.corp.natinst.com (us-aus-exhub2.ni.corp.natinst.com [130.164.68.32])
        by us-aus-skprod2.natinst.com (8.16.0.27/8.16.0.27) with ESMTPS id x1C12qOv016525
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 11 Feb 2019 19:02:52 -0600
Received: from us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) by
 us-aus-exhub2.ni.corp.natinst.com (130.164.68.32) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Mon, 11 Feb 2019 19:02:52 -0600
Received: from nisurp-linux-2.ni.corp.natinst.com (130.164.49.7) by
 us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) with Microsoft SMTP Server
 id 15.0.1395.4 via Frontend Transport; Mon, 11 Feb 2019 19:02:52 -0600
From:   Virendra Kakade <virendra.kakade@ni.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC:     <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <sre@kernel.org>,
        <moritz.fischer@ettus.com>,
        Virendra Kakade <virendra.kakade@ni.com>
Subject: [RFC 4/6] power: supply: Ettus Research E31x charger driver
Date:   Mon, 11 Feb 2019 19:01:41 -0600
Message-ID: <20190212010143.3729-5-virendra.kakade@ni.com>
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

Add support for E31x devices charger which is a sub-device of E31X-PMU.
Enables query of charger properties from device tree.

Signed-off-by: Virendra Kakade <virendra.kakade@ni.com>
---
 drivers/power/supply/Kconfig        |   6 +
 drivers/power/supply/Makefile       |   1 +
 drivers/power/supply/e31x-charger.c | 190 ++++++++++++++++++++++++++++
 include/linux/mfd/e31x-pmu.h        |   4 +
 4 files changed, 201 insertions(+)
 create mode 100644 drivers/power/supply/e31x-charger.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index e901b9879e7e..3d043b8fd49c 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -660,4 +660,10 @@ config FUEL_GAUGE_SC27XX
 	 Say Y here to enable support for fuel gauge with SC27XX
 	 PMIC chips.
 
+config E31X_CHARGER
+	tristate "Ettus Research E31x charger support"
+	depends on MFD_E31X_PMU
+	help
+	 This adds support for the battery charger in Ettus Research E31x PMU.
+
 endif # POWER_SUPPLY
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index b731c2a9b695..6f4f8ca5484e 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -87,3 +87,4 @@ obj-$(CONFIG_AXP288_CHARGER)	+= axp288_charger.o
 obj-$(CONFIG_CHARGER_CROS_USBPD)	+= cros_usbpd-charger.o
 obj-$(CONFIG_CHARGER_SC2731)	+= sc2731_charger.o
 obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+= sc27xx_fuel_gauge.o
+obj-$(CONFIG_E31X_CHARGER)	+= e31x-charger.o
diff --git a/drivers/power/supply/e31x-charger.c b/drivers/power/supply/e31x-charger.c
new file mode 100644
index 000000000000..f154482bf95e
--- /dev/null
+++ b/drivers/power/supply/e31x-charger.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 National Instruments Corp
+ * Author: Virendra Kakade <virendra.kakade@ni.com>
+ *
+ * Ettus Research E31x charger driver
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
+#define E31X_PMU_CHARGER_HEALTH_MASK		GENMASK(1, 0)
+#define E31X_PMU_CHARGER_HEALTH_SHIFT		0
+#define E31X_PMU_CHARGER_CHARGE_TYPE_MASK	GENMASK(4, 3)
+#define E31X_PMU_CHARGER_CHARGE_TYPE_SHIFT	3
+
+struct e31x_charger_dev {
+	struct regmap *regmap;
+	struct power_supply *supply;
+};
+
+static int e31x_charger_get_health(struct e31x_charger_dev *charger,
+				   union power_supply_propval *val)
+{
+	u32 value;
+	int err;
+
+	err = regmap_read(charger->regmap, E31X_PMU_REG_CHARGER, &value);
+	if (err)
+		return err;
+
+	value = E31X_PMU_GET_FIELD(CHARGER_HEALTH, value);
+	switch (value) {
+	case 0x0:
+		val->intval = POWER_SUPPLY_HEALTH_GOOD;
+		break;
+	case 0x1:
+		val->intval = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
+		break;
+	case 0x2:
+		val->intval = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
+		break;
+	case 0x3:
+		val->intval = POWER_SUPPLY_HEALTH_OVERHEAT;
+		break;
+	default:
+		val->intval = POWER_SUPPLY_HEALTH_UNKNOWN;
+		break;
+	};
+
+	return 0;
+}
+
+static int e31x_charger_get_type(struct e31x_charger_dev *charger,
+				 union power_supply_propval *val)
+{
+	u32 value;
+	int err;
+
+	err = regmap_read(charger->regmap, E31X_PMU_REG_CHARGER, &value);
+	if (err)
+		return err;
+
+	value = E31X_PMU_GET_FIELD(CHARGER_CHARGE_TYPE, value);
+	switch (value) {
+	case 0x0:
+		val->intval = POWER_SUPPLY_CHARGE_TYPE_NONE;
+		break;
+	case 0x1:
+		val->intval = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
+		break;
+	case 0x2:
+		val->intval = POWER_SUPPLY_CHARGE_TYPE_FAST;
+		break;
+	default:
+		val->intval = POWER_SUPPLY_CHARGE_TYPE_NONE;
+		break;
+	};
+	return 0;
+}
+
+static int e31x_charger_get_online(struct e31x_charger_dev *charger,
+				   union power_supply_propval *val)
+{
+	u32 value;
+	int err;
+
+	err = regmap_read(charger->regmap, E31X_PMU_REG_CHARGER, &value);
+	if (err)
+		return err;
+
+	value = E31X_PMU_GET_FIELD(CHARGER_ONLINE, value);
+	val->intval = !!value;
+
+	return 0;
+}
+
+static int e31x_charger_get_property(struct power_supply *psy,
+				     enum power_supply_property psp,
+				     union power_supply_propval *val)
+{
+	struct e31x_charger_dev *charger = power_supply_get_drvdata(psy);
+	int err = -EINVAL;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_HEALTH:
+		return e31x_charger_get_health(charger, val);
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		return e31x_charger_get_type(charger, val);
+	case POWER_SUPPLY_PROP_ONLINE:
+		return e31x_charger_get_online(charger, val);
+	case POWER_SUPPLY_PROP_SCOPE:
+		val->intval = POWER_SUPPLY_SCOPE_SYSTEM;
+		return 0;
+	default:
+		break;
+	}
+
+	return err;
+}
+
+static enum power_supply_property e31x_charger_properties[] = {
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_SCOPE,
+};
+
+static const struct power_supply_desc e31x_charger_desc = {
+	.name = "e31x-charger",
+	.type = POWER_SUPPLY_TYPE_MAINS,
+	.properties = e31x_charger_properties,
+	.num_properties = ARRAY_SIZE(e31x_charger_properties),
+	.get_property = e31x_charger_get_property,
+};
+
+static const struct of_device_id e31x_charger_id[] = {
+	{ .compatible = "ni,e31x-charger" },
+	{ },
+};
+
+static int e31x_charger_probe(struct platform_device *pdev)
+{
+	struct power_supply_config psy_cfg = {};
+	struct e31x_charger_dev *charger;
+
+	if (!of_device_is_available(pdev->dev.of_node))
+		return -ENODEV;
+
+	charger = devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
+	if (!charger)
+		return -ENOMEM;
+
+	charger->regmap = syscon_regmap_lookup_by_phandle(\
+			pdev->dev.parent->of_node, "regmap");
+
+	psy_cfg.of_node = pdev->dev.of_node;
+	psy_cfg.drv_data = charger;
+
+	charger->supply = devm_power_supply_register(&pdev->dev,
+						     &e31x_charger_desc,
+						     &psy_cfg);
+
+	if (IS_ERR(charger->supply))
+		return PTR_ERR(charger->supply);
+	return 0;
+}
+
+static struct platform_driver e31x_charger_driver = {
+	.driver = {
+		.name = "e31x-charger",
+		.of_match_table = e31x_charger_id,
+	},
+	.probe = e31x_charger_probe,
+};
+module_platform_driver(e31x_charger_driver);
+
+MODULE_AUTHOR("Virendra Kakade <virendra.kakade@ni.com>");
+MODULE_DESCRIPTION("E31x charger driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/e31x-pmu.h b/include/linux/mfd/e31x-pmu.h
index c57d5a8c1aad..e0649845fe4d 100644
--- a/include/linux/mfd/e31x-pmu.h
+++ b/include/linux/mfd/e31x-pmu.h
@@ -12,9 +12,13 @@
 #include <linux/bitops.h>
 
 #define E31X_PMU_REG_MISC      0x04
+#define E31X_PMU_REG_CHARGER   0x0c
 
 #define E31X_PMU_GET_FIELD(name, reg) \
 	(((reg) & E31X_PMU_## name ##_MASK) >> \
 	E31X_PMU_## name ##_SHIFT)
 
+#define E31X_PMU_CHARGER_ONLINE_MASK	BIT(2)
+#define E31X_PMU_CHARGER_ONLINE_SHIFT	2
+
 #endif /* MFD_E31X_PMU_H */
-- 
2.17.1

