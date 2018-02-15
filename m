Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165883AbeBORxk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 12:53:40 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:60702 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1165814AbeBORwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 12:52:54 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 1/5] regmap: Move the handling for max_raw_read into regmap_raw_read
Date: Thu, 15 Feb 2018 17:52:16 +0000
Message-ID: <20180215175220.2691-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1802150215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently regmap_bulk_read will split a read into chunks before
calling regmap_raw_read if max_raw_read is set. It is more logical for
this handling to be inside regmap_raw_read itself, as this removes the
need to keep re-implementing the chunking code, which would be the
same for all users of regmap_raw_read.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/base/regmap/regmap.c | 90 +++++++++++++++++---------------------------
 1 file changed, 35 insertions(+), 55 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 6342eaefc218..f78ddaa9a1e8 100644
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
2.11.0
