Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752814AbeBZLSA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 06:18:00 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52040 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752157AbeBZLR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 06:17:56 -0500
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Applied "regmap: Merge redundant handling in regmap_bulk_write" to the regmap tree
In-Reply-To: <20180222125914.17016-5-ckeepax@opensource.cirrus.com>
Message-Id: <E1eqGn2-0005a1-TM@debutante>
Date: Mon, 26 Feb 2018 11:17:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: Merge redundant handling in regmap_bulk_write

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

>From fb44f3cec35c6e71865012fa281ba6d4ff50a99a Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Thu, 22 Feb 2018 12:59:14 +0000
Subject: [PATCH] regmap: Merge redundant handling in regmap_bulk_write

The handling for the first two cases in regmap_bulk_write is
essentially identical. The first case is just a better implementation of
the second, supporting 8 byte registers and doing the locking manually to
avoid bouncing the lock for each register. Drop some redundant code by
removing the second of these cases and allowing both situations to be
handled by the same code.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 39 +++------------------------------------
 1 file changed, 3 insertions(+), 36 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index bfdd66dd3766..fafee9251d65 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1965,17 +1965,10 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 		return -EINVAL;
 
 	/*
-	 * Some devices don't support bulk write, for
-	 * them we have a series of single write operations in the first two if
-	 * blocks.
-	 *
-	 * The first if block is used for memory mapped io. It does not allow
-	 * val_bytes of 3 for example.
-	 * The second one is for busses that do not provide raw I/O.
-	 * The third one is used for busses which do not have these limitations
-	 * and can write arbitrary value lengths.
+	 * Some devices don't support bulk write, for them we have a series of
+	 * single write operations.
 	 */
-	if (!map->bus) {
+	if (!map->bus || !map->format.parse_inplace) {
 		map->lock(map->lock_arg);
 		for (i = 0; i < val_count; i++) {
 			unsigned int ival;
@@ -2008,32 +2001,6 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 		}
 out:
 		map->unlock(map->lock_arg);
-	} else if (map->bus && !map->format.parse_inplace) {
-		const u8 *u8 = val;
-		const u16 *u16 = val;
-		const u32 *u32 = val;
-		unsigned int ival;
-
-		for (i = 0; i < val_count; i++) {
-			switch (map->format.val_bytes) {
-			case 4:
-				ival = u32[i];
-				break;
-			case 2:
-				ival = u16[i];
-				break;
-			case 1:
-				ival = u8[i];
-				break;
-			default:
-				return -EINVAL;
-			}
-
-			ret = regmap_write(map, reg + regmap_get_offset(map, i),
-					   ival);
-			if (ret)
-				return ret;
-		}
 	} else {
 		void *wval;
 
-- 
2.16.1
