Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932539AbeCISEt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 13:04:49 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40766 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932087AbeCISEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 13:04:47 -0500
From: Mark Brown <broonie@kernel.org>
To: Alexander Monakov <amonakov@ispras.ru>
Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: 88pg86x: new i2c dual regulator chip" to the regulator tree
In-Reply-To: <20180308225303.329-2-amonakov@ispras.ru>
Message-Id: <E1euMNk-00027i-No@debutante>
Date: Fri, 09 Mar 2018 18:04:40 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: 88pg86x: new i2c dual regulator chip

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

>From a265b03bd29a745d85237f47739d92cb43d214b9 Mon Sep 17 00:00:00 2001
From: Alexander Monakov <amonakov@ispras.ru>
Date: Fri, 9 Mar 2018 01:53:03 +0300
Subject: [PATCH] regulator: 88pg86x: new i2c dual regulator chip

This chip is found on Google Chromecast and Valve Steam Link devices.
It provides two DC regulators with I2C voltage control, separate GPIO
enable pins and one sleep mode pin.

This driver does not expose GPIO functionality, but supports voltage
control in 1.0-2.2V range, based on I2C register information given in
Chromecast kernel driver by Jisheng Zhang.

Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/88pg86x.c | 114 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/regulator/Kconfig   |   9 ++++
 drivers/regulator/Makefile  |   1 +
 3 files changed, 124 insertions(+)
 create mode 100644 drivers/regulator/88pg86x.c

diff --git a/drivers/regulator/88pg86x.c b/drivers/regulator/88pg86x.c
new file mode 100644
index 000000000000..d5ef55c81185
--- /dev/null
+++ b/drivers/regulator/88pg86x.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/of.h>
+#include <linux/regulator/driver.h>
+#include <linux/regmap.h>
+
+static const struct regulator_ops pg86x_ops = {
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.list_voltage = regulator_list_voltage_linear_range,
+};
+
+static const struct regulator_linear_range pg86x_buck1_ranges[] = {
+	REGULATOR_LINEAR_RANGE(      0,  0, 10,     0),
+	REGULATOR_LINEAR_RANGE(1000000, 11, 34, 25000),
+	REGULATOR_LINEAR_RANGE(1600000, 35, 47, 50000),
+};
+
+static const struct regulator_linear_range pg86x_buck2_ranges[] = {
+	REGULATOR_LINEAR_RANGE(      0,  0, 15,     0),
+	REGULATOR_LINEAR_RANGE(1000000, 16, 39, 25000),
+	REGULATOR_LINEAR_RANGE(1600000, 40, 52, 50000),
+};
+
+static const struct regulator_desc pg86x_regulators[] = {
+	{
+		.id = 0,
+		.type = REGULATOR_VOLTAGE,
+		.name = "buck1",
+		.of_match = of_match_ptr("buck1"),
+		.n_voltages = 11 + 24 + 13,
+		.linear_ranges = pg86x_buck1_ranges,
+		.n_linear_ranges = 3,
+		.vsel_reg  = 0x24,
+		.vsel_mask = 0xff,
+		.ops = &pg86x_ops,
+		.owner = THIS_MODULE
+	},
+	{
+		.id = 1,
+		.type = REGULATOR_VOLTAGE,
+		.name = "buck2",
+		.of_match = of_match_ptr("buck2"),
+		.n_voltages = 16 + 24 + 13,
+		.linear_ranges = pg86x_buck2_ranges,
+		.n_linear_ranges = 3,
+		.vsel_reg  = 0x13,
+		.vsel_mask = 0xff,
+		.ops = &pg86x_ops,
+		.owner = THIS_MODULE
+	},
+};
+
+static const struct regmap_config pg86x_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int pg86x_i2c_probe(struct i2c_client *i2c)
+{
+	int id, ret;
+	struct regulator_config config = {.dev = &i2c->dev};
+	struct regmap *regmap = devm_regmap_init_i2c(i2c, &pg86x_regmap);
+
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		dev_err(&i2c->dev, "regmap init failed: %d\n", ret);
+		return ret;
+	}
+
+	for (id = 0; id < ARRAY_SIZE(pg86x_regulators); id++) {
+		struct regulator_dev *rdev;
+		rdev = devm_regulator_register(&i2c->dev,
+					       &pg86x_regulators[id],
+					       &config);
+		if (IS_ERR(rdev)) {
+			ret = PTR_ERR(rdev);
+			dev_err(&i2c->dev, "failed to register %s: %d\n",
+				pg86x_regulators[id].name, ret);
+			return ret;
+		}
+	}
+	return 0;
+}
+
+static const struct of_device_id pg86x_dt_ids [] = {
+	{ .compatible = "marvell,88pg867" },
+	{ .compatible = "marvell,88pg868" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pg86x_dt_ids);
+
+static const struct i2c_device_id pg86x_i2c_id[] = {
+	{ "88pg867", },
+	{ "88pg868", },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, pg86x_i2c_id);
+
+static struct i2c_driver pg86x_regulator_driver = {
+	.driver = {
+		.name = "88pg86x",
+		.of_match_table = of_match_ptr(pg86x_dt_ids),
+	},
+	.probe_new = pg86x_i2c_probe,
+	.id_table = pg86x_i2c_id,
+};
+
+module_i2c_driver(pg86x_regulator_driver);
+
+MODULE_DESCRIPTION("Marvell 88PG86X voltage regulator");
+MODULE_AUTHOR("Alexander Monakov <amonakov@gmail.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index b27417ca188a..097f61784a7d 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -54,6 +54,15 @@ config REGULATOR_USERSPACE_CONSUMER
 
 	  If unsure, say no.
 
+config REGULATOR_88PG86X
+	tristate "Marvell 88PG86X voltage regulators"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  This driver supports Marvell 88PG867 and 88PG868 voltage regulators.
+	  They provide two I2C-controlled DC/DC step-down converters with
+	  sleep mode and separate enable pins.
+
 config REGULATOR_88PM800
 	tristate "Marvell 88PM800 Power regulators"
 	depends on MFD_88PM800
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 19fea09ba10a..590674fbecd7 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_REGULATOR_FIXED_VOLTAGE) += fixed.o
 obj-$(CONFIG_REGULATOR_VIRTUAL_CONSUMER) += virtual.o
 obj-$(CONFIG_REGULATOR_USERSPACE_CONSUMER) += userspace-consumer.o
 
+obj-$(CONFIG_REGULATOR_88PG86X) += 88pg86x.o
 obj-$(CONFIG_REGULATOR_88PM800) += 88pm800.o
 obj-$(CONFIG_REGULATOR_88PM8607) += 88pm8607.o
 obj-$(CONFIG_REGULATOR_CPCAP) += cpcap-regulator.o
-- 
2.16.2
