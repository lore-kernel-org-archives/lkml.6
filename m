Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932498AbeBVM71 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 07:59:27 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:47536 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932199AbeBVM7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 07:59:25 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 1/5] regmap: Format data for raw write in regmap_bulk_write
Date: Thu, 22 Feb 2018 12:59:10 +0000
Message-ID: <20180222125914.17016-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
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

In the case were the bulk transaction is split up into smaller chunks
data is passed directly to regmap_raw_write. However regmap_bulk_write
uses data in host endian and regmap_raw_write expects data in device
endian. As such if the host and device differ in endian the wrong data
will be written to the device. Correct this issue using a similar
approach to the single raw write case below it, duplicate the data
into a new buffer and use parse_inplace to format the data correctly.

Fixes: adaac459759d ("regmap: Introduce max_raw_read/write for regmap_bulk_read/write")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/base/regmap/regmap.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index b38ba6fdecbc..8a6de76f89bb 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2005,6 +2005,17 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 		int chunk_stride = map->reg_stride;
 		size_t chunk_size = val_bytes;
 		size_t chunk_count = val_count;
+		void *wval;
+
+		if (!val_count)
+			return -EINVAL;
+
+		wval = kmemdup(val, val_count * val_bytes, map->alloc_flags);
+		if (!wval)
+			return -ENOMEM;
+
+		for (i = 0; i < val_count * val_bytes; i += val_bytes)
+			map->format.parse_inplace(wval + i);
 
 		if (!map->use_single_write) {
 			chunk_size = map->max_raw_write;
@@ -2019,7 +2030,7 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 		for (i = 0; i < chunk_count; i++) {
 			ret = _regmap_raw_write(map,
 						reg + (i * chunk_stride),
-						val + (i * chunk_size),
+						wval + (i * chunk_size),
 						chunk_size);
 			if (ret)
 				break;
@@ -2028,10 +2039,12 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 		/* Write remaining bytes */
 		if (!ret && chunk_size * i < total_size) {
 			ret = _regmap_raw_write(map, reg + (i * chunk_stride),
-						val + (i * chunk_size),
+						wval + (i * chunk_size),
 						total_size - i * chunk_size);
 		}
 		map->unlock(map->lock_arg);
+
+		kfree(wval);
 	} else {
 		void *wval;
 
-- 
2.11.0
