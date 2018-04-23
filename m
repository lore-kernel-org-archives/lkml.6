Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932505AbeDWSFI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 14:05:08 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58370 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932129AbeDWSFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 14:05:04 -0400
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Applied "regulator: bd9571mwv: Add support for backup mode" to the regulator tree
In-Reply-To: <1521025722-24205-5-git-send-email-geert+renesas@glider.be>
Message-Id: <E1fAfpk-0004Bn-Gw@debutante>
Date: Mon, 23 Apr 2018 19:05:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: bd9571mwv: Add support for backup mode

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

>From 6eb0bfae6973eb6a7790f9d21e294022fe2da6ad Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 18 Apr 2018 15:18:04 +0200
Subject: [PATCH] regulator: bd9571mwv: Add support for backup mode

The BD9571MWV PMIC supports backup mode, which keeps one or more DDR
rails powered while the main SoC is powered down.

Which DDR rails are to be kept powered is board-specific, and controlled
using the optional "rohm,ddr-backup-power" DT property.  In the absence
of this property, backup mode is not available.

Backup mode can be enabled or disabled by the user using the standard
"wakeup" virtual file in sysfs, e.g. to enable:

    echo enabled > /sys/devices/platform/soc/e60b0000.i2c/i2c-7/7-0030/bd9571mwv-regulator.2.auto/power/wakeup

When the PMIC is configured for backup mode, the role of the accessory
power switch changes from a power switch to a wake-up switch.
Two types of switches (or signals) can be used:
  A. With a momentary power switch (or pulse signal), the PMIC is
     configured for backup mode in the PMIC driver's suspend callback,
     during system suspend.
     Backup mode is enabled by default, as there is no further impact
     during normal system operation.

  B. With a toggle power switch (or level signal), the following steps
     must be followed exactly:
       1. Configure PMIC for backup mode,
       2. Switch accessory power switch off, to prepare for system
          suspend, which is a manual step not controlled by software,
       3. Suspend system.
     This mode is not yet supported by the driver.

As the switch type is board-specific, and cannot be determined
automatically, it is obtained from the presence of one of the
"rohm,rstbmode-*" properties in DT.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/bd9571mwv-regulator.c | 127 +++++++++++++++++++++++-
 1 file changed, 126 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/bd9571mwv-regulator.c b/drivers/regulator/bd9571mwv-regulator.c
index c67a83d53c4c..be574eb444eb 100644
--- a/drivers/regulator/bd9571mwv-regulator.c
+++ b/drivers/regulator/bd9571mwv-regulator.c
@@ -24,6 +24,18 @@
 
 #include <linux/mfd/bd9571mwv.h>
 
+struct bd9571mwv_reg {
+	struct bd9571mwv *bd;
+
+	/* DDR Backup Power */
+	u8 bkup_mode_cnt_keepon;	/* from "rohm,ddr-backup-power" */
+	u8 bkup_mode_cnt_saved;
+
+	/* Power switch type */
+	bool rstbmode_level;
+	bool rstbmode_pulse;
+};
+
 enum bd9571mwv_regulators { VD09, VD18, VD25, VD33, DVFS };
 
 #define BD9571MWV_REG(_name, _of, _id, _ops, _vr, _vm, _nv, _min, _step, _lmin)\
@@ -131,14 +143,99 @@ static struct regulator_desc regulators[] = {
 		      0x80, 600000, 10000, 0x3c),
 };
 
+#ifdef CONFIG_PM_SLEEP
+static int bd9571mwv_bkup_mode_read(struct bd9571mwv *bd, unsigned int *mode)
+{
+	int ret;
+
+	ret = regmap_read(bd->regmap, BD9571MWV_BKUP_MODE_CNT, mode);
+	if (ret) {
+		dev_err(bd->dev, "failed to read backup mode (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int bd9571mwv_bkup_mode_write(struct bd9571mwv *bd, unsigned int mode)
+{
+	int ret;
+
+	ret = regmap_write(bd->regmap, BD9571MWV_BKUP_MODE_CNT, mode);
+	if (ret) {
+		dev_err(bd->dev, "failed to configure backup mode 0x%x (%d)\n",
+			mode, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int bd9571mwv_suspend(struct device *dev)
+{
+	struct bd9571mwv_reg *bdreg = dev_get_drvdata(dev);
+	unsigned int mode;
+	int ret;
+
+	if (!device_may_wakeup(dev))
+		return 0;
+
+	/* Save DDR Backup Mode */
+	ret = bd9571mwv_bkup_mode_read(bdreg->bd, &mode);
+	if (ret)
+		return ret;
+
+	bdreg->bkup_mode_cnt_saved = mode;
+
+	if (!bdreg->rstbmode_pulse)
+		return 0;
+
+	/* Enable DDR Backup Mode */
+	mode &= ~BD9571MWV_BKUP_MODE_CNT_KEEPON_MASK;
+	mode |= bdreg->bkup_mode_cnt_keepon;
+
+	if (mode != bdreg->bkup_mode_cnt_saved)
+		return bd9571mwv_bkup_mode_write(bdreg->bd, mode);
+
+	return 0;
+}
+
+static int bd9571mwv_resume(struct device *dev)
+{
+	struct bd9571mwv_reg *bdreg = dev_get_drvdata(dev);
+
+	if (!device_may_wakeup(dev))
+		return 0;
+
+	/* Restore DDR Backup Mode */
+	return bd9571mwv_bkup_mode_write(bdreg->bd, bdreg->bkup_mode_cnt_saved);
+}
+
+static const struct dev_pm_ops bd9571mwv_pm  = {
+	SET_SYSTEM_SLEEP_PM_OPS(bd9571mwv_suspend, bd9571mwv_resume)
+};
+
+#define DEV_PM_OPS	&bd9571mwv_pm
+#else
+#define DEV_PM_OPS	NULL
+#endif /* CONFIG_PM_SLEEP */
+
 static int bd9571mwv_regulator_probe(struct platform_device *pdev)
 {
 	struct bd9571mwv *bd = dev_get_drvdata(pdev->dev.parent);
 	struct regulator_config config = { };
+	struct bd9571mwv_reg *bdreg;
 	struct regulator_dev *rdev;
+	unsigned int val;
 	int i;
 
-	platform_set_drvdata(pdev, bd);
+	bdreg = devm_kzalloc(&pdev->dev, sizeof(*bdreg), GFP_KERNEL);
+	if (!bdreg)
+		return -ENOMEM;
+
+	bdreg->bd = bd;
+
+	platform_set_drvdata(pdev, bdreg);
 
 	config.dev = &pdev->dev;
 	config.dev->of_node = bd->dev->of_node;
@@ -155,6 +252,33 @@ static int bd9571mwv_regulator_probe(struct platform_device *pdev)
 		}
 	}
 
+	val = 0;
+	of_property_read_u32(bd->dev->of_node, "rohm,ddr-backup-power", &val);
+	if (val & ~BD9571MWV_BKUP_MODE_CNT_KEEPON_MASK) {
+		dev_err(bd->dev, "invalid %s mode %u\n",
+			"rohm,ddr-backup-power", val);
+		return -EINVAL;
+	}
+	bdreg->bkup_mode_cnt_keepon = val;
+
+	bdreg->rstbmode_level = of_property_read_bool(bd->dev->of_node,
+						      "rohm,rstbmode-level");
+	bdreg->rstbmode_pulse = of_property_read_bool(bd->dev->of_node,
+						      "rohm,rstbmode-pulse");
+	if (bdreg->rstbmode_level && bdreg->rstbmode_pulse) {
+		dev_err(bd->dev, "only one rohm,rstbmode-* may be specified");
+		return -EINVAL;
+	}
+
+	if (bdreg->bkup_mode_cnt_keepon) {
+		device_set_wakeup_capable(&pdev->dev, true);
+		/*
+		 * Wakeup is enabled by default in pulse mode, but needs
+		 * explicit user setup in level mode.
+		 */
+		device_set_wakeup_enable(&pdev->dev, bdreg->rstbmode_pulse);
+	}
+
 	return 0;
 }
 
@@ -167,6 +291,7 @@ MODULE_DEVICE_TABLE(platform, bd9571mwv_regulator_id_table);
 static struct platform_driver bd9571mwv_regulator_driver = {
 	.driver = {
 		.name = "bd9571mwv-regulator",
+		.pm = DEV_PM_OPS,
 	},
 	.probe = bd9571mwv_regulator_probe,
 	.id_table = bd9571mwv_regulator_id_table,
-- 
2.17.0
