Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932446AbeBVM7W (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 07:59:22 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:60838 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753816AbeBVM7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 07:59:17 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 4/5] regmap: Tidy up regmap_raw_write chunking code
Date: Thu, 22 Feb 2018 12:59:13 +0000
Message-ID: <20180222125914.17016-4-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180222125914.17016-1-ckeepax@opensource.cirrus.com>
References: <20180222125914.17016-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=836 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1802220164
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Raw writes may need to be split into small chunks if max_raw_write is
set. Tidy up the code implementing this, the new code is slightly
clearer, slightly shorter and slightly more efficient.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/base/regmap/regmap.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index dd17e2e7a3d7..6809b33d6ab1 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1814,40 +1814,35 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
 {
 	size_t val_bytes = map->format.val_bytes;
 	size_t val_count = val_len / val_bytes;
-	int chunk_stride = map->reg_stride;
-	size_t chunk_size = val_bytes;
-	size_t chunk_count = val_count;
+	size_t chunk_count, chunk_bytes;
+	size_t chunk_regs = val_count;
 	int ret, i;
 
 	if (!val_count)
 		return -EINVAL;
 
-	if (!map->use_single_write) {
-		if (map->max_raw_write)
-			chunk_size = map->max_raw_write;
-		else
-			chunk_size = val_len;
-		if (chunk_size % val_bytes)
-			chunk_size -= chunk_size % val_bytes;
-		chunk_count = val_len / chunk_size;
-		chunk_stride *= chunk_size / val_bytes;
-	}
+	if (map->use_single_write)
+		chunk_regs = 1;
+	else if (map->max_raw_write && val_len > map->max_raw_write)
+		chunk_regs = map->max_raw_write / val_bytes;
+
+	chunk_count = val_count / chunk_regs;
+	chunk_bytes = chunk_regs * val_bytes;
 
 	/* Write as many bytes as possible with chunk_size */
 	for (i = 0; i < chunk_count; i++) {
-		ret = _regmap_raw_write_impl(map,
-					     reg + (i * chunk_stride),
-					     val + (i * chunk_size),
-					     chunk_size);
+		ret = _regmap_raw_write_impl(map, reg, val, chunk_bytes);
 		if (ret)
 			return ret;
+
+		reg += regmap_get_offset(map, chunk_regs);
+		val += chunk_bytes;
+		val_len -= chunk_bytes;
 	}
 
 	/* Write remaining bytes */
-	if (!ret && chunk_size * i < val_len)
-		ret = _regmap_raw_write_impl(map, reg + (i * chunk_stride),
-					     val + (i * chunk_size),
-					     val_len - i * chunk_size);
+	if (val_len)
+		ret = _regmap_raw_write_impl(map, reg, val, val_len);
 
 	return ret;
 }
-- 
2.11.0
