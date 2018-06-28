Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8831CC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE1923C4D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE1923C4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030250AbeF1Ptn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:49:43 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:44060 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752028AbeF1Ptm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:49:42 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5SFmu3e013159;
        Thu, 28 Jun 2018 10:49:37 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0a-001ae601.pphosted.com with ESMTP id 2ju89dm9jp-1;
        Thu, 28 Jun 2018 10:49:36 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id 1499F611C8A7;
        Thu, 28 Jun 2018 10:50:39 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.301.0; Thu, 28 Jun 2018
 16:49:36 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id w5SFnZwf019089; Thu,
 28 Jun 2018 16:49:35 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <andy.shevchenko@gmail.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] mfd: arizona: Don't use regmap_read_poll_timeout
Date:   Thu, 28 Jun 2018 16:49:35 +0100
Message-ID: <20180628154935.31049-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1806210000
 definitions=main-1806280179
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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

Changes since v2:
 - Refactor to remove initialisation of ret variable

Thanks,
Charles

 drivers/mfd/arizona-core.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index 83f1c5a516d99..5f1e37d23943a 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -24,6 +24,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/regulator/machine.h>
 #include <linux/slab.h>
+#include <linux/ktime.h>
 #include <linux/platform_device.h>
 
 #include <linux/mfd/arizona/core.h>
@@ -236,22 +237,39 @@ static irqreturn_t arizona_overclocked(int irq, void *data)
 
 #define ARIZONA_REG_POLL_DELAY_US 7500
 
+static inline bool arizona_poll_reg_delay(ktime_t timeout)
+{
+	if (ktime_compare(ktime_get(), timeout) > 0)
+		return false;
+
+	usleep_range(ARIZONA_REG_POLL_DELAY_US / 2, ARIZONA_REG_POLL_DELAY_US);
+
+	return true;
+}
+
 static int arizona_poll_reg(struct arizona *arizona,
 			    int timeout_ms, unsigned int reg,
 			    unsigned int mask, unsigned int target)
 {
+	ktime_t timeout = ktime_add_us(ktime_get(), timeout_ms * USEC_PER_MSEC);
 	unsigned int val = 0;
 	int ret;
 
-	ret = regmap_read_poll_timeout(arizona->regmap,
-				       reg, val, ((val & mask) == target),
-				       ARIZONA_REG_POLL_DELAY_US,
-				       timeout_ms * 1000);
-	if (ret)
-		dev_err(arizona->dev, "Polling reg 0x%x timed out: %x\n",
-			reg, val);
+	do {
+		ret = regmap_read(arizona->regmap, reg, &val);
 
-	return ret;
+		if ((val & mask) == target)
+			return 0;
+	} while (arizona_poll_reg_delay(timeout));
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

