Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751772AbeEABux (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 21:50:53 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:34787 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751261AbeEABuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 21:50:52 -0400
X-Auth-Info: ZkgvTIxIphWsKYrQaux7Aw/vee4nDVrvdThxQZ+tt+E=
From: Marek Vasut <marex@denx.de>
To: linux-kernel@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] regulator: ltc3676: Assure PGOOD mask is set before changing voltage
Date: Tue,  1 May 2018 03:50:45 +0200
Message-Id: <20180501015045.19166-1-marex@denx.de>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure the DVBxB bit 5, PGOOD mask, is set before changing voltage
on the buck converters. If the PGOOD mask bit is not set, the PMIC may
deassert the PGOOD signal during the voltage transition.

On systems that use the PGOOD signal as a power OK indication for the
board or SoC, which should be the case on correct designs, deasserting
the PGOOD signal will lead to system reset or shutdown, which is not
the expected behavior when changing PMIC buck converter voltage.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Mark Brown <broonie@kernel.org>
---
NOTE: This was observed on an iMX6Q design during DVFS. When the cpufreq
      driver changed the frequency and scaled the voltage up, the system
      froze. This was because the PGOOD went down and the voltage rails
      lost power shortly after.
---
 drivers/regulator/ltc3676.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/ltc3676.c b/drivers/regulator/ltc3676.c
index 662ee05ea44d..9dec1609ff66 100644
--- a/drivers/regulator/ltc3676.c
+++ b/drivers/regulator/ltc3676.c
@@ -52,6 +52,7 @@
 #define LTC3676_CLIRQ     0x1F
 
 #define LTC3676_DVBxA_REF_SELECT	BIT(5)
+#define LTC3676_DVBxB_PGOOD_MASK	BIT(5)
 
 #define LTC3676_IRQSTAT_PGOOD_TIMEOUT	BIT(3)
 #define LTC3676_IRQSTAT_UNDERVOLT_WARN	BIT(4)
@@ -123,6 +124,23 @@ static int ltc3676_set_suspend_mode(struct regulator_dev *rdev,
 				  mask, val);
 }
 
+static int ltc3676_set_voltage_sel(struct regulator_dev *rdev, unsigned selector)
+{
+	struct ltc3676 *ltc3676 = rdev_get_drvdata(rdev);
+	struct device *dev = ltc3676->dev;
+	int ret, dcdc = rdev_get_id(rdev);
+
+	dev_dbg(dev, "%s id=%d selector=%d\n", __func__, dcdc, selector);
+
+	ret = regmap_update_bits(ltc3676->regmap, rdev->desc->vsel_reg + 1,
+				 LTC3676_DVBxB_PGOOD_MASK,
+				 LTC3676_DVBxB_PGOOD_MASK);
+	if (ret)
+		return ret;
+
+	return regulator_set_voltage_sel_regmap(rdev, selector);
+}
+
 static inline unsigned int ltc3676_scale(unsigned int uV, u32 r1, u32 r2)
 {
 	uint64_t tmp;
@@ -166,7 +184,7 @@ static const struct regulator_ops ltc3676_linear_regulator_ops = {
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
 	.list_voltage = regulator_list_voltage_linear,
-	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.set_voltage_sel = ltc3676_set_voltage_sel,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_suspend_voltage = ltc3676_set_suspend_voltage,
 	.set_suspend_mode = ltc3676_set_suspend_mode,
-- 
2.16.2
