Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752849AbeBZLSJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 06:18:09 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52214 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752157AbeBZLSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 06:18:02 -0500
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Applied "regmap: Move the handling for max_raw_write into regmap_raw_write" to the regmap tree
In-Reply-To: <20180222125914.17016-3-ckeepax@opensource.cirrus.com>
Message-Id: <E1eqGn9-0005bz-66@debutante>
Date: Mon, 26 Feb 2018 11:17:59 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: Move the handling for max_raw_write into regmap_raw_write

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

>From 7ef2c6b8689a084954cffbd102ee49c2fb72cbd4 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Thu, 22 Feb 2018 12:59:12 +0000
Subject: [PATCH] regmap: Move the handling for max_raw_write into
 regmap_raw_write

Currently regmap_bulk_write will split a write into chunks before
calling regmap_raw_write if max_raw_write is set. It is more logical
for this handling to be inside regmap_raw_write itself, as this
removes the need to keep re-implementing the chunking code, which
would be the same for all users of regmap_raw_write.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 117 ++++++++++++++++++++-----------------------
 1 file changed, 54 insertions(+), 63 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 707b0450ad72..e82ea77849fb 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1438,8 +1438,8 @@ static void regmap_set_work_buf_flag_mask(struct regmap *map, int max_bytes,
 		buf[i] |= (mask >> (8 * i)) & 0xff;
 }
 
-int _regmap_raw_write(struct regmap *map, unsigned int reg,
-		      const void *val, size_t val_len)
+static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
+				  const void *val, size_t val_len)
 {
 	struct regmap_range_node *range;
 	unsigned long flags;
@@ -1490,8 +1490,9 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
 		while (val_num > win_residue) {
 			dev_dbg(map->dev, "Writing window %d/%zu\n",
 				win_residue, val_len / map->format.val_bytes);
-			ret = _regmap_raw_write(map, reg, val, win_residue *
-						map->format.val_bytes);
+			ret = _regmap_raw_write_impl(map, reg, val,
+						     win_residue *
+						     map->format.val_bytes);
 			if (ret != 0)
 				return ret;
 
@@ -1707,11 +1708,11 @@ static int _regmap_bus_raw_write(void *context, unsigned int reg,
 
 	map->format.format_val(map->work_buf + map->format.reg_bytes
 			       + map->format.pad_bytes, val, 0);
-	return _regmap_raw_write(map, reg,
-				 map->work_buf +
-				 map->format.reg_bytes +
-				 map->format.pad_bytes,
-				 map->format.val_bytes);
+	return _regmap_raw_write_impl(map, reg,
+				      map->work_buf +
+				      map->format.reg_bytes +
+				      map->format.pad_bytes,
+				      map->format.val_bytes);
 }
 
 static inline void *_regmap_map_get_context(struct regmap *map)
@@ -1806,6 +1807,49 @@ int regmap_write_async(struct regmap *map, unsigned int reg, unsigned int val)
 }
 EXPORT_SYMBOL_GPL(regmap_write_async);
 
+int _regmap_raw_write(struct regmap *map, unsigned int reg,
+		      const void *val, size_t val_len)
+{
+	size_t val_bytes = map->format.val_bytes;
+	size_t val_count = val_len / val_bytes;
+	int chunk_stride = map->reg_stride;
+	size_t chunk_size = val_bytes;
+	size_t chunk_count = val_count;
+	int ret, i;
+
+	if (!val_count)
+		return -EINVAL;
+
+	if (!map->use_single_write) {
+		if (map->max_raw_write)
+			chunk_size = map->max_raw_write;
+		else
+			chunk_size = val_len;
+		if (chunk_size % val_bytes)
+			chunk_size -= chunk_size % val_bytes;
+		chunk_count = val_len / chunk_size;
+		chunk_stride *= chunk_size / val_bytes;
+	}
+
+	/* Write as many bytes as possible with chunk_size */
+	for (i = 0; i < chunk_count; i++) {
+		ret = _regmap_raw_write_impl(map,
+					     reg + (i * chunk_stride),
+					     val + (i * chunk_size),
+					     chunk_size);
+		if (ret)
+			return ret;
+	}
+
+	/* Write remaining bytes */
+	if (!ret && chunk_size * i < val_len)
+		ret = _regmap_raw_write_impl(map, reg + (i * chunk_stride),
+					     val + (i * chunk_size),
+					     val_len - i * chunk_size);
+
+	return ret;
+}
+
 /**
  * regmap_raw_write() - Write raw values to one or more registers
  *
@@ -1831,8 +1875,6 @@ int regmap_raw_write(struct regmap *map, unsigned int reg,
 		return -EINVAL;
 	if (val_len % map->format.val_bytes)
 		return -EINVAL;
-	if (map->max_raw_write && map->max_raw_write < val_len)
-		return -E2BIG;
 
 	map->lock(map->lock_arg);
 
@@ -1923,7 +1965,6 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 {
 	int ret = 0, i;
 	size_t val_bytes = map->format.val_bytes;
-	size_t total_size = val_bytes * val_count;
 
 	if (!IS_ALIGNED(reg, map->reg_stride))
 		return -EINVAL;
@@ -1998,57 +2039,9 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 			if (ret)
 				return ret;
 		}
-	} else if (map->use_single_write ||
-		   (map->max_raw_write && map->max_raw_write < total_size)) {
-		int chunk_stride = map->reg_stride;
-		size_t chunk_size = val_bytes;
-		size_t chunk_count = val_count;
-		void *wval;
-
-		if (!val_count)
-			return -EINVAL;
-
-		wval = kmemdup(val, val_count * val_bytes, map->alloc_flags);
-		if (!wval)
-			return -ENOMEM;
-
-		for (i = 0; i < val_count * val_bytes; i += val_bytes)
-			map->format.parse_inplace(wval + i);
-
-		if (!map->use_single_write) {
-			chunk_size = map->max_raw_write;
-			if (chunk_size % val_bytes)
-				chunk_size -= chunk_size % val_bytes;
-			chunk_count = total_size / chunk_size;
-			chunk_stride *= chunk_size / val_bytes;
-		}
-
-		map->lock(map->lock_arg);
-		/* Write as many bytes as possible with chunk_size */
-		for (i = 0; i < chunk_count; i++) {
-			ret = _regmap_raw_write(map,
-						reg + (i * chunk_stride),
-						wval + (i * chunk_size),
-						chunk_size);
-			if (ret)
-				break;
-		}
-
-		/* Write remaining bytes */
-		if (!ret && chunk_size * i < total_size) {
-			ret = _regmap_raw_write(map, reg + (i * chunk_stride),
-						wval + (i * chunk_size),
-						total_size - i * chunk_size);
-		}
-		map->unlock(map->lock_arg);
-
-		kfree(wval);
 	} else {
 		void *wval;
 
-		if (!val_count)
-			return -EINVAL;
-
 		wval = kmemdup(val, val_count * val_bytes, map->alloc_flags);
 		if (!wval)
 			return -ENOMEM;
@@ -2056,9 +2049,7 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 		for (i = 0; i < val_count * val_bytes; i += val_bytes)
 			map->format.parse_inplace(wval + i);
 
-		map->lock(map->lock_arg);
-		ret = _regmap_raw_write(map, reg, wval, val_bytes * val_count);
-		map->unlock(map->lock_arg);
+		ret = regmap_raw_write(map, reg, wval, val_bytes * val_count);
 
 		kfree(wval);
 	}
-- 
2.16.1
