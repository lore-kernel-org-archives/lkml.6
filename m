Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8429FC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4896620879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbfAVJq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:46:26 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38595 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbfAVJqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:46:25 -0500
Received: by mail-lf1-f67.google.com with SMTP id a8so17579605lfk.5;
        Tue, 22 Jan 2019 01:46:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Su0/YwS1sLv8wECTVdiq9KvGwdKZMDKH1/pLgUO7HZg=;
        b=nXSUrFMbPdplPK8H3Wn/S7SLgI5gXgmCVrXls8a6KiXEbljrmYERjBC7FG3er52cRf
         thpYhEEKQHejd+mjccq8saGZzaqvSWGAqsm9fwFfJeyIr1maw1ccYkyj3yGTuv5gOAUK
         1eAf/r3n00VomMHVEQ9iSpRcVjA7z/VrSBMvBGB6vGEZSTKjV0ScSkUcmZ6i68aDmxQb
         XN+8snECp4qRoOt5y/CLD6ySEc/vMzR0d93JAt7SyWQhLdIdkChmHuAWPYQZ01/2i+d4
         gqU5wm55OsBLBWPDwGRs9Xug23sK3VgHY3175NRRrA+fU905GJBSFW0MmDC52qV7qdaH
         90Mw==
X-Gm-Message-State: AJcUukdIh9fj/naCAI+UoMf3B+qdo9tkcSj2v86+KaNwu+hNshMttRsC
        hVqIWI8to/1AuFWjZ4QHRoA=
X-Google-Smtp-Source: ALg8bN5NbN+mfoumtjR6fixII70uQ9Qic8OfzgyTDGdpQnM5UYr8prGCMokhk2wCHNHND0gu/0W0jA==
X-Received: by 2002:ac2:4215:: with SMTP id y21mr11508990lfh.6.1548150382067;
        Tue, 22 Jan 2019 01:46:22 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id x24-v6sm3026773ljc.54.2019.01.22.01.46.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 01:46:21 -0800 (PST)
Date:   Tue, 22 Jan 2019 11:46:08 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        linux@roeck-us.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: [RFC PATCH v1 08/13] regulator: bd70528: Support ROHM BD70528
 regulator block
Message-ID: <f06b0b7b3d86258cda85f545cae69d077e7cc8ca.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BD70528MWV is an ultra-low Iq general purpose single-chip power
management IC for battery-powered portable devices.

Add support for controlling 3 bucks and 3 LDOs present in
ROHM BD70528.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/regulator/Kconfig             |  11 ++
 drivers/regulator/Makefile            |   1 +
 drivers/regulator/bd70528-regulator.c | 290 ++++++++++++++++++++++++++++++++++
 3 files changed, 302 insertions(+)
 create mode 100644 drivers/regulator/bd70528-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 7fc1f88e27e7..21dc3b59db19 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -180,6 +180,17 @@ config REGULATOR_BCM590XX
 	  BCM590xx PMUs. This will enable support for the software
 	  controllable LDO/Switching regulators.
 
+config REGULATOR_BD70528
+	tristate "ROHM BD70528 Power Regulator"
+	depends on MFD_ROHM_BD70528
+	help
+	  This driver supports voltage regulators on ROHM BD70528 PMIC.
+	  This will enable support for the software controllable buck
+	  and LDO regulators.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called bd70528-regulator.
+
 config REGULATOR_BD718XX
 	tristate "ROHM BD71837 Power Regulator"
 	depends on MFD_ROHM_BD718XX
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index b12e1c9b2118..960406952119 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_REGULATOR_AS3711) += as3711-regulator.o
 obj-$(CONFIG_REGULATOR_AS3722) += as3722-regulator.o
 obj-$(CONFIG_REGULATOR_AXP20X) += axp20x-regulator.o
 obj-$(CONFIG_REGULATOR_BCM590XX) += bcm590xx-regulator.o
+obj-$(CONFIG_REGULATOR_BD70528) += bd70528-regulator.o
 obj-$(CONFIG_REGULATOR_BD718XX) += bd718x7-regulator.o
 obj-$(CONFIG_REGULATOR_BD9571MWV) += bd9571mwv-regulator.o
 obj-$(CONFIG_REGULATOR_DA903X)	+= da903x.o
diff --git a/drivers/regulator/bd70528-regulator.c b/drivers/regulator/bd70528-regulator.c
new file mode 100644
index 000000000000..0cf261c469b9
--- /dev/null
+++ b/drivers/regulator/bd70528-regulator.c
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 ROHM Semiconductors
+// bd70528-regulator.c ROHM BD70528MWV regulator driver
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mfd/rohm-bd70528.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/slab.h>
+
+#define BUCK_RAMPRATE_250MV 0
+#define BUCK_RAMPRATE_125MV 1
+#define BUCK_RAMP_MAX 250
+
+static struct regulator_linear_range bd70528_buck1_volts[] = {
+	REGULATOR_LINEAR_RANGE(1200000, 0x00, 0x1, 600000),
+	REGULATOR_LINEAR_RANGE(2750000, 0x2, 0xf, 50000),
+};
+static struct regulator_linear_range bd70528_buck2_volts[] = {
+	REGULATOR_LINEAR_RANGE(1200000, 0x00, 0x1, 300000),
+	REGULATOR_LINEAR_RANGE(1550000, 0x2, 0xd, 50000),
+	REGULATOR_LINEAR_RANGE(3000000, 0xe, 0xf, 300000),
+};
+static struct regulator_linear_range bd70528_buck3_volts[] = {
+	REGULATOR_LINEAR_RANGE(800000, 0x00, 0xd, 50000),
+	REGULATOR_LINEAR_RANGE(1800000, 0xe, 0xf, 0),
+};
+
+/* All LDOs have same voltage ranges */
+static struct regulator_linear_range bd70528_ldo_volts[] = {
+	REGULATOR_LINEAR_RANGE(1650000, 0x0, 0x07, 50000),
+	REGULATOR_LINEAR_RANGE(2100000, 0x8, 0x0f, 100000),
+	REGULATOR_LINEAR_RANGE(2850000, 0x10, 0x19, 50000),
+	REGULATOR_LINEAR_RANGE(3300000, 0x19, 0x1f, 0),
+};
+
+/* Also both LEDs support same voltages */
+static const unsigned int led_volts[] = {
+	20000, 30000
+};
+
+static int bd70528_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
+{
+	if (ramp_delay > 0 && ramp_delay <= BUCK_RAMP_MAX) {
+		unsigned int ramp_value = BUCK_RAMPRATE_250MV;
+
+		if (ramp_delay <= 125)
+			ramp_value = BUCK_RAMPRATE_125MV;
+
+		return regmap_update_bits(rdev->regmap, rdev->desc->vsel_reg,
+				  BD70528_MASK_BUCK_RAMP,
+				  ramp_value << BD70528_SIFT_BUCK_RAMP);
+	}
+	dev_err(&rdev->dev, "%s: ramp_delay: %d not supported\n",
+		rdev->desc->name, ramp_delay);
+	return -EINVAL;
+}
+
+static int bd70528_led_set_voltage_sel(struct regulator_dev *rdev,
+				       unsigned int sel)
+{
+	int ret;
+
+	ret = regulator_is_enabled_regmap(rdev);
+	if (ret < 0)
+		return ret;
+
+	if (ret == 0)
+		return regulator_set_voltage_sel_regmap(rdev, sel);
+
+	dev_err(&rdev->dev,
+		"LED voltage change not allowed when led is enabled\n");
+
+	return -EBUSY;
+}
+
+static struct regulator_ops bd70528_buck_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.set_ramp_delay = bd70528_set_ramp_delay,
+};
+
+static struct regulator_ops bd70528_ldo_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.set_ramp_delay = bd70528_set_ramp_delay,
+};
+
+static struct regulator_ops bd70528_led_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_table,
+	.set_voltage_sel = bd70528_led_set_voltage_sel,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+};
+
+
+static struct regulator_desc bd70528_desc[] = {
+	{
+		.name = "buck1",
+		.of_match = of_match_ptr("BUCK1"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = BD70528_BUCK1,
+		.ops = &bd70528_buck_ops,
+		.type = REGULATOR_VOLTAGE,
+		.linear_ranges = bd70528_buck1_volts,
+		.n_linear_ranges = ARRAY_SIZE(bd70528_buck1_volts),
+		.n_voltages = BD70528_BUCK_VOLTS,
+		.enable_reg = BD70528_REG_BUCK1_EN,
+		.enable_mask = BD70528_MASK_RUN_EN,
+		.vsel_reg = BD70528_REG_BUCK1_VOLT,
+		.vsel_mask = BD70528_MASK_BUCK_VOLT,
+		.owner = THIS_MODULE,
+	},
+	{
+		.name = "buck2",
+		.of_match = of_match_ptr("BUCK2"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = BD70528_BUCK2,
+		.ops = &bd70528_buck_ops,
+		.type = REGULATOR_VOLTAGE,
+		.linear_ranges = bd70528_buck2_volts,
+		.n_linear_ranges = ARRAY_SIZE(bd70528_buck2_volts),
+		.n_voltages = BD70528_BUCK_VOLTS,
+		.enable_reg = BD70528_REG_BUCK2_EN,
+		.enable_mask = BD70528_MASK_RUN_EN,
+		.vsel_reg = BD70528_REG_BUCK2_VOLT,
+		.vsel_mask = BD70528_MASK_BUCK_VOLT,
+		.owner = THIS_MODULE,
+	},
+	{
+		.name = "buck3",
+		.of_match = of_match_ptr("BUCK3"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = BD70528_BUCK3,
+		.ops = &bd70528_buck_ops,
+		.type = REGULATOR_VOLTAGE,
+		.linear_ranges = bd70528_buck3_volts,
+		.n_linear_ranges = ARRAY_SIZE(bd70528_buck3_volts),
+		.n_voltages = BD70528_BUCK_VOLTS,
+		.enable_reg = BD70528_REG_BUCK3_EN,
+		.enable_mask = BD70528_MASK_RUN_EN,
+		.vsel_reg = BD70528_REG_BUCK3_VOLT,
+		.vsel_mask = BD70528_MASK_BUCK_VOLT,
+		.owner = THIS_MODULE,
+	},
+	{
+		.name = "ldo1",
+		.of_match = of_match_ptr("LDO1"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = BD70528_LDO1,
+		.ops = &bd70528_ldo_ops,
+		.type = REGULATOR_VOLTAGE,
+		.linear_ranges = bd70528_ldo_volts,
+		.n_linear_ranges = ARRAY_SIZE(bd70528_ldo_volts),
+		.n_voltages = BD70528_LDO_VOLTS,
+		.enable_reg = BD70528_REG_LDO1_EN,
+		.enable_mask = BD70528_MASK_RUN_EN,
+		.vsel_reg = BD70528_REG_LDO1_VOLT,
+		.vsel_mask = BD70528_MASK_LDO_VOLT,
+		.owner = THIS_MODULE,
+	},
+	{
+		.name = "ldo2",
+		.of_match = of_match_ptr("LDO2"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = BD70528_LDO2,
+		.ops = &bd70528_ldo_ops,
+		.type = REGULATOR_VOLTAGE,
+		.linear_ranges = bd70528_ldo_volts,
+		.n_linear_ranges = ARRAY_SIZE(bd70528_ldo_volts),
+		.n_voltages = BD70528_LDO_VOLTS,
+		.enable_reg = BD70528_REG_LDO2_EN,
+		.enable_mask = BD70528_MASK_RUN_EN,
+		.vsel_reg = BD70528_REG_LDO2_VOLT,
+		.vsel_mask = BD70528_MASK_LDO_VOLT,
+		.owner = THIS_MODULE,
+	},
+	{
+		.name = "ldo3",
+		.of_match = of_match_ptr("LDO3"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = BD70528_LDO3,
+		.ops = &bd70528_ldo_ops,
+		.type = REGULATOR_VOLTAGE,
+		.linear_ranges = bd70528_ldo_volts,
+		.n_linear_ranges = ARRAY_SIZE(bd70528_ldo_volts),
+		.n_voltages = BD70528_LDO_VOLTS,
+		.enable_reg = BD70528_REG_LDO3_EN,
+		.enable_mask = BD70528_MASK_RUN_EN,
+		.vsel_reg = BD70528_REG_LDO3_VOLT,
+		.vsel_mask = BD70528_MASK_LDO_VOLT,
+		.owner = THIS_MODULE,
+	},
+	{
+		.name = "ldo_led1",
+		.of_match = of_match_ptr("LDO_LED1"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = BD70528_LED1,
+		.ops = &bd70528_led_ops,
+		.type = REGULATOR_VOLTAGE,
+		.volt_table = &led_volts[0],
+		.n_voltages = ARRAY_SIZE(led_volts),
+		.enable_reg = BD70528_REG_LED_EN,
+		.enable_mask = BD70528_MASK_LED1_EN,
+		.vsel_reg = BD70528_REG_LED_VOLT,
+		.vsel_mask = BD70528_MASK_LED1_VOLT,
+		.owner = THIS_MODULE,
+	},
+	{
+		.name = "ldo_led2",
+		.of_match = of_match_ptr("LDO_LED2"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = BD70528_LED2,
+		.ops = &bd70528_led_ops,
+		.type = REGULATOR_VOLTAGE,
+		.volt_table = &led_volts[0],
+		.n_voltages = ARRAY_SIZE(led_volts),
+		.enable_reg = BD70528_REG_LED_EN,
+		.enable_mask = BD70528_MASK_LED2_EN,
+		.vsel_reg = BD70528_REG_LED_VOLT,
+		.vsel_mask = BD70528_MASK_LED2_VOLT,
+		.owner = THIS_MODULE,
+	},
+
+};
+
+static int bd70528_probe(struct platform_device *pdev)
+{
+	struct bd70528 *bd70528;
+	int i;
+	struct regulator_config config = {
+		.dev = pdev->dev.parent,
+	};
+
+	bd70528 = dev_get_drvdata(pdev->dev.parent);
+	if (!bd70528) {
+		dev_err(&pdev->dev, "No MFD driver data\n");
+		return -EINVAL;
+	}
+
+	config.regmap = bd70528->chip.regmap;
+
+	for (i = 0; i < ARRAY_SIZE(bd70528_desc); i++) {
+		struct regulator_dev *rdev;
+
+		rdev = devm_regulator_register(&pdev->dev, &bd70528_desc[i],
+					       &config);
+		if (IS_ERR(rdev)) {
+			dev_err(&pdev->dev,
+				"failed to register %s regulator\n",
+				bd70528_desc[i].name);
+			return PTR_ERR(rdev);
+		}
+	}
+	return 0;
+}
+
+static struct platform_driver bd70528_regulator = {
+	.driver = {
+		.name = "bd70528-pmic"
+	},
+	.probe = bd70528_probe,
+};
+
+module_platform_driver(bd70528_regulator);
+
+MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
+MODULE_DESCRIPTION("BD70528 voltage regulator driver");
+MODULE_LICENSE("GPL");
-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
