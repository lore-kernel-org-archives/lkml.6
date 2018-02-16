Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965810AbeBPMGJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 07:06:09 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42584 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965776AbeBPMGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 07:06:04 -0500
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Applied "regmap: Use _regmap_read in regmap_bulk_read" to the regmap tree
In-Reply-To: <20180215175220.2691-3-ckeepax@opensource.cirrus.com>
Message-Id: <E1emelu-0005AA-Kr@debutante>
Date: Fri, 16 Feb 2018 12:05:46 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: Use _regmap_read in regmap_bulk_read

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

>From 186ba2eec275a5e4ee09d4b6a77c619e46fab9fd Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Thu, 15 Feb 2018 17:52:18 +0000
Subject: [PATCH] regmap: Use _regmap_read in regmap_bulk_read

Bulk reads may potentially read a lot of registers and regmap_read will
take and release the regmap lock for each register. Avoid bouncing
the lock so frequently by holding the lock locally and calling
_regmap_read instead. This also has the nice side-effect that all the
reads will be done atomically so no other threads can sneak a write in
during the regmap_bulk_read.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index ff30a9157de5..258a40e2a1d3 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2674,6 +2674,8 @@ int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 
 	if (!IS_ALIGNED(reg, map->reg_stride))
 		return -EINVAL;
+	if (val_count == 0)
+		return -EINVAL;
 
 	if (map->bus && map->format.parse_inplace && (vol || map->cache_type == REGCACHE_NONE)) {
 		ret = regmap_raw_read(map, reg, val, val_bytes * val_count);
@@ -2690,13 +2692,15 @@ int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 		u16 *u16 = val;
 		u8 *u8 = val;
 
+		map->lock(map->lock_arg);
+
 		for (i = 0; i < val_count; i++) {
 			unsigned int ival;
 
-			ret = regmap_read(map, reg + regmap_get_offset(map, i),
-					  &ival);
+			ret = _regmap_read(map, reg + regmap_get_offset(map, i),
+					   &ival);
 			if (ret != 0)
-				return ret;
+				goto out;
 
 			switch (map->format.val_bytes) {
 #ifdef CONFIG_64BIT
@@ -2714,12 +2718,16 @@ int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 				u8[i] = ival;
 				break;
 			default:
-				return -EINVAL;
+				ret = -EINVAL;
+				goto out;
 			}
 		}
+
+out:
+		map->unlock(map->lock_arg);
 	}
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(regmap_bulk_read);
 
-- 
2.16.1
