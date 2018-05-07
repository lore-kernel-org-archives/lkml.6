Return-Path: <vadimp@mellanox.com>
X-Google-Smtp-Source: AB8JxZpX0QGPHiTLXlCn2pkPVqyjHc1mwAH4mopURH8aYhgU1TARKZ3+m/KGQV6AQhp2ozCN1rUN
ARC-Seal: i=1; a=rsa-sha256; t=1525668788; cv=none;
        d=google.com; s=arc-20160816;
        b=XLHCh5gG8qVazBMTfP+1flznI/2kN7eWdxa9F9iRzvc7eGVbptYArAFVILTqN7MBss
         wOy9hJy+gzC+bO8fUQOrW/VoA7WbHauoE/V7wuwypfcx8v3fW18xmUaJp0EtZmNHRBTM
         jcdJL//l4nX6aCOGUivsvPTcX5Ll+evuOkrvZk0AbhgXbQi4VwANIEM2DNuyaDLJauB5
         etVLtdEim/QCalXs2iP9G3hZSkiFn2FFO4BHioLACLs1gVg5brxnb0J4ltClju0Yh45T
         FcwftnzQMh8Qm3WqnlhDH8GZT5J5XPheOBnHJR791uCGyu5+OaaLpTod5kYEelRmnxoA
         TA7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=ar1A+r3PrbOhV8rzCB6+hmKFmEl4xlxHruiCZ6MU/P8=;
        b=B2K8PyWWnSSPUL52MmQaw96WUAfO5L+MDHqbT7jEiS6bjKa8Cux3NYhi4P0v6XWqxH
         EMKx8k3Ekl+V++RwKphSz9gDI3nhH7s2m4ad4WVHkUP7PhNS8Eat7DOTjYDe7wVmJTsn
         5OuOYFYgwWJ2+1y2NzLJI9RNKuGHSfx/M9CMU/Mxc2uELcpFkWZCNkxxsOptdxlxd6ZP
         XL3Dn6Igk9WZCpv1HLJOIS7QyD3OAOLiE6LTMCRuNl7vvgHLkPljPOR44cnxFXWjZKoq
         m+eILL7dosWN0kgxwX3iazp2Bug5stMH6pHNI6yEQFO4zc96SYTHdJPFewLVapRmqK54
         SstA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 193.47.165.129 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 193.47.165.129 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
From: Vadim Pasternak <vadimp@mellanox.com>
To: dvhart@infradead.org, andy.shevchenko@gmail.com,
        gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        jiri@resnulli.us, michaelsh@mellanox.com, ivecera@redhat.com,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH v2 7/7] platform/x86: mlx-platform: Add mlxreg-io platform driver activation
Date: Mon,  7 May 2018 06:48:55 +0000
Message-Id: <1525675735-125547-5-git-send-email-vadimp@mellanox.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1525675735-125547-1-git-send-email-vadimp@mellanox.com>
References: <1525675735-125547-1-git-send-email-vadimp@mellanox.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599779675617299623?=
X-GMAIL-MSGID: =?utf-8?q?1599779675617299623?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add mlxreg-io platform driver activation. Access driver uses the same
regmap infrastructure as others Mellanox platform drivers.
Specific registers description for default platform data configuration are
added to mlx-platform. There are the registers for resets control, reset
causes monitoring, programmable devices version reading and mux select
control. This platform data is passed to mlxreg-io driver. Also some
default values for the register are set at initialization time through
the regmap infrastructure, which are necessary for moving write protection
from the general purpose registers, which are used by mlxreg-io for
write access.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
 drivers/platform/x86/mlx-platform.c | 159 +++++++++++++++++++++++++++++++++++-
 1 file changed, 157 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/mlx-platform.c
index a0fd9aa..87ddd3a 100644
--- a/drivers/platform/x86/mlx-platform.c
+++ b/drivers/platform/x86/mlx-platform.c
@@ -47,11 +47,18 @@
 /* LPC bus IO offsets */
 #define MLXPLAT_CPLD_LPC_I2C_BASE_ADRR		0x2000
 #define MLXPLAT_CPLD_LPC_REG_BASE_ADRR		0x2500
+#define MLXPLAT_CPLD_LPC_REG_CPLD1_VER_OFFSET	0x00
+#define MLXPLAT_CPLD_LPC_REG_CPLD2_VER_OFFSET	0x01
+#define MLXPLAT_CPLD_LPC_REG_RESET_CAUSE_OFFSET	0x1d
 #define MLXPLAT_CPLD_LPC_REG_LED1_OFFSET	0x20
 #define MLXPLAT_CPLD_LPC_REG_LED2_OFFSET	0x21
 #define MLXPLAT_CPLD_LPC_REG_LED3_OFFSET	0x22
 #define MLXPLAT_CPLD_LPC_REG_LED4_OFFSET	0x23
 #define MLXPLAT_CPLD_LPC_REG_LED5_OFFSET	0x24
+#define MLXPLAT_CPLD_LPC_REG_GP1_OFFSET		0x30
+#define MLXPLAT_CPLD_LPC_REG_WP1_OFFSET		0x31
+#define MLXPLAT_CPLD_LPC_REG_GP2_OFFSET		0x32
+#define MLXPLAT_CPLD_LPC_REG_WP2_OFFSET		0x33
 #define MLXPLAT_CPLD_LPC_REG_AGGR_OFFSET	0x3a
 #define MLXPLAT_CPLD_LPC_REG_AGGR_MASK_OFFSET	0x3b
 #define MLXPLAT_CPLD_LPC_REG_AGGRLO_OFFSET	0x40
@@ -122,12 +129,14 @@
  * @pdev_mux - array of mux platform devices
  * @pdev_hotplug - hotplug platform devices
  * @pdev_led - led platform devices
+ * @pdev_io_regs - register access platform devices
  */
 struct mlxplat_priv {
 	struct platform_device *pdev_i2c;
 	struct platform_device *pdev_mux[MLXPLAT_CPLD_LPC_MUX_DEVS];
 	struct platform_device *pdev_hotplug;
 	struct platform_device *pdev_led;
+	struct platform_device *pdev_io_regs;
 };
 
 /* Regions for LPC I2C controller and LPC base register space */
@@ -813,6 +822,98 @@ static struct mlxreg_core_platform_data mlxplat_default_ng_led_data = {
 		.counter = ARRAY_SIZE(mlxplat_mlxcpld_default_ng_led_data),
 };
 
+/* Platform register access default */
+static struct mlxreg_core_data mlxplat_mlxcpld_default_regs_io_data[] = {
+	{
+		.label = "cpld1_version",
+		.reg = MLXPLAT_CPLD_LPC_REG_CPLD1_VER_OFFSET,
+		.bit = GENMASK(7, 0),
+		.mode = 0444,
+	},
+	{
+		.label = "cpld2_version",
+		.reg = MLXPLAT_CPLD_LPC_REG_CPLD2_VER_OFFSET,
+		.bit = GENMASK(7, 0),
+		.mode = 0444,
+	},
+	{
+		.label = "cause_long_pb",
+		.reg = MLXPLAT_CPLD_LPC_REG_RESET_CAUSE_OFFSET,
+		.mask = GENMASK(7, 0) & ~BIT(0),
+		.mode = 0444,
+	},
+	{
+		.label = "cause_short_pb",
+		.reg = MLXPLAT_CPLD_LPC_REG_RESET_CAUSE_OFFSET,
+		.mask = GENMASK(7, 0) & ~BIT(1),
+		.mode = 0444,
+	},
+	{
+		.label = "cause_aux_pwr_or_ref",
+		.reg = MLXPLAT_CPLD_LPC_REG_RESET_CAUSE_OFFSET,
+		.mask = GENMASK(7, 0) & ~BIT(2),
+		.mode = 0444,
+	},
+	{
+		.label = "cause_main_pwr_fail",
+		.reg = MLXPLAT_CPLD_LPC_REG_RESET_CAUSE_OFFSET,
+		.mask = GENMASK(7, 0) & ~BIT(3),
+		.mode = 0444,
+	},
+	{
+		.label = "cause_sw_reset",
+		.reg = MLXPLAT_CPLD_LPC_REG_RESET_CAUSE_OFFSET,
+		.mask = GENMASK(7, 0) & ~BIT(4),
+		.mode = 0444,
+	},
+	{
+		.label = "cause_fw_reset",
+		.reg = MLXPLAT_CPLD_LPC_REG_RESET_CAUSE_OFFSET,
+		.mask = GENMASK(7, 0) & ~BIT(5),
+		.mode = 0444,
+	},
+	{
+		.label = "cause_hotswap_or_wd",
+		.reg = MLXPLAT_CPLD_LPC_REG_RESET_CAUSE_OFFSET,
+		.mask = GENMASK(7, 0) & ~BIT(6),
+		.mode = 0444,
+	},
+	{
+		.label = "cause_asic_thermal",
+		.reg = MLXPLAT_CPLD_LPC_REG_RESET_CAUSE_OFFSET,
+		.mask = GENMASK(7, 0) & ~BIT(7),
+		.mode = 0444,
+	},
+	{
+		.label = "psu1_on",
+		.reg = MLXPLAT_CPLD_LPC_REG_GP1_OFFSET,
+		.mask = GENMASK(7, 0) & ~BIT(0),
+		.mode = 0200,
+	},
+	{
+		.label = "psu2_on",
+		.reg = MLXPLAT_CPLD_LPC_REG_GP1_OFFSET,
+		.mask = GENMASK(7, 0) & ~BIT(1),
+		.mode = 0200,
+	},
+	{
+		.label = "pwr_cycle",
+		.reg = MLXPLAT_CPLD_LPC_REG_GP1_OFFSET,
+		.mask = GENMASK(7, 0) & ~BIT(2),
+		.mode = 0200,
+	},
+	{
+		.label = "select_iio",
+		.reg = MLXPLAT_CPLD_LPC_REG_GP2_OFFSET,
+		.mask = GENMASK(7, 0) & ~BIT(6),
+		.mode = 0644,
+	},
+};
+
+static struct mlxreg_core_platform_data mlxplat_default_regs_io_data = {
+		.data = mlxplat_mlxcpld_default_regs_io_data,
+		.counter = ARRAY_SIZE(mlxplat_mlxcpld_default_regs_io_data),
+};
 
 static bool mlxplat_mlxcpld_writeable_reg(struct device *dev, unsigned int reg)
 {
@@ -822,6 +923,10 @@ static bool mlxplat_mlxcpld_writeable_reg(struct device *dev, unsigned int reg)
 	case MLXPLAT_CPLD_LPC_REG_LED3_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_LED4_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_LED5_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_GP1_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_WP1_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_GP2_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_WP2_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_AGGR_MASK_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_AGGRLO_MASK_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_PSU_EVENT_OFFSET:
@@ -838,11 +943,18 @@ static bool mlxplat_mlxcpld_writeable_reg(struct device *dev, unsigned int reg)
 static bool mlxplat_mlxcpld_readable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case MLXPLAT_CPLD_LPC_REG_CPLD1_VER_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_CPLD2_VER_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_RESET_CAUSE_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_LED1_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_LED2_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_LED3_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_LED4_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_LED5_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_GP1_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_WP1_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_GP2_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_WP2_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_AGGR_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_AGGR_MASK_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_AGGRLO_OFFSET:
@@ -864,11 +976,16 @@ static bool mlxplat_mlxcpld_readable_reg(struct device *dev, unsigned int reg)
 static bool mlxplat_mlxcpld_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case MLXPLAT_CPLD_LPC_REG_CPLD1_VER_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_CPLD2_VER_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_RESET_CAUSE_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_LED1_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_LED2_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_LED3_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_LED4_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_LED5_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_GP1_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_GP2_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_AGGR_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_AGGR_MASK_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_AGGRLO_OFFSET:
@@ -887,6 +1004,11 @@ static bool mlxplat_mlxcpld_volatile_reg(struct device *dev, unsigned int reg)
 	return false;
 }
 
+static const struct reg_default mlxplat_mlxcpld_regmap_default[] = {
+	{ MLXPLAT_CPLD_LPC_REG_WP1_OFFSET, 0x00 },
+	{ MLXPLAT_CPLD_LPC_REG_WP2_OFFSET, 0x00 },
+};
+
 struct mlxplat_mlxcpld_regmap_context {
 	void __iomem *base;
 };
@@ -919,6 +1041,8 @@ static const struct regmap_config mlxplat_mlxcpld_regmap_config = {
 	.writeable_reg = mlxplat_mlxcpld_writeable_reg,
 	.readable_reg = mlxplat_mlxcpld_readable_reg,
 	.volatile_reg = mlxplat_mlxcpld_volatile_reg,
+	.reg_defaults = mlxplat_mlxcpld_regmap_default,
+	.num_reg_defaults = ARRAY_SIZE(mlxplat_mlxcpld_regmap_default),
 	.reg_read = mlxplat_mlxcpld_reg_read,
 	.reg_write = mlxplat_mlxcpld_reg_write,
 };
@@ -930,6 +1054,7 @@ static struct resource mlxplat_mlxcpld_resources[] = {
 static struct platform_device *mlxplat_dev;
 static struct mlxreg_core_hotplug_platform_data *mlxplat_hotplug;
 static struct mlxreg_core_platform_data *mlxplat_led;
+static struct mlxreg_core_platform_data *mlxplat_regs_io;
 
 static int __init mlxplat_dmi_default_matched(const struct dmi_system_id *dmi)
 {
@@ -944,6 +1069,7 @@ static int __init mlxplat_dmi_default_matched(const struct dmi_system_id *dmi)
 	mlxplat_hotplug->deferred_nr =
 		mlxplat_default_channels[i - 1][MLXPLAT_CPLD_GRP_CHNL_NUM - 1];
 	mlxplat_led = &mlxplat_default_led_data;
+	mlxplat_regs_io = &mlxplat_default_regs_io_data;
 
 	return 1;
 };
@@ -978,6 +1104,7 @@ static int __init mlxplat_dmi_msn274x_matched(const struct dmi_system_id *dmi)
 	mlxplat_hotplug->deferred_nr =
 		mlxplat_msn21xx_channels[MLXPLAT_CPLD_GRP_CHNL_NUM - 1];
 	mlxplat_led = &mlxplat_default_led_data;
+	mlxplat_regs_io = &mlxplat_default_regs_io_data;
 
 	return 1;
 };
@@ -1163,7 +1290,7 @@ static int mlxplat_mlxcpld_verify_bus_topology(int *nr)
 static int __init mlxplat_init(void)
 {
 	struct mlxplat_priv *priv;
-	int i, nr, err;
+	int i, j, nr, err;
 
 	if (!dmi_check_system(mlxplat_dmi_table))
 		return -ENODEV;
@@ -1233,6 +1360,15 @@ static int __init mlxplat_init(void)
 		goto fail_platform_mux_register;
 	}
 
+	/* Set default registers. */
+	for (j = 0; j <  mlxplat_mlxcpld_regmap_config.num_reg_defaults; j++) {
+		err = regmap_write(mlxplat_hotplug->regmap,
+				   mlxplat_mlxcpld_regmap_default[j].reg,
+				   mlxplat_mlxcpld_regmap_default[j].def);
+		if (err)
+			goto fail_platform_mux_register;
+	}
+
 	/* Add LED driver. */
 	mlxplat_led->regmap = mlxplat_hotplug->regmap;
 	priv->pdev_led = platform_device_register_resndata(
@@ -1244,14 +1380,31 @@ static int __init mlxplat_init(void)
 		goto fail_platform_hotplug_register;
 	}
 
+	/* Add registers io access driver. */
+	if (mlxplat_regs_io) {
+		mlxplat_regs_io->regmap = mlxplat_hotplug->regmap;
+		priv->pdev_io_regs = platform_device_register_resndata(
+					&mlxplat_dev->dev, "mlxreg-io",
+					PLATFORM_DEVID_NONE, NULL, 0,
+					mlxplat_regs_io,
+					sizeof(*mlxplat_regs_io));
+		if (IS_ERR(priv->pdev_io_regs)) {
+			err = PTR_ERR(priv->pdev_io_regs);
+			goto fail_platform_led_register;
+		}
+	}
+
 	/* Sync registers with hardware. */
 	regcache_mark_dirty(mlxplat_hotplug->regmap);
 	err = regcache_sync(mlxplat_hotplug->regmap);
 	if (err)
-		goto fail_platform_led_register;
+		goto fail_platform_io_regs_register;
 
 	return 0;
 
+fail_platform_io_regs_register:
+	if (mlxplat_regs_io)
+		platform_device_unregister(priv->pdev_io_regs);
 fail_platform_led_register:
 	platform_device_unregister(priv->pdev_led);
 fail_platform_hotplug_register:
@@ -1272,6 +1425,8 @@ static void __exit mlxplat_exit(void)
 	struct mlxplat_priv *priv = platform_get_drvdata(mlxplat_dev);
 	int i;
 
+	if (priv->pdev_io_regs)
+		platform_device_unregister(priv->pdev_io_regs);
 	platform_device_unregister(priv->pdev_led);
 	platform_device_unregister(priv->pdev_hotplug);
 
-- 
2.1.4
