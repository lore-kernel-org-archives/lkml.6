Return-Path: <vadimp@mellanox.com>
X-Google-Smtp-Source: AH8x226KAKvd7kolD9I6WNYFX6GHuWsQG8qXIe9G3X5h+ImIysQVEohGGa5j/qe6QDl0sP9uQazf
ARC-Seal: i=1; a=rsa-sha256; t=1518214943; cv=none;
        d=google.com; s=arc-20160816;
        b=0XlnGxb7VbaYU3GHx/E0CHpSPrV6lvJaJ9Kp76kNQ51CJt4Hy5Wq9aR5Wq/KhroJVE
         JdWXGUhcy1PpW5FgZrL8XuiQtJUkO+PtzlhFclA29el3qq7NLY18rYo43sJ9rrxV0rH7
         OBx8qj3HTq1BwzAA7z4kahT+fsJuWAi//xvhN6W7KNo+ZjO1iibzJ4ozoFEIfBz+0t0I
         t7awDvMBWRqQrzzRQDxlAkkvxDnslepf7MieeXCKb0tCdZaIh43epxxz9EfysYnZ6ST6
         7UbUUZFIFa+DQKI9fERN2YYTbL/s0wgMvsnNaIVzMlCcrRh1TZISuvHB23hbauFMwo6n
         15yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=mexXhE9MtDv3d/6g3sq26xzJrhMDi3FIYE6uiTchfgo=;
        b=z92zdNCZYR71thFc7qtf58hUwVjXhtEyh9W1pkmTfdC5fysyXPsVCn8I6iqn/NRB9m
         3TH/k2vMTgaRRz603eopegxjIUq2XcYJ/8+50CuN1iDg+7baThCQaZHyIvmsJy9Pnwlk
         sZ2bQQssUzl6qstW//NBetlJFd/rvvz9NHYEN8814EqHKQ2s/WYtl9umH++hi5xdTTnV
         +7hxErydkLGhvW/sXWT0tzml8jPEZsYKeJjxryQecCmLRbp/0Hhs8MP8o+t6Wr+NrZv9
         Gm4j0ahUGUwGk2TbIZiiggj5SFOYFWozRw+rzQ+wHXpSlNW7qPvZjgtu/0to7uFxKZLL
         eV6Q==
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
Subject: [patch v2 1/3] platform/x86: mlx-platform: Add support for new msn274x system type
Date: Fri,  9 Feb 2018 23:59:30 +0000
Message-Id: <1518220772-98492-2-git-send-email-vadimp@mellanox.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1518220772-98492-1-git-send-email-vadimp@mellanox.com>
References: <1518220772-98492-1-git-send-email-vadimp@mellanox.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591963752437739625?=
X-GMAIL-MSGID: =?utf-8?q?1591963752437739625?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

It adds support for new Mellanox system types of basic class msn274x,
containing system MSN2740 (32x100GbE Ethernet switch with cost reduction)
and its derivatives. These are the Top of the Rack system, equipped with
Mellanox Small Form Factor carrier board and switch board with Mellanox
Spectrum device, which supports Ethernet switching with 32X100G ports line
rate of up to EDR speed.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
v1->v2
  Comments pointed out by Darren:
  - Break the patch into series of patches per system type.
---
 drivers/platform/x86/mlx-platform.c | 124 ++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/mlx-platform.c
index e87fe34..3a13285 100644
--- a/drivers/platform/x86/mlx-platform.c
+++ b/drivers/platform/x86/mlx-platform.c
@@ -94,6 +94,7 @@
 /* Hotplug devices adapter numbers */
 #define MLXPLAT_CPLD_NR_NONE			-1
 #define MLXPLAT_CPLD_PSU_DEFAULT_NR		10
+#define MLXPLAT_CPLD_PSU_MSNXXXX_NR		4
 #define MLXPLAT_CPLD_FAN1_DEFAULT_NR		11
 #define MLXPLAT_CPLD_FAN2_DEFAULT_NR		12
 #define MLXPLAT_CPLD_FAN3_DEFAULT_NR		13
@@ -335,6 +336,108 @@ struct mlxreg_core_hotplug_platform_data mlxplat_mlxcpld_msn21xx_data = {
 	.mask_low = MLXPLAT_CPLD_LOW_AGGR_MASK_LOW,
 };
 
+/* Platform hotplug msn274x system family data */
+static struct mlxreg_core_data mlxplat_mlxcpld_msn274x_psu_items_data[] = {
+	{
+		.label = "psu1",
+		.reg = MLXPLAT_CPLD_LPC_REG_PSU_OFFSET,
+		.mask = BIT(0),
+		.hpdev.brdinfo = &mlxplat_mlxcpld_psu[0],
+		.hpdev.nr = MLXPLAT_CPLD_PSU_MSNXXXX_NR,
+	},
+	{
+		.label = "psu2",
+		.reg = MLXPLAT_CPLD_LPC_REG_PSU_OFFSET,
+		.mask = BIT(1),
+		.hpdev.brdinfo = &mlxplat_mlxcpld_psu[1],
+		.hpdev.nr = MLXPLAT_CPLD_PSU_MSNXXXX_NR,
+	},
+};
+
+static struct mlxreg_core_data mlxplat_mlxcpld_default_ng_pwr_items_data[] = {
+	{
+		.label = "pwr1",
+		.reg = MLXPLAT_CPLD_LPC_REG_PWR_OFFSET,
+		.mask = BIT(0),
+		.hpdev.brdinfo = &mlxplat_mlxcpld_pwr[0],
+		.hpdev.nr = MLXPLAT_CPLD_PSU_MSNXXXX_NR,
+	},
+	{
+		.label = "pwr2",
+		.reg = MLXPLAT_CPLD_LPC_REG_PWR_OFFSET,
+		.mask = BIT(1),
+		.hpdev.brdinfo = &mlxplat_mlxcpld_pwr[1],
+		.hpdev.nr = MLXPLAT_CPLD_PSU_MSNXXXX_NR,
+	},
+};
+
+static struct mlxreg_core_data mlxplat_mlxcpld_msn274x_fan_items_data[] = {
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
+};
+
+static struct mlxreg_core_item mlxplat_mlxcpld_msn274x_items[] = {
+	{
+		.data = mlxplat_mlxcpld_msn274x_psu_items_data,
+		.aggr_mask = MLXPLAT_CPLD_AGGR_MASK_NG_DEF,
+		.reg = MLXPLAT_CPLD_LPC_REG_PSU_OFFSET,
+		.mask = MLXPLAT_CPLD_PSU_MASK,
+		.count = ARRAY_SIZE(mlxplat_mlxcpld_msn274x_psu_items_data),
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
+		.data = mlxplat_mlxcpld_msn274x_fan_items_data,
+		.aggr_mask = MLXPLAT_CPLD_AGGR_MASK_NG_DEF,
+		.reg = MLXPLAT_CPLD_LPC_REG_FAN_OFFSET,
+		.mask = MLXPLAT_CPLD_FAN_MASK,
+		.count = ARRAY_SIZE(mlxplat_mlxcpld_msn274x_fan_items_data),
+		.inversed = 1,
+		.health = false,
+	},
+};
+
+static
+struct mlxreg_core_hotplug_platform_data mlxplat_mlxcpld_msn274x_data = {
+	.items = mlxplat_mlxcpld_msn274x_items,
+	.counter = ARRAY_SIZE(mlxplat_mlxcpld_msn274x_items),
+	.cell = MLXPLAT_CPLD_LPC_REG_AGGR_OFFSET,
+	.mask = MLXPLAT_CPLD_AGGR_MASK_NG_DEF,
+	.cell_low = MLXPLAT_CPLD_LPC_REG_AGGRLO_OFFSET,
+	.mask_low = MLXPLAT_CPLD_LOW_AGGR_MASK_LOW,
+};
+
 static bool mlxplat_mlxcpld_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -464,8 +567,29 @@ static int __init mlxplat_dmi_msn21xx_matched(const struct dmi_system_id *dmi)
 	return 1;
 };
 
+static int __init mlxplat_dmi_msn274x_matched(const struct dmi_system_id *dmi)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mlxplat_mux_data); i++) {
+		mlxplat_mux_data[i].values = mlxplat_msn21xx_channels;
+		mlxplat_mux_data[i].n_values =
+				ARRAY_SIZE(mlxplat_msn21xx_channels);
+	}
+	mlxplat_hotplug = &mlxplat_mlxcpld_msn274x_data;
+
+	return 1;
+};
+
 static const struct dmi_system_id mlxplat_dmi_table[] __initconst = {
 	{
+		.callback = mlxplat_dmi_msn274x_matched,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Mellanox Technologies"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MSN274"),
+		},
+	},
+	{
 		.callback = mlxplat_dmi_default_matched,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Mellanox Technologies"),
-- 
2.1.4
