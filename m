Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932393AbeBVM7T (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 07:59:19 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:60840 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753811AbeBVM7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 07:59:17 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 3/5] regmap: Move the handling for max_raw_write into regmap_raw_write
Date: Thu, 22 Feb 2018 12:59:12 +0000
Message-ID: <20180222125914.17016-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180222125914.17016-1-ckeepax@opensource.cirrus.com>
References: <20180222125914.17016-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1802220164
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently regmap_bulk_write will split a write into chunks before
calling regmap_raw_write if max_raw_write is set. It is more logical
for this handling to be inside regmap_raw_write itself, as this
removes the need to keep re-implementing the chunking code, which
would be the same for all users of regmap_raw_write.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/base/regmap/regmap.c | 117 ++++++++++++++++++++-----------------------
 1 file changed, 54 insertions(+), 63 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index c84c4d5d2df7..dd17e2e7a3d7 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1440,8 +1440,8 @@ static void regmap_set_work_buf_flag_mask(struct regmap *map, int max_bytes,
 		buf[i] |= (mask >> (8 * i)) & 0xff;
 }
 
-int _regmap_raw_write(struct regmap *map, unsigned int reg,
-		      const void *val, size_t val_len)
+static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
+				  const void *val, size_t val_len)
 {
 	struct regmap_range_node *range;
 	unsigned long flags;
@@ -1492,8 +1492,9 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
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
 
@@ -1709,11 +1710,11 @@ static int _regmap_bus_raw_write(void *context, unsigned int reg,
 
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
@@ -1808,6 +1809,49 @@ int regmap_write_async(struct regmap *map, unsigned int reg, unsigned int val)
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
@@ -1833,8 +1877,6 @@ int regmap_raw_write(struct regmap *map, unsigned int reg,
 		return -EINVAL;
 	if (val_len % map->format.val_bytes)
 		return -EINVAL;
-	if (map->max_raw_write && map->max_raw_write < val_len)
-		return -E2BIG;
 
 	map->lock(map->lock_arg);
 
@@ -1925,7 +1967,6 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 {
 	int ret = 0, i;
 	size_t val_bytes = map->format.val_bytes;
-	size_t total_size = val_bytes * val_count;
 
 	if (!IS_ALIGNED(reg, map->reg_stride))
 		return -EINVAL;
@@ -2000,57 +2041,9 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
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
@@ -2058,9 +2051,7 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 		for (i = 0; i < val_count * val_bytes; i += val_bytes)
 			map->format.parse_inplace(wval + i);
 
-		map->lock(map->lock_arg);
-		ret = _regmap_raw_write(map, reg, wval, val_bytes * val_count);
-		map->unlock(map->lock_arg);
+		ret = regmap_raw_write(map, reg, wval, val_bytes * val_count);
 
 		kfree(wval);
 	}
-- 
2.11.0
