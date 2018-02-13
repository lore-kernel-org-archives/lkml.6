Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935264AbeBMMdZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:33:25 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59272 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935106AbeBMM30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:29:26 -0500
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: David Rhodes <david.rhodes@cirrus.com>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        david.rhodes@cirrus.com, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Applied "regmap: Don't use format_val in regmap_bulk_read" to the regmap tree
In-Reply-To: <20180212181547.2415-3-ckeepax@opensource.cirrus.com>
Message-Id: <E1elZi3-0007ND-Ap@debutante>
Date: Tue, 13 Feb 2018 12:29:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: Don't use format_val in regmap_bulk_read

has been applied to the regmap tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git 

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

>From 9ae27a8d1f3ebff09191fb8cb1341414547293b2 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Mon, 12 Feb 2018 18:15:46 +0000
Subject: [PATCH] regmap: Don't use format_val in regmap_bulk_read

A bulk read can be implemented either through regmap_raw_read, or
by reading each register individually using regmap_read.  Both
regmap_read and regmap_bulk_read should return values in native
endian. In the individual case the current implementation calls
format_val to put the data into the output array, which can cause
endian issues. The regmap_read will have already converted the data
into native endian, if the hosts endian differs from the device then
format_val will switch the endian back again.

Rather than using format_val simply use the code that is called if
there is no format_val function. This code supports all cases except
24-bit but there don't appear to be any users of regmap_bulk_read for
24-bit. Additionally, it would have to be a big endian host for the
old code to actually function correctly anyway.

Fixes: 15b8d2c41fe5 ("regmap: Fix regmap_bulk_read in BE mode")
Reported-by: David Rhodes <david.rhodes@cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 55 ++++++++++++++++++--------------------------
 1 file changed, 23 insertions(+), 32 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index ee302ccdfbc8..4037b3782bd3 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2709,47 +2709,38 @@ int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 		for (i = 0; i < val_count * val_bytes; i += val_bytes)
 			map->format.parse_inplace(val + i);
 	} else {
+#ifdef CONFIG_64BIT
+		u64 *u64 = val;
+#endif
+		u32 *u32 = val;
+		u16 *u16 = val;
+		u8 *u8 = val;
+
 		for (i = 0; i < val_count; i++) {
 			unsigned int ival;
+
 			ret = regmap_read(map, reg + regmap_get_offset(map, i),
 					  &ival);
 			if (ret != 0)
 				return ret;
 
-			if (map->format.format_val) {
-				map->format.format_val(val + (i * val_bytes), ival, 0);
-			} else {
-				/* Devices providing read and write
-				 * operations can use the bulk I/O
-				 * functions if they define a val_bytes,
-				 * we assume that the values are native
-				 * endian.
-				 */
-#ifdef CONFIG_64BIT
-				u64 *u64 = val;
-#endif
-				u32 *u32 = val;
-				u16 *u16 = val;
-				u8 *u8 = val;
-
-				switch (map->format.val_bytes) {
+			switch (map->format.val_bytes) {
 #ifdef CONFIG_64BIT
-				case 8:
-					u64[i] = ival;
-					break;
+			case 8:
+				u64[i] = ival;
+				break;
 #endif
-				case 4:
-					u32[i] = ival;
-					break;
-				case 2:
-					u16[i] = ival;
-					break;
-				case 1:
-					u8[i] = ival;
-					break;
-				default:
-					return -EINVAL;
-				}
+			case 4:
+				u32[i] = ival;
+				break;
+			case 2:
+				u16[i] = ival;
+				break;
+			case 1:
+				u8[i] = ival;
+				break;
+			default:
+				return -EINVAL;
 			}
 		}
 	}
-- 
2.16.1
