Return-Path: <vadimp@mellanox.com>
X-Google-Smtp-Source: AH8x224si6XEXAwWbHO3HvYBBR4IjS5Om70IbC89eY+srX2oVb0P+tGZCPihntWy3zDgo19erPgW
ARC-Seal: i=1; a=rsa-sha256; t=1517554178; cv=none;
        d=google.com; s=arc-20160816;
        b=ejedFOmw3xEZFFSQ71tYkP0F88wuwq5rxH1AqKs4oSWlyFHnOP6dNLnR9MMvzga9DD
         wdQotOfKz1g57HCc+M0/sSZkBhFWCO69lUYo7469dYdeBr4WHSfTyU4aOF5yBZxMoAAN
         p3ET1XwjEYRtsg2AlceA2jbBaJx296uB5EexZdc9otqVvAHQwK4w8nimPINnjQtROsU2
         aflmWNUppIOk18tR3cw3G50vXuh475gnH9zFAN4Br7Wy+SBJa2tCJ7EElowL+zVfnJIV
         PymwdOmJA2scdw9mkvUu5GvTCMyinH/3IabG8dTak288QSchs+rTtUsFSbZHkknexQf1
         Au1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Ns6ViRkthvg0vWB9jrtaYIZC80wZNeY+eNzgqSj53Os=;
        b=eODQ7ORTC2Ym8VqdVCc/MW4x9sdwb0qE+H9NJgyWAlMuwKbvY7um1bhS9pBeJ+6RY4
         tZW/mdFAVCv940g7VUAlfl9OcbPvtEFT6agesujMIyjasfE4v5C5lP03QhBmamh7OAn8
         0ICKilsQOqAVY88OtuyBAiLFs5gbhd1UJz0RhtmkZsLCW34YBpET9lCDBC1+cvm+eNiI
         uK1iTYBa08ij2WvxwK2mwCAJ+4t5Jkz+GPbNfCb+6E5ppJqeOhFtpOl172+OJNYb1hBO
         mwkz6Gej7JggXbAhgTH7UGDMQH+OdB4c/BOpHDO4E6AZXCH8gKWv00nbfoVtJ5Fyuch8
         Yh+w==
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
        jiri@resnulli.us, Vadim Pasternak <vadimp@mellanox.com>
Subject: [patch v1 3/4] platform/x86: mlx-platform: Fix power cable setting for systems from msn21xx family
Date: Fri,  2 Feb 2018 08:45:47 +0000
Message-Id: <1517561148-38587-4-git-send-email-vadimp@mellanox.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1517561148-38587-1-git-send-email-vadimp@mellanox.com>
References: <1517561148-38587-1-git-send-email-vadimp@mellanox.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591270889847473743?=
X-GMAIL-MSGID: =?utf-8?q?1591270889847473743?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add dedicated structure with power cable setting for Mellanox system from
family msn21xx. These systems do not have physical device for power
unit controller. So, in case power cable is inserted or removed, relevant
interrupt signal is to be handled, status will be updated, but no device
is to be associated with this signal.

Add definition for interrupt low aggregation signal. On system from
msn21xx family, low aggregation mask should be removed in order to allow
signal hit CPU.

Fixes: 6613d18e9038 ("platform/x86: mlx-platform: Move module from arch/x86")
Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
 drivers/platform/x86/mlx-platform.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/mlx-platform.c
index 177b40a..4d8078d 100644
--- a/drivers/platform/x86/mlx-platform.c
+++ b/drivers/platform/x86/mlx-platform.c
@@ -77,6 +77,8 @@
 #define MLXPLAT_CPLD_AGGR_FAN_MASK_DEF	0x40
 #define MLXPLAT_CPLD_AGGR_MASK_DEF	(MLXPLAT_CPLD_AGGR_PSU_MASK_DEF | \
 					 MLXPLAT_CPLD_AGGR_FAN_MASK_DEF)
+#define MLXPLAT_CPLD_AGGR_MASK_NG_DEF	0x04
+#define MLXPLAT_CPLD_LOW_AGGR_MASK_LOW	0xc0
 #define MLXPLAT_CPLD_AGGR_MASK_MSN21XX	0x04
 #define MLXPLAT_CPLD_PSU_MASK		GENMASK(1, 0)
 #define MLXPLAT_CPLD_PWR_MASK		GENMASK(1, 0)
@@ -295,14 +297,29 @@ struct mlxreg_core_hotplug_platform_data mlxplat_mlxcpld_default_data = {
 	.mask = MLXPLAT_CPLD_AGGR_MASK_DEF,
 };
 
+static struct mlxreg_core_data mlxplat_mlxcpld_msn21xx_pwr_items_data[] = {
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
 /* Platform hotplug MSN21xx system family data */
 static struct mlxreg_core_item mlxplat_mlxcpld_msn21xx_items[] = {
 	{
-		.data = mlxplat_mlxcpld_default_pwr_items_data,
+		.data = mlxplat_mlxcpld_msn21xx_pwr_items_data,
 		.aggr_mask = MLXPLAT_CPLD_AGGR_PWR_MASK_DEF,
 		.reg = MLXPLAT_CPLD_LPC_REG_PWR_OFFSET,
 		.mask = MLXPLAT_CPLD_PWR_MASK,
-		.count = ARRAY_SIZE(mlxplat_mlxcpld_pwr),
+		.count = ARRAY_SIZE(mlxplat_mlxcpld_msn21xx_pwr_items_data),
 		.inversed = 0,
 		.health = false,
 	},
@@ -314,6 +331,8 @@ struct mlxreg_core_hotplug_platform_data mlxplat_mlxcpld_msn21xx_data = {
 	.counter = ARRAY_SIZE(mlxplat_mlxcpld_msn21xx_items),
 	.cell = MLXPLAT_CPLD_LPC_REG_AGGR_OFFSET,
 	.mask = MLXPLAT_CPLD_AGGR_MASK_DEF,
+	.cell_low = MLXPLAT_CPLD_LPC_REG_AGGRLO_OFFSET,
+	.mask_low = MLXPLAT_CPLD_LOW_AGGR_MASK_LOW,
 };
 
 static bool mlxplat_mlxcpld_writeable_reg(struct device *dev, unsigned int reg)
-- 
2.1.4
