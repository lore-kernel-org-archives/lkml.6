Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752614AbeB1KhC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:37:02 -0500
Received: from mail.bootlin.com ([62.4.15.54]:55897 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752229AbeB1Kg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:36:58 -0500
From: Quentin Schulz <quentin.schulz@bootlin.com>
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org
Cc: maxime.ripard@bootlin.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        linux-sunxi@googlegroups.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH v5 5/6] power: supply: axp20x_battery: add support for AXP813
Date: Wed, 28 Feb 2018 11:36:00 +0100
Message-Id: <3969fa859a80afba1fe3c9b71cf3147111582520.1519813976.git-series.quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.07d02d245f44e63775b331815e9bf584598d2e9f.1519813976.git-series.quentin.schulz@bootlin.com>
References: <cover.07d02d245f44e63775b331815e9bf584598d2e9f.1519813976.git-series.quentin.schulz@bootlin.com>
In-Reply-To: <cover.07d02d245f44e63775b331815e9bf584598d2e9f.1519813976.git-series.quentin.schulz@bootlin.com>
References: <cover.07d02d245f44e63775b331815e9bf584598d2e9f.1519813976.git-series.quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The X-Powers AXP813 PMIC has got some slight differences from
AXP20X/AXP22X PMICs:
 - the maximum voltage supplied by the PMIC is 4.35 instead of 4.36/4.24
 for AXP20X/AXP22X,
 - the constant charge current formula is different,

It also has a bit to tell whether the battery percentage returned by the
PMIC is valid.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/power/supply/axp20x_battery.c | 42 ++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+)

diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index 04a0d91..4f69c0e 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -49,6 +49,8 @@
 #define AXP22X_CHRG_CTRL1_TGT_4_22V	(1 << 5)
 #define AXP22X_CHRG_CTRL1_TGT_4_24V	(3 << 5)
 
+#define AXP813_CHRG_CTRL1_TGT_4_35V	(3 << 5)
+
 #define AXP20X_CHRG_CTRL1_TGT_CURR	GENMASK(3, 0)
 
 #define AXP20X_V_OFF_MASK		GENMASK(2, 0)
@@ -133,6 +135,35 @@ static int axp22x_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
 	return 0;
 }
 
+static int axp813_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
+					  int *val)
+{
+	int ret, reg;
+
+	ret = regmap_read(axp20x_batt->regmap, AXP20X_CHRG_CTRL1, &reg);
+	if (ret)
+		return ret;
+
+	switch (reg & AXP20X_CHRG_CTRL1_TGT_VOLT) {
+	case AXP20X_CHRG_CTRL1_TGT_4_1V:
+		*val = 4100000;
+		break;
+	case AXP20X_CHRG_CTRL1_TGT_4_15V:
+		*val = 4150000;
+		break;
+	case AXP20X_CHRG_CTRL1_TGT_4_2V:
+		*val = 4200000;
+		break;
+	case AXP813_CHRG_CTRL1_TGT_4_35V:
+		*val = 4350000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int axp20x_get_constant_charge_current(struct axp20x_batt_ps *axp,
 					      int *val)
 {
@@ -491,6 +522,14 @@ static const struct axp_data axp221_data = {
 	.set_max_voltage = axp22x_battery_set_max_voltage,
 };
 
+static const struct axp_data axp813_data = {
+	.ccc_scale = 200000,
+	.ccc_offset = 200000,
+	.has_fg_valid = true,
+	.get_max_voltage = axp813_battery_get_max_voltage,
+	.set_max_voltage = axp20x_battery_set_max_voltage,
+};
+
 static const struct of_device_id axp20x_battery_ps_id[] = {
 	{
 		.compatible = "x-powers,axp209-battery-power-supply",
@@ -498,6 +537,9 @@ static const struct of_device_id axp20x_battery_ps_id[] = {
 	}, {
 		.compatible = "x-powers,axp221-battery-power-supply",
 		.data = (void *)&axp221_data,
+	}, {
+		.compatible = "x-powers,axp813-battery-power-supply",
+		.data = (void *)&axp813_data,
 	}, { /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, axp20x_battery_ps_id);
-- 
git-series 0.9.1
