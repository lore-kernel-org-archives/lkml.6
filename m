Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965774AbeBPMGC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 07:06:02 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42466 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965644AbeBPMGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 07:06:00 -0500
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Applied "regmap: Tidy up regmap_raw_read chunking code" to the regmap tree
In-Reply-To: <20180215175220.2691-2-ckeepax@opensource.cirrus.com>
Message-Id: <E1emelx-0005B9-Op@debutante>
Date: Fri, 16 Feb 2018 12:05:49 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: Tidy up regmap_raw_read chunking code

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

>From 1b079ca2c2e9a4652051bc4b62a5ef83d59d86bb Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Thu, 15 Feb 2018 17:52:17 +0000
Subject: [PATCH] regmap: Tidy up regmap_raw_read chunking code

Raw reads may need to be split into small chunks if max_raw_read is
set.  Tidy up the code implementing this, the new code is slightly
clearer, slightly shorter and slightly more efficient.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 44 +++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 0cc7387008c9..ff30a9157de5 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2542,44 +2542,38 @@ int regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 
 	if (regmap_volatile_range(map, reg, val_count) || map->cache_bypass ||
 	    map->cache_type == REGCACHE_NONE) {
-		int chunk_stride = map->reg_stride;
-		size_t chunk_size = val_bytes;
-		size_t chunk_count = val_count;
+		size_t chunk_count, chunk_bytes;
+		size_t chunk_regs = val_count;
 
 		if (!map->bus->read) {
 			ret = -ENOTSUPP;
 			goto out;
 		}
 
-		if (!map->use_single_read) {
-			if (map->max_raw_read)
-				chunk_size = map->max_raw_read;
-			else
-				chunk_size = val_len;
-			if (chunk_size % val_bytes)
-				chunk_size -= chunk_size % val_bytes;
-			chunk_count = val_len / chunk_size;
-			chunk_stride *= chunk_size / val_bytes;
-		}
+		if (map->use_single_read)
+			chunk_regs = 1;
+		else if (map->max_raw_read && val_len > map->max_raw_read)
+			chunk_regs = map->max_raw_read / val_bytes;
 
-		/* Read bytes that fit into a multiple of chunk_size */
+		chunk_count = val_count / chunk_regs;
+		chunk_bytes = chunk_regs * val_bytes;
+
+		/* Read bytes that fit into whole chunks */
 		for (i = 0; i < chunk_count; i++) {
-			ret = _regmap_raw_read(map,
-					       reg + (i * chunk_stride),
-					       val + (i * chunk_size),
-					       chunk_size);
+			ret = _regmap_raw_read(map, reg, val, chunk_bytes);
 			if (ret != 0)
-				return ret;
+				goto out;
+
+			reg += regmap_get_offset(map, chunk_regs);
+			val += chunk_bytes;
+			val_len -= chunk_bytes;
 		}
 
 		/* Read remaining bytes */
-		if (chunk_size * i < val_len) {
-			ret = _regmap_raw_read(map,
-					       reg + (i * chunk_stride),
-					       val + (i * chunk_size),
-					       val_len - i * chunk_size);
+		if (val_len) {
+			ret = _regmap_raw_read(map, reg, val, val_len);
 			if (ret != 0)
-				return ret;
+				goto out;
 		}
 	} else {
 		/* Otherwise go word by word for the cache; should be low
-- 
2.16.1
