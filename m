Return-Path: <vadimp@mellanox.com>
X-Google-Smtp-Source: AG47ELsvrBbTOWB3fEY2b68xFHnwPL52eGi+axLodfltBO446XxHZcl6aIOvghe4UR5JmDTJC2ya
ARC-Seal: i=1; a=rsa-sha256; t=1522137957; cv=none;
        d=google.com; s=arc-20160816;
        b=UNNHMzpEV39o3q9JZ2XiU8IUxZAIOstGhxjsGXO8eTaHNgxpnBd6b+Ws0UaXpObWso
         V1OkiTCm7o0eZw2LswXOC/9XYhoohO/aHJaWwDHDoDR/+Q7aesFPv4AN64I3bvnCZ5Zh
         lxloXqDYZ1/oONxD4gWBd6pmROu1/iMLKh1ZKO3pp04GdLx/gJ0vPFNqCTE5Zk6vAODN
         o8bJJUd9d54gbY9T/uaicxGk5zY1iNarpjkjxI1+Y8NbzmoRfn3Wk80cK0NFRhoj+jPI
         2tJLQzbjrWI+HpTP8C6bAhbN8x0VEqCzWUR6b5eUMkVMoCpCS1md1RxXMICLHMs9Z43n
         gpFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=cigELpq8MZtyzpePMTmnO9jxo47BfTrHMRpEVRaYPI8=;
        b=aIm88vKa1CbKvrNEuIbxS2SFOkT4c+hPrADs+ifZdB5WcLINdGsap1DsRipmZ0VQZ5
         jMQfZPI/n2HXkWeTSr+tsXtKtG2vobYx9iV9Zj5B8PxZ2GnXnACBOAj3SvGQ/OeDqR2D
         42ZyRxHfx0yln3qKUEDxxfTMJtjIbfem6GWzaB33A5yd9MFxrPpAr4JstFsabHV2oQQw
         m2jXEREK+KNPAPQ7ONsHw6BKdwKjqn/Vjh7iMuNMTZ3mkQ+zzxTI+nycnc8euehnw5y3
         VytFL7YIqM3Z1qfxl5g88LNHw8vC9kk/vyaoIydmA7ycx7l2ERnN2ZhOqU/UuNMMSfEX
         YmoQ==
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
Subject: [PATCH v1 5/7] platform/x86: mlx-platform: Add LED platform driver activation
Date: Tue, 27 Mar 2018 10:02:05 +0000
Message-Id: <1522144927-56512-6-git-send-email-vadimp@mellanox.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1522144927-56512-1-git-send-email-vadimp@mellanox.com>
References: <1522144927-56512-1-git-send-email-vadimp@mellanox.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596077330577207418?=
X-GMAIL-MSGID: =?utf-8?q?1596077330577207418?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds:
- Support of Mellanox LED driver leds-mlxreg activation from mlx-platform.
  This LED driver uses the same regmap infrastructure as others Mellanox
  platform drivers.
- LED specific registers description.
- Per system type LED description, which is passed to LED driver.
- Static inline functions for adding and removing platform drivers sharing
  the same regmap infrastructure.
  Motivation of adding them as a static inline to the header file is to
  allow reusing of them by not only x86 architecture specific platform
  driver.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
 drivers/platform/x86/mlx-platform.c  | 290 +++++++++++++++++++++++++++++++++++
 include/linux/platform_data/mlxreg.h |  63 ++++++++
 2 files changed, 353 insertions(+)

diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/mlx-platform.c
index 912f844..efb605a 100644
--- a/drivers/platform/x86/mlx-platform.c
+++ b/drivers/platform/x86/mlx-platform.c
@@ -47,6 +47,11 @@
 /* LPC bus IO offsets */
 #define MLXPLAT_CPLD_LPC_I2C_BASE_ADRR		0x2000
 #define MLXPLAT_CPLD_LPC_REG_BASE_ADRR		0x2500
+#define MLXPLAT_CPLD_LPC_REG_LED1_OFFSET	0x20
+#define MLXPLAT_CPLD_LPC_REG_LED2_OFFSET	0x21
+#define MLXPLAT_CPLD_LPC_REG_LED3_OFFSET	0x22
+#define MLXPLAT_CPLD_LPC_REG_LED4_OFFSET	0x23
+#define MLXPLAT_CPLD_LPC_REG_LED5_OFFSET	0x24
 #define MLXPLAT_CPLD_LPC_REG_AGGR_OFFSET	0x3a
 #define MLXPLAT_CPLD_LPC_REG_AGGR_MASK_OFFSET	0x3b
 #define MLXPLAT_CPLD_LPC_REG_AGGRLO_OFFSET	0x40
@@ -84,6 +89,8 @@
 #define MLXPLAT_CPLD_PWR_MASK		GENMASK(1, 0)
 #define MLXPLAT_CPLD_FAN_MASK		GENMASK(3, 0)
 #define MLXPLAT_CPLD_FAN_NG_MASK	GENMASK(5, 0)
+#define MLXPLAT_CPLD_LED_LO_NIBBLE_MASK	GENMASK(7, 4)
+#define MLXPLAT_CPLD_LED_HI_NIBBLE_MASK	GENMASK(3, 0)
 
 /* Default I2C parent bus number */
 #define MLXPLAT_CPLD_PHYS_ADAPTER_DEF_NR	1
@@ -114,11 +121,13 @@
  * @pdev_i2c - i2c controller platform device
  * @pdev_mux - array of mux platform devices
  * @pdev_hotplug - hotplug platform devices
+ * @platform_items - platform devices container
  */
 struct mlxplat_priv {
 	struct platform_device *pdev_i2c;
 	struct platform_device *pdev_mux[MLXPLAT_CPLD_LPC_MUX_DEVS];
 	struct platform_device *pdev_hotplug;
+	struct mlxreg_core_platform_drivers *platform_items;
 };
 
 /* Regions for LPC I2C controller and LPC base register space */
@@ -592,9 +601,251 @@ struct mlxreg_core_hotplug_platform_data mlxplat_mlxcpld_default_ng_data = {
 	.mask_low = MLXPLAT_CPLD_LOW_AGGR_MASK_LOW,
 };
 
+/* Platform led default data */
+static struct mlxreg_core_data mlxplat_mlxcpld_default_led_data[] = {
+	{
+		.label = "status:green",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED1_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_LO_NIBBLE_MASK,
+	},
+	{
+		.label = "status:red",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED1_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_LO_NIBBLE_MASK
+	},
+	{
+		.label = "psu:green",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED1_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_HI_NIBBLE_MASK,
+	},
+	{
+		.label = "psu:red",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED1_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_HI_NIBBLE_MASK,
+	},
+	{
+		.label = "fan1:green",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED2_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_LO_NIBBLE_MASK,
+	},
+	{
+		.label = "fan1:red",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED2_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_LO_NIBBLE_MASK,
+	},
+	{
+		.label = "fan2:green",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED2_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_HI_NIBBLE_MASK,
+	},
+	{
+		.label = "fan2:red",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED2_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_HI_NIBBLE_MASK,
+	},
+	{
+		.label = "fan3:green",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED3_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_LO_NIBBLE_MASK,
+	},
+	{
+		.label = "fan3:red",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED3_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_LO_NIBBLE_MASK,
+	},
+	{
+		.label = "fan4:green",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED3_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_HI_NIBBLE_MASK,
+	},
+	{
+		.label = "fan4:red",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED3_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_HI_NIBBLE_MASK,
+	},
+};
+
+static struct mlxreg_core_platform_data mlxplat_default_led_data = {
+		.data = mlxplat_mlxcpld_default_led_data,
+		.counter = ARRAY_SIZE(mlxplat_mlxcpld_default_led_data),
+};
+
+/* Platform led MSN21xx system family data */
+static struct mlxreg_core_data mlxplat_mlxcpld_msn21xx_led_data[] = {
+	{
+		.label = "status:green",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED1_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_LO_NIBBLE_MASK,
+	},
+	{
+		.label = "status:red",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED1_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_LO_NIBBLE_MASK
+	},
+	{
+		.label = "fan:green",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED2_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_LO_NIBBLE_MASK,
+	},
+	{
+		.label = "fan:red",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED2_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_LO_NIBBLE_MASK,
+	},
+	{
+		.label = "psu1:green",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED4_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_LO_NIBBLE_MASK,
+	},
+	{
+		.label = "psu1:red",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED4_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_LO_NIBBLE_MASK,
+	},
+	{
+		.label = "psu2:green",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED4_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_HI_NIBBLE_MASK,
+	},
+	{
+		.label = "psu2:red",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED4_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_HI_NIBBLE_MASK,
+	},
+	{
+		.label = "uid:blue",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED5_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_LO_NIBBLE_MASK,
+	},
+};
+
+static struct mlxreg_core_platform_data mlxplat_msn21xx_led_data = {
+		.data = mlxplat_mlxcpld_msn21xx_led_data,
+		.counter = ARRAY_SIZE(mlxplat_mlxcpld_msn21xx_led_data),
+};
+
+/* Platform led for default data for 200GbE systems */
+static struct mlxreg_core_data mlxplat_mlxcpld_default_ng_led_data[] = {
+	{
+		.label = "status:green",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED1_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_LO_NIBBLE_MASK,
+	},
+	{
+		.label = "status:orange",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED1_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_LO_NIBBLE_MASK
+	},
+	{
+		.label = "psu:green",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED1_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_HI_NIBBLE_MASK,
+	},
+	{
+		.label = "psu:orange",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED1_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_HI_NIBBLE_MASK,
+	},
+	{
+		.label = "fan1:green",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED2_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_LO_NIBBLE_MASK,
+	},
+	{
+		.label = "fan1:orange",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED2_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_LO_NIBBLE_MASK,
+	},
+	{
+		.label = "fan2:green",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED2_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_HI_NIBBLE_MASK,
+	},
+	{
+		.label = "fan2:orange",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED2_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_HI_NIBBLE_MASK,
+	},
+	{
+		.label = "fan3:green",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED3_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_LO_NIBBLE_MASK,
+	},
+	{
+		.label = "fan3:orange",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED3_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_LO_NIBBLE_MASK,
+	},
+	{
+		.label = "fan4:green",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED3_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_HI_NIBBLE_MASK,
+	},
+	{
+		.label = "fan4:orange",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED3_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_HI_NIBBLE_MASK,
+	},
+	{
+		.label = "fan5:green",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED4_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_LO_NIBBLE_MASK,
+	},
+	{
+		.label = "fan5:orange",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED4_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_LO_NIBBLE_MASK,
+	},
+	{
+		.label = "fan6:green",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED4_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_HI_NIBBLE_MASK,
+	},
+	{
+		.label = "fan6:orange",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED4_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_HI_NIBBLE_MASK,
+	},
+};
+
+static struct mlxreg_core_platform_data mlxplat_default_ng_led_data = {
+		.data = mlxplat_mlxcpld_default_ng_led_data,
+		.counter = ARRAY_SIZE(mlxplat_mlxcpld_default_ng_led_data),
+};
+
+/* Core platform devices */
+static struct mlxreg_core_platform_driver
+			mlxplat_mlxcpld_default_core_platform_drivers[] = {
+	{
+		.name = "leds-mlxreg",
+		.mlxreg_core_pdata = &mlxplat_default_led_data,
+	},
+};
+
+static struct mlxreg_core_platform_driver
+			mlxplat_mlxcpld_msn21xx_core_platform_drivers[] = {
+	{
+		.name = "leds-mlxreg",
+		.mlxreg_core_pdata = &mlxplat_msn21xx_led_data,
+	},
+};
+
+static struct mlxreg_core_platform_driver
+			mlxplat_mlxcpld_default_ng_core_platform_drivers[] = {
+	{
+		.name = "leds-mlxreg",
+		.mlxreg_core_pdata = &mlxplat_default_ng_led_data,
+	},
+};
+
 static bool mlxplat_mlxcpld_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case MLXPLAT_CPLD_LPC_REG_LED1_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_LED2_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_LED3_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_LED4_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_LED5_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_AGGR_MASK_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_AGGRLO_MASK_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_PSU_EVENT_OFFSET:
@@ -611,6 +862,11 @@ static bool mlxplat_mlxcpld_writeable_reg(struct device *dev, unsigned int reg)
 static bool mlxplat_mlxcpld_readable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case MLXPLAT_CPLD_LPC_REG_LED1_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_LED2_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_LED3_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_LED4_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_LED5_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_AGGR_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_AGGR_MASK_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_AGGRLO_OFFSET:
@@ -632,6 +888,11 @@ static bool mlxplat_mlxcpld_readable_reg(struct device *dev, unsigned int reg)
 static bool mlxplat_mlxcpld_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case MLXPLAT_CPLD_LPC_REG_LED1_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_LED2_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_LED3_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_LED4_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_LED5_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_AGGR_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_AGGR_MASK_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_AGGRLO_OFFSET:
@@ -692,6 +953,7 @@ static struct resource mlxplat_mlxcpld_resources[] = {
 
 static struct platform_device *mlxplat_dev;
 static struct mlxreg_core_hotplug_platform_data *mlxplat_hotplug;
+static struct mlxreg_core_platform_drivers mlxplat_platform_devs;
 
 static int __init mlxplat_dmi_default_matched(const struct dmi_system_id *dmi)
 {
@@ -705,6 +967,10 @@ static int __init mlxplat_dmi_default_matched(const struct dmi_system_id *dmi)
 	mlxplat_hotplug = &mlxplat_mlxcpld_default_data;
 	mlxplat_hotplug->deferred_nr =
 		mlxplat_default_channels[i - 1][MLXPLAT_CPLD_GRP_CHNL_NUM - 1];
+	mlxplat_platform_devs.pdrv =
+			mlxplat_mlxcpld_default_core_platform_drivers;
+	mlxplat_platform_devs.pdrvs_num =
+		ARRAY_SIZE(mlxplat_mlxcpld_default_core_platform_drivers);
 
 	return 1;
 };
@@ -721,6 +987,10 @@ static int __init mlxplat_dmi_msn21xx_matched(const struct dmi_system_id *dmi)
 	mlxplat_hotplug = &mlxplat_mlxcpld_msn21xx_data;
 	mlxplat_hotplug->deferred_nr =
 		mlxplat_msn21xx_channels[MLXPLAT_CPLD_GRP_CHNL_NUM - 1];
+	mlxplat_platform_devs.pdrv =
+			mlxplat_mlxcpld_msn21xx_core_platform_drivers;
+	mlxplat_platform_devs.pdrvs_num =
+		ARRAY_SIZE(mlxplat_mlxcpld_msn21xx_core_platform_drivers);
 
 	return 1;
 };
@@ -737,6 +1007,10 @@ static int __init mlxplat_dmi_msn274x_matched(const struct dmi_system_id *dmi)
 	mlxplat_hotplug = &mlxplat_mlxcpld_msn274x_data;
 	mlxplat_hotplug->deferred_nr =
 		mlxplat_msn21xx_channels[MLXPLAT_CPLD_GRP_CHNL_NUM - 1];
+	mlxplat_platform_devs.pdrv =
+			mlxplat_mlxcpld_default_core_platform_drivers;
+	mlxplat_platform_devs.pdrvs_num =
+		ARRAY_SIZE(mlxplat_mlxcpld_default_core_platform_drivers);
 
 	return 1;
 };
@@ -753,6 +1027,10 @@ static int __init mlxplat_dmi_msn201x_matched(const struct dmi_system_id *dmi)
 	mlxplat_hotplug = &mlxplat_mlxcpld_msn201x_data;
 	mlxplat_hotplug->deferred_nr =
 		mlxplat_default_channels[i - 1][MLXPLAT_CPLD_GRP_CHNL_NUM - 1];
+	mlxplat_platform_devs.pdrv =
+			mlxplat_mlxcpld_msn21xx_core_platform_drivers;
+	mlxplat_platform_devs.pdrvs_num =
+		ARRAY_SIZE(mlxplat_mlxcpld_msn21xx_core_platform_drivers);
 
 	return 1;
 };
@@ -769,6 +1047,10 @@ static int __init mlxplat_dmi_qmb7xx_matched(const struct dmi_system_id *dmi)
 	mlxplat_hotplug = &mlxplat_mlxcpld_default_ng_data;
 	mlxplat_hotplug->deferred_nr =
 		mlxplat_msn21xx_channels[MLXPLAT_CPLD_GRP_CHNL_NUM - 1];
+	mlxplat_platform_devs.pdrv =
+			mlxplat_mlxcpld_default_ng_core_platform_drivers;
+	mlxplat_platform_devs.pdrvs_num =
+		ARRAY_SIZE(mlxplat_mlxcpld_default_ng_core_platform_drivers);
 
 	return 1;
 };
@@ -990,6 +1272,13 @@ static int __init mlxplat_init(void)
 		goto fail_platform_mux_register;
 	}
 
+	/* Add platform drivers. */
+	err = mlxreg_core_add_platform_drivers(&mlxplat_dev->dev,
+					       &mlxplat_platform_devs,
+					       mlxplat_hotplug->regmap);
+	if (err)
+		goto fail_platform_hotplug_register;
+
 	/* Sync registers with hardware. */
 	regcache_mark_dirty(mlxplat_hotplug->regmap);
 	err = regcache_sync(mlxplat_hotplug->regmap);
@@ -1016,6 +1305,7 @@ static void __exit mlxplat_exit(void)
 	struct mlxplat_priv *priv = platform_get_drvdata(mlxplat_dev);
 	int i;
 
+	mlxreg_core_remove_platform_drivers(&mlxplat_platform_devs);
 	platform_device_unregister(priv->pdev_hotplug);
 
 	for (i = ARRAY_SIZE(mlxplat_mux_data) - 1; i >= 0 ; i--)
diff --git a/include/linux/platform_data/mlxreg.h b/include/linux/platform_data/mlxreg.h
index 19f5cb61..efc30a7 100644
--- a/include/linux/platform_data/mlxreg.h
+++ b/include/linux/platform_data/mlxreg.h
@@ -144,4 +144,67 @@ struct mlxreg_core_hotplug_platform_data {
 	int shift_nr;
 };
 
+/* mlxreg_core_platform_driver - platform driver specification
+ * @name - platform driver name;
+ * @regmap - register map shared between all the drivers;
+ * @pdev - platform device;
+ * @mlxreg_core_pdata - platform driver data;
+ */
+struct mlxreg_core_platform_driver {
+	const char *name;
+	void *regmap;
+	struct platform_device *pdev;
+	struct mlxreg_core_platform_data *mlxreg_core_pdata;
+};
+
+/* mlxreg_core_platform_drivers - platform drivers container
+ * @pdrv - platform driver container;
+ * @pdrvs_num - number of core platform drivers;
+ */
+struct mlxreg_core_platform_drivers {
+	struct mlxreg_core_platform_driver *pdrv;
+	int pdrvs_num;
+};
+
+static inline int
+mlxreg_core_add_platform_drivers(struct device *dev,
+		struct mlxreg_core_platform_drivers *pdrvs, void *regmap)
+{
+	struct mlxreg_core_platform_driver *item;
+	int i, err;
+
+	for (i = 0; i < pdrvs->pdrvs_num; i++, item++) {
+		item = pdrvs->pdrv + i;
+		item->regmap = regmap;
+		item->pdev = platform_device_register_resndata(dev, item->name,
+					PLATFORM_DEVID_NONE, NULL, 0,
+					item->mlxreg_core_pdata,
+					sizeof(*item->mlxreg_core_pdata));
+		if (IS_ERR(item->pdev)) {
+			err = PTR_ERR(item->pdev);
+			goto fail;
+		}
+	}
+
+	return 0;
+
+fail:
+	while (--i >= 0)
+		platform_device_unregister(--item->pdev);
+
+	return err;
+}
+
+static inline void
+mlxreg_core_remove_platform_drivers(struct mlxreg_core_platform_drivers *pdrvs)
+{
+	struct mlxreg_core_platform_driver *item;
+	int i;
+
+	for (i = pdrvs->pdrvs_num - 1; i >= 0 ; i--) {
+		item = pdrvs->pdrv + i;
+		platform_device_unregister(item->pdev);
+	}
+}
+
 #endif /* __LINUX_PLATFORM_DATA_MLXREG_H */
-- 
2.1.4
