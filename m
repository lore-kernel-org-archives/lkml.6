Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752623AbeBFEub (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 23:50:31 -0500
Received: from hermes.aosc.io ([199.195.250.187]:50232 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752315AbeBFEuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 23:50:24 -0500
From: Icenowy Zheng <icenowy@aosc.io>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Ondrej Jirman <megous@megous.com>, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v2 02/10] regulator: add support for SY8106A regulator
Date: Tue,  6 Feb 2018 12:48:57 +0800
Message-Id: <20180206044905.30508-3-icenowy@aosc.io>
In-Reply-To: <20180206044905.30508-1-icenowy@aosc.io>
References: <20180206044905.30508-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

SY8106A is an I2C attached single output regulator made by Silergy Corp,
which is used on several Allwinner H3/H5 SBCs to control the power
supply of the ARM cores.

Add a driver for it.

Signed-off-by: Ondrej Jirman <megous@megous.com>
[Icenowy: Change commit message, remove enable/disable code, add default
 ramp_delay, add comment for go bit]
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v2:
- Dropped the enable/disable code.
- Added default ramp_delay value.
- Added comment for the "go bit".

 drivers/regulator/Kconfig             |   8 +-
 drivers/regulator/Makefile            |   2 +-
 drivers/regulator/sy8106a-regulator.c | 168 ++++++++++++++++++++++++++++++++++
 3 files changed, 176 insertions(+), 2 deletions(-)
 create mode 100644 drivers/regulator/sy8106a-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index b27417ca188a..70227230bca2 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -792,6 +792,13 @@ config REGULATOR_STW481X_VMMC
 	  This driver supports the internal VMMC regulator in the STw481x
 	  PMIC chips.
 
+config REGULATOR_SY8106A
+	tristate "Silergy SY8106A regulator"
+	depends on I2C && (OF || COMPILE_TEST)
+	select REGMAP_I2C
+	help
+	  This driver supports SY8106A single output regulator.
+
 config REGULATOR_TPS51632
 	tristate "TI TPS51632 Power Regulator"
 	depends on I2C
@@ -966,4 +973,3 @@ config REGULATOR_WM8994
 	  WM8994 CODEC.
 
 endif
-
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 19fea09ba10a..7564664c64df 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -99,6 +99,7 @@ obj-$(CONFIG_REGULATOR_SC2731) += sc2731-regulator.o
 obj-$(CONFIG_REGULATOR_SKY81452) += sky81452-regulator.o
 obj-$(CONFIG_REGULATOR_STM32_VREFBUF) += stm32-vrefbuf.o
 obj-$(CONFIG_REGULATOR_STW481X_VMMC) += stw481x-vmmc.o
+obj-$(CONFIG_REGULATOR_SY8106A) += sy8106a-regulator.o
 obj-$(CONFIG_REGULATOR_TI_ABB) += ti-abb-regulator.o
 obj-$(CONFIG_REGULATOR_TPS6105X) += tps6105x-regulator.o
 obj-$(CONFIG_REGULATOR_TPS62360) += tps62360-regulator.o
@@ -124,5 +125,4 @@ obj-$(CONFIG_REGULATOR_WM8350) += wm8350-regulator.o
 obj-$(CONFIG_REGULATOR_WM8400) += wm8400-regulator.o
 obj-$(CONFIG_REGULATOR_WM8994) += wm8994-regulator.o
 
-
 ccflags-$(CONFIG_REGULATOR_DEBUG) += -DDEBUG
diff --git a/drivers/regulator/sy8106a-regulator.c b/drivers/regulator/sy8106a-regulator.c
new file mode 100644
index 000000000000..c5643c33e1e5
--- /dev/null
+++ b/drivers/regulator/sy8106a-regulator.c
@@ -0,0 +1,168 @@
+/*
+ * sy8106a-regulator.c - Regulator device driver for SY8106A
+ *
+ * Copyright (C) 2016 Ondřej Jirman <megous@megous.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Library General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Library General Public License for more details.
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+
+#define SY8106A_REG_VOUT1_SEL		0x01
+#define SY8106A_REG_VOUT_COM		0x02
+#define SY8106A_REG_VOUT1_SEL_MASK	0x7f
+#define SY8106A_DISABLE_REG		BIT(0)
+/*
+ * The I2C controlled voltage will only work when this bit is set; otherwise
+ * it will behave like a fixed regulator.
+ */
+#define SY8106A_GO_BIT			BIT(7)
+
+struct sy8106a {
+	struct regulator_dev *rdev;
+	struct regmap *regmap;
+};
+
+static const struct regmap_config sy8106a_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int sy8106a_set_voltage_sel(struct regulator_dev *rdev, unsigned int sel)
+{
+	/* We use our set_voltage_sel in order to avoid unnecessary I2C
+	 * chatter, because the regulator_get_voltage_sel_regmap using
+	 * apply_bit would perform 4 unnecessary transfers instead of one,
+	 * increasing the chance of error.
+	 */
+	return regmap_write(rdev->regmap, rdev->desc->vsel_reg,
+			    sel | SY8106A_GO_BIT);
+}
+
+static const struct regulator_ops sy8106a_ops = {
+	.set_voltage_sel = sy8106a_set_voltage_sel,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.list_voltage = regulator_list_voltage_linear,
+	/* Enabling/disabling the regulator is not yet implemented */
+};
+
+/* Default limits measured in millivolts and milliamps */
+#define SY8106A_MIN_MV		680
+#define SY8106A_MAX_MV		1950
+#define SY8106A_STEP_MV		10
+
+static const struct regulator_desc sy8106a_reg = {
+	.name = "SY8106A",
+	.id = 0,
+	.ops = &sy8106a_ops,
+	.type = REGULATOR_VOLTAGE,
+	.n_voltages = ((SY8106A_MAX_MV - SY8106A_MIN_MV) / SY8106A_STEP_MV) + 1,
+	.min_uV = (SY8106A_MIN_MV * 1000),
+	.uV_step = (SY8106A_STEP_MV * 1000),
+	.vsel_reg = SY8106A_REG_VOUT1_SEL,
+	.vsel_mask = SY8106A_REG_VOUT1_SEL_MASK,
+	/*
+	 * This ramp_delay is a conservative default value which works on
+	 * H3/H5 boards VDD-CPUX situations.
+	 */
+	.ramp_delay = 200,
+	.owner = THIS_MODULE,
+};
+
+/*
+ * I2C driver interface functions
+ */
+static int sy8106a_i2c_probe(struct i2c_client *i2c,
+			    const struct i2c_device_id *id)
+{
+	struct sy8106a *chip;
+	struct device *dev = &i2c->dev;
+	struct regulator_dev *rdev = NULL;
+	struct regulator_config config = { };
+	unsigned int selector;
+	int error;
+
+	chip = devm_kzalloc(&i2c->dev, sizeof(struct sy8106a), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->regmap = devm_regmap_init_i2c(i2c, &sy8106a_regmap_config);
+	if (IS_ERR(chip->regmap)) {
+		error = PTR_ERR(chip->regmap);
+		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
+			error);
+		return error;
+	}
+
+	config.dev = &i2c->dev;
+	config.regmap = chip->regmap;
+	config.driver_data = chip;
+
+	config.of_node = dev->of_node;
+	config.init_data = of_get_regulator_init_data(dev, dev->of_node,
+						      &sy8106a_reg);
+
+	if (!config.init_data)
+		return -ENOMEM;
+
+	/* Probe regulator */
+	error = regmap_read(chip->regmap, SY8106A_REG_VOUT1_SEL, &selector);
+	if (error) {
+		dev_err(&i2c->dev, "Failed to read voltage at probe time: %d\n", error);
+		return error;
+	}
+
+	rdev = devm_regulator_register(&i2c->dev, &sy8106a_reg, &config);
+	if (IS_ERR(rdev)) {
+		error = PTR_ERR(rdev);
+		dev_err(&i2c->dev, "Failed to register SY8106A regulator: %d\n", error);
+		return error;
+	}
+
+	chip->rdev = rdev;
+
+	i2c_set_clientdata(i2c, chip);
+
+	return 0;
+}
+
+static const struct of_device_id sy8106a_i2c_of_match[] = {
+	{ .compatible = "silergy,sy8106a" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sy8106a_i2c_of_match);
+
+static const struct i2c_device_id sy8106a_i2c_id[] = {
+	{ "sy8106a", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, sy8106a_i2c_id);
+
+static struct i2c_driver sy8106a_regulator_driver = {
+	.driver = {
+		.name = "sy8106a",
+		.of_match_table	= of_match_ptr(sy8106a_i2c_of_match),
+	},
+	.probe = sy8106a_i2c_probe,
+	.id_table = sy8106a_i2c_id,
+};
+
+module_i2c_driver(sy8106a_regulator_driver);
+
+MODULE_AUTHOR("Ondřej Jirman <megous@megous.com>");
+MODULE_DESCRIPTION("Regulator device driver for Silergy SY8106A");
+MODULE_LICENSE("GPL");
-- 
2.15.1
