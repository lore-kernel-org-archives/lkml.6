Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751200AbeCHWxg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 17:53:36 -0500
Received: from bran.ispras.ru ([83.149.199.196]:10325 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751046AbeCHWxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 17:53:35 -0500
From: Alexander Monakov <amonakov@ispras.ru>
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Alexander Monakov <amonakov@ispras.ru>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: [PATCH 2/2] regulator: 88pg86x: new i2c dual regulator chip
Date: Fri,  9 Mar 2018 01:53:03 +0300
Message-Id: <20180308225303.329-2-amonakov@ispras.ru>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180308225303.329-1-amonakov@ispras.ru>
References: <20180308225303.329-1-amonakov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This chip is found on Google Chromecast and Valve Steam Link devices.
It provides two DC regulators with I2C voltage control, separate GPIO
enable pins and one sleep mode pin.

This driver does not expose GPIO functionality, but supports voltage
control in 1.0-2.2V range, based on I2C register information given in
Chromecast kernel driver by Jisheng Zhang.

Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
---
Hello,

Some high-level information on the chip is available in Marvell's PDF titled
"DC/DC Power Regulators Product Portfolio" [1]. Chromecast's drivers show two
linear ranges: 1.0-1.6V at 25mV steps and 1.6-2.2V at 50mV steps. The brochure
says that programmable range is 0.6-3.3V, though, so this patch doesn't support
the full voltage range.

I've also opted not to support GPIO sleep and enable pins over concerns that it
would be a dead weight.

I'd like to use this for controlling the voltage regulator on Steam Link device.

Thanks.
Alexander

[1] https://www.marvell.com/power-management/assets/Marvell-DC-DC-Power-Regulators-Product-Portfolio.pdf

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
index 96cd55f9e3c5..16afb644aee7 100644
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
index 80ffc57a9ca3..fbd5e91dd981 100644
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
2.11.0
