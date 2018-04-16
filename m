Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754809AbeDPMGM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:06:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45690 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754532AbeDPMGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:06:10 -0400
From: Mark Brown <broonie@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Loic Pallardy <loic.pallardy@st.com>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, Loic Pallardy <loic.pallardy@st.com>,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: ab8500: Drop AB8540/9540 support" to the regulator tree
In-Reply-To: <20180322101740.9776-1-linus.walleij@linaro.org>
Message-Id: <E1f82tZ-0000pS-0N@debutante>
Date: Mon, 16 Apr 2018 13:06:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: ab8500: Drop AB8540/9540 support

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

>From 17333f544fa588ab756b339a2794b15d29b8cc08 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Mar 2018 11:17:40 +0100
Subject: [PATCH] regulator: ab8500: Drop AB8540/9540 support

The AB8540 was an evolved version of the AB8500, but it was never
mass produced or put into products, only reference designs exist.
The upstream support was never completed and it is unlikely that
this will happen so drop the support for now to simplify
maintenance of the AB8500.

Cc: Loic Pallardy <loic.pallardy@st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/ab8500.c       | 1779 ++++--------------------------
 include/linux/regulator/ab8500.h |  157 +--
 2 files changed, 188 insertions(+), 1748 deletions(-)

diff --git a/drivers/regulator/ab8500.c b/drivers/regulator/ab8500.c
index 0f97514e3474..83dba3fbfe0c 100644
--- a/drivers/regulator/ab8500.c
+++ b/drivers/regulator/ab8500.c
@@ -132,33 +132,6 @@ static const unsigned int ldo_vaux56_voltages[] = {
 	2790000,
 };
 
-static const unsigned int ldo_vaux3_ab8540_voltages[] = {
-	1200000,
-	1500000,
-	1800000,
-	2100000,
-	2500000,
-	2750000,
-	2790000,
-	2910000,
-	3050000,
-};
-
-static const unsigned int ldo_vaux56_ab8540_voltages[] = {
-	750000, 760000, 770000, 780000, 790000, 800000,
-	810000, 820000, 830000, 840000, 850000, 860000,
-	870000, 880000, 890000, 900000, 910000, 920000,
-	930000, 940000, 950000, 960000, 970000, 980000,
-	990000, 1000000, 1010000, 1020000, 1030000,
-	1040000, 1050000, 1060000, 1070000, 1080000,
-	1090000, 1100000, 1110000, 1120000, 1130000,
-	1140000, 1150000, 1160000, 1170000, 1180000,
-	1190000, 1200000, 1210000, 1220000, 1230000,
-	1240000, 1250000, 1260000, 1270000, 1280000,
-	1290000, 1300000, 1310000, 1320000, 1330000,
-	1340000, 1350000, 1360000, 1800000, 2790000,
-};
-
 static const unsigned int ldo_vintcore_voltages[] = {
 	1200000,
 	1225000,
@@ -232,8 +205,6 @@ static const unsigned int ldo_vdmic_voltages[] = {
 static DEFINE_MUTEX(shared_mode_mutex);
 static struct ab8500_shared_mode ldo_anamic1_shared;
 static struct ab8500_shared_mode ldo_anamic2_shared;
-static struct ab8500_shared_mode ab8540_ldo_anamic1_shared;
-static struct ab8500_shared_mode ab8540_ldo_anamic2_shared;
 
 static int ab8500_regulator_enable(struct regulator_dev *rdev)
 {
@@ -507,53 +478,6 @@ static int ab8500_regulator_get_voltage_sel(struct regulator_dev *rdev)
 	return (regval & info->voltage_mask) >> voltage_shift;
 }
 
-static int ab8540_aux3_regulator_get_voltage_sel(struct regulator_dev *rdev)
-{
-	int ret, voltage_shift;
-	struct ab8500_regulator_info *info = rdev_get_drvdata(rdev);
-	u8 regval, regval_expand;
-
-	if (info == NULL) {
-		dev_err(rdev_get_dev(rdev), "regulator info null pointer\n");
-		return -EINVAL;
-	}
-
-	ret = abx500_get_register_interruptible(info->dev,
-			info->expand_register.voltage_bank,
-			info->expand_register.voltage_reg, &regval_expand);
-	if (ret < 0) {
-		dev_err(rdev_get_dev(rdev),
-			"couldn't read voltage expand reg for regulator\n");
-		return ret;
-	}
-
-	dev_vdbg(rdev_get_dev(rdev),
-		 "%s-get_voltage expand (bank, reg, mask, value): 0x%x, 0x%x, 0x%x, 0x%x\n",
-		 info->desc.name, info->expand_register.voltage_bank,
-		 info->expand_register.voltage_reg,
-		 info->expand_register.voltage_mask, regval_expand);
-
-	if (regval_expand & info->expand_register.voltage_mask)
-		return info->expand_register.voltage_limit;
-
-	ret = abx500_get_register_interruptible(info->dev,
-			info->voltage_bank, info->voltage_reg, &regval);
-	if (ret < 0) {
-		dev_err(rdev_get_dev(rdev),
-			"couldn't read voltage reg for regulator\n");
-		return ret;
-	}
-
-	dev_vdbg(rdev_get_dev(rdev),
-		 "%s-get_voltage (bank, reg, mask, value): 0x%x, 0x%x, 0x%x, 0x%x\n",
-		 info->desc.name, info->voltage_bank, info->voltage_reg,
-		 info->voltage_mask, regval);
-
-	voltage_shift = ffs(info->voltage_mask) - 1;
-
-	return (regval & info->voltage_mask) >> voltage_shift;
-}
-
 static int ab8500_regulator_set_voltage_sel(struct regulator_dev *rdev,
 					    unsigned selector)
 {
@@ -586,61 +510,6 @@ static int ab8500_regulator_set_voltage_sel(struct regulator_dev *rdev,
 	return ret;
 }
 
-static int ab8540_aux3_regulator_set_voltage_sel(struct regulator_dev *rdev,
-						unsigned selector)
-{
-	int ret;
-	struct ab8500_regulator_info *info = rdev_get_drvdata(rdev);
-	u8 regval, regval_expand;
-
-	if (info == NULL) {
-		dev_err(rdev_get_dev(rdev), "regulator info null pointer\n");
-		return -EINVAL;
-	}
-
-	if (selector < info->expand_register.voltage_limit) {
-		int voltage_shift = ffs(info->voltage_mask) - 1;
-
-		regval = (u8)selector << voltage_shift;
-		ret = abx500_mask_and_set_register_interruptible(info->dev,
-					info->voltage_bank, info->voltage_reg,
-					info->voltage_mask, regval);
-		if (ret < 0) {
-			dev_err(rdev_get_dev(rdev),
-				"couldn't set voltage reg for regulator\n");
-			return ret;
-		}
-
-		dev_vdbg(rdev_get_dev(rdev),
-			 "%s-set_voltage (bank, reg, mask, value): 0x%x, 0x%x, 0x%x, 0x%x\n",
-			 info->desc.name, info->voltage_bank, info->voltage_reg,
-			 info->voltage_mask, regval);
-
-		regval_expand = 0;
-	} else {
-		regval_expand = info->expand_register.voltage_mask;
-	}
-
-	ret = abx500_mask_and_set_register_interruptible(info->dev,
-				info->expand_register.voltage_bank,
-				info->expand_register.voltage_reg,
-				info->expand_register.voltage_mask,
-				regval_expand);
-	if (ret < 0) {
-		dev_err(rdev_get_dev(rdev),
-			"couldn't set expand voltage reg for regulator\n");
-		return ret;
-	}
-
-	dev_vdbg(rdev_get_dev(rdev),
-		 "%s-set_voltage expand (bank, reg, mask, value): 0x%x, 0x%x, 0x%x, 0x%x\n",
-		 info->desc.name, info->expand_register.voltage_bank,
-		 info->expand_register.voltage_reg,
-		 info->expand_register.voltage_mask, regval_expand);
-
-	return 0;
-}
-
 static struct regulator_ops ab8500_regulator_volt_mode_ops = {
 	.enable			= ab8500_regulator_enable,
 	.disable		= ab8500_regulator_disable,
@@ -653,18 +522,6 @@ static struct regulator_ops ab8500_regulator_volt_mode_ops = {
 	.list_voltage		= regulator_list_voltage_table,
 };
 
-static struct regulator_ops ab8540_aux3_regulator_volt_mode_ops = {
-	.enable		= ab8500_regulator_enable,
-	.disable	= ab8500_regulator_disable,
-	.get_optimum_mode	= ab8500_regulator_get_optimum_mode,
-	.set_mode	= ab8500_regulator_set_mode,
-	.get_mode	= ab8500_regulator_get_mode,
-	.is_enabled	= ab8500_regulator_is_enabled,
-	.get_voltage_sel = ab8540_aux3_regulator_get_voltage_sel,
-	.set_voltage_sel = ab8540_aux3_regulator_set_voltage_sel,
-	.list_voltage	= regulator_list_voltage_table,
-};
-
 static struct regulator_ops ab8500_regulator_volt_ops = {
 	.enable		= ab8500_regulator_enable,
 	.disable	= ab8500_regulator_disable,
@@ -1217,1156 +1074,118 @@ static struct ab8500_regulator_info
 	},
 };
 
-/* AB9540 regulator information */
-static struct ab8500_regulator_info
-		ab9540_regulator_info[AB9540_NUM_REGULATORS] = {
+static struct ab8500_shared_mode ldo_anamic1_shared = {
+	.shared_regulator = &ab8505_regulator_info[AB8505_LDO_ANAMIC2],
+};
+
+static struct ab8500_shared_mode ldo_anamic2_shared = {
+	.shared_regulator = &ab8505_regulator_info[AB8505_LDO_ANAMIC1],
+};
+
+struct ab8500_reg_init {
+	u8 bank;
+	u8 addr;
+	u8 mask;
+};
+
+#define REG_INIT(_id, _bank, _addr, _mask)	\
+	[_id] = {				\
+		.bank = _bank,			\
+		.addr = _addr,			\
+		.mask = _mask,			\
+	}
+
+/* AB8500 register init */
+static struct ab8500_reg_init ab8500_reg_init[] = {
 	/*
-	 * Variable Voltage Regulators
-	 *   name, min mV, max mV,
-	 *   update bank, reg, mask, enable val
-	 *   volt bank, reg, mask
+	 * 0x30, VanaRequestCtrl
+	 * 0xc0, VextSupply1RequestCtrl
 	 */
-	[AB9540_LDO_AUX1] = {
-		.desc = {
-			.name		= "LDO-AUX1",
-			.ops		= &ab8500_regulator_volt_mode_ops,
-			.type		= REGULATOR_VOLTAGE,
-			.id		= AB9540_LDO_AUX1,
-			.owner		= THIS_MODULE,
-			.n_voltages	= ARRAY_SIZE(ldo_vauxn_voltages),
-			.volt_table	= ldo_vauxn_voltages,
-		},
-		.load_lp_uA		= 5000,
-		.update_bank		= 0x04,
-		.update_reg		= 0x09,
-		.update_mask		= 0x03,
-		.update_val		= 0x01,
-		.update_val_idle	= 0x03,
-		.update_val_normal	= 0x01,
-		.voltage_bank		= 0x04,
-		.voltage_reg		= 0x1f,
-		.voltage_mask		= 0x0f,
-	},
-	[AB9540_LDO_AUX2] = {
-		.desc = {
-			.name		= "LDO-AUX2",
-			.ops		= &ab8500_regulator_volt_mode_ops,
-			.type		= REGULATOR_VOLTAGE,
-			.id		= AB9540_LDO_AUX2,
-			.owner		= THIS_MODULE,
-			.n_voltages	= ARRAY_SIZE(ldo_vauxn_voltages),
-			.volt_table	= ldo_vauxn_voltages,
-		},
-		.load_lp_uA		= 5000,
-		.update_bank		= 0x04,
-		.update_reg		= 0x09,
-		.update_mask		= 0x0c,
-		.update_val		= 0x04,
-		.update_val_idle	= 0x0c,
-		.update_val_normal	= 0x04,
-		.voltage_bank		= 0x04,
-		.voltage_reg		= 0x20,
-		.voltage_mask		= 0x0f,
-	},
-	[AB9540_LDO_AUX3] = {
-		.desc = {
-			.name		= "LDO-AUX3",
-			.ops		= &ab8500_regulator_volt_mode_ops,
-			.type		= REGULATOR_VOLTAGE,
-			.id		= AB9540_LDO_AUX3,
-			.owner		= THIS_MODULE,
-			.n_voltages	= ARRAY_SIZE(ldo_vaux3_voltages),
-			.volt_table	= ldo_vaux3_voltages,
-		},
-		.load_lp_uA		= 5000,
-		.update_bank		= 0x04,
-		.update_reg		= 0x0a,
-		.update_mask		= 0x03,
-		.update_val		= 0x01,
-		.update_val_idle	= 0x03,
-		.update_val_normal	= 0x01,
-		.voltage_bank		= 0x04,
-		.voltage_reg		= 0x21,
-		.voltage_mask		= 0x07,
-	},
-	[AB9540_LDO_AUX4] = {
-		.desc = {
-			.name		= "LDO-AUX4",
-			.ops		= &ab8500_regulator_volt_mode_ops,
-			.type		= REGULATOR_VOLTAGE,
-			.id		= AB9540_LDO_AUX4,
-			.owner		= THIS_MODULE,
-			.n_voltages	= ARRAY_SIZE(ldo_vauxn_voltages),
-			.volt_table	= ldo_vauxn_voltages,
-		},
-		.load_lp_uA		= 5000,
-		/* values for Vaux4Regu register */
-		.update_bank		= 0x04,
-		.update_reg		= 0x2e,
-		.update_mask		= 0x03,
-		.update_val		= 0x01,
-		.update_val_idle	= 0x03,
-		.update_val_normal	= 0x01,
-		/* values for Vaux4SEL register */
-		.voltage_bank		= 0x04,
-		.voltage_reg		= 0x2f,
-		.voltage_mask		= 0x0f,
-	},
-	[AB9540_LDO_INTCORE] = {
-		.desc = {
-			.name		= "LDO-INTCORE",
-			.ops		= &ab8500_regulator_volt_mode_ops,
-			.type		= REGULATOR_VOLTAGE,
-			.id		= AB9540_LDO_INTCORE,
-			.owner		= THIS_MODULE,
-			.n_voltages	= ARRAY_SIZE(ldo_vintcore_voltages),
-			.volt_table	= ldo_vintcore_voltages,
-		},
-		.load_lp_uA		= 5000,
-		.update_bank		= 0x03,
-		.update_reg		= 0x80,
-		.update_mask		= 0x44,
-		.update_val		= 0x44,
-		.update_val_idle	= 0x44,
-		.update_val_normal	= 0x04,
-		.voltage_bank		= 0x03,
-		.voltage_reg		= 0x80,
-		.voltage_mask		= 0x38,
-	},
-
+	REG_INIT(AB8500_REGUREQUESTCTRL2,	0x03, 0x04, 0xf0),
 	/*
-	 * Fixed Voltage Regulators
-	 *   name, fixed mV,
-	 *   update bank, reg, mask, enable val
+	 * 0x03, VextSupply2RequestCtrl
+	 * 0x0c, VextSupply3RequestCtrl
+	 * 0x30, Vaux1RequestCtrl
+	 * 0xc0, Vaux2RequestCtrl
 	 */
-	[AB9540_LDO_TVOUT] = {
-		.desc = {
-			.name		= "LDO-TVOUT",
-			.ops		= &ab8500_regulator_mode_ops,
-			.type		= REGULATOR_VOLTAGE,
-			.id		= AB9540_LDO_TVOUT,
-			.owner		= THIS_MODULE,
-			.n_voltages	= 1,
-			.volt_table	= fixed_2000000_voltage,
-			.enable_time	= 10000,
-		},
-		.load_lp_uA		= 1000,
-		.update_bank		= 0x03,
-		.update_reg		= 0x80,
-		.update_mask		= 0x82,
-		.update_val		= 0x02,
-		.update_val_idle	= 0x82,
-		.update_val_normal	= 0x02,
-	},
-	[AB9540_LDO_USB] = {
-		.desc = {
-			.name           = "LDO-USB",
-			.ops            = &ab8500_regulator_ops,
-			.type           = REGULATOR_VOLTAGE,
-			.id             = AB9540_LDO_USB,
-			.owner          = THIS_MODULE,
-			.n_voltages     = 1,
-			.volt_table	= fixed_3300000_voltage,
-		},
-		.update_bank            = 0x03,
-		.update_reg             = 0x82,
-		.update_mask            = 0x03,
-		.update_val		= 0x01,
-		.update_val_idle	= 0x03,
-		.update_val_normal	= 0x01,
-	},
-	[AB9540_LDO_AUDIO] = {
-		.desc = {
-			.name		= "LDO-AUDIO",
-			.ops		= &ab8500_regulator_ops,
-			.type		= REGULATOR_VOLTAGE,
-			.id		= AB9540_LDO_AUDIO,
-			.owner		= THIS_MODULE,
-			.n_voltages	= 1,
-			.volt_table	= fixed_2000000_voltage,
-		},
-		.update_bank		= 0x03,
-		.update_reg		= 0x83,
-		.update_mask		= 0x02,
-		.update_val		= 0x02,
-	},
-	[AB9540_LDO_ANAMIC1] = {
-		.desc = {
-			.name		= "LDO-ANAMIC1",
-			.ops		= &ab8500_regulator_ops,
-			.type		= REGULATOR_VOLTAGE,
-			.id		= AB9540_LDO_ANAMIC1,
-			.owner		= THIS_MODULE,
-			.n_voltages	= 1,
-			.volt_table	= fixed_2050000_voltage,
-		},
-		.update_bank		= 0x03,
-		.update_reg		= 0x83,
-		.update_mask		= 0x08,
-		.update_val		= 0x08,
-	},
-	[AB9540_LDO_ANAMIC2] = {
-		.desc = {
-			.name		= "LDO-ANAMIC2",
-			.ops		= &ab8500_regulator_ops,
-			.type		= REGULATOR_VOLTAGE,
-			.id		= AB9540_LDO_ANAMIC2,
-			.owner		= THIS_MODULE,
-			.n_voltages	= 1,
-			.volt_table	= fixed_2050000_voltage,
-		},
-		.update_bank		= 0x03,
-		.update_reg		= 0x83,
-		.update_mask		= 0x10,
-		.update_val		= 0x10,
-	},
-	[AB9540_LDO_DMIC] = {
-		.desc = {
-			.name		= "LDO-DMIC",
-			.ops		= &ab8500_regulator_ops,
-			.type		= REGULATOR_VOLTAGE,
-			.id		= AB9540_LDO_DMIC,
-			.owner		= THIS_MODULE,
-			.n_voltages	= 1,
-			.volt_table	= fixed_1800000_voltage,
-		},
-		.update_bank		= 0x03,
-		.update_reg		= 0x83,
-		.update_mask		= 0x04,
-		.update_val		= 0x04,
-	},
-
-	/*
-	 * Regulators with fixed voltage and normal/idle modes
-	 */
-	[AB9540_LDO_ANA] = {
-		.desc = {
-			.name		= "LDO-ANA",
-			.ops		= &ab8500_regulator_mode_ops,
-			.type		= REGULATOR_VOLTAGE,
-			.id		= AB9540_LDO_ANA,
-			.owner		= THIS_MODULE,
-			.n_voltages	= 1,
-			.volt_table	= fixed_1200000_voltage,
-		},
-		.load_lp_uA		= 1000,
-		.update_bank		= 0x04,
-		.update_reg		= 0x06,
-		.update_mask		= 0x0c,
-		.update_val		= 0x08,
-		.update_val_idle	= 0x0c,
-		.update_val_normal	= 0x08,
-	},
-};
-
-/* AB8540 regulator information */
-static struct ab8500_regulator_info
-		ab8540_regulator_info[AB8540_NUM_REGULATORS] = {
-	/*
-	 * Variable Voltage Regulators
-	 *   name, min mV, max mV,
-	 *   update bank, reg, mask, enable val
-	 *   volt bank, reg, mask
-	 */
-	[AB8540_LDO_AUX1] = {
-		.desc = {
-			.name		= "LDO-AUX1",
-			.ops		= &ab8500_regulator_volt_mode_ops,
-			.type		= REGULATOR_VOLTAGE,
-			.id		= AB8540_LDO_AUX1,
-			.owner		= THIS_MODULE,
-			.n_voltages	= ARRAY_SIZE(ldo_vauxn_voltages),
-			.volt_table	= ldo_vauxn_voltages,
-		},
-		.load_lp_uA		= 5000,
-		.update_bank		= 0x04,
-		.update_reg		= 0x09,
-		.update_mask		= 0x03,
-		.update_val		= 0x01,
-		.update_val_idle	= 0x03,
-		.update_val_normal	= 0x01,
-		.voltage_bank		= 0x04,
-		.voltage_reg		= 0x1f,
-		.voltage_mask		= 0x0f,
-	},
-	[AB8540_LDO_AUX2] = {
-		.desc = {
-			.name		= "LDO-AUX2",
-			.ops		= &ab8500_regulator_volt_mode_ops,
-			.type		= REGULATOR_VOLTAGE,
-			.id		= AB8540_LDO_AUX2,
-			.owner		= THIS_MODULE,
-			.n_voltages	= ARRAY_SIZE(ldo_vauxn_voltages),
-			.volt_table	= ldo_vauxn_voltages,
-		},
-		.load_lp_uA		= 5000,
-		.update_bank		= 0x04,
-		.update_reg		= 0x09,
-		.update_mask		= 0x0c,
-		.update_val		= 0x04,
-		.update_val_idle	= 0x0c,
-		.update_val_normal	= 0x04,
-		.voltage_bank		= 0x04,
-		.voltage_reg		= 0x20,
-		.voltage_mask		= 0x0f,
-	},
-	[AB8540_LDO_AUX3] = {
-		.desc = {
-			.name		= "LDO-AUX3",
-			.ops		= &ab8540_aux3_regulator_volt_mode_ops,
-			.type		= REGULATOR_VOLTAGE,
-			.id		= AB8540_LDO_AUX3,
-			.owner		= THIS_MODULE,
-			.n_voltages	= ARRAY_SIZE(ldo_vaux3_ab8540_voltages),
-			.volt_table	= ldo_vaux3_ab8540_voltages,
-		},
-		.load_lp_uA		= 5000,
-		.update_bank		= 0x04,
-		.update_reg		= 0x0a,
-		.update_mask		= 0x03,
-		.update_val		= 0x01,
-		.update_val_idle	= 0x03,
-		.update_val_normal	= 0x01,
-		.voltage_bank		= 0x04,
-		.voltage_reg		= 0x21,
-		.voltage_mask		= 0x07,
-		.expand_register = {
-			.voltage_limit		= 8,
-			.voltage_bank		= 0x04,
-			.voltage_reg		= 0x01,
-			.voltage_mask		= 0x10,
-		}
-	},
-	[AB8540_LDO_AUX4] = {
-		.desc = {
-			.name		= "LDO-AUX4",
-			.ops		= &ab8500_regulator_volt_mode_ops,
-			.type		= REGULATOR_VOLTAGE,
-			.id		= AB8540_LDO_AUX4,
-			.owner		= THIS_MODULE,
-			.n_voltages	= ARRAY_SIZE(ldo_vauxn_voltages),
-			.volt_table	= ldo_vauxn_voltages,
-		},
-		.load_lp_uA		= 5000,
-		/* values for Vaux4Regu register */
-		.update_bank		= 0x04,
-		.update_reg		= 0x2e,
-		.update_mask		= 0x03,
-		.update_val		= 0x01,
-		.update_val_idle	= 0x03,
-		.update_val_normal	= 0x01,
-		/* values for Vaux4SEL register */
-		.voltage_bank		= 0x04,
-		.voltage_reg		= 0x2f,
-		.voltage_mask		= 0x0f,
-	},
-	[AB8540_LDO_AUX5] = {
-		.desc = {
-			.name		= "LDO-AUX5",
-			.ops		= &ab8500_regulator_volt_mode_ops,
-			.type		= REGULATOR_VOLTAGE,
-			.id		= AB8540_LDO_AUX5,
-			.owner		= THIS_MODULE,
-			.n_voltages	= ARRAY_SIZE(ldo_vaux56_ab8540_voltages),
-			.volt_table	= ldo_vaux56_ab8540_voltages,
-		},
-		.load_lp_uA		= 20000,
-		/* values for Vaux5Regu register */
-		.update_bank		= 0x04,
-		.update_reg		= 0x32,
-		.update_mask		= 0x03,
-		.update_val		= 0x01,
-		.update_val_idle	= 0x03,
-		.update_val_normal	= 0x01,
-		/* values for Vaux5SEL register */
-		.voltage_bank		= 0x04,
-		.voltage_reg		= 0x33,
-		.voltage_mask		= 0x3f,
-	},
-	[AB8540_LDO_AUX6] = {
-		.desc = {
-			.name		= "LDO-AUX6",
-			.ops		= &ab8500_regulator_volt_mode_ops,
-			.type		= REGULATOR_VOLTAGE,
-			.id		= AB8540_LDO_AUX6,
-			.owner		= THIS_MODULE,
-			.n_voltages	= ARRAY_SIZE(ldo_vaux56_ab8540_voltages),
-			.volt_table	= ldo_vaux56_ab8540_voltages,
-		},
-		.load_lp_uA		= 20000,
-		/* values for Vaux6Regu register */
-		.update_bank		= 0x04,
-		.update_reg		= 0x35,
-		.update_mask		= 0x03,
-		.update_val		= 0x01,
-		.update_val_idle	= 0x03,
-		.update_val_normal	= 0x01,
-		/* values for Vaux6SEL register */
-		.voltage_bank		= 0x04,
-		.voltage_reg		= 0x36,
-		.voltage_mask		= 0x3f,
-	},
-	[AB8540_LDO_INTCORE] = {
-		.desc = {
-			.name		= "LDO-INTCORE",
-			.ops		= &ab8500_regulator_volt_mode_ops,
-			.type		= REGULATOR_VOLTAGE,
-			.id		= AB8540_LDO_INTCORE,
-			.owner		= THIS_MODULE,
-			.n_voltages	= ARRAY_SIZE(ldo_vintcore_voltages),
-			.volt_table	= ldo_vintcore_voltages,
-		},
-		.load_lp_uA		= 5000,
-		.update_bank		= 0x03,
-		.update_reg		= 0x80,
-		.update_mask		= 0x44,
-		.update_val		= 0x44,
-		.update_val_idle	= 0x44,
-		.update_val_normal	= 0x04,
-		.voltage_bank		= 0x03,
-		.voltage_reg		= 0x80,
-		.voltage_mask		= 0x38,
-	},
-
-	/*
-	 * Fixed Voltage Regulators
-	 *   name, fixed mV,
-	 *   update bank, reg, mask, enable val
-	 */
-	[AB8540_LDO_TVOUT] = {
-		.desc = {
-			.name		= "LDO-TVOUT",
-			.ops		= &ab8500_regulator_mode_ops,
-			.type		= REGULATOR_VOLTAGE,
-			.id		= AB8540_LDO_TVOUT,
-			.owner		= THIS_MODULE,
-			.n_voltages	= 1,
-			.volt_table     = fixed_2000000_voltage,
-			.enable_time	= 10000,
-		},
-		.load_lp_uA		= 1000,
-		.update_bank		= 0x03,
-		.update_reg		= 0x80,
-		.update_mask		= 0x82,
-		.update_val		= 0x02,
-		.update_val_idle	= 0x82,
-		.update_val_normal	= 0x02,
-	},
-	[AB8540_LDO_AUDIO] = {
-		.desc = {
-			.name		= "LDO-AUDIO",
-			.ops		= &ab8500_regulator_ops,
-			.type		= REGULATOR_VOLTAGE,
-			.id		= AB8540_LDO_AUDIO,
-			.owner		= THIS_MODULE,
-			.n_voltages	= 1,
-			.volt_table	= fixed_2000000_voltage,
-		},
-		.update_bank		= 0x03,
-		.update_reg		= 0x83,
-		.update_mask		= 0x02,
-		.update_val		= 0x02,
-	},
-	[AB8540_LDO_ANAMIC1] = {
-		.desc = {
-			.name		= "LDO-ANAMIC1",
-			.ops		= &ab8500_regulator_anamic_mode_ops,
-			.type		= REGULATOR_VOLTAGE,
-			.id		= AB8540_LDO_ANAMIC1,
-			.owner		= THIS_MODULE,
-			.n_voltages	= 1,
-			.volt_table	= fixed_2050000_voltage,
-		},
-		.shared_mode		= &ab8540_ldo_anamic1_shared,
-		.update_bank		= 0x03,
-		.update_reg		= 0x83,
-		.update_mask		= 0x08,
-		.update_val		= 0x08,
-		.mode_bank		= 0x03,
-		.mode_reg		= 0x83,
-		.mode_mask		= 0x20,
-		.mode_val_idle		= 0x20,
-		.mode_val_normal	= 0x00,
-	},
-	[AB8540_LDO_ANAMIC2] = {
-		.desc = {
-			.name		= "LDO-ANAMIC2",
-			.ops		= &ab8500_regulator_anamic_mode_ops,
-			.type		= REGULATOR_VOLTAGE,
-			.id		= AB8540_LDO_ANAMIC2,
-			.owner		= THIS_MODULE,
-			.n_voltages	= 1,
-			.volt_table	= fixed_2050000_voltage,
-		},
-		.shared_mode		= &ab8540_ldo_anamic2_shared,
-		.update_bank		= 0x03,
-		.update_reg		= 0x83,
-		.update_mask		= 0x10,
-		.update_val		= 0x10,
-		.mode_bank		= 0x03,
-		.mode_reg		= 0x83,
-		.mode_mask		= 0x20,
-		.mode_val_idle		= 0x20,
-		.mode_val_normal	= 0x00,
-	},
-	[AB8540_LDO_DMIC] = {
-		.desc = {
-			.name		= "LDO-DMIC",
-			.ops		= &ab8500_regulator_volt_mode_ops,
-			.type		= REGULATOR_VOLTAGE,
-			.id		= AB8540_LDO_DMIC,
-			.owner		= THIS_MODULE,
-			.n_voltages	= ARRAY_SIZE(ldo_vdmic_voltages),
-			.volt_table	= ldo_vdmic_voltages,
-		},
-		.load_lp_uA		= 1000,
-		.update_bank		= 0x03,
-		.update_reg		= 0x83,
-		.update_mask		= 0x04,
-		.update_val		= 0x04,
-		.voltage_bank		= 0x03,
-		.voltage_reg		= 0x83,
-		.voltage_mask		= 0xc0,
-	},
-
-	/*
-	 * Regulators with fixed voltage and normal/idle modes
-	 */
-	[AB8540_LDO_ANA] = {
-		.desc = {
-			.name		= "LDO-ANA",
-			.ops		= &ab8500_regulator_mode_ops,
-			.type		= REGULATOR_VOLTAGE,
-			.id		= AB8540_LDO_ANA,
-			.owner		= THIS_MODULE,
-			.n_voltages	= 1,
-			.volt_table     = fixed_1200000_voltage,
-		},
-		.load_lp_uA		= 1000,
-		.update_bank		= 0x04,
-		.update_reg		= 0x06,
-		.update_mask		= 0x0c,
-		.update_val		= 0x04,
-		.update_val_idle	= 0x0c,
-		.update_val_normal	= 0x04,
-	},
-	[AB8540_LDO_SDIO] = {
-		.desc = {
-			.name		= "LDO-SDIO",
-			.ops		= &ab8500_regulator_volt_mode_ops,
-			.type		= REGULATOR_VOLTAGE,
-			.id		= AB8540_LDO_SDIO,
-			.owner		= THIS_MODULE,
-			.n_voltages 	= ARRAY_SIZE(ldo_sdio_voltages),
-			.volt_table	= ldo_sdio_voltages,
-		},
-		.load_lp_uA		= 5000,
-		.update_bank		= 0x03,
-		.update_reg		= 0x88,
-		.update_mask		= 0x30,
-		.update_val		= 0x10,
-		.update_val_idle	= 0x30,
-		.update_val_normal	= 0x10,
-		.voltage_bank		= 0x03,
-		.voltage_reg		= 0x88,
-		.voltage_mask		= 0x07,
-	},
-};
-
-static struct ab8500_shared_mode ldo_anamic1_shared = {
-	.shared_regulator = &ab8505_regulator_info[AB8505_LDO_ANAMIC2],
-};
-
-static struct ab8500_shared_mode ldo_anamic2_shared = {
-	.shared_regulator = &ab8505_regulator_info[AB8505_LDO_ANAMIC1],
-};
-
-static struct ab8500_shared_mode ab8540_ldo_anamic1_shared = {
-	.shared_regulator = &ab8540_regulator_info[AB8540_LDO_ANAMIC2],
-};
-
-static struct ab8500_shared_mode ab8540_ldo_anamic2_shared = {
-	.shared_regulator = &ab8540_regulator_info[AB8540_LDO_ANAMIC1],
-};
-
-struct ab8500_reg_init {
-	u8 bank;
-	u8 addr;
-	u8 mask;
-};
-
-#define REG_INIT(_id, _bank, _addr, _mask)	\
-	[_id] = {				\
-		.bank = _bank,			\
-		.addr = _addr,			\
-		.mask = _mask,			\
-	}
-
-/* AB8500 register init */
-static struct ab8500_reg_init ab8500_reg_init[] = {
-	/*
-	 * 0x30, VanaRequestCtrl
-	 * 0xc0, VextSupply1RequestCtrl
-	 */
-	REG_INIT(AB8500_REGUREQUESTCTRL2,	0x03, 0x04, 0xf0),
-	/*
-	 * 0x03, VextSupply2RequestCtrl
-	 * 0x0c, VextSupply3RequestCtrl
-	 * 0x30, Vaux1RequestCtrl
-	 * 0xc0, Vaux2RequestCtrl
-	 */
-	REG_INIT(AB8500_REGUREQUESTCTRL3,	0x03, 0x05, 0xff),
-	/*
-	 * 0x03, Vaux3RequestCtrl
-	 * 0x04, SwHPReq
-	 */
-	REG_INIT(AB8500_REGUREQUESTCTRL4,	0x03, 0x06, 0x07),
-	/*
-	 * 0x08, VanaSysClkReq1HPValid
-	 * 0x20, Vaux1SysClkReq1HPValid
-	 * 0x40, Vaux2SysClkReq1HPValid
-	 * 0x80, Vaux3SysClkReq1HPValid
-	 */
-	REG_INIT(AB8500_REGUSYSCLKREQ1HPVALID1,	0x03, 0x07, 0xe8),
-	/*
-	 * 0x10, VextSupply1SysClkReq1HPValid
-	 * 0x20, VextSupply2SysClkReq1HPValid
-	 * 0x40, VextSupply3SysClkReq1HPValid
-	 */
-	REG_INIT(AB8500_REGUSYSCLKREQ1HPVALID2,	0x03, 0x08, 0x70),
-	/*
-	 * 0x08, VanaHwHPReq1Valid
-	 * 0x20, Vaux1HwHPReq1Valid
-	 * 0x40, Vaux2HwHPReq1Valid
-	 * 0x80, Vaux3HwHPReq1Valid
-	 */
-	REG_INIT(AB8500_REGUHWHPREQ1VALID1,	0x03, 0x09, 0xe8),
-	/*
-	 * 0x01, VextSupply1HwHPReq1Valid
-	 * 0x02, VextSupply2HwHPReq1Valid
-	 * 0x04, VextSupply3HwHPReq1Valid
-	 */
-	REG_INIT(AB8500_REGUHWHPREQ1VALID2,	0x03, 0x0a, 0x07),
-	/*
-	 * 0x08, VanaHwHPReq2Valid
-	 * 0x20, Vaux1HwHPReq2Valid
-	 * 0x40, Vaux2HwHPReq2Valid
-	 * 0x80, Vaux3HwHPReq2Valid
-	 */
-	REG_INIT(AB8500_REGUHWHPREQ2VALID1,	0x03, 0x0b, 0xe8),
-	/*
-	 * 0x01, VextSupply1HwHPReq2Valid
-	 * 0x02, VextSupply2HwHPReq2Valid
-	 * 0x04, VextSupply3HwHPReq2Valid
-	 */
-	REG_INIT(AB8500_REGUHWHPREQ2VALID2,	0x03, 0x0c, 0x07),
-	/*
-	 * 0x20, VanaSwHPReqValid
-	 * 0x80, Vaux1SwHPReqValid
-	 */
-	REG_INIT(AB8500_REGUSWHPREQVALID1,	0x03, 0x0d, 0xa0),
-	/*
-	 * 0x01, Vaux2SwHPReqValid
-	 * 0x02, Vaux3SwHPReqValid
-	 * 0x04, VextSupply1SwHPReqValid
-	 * 0x08, VextSupply2SwHPReqValid
-	 * 0x10, VextSupply3SwHPReqValid
-	 */
-	REG_INIT(AB8500_REGUSWHPREQVALID2,	0x03, 0x0e, 0x1f),
-	/*
-	 * 0x02, SysClkReq2Valid1
-	 * 0x04, SysClkReq3Valid1
-	 * 0x08, SysClkReq4Valid1
-	 * 0x10, SysClkReq5Valid1
-	 * 0x20, SysClkReq6Valid1
-	 * 0x40, SysClkReq7Valid1
-	 * 0x80, SysClkReq8Valid1
-	 */
-	REG_INIT(AB8500_REGUSYSCLKREQVALID1,	0x03, 0x0f, 0xfe),
-	/*
-	 * 0x02, SysClkReq2Valid2
-	 * 0x04, SysClkReq3Valid2
-	 * 0x08, SysClkReq4Valid2
-	 * 0x10, SysClkReq5Valid2
-	 * 0x20, SysClkReq6Valid2
-	 * 0x40, SysClkReq7Valid2
-	 * 0x80, SysClkReq8Valid2
-	 */
-	REG_INIT(AB8500_REGUSYSCLKREQVALID2,	0x03, 0x10, 0xfe),
-	/*
-	 * 0x02, VTVoutEna
-	 * 0x04, Vintcore12Ena
-	 * 0x38, Vintcore12Sel
-	 * 0x40, Vintcore12LP
-	 * 0x80, VTVoutLP
-	 */
-	REG_INIT(AB8500_REGUMISC1,		0x03, 0x80, 0xfe),
-	/*
-	 * 0x02, VaudioEna
-	 * 0x04, VdmicEna
-	 * 0x08, Vamic1Ena
-	 * 0x10, Vamic2Ena
-	 */
-	REG_INIT(AB8500_VAUDIOSUPPLY,		0x03, 0x83, 0x1e),
-	/*
-	 * 0x01, Vamic1_dzout
-	 * 0x02, Vamic2_dzout
-	 */
-	REG_INIT(AB8500_REGUCTRL1VAMIC,		0x03, 0x84, 0x03),
-	/*
-	 * 0x03, VpllRegu (NOTE! PRCMU register bits)
-	 * 0x0c, VanaRegu
-	 */
-	REG_INIT(AB8500_VPLLVANAREGU,		0x04, 0x06, 0x0f),
-	/*
-	 * 0x01, VrefDDREna
-	 * 0x02, VrefDDRSleepMode
-	 */
-	REG_INIT(AB8500_VREFDDR,		0x04, 0x07, 0x03),
-	/*
-	 * 0x03, VextSupply1Regu
-	 * 0x0c, VextSupply2Regu
-	 * 0x30, VextSupply3Regu
-	 * 0x40, ExtSupply2Bypass
-	 * 0x80, ExtSupply3Bypass
-	 */
-	REG_INIT(AB8500_EXTSUPPLYREGU,		0x04, 0x08, 0xff),
-	/*
-	 * 0x03, Vaux1Regu
-	 * 0x0c, Vaux2Regu
-	 */
-	REG_INIT(AB8500_VAUX12REGU,		0x04, 0x09, 0x0f),
-	/*
-	 * 0x03, Vaux3Regu
-	 */
-	REG_INIT(AB8500_VRF1VAUX3REGU,		0x04, 0x0a, 0x03),
-	/*
-	 * 0x0f, Vaux1Sel
-	 */
-	REG_INIT(AB8500_VAUX1SEL,		0x04, 0x1f, 0x0f),
-	/*
-	 * 0x0f, Vaux2Sel
-	 */
-	REG_INIT(AB8500_VAUX2SEL,		0x04, 0x20, 0x0f),
-	/*
-	 * 0x07, Vaux3Sel
-	 */
-	REG_INIT(AB8500_VRF1VAUX3SEL,		0x04, 0x21, 0x07),
-	/*
-	 * 0x01, VextSupply12LP
-	 */
-	REG_INIT(AB8500_REGUCTRL2SPARE,		0x04, 0x22, 0x01),
-	/*
-	 * 0x04, Vaux1Disch
-	 * 0x08, Vaux2Disch
-	 * 0x10, Vaux3Disch
-	 * 0x20, Vintcore12Disch
-	 * 0x40, VTVoutDisch
-	 * 0x80, VaudioDisch
-	 */
-	REG_INIT(AB8500_REGUCTRLDISCH,		0x04, 0x43, 0xfc),
-	/*
-	 * 0x02, VanaDisch
-	 * 0x04, VdmicPullDownEna
-	 * 0x10, VdmicDisch
-	 */
-	REG_INIT(AB8500_REGUCTRLDISCH2,		0x04, 0x44, 0x16),
-};
-
-/* AB8505 register init */
-static struct ab8500_reg_init ab8505_reg_init[] = {
-	/*
-	 * 0x03, VarmRequestCtrl
-	 * 0x0c, VsmpsCRequestCtrl
-	 * 0x30, VsmpsARequestCtrl
-	 * 0xc0, VsmpsBRequestCtrl
-	 */
-	REG_INIT(AB8505_REGUREQUESTCTRL1,	0x03, 0x03, 0xff),
-	/*
-	 * 0x03, VsafeRequestCtrl
-	 * 0x0c, VpllRequestCtrl
-	 * 0x30, VanaRequestCtrl
-	 */
-	REG_INIT(AB8505_REGUREQUESTCTRL2,	0x03, 0x04, 0x3f),
-	/*
-	 * 0x30, Vaux1RequestCtrl
-	 * 0xc0, Vaux2RequestCtrl
-	 */
-	REG_INIT(AB8505_REGUREQUESTCTRL3,	0x03, 0x05, 0xf0),
-	/*
-	 * 0x03, Vaux3RequestCtrl
-	 * 0x04, SwHPReq
-	 */
-	REG_INIT(AB8505_REGUREQUESTCTRL4,	0x03, 0x06, 0x07),
-	/*
-	 * 0x01, VsmpsASysClkReq1HPValid
-	 * 0x02, VsmpsBSysClkReq1HPValid
-	 * 0x04, VsafeSysClkReq1HPValid
-	 * 0x08, VanaSysClkReq1HPValid
-	 * 0x10, VpllSysClkReq1HPValid
-	 * 0x20, Vaux1SysClkReq1HPValid
-	 * 0x40, Vaux2SysClkReq1HPValid
-	 * 0x80, Vaux3SysClkReq1HPValid
-	 */
-	REG_INIT(AB8505_REGUSYSCLKREQ1HPVALID1,	0x03, 0x07, 0xff),
-	/*
-	 * 0x01, VsmpsCSysClkReq1HPValid
-	 * 0x02, VarmSysClkReq1HPValid
-	 * 0x04, VbbSysClkReq1HPValid
-	 * 0x08, VsmpsMSysClkReq1HPValid
-	 */
-	REG_INIT(AB8505_REGUSYSCLKREQ1HPVALID2,	0x03, 0x08, 0x0f),
-	/*
-	 * 0x01, VsmpsAHwHPReq1Valid
-	 * 0x02, VsmpsBHwHPReq1Valid
-	 * 0x04, VsafeHwHPReq1Valid
-	 * 0x08, VanaHwHPReq1Valid
-	 * 0x10, VpllHwHPReq1Valid
-	 * 0x20, Vaux1HwHPReq1Valid
-	 * 0x40, Vaux2HwHPReq1Valid
-	 * 0x80, Vaux3HwHPReq1Valid
-	 */
-	REG_INIT(AB8505_REGUHWHPREQ1VALID1,	0x03, 0x09, 0xff),
-	/*
-	 * 0x08, VsmpsMHwHPReq1Valid
-	 */
-	REG_INIT(AB8505_REGUHWHPREQ1VALID2,	0x03, 0x0a, 0x08),
-	/*
-	 * 0x01, VsmpsAHwHPReq2Valid
-	 * 0x02, VsmpsBHwHPReq2Valid
-	 * 0x04, VsafeHwHPReq2Valid
-	 * 0x08, VanaHwHPReq2Valid
-	 * 0x10, VpllHwHPReq2Valid
-	 * 0x20, Vaux1HwHPReq2Valid
-	 * 0x40, Vaux2HwHPReq2Valid
-	 * 0x80, Vaux3HwHPReq2Valid
-	 */
-	REG_INIT(AB8505_REGUHWHPREQ2VALID1,	0x03, 0x0b, 0xff),
-	/*
-	 * 0x08, VsmpsMHwHPReq2Valid
-	 */
-	REG_INIT(AB8505_REGUHWHPREQ2VALID2,	0x03, 0x0c, 0x08),
-	/*
-	 * 0x01, VsmpsCSwHPReqValid
-	 * 0x02, VarmSwHPReqValid
-	 * 0x04, VsmpsASwHPReqValid
-	 * 0x08, VsmpsBSwHPReqValid
-	 * 0x10, VsafeSwHPReqValid
-	 * 0x20, VanaSwHPReqValid
-	 * 0x40, VpllSwHPReqValid
-	 * 0x80, Vaux1SwHPReqValid
-	 */
-	REG_INIT(AB8505_REGUSWHPREQVALID1,	0x03, 0x0d, 0xff),
-	/*
-	 * 0x01, Vaux2SwHPReqValid
-	 * 0x02, Vaux3SwHPReqValid
-	 * 0x20, VsmpsMSwHPReqValid
-	 */
-	REG_INIT(AB8505_REGUSWHPREQVALID2,	0x03, 0x0e, 0x23),
-	/*
-	 * 0x02, SysClkReq2Valid1
-	 * 0x04, SysClkReq3Valid1
-	 * 0x08, SysClkReq4Valid1
-	 */
-	REG_INIT(AB8505_REGUSYSCLKREQVALID1,	0x03, 0x0f, 0x0e),
-	/*
-	 * 0x02, SysClkReq2Valid2
-	 * 0x04, SysClkReq3Valid2
-	 * 0x08, SysClkReq4Valid2
-	 */
-	REG_INIT(AB8505_REGUSYSCLKREQVALID2,	0x03, 0x10, 0x0e),
-	/*
-	 * 0x01, Vaux4SwHPReqValid
-	 * 0x02, Vaux4HwHPReq2Valid
-	 * 0x04, Vaux4HwHPReq1Valid
-	 * 0x08, Vaux4SysClkReq1HPValid
-	 */
-	REG_INIT(AB8505_REGUVAUX4REQVALID,	0x03, 0x11, 0x0f),
-	/*
-	 * 0x02, VadcEna
-	 * 0x04, VintCore12Ena
-	 * 0x38, VintCore12Sel
-	 * 0x40, VintCore12LP
-	 * 0x80, VadcLP
-	 */
-	REG_INIT(AB8505_REGUMISC1,		0x03, 0x80, 0xfe),
-	/*
-	 * 0x02, VaudioEna
-	 * 0x04, VdmicEna
-	 * 0x08, Vamic1Ena
-	 * 0x10, Vamic2Ena
-	 */
-	REG_INIT(AB8505_VAUDIOSUPPLY,		0x03, 0x83, 0x1e),
-	/*
-	 * 0x01, Vamic1_dzout
-	 * 0x02, Vamic2_dzout
-	 */
-	REG_INIT(AB8505_REGUCTRL1VAMIC,		0x03, 0x84, 0x03),
-	/*
-	 * 0x03, VsmpsARegu
-	 * 0x0c, VsmpsASelCtrl
-	 * 0x10, VsmpsAAutoMode
-	 * 0x20, VsmpsAPWMMode
-	 */
-	REG_INIT(AB8505_VSMPSAREGU,		0x04, 0x03, 0x3f),
-	/*
-	 * 0x03, VsmpsBRegu
-	 * 0x0c, VsmpsBSelCtrl
-	 * 0x10, VsmpsBAutoMode
-	 * 0x20, VsmpsBPWMMode
-	 */
-	REG_INIT(AB8505_VSMPSBREGU,		0x04, 0x04, 0x3f),
-	/*
-	 * 0x03, VsafeRegu
-	 * 0x0c, VsafeSelCtrl
-	 * 0x10, VsafeAutoMode
-	 * 0x20, VsafePWMMode
-	 */
-	REG_INIT(AB8505_VSAFEREGU,		0x04, 0x05, 0x3f),
-	/*
-	 * 0x03, VpllRegu (NOTE! PRCMU register bits)
-	 * 0x0c, VanaRegu
-	 */
-	REG_INIT(AB8505_VPLLVANAREGU,		0x04, 0x06, 0x0f),
-	/*
-	 * 0x03, VextSupply1Regu
-	 * 0x0c, VextSupply2Regu
-	 * 0x30, VextSupply3Regu
-	 * 0x40, ExtSupply2Bypass
-	 * 0x80, ExtSupply3Bypass
-	 */
-	REG_INIT(AB8505_EXTSUPPLYREGU,		0x04, 0x08, 0xff),
-	/*
-	 * 0x03, Vaux1Regu
-	 * 0x0c, Vaux2Regu
-	 */
-	REG_INIT(AB8505_VAUX12REGU,		0x04, 0x09, 0x0f),
-	/*
-	 * 0x0f, Vaux3Regu
-	 */
-	REG_INIT(AB8505_VRF1VAUX3REGU,		0x04, 0x0a, 0x0f),
-	/*
-	 * 0x3f, VsmpsASel1
-	 */
-	REG_INIT(AB8505_VSMPSASEL1,		0x04, 0x13, 0x3f),
-	/*
-	 * 0x3f, VsmpsASel2
-	 */
-	REG_INIT(AB8505_VSMPSASEL2,		0x04, 0x14, 0x3f),
-	/*
-	 * 0x3f, VsmpsASel3
-	 */
-	REG_INIT(AB8505_VSMPSASEL3,		0x04, 0x15, 0x3f),
-	/*
-	 * 0x3f, VsmpsBSel1
-	 */
-	REG_INIT(AB8505_VSMPSBSEL1,		0x04, 0x17, 0x3f),
-	/*
-	 * 0x3f, VsmpsBSel2
-	 */
-	REG_INIT(AB8505_VSMPSBSEL2,		0x04, 0x18, 0x3f),
-	/*
-	 * 0x3f, VsmpsBSel3
-	 */
-	REG_INIT(AB8505_VSMPSBSEL3,		0x04, 0x19, 0x3f),
-	/*
-	 * 0x7f, VsafeSel1
-	 */
-	REG_INIT(AB8505_VSAFESEL1,		0x04, 0x1b, 0x7f),
-	/*
-	 * 0x3f, VsafeSel2
-	 */
-	REG_INIT(AB8505_VSAFESEL2,		0x04, 0x1c, 0x7f),
-	/*
-	 * 0x3f, VsafeSel3
-	 */
-	REG_INIT(AB8505_VSAFESEL3,		0x04, 0x1d, 0x7f),
-	/*
-	 * 0x0f, Vaux1Sel
-	 */
-	REG_INIT(AB8505_VAUX1SEL,		0x04, 0x1f, 0x0f),
-	/*
-	 * 0x0f, Vaux2Sel
-	 */
-	REG_INIT(AB8505_VAUX2SEL,		0x04, 0x20, 0x0f),
-	/*
-	 * 0x07, Vaux3Sel
-	 * 0x30, VRF1Sel
-	 */
-	REG_INIT(AB8505_VRF1VAUX3SEL,		0x04, 0x21, 0x37),
-	/*
-	 * 0x03, Vaux4RequestCtrl
-	 */
-	REG_INIT(AB8505_VAUX4REQCTRL,		0x04, 0x2d, 0x03),
-	/*
-	 * 0x03, Vaux4Regu
-	 */
-	REG_INIT(AB8505_VAUX4REGU,		0x04, 0x2e, 0x03),
-	/*
-	 * 0x0f, Vaux4Sel
-	 */
-	REG_INIT(AB8505_VAUX4SEL,		0x04, 0x2f, 0x0f),
-	/*
-	 * 0x04, Vaux1Disch
-	 * 0x08, Vaux2Disch
-	 * 0x10, Vaux3Disch
-	 * 0x20, Vintcore12Disch
-	 * 0x40, VTVoutDisch
-	 * 0x80, VaudioDisch
-	 */
-	REG_INIT(AB8505_REGUCTRLDISCH,		0x04, 0x43, 0xfc),
-	/*
-	 * 0x02, VanaDisch
-	 * 0x04, VdmicPullDownEna
-	 * 0x10, VdmicDisch
-	 */
-	REG_INIT(AB8505_REGUCTRLDISCH2,		0x04, 0x44, 0x16),
-	/*
-	 * 0x01, Vaux4Disch
-	 */
-	REG_INIT(AB8505_REGUCTRLDISCH3,		0x04, 0x48, 0x01),
-	/*
-	 * 0x07, Vaux5Sel
-	 * 0x08, Vaux5LP
-	 * 0x10, Vaux5Ena
-	 * 0x20, Vaux5Disch
-	 * 0x40, Vaux5DisSfst
-	 * 0x80, Vaux5DisPulld
-	 */
-	REG_INIT(AB8505_CTRLVAUX5,		0x01, 0x55, 0xff),
-	/*
-	 * 0x07, Vaux6Sel
-	 * 0x08, Vaux6LP
-	 * 0x10, Vaux6Ena
-	 * 0x80, Vaux6DisPulld
-	 */
-	REG_INIT(AB8505_CTRLVAUX6,		0x01, 0x56, 0x9f),
-};
-
-/* AB9540 register init */
-static struct ab8500_reg_init ab9540_reg_init[] = {
-	/*
-	 * 0x03, VarmRequestCtrl
-	 * 0x0c, VapeRequestCtrl
-	 * 0x30, Vsmps1RequestCtrl
-	 * 0xc0, Vsmps2RequestCtrl
-	 */
-	REG_INIT(AB9540_REGUREQUESTCTRL1,	0x03, 0x03, 0xff),
-	/*
-	 * 0x03, Vsmps3RequestCtrl
-	 * 0x0c, VpllRequestCtrl
-	 * 0x30, VanaRequestCtrl
-	 * 0xc0, VextSupply1RequestCtrl
-	 */
-	REG_INIT(AB9540_REGUREQUESTCTRL2,	0x03, 0x04, 0xff),
-	/*
-	 * 0x03, VextSupply2RequestCtrl
-	 * 0x0c, VextSupply3RequestCtrl
-	 * 0x30, Vaux1RequestCtrl
-	 * 0xc0, Vaux2RequestCtrl
-	 */
-	REG_INIT(AB9540_REGUREQUESTCTRL3,	0x03, 0x05, 0xff),
+	REG_INIT(AB8500_REGUREQUESTCTRL3,	0x03, 0x05, 0xff),
 	/*
 	 * 0x03, Vaux3RequestCtrl
 	 * 0x04, SwHPReq
 	 */
-	REG_INIT(AB9540_REGUREQUESTCTRL4,	0x03, 0x06, 0x07),
+	REG_INIT(AB8500_REGUREQUESTCTRL4,	0x03, 0x06, 0x07),
 	/*
-	 * 0x01, Vsmps1SysClkReq1HPValid
-	 * 0x02, Vsmps2SysClkReq1HPValid
-	 * 0x04, Vsmps3SysClkReq1HPValid
 	 * 0x08, VanaSysClkReq1HPValid
-	 * 0x10, VpllSysClkReq1HPValid
 	 * 0x20, Vaux1SysClkReq1HPValid
 	 * 0x40, Vaux2SysClkReq1HPValid
 	 * 0x80, Vaux3SysClkReq1HPValid
 	 */
-	REG_INIT(AB9540_REGUSYSCLKREQ1HPVALID1,	0x03, 0x07, 0xff),
+	REG_INIT(AB8500_REGUSYSCLKREQ1HPVALID1,	0x03, 0x07, 0xe8),
 	/*
-	 * 0x01, VapeSysClkReq1HPValid
-	 * 0x02, VarmSysClkReq1HPValid
-	 * 0x04, VbbSysClkReq1HPValid
-	 * 0x08, VmodSysClkReq1HPValid
 	 * 0x10, VextSupply1SysClkReq1HPValid
 	 * 0x20, VextSupply2SysClkReq1HPValid
 	 * 0x40, VextSupply3SysClkReq1HPValid
 	 */
-	REG_INIT(AB9540_REGUSYSCLKREQ1HPVALID2,	0x03, 0x08, 0x7f),
+	REG_INIT(AB8500_REGUSYSCLKREQ1HPVALID2,	0x03, 0x08, 0x70),
 	/*
-	 * 0x01, Vsmps1HwHPReq1Valid
-	 * 0x02, Vsmps2HwHPReq1Valid
-	 * 0x04, Vsmps3HwHPReq1Valid
 	 * 0x08, VanaHwHPReq1Valid
-	 * 0x10, VpllHwHPReq1Valid
 	 * 0x20, Vaux1HwHPReq1Valid
 	 * 0x40, Vaux2HwHPReq1Valid
 	 * 0x80, Vaux3HwHPReq1Valid
 	 */
-	REG_INIT(AB9540_REGUHWHPREQ1VALID1,	0x03, 0x09, 0xff),
+	REG_INIT(AB8500_REGUHWHPREQ1VALID1,	0x03, 0x09, 0xe8),
 	/*
 	 * 0x01, VextSupply1HwHPReq1Valid
 	 * 0x02, VextSupply2HwHPReq1Valid
 	 * 0x04, VextSupply3HwHPReq1Valid
-	 * 0x08, VmodHwHPReq1Valid
 	 */
-	REG_INIT(AB9540_REGUHWHPREQ1VALID2,	0x03, 0x0a, 0x0f),
+	REG_INIT(AB8500_REGUHWHPREQ1VALID2,	0x03, 0x0a, 0x07),
 	/*
-	 * 0x01, Vsmps1HwHPReq2Valid
-	 * 0x02, Vsmps2HwHPReq2Valid
-	 * 0x03, Vsmps3HwHPReq2Valid
 	 * 0x08, VanaHwHPReq2Valid
-	 * 0x10, VpllHwHPReq2Valid
 	 * 0x20, Vaux1HwHPReq2Valid
 	 * 0x40, Vaux2HwHPReq2Valid
 	 * 0x80, Vaux3HwHPReq2Valid
 	 */
-	REG_INIT(AB9540_REGUHWHPREQ2VALID1,	0x03, 0x0b, 0xff),
+	REG_INIT(AB8500_REGUHWHPREQ2VALID1,	0x03, 0x0b, 0xe8),
 	/*
 	 * 0x01, VextSupply1HwHPReq2Valid
 	 * 0x02, VextSupply2HwHPReq2Valid
 	 * 0x04, VextSupply3HwHPReq2Valid
-	 * 0x08, VmodHwHPReq2Valid
 	 */
-	REG_INIT(AB9540_REGUHWHPREQ2VALID2,	0x03, 0x0c, 0x0f),
+	REG_INIT(AB8500_REGUHWHPREQ2VALID2,	0x03, 0x0c, 0x07),
 	/*
-	 * 0x01, VapeSwHPReqValid
-	 * 0x02, VarmSwHPReqValid
-	 * 0x04, Vsmps1SwHPReqValid
-	 * 0x08, Vsmps2SwHPReqValid
-	 * 0x10, Vsmps3SwHPReqValid
 	 * 0x20, VanaSwHPReqValid
-	 * 0x40, VpllSwHPReqValid
 	 * 0x80, Vaux1SwHPReqValid
 	 */
-	REG_INIT(AB9540_REGUSWHPREQVALID1,	0x03, 0x0d, 0xff),
+	REG_INIT(AB8500_REGUSWHPREQVALID1,	0x03, 0x0d, 0xa0),
 	/*
 	 * 0x01, Vaux2SwHPReqValid
 	 * 0x02, Vaux3SwHPReqValid
 	 * 0x04, VextSupply1SwHPReqValid
 	 * 0x08, VextSupply2SwHPReqValid
 	 * 0x10, VextSupply3SwHPReqValid
-	 * 0x20, VmodSwHPReqValid
 	 */
-	REG_INIT(AB9540_REGUSWHPREQVALID2,	0x03, 0x0e, 0x3f),
+	REG_INIT(AB8500_REGUSWHPREQVALID2,	0x03, 0x0e, 0x1f),
 	/*
 	 * 0x02, SysClkReq2Valid1
-	 * ...
+	 * 0x04, SysClkReq3Valid1
+	 * 0x08, SysClkReq4Valid1
+	 * 0x10, SysClkReq5Valid1
+	 * 0x20, SysClkReq6Valid1
+	 * 0x40, SysClkReq7Valid1
 	 * 0x80, SysClkReq8Valid1
 	 */
-	REG_INIT(AB9540_REGUSYSCLKREQVALID1,	0x03, 0x0f, 0xfe),
+	REG_INIT(AB8500_REGUSYSCLKREQVALID1,	0x03, 0x0f, 0xfe),
 	/*
 	 * 0x02, SysClkReq2Valid2
-	 * ...
+	 * 0x04, SysClkReq3Valid2
+	 * 0x08, SysClkReq4Valid2
+	 * 0x10, SysClkReq5Valid2
+	 * 0x20, SysClkReq6Valid2
+	 * 0x40, SysClkReq7Valid2
 	 * 0x80, SysClkReq8Valid2
 	 */
-	REG_INIT(AB9540_REGUSYSCLKREQVALID2,	0x03, 0x10, 0xfe),
-	/*
-	 * 0x01, Vaux4SwHPReqValid
-	 * 0x02, Vaux4HwHPReq2Valid
-	 * 0x04, Vaux4HwHPReq1Valid
-	 * 0x08, Vaux4SysClkReq1HPValid
-	 */
-	REG_INIT(AB9540_REGUVAUX4REQVALID,	0x03, 0x11, 0x0f),
+	REG_INIT(AB8500_REGUSYSCLKREQVALID2,	0x03, 0x10, 0xfe),
 	/*
 	 * 0x02, VTVoutEna
 	 * 0x04, Vintcore12Ena
@@ -2374,44 +1193,29 @@ static struct ab8500_reg_init ab9540_reg_init[] = {
 	 * 0x40, Vintcore12LP
 	 * 0x80, VTVoutLP
 	 */
-	REG_INIT(AB9540_REGUMISC1,		0x03, 0x80, 0xfe),
+	REG_INIT(AB8500_REGUMISC1,		0x03, 0x80, 0xfe),
 	/*
 	 * 0x02, VaudioEna
 	 * 0x04, VdmicEna
 	 * 0x08, Vamic1Ena
 	 * 0x10, Vamic2Ena
 	 */
-	REG_INIT(AB9540_VAUDIOSUPPLY,		0x03, 0x83, 0x1e),
+	REG_INIT(AB8500_VAUDIOSUPPLY,		0x03, 0x83, 0x1e),
 	/*
 	 * 0x01, Vamic1_dzout
 	 * 0x02, Vamic2_dzout
 	 */
-	REG_INIT(AB9540_REGUCTRL1VAMIC,		0x03, 0x84, 0x03),
-	/*
-	 * 0x03, Vsmps1Regu
-	 * 0x0c, Vsmps1SelCtrl
-	 * 0x10, Vsmps1AutoMode
-	 * 0x20, Vsmps1PWMMode
-	 */
-	REG_INIT(AB9540_VSMPS1REGU,		0x04, 0x03, 0x3f),
-	/*
-	 * 0x03, Vsmps2Regu
-	 * 0x0c, Vsmps2SelCtrl
-	 * 0x10, Vsmps2AutoMode
-	 * 0x20, Vsmps2PWMMode
-	 */
-	REG_INIT(AB9540_VSMPS2REGU,		0x04, 0x04, 0x3f),
+	REG_INIT(AB8500_REGUCTRL1VAMIC,		0x03, 0x84, 0x03),
 	/*
-	 * 0x03, Vsmps3Regu
-	 * 0x0c, Vsmps3SelCtrl
-	 * NOTE! PRCMU register
+	 * 0x03, VpllRegu (NOTE! PRCMU register bits)
+	 * 0x0c, VanaRegu
 	 */
-	REG_INIT(AB9540_VSMPS3REGU,		0x04, 0x05, 0x0f),
+	REG_INIT(AB8500_VPLLVANAREGU,		0x04, 0x06, 0x0f),
 	/*
-	 * 0x03, VpllRegu
-	 * 0x0c, VanaRegu
+	 * 0x01, VrefDDREna
+	 * 0x02, VrefDDRSleepMode
 	 */
-	REG_INIT(AB9540_VPLLVANAREGU,		0x04, 0x06, 0x0f),
+	REG_INIT(AB8500_VREFDDR,		0x04, 0x07, 0x03),
 	/*
 	 * 0x03, VextSupply1Regu
 	 * 0x0c, VextSupply2Regu
@@ -2419,83 +1223,33 @@ static struct ab8500_reg_init ab9540_reg_init[] = {
 	 * 0x40, ExtSupply2Bypass
 	 * 0x80, ExtSupply3Bypass
 	 */
-	REG_INIT(AB9540_EXTSUPPLYREGU,		0x04, 0x08, 0xff),
+	REG_INIT(AB8500_EXTSUPPLYREGU,		0x04, 0x08, 0xff),
 	/*
 	 * 0x03, Vaux1Regu
 	 * 0x0c, Vaux2Regu
 	 */
-	REG_INIT(AB9540_VAUX12REGU,		0x04, 0x09, 0x0f),
+	REG_INIT(AB8500_VAUX12REGU,		0x04, 0x09, 0x0f),
 	/*
-	 * 0x0c, Vrf1Regu
 	 * 0x03, Vaux3Regu
 	 */
-	REG_INIT(AB9540_VRF1VAUX3REGU,		0x04, 0x0a, 0x0f),
-	/*
-	 * 0x3f, Vsmps1Sel1
-	 */
-	REG_INIT(AB9540_VSMPS1SEL1,		0x04, 0x13, 0x3f),
-	/*
-	 * 0x3f, Vsmps1Sel2
-	 */
-	REG_INIT(AB9540_VSMPS1SEL2,		0x04, 0x14, 0x3f),
-	/*
-	 * 0x3f, Vsmps1Sel3
-	 */
-	REG_INIT(AB9540_VSMPS1SEL3,		0x04, 0x15, 0x3f),
-	/*
-	 * 0x3f, Vsmps2Sel1
-	 */
-	REG_INIT(AB9540_VSMPS2SEL1,		0x04, 0x17, 0x3f),
-	/*
-	 * 0x3f, Vsmps2Sel2
-	 */
-	REG_INIT(AB9540_VSMPS2SEL2,		0x04, 0x18, 0x3f),
-	/*
-	 * 0x3f, Vsmps2Sel3
-	 */
-	REG_INIT(AB9540_VSMPS2SEL3,		0x04, 0x19, 0x3f),
-	/*
-	 * 0x7f, Vsmps3Sel1
-	 * NOTE! PRCMU register
-	 */
-	REG_INIT(AB9540_VSMPS3SEL1,             0x04, 0x1b, 0x7f),
-	/*
-	 * 0x7f, Vsmps3Sel2
-	 * NOTE! PRCMU register
-	 */
-	REG_INIT(AB9540_VSMPS3SEL2,             0x04, 0x1c, 0x7f),
+	REG_INIT(AB8500_VRF1VAUX3REGU,		0x04, 0x0a, 0x03),
 	/*
 	 * 0x0f, Vaux1Sel
 	 */
-	REG_INIT(AB9540_VAUX1SEL,		0x04, 0x1f, 0x0f),
+	REG_INIT(AB8500_VAUX1SEL,		0x04, 0x1f, 0x0f),
 	/*
 	 * 0x0f, Vaux2Sel
 	 */
-	REG_INIT(AB9540_VAUX2SEL,		0x04, 0x20, 0x0f),
+	REG_INIT(AB8500_VAUX2SEL,		0x04, 0x20, 0x0f),
 	/*
 	 * 0x07, Vaux3Sel
-	 * 0x30, Vrf1Sel
 	 */
-	REG_INIT(AB9540_VRF1VAUX3SEL,		0x04, 0x21, 0x37),
+	REG_INIT(AB8500_VRF1VAUX3SEL,		0x04, 0x21, 0x07),
 	/*
 	 * 0x01, VextSupply12LP
 	 */
-	REG_INIT(AB9540_REGUCTRL2SPARE,		0x04, 0x22, 0x01),
-	/*
-	 * 0x03, Vaux4RequestCtrl
-	 */
-	REG_INIT(AB9540_VAUX4REQCTRL,		0x04, 0x2d, 0x03),
-	/*
-	 * 0x03, Vaux4Regu
-	 */
-	REG_INIT(AB9540_VAUX4REGU,		0x04, 0x2e, 0x03),
-	/*
-	 * 0x08, Vaux4Sel
-	 */
-	REG_INIT(AB9540_VAUX4SEL,		0x04, 0x2f, 0x0f),
+	REG_INIT(AB8500_REGUCTRL2SPARE,		0x04, 0x22, 0x01),
 	/*
-	 * 0x01, VpllDisch
-	 * 0x02, Vrf1Disch
 	 * 0x04, Vaux1Disch
 	 * 0x08, Vaux2Disch
 	 * 0x10, Vaux3Disch
@@ -2503,243 +1257,170 @@ static struct ab8500_reg_init ab9540_reg_init[] = {
 	 * 0x40, VTVoutDisch
 	 * 0x80, VaudioDisch
 	 */
-	REG_INIT(AB9540_REGUCTRLDISCH,		0x04, 0x43, 0xff),
+	REG_INIT(AB8500_REGUCTRLDISCH,		0x04, 0x43, 0xfc),
 	/*
-	 * 0x01, VsimDisch
 	 * 0x02, VanaDisch
 	 * 0x04, VdmicPullDownEna
-	 * 0x08, VpllPullDownEna
 	 * 0x10, VdmicDisch
 	 */
-	REG_INIT(AB9540_REGUCTRLDISCH2,		0x04, 0x44, 0x1f),
-	/*
-	 * 0x01, Vaux4Disch
-	 */
-	REG_INIT(AB9540_REGUCTRLDISCH3,		0x04, 0x48, 0x01),
+	REG_INIT(AB8500_REGUCTRLDISCH2,		0x04, 0x44, 0x16),
 };
 
-/* AB8540 register init */
-static struct ab8500_reg_init ab8540_reg_init[] = {
-	/*
-	 * 0x01, VSimSycClkReq1Valid
-	 * 0x02, VSimSycClkReq2Valid
-	 * 0x04, VSimSycClkReq3Valid
-	 * 0x08, VSimSycClkReq4Valid
-	 * 0x10, VSimSycClkReq5Valid
-	 * 0x20, VSimSycClkReq6Valid
-	 * 0x40, VSimSycClkReq7Valid
-	 * 0x80, VSimSycClkReq8Valid
-	 */
-	REG_INIT(AB8540_VSIMSYSCLKCTRL,		0x02, 0x33, 0xff),
+/* AB8505 register init */
+static struct ab8500_reg_init ab8505_reg_init[] = {
 	/*
 	 * 0x03, VarmRequestCtrl
-	 * 0x0c, VapeRequestCtrl
-	 * 0x30, Vsmps1RequestCtrl
-	 * 0xc0, Vsmps2RequestCtrl
+	 * 0x0c, VsmpsCRequestCtrl
+	 * 0x30, VsmpsARequestCtrl
+	 * 0xc0, VsmpsBRequestCtrl
 	 */
-	REG_INIT(AB8540_REGUREQUESTCTRL1,	0x03, 0x03, 0xff),
+	REG_INIT(AB8505_REGUREQUESTCTRL1,	0x03, 0x03, 0xff),
 	/*
-	 * 0x03, Vsmps3RequestCtrl
+	 * 0x03, VsafeRequestCtrl
 	 * 0x0c, VpllRequestCtrl
 	 * 0x30, VanaRequestCtrl
-	 * 0xc0, VextSupply1RequestCtrl
 	 */
-	REG_INIT(AB8540_REGUREQUESTCTRL2,	0x03, 0x04, 0xff),
+	REG_INIT(AB8505_REGUREQUESTCTRL2,	0x03, 0x04, 0x3f),
 	/*
-	 * 0x03, VextSupply2RequestCtrl
-	 * 0x0c, VextSupply3RequestCtrl
 	 * 0x30, Vaux1RequestCtrl
 	 * 0xc0, Vaux2RequestCtrl
 	 */
-	REG_INIT(AB8540_REGUREQUESTCTRL3,	0x03, 0x05, 0xff),
+	REG_INIT(AB8505_REGUREQUESTCTRL3,	0x03, 0x05, 0xf0),
 	/*
 	 * 0x03, Vaux3RequestCtrl
 	 * 0x04, SwHPReq
 	 */
-	REG_INIT(AB8540_REGUREQUESTCTRL4,	0x03, 0x06, 0x07),
+	REG_INIT(AB8505_REGUREQUESTCTRL4,	0x03, 0x06, 0x07),
 	/*
-	 * 0x01, Vsmps1SysClkReq1HPValid
-	 * 0x02, Vsmps2SysClkReq1HPValid
-	 * 0x04, Vsmps3SysClkReq1HPValid
+	 * 0x01, VsmpsASysClkReq1HPValid
+	 * 0x02, VsmpsBSysClkReq1HPValid
+	 * 0x04, VsafeSysClkReq1HPValid
 	 * 0x08, VanaSysClkReq1HPValid
 	 * 0x10, VpllSysClkReq1HPValid
 	 * 0x20, Vaux1SysClkReq1HPValid
 	 * 0x40, Vaux2SysClkReq1HPValid
 	 * 0x80, Vaux3SysClkReq1HPValid
 	 */
-	REG_INIT(AB8540_REGUSYSCLKREQ1HPVALID1,	0x03, 0x07, 0xff),
+	REG_INIT(AB8505_REGUSYSCLKREQ1HPVALID1,	0x03, 0x07, 0xff),
 	/*
-	 * 0x01, VapeSysClkReq1HPValid
+	 * 0x01, VsmpsCSysClkReq1HPValid
 	 * 0x02, VarmSysClkReq1HPValid
 	 * 0x04, VbbSysClkReq1HPValid
-	 * 0x10, VextSupply1SysClkReq1HPValid
-	 * 0x20, VextSupply2SysClkReq1HPValid
-	 * 0x40, VextSupply3SysClkReq1HPValid
+	 * 0x08, VsmpsMSysClkReq1HPValid
 	 */
-	REG_INIT(AB8540_REGUSYSCLKREQ1HPVALID2,	0x03, 0x08, 0x77),
+	REG_INIT(AB8505_REGUSYSCLKREQ1HPVALID2,	0x03, 0x08, 0x0f),
 	/*
-	 * 0x01, Vsmps1HwHPReq1Valid
-	 * 0x02, Vsmps2HwHPReq1Valid
-	 * 0x04, Vsmps3HwHPReq1Valid
+	 * 0x01, VsmpsAHwHPReq1Valid
+	 * 0x02, VsmpsBHwHPReq1Valid
+	 * 0x04, VsafeHwHPReq1Valid
 	 * 0x08, VanaHwHPReq1Valid
 	 * 0x10, VpllHwHPReq1Valid
 	 * 0x20, Vaux1HwHPReq1Valid
 	 * 0x40, Vaux2HwHPReq1Valid
 	 * 0x80, Vaux3HwHPReq1Valid
 	 */
-	REG_INIT(AB8540_REGUHWHPREQ1VALID1,	0x03, 0x09, 0xff),
+	REG_INIT(AB8505_REGUHWHPREQ1VALID1,	0x03, 0x09, 0xff),
 	/*
-	 * 0x01, VextSupply1HwHPReq1Valid
-	 * 0x02, VextSupply2HwHPReq1Valid
-	 * 0x04, VextSupply3HwHPReq1Valid
+	 * 0x08, VsmpsMHwHPReq1Valid
 	 */
-	REG_INIT(AB8540_REGUHWHPREQ1VALID2,	0x03, 0x0a, 0x07),
+	REG_INIT(AB8505_REGUHWHPREQ1VALID2,	0x03, 0x0a, 0x08),
 	/*
-	 * 0x01, Vsmps1HwHPReq2Valid
-	 * 0x02, Vsmps2HwHPReq2Valid
-	 * 0x03, Vsmps3HwHPReq2Valid
+	 * 0x01, VsmpsAHwHPReq2Valid
+	 * 0x02, VsmpsBHwHPReq2Valid
+	 * 0x04, VsafeHwHPReq2Valid
 	 * 0x08, VanaHwHPReq2Valid
 	 * 0x10, VpllHwHPReq2Valid
 	 * 0x20, Vaux1HwHPReq2Valid
 	 * 0x40, Vaux2HwHPReq2Valid
 	 * 0x80, Vaux3HwHPReq2Valid
 	 */
-	REG_INIT(AB8540_REGUHWHPREQ2VALID1,	0x03, 0x0b, 0xff),
+	REG_INIT(AB8505_REGUHWHPREQ2VALID1,	0x03, 0x0b, 0xff),
 	/*
-	 * 0x01, VextSupply1HwHPReq2Valid
-	 * 0x02, VextSupply2HwHPReq2Valid
-	 * 0x04, VextSupply3HwHPReq2Valid
+	 * 0x08, VsmpsMHwHPReq2Valid
 	 */
-	REG_INIT(AB8540_REGUHWHPREQ2VALID2,	0x03, 0x0c, 0x07),
+	REG_INIT(AB8505_REGUHWHPREQ2VALID2,	0x03, 0x0c, 0x08),
 	/*
-	 * 0x01, VapeSwHPReqValid
+	 * 0x01, VsmpsCSwHPReqValid
 	 * 0x02, VarmSwHPReqValid
-	 * 0x04, Vsmps1SwHPReqValid
-	 * 0x08, Vsmps2SwHPReqValid
-	 * 0x10, Vsmps3SwHPReqValid
+	 * 0x04, VsmpsASwHPReqValid
+	 * 0x08, VsmpsBSwHPReqValid
+	 * 0x10, VsafeSwHPReqValid
 	 * 0x20, VanaSwHPReqValid
 	 * 0x40, VpllSwHPReqValid
 	 * 0x80, Vaux1SwHPReqValid
 	 */
-	REG_INIT(AB8540_REGUSWHPREQVALID1,	0x03, 0x0d, 0xff),
+	REG_INIT(AB8505_REGUSWHPREQVALID1,	0x03, 0x0d, 0xff),
 	/*
 	 * 0x01, Vaux2SwHPReqValid
 	 * 0x02, Vaux3SwHPReqValid
-	 * 0x04, VextSupply1SwHPReqValid
-	 * 0x08, VextSupply2SwHPReqValid
-	 * 0x10, VextSupply3SwHPReqValid
+	 * 0x20, VsmpsMSwHPReqValid
 	 */
-	REG_INIT(AB8540_REGUSWHPREQVALID2,	0x03, 0x0e, 0x1f),
+	REG_INIT(AB8505_REGUSWHPREQVALID2,	0x03, 0x0e, 0x23),
 	/*
 	 * 0x02, SysClkReq2Valid1
-	 * ...
-	 * 0x80, SysClkReq8Valid1
+	 * 0x04, SysClkReq3Valid1
+	 * 0x08, SysClkReq4Valid1
 	 */
-	REG_INIT(AB8540_REGUSYSCLKREQVALID1,	0x03, 0x0f, 0xff),
+	REG_INIT(AB8505_REGUSYSCLKREQVALID1,	0x03, 0x0f, 0x0e),
 	/*
 	 * 0x02, SysClkReq2Valid2
-	 * ...
-	 * 0x80, SysClkReq8Valid2
+	 * 0x04, SysClkReq3Valid2
+	 * 0x08, SysClkReq4Valid2
 	 */
-	REG_INIT(AB8540_REGUSYSCLKREQVALID2,	0x03, 0x10, 0xff),
+	REG_INIT(AB8505_REGUSYSCLKREQVALID2,	0x03, 0x10, 0x0e),
 	/*
 	 * 0x01, Vaux4SwHPReqValid
 	 * 0x02, Vaux4HwHPReq2Valid
 	 * 0x04, Vaux4HwHPReq1Valid
 	 * 0x08, Vaux4SysClkReq1HPValid
 	 */
-	REG_INIT(AB8540_REGUVAUX4REQVALID,	0x03, 0x11, 0x0f),
-	/*
-	 * 0x01, Vaux5SwHPReqValid
-	 * 0x02, Vaux5HwHPReq2Valid
-	 * 0x04, Vaux5HwHPReq1Valid
-	 * 0x08, Vaux5SysClkReq1HPValid
-	 */
-	REG_INIT(AB8540_REGUVAUX5REQVALID,	0x03, 0x12, 0x0f),
-	/*
-	 * 0x01, Vaux6SwHPReqValid
-	 * 0x02, Vaux6HwHPReq2Valid
-	 * 0x04, Vaux6HwHPReq1Valid
-	 * 0x08, Vaux6SysClkReq1HPValid
-	 */
-	REG_INIT(AB8540_REGUVAUX6REQVALID,	0x03, 0x13, 0x0f),
-	/*
-	 * 0x01, VclkbSwHPReqValid
-	 * 0x02, VclkbHwHPReq2Valid
-	 * 0x04, VclkbHwHPReq1Valid
-	 * 0x08, VclkbSysClkReq1HPValid
-	 */
-	REG_INIT(AB8540_REGUVCLKBREQVALID,	0x03, 0x14, 0x0f),
-	/*
-	 * 0x01, Vrf1SwHPReqValid
-	 * 0x02, Vrf1HwHPReq2Valid
-	 * 0x04, Vrf1HwHPReq1Valid
-	 * 0x08, Vrf1SysClkReq1HPValid
-	 */
-	REG_INIT(AB8540_REGUVRF1REQVALID,	0x03, 0x15, 0x0f),
+	REG_INIT(AB8505_REGUVAUX4REQVALID,	0x03, 0x11, 0x0f),
 	/*
-	 * 0x02, VTVoutEna
-	 * 0x04, Vintcore12Ena
-	 * 0x38, Vintcore12Sel
-	 * 0x40, Vintcore12LP
-	 * 0x80, VTVoutLP
+	 * 0x02, VadcEna
+	 * 0x04, VintCore12Ena
+	 * 0x38, VintCore12Sel
+	 * 0x40, VintCore12LP
+	 * 0x80, VadcLP
 	 */
-	REG_INIT(AB8540_REGUMISC1,		0x03, 0x80, 0xfe),
+	REG_INIT(AB8505_REGUMISC1,		0x03, 0x80, 0xfe),
 	/*
 	 * 0x02, VaudioEna
 	 * 0x04, VdmicEna
 	 * 0x08, Vamic1Ena
 	 * 0x10, Vamic2Ena
-	 * 0x20, Vamic12LP
-	 * 0xC0, VdmicSel
 	 */
-	REG_INIT(AB8540_VAUDIOSUPPLY,		0x03, 0x83, 0xfe),
+	REG_INIT(AB8505_VAUDIOSUPPLY,		0x03, 0x83, 0x1e),
 	/*
 	 * 0x01, Vamic1_dzout
 	 * 0x02, Vamic2_dzout
 	 */
-	REG_INIT(AB8540_REGUCTRL1VAMIC,		0x03, 0x84, 0x03),
-	/*
-	 * 0x07, VHSICSel
-	 * 0x08, VHSICOffState
-	 * 0x10, VHSIEna
-	 * 0x20, VHSICLP
-	 */
-	REG_INIT(AB8540_VHSIC,			0x03, 0x87, 0x3f),
-	/*
-	 * 0x07, VSDIOSel
-	 * 0x08, VSDIOOffState
-	 * 0x10, VSDIOEna
-	 * 0x20, VSDIOLP
-	 */
-	REG_INIT(AB8540_VSDIO,			0x03, 0x88, 0x3f),
+	REG_INIT(AB8505_REGUCTRL1VAMIC,		0x03, 0x84, 0x03),
 	/*
-	 * 0x03, Vsmps1Regu
-	 * 0x0c, Vsmps1SelCtrl
-	 * 0x10, Vsmps1AutoMode
-	 * 0x20, Vsmps1PWMMode
+	 * 0x03, VsmpsARegu
+	 * 0x0c, VsmpsASelCtrl
+	 * 0x10, VsmpsAAutoMode
+	 * 0x20, VsmpsAPWMMode
 	 */
-	REG_INIT(AB8540_VSMPS1REGU,		0x04, 0x03, 0x3f),
+	REG_INIT(AB8505_VSMPSAREGU,		0x04, 0x03, 0x3f),
 	/*
-	 * 0x03, Vsmps2Regu
-	 * 0x0c, Vsmps2SelCtrl
-	 * 0x10, Vsmps2AutoMode
-	 * 0x20, Vsmps2PWMMode
+	 * 0x03, VsmpsBRegu
+	 * 0x0c, VsmpsBSelCtrl
+	 * 0x10, VsmpsBAutoMode
+	 * 0x20, VsmpsBPWMMode
 	 */
-	REG_INIT(AB8540_VSMPS2REGU,		0x04, 0x04, 0x3f),
+	REG_INIT(AB8505_VSMPSBREGU,		0x04, 0x04, 0x3f),
 	/*
-	 * 0x03, Vsmps3Regu
-	 * 0x0c, Vsmps3SelCtrl
-	 * 0x10, Vsmps3AutoMode
-	 * 0x20, Vsmps3PWMMode
-	 * NOTE! PRCMU register
+	 * 0x03, VsafeRegu
+	 * 0x0c, VsafeSelCtrl
+	 * 0x10, VsafeAutoMode
+	 * 0x20, VsafePWMMode
 	 */
-	REG_INIT(AB8540_VSMPS3REGU,		0x04, 0x05, 0x0f),
+	REG_INIT(AB8505_VSAFEREGU,		0x04, 0x05, 0x3f),
 	/*
-	 * 0x03, VpllRegu
+	 * 0x03, VpllRegu (NOTE! PRCMU register bits)
 	 * 0x0c, VanaRegu
 	 */
-	REG_INIT(AB8540_VPLLVANAREGU,		0x04, 0x06, 0x0f),
+	REG_INIT(AB8505_VPLLVANAREGU,		0x04, 0x06, 0x0f),
 	/*
 	 * 0x03, VextSupply1Regu
 	 * 0x0c, VextSupply2Regu
@@ -2747,128 +1428,78 @@ static struct ab8500_reg_init ab8540_reg_init[] = {
 	 * 0x40, ExtSupply2Bypass
 	 * 0x80, ExtSupply3Bypass
 	 */
-	REG_INIT(AB8540_EXTSUPPLYREGU,		0x04, 0x08, 0xff),
+	REG_INIT(AB8505_EXTSUPPLYREGU,		0x04, 0x08, 0xff),
 	/*
 	 * 0x03, Vaux1Regu
 	 * 0x0c, Vaux2Regu
 	 */
-	REG_INIT(AB8540_VAUX12REGU,		0x04, 0x09, 0x0f),
+	REG_INIT(AB8505_VAUX12REGU,		0x04, 0x09, 0x0f),
 	/*
-	 * 0x0c, VRF1Regu
-	 * 0x03, Vaux3Regu
+	 * 0x0f, Vaux3Regu
+	 */
+	REG_INIT(AB8505_VRF1VAUX3REGU,		0x04, 0x0a, 0x0f),
+	/*
+	 * 0x3f, VsmpsASel1
 	 */
-	REG_INIT(AB8540_VRF1VAUX3REGU,		0x04, 0x0a, 0x0f),
+	REG_INIT(AB8505_VSMPSASEL1,		0x04, 0x13, 0x3f),
 	/*
-	 * 0x3f, Vsmps1Sel1
+	 * 0x3f, VsmpsASel2
 	 */
-	REG_INIT(AB8540_VSMPS1SEL1,		0x04, 0x13, 0x3f),
+	REG_INIT(AB8505_VSMPSASEL2,		0x04, 0x14, 0x3f),
 	/*
-	 * 0x3f, Vsmps1Sel2
+	 * 0x3f, VsmpsASel3
 	 */
-	REG_INIT(AB8540_VSMPS1SEL2,		0x04, 0x14, 0x3f),
+	REG_INIT(AB8505_VSMPSASEL3,		0x04, 0x15, 0x3f),
 	/*
-	 * 0x3f, Vsmps1Sel3
+	 * 0x3f, VsmpsBSel1
 	 */
-	REG_INIT(AB8540_VSMPS1SEL3,		0x04, 0x15, 0x3f),
+	REG_INIT(AB8505_VSMPSBSEL1,		0x04, 0x17, 0x3f),
 	/*
-	 * 0x3f, Vsmps2Sel1
+	 * 0x3f, VsmpsBSel2
 	 */
-	REG_INIT(AB8540_VSMPS2SEL1,		0x04, 0x17, 0x3f),
+	REG_INIT(AB8505_VSMPSBSEL2,		0x04, 0x18, 0x3f),
 	/*
-	 * 0x3f, Vsmps2Sel2
+	 * 0x3f, VsmpsBSel3
 	 */
-	REG_INIT(AB8540_VSMPS2SEL2,		0x04, 0x18, 0x3f),
+	REG_INIT(AB8505_VSMPSBSEL3,		0x04, 0x19, 0x3f),
 	/*
-	 * 0x3f, Vsmps2Sel3
+	 * 0x7f, VsafeSel1
 	 */
-	REG_INIT(AB8540_VSMPS2SEL3,		0x04, 0x19, 0x3f),
+	REG_INIT(AB8505_VSAFESEL1,		0x04, 0x1b, 0x7f),
 	/*
-	 * 0x7f, Vsmps3Sel1
-	 * NOTE! PRCMU register
+	 * 0x3f, VsafeSel2
 	 */
-	REG_INIT(AB8540_VSMPS3SEL1,             0x04, 0x1b, 0x7f),
+	REG_INIT(AB8505_VSAFESEL2,		0x04, 0x1c, 0x7f),
 	/*
-	 * 0x7f, Vsmps3Sel2
-	 * NOTE! PRCMU register
+	 * 0x3f, VsafeSel3
 	 */
-	REG_INIT(AB8540_VSMPS3SEL2,             0x04, 0x1c, 0x7f),
+	REG_INIT(AB8505_VSAFESEL3,		0x04, 0x1d, 0x7f),
 	/*
 	 * 0x0f, Vaux1Sel
 	 */
-	REG_INIT(AB8540_VAUX1SEL,		0x04, 0x1f, 0x0f),
+	REG_INIT(AB8505_VAUX1SEL,		0x04, 0x1f, 0x0f),
 	/*
 	 * 0x0f, Vaux2Sel
 	 */
-	REG_INIT(AB8540_VAUX2SEL,		0x04, 0x20, 0x0f),
+	REG_INIT(AB8505_VAUX2SEL,		0x04, 0x20, 0x0f),
 	/*
 	 * 0x07, Vaux3Sel
-	 * 0x70, Vrf1Sel
-	 */
-	REG_INIT(AB8540_VRF1VAUX3SEL,		0x04, 0x21, 0x77),
-	/*
-	 * 0x01, VextSupply12LP
-	 */
-	REG_INIT(AB8540_REGUCTRL2SPARE,		0x04, 0x22, 0x01),
-	/*
-	 * 0x07, Vanasel
-	 * 0x30, Vpllsel
+	 * 0x30, VRF1Sel
 	 */
-	REG_INIT(AB8540_VANAVPLLSEL,		0x04, 0x29, 0x37),
+	REG_INIT(AB8505_VRF1VAUX3SEL,		0x04, 0x21, 0x37),
 	/*
 	 * 0x03, Vaux4RequestCtrl
 	 */
-	REG_INIT(AB8540_VAUX4REQCTRL,		0x04, 0x2d, 0x03),
+	REG_INIT(AB8505_VAUX4REQCTRL,		0x04, 0x2d, 0x03),
 	/*
 	 * 0x03, Vaux4Regu
 	 */
-	REG_INIT(AB8540_VAUX4REGU,		0x04, 0x2e, 0x03),
+	REG_INIT(AB8505_VAUX4REGU,		0x04, 0x2e, 0x03),
 	/*
 	 * 0x0f, Vaux4Sel
 	 */
-	REG_INIT(AB8540_VAUX4SEL,		0x04, 0x2f, 0x0f),
-	/*
-	 * 0x03, Vaux5RequestCtrl
-	 */
-	REG_INIT(AB8540_VAUX5REQCTRL,		0x04, 0x31, 0x03),
-	/*
-	 * 0x03, Vaux5Regu
-	 */
-	REG_INIT(AB8540_VAUX5REGU,		0x04, 0x32, 0x03),
-	/*
-	 * 0x3f, Vaux5Sel
-	 */
-	REG_INIT(AB8540_VAUX5SEL,		0x04, 0x33, 0x3f),
-	/*
-	 * 0x03, Vaux6RequestCtrl
-	 */
-	REG_INIT(AB8540_VAUX6REQCTRL,		0x04, 0x34, 0x03),
-	/*
-	 * 0x03, Vaux6Regu
-	 */
-	REG_INIT(AB8540_VAUX6REGU,		0x04, 0x35, 0x03),
-	/*
-	 * 0x3f, Vaux6Sel
-	 */
-	REG_INIT(AB8540_VAUX6SEL,		0x04, 0x36, 0x3f),
-	/*
-	 * 0x03, VCLKBRequestCtrl
-	 */
-	REG_INIT(AB8540_VCLKBREQCTRL,		0x04, 0x37, 0x03),
-	/*
-	 * 0x03, VCLKBRegu
-	 */
-	REG_INIT(AB8540_VCLKBREGU,		0x04, 0x38, 0x03),
-	/*
-	 * 0x07, VCLKBSel
-	 */
-	REG_INIT(AB8540_VCLKBSEL,		0x04, 0x39, 0x07),
-	/*
-	 * 0x03, Vrf1RequestCtrl
-	 */
-	REG_INIT(AB8540_VRF1REQCTRL,		0x04, 0x3a, 0x03),
+	REG_INIT(AB8505_VAUX4SEL,		0x04, 0x2f, 0x0f),
 	/*
-	 * 0x01, VpllDisch
-	 * 0x02, Vrf1Disch
 	 * 0x04, Vaux1Disch
 	 * 0x08, Vaux2Disch
 	 * 0x10, Vaux3Disch
@@ -2876,24 +1507,33 @@ static struct ab8500_reg_init ab8540_reg_init[] = {
 	 * 0x40, VTVoutDisch
 	 * 0x80, VaudioDisch
 	 */
-	REG_INIT(AB8540_REGUCTRLDISCH,		0x04, 0x43, 0xff),
+	REG_INIT(AB8505_REGUCTRLDISCH,		0x04, 0x43, 0xfc),
 	/*
 	 * 0x02, VanaDisch
 	 * 0x04, VdmicPullDownEna
-	 * 0x08, VpllPullDownEna
 	 * 0x10, VdmicDisch
 	 */
-	REG_INIT(AB8540_REGUCTRLDISCH2,		0x04, 0x44, 0x1e),
+	REG_INIT(AB8505_REGUCTRLDISCH2,		0x04, 0x44, 0x16),
 	/*
 	 * 0x01, Vaux4Disch
 	 */
-	REG_INIT(AB8540_REGUCTRLDISCH3,		0x04, 0x48, 0x01),
+	REG_INIT(AB8505_REGUCTRLDISCH3,		0x04, 0x48, 0x01),
+	/*
+	 * 0x07, Vaux5Sel
+	 * 0x08, Vaux5LP
+	 * 0x10, Vaux5Ena
+	 * 0x20, Vaux5Disch
+	 * 0x40, Vaux5DisSfst
+	 * 0x80, Vaux5DisPulld
+	 */
+	REG_INIT(AB8505_CTRLVAUX5,		0x01, 0x55, 0xff),
 	/*
-	 * 0x01, Vaux5Disch
-	 * 0x02, Vaux6Disch
-	 * 0x04, VCLKBDisch
+	 * 0x07, Vaux6Sel
+	 * 0x08, Vaux6LP
+	 * 0x10, Vaux6Ena
+	 * 0x80, Vaux6DisPulld
 	 */
-	REG_INIT(AB8540_REGUCTRLDISCH4,		0x04, 0x49, 0x07),
+	REG_INIT(AB8505_CTRLVAUX6,		0x01, 0x56, 0x9f),
 };
 
 static struct of_regulator_match ab8500_regulator_match[] = {
@@ -2925,37 +1565,6 @@ static struct of_regulator_match ab8505_regulator_match[] = {
 	{ .name	= "ab8500_ldo_ana",     .driver_data = (void *) AB8505_LDO_ANA, },
 };
 
-static struct of_regulator_match ab8540_regulator_match[] = {
-	{ .name	= "ab8500_ldo_aux1",    .driver_data = (void *) AB8540_LDO_AUX1, },
-	{ .name	= "ab8500_ldo_aux2",    .driver_data = (void *) AB8540_LDO_AUX2, },
-	{ .name	= "ab8500_ldo_aux3",    .driver_data = (void *) AB8540_LDO_AUX3, },
-	{ .name	= "ab8500_ldo_aux4",    .driver_data = (void *) AB8540_LDO_AUX4, },
-	{ .name	= "ab8500_ldo_aux5",    .driver_data = (void *) AB8540_LDO_AUX5, },
-	{ .name	= "ab8500_ldo_aux6",    .driver_data = (void *) AB8540_LDO_AUX6, },
-	{ .name	= "ab8500_ldo_intcore", .driver_data = (void *) AB8540_LDO_INTCORE, },
-	{ .name	= "ab8500_ldo_tvout",   .driver_data = (void *) AB8540_LDO_TVOUT, },
-	{ .name = "ab8500_ldo_audio",   .driver_data = (void *) AB8540_LDO_AUDIO, },
-	{ .name	= "ab8500_ldo_anamic1", .driver_data = (void *) AB8540_LDO_ANAMIC1, },
-	{ .name	= "ab8500_ldo_anamic2", .driver_data = (void *) AB8540_LDO_ANAMIC2, },
-	{ .name	= "ab8500_ldo_dmic",    .driver_data = (void *) AB8540_LDO_DMIC, },
-	{ .name	= "ab8500_ldo_ana",     .driver_data = (void *) AB8540_LDO_ANA, },
-	{ .name = "ab8500_ldo_sdio",    .driver_data = (void *) AB8540_LDO_SDIO, },
-};
-
-static struct of_regulator_match ab9540_regulator_match[] = {
-	{ .name	= "ab8500_ldo_aux1",    .driver_data = (void *) AB9540_LDO_AUX1, },
-	{ .name	= "ab8500_ldo_aux2",    .driver_data = (void *) AB9540_LDO_AUX2, },
-	{ .name	= "ab8500_ldo_aux3",    .driver_data = (void *) AB9540_LDO_AUX3, },
-	{ .name	= "ab8500_ldo_aux4",    .driver_data = (void *) AB9540_LDO_AUX4, },
-	{ .name	= "ab8500_ldo_intcore", .driver_data = (void *) AB9540_LDO_INTCORE, },
-	{ .name	= "ab8500_ldo_tvout",   .driver_data = (void *) AB9540_LDO_TVOUT, },
-	{ .name = "ab8500_ldo_audio",   .driver_data = (void *) AB9540_LDO_AUDIO, },
-	{ .name	= "ab8500_ldo_anamic1", .driver_data = (void *) AB9540_LDO_ANAMIC1, },
-	{ .name	= "ab8500_ldo_anamic2", .driver_data = (void *) AB9540_LDO_ANAMIC2, },
-	{ .name	= "ab8500_ldo_dmic",    .driver_data = (void *) AB9540_LDO_DMIC, },
-	{ .name	= "ab8500_ldo_ana",     .driver_data = (void *) AB9540_LDO_ANA, },
-};
-
 static struct {
 	struct ab8500_regulator_info *info;
 	int info_size;
@@ -2967,27 +1576,13 @@ static struct {
 
 static void abx500_get_regulator_info(struct ab8500 *ab8500)
 {
-	if (is_ab9540(ab8500)) {
-		abx500_regulator.info = ab9540_regulator_info;
-		abx500_regulator.info_size = ARRAY_SIZE(ab9540_regulator_info);
-		abx500_regulator.init = ab9540_reg_init;
-		abx500_regulator.init_size = AB9540_NUM_REGULATOR_REGISTERS;
-		abx500_regulator.match = ab9540_regulator_match;
-		abx500_regulator.match_size = ARRAY_SIZE(ab9540_regulator_match);
-	} else if (is_ab8505(ab8500)) {
+	if (is_ab8505(ab8500)) {
 		abx500_regulator.info = ab8505_regulator_info;
 		abx500_regulator.info_size = ARRAY_SIZE(ab8505_regulator_info);
 		abx500_regulator.init = ab8505_reg_init;
 		abx500_regulator.init_size = AB8505_NUM_REGULATOR_REGISTERS;
 		abx500_regulator.match = ab8505_regulator_match;
 		abx500_regulator.match_size = ARRAY_SIZE(ab8505_regulator_match);
-	} else if (is_ab8540(ab8500)) {
-		abx500_regulator.info = ab8540_regulator_info;
-		abx500_regulator.info_size = ARRAY_SIZE(ab8540_regulator_info);
-		abx500_regulator.init = ab8540_reg_init;
-		abx500_regulator.init_size = AB8540_NUM_REGULATOR_REGISTERS;
-		abx500_regulator.match = ab8540_regulator_match;
-		abx500_regulator.match_size = ARRAY_SIZE(ab8540_regulator_match);
 	} else {
 		abx500_regulator.info = ab8500_regulator_info;
 		abx500_regulator.info_size = ARRAY_SIZE(ab8500_regulator_info);
diff --git a/include/linux/regulator/ab8500.h b/include/linux/regulator/ab8500.h
index d8ecefaf63ca..6d46f962685d 100644
--- a/include/linux/regulator/ab8500.h
+++ b/include/linux/regulator/ab8500.h
@@ -49,47 +49,7 @@ enum ab8505_regulator_id {
 	AB8505_NUM_REGULATORS,
 };
 
-/* AB9540 regulators */
-enum ab9540_regulator_id {
-	AB9540_LDO_AUX1,
-	AB9540_LDO_AUX2,
-	AB9540_LDO_AUX3,
-	AB9540_LDO_AUX4,
-	AB9540_LDO_INTCORE,
-	AB9540_LDO_TVOUT,
-	AB9540_LDO_USB,
-	AB9540_LDO_AUDIO,
-	AB9540_LDO_ANAMIC1,
-	AB9540_LDO_ANAMIC2,
-	AB9540_LDO_DMIC,
-	AB9540_LDO_ANA,
-	AB9540_SYSCLKREQ_2,
-	AB9540_SYSCLKREQ_4,
-	AB9540_NUM_REGULATORS,
-};
-
-/* AB8540 regulators */
-enum ab8540_regulator_id {
-	AB8540_LDO_AUX1,
-	AB8540_LDO_AUX2,
-	AB8540_LDO_AUX3,
-	AB8540_LDO_AUX4,
-	AB8540_LDO_AUX5,
-	AB8540_LDO_AUX6,
-	AB8540_LDO_INTCORE,
-	AB8540_LDO_TVOUT,
-	AB8540_LDO_AUDIO,
-	AB8540_LDO_ANAMIC1,
-	AB8540_LDO_ANAMIC2,
-	AB8540_LDO_DMIC,
-	AB8540_LDO_ANA,
-	AB8540_LDO_SDIO,
-	AB8540_SYSCLKREQ_2,
-	AB8540_SYSCLKREQ_4,
-	AB8540_NUM_REGULATORS,
-};
-
-/* AB8500, AB8505, and AB9540 register initialization */
+/* AB8500 and AB8505 register initialization */
 struct ab8500_regulator_reg_init {
 	int id;
 	u8 mask;
@@ -185,121 +145,6 @@ enum ab8505_regulator_reg {
 	AB8505_NUM_REGULATOR_REGISTERS,
 };
 
-/* AB9540 registers */
-enum ab9540_regulator_reg {
-	AB9540_REGUREQUESTCTRL1,
-	AB9540_REGUREQUESTCTRL2,
-	AB9540_REGUREQUESTCTRL3,
-	AB9540_REGUREQUESTCTRL4,
-	AB9540_REGUSYSCLKREQ1HPVALID1,
-	AB9540_REGUSYSCLKREQ1HPVALID2,
-	AB9540_REGUHWHPREQ1VALID1,
-	AB9540_REGUHWHPREQ1VALID2,
-	AB9540_REGUHWHPREQ2VALID1,
-	AB9540_REGUHWHPREQ2VALID2,
-	AB9540_REGUSWHPREQVALID1,
-	AB9540_REGUSWHPREQVALID2,
-	AB9540_REGUSYSCLKREQVALID1,
-	AB9540_REGUSYSCLKREQVALID2,
-	AB9540_REGUVAUX4REQVALID,
-	AB9540_REGUMISC1,
-	AB9540_VAUDIOSUPPLY,
-	AB9540_REGUCTRL1VAMIC,
-	AB9540_VSMPS1REGU,
-	AB9540_VSMPS2REGU,
-	AB9540_VSMPS3REGU, /* NOTE! PRCMU register */
-	AB9540_VPLLVANAREGU,
-	AB9540_EXTSUPPLYREGU,
-	AB9540_VAUX12REGU,
-	AB9540_VRF1VAUX3REGU,
-	AB9540_VSMPS1SEL1,
-	AB9540_VSMPS1SEL2,
-	AB9540_VSMPS1SEL3,
-	AB9540_VSMPS2SEL1,
-	AB9540_VSMPS2SEL2,
-	AB9540_VSMPS2SEL3,
-	AB9540_VSMPS3SEL1, /* NOTE! PRCMU register */
-	AB9540_VSMPS3SEL2, /* NOTE! PRCMU register */
-	AB9540_VAUX1SEL,
-	AB9540_VAUX2SEL,
-	AB9540_VRF1VAUX3SEL,
-	AB9540_REGUCTRL2SPARE,
-	AB9540_VAUX4REQCTRL,
-	AB9540_VAUX4REGU,
-	AB9540_VAUX4SEL,
-	AB9540_REGUCTRLDISCH,
-	AB9540_REGUCTRLDISCH2,
-	AB9540_REGUCTRLDISCH3,
-	AB9540_NUM_REGULATOR_REGISTERS,
-};
-
-/* AB8540 registers */
-enum ab8540_regulator_reg {
-	AB8540_REGUREQUESTCTRL1,
-	AB8540_REGUREQUESTCTRL2,
-	AB8540_REGUREQUESTCTRL3,
-	AB8540_REGUREQUESTCTRL4,
-	AB8540_REGUSYSCLKREQ1HPVALID1,
-	AB8540_REGUSYSCLKREQ1HPVALID2,
-	AB8540_REGUHWHPREQ1VALID1,
-	AB8540_REGUHWHPREQ1VALID2,
-	AB8540_REGUHWHPREQ2VALID1,
-	AB8540_REGUHWHPREQ2VALID2,
-	AB8540_REGUSWHPREQVALID1,
-	AB8540_REGUSWHPREQVALID2,
-	AB8540_REGUSYSCLKREQVALID1,
-	AB8540_REGUSYSCLKREQVALID2,
-	AB8540_REGUVAUX4REQVALID,
-	AB8540_REGUVAUX5REQVALID,
-	AB8540_REGUVAUX6REQVALID,
-	AB8540_REGUVCLKBREQVALID,
-	AB8540_REGUVRF1REQVALID,
-	AB8540_REGUMISC1,
-	AB8540_VAUDIOSUPPLY,
-	AB8540_REGUCTRL1VAMIC,
-	AB8540_VHSIC,
-	AB8540_VSDIO,
-	AB8540_VSMPS1REGU,
-	AB8540_VSMPS2REGU,
-	AB8540_VSMPS3REGU,
-	AB8540_VPLLVANAREGU,
-	AB8540_EXTSUPPLYREGU,
-	AB8540_VAUX12REGU,
-	AB8540_VRF1VAUX3REGU,
-	AB8540_VSMPS1SEL1,
-	AB8540_VSMPS1SEL2,
-	AB8540_VSMPS1SEL3,
-	AB8540_VSMPS2SEL1,
-	AB8540_VSMPS2SEL2,
-	AB8540_VSMPS2SEL3,
-	AB8540_VSMPS3SEL1,
-	AB8540_VSMPS3SEL2,
-	AB8540_VAUX1SEL,
-	AB8540_VAUX2SEL,
-	AB8540_VRF1VAUX3SEL,
-	AB8540_REGUCTRL2SPARE,
-	AB8540_VAUX4REQCTRL,
-	AB8540_VAUX4REGU,
-	AB8540_VAUX4SEL,
-	AB8540_VAUX5REQCTRL,
-	AB8540_VAUX5REGU,
-	AB8540_VAUX5SEL,
-	AB8540_VAUX6REQCTRL,
-	AB8540_VAUX6REGU,
-	AB8540_VAUX6SEL,
-	AB8540_VCLKBREQCTRL,
-	AB8540_VCLKBREGU,
-	AB8540_VCLKBSEL,
-	AB8540_VRF1REQCTRL,
-	AB8540_REGUCTRLDISCH,
-	AB8540_REGUCTRLDISCH2,
-	AB8540_REGUCTRLDISCH3,
-	AB8540_REGUCTRLDISCH4,
-	AB8540_VSIMSYSCLKCTRL,
-	AB8540_VANAVPLLSEL,
-	AB8540_NUM_REGULATOR_REGISTERS,
-};
-
 /* AB8500 external regulators */
 struct ab8500_ext_regulator_cfg {
 	bool hwreq; /* requires hw mode or high power mode */
-- 
2.17.0
