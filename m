Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753355AbeDUXMy (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 19:12:54 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:30827 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753208AbeDUXMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 19:12:52 -0400
From: "Andrew F. Davis" <afd@ti.com>
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH] power: supply: bq27xxx: Add support for BQ27426
Date: Sat, 21 Apr 2018 18:12:49 -0500
Message-ID: <20180421231249.9517-1-afd@ti.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device is software similar to the BQ27426 except it has
different data memory offsets. Add support here.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 .../devicetree/bindings/power/supply/bq27xxx.txt         | 1 +
 drivers/power/supply/bq27xxx_battery.c                   | 9 +++++++++
 drivers/power/supply/bq27xxx_battery_i2c.c               | 2 ++
 include/linux/power/bq27xxx_battery.h                    | 3 ++-
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt b/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
index 615c1cb6889f..37994fdb18ca 100644
--- a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
+++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
@@ -25,6 +25,7 @@ Required properties:
  * "ti,bq27545" - BQ27545
  * "ti,bq27421" - BQ27421
  * "ti,bq27425" - BQ27425
+ * "ti,bq27426" - BQ27426
  * "ti,bq27441" - BQ27441
  * "ti,bq27621" - BQ27621
 - reg: integer, I2C address of the fuel gauge.
diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 7ce60519b1bc..d44ed8e17c47 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -432,6 +432,7 @@ static u8
 		BQ27XXX_DM_REG_ROWS,
 	};
 #define bq27425_regs bq27421_regs
+#define bq27426_regs bq27421_regs
 #define bq27441_regs bq27421_regs
 #define bq27621_regs bq27421_regs
 
@@ -664,6 +665,7 @@ static enum power_supply_property bq27421_props[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
 #define bq27425_props bq27421_props
+#define bq27426_props bq27421_props
 #define bq27441_props bq27421_props
 #define bq27621_props bq27421_props
 
@@ -734,6 +736,12 @@ static struct bq27xxx_dm_reg bq27425_dm_regs[] = {
 	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 18, 2, 2800,  3700 },
 };
 
+static struct bq27xxx_dm_reg bq27426_dm_regs[] = {
+	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 82,  6, 2,    0,  8000 },
+	[BQ27XXX_DM_DESIGN_ENERGY]     = { 82,  8, 2,    0, 32767 },
+	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 10, 2, 2500,  3700 },
+};
+
 #if 0 /* not yet tested */
 #define bq27441_dm_regs bq27421_dm_regs
 #else
@@ -795,6 +803,7 @@ static struct {
 	[BQ27545]   = BQ27XXX_DATA(bq27545,   0x04143672, BQ27XXX_O_OTDC),
 	[BQ27421]   = BQ27XXX_DATA(bq27421,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
 	[BQ27425]   = BQ27XXX_DATA(bq27425,   0x04143672, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP),
+	[BQ27426]   = BQ27XXX_DATA(bq27426,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
 	[BQ27441]   = BQ27XXX_DATA(bq27441,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
 	[BQ27621]   = BQ27XXX_DATA(bq27621,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
 };
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index 6b25e5f2337e..40069128ad44 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -249,6 +249,7 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
 	{ "bq27545", BQ27545 },
 	{ "bq27421", BQ27421 },
 	{ "bq27425", BQ27425 },
+	{ "bq27426", BQ27426 },
 	{ "bq27441", BQ27441 },
 	{ "bq27621", BQ27621 },
 	{},
@@ -280,6 +281,7 @@ static const struct of_device_id bq27xxx_battery_i2c_of_match_table[] = {
 	{ .compatible = "ti,bq27545" },
 	{ .compatible = "ti,bq27421" },
 	{ .compatible = "ti,bq27425" },
+	{ .compatible = "ti,bq27426" },
 	{ .compatible = "ti,bq27441" },
 	{ .compatible = "ti,bq27621" },
 	{},
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 01fbf1b16258..d6355f49fbae 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -24,8 +24,9 @@ enum bq27xxx_chip {
 	BQ27546,
 	BQ27742,
 	BQ27545, /* bq27545 */
-	BQ27421, /* bq27421, bq27425, bq27441, bq27621 */
+	BQ27421, /* bq27421, bq27441, bq27621 */
 	BQ27425,
+	BQ27426,
 	BQ27441,
 	BQ27621,
 };
-- 
2.17.0
