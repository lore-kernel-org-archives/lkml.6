Return-Path: <vadimp@mellanox.com>
X-Google-Smtp-Source: AB8JxZrdtB5ki979BPjlgOQ2IdlCwq9YX+GNl0Loh8Cz4HJISfdbpIQUx7j19scsUAi0WDKRKhez
ARC-Seal: i=1; a=rsa-sha256; t=1525668788; cv=none;
        d=google.com; s=arc-20160816;
        b=Hyi8cvDW4vODRWhqrVb9aEWJQwovQ51kQLJWizSYN9MwoDQMEG4nxQodgo1zo4BSMG
         z1ipA0DX2zR79pB6umvptRGd7k76QhkuBK2qLDbAytUSaDn7i7zN1Gg4HT3aZvp9NEjl
         kPJjQ7D1/htAC3hnN9EJtv9JKO1aBc8C9kJX0850O90HYMs/x4hqiBhTM03SvSZWADgK
         s7O7RXWrnc1UJO1k8LbUckf+v9IBnu1opU9Ku0c2NmkW5hFimwKt+BD/4rAoTtIfXgOV
         rojQCiuqx+CffMjTNOVoYaA/xpfAHbz1zpjjrWWk82aG1BUgxDgiuathNGlZ60YY+GPN
         iIpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=fQaEdiZkH9qP/hgWd90A4qz4bvrru7kArOb4BBgJEjE=;
        b=S9BL4bUwlXEI49oceziRp81y8QPhmJs/DuBR2K/daRH5Xyr4RhBuekv0voGuilTeXM
         58poBBTkvfJO6Xkc1cCFNOBTty4UFgJUpPM3Mg7VmCpGJocNCC4MmSyGtL28vz95+SVJ
         JNmtGrgnA89sLgfrALXKcyXWgmQiMtSXwRxhfinCgJLtaTMVGQ/oaXKYoATXRx8i5FoP
         6elWnblejBuGD+PXaa56vMKdzH0/ttQIDNt87kdmdUcqJvjVpyic0ch9hXMo8sHkbD3V
         JtDrwUR5DDy/fI396HkB3iUQMeGY93jKWg4vkQjjO1C3CkC95VtwnqQQkOHDxcpqIydu
         W0Tw==
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
Subject: [PATCH v2 5/7] platform/x86: mlx-platform: Add LED platform driver activation
Date: Mon,  7 May 2018 06:48:53 +0000
Message-Id: <1525675735-125547-3-git-send-email-vadimp@mellanox.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1525675735-125547-1-git-send-email-vadimp@mellanox.com>
References: <1525675735-125547-1-git-send-email-vadimp@mellanox.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599779675457691453?=
X-GMAIL-MSGID: =?utf-8?q?1599779675457691453?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add LED platform driver activation from mlx-platform. This LED driver uses
the same regmap infrastructure as others Mellanox platform drivers, so LED
specific registers description is added.

System LED configuration depends on system type. To support all the
relevant types per system type LED descriptions are defined for passing
to LED platform driver.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
v1->v2:
 Fixes added by Vadim:
 - Remove inline functions from mlxreg.h file;
---
 drivers/platform/x86/mlx-platform.c | 259 +++++++++++++++++++++++++++++++++++-
 1 file changed, 258 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/mlx-platform.c
index 912f844..a0fd9aa 100644
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
+ * @pdev_led - led platform devices
  */
 struct mlxplat_priv {
 	struct platform_device *pdev_i2c;
 	struct platform_device *pdev_mux[MLXPLAT_CPLD_LPC_MUX_DEVS];
 	struct platform_device *pdev_hotplug;
+	struct platform_device *pdev_led;
 };
 
 /* Regions for LPC I2C controller and LPC base register space */
@@ -592,9 +601,227 @@ struct mlxreg_core_hotplug_platform_data mlxplat_mlxcpld_default_ng_data = {
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
@@ -611,6 +838,11 @@ static bool mlxplat_mlxcpld_writeable_reg(struct device *dev, unsigned int reg)
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
@@ -632,6 +864,11 @@ static bool mlxplat_mlxcpld_readable_reg(struct device *dev, unsigned int reg)
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
@@ -692,6 +929,7 @@ static struct resource mlxplat_mlxcpld_resources[] = {
 
 static struct platform_device *mlxplat_dev;
 static struct mlxreg_core_hotplug_platform_data *mlxplat_hotplug;
+static struct mlxreg_core_platform_data *mlxplat_led;
 
 static int __init mlxplat_dmi_default_matched(const struct dmi_system_id *dmi)
 {
@@ -705,6 +943,7 @@ static int __init mlxplat_dmi_default_matched(const struct dmi_system_id *dmi)
 	mlxplat_hotplug = &mlxplat_mlxcpld_default_data;
 	mlxplat_hotplug->deferred_nr =
 		mlxplat_default_channels[i - 1][MLXPLAT_CPLD_GRP_CHNL_NUM - 1];
+	mlxplat_led = &mlxplat_default_led_data;
 
 	return 1;
 };
@@ -721,6 +960,7 @@ static int __init mlxplat_dmi_msn21xx_matched(const struct dmi_system_id *dmi)
 	mlxplat_hotplug = &mlxplat_mlxcpld_msn21xx_data;
 	mlxplat_hotplug->deferred_nr =
 		mlxplat_msn21xx_channels[MLXPLAT_CPLD_GRP_CHNL_NUM - 1];
+	mlxplat_led = &mlxplat_msn21xx_led_data;
 
 	return 1;
 };
@@ -737,6 +977,7 @@ static int __init mlxplat_dmi_msn274x_matched(const struct dmi_system_id *dmi)
 	mlxplat_hotplug = &mlxplat_mlxcpld_msn274x_data;
 	mlxplat_hotplug->deferred_nr =
 		mlxplat_msn21xx_channels[MLXPLAT_CPLD_GRP_CHNL_NUM - 1];
+	mlxplat_led = &mlxplat_default_led_data;
 
 	return 1;
 };
@@ -753,6 +994,7 @@ static int __init mlxplat_dmi_msn201x_matched(const struct dmi_system_id *dmi)
 	mlxplat_hotplug = &mlxplat_mlxcpld_msn201x_data;
 	mlxplat_hotplug->deferred_nr =
 		mlxplat_default_channels[i - 1][MLXPLAT_CPLD_GRP_CHNL_NUM - 1];
+	mlxplat_led = &mlxplat_default_ng_led_data;
 
 	return 1;
 };
@@ -769,6 +1011,7 @@ static int __init mlxplat_dmi_qmb7xx_matched(const struct dmi_system_id *dmi)
 	mlxplat_hotplug = &mlxplat_mlxcpld_default_ng_data;
 	mlxplat_hotplug->deferred_nr =
 		mlxplat_msn21xx_channels[MLXPLAT_CPLD_GRP_CHNL_NUM - 1];
+	mlxplat_led = &mlxplat_msn21xx_led_data;
 
 	return 1;
 };
@@ -990,14 +1233,27 @@ static int __init mlxplat_init(void)
 		goto fail_platform_mux_register;
 	}
 
+	/* Add LED driver. */
+	mlxplat_led->regmap = mlxplat_hotplug->regmap;
+	priv->pdev_led = platform_device_register_resndata(
+				&mlxplat_dev->dev, "leds-mlxreg",
+				PLATFORM_DEVID_NONE, NULL, 0,
+				mlxplat_led, sizeof(*mlxplat_led));
+	if (IS_ERR(priv->pdev_led)) {
+		err = PTR_ERR(priv->pdev_led);
+		goto fail_platform_hotplug_register;
+	}
+
 	/* Sync registers with hardware. */
 	regcache_mark_dirty(mlxplat_hotplug->regmap);
 	err = regcache_sync(mlxplat_hotplug->regmap);
 	if (err)
-		goto fail_platform_hotplug_register;
+		goto fail_platform_led_register;
 
 	return 0;
 
+fail_platform_led_register:
+	platform_device_unregister(priv->pdev_led);
 fail_platform_hotplug_register:
 	platform_device_unregister(priv->pdev_hotplug);
 fail_platform_mux_register:
@@ -1016,6 +1272,7 @@ static void __exit mlxplat_exit(void)
 	struct mlxplat_priv *priv = platform_get_drvdata(mlxplat_dev);
 	int i;
 
+	platform_device_unregister(priv->pdev_led);
 	platform_device_unregister(priv->pdev_hotplug);
 
 	for (i = ARRAY_SIZE(mlxplat_mux_data) - 1; i >= 0 ; i--)
-- 
2.1.4
