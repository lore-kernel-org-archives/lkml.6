Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165869AbeBORxi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 12:53:38 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:60706 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1165816AbeBORwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 12:52:54 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 3/5] regmap: Use _regmap_read in regmap_bulk_read
Date: Thu, 15 Feb 2018 17:52:18 +0000
Message-ID: <20180215175220.2691-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180215175220.2691-1-ckeepax@opensource.cirrus.com>
References: <20180215175220.2691-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=870 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1802150215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bulk reads may potentially read a lot of registers and regmap_read will
take and release the regmap lock for each register. Avoid bouncing
the lock so frequently by holding the lock locally and calling
_regmap_read instead. This also has the nice side-effect that all the
reads will be done atomically so no other threads can sneak a write in
during the regmap_bulk_read.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/base/regmap/regmap.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 93d4218c5569..872be065e3fe 100644
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
2.11.0
