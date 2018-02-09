Return-Path: <vadimp@mellanox.com>
X-Google-Smtp-Source: AH8x22600F1Eb2TXlvJ/WM3g4RTkhOlTzGu5ZMr1IYxXB5p7ZCfXjo4m8G2APW7K9HzppXau29q0
ARC-Seal: i=1; a=rsa-sha256; t=1518214947; cv=none;
        d=google.com; s=arc-20160816;
        b=Dfv4rIKUwVUkZPS9qZVbvqXXNRCFNCTwMGBDDw7K0ngA8//jPWZQDJ/zQTKnB24him
         RzaIcIiRYMraj65t2hQCe4yg7YSyxtXCi5DgwlHfSCRFdmWPlYP0qe7SD73c9taIfc3A
         MWh8YvX0qnR0s1QN3aIwxoKh0ZahRNKkooT/PvGNncRqLltYJnYJgYGIShIRe4GhVDOI
         rUVDQX0Aa6MSJS5C/+jlsNLC00Gkd9TXpszuFJUQmL9EP8UCF5QIYpMy9iWz2611MA4r
         OO6xnJOw9WBF70nkjG4Z9txrStDYX9YMYL93fw50tqYxdYxT65pW39v6LrjhGxer9zGA
         NK8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=+A+K6emciv8ZYIdBFROv5ngabLHjFQBTNK565KDgNd8=;
        b=CkiQ0QFalKQLWue1UlP1lFMsZ9zEE1avRqav/q6f2DhYxQWZa6areaRleJ0XOtX20u
         TbH9U4vtfm9VQ0LsQgRxm5dcXNv8nkhVgwXQvcErROlAYiRdfdI82rgx0iKfHE1QRAXW
         OFs2V+YETTaB4eNM5nK7i6aDDiVever2f/IuXBQeUmJh4/kai0EWM9Us5tTkrUgekVHx
         D3oVVExo2i7660IK2z4RddIUdyaTBUSpvvZNjI7zjy6NCxw5D7ANSmQYBxnAwKEWu0yJ
         LhGoEs5bPKcjBMsSW5eeihL5LWNuu1MEHsy9txC8zHwLyJlEfjN7DyIqNjIBEbS7POi3
         xUtQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 193.47.165.129 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 193.47.165.129 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
From: Vadim Pasternak <vadimp@mellanox.com>
To: dvhart@infradead.org, andy.shevchenko@gmail.com,
        gregkh@linuxfoundation.org
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiri@resnulli.us, Vadim Pasternak <vadimp@mellanox.com>
Subject: [patch v2 3/3] platform/x86: mlx-platform: Add support for new 200G IB and Ethernet systems
Date: Fri,  9 Feb 2018 23:59:32 +0000
Message-Id: <1518220772-98492-4-git-send-email-vadimp@mellanox.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1518220772-98492-1-git-send-email-vadimp@mellanox.com>
References: <1518220772-98492-1-git-send-email-vadimp@mellanox.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591963756580220544?=
X-GMAIL-MSGID: =?utf-8?q?1591963756580220544?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

It adds support for new Mellanox system types of basic classes qmb7, sn34,
sn37, containing systems QMB700 (40x200GbE InfiniBand switch), SN3700
(32x200GbE and 16x400GbE Ethernet switch) and SN3410 (6x400GbE plus
48x50GbE Ethernet switch). These are the Top of the Rack systems, equipped
with Mellanox COM-Express carrier board and switch board with Mellanox
Quantum device, which supports InfiniBand switching with 40X200G ports and
line rate of up to HDR speed or with Mellanox Spectrum-2 device, which
supports Ethernet switching with 32X200G ports line rate of up to HDR
speed.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
v1->v2
  Comments pointed out by Darren:
  - Break the patch into series of patches per system type.
---
 drivers/platform/x86/mlx-platform.c | 142 ++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/mlx-platform.c
index e4251cf..454e14f 100644
--- a/drivers/platform/x86/mlx-platform.c
+++ b/drivers/platform/x86/mlx-platform.c
@@ -83,6 +83,7 @@
 #define MLXPLAT_CPLD_PSU_MASK		GENMASK(1, 0)
 #define MLXPLAT_CPLD_PWR_MASK		GENMASK(1, 0)
 #define MLXPLAT_CPLD_FAN_MASK		GENMASK(3, 0)
+#define MLXPLAT_CPLD_FAN_NG_MASK	GENMASK(5, 0)
 
 /* Start channel numbers */
 #define MLXPLAT_CPLD_CH1			2
@@ -170,6 +171,15 @@ static struct i2c_board_info mlxplat_mlxcpld_psu[] = {
 	},
 };
 
+static struct i2c_board_info mlxplat_mlxcpld_ng_psu[] = {
+	{
+		I2C_BOARD_INFO("24c32", 0x51),
+	},
+	{
+		I2C_BOARD_INFO("24c32", 0x50),
+	},
+};
+
 static struct i2c_board_info mlxplat_mlxcpld_pwr[] = {
 	{
 		I2C_BOARD_INFO("dps460", 0x59),
@@ -476,6 +486,103 @@ struct mlxreg_core_hotplug_platform_data mlxplat_mlxcpld_msn201x_data = {
 	.mask_low = MLXPLAT_CPLD_LOW_AGGR_MASK_LOW,
 };
 
+/* Platform hotplug next generation system family data */
+static struct mlxreg_core_data mlxplat_mlxcpld_default_ng_psu_items_data[] = {
+	{
+		.label = "psu1",
+		.reg = MLXPLAT_CPLD_LPC_REG_PSU_OFFSET,
+		.mask = BIT(0),
+		.hpdev.brdinfo = &mlxplat_mlxcpld_ng_psu[0],
+		.hpdev.nr = MLXPLAT_CPLD_PSU_MSNXXXX_NR,
+	},
+	{
+		.label = "psu2",
+		.reg = MLXPLAT_CPLD_LPC_REG_PSU_OFFSET,
+		.mask = BIT(1),
+		.hpdev.brdinfo = &mlxplat_mlxcpld_ng_psu[1],
+		.hpdev.nr = MLXPLAT_CPLD_PSU_MSNXXXX_NR,
+	},
+};
+
+static struct mlxreg_core_data mlxplat_mlxcpld_default_ng_fan_items_data[] = {
+	{
+		.label = "fan1",
+		.reg = MLXPLAT_CPLD_LPC_REG_FAN_OFFSET,
+		.mask = BIT(0),
+		.hpdev.nr = MLXPLAT_CPLD_NR_NONE,
+	},
+	{
+		.label = "fan2",
+		.reg = MLXPLAT_CPLD_LPC_REG_FAN_OFFSET,
+		.mask = BIT(1),
+		.hpdev.nr = MLXPLAT_CPLD_NR_NONE,
+	},
+	{
+		.label = "fan3",
+		.reg = MLXPLAT_CPLD_LPC_REG_FAN_OFFSET,
+		.mask = BIT(2),
+		.hpdev.nr = MLXPLAT_CPLD_NR_NONE,
+	},
+	{
+		.label = "fan4",
+		.reg = MLXPLAT_CPLD_LPC_REG_FAN_OFFSET,
+		.mask = BIT(3),
+		.hpdev.nr = MLXPLAT_CPLD_NR_NONE,
+	},
+	{
+		.label = "fan5",
+		.reg = MLXPLAT_CPLD_LPC_REG_FAN_OFFSET,
+		.mask = BIT(4),
+		.hpdev.nr = MLXPLAT_CPLD_NR_NONE,
+	},
+	{
+		.label = "fan6",
+		.reg = MLXPLAT_CPLD_LPC_REG_FAN_OFFSET,
+		.mask = BIT(5),
+		.hpdev.nr = MLXPLAT_CPLD_NR_NONE,
+	},
+};
+
+static struct mlxreg_core_item mlxplat_mlxcpld_default_ng_items[] = {
+	{
+		.data = mlxplat_mlxcpld_default_ng_psu_items_data,
+		.aggr_mask = MLXPLAT_CPLD_AGGR_MASK_NG_DEF,
+		.reg = MLXPLAT_CPLD_LPC_REG_PSU_OFFSET,
+		.mask = MLXPLAT_CPLD_PSU_MASK,
+		.count = ARRAY_SIZE(mlxplat_mlxcpld_default_ng_psu_items_data),
+		.inversed = 1,
+		.health = false,
+	},
+	{
+		.data = mlxplat_mlxcpld_default_ng_pwr_items_data,
+		.aggr_mask = MLXPLAT_CPLD_AGGR_MASK_NG_DEF,
+		.reg = MLXPLAT_CPLD_LPC_REG_PWR_OFFSET,
+		.mask = MLXPLAT_CPLD_PWR_MASK,
+		.count = ARRAY_SIZE(mlxplat_mlxcpld_default_ng_pwr_items_data),
+		.inversed = 0,
+		.health = false,
+	},
+	{
+		.data = mlxplat_mlxcpld_default_ng_fan_items_data,
+		.aggr_mask = MLXPLAT_CPLD_AGGR_MASK_NG_DEF,
+		.reg = MLXPLAT_CPLD_LPC_REG_FAN_OFFSET,
+		.mask = MLXPLAT_CPLD_FAN_NG_MASK,
+		.count = ARRAY_SIZE(mlxplat_mlxcpld_default_ng_fan_items_data),
+		.inversed = 1,
+		.health = false,
+	},
+};
+
+static
+struct mlxreg_core_hotplug_platform_data mlxplat_mlxcpld_default_ng_data = {
+	.items = mlxplat_mlxcpld_default_ng_items,
+	.counter = ARRAY_SIZE(mlxplat_mlxcpld_default_ng_items),
+	.cell = MLXPLAT_CPLD_LPC_REG_AGGR_OFFSET,
+	.mask = MLXPLAT_CPLD_AGGR_MASK_NG_DEF,
+	.cell_low = MLXPLAT_CPLD_LPC_REG_AGGRLO_OFFSET,
+	.mask_low = MLXPLAT_CPLD_LOW_AGGR_MASK_LOW,
+};
+
 static bool mlxplat_mlxcpld_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -633,6 +740,20 @@ static int __init mlxplat_dmi_msn201x_matched(const struct dmi_system_id *dmi)
 	return 1;
 };
 
+static int __init mlxplat_dmi_qmb7xx_matched(const struct dmi_system_id *dmi)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mlxplat_mux_data); i++) {
+		mlxplat_mux_data[i].values = mlxplat_msn21xx_channels;
+		mlxplat_mux_data[i].n_values =
+				ARRAY_SIZE(mlxplat_msn21xx_channels);
+	}
+	mlxplat_hotplug = &mlxplat_mlxcpld_default_ng_data;
+
+	return 1;
+};
+
 static const struct dmi_system_id mlxplat_dmi_table[] __initconst = {
 	{
 		.callback = mlxplat_dmi_msn274x_matched,
@@ -683,6 +804,27 @@ static const struct dmi_system_id mlxplat_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "MSN201"),
 		},
 	},
+	{
+		.callback = mlxplat_dmi_qmb7xx_matched,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Mellanox Technologies"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "QMB7"),
+		},
+	},
+	{
+		.callback = mlxplat_dmi_qmb7xx_matched,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Mellanox Technologies"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "SN37"),
+		},
+	},
+	{
+		.callback = mlxplat_dmi_qmb7xx_matched,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Mellanox Technologies"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "SN34"),
+		},
+	},
 	{ }
 };
 
-- 
2.1.4
