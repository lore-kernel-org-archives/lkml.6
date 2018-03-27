Return-Path: <vadimp@mellanox.com>
X-Google-Smtp-Source: AG47ELsddpNFOLoZM1LUzLoHp2F6YDtT2VnXbfShWBQ3nD11XG+iOhF/RayHP4MIgAs8ZG01jg6N
ARC-Seal: i=1; a=rsa-sha256; t=1522137961; cv=none;
        d=google.com; s=arc-20160816;
        b=cj3pwC7jcjMMg9zhirqjsg/JoLc8q8gvn0jxZ8XyN8eOMNN3M2KAOakXT+ReMeoEw/
         ZPBthPdd2MNbGUOc3Opk8Fam64liXrAjyPqZriwT0BBkmJ6o16UGKwMpJLc27Y6pCswJ
         VwYLyHskDNUYgwboo/qRuHu1uHORJrXc9LI+3Y/PB1CnFDj6ZO04bcsV9H07adOBx2ma
         9peaQdBueRsjZFhXa8/4+n47VHvOGsngPHKjrOOdyoxo5AKkXnWaC7yop6WIrrMmC+QB
         boZyN2PNiKwmKUYfo406gZ3hoXoKM71AY62NYcdn6M1lxD3FZLqpjY5gkmGBQWmRcCfE
         w85A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=1sE1UhXUh9cVPxE8eKtzz0DVkHWFKsZeWTl3GOX/UQE=;
        b=VzwpxLAUGjYAB/8YdxjYUo/WaCHJ1kvR/u7ciFqr83eNatt9mcl/LWBcyBq6BWfz+j
         GZ0XMTND6drdbhYCyVQjb173N8LXZ5/KCGdy/gXz9jVjqZSFp0pguVCPPNb9yG51ywmK
         l+dy2/uJSPL09onNJJXLnJo9jkxOResQAcoRcM9KbNTgrhRS2q8gKi0UfvWufLTh2BIr
         fqJHpm3mo84VXxpVn7pmM3NORce9kzrSlk0m8VG40hS53VLcl9Q5xbgEkNSU6+lnUT4t
         u379A3HRfCzKFhVOyD1sO5GEdAINz2E4gedKxjrjJoixruWv3ibhLKN1P7bu02Im6SoU
         /y6w==
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
Subject: [PATCH v1 7/7] platform/x86: mlx-platform: Add mlxreg-io platform driver activation
Date: Tue, 27 Mar 2018 10:02:07 +0000
Message-Id: <1522144927-56512-8-git-send-email-vadimp@mellanox.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1522144927-56512-1-git-send-email-vadimp@mellanox.com>
References: <1522144927-56512-1-git-send-email-vadimp@mellanox.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596077334582254806?=
X-GMAIL-MSGID: =?utf-8?q?1596077334582254806?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds:
- Support for Mellanox mlxreg-io driver activation, which uses the same
  regmap infrastructure as others Mellanox platform drivers.
- Specific registers description for default platform data configuration.
  It includes the registers for resets control, reset causes monitoring,
  programmable devices version reading and mux select control. This
  platform data is passed to mlxreg-io driver.
- The default values for the register, which should be set to these values
  at initialization time by regmap infrastructure.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
 drivers/platform/x86/mlx-platform.c | 127 ++++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/mlx-platform.c
index efb605a..79876d9 100644
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
@@ -813,6 +820,99 @@ static struct mlxreg_core_platform_data mlxplat_default_ng_led_data = {
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
+
 /* Core platform devices */
 static struct mlxreg_core_platform_driver
 			mlxplat_mlxcpld_default_core_platform_drivers[] = {
@@ -828,6 +928,10 @@ static struct mlxreg_core_platform_driver
 		.name = "leds-mlxreg",
 		.mlxreg_core_pdata = &mlxplat_msn21xx_led_data,
 	},
+	{
+		.name = "mlxreg-io",
+		.mlxreg_core_pdata = &mlxplat_default_regs_io_data,
+	},
 };
 
 static struct mlxreg_core_platform_driver
@@ -846,6 +950,10 @@ static bool mlxplat_mlxcpld_writeable_reg(struct device *dev, unsigned int reg)
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
@@ -862,11 +970,18 @@ static bool mlxplat_mlxcpld_writeable_reg(struct device *dev, unsigned int reg)
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
@@ -888,11 +1003,16 @@ static bool mlxplat_mlxcpld_readable_reg(struct device *dev, unsigned int reg)
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
@@ -911,6 +1031,11 @@ static bool mlxplat_mlxcpld_volatile_reg(struct device *dev, unsigned int reg)
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
@@ -943,6 +1068,8 @@ static const struct regmap_config mlxplat_mlxcpld_regmap_config = {
 	.writeable_reg = mlxplat_mlxcpld_writeable_reg,
 	.readable_reg = mlxplat_mlxcpld_readable_reg,
 	.volatile_reg = mlxplat_mlxcpld_volatile_reg,
+	.reg_defaults = mlxplat_mlxcpld_regmap_default,
+	.num_reg_defaults = ARRAY_SIZE(mlxplat_mlxcpld_regmap_default),
 	.reg_read = mlxplat_mlxcpld_reg_read,
 	.reg_write = mlxplat_mlxcpld_reg_write,
 };
-- 
2.1.4
