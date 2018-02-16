Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965838AbeBPMGX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 07:06:23 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42614 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965781AbeBPMGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 07:06:05 -0500
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Applied "regmap: Move the handling for max_raw_read into regmap_raw_read" to the regmap tree
In-Reply-To: <20180215175220.2691-1-ckeepax@opensource.cirrus.com>
Message-Id: <E1emem0-0005C9-T9@debutante>
Date: Fri, 16 Feb 2018 12:05:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: Move the handling for max_raw_read into regmap_raw_read

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

>From 0645ba4331c2b02ba9907b1591ba722535890e9f Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Thu, 15 Feb 2018 17:52:16 +0000
Subject: [PATCH] regmap: Move the handling for max_raw_read into
 regmap_raw_read

Currently regmap_bulk_read will split a read into chunks before
calling regmap_raw_read if max_raw_read is set. It is more logical for
this handling to be inside regmap_raw_read itself, as this removes the
need to keep re-implementing the chunking code, which would be the
same for all users of regmap_raw_read.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 90 +++++++++++++++++---------------------------
 1 file changed, 35 insertions(+), 55 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index f075c05859b0..0cc7387008c9 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2542,18 +2542,45 @@ int regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 
 	if (regmap_volatile_range(map, reg, val_count) || map->cache_bypass ||
 	    map->cache_type == REGCACHE_NONE) {
+		int chunk_stride = map->reg_stride;
+		size_t chunk_size = val_bytes;
+		size_t chunk_count = val_count;
+
 		if (!map->bus->read) {
 			ret = -ENOTSUPP;
 			goto out;
 		}
-		if (map->max_raw_read && map->max_raw_read < val_len) {
-			ret = -E2BIG;
-			goto out;
+
+		if (!map->use_single_read) {
+			if (map->max_raw_read)
+				chunk_size = map->max_raw_read;
+			else
+				chunk_size = val_len;
+			if (chunk_size % val_bytes)
+				chunk_size -= chunk_size % val_bytes;
+			chunk_count = val_len / chunk_size;
+			chunk_stride *= chunk_size / val_bytes;
 		}
 
-		/* Physical block read if there's no cache involved */
-		ret = _regmap_raw_read(map, reg, val, val_len);
+		/* Read bytes that fit into a multiple of chunk_size */
+		for (i = 0; i < chunk_count; i++) {
+			ret = _regmap_raw_read(map,
+					       reg + (i * chunk_stride),
+					       val + (i * chunk_size),
+					       chunk_size);
+			if (ret != 0)
+				return ret;
+		}
 
+		/* Read remaining bytes */
+		if (chunk_size * i < val_len) {
+			ret = _regmap_raw_read(map,
+					       reg + (i * chunk_stride),
+					       val + (i * chunk_size),
+					       val_len - i * chunk_size);
+			if (ret != 0)
+				return ret;
+		}
 	} else {
 		/* Otherwise go word by word for the cache; should be low
 		 * cost as we expect to hit the cache.
@@ -2655,56 +2682,9 @@ int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 		return -EINVAL;
 
 	if (map->bus && map->format.parse_inplace && (vol || map->cache_type == REGCACHE_NONE)) {
-		/*
-		 * Some devices does not support bulk read, for
-		 * them we have a series of single read operations.
-		 */
-		size_t total_size = val_bytes * val_count;
-
-		if (!map->use_single_read &&
-		    (!map->max_raw_read || map->max_raw_read > total_size)) {
-			ret = regmap_raw_read(map, reg, val,
-					      val_bytes * val_count);
-			if (ret != 0)
-				return ret;
-		} else {
-			/*
-			 * Some devices do not support bulk read or do not
-			 * support large bulk reads, for them we have a series
-			 * of read operations.
-			 */
-			int chunk_stride = map->reg_stride;
-			size_t chunk_size = val_bytes;
-			size_t chunk_count = val_count;
-
-			if (!map->use_single_read) {
-				chunk_size = map->max_raw_read;
-				if (chunk_size % val_bytes)
-					chunk_size -= chunk_size % val_bytes;
-				chunk_count = total_size / chunk_size;
-				chunk_stride *= chunk_size / val_bytes;
-			}
-
-			/* Read bytes that fit into a multiple of chunk_size */
-			for (i = 0; i < chunk_count; i++) {
-				ret = regmap_raw_read(map,
-						      reg + (i * chunk_stride),
-						      val + (i * chunk_size),
-						      chunk_size);
-				if (ret != 0)
-					return ret;
-			}
-
-			/* Read remaining bytes */
-			if (chunk_size * i < total_size) {
-				ret = regmap_raw_read(map,
-						      reg + (i * chunk_stride),
-						      val + (i * chunk_size),
-						      total_size - i * chunk_size);
-				if (ret != 0)
-					return ret;
-			}
-		}
+		ret = regmap_raw_read(map, reg, val, val_bytes * val_count);
+		if (ret != 0)
+			return ret;
 
 		for (i = 0; i < val_count * val_bytes; i += val_bytes)
 			map->format.parse_inplace(val + i);
-- 
2.16.1
