Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753823AbeBLSPz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 13:15:55 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:46514 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752697AbeBLSPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 13:15:51 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <david.rhodes@cirrus.com>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 2/4] regmap: Correct offset handling in regmap_volatile_range
Date: Mon, 12 Feb 2018 18:15:45 +0000
Message-ID: <20180212181547.2415-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180212181547.2415-1-ckeepax@opensource.cirrus.com>
References: <20180212181547.2415-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=809 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1802120234
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation is broken for regmaps that have a reg_stride,
since it doesn't take the stride into account. Correct this by using the
helper function to calculate the register offset.

Fixes: f01ee60fffa4 ("regmap: implement register striding")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/base/regmap/regmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index c7b7c5fa73ab4..2339b98f1b6e4 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -174,7 +174,7 @@ static bool regmap_volatile_range(struct regmap *map, unsigned int reg,
 	unsigned int i;
 
 	for (i = 0; i < num; i++)
-		if (!regmap_volatile(map, reg + i))
+		if (!regmap_volatile(map, reg + regmap_get_offset(map, i)))
 			return false;
 
 	return true;
-- 
2.11.0
