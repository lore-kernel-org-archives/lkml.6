Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F1EC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A808620869
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A808620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeIEPLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 11:11:07 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:51058 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726422AbeIEPLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 11:11:06 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w85AcmnI030877;
        Wed, 5 Sep 2018 05:41:22 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0b-001ae601.pphosted.com with ESMTP id 2m7q6p5bxs-1;
        Wed, 05 Sep 2018 05:41:21 -0500
Received: from EX17.ad.cirrus.com (ex17.ad.cirrus.com [172.20.9.81])
        by mail3.cirrus.com (Postfix) with ESMTP id 96848611C8B5;
        Wed,  5 Sep 2018 05:43:06 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Wed, 5 Sep 2018
 11:41:20 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id w85AfKV9002407; Wed,
 5 Sep 2018 11:41:20 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <broonie@kernel.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <lgirdwood@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 3/5] regulator: lochnagar: Add support for the Cirrus Logic Lochnagar
Date:   Wed, 5 Sep 2018 11:41:18 +0100
Message-ID: <20180905104120.17252-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180905104120.17252-1-ckeepax@opensource.cirrus.com>
References: <20180905104120.17252-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1809050114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Lochnagar is an evaluation and development board for Cirrus
Logic Smart CODEC and Amp devices. It allows the connection of
most Cirrus Logic devices on mini-cards, as well as allowing
connection of various application processor systems to provide a
full evaluation platform.

The Lochnagar board provides power supplies for the attached
CODEC/Amp device. Currently this driver supports the microphone
supplies and the digital core voltage for the attached
device. There are some additional supplies that will be
added in time but these supplies are sufficient for most
systems/use-cases.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 drivers/regulator/Kconfig               |   7 +
 drivers/regulator/Makefile              |   1 +
 drivers/regulator/lochnagar-regulator.c | 258 ++++++++++++++++++++++++++++++++
 3 files changed, 266 insertions(+)
 create mode 100644 drivers/regulator/lochnagar-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 5dbccf5f3037..10c3aa7e4bfd 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -356,6 +356,13 @@ config REGULATOR_LM363X
 	  One boost output voltage is configurable and always on.
 	  Other LDOs are used for the display module.
 
+config REGULATOR_LOCHNAGAR
+	tristate "Cirrus Logic Lochnagar regulator driver"
+	depends on MFD_LOCHNAGAR
+	help
+	  This enables regulator support on the Cirrus Logic Lochnagar audio
+	  development board.
+
 config REGULATOR_LP3971
 	tristate "National Semiconductors LP3971 PMIC regulator driver"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index bd818ceb7c72..72eaa51cdaf9 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_REGULATOR_HI655X) += hi655x-regulator.o
 obj-$(CONFIG_REGULATOR_ISL6271A) += isl6271a-regulator.o
 obj-$(CONFIG_REGULATOR_ISL9305) += isl9305.o
 obj-$(CONFIG_REGULATOR_LM363X) += lm363x-regulator.o
+obj-$(CONFIG_REGULATOR_LOCHNAGAR) += lochnagar-regulator.o
 obj-$(CONFIG_REGULATOR_LP3971) += lp3971.o
 obj-$(CONFIG_REGULATOR_LP3972) += lp3972.o
 obj-$(CONFIG_REGULATOR_LP872X) += lp872x.o
diff --git a/drivers/regulator/lochnagar-regulator.c b/drivers/regulator/lochnagar-regulator.c
new file mode 100644
index 000000000000..ef571e9fc621
--- /dev/null
+++ b/drivers/regulator/lochnagar-regulator.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Lochnagar regulator driver
+ *
+ * Copyright 2017-2018 Cirrus Logic Inc.
+ *
+ * Author: Charles Keepax <ckeepax@opensource.cirrus.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+
+#include <linux/mfd/lochnagar.h>
+
+static const struct regulator_ops lochnagar_micvdd_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+
+	.list_voltage = regulator_list_voltage_linear_range,
+	.map_voltage = regulator_map_voltage_linear_range,
+
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+};
+
+static const struct regulator_linear_range lochnagar_micvdd_ranges[] = {
+	REGULATOR_LINEAR_RANGE(1000000, 0,    0xC, 50000),
+	REGULATOR_LINEAR_RANGE(1700000, 0xD, 0x1F, 100000),
+};
+
+static int lochnagar_micbias_enable(struct regulator_dev *rdev)
+{
+	struct lochnagar *lochnagar = rdev_get_drvdata(rdev);
+	int ret;
+
+	mutex_lock(&lochnagar->analogue_config_lock);
+
+	ret = regulator_enable_regmap(rdev);
+	if (ret < 0)
+		goto err;
+
+	ret = lochnagar_update_config(lochnagar);
+
+err:
+	mutex_unlock(&lochnagar->analogue_config_lock);
+
+	return ret;
+}
+
+static int lochnagar_micbias_disable(struct regulator_dev *rdev)
+{
+	struct lochnagar *lochnagar = rdev_get_drvdata(rdev);
+	int ret;
+
+	mutex_lock(&lochnagar->analogue_config_lock);
+
+	ret = regulator_disable_regmap(rdev);
+	if (ret < 0)
+		goto err;
+
+	ret = lochnagar_update_config(lochnagar);
+
+err:
+	mutex_unlock(&lochnagar->analogue_config_lock);
+
+	return ret;
+}
+
+static const struct regulator_ops lochnagar_micbias_ops = {
+	.enable = lochnagar_micbias_enable,
+	.disable = lochnagar_micbias_disable,
+	.is_enabled = regulator_is_enabled_regmap,
+};
+
+static const struct regulator_ops lochnagar_vddcore_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+
+	.list_voltage = regulator_list_voltage_linear_range,
+	.map_voltage = regulator_map_voltage_linear_range,
+
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+};
+
+static const struct regulator_linear_range lochnagar_vddcore_ranges[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0x8, 0x41, 12500),
+};
+
+enum lochnagar_regulators {
+	LOCHNAGAR_MICVDD,
+	LOCHNAGAR_MIC1VDD,
+	LOCHNAGAR_MIC2VDD,
+	LOCHNAGAR_VDDCORE,
+};
+
+static int lochnagar_micbias_of_parse(struct device_node *np,
+				      const struct regulator_desc *desc,
+				      struct regulator_config *config)
+{
+	struct lochnagar *lochnagar = config->driver_data;
+	int shift = (desc->id - LOCHNAGAR_MIC1VDD) *
+		    LOCHNAGAR2_P2_MICBIAS_SRC_SHIFT;
+	int mask = LOCHNAGAR2_P1_MICBIAS_SRC_MASK << shift;
+	unsigned int val;
+	int ret;
+
+	ret = of_property_read_u32(np, "cirrus,micbias-input", &val);
+	if (ret >= 0) {
+		mutex_lock(&lochnagar->analogue_config_lock);
+		ret = regmap_update_bits(lochnagar->regmap,
+					 LOCHNAGAR2_ANALOGUE_PATH_CTRL2,
+					 mask, val << shift);
+		mutex_unlock(&lochnagar->analogue_config_lock);
+		if (ret < 0) {
+			dev_err(lochnagar->dev,
+				"Failed to update micbias source: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static const struct regulator_desc lochnagar_regulators[] = {
+	[LOCHNAGAR_MICVDD] = {
+		.name = "MICVDD",
+		.supply_name = "SYSVDD",
+		.type = REGULATOR_VOLTAGE,
+		.n_voltages = 32,
+		.ops = &lochnagar_micvdd_ops,
+
+		.id = LOCHNAGAR_MICVDD,
+		.of_match = of_match_ptr("MICVDD"),
+
+		.enable_reg = LOCHNAGAR2_MICVDD_CTRL1,
+		.enable_mask = LOCHNAGAR2_MICVDD_REG_ENA_MASK,
+		.vsel_reg = LOCHNAGAR2_MICVDD_CTRL2,
+		.vsel_mask = LOCHNAGAR2_MICVDD_VSEL_MASK,
+
+		.linear_ranges = lochnagar_micvdd_ranges,
+		.n_linear_ranges = ARRAY_SIZE(lochnagar_micvdd_ranges),
+
+		.enable_time = 3000,
+		.ramp_delay = 1000,
+
+		.owner = THIS_MODULE,
+	},
+	[LOCHNAGAR_MIC1VDD] = {
+		.name = "MIC1VDD",
+		.supply_name = "MICBIAS1",
+		.type = REGULATOR_VOLTAGE,
+		.ops = &lochnagar_micbias_ops,
+
+		.id = LOCHNAGAR_MIC1VDD,
+		.of_match = of_match_ptr("MIC1VDD"),
+		.of_parse_cb = lochnagar_micbias_of_parse,
+
+		.enable_reg = LOCHNAGAR2_ANALOGUE_PATH_CTRL2,
+		.enable_mask = LOCHNAGAR2_P1_INPUT_BIAS_ENA_MASK,
+
+		.owner = THIS_MODULE,
+	},
+	[LOCHNAGAR_MIC2VDD] = {
+		.name = "MIC2VDD",
+		.supply_name = "MICBIAS2",
+		.type = REGULATOR_VOLTAGE,
+		.ops = &lochnagar_micbias_ops,
+
+		.id = LOCHNAGAR_MIC2VDD,
+		.of_match = of_match_ptr("MIC2VDD"),
+		.of_parse_cb = lochnagar_micbias_of_parse,
+
+		.enable_reg = LOCHNAGAR2_ANALOGUE_PATH_CTRL2,
+		.enable_mask = LOCHNAGAR2_P2_INPUT_BIAS_ENA_MASK,
+
+		.owner = THIS_MODULE,
+	},
+	[LOCHNAGAR_VDDCORE] = {
+		.name = "VDDCORE",
+		.supply_name = "SYSVDD",
+		.type = REGULATOR_VOLTAGE,
+		.n_voltages = 57,
+		.ops = &lochnagar_vddcore_ops,
+
+		.id = LOCHNAGAR_VDDCORE,
+		.of_match = of_match_ptr("VDDCORE"),
+
+		.enable_reg = LOCHNAGAR2_VDDCORE_CDC_CTRL1,
+		.enable_mask = LOCHNAGAR2_VDDCORE_CDC_REG_ENA_MASK,
+		.vsel_reg = LOCHNAGAR2_VDDCORE_CDC_CTRL2,
+		.vsel_mask = LOCHNAGAR2_VDDCORE_CDC_VSEL_MASK,
+
+		.linear_ranges = lochnagar_vddcore_ranges,
+		.n_linear_ranges = ARRAY_SIZE(lochnagar_vddcore_ranges),
+
+		.enable_time = 3000,
+		.ramp_delay = 1000,
+
+		.owner = THIS_MODULE,
+	},
+};
+
+static int lochnagar_regulator_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct lochnagar *lochnagar = dev_get_drvdata(dev->parent);
+	struct regulator_config config = { };
+	struct regulator_dev *rdev;
+	int ret, i;
+
+	config.dev = lochnagar->dev;
+	config.regmap = lochnagar->regmap;
+	config.driver_data = lochnagar;
+
+	for (i = 0; i < ARRAY_SIZE(lochnagar_regulators); i++) {
+		const struct regulator_desc *desc = &lochnagar_regulators[i];
+
+		rdev = devm_regulator_register(dev, desc, &config);
+		if (IS_ERR(rdev)) {
+			ret = PTR_ERR(rdev);
+			dev_err(dev, "Failed to register %s regulator: %d\n",
+				desc->name, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static struct platform_driver lochnagar_regulator_driver = {
+	.driver = {
+		.name = "lochnagar-regulator",
+	},
+
+	.probe = lochnagar_regulator_probe,
+};
+module_platform_driver(lochnagar_regulator_driver);
+
+MODULE_AUTHOR("Charles Keepax <ckeepax@opensource.cirrus.com>");
+MODULE_DESCRIPTION("Regulator driver for Cirrus Logic Lochnagar Board");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:lochnagar-regulator");
-- 
2.11.0

