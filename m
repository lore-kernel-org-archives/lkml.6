Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932418AbeBVM7U (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 07:59:20 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:60836 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753815AbeBVM7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 07:59:17 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 5/5] regmap: Merge redundant handling in regmap_bulk_write
Date: Thu, 22 Feb 2018 12:59:14 +0000
Message-ID: <20180222125914.17016-5-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180222125914.17016-1-ckeepax@opensource.cirrus.com>
References: <20180222125914.17016-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=871 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1802220164
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The handling for the first two cases in regmap_bulk_write is
essentially identical. The first case is just a better implementation of
the second, supporting 8 byte registers and doing the locking manually to
avoid bouncing the lock for each register. Drop some redundant code by
removing the second of these cases and allowing both situations to be
handled by the same code.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/base/regmap/regmap.c | 39 +++------------------------------------
 1 file changed, 3 insertions(+), 36 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 6809b33d6ab1..3bc84885eb91 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1967,17 +1967,10 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
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
@@ -2010,32 +2003,6 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
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
2.11.0
