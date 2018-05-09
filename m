Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934126AbeEIJdK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 05:33:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45060 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934048AbeEIJdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 05:33:08 -0400
From: Mark Brown <broonie@kernel.org>
To: Ondrej Jirman <megous@megous.com>
Cc: Icenowy Zheng <icenowy@aosc.io>, Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: add support for SY8106A regulator" to the regulator tree
In-Reply-To: <20180507122942.25758-3-icenowy@aosc.io>
Message-Id: <20180509093251.87ACE44007A@finisterre.ee.mobilebroadband>
Date: Wed,  9 May 2018 10:32:51 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: add support for SY8106A regulator

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 8878302ebbc580d64f390c0acc509e5e8276598c Mon Sep 17 00:00:00 2001
From: Ondrej Jirman <megous@megous.com>
Date: Mon, 7 May 2018 20:29:41 +0800
Subject: [PATCH] regulator: add support for SY8106A regulator

SY8106A is an I2C attached single output regulator made by Silergy Corp,
which is used on several Allwinner H3/H5 SBCs to control the power
supply of the ARM cores.

Add a driver for it.

Signed-off-by: Ondrej Jirman <megous@megous.com>
[Icenowy: Change commit message, remove enable/disable code, add default
 ramp_delay, add comment for go bit, add code for fixed mode voltage]
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS                           |   6 +
 drivers/regulator/Kconfig             |   7 ++
 drivers/regulator/Makefile            |   2 +-
 drivers/regulator/sy8106a-regulator.c | 167 ++++++++++++++++++++++++++
 4 files changed, 181 insertions(+), 1 deletion(-)
 create mode 100644 drivers/regulator/sy8106a-regulator.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a1410d5a621..971300930067 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13461,6 +13461,12 @@ S:	Supported
 F:	net/switchdev/
 F:	include/net/switchdev.h
 
+SY8106A REGULATOR DRIVER
+M:	Icenowy Zheng <icenowy@aosc.io>
+S:	Maintained
+F:	drivers/regulator/sy8106a-regulator.c
+F:	Documentation/devicetree/bindings/regulator/sy8106a-regulator.txt
+
 SYNC FILE FRAMEWORK
 M:	Sumit Semwal <sumit.semwal@linaro.org>
 R:	Gustavo Padovan <gustavo@padovan.org>
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 097f61784a7d..4efae3b7e746 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -801,6 +801,13 @@ config REGULATOR_STW481X_VMMC
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
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 590674fbecd7..d81fb02bd6e9 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -100,6 +100,7 @@ obj-$(CONFIG_REGULATOR_SC2731) += sc2731-regulator.o
 obj-$(CONFIG_REGULATOR_SKY81452) += sky81452-regulator.o
 obj-$(CONFIG_REGULATOR_STM32_VREFBUF) += stm32-vrefbuf.o
 obj-$(CONFIG_REGULATOR_STW481X_VMMC) += stw481x-vmmc.o
+obj-$(CONFIG_REGULATOR_SY8106A) += sy8106a-regulator.o
 obj-$(CONFIG_REGULATOR_TI_ABB) += ti-abb-regulator.o
 obj-$(CONFIG_REGULATOR_TPS6105X) += tps6105x-regulator.o
 obj-$(CONFIG_REGULATOR_TPS62360) += tps62360-regulator.o
@@ -125,5 +126,4 @@ obj-$(CONFIG_REGULATOR_WM8350) += wm8350-regulator.o
 obj-$(CONFIG_REGULATOR_WM8400) += wm8400-regulator.o
 obj-$(CONFIG_REGULATOR_WM8994) += wm8994-regulator.o
 
-
 ccflags-$(CONFIG_REGULATOR_DEBUG) += -DDEBUG
diff --git a/drivers/regulator/sy8106a-regulator.c b/drivers/regulator/sy8106a-regulator.c
new file mode 100644
index 000000000000..65fbd1f0b612
--- /dev/null
+++ b/drivers/regulator/sy8106a-regulator.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// sy8106a-regulator.c - Regulator device driver for SY8106A
+//
+// Copyright (C) 2016 Ondřej Jirman <megous@megous.com>
+// Copyright (c) 2017-2018 Icenowy Zheng <icenowy@aosc.io>
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
+	u32 fixed_voltage;
+};
+
+static const struct regmap_config sy8106a_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static const struct regulator_ops sy8106a_ops = {
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.list_voltage = regulator_list_voltage_linear,
+	/* Enabling/disabling the regulator is not yet implemented */
+};
+
+/* Default limits measured in millivolts */
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
+	unsigned int reg, vsel;
+	int error;
+
+	chip = devm_kzalloc(&i2c->dev, sizeof(struct sy8106a), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	error = of_property_read_u32(dev->of_node, "silergy,fixed-microvolt",
+				     &chip->fixed_voltage);
+	if (error)
+		return error;
+
+	if (chip->fixed_voltage < SY8106A_MIN_MV * 1000 ||
+	    chip->fixed_voltage > SY8106A_MAX_MV * 1000)
+		return -EINVAL;
+
+	chip->regmap = devm_regmap_init_i2c(i2c, &sy8106a_regmap_config);
+	if (IS_ERR(chip->regmap)) {
+		error = PTR_ERR(chip->regmap);
+		dev_err(dev, "Failed to allocate register map: %d\n", error);
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
+	/* Ensure GO_BIT is enabled when probing */
+	error = regmap_read(chip->regmap, SY8106A_REG_VOUT1_SEL, &reg);
+	if (error)
+		return error;
+
+	if (!(reg & SY8106A_GO_BIT)) {
+		vsel = (chip->fixed_voltage / 1000 - SY8106A_MIN_MV) /
+		       SY8106A_STEP_MV;
+
+		error = regmap_write(chip->regmap, SY8106A_REG_VOUT1_SEL,
+				     vsel | SY8106A_GO_BIT);
+		if (error)
+			return error;
+	}
+
+	/* Probe regulator */
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
+MODULE_AUTHOR("Icenowy Zheng <icenowy@aosc.io>");
+MODULE_DESCRIPTION("Regulator device driver for Silergy SY8106A");
+MODULE_LICENSE("GPL");
-- 
2.17.0
