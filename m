Return-Path: <vadimp@mellanox.com>
X-Google-Smtp-Source: AH8x227V5ByunmV94hg5/2Wqt62YIJqtHvCK1qlaD0deMbU5p8e/lnDCSKogxHVvLpF6JKWXYZHb
ARC-Seal: i=1; a=rsa-sha256; t=1518214942; cv=none;
        d=google.com; s=arc-20160816;
        b=cOw38LRGkZY+AZpI7jKEQPmtYs66a2rpWC5ng1TKmMjGr8D0/yXiN2iGmDsZ1vj9mx
         1xFZBgGBqmzLS+z/iRmVCJroFSg381QA0YRmkR/EQ0yo8sCVCMftjMNL1AryugYPdVOT
         OxnJ0OfBD53EsJlt9S2KLdv4mKQFyDWCrOlmK20q8SRJBMkka+4yQ4WuhYQr2U8jL+/p
         U8+RU1RyuKdW8ElMf8vT6jb2wkVawaGDtmEXbJRG2JxRV6fWQ8/CaLPFq/LBtbe4djOL
         YTjsdjGUv8M1fVlIBi80BbeMXwd+D7mxOgUrEnYZmqGeZuBGfEeixw0xRdp2SXXfk16X
         hAug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Qd0/0A+0riQP+2r7QBD8WYPQu2gBQbzOCSiCY8wgvqw=;
        b=fBL2Kp7lbB0Vwx2I6wGMjDvTndfxxN6YNoX+zvDLBgOF7ET/iXbco7o+wPIVLCxdcZ
         j0L3APWEnokf2FJlF38bOpryzqNTrD2hjnkEgQZ/fsMeiPhPv+Pjd82/93XSLlZX6Z5Z
         t6VWhJAIf8T3Syrc3aQV1SrfYsXCmmCSp2ZQY37qoTm2qKcqN6Anj16od7xBxpe0EYCN
         opQAOb3wqjeK6W3Y64Zn7GEncAsTGfAGRrgqWGDPHL/msGCclSzM/Yl6DjsbBqy5dT/L
         K+3fRaMY/3InXBs3EyukqhoDKHimc2tXHwoIMFkw9WK2HGtR6E44O6U03R51MAXj1l7O
         Wogw==
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
Subject: [patch v2 2/3] platform/x86: mlx-platform: Add support for new  msn201x system type
Date: Fri,  9 Feb 2018 23:59:31 +0000
Message-Id: <1518220772-98492-3-git-send-email-vadimp@mellanox.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1518220772-98492-1-git-send-email-vadimp@mellanox.com>
References: <1518220772-98492-1-git-send-email-vadimp@mellanox.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591963751574350567?=
X-GMAIL-MSGID: =?utf-8?q?1591963751574350567?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

It adds support for new Mellanox system types of basic half unit size
class msn201x, containing system MSN2010 (18x10GbE plus 4x4x25GbE) half
and its derivatives. This is the Top of the Rack system, equipped with
Mellanox Small Form Factor carrier board and switch board with Mellanox
Spectrum device, which supports Ethernet switching with 32X100G ports line
rate of up to EDR speed.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
v1->v2
  Comments pointed out by Darren:
  - Break the patch into series of patches per system type.
---
 drivers/platform/x86/mlx-platform.c | 59 +++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/mlx-platform.c
index 3a13285..e4251cf 100644
--- a/drivers/platform/x86/mlx-platform.c
+++ b/drivers/platform/x86/mlx-platform.c
@@ -438,6 +438,44 @@ struct mlxreg_core_hotplug_platform_data mlxplat_mlxcpld_msn274x_data = {
 	.mask_low = MLXPLAT_CPLD_LOW_AGGR_MASK_LOW,
 };
 
+/* Platform hotplug MSN201x system family data */
+static struct mlxreg_core_data mlxplat_mlxcpld_msn201x_pwr_items_data[] = {
+	{
+		.label = "pwr1",
+		.reg = MLXPLAT_CPLD_LPC_REG_PWR_OFFSET,
+		.mask = BIT(0),
+		.hpdev.nr = MLXPLAT_CPLD_NR_NONE,
+	},
+	{
+		.label = "pwr2",
+		.reg = MLXPLAT_CPLD_LPC_REG_PWR_OFFSET,
+		.mask = BIT(1),
+		.hpdev.nr = MLXPLAT_CPLD_NR_NONE,
+	},
+};
+
+static struct mlxreg_core_item mlxplat_mlxcpld_msn201x_items[] = {
+	{
+		.data = mlxplat_mlxcpld_msn201x_pwr_items_data,
+		.aggr_mask = MLXPLAT_CPLD_AGGR_PWR_MASK_DEF,
+		.reg = MLXPLAT_CPLD_LPC_REG_PWR_OFFSET,
+		.mask = MLXPLAT_CPLD_PWR_MASK,
+		.count = ARRAY_SIZE(mlxplat_mlxcpld_msn201x_pwr_items_data),
+		.inversed = 0,
+		.health = false,
+	},
+};
+
+static
+struct mlxreg_core_hotplug_platform_data mlxplat_mlxcpld_msn201x_data = {
+	.items = mlxplat_mlxcpld_msn21xx_items,
+	.counter = ARRAY_SIZE(mlxplat_mlxcpld_msn201x_items),
+	.cell = MLXPLAT_CPLD_LPC_REG_AGGR_OFFSET,
+	.mask = MLXPLAT_CPLD_AGGR_MASK_DEF,
+	.cell_low = MLXPLAT_CPLD_LPC_REG_AGGRLO_OFFSET,
+	.mask_low = MLXPLAT_CPLD_LOW_AGGR_MASK_LOW,
+};
+
 static bool mlxplat_mlxcpld_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -581,6 +619,20 @@ static int __init mlxplat_dmi_msn274x_matched(const struct dmi_system_id *dmi)
 	return 1;
 };
 
+static int __init mlxplat_dmi_msn201x_matched(const struct dmi_system_id *dmi)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mlxplat_mux_data); i++) {
+		mlxplat_mux_data[i].values = mlxplat_msn21xx_channels;
+		mlxplat_mux_data[i].n_values =
+				ARRAY_SIZE(mlxplat_msn21xx_channels);
+	}
+	mlxplat_hotplug = &mlxplat_mlxcpld_msn201x_data;
+
+	return 1;
+};
+
 static const struct dmi_system_id mlxplat_dmi_table[] __initconst = {
 	{
 		.callback = mlxplat_dmi_msn274x_matched,
@@ -624,6 +676,13 @@ static const struct dmi_system_id mlxplat_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "MSN21"),
 		},
 	},
+	{
+		.callback = mlxplat_dmi_msn201x_matched,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Mellanox Technologies"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MSN201"),
+		},
+	},
 	{ }
 };
 
-- 
2.1.4
