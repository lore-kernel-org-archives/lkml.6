Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753453AbeBLSPw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 13:15:52 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:46512 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752331AbeBLSPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 13:15:51 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <david.rhodes@cirrus.com>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 3/4] regmap: Don't use format_val in regmap_bulk_read
Date: Mon, 12 Feb 2018 18:15:46 +0000
Message-ID: <20180212181547.2415-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180212181547.2415-1-ckeepax@opensource.cirrus.com>
References: <20180212181547.2415-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=795 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1802120234
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A bulk read can be implemented either through regmap_raw_read, or
by reading each register individually using regmap_read.  Both
regmap_read and regmap_bulk_read should return values in native
endian. In the individual case the current implementation calls
format_val to put the data into the output array, which can cause
endian issues. The regmap_read will have already converted the data
into native endian, if the hosts endian differs from the device then
format_val will switch the endian back again.

Rather than using format_val simply use the code that is called if
there is no format_val function. This code supports all cases except
24-bit but there don't appear to be any users of regmap_bulk_read for
24-bit. Additionally, it would have to be a big endian host for the
old code to actually function correctly anyway.

Fixes: 15b8d2c41fe5 ("regmap: Fix regmap_bulk_read in BE mode")
Reported-by: David Rhodes <david.rhodes@cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/base/regmap/regmap.c | 55 ++++++++++++++++++--------------------------
 1 file changed, 23 insertions(+), 32 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 2339b98f1b6e4..8594b02aa3e67 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2709,47 +2709,38 @@ int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 		for (i = 0; i < val_count * val_bytes; i += val_bytes)
 			map->format.parse_inplace(val + i);
 	} else {
+#ifdef CONFIG_64BIT
+		u64 *u64 = val;
+#endif
+		u32 *u32 = val;
+		u16 *u16 = val;
+		u8 *u8 = val;
+
 		for (i = 0; i < val_count; i++) {
 			unsigned int ival;
+
 			ret = regmap_read(map, reg + regmap_get_offset(map, i),
 					  &ival);
 			if (ret != 0)
 				return ret;
 
-			if (map->format.format_val) {
-				map->format.format_val(val + (i * val_bytes), ival, 0);
-			} else {
-				/* Devices providing read and write
-				 * operations can use the bulk I/O
-				 * functions if they define a val_bytes,
-				 * we assume that the values are native
-				 * endian.
-				 */
-#ifdef CONFIG_64BIT
-				u64 *u64 = val;
-#endif
-				u32 *u32 = val;
-				u16 *u16 = val;
-				u8 *u8 = val;
-
-				switch (map->format.val_bytes) {
+			switch (map->format.val_bytes) {
 #ifdef CONFIG_64BIT
-				case 8:
-					u64[i] = ival;
-					break;
+			case 8:
+				u64[i] = ival;
+				break;
 #endif
-				case 4:
-					u32[i] = ival;
-					break;
-				case 2:
-					u16[i] = ival;
-					break;
-				case 1:
-					u8[i] = ival;
-					break;
-				default:
-					return -EINVAL;
-				}
+			case 4:
+				u32[i] = ival;
+				break;
+			case 2:
+				u16[i] = ival;
+				break;
+			case 1:
+				u8[i] = ival;
+				break;
+			default:
+				return -EINVAL;
 			}
 		}
 	}
-- 
2.11.0
