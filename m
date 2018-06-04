Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752685AbeFDL56 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 07:57:58 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:39766 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752635AbeFDL5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 07:57:55 -0400
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <lee.jones@linaro.org>
CC: <andy.shevchenko@gmail.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] mfd: arizona: Don't use regmap_read_poll_timeout
Date: Mon, 4 Jun 2018 12:57:50 +0100
Message-ID: <20180604115750.6126-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1805220000
 definitions=main-1806040144
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Arizona CODECs have a small timing window where they will
NAK an I2C transaction if it happens before the boot done bit is
set. This can cause the read of the register containing the boot
done bit to fail until it is set. Since regmap_read_poll_timeout
will abort polling if a read fails it can't be reliably used to
poll the boot done bit over I2C.

Do a partial revert of ef84f885e037 ("mfd: arizona: Refactor
arizona_poll_reg"), removing the regmap_read_poll_timeout but
leaving the refactoring to make the arizona_poll_reg take more
sensible arguments.

Fixes: ef84f885e037 ("mfd: arizona: Refactor arizona_poll_reg")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v1:
 - Explicitly include ktime header
 - Use USEC_PER_MSEC instead of a constant
 - Refactor the loop to not use a while (true)

Thanks,
Charles

 drivers/mfd/arizona-core.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index 83f1c5a516d99..fe0c151d9d9d7 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -24,6 +24,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/regulator/machine.h>
 #include <linux/slab.h>
+#include <linux/ktime.h>
 #include <linux/platform_device.h>
 
 #include <linux/mfd/arizona/core.h>
@@ -240,18 +241,28 @@ static int arizona_poll_reg(struct arizona *arizona,
 			    int timeout_ms, unsigned int reg,
 			    unsigned int mask, unsigned int target)
 {
+	ktime_t timeout = ktime_add_us(ktime_get(), timeout_ms * USEC_PER_MSEC);
 	unsigned int val = 0;
-	int ret;
+	int ret = regmap_read(arizona->regmap, reg, &val);
 
-	ret = regmap_read_poll_timeout(arizona->regmap,
-				       reg, val, ((val & mask) == target),
-				       ARIZONA_REG_POLL_DELAY_US,
-				       timeout_ms * 1000);
-	if (ret)
-		dev_err(arizona->dev, "Polling reg 0x%x timed out: %x\n",
-			reg, val);
+	while (ktime_compare(ktime_get(), timeout) <= 0) {
+		if ((val & mask) == target)
+			return 0;
 
-	return ret;
+		usleep_range(ARIZONA_REG_POLL_DELAY_US / 2,
+			     ARIZONA_REG_POLL_DELAY_US);
+
+		ret = regmap_read(arizona->regmap, reg, &val);
+	}
+
+	if (ret) {
+		dev_err(arizona->dev, "Failed polling reg 0x%x: %d\n",
+			reg, ret);
+		return ret;
+	}
+
+	dev_err(arizona->dev, "Polling reg 0x%x timed out: %x\n", reg, val);
+	return -ETIMEDOUT;
 }
 
 static int arizona_wait_for_boot(struct arizona *arizona)
-- 
2.11.0
