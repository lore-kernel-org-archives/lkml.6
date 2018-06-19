Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DB1C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815442083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:33:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 815442083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757081AbeFSJdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:33:09 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:46926 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1757052AbeFSJdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:33:07 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5J9UIMV016142;
        Tue, 19 Jun 2018 04:32:47 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2jmyy2cr97-1;
        Tue, 19 Jun 2018 04:32:47 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id C0892611C8A7;
        Tue, 19 Jun 2018 04:32:46 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.301.0; Tue, 19 Jun 2018
 10:32:46 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id w5J9Wjlr021206; Tue,
 19 Jun 2018 10:32:45 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>, <hias@horus.com>
CC:     <lgirdwood@gmail.com>, <linus.walleij@linaro.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] regulator: arizona-ldo1: Use correct device to get enable GPIO
Date:   Tue, 19 Jun 2018 10:32:45 +0100
Message-ID: <20180619093245.1261-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=830 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1805220000
 definitions=main-1806190109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the enable GPIO is being looked up on the regulator
device itself but that does not have its own DT node, this causes
the lookup to fail and the regulator not to get its GPIO. The DT
node is shared across the whole MFD and as such the lookup needs
to happen on that parent device. Moving the lookup to the parent
device also means devres can no longer be used as the life time
would attach to the wrong device.

Fixes: e1739e86f0cb ("regulator: arizona-ldo1: Look up a descriptor and pass to the core")
Reported-by: Matthias Reichl <hias@horus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Apologies for missing this again, we should have caught
this in our testing and thanks for reporting it.

Thanks,
Charles

 drivers/regulator/arizona-ldo1.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index f6d6a4ad9e8a..a981896c056a 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -36,6 +36,8 @@ struct arizona_ldo1 {
 
 	struct regulator_consumer_supply supply;
 	struct regulator_init_data init_data;
+
+	struct gpio_desc *ena_gpiod;
 };
 
 static int arizona_ldo1_hc_list_voltage(struct regulator_dev *rdev,
@@ -253,12 +255,17 @@ static int arizona_ldo1_common_init(struct platform_device *pdev,
 		}
 	}
 
-	/* We assume that high output = regulator off */
-	config.ena_gpiod = devm_gpiod_get_optional(&pdev->dev, "wlf,ldoena",
-						   GPIOD_OUT_HIGH);
+	/* We assume that high output = regulator off
+	 * Don't use devm, since we need to get against the parent device
+	 * so clean up would happen at the wrong time
+	 */
+	config.ena_gpiod = gpiod_get_optional(parent_dev, "wlf,ldoena",
+					      GPIOD_OUT_HIGH);
 	if (IS_ERR(config.ena_gpiod))
 		return PTR_ERR(config.ena_gpiod);
 
+	ldo1->ena_gpiod = config.ena_gpiod;
+
 	if (pdata->init_data)
 		config.init_data = pdata->init_data;
 	else
@@ -276,6 +283,9 @@ static int arizona_ldo1_common_init(struct platform_device *pdev,
 	of_node_put(config.of_node);
 
 	if (IS_ERR(ldo1->regulator)) {
+		if (config.ena_gpiod)
+			gpiod_put(config.ena_gpiod);
+
 		ret = PTR_ERR(ldo1->regulator);
 		dev_err(&pdev->dev, "Failed to register LDO1 supply: %d\n",
 			ret);
@@ -334,8 +344,19 @@ static int arizona_ldo1_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int arizona_ldo1_remove(struct platform_device *pdev)
+{
+	struct arizona_ldo1 *ldo1 = platform_get_drvdata(pdev);
+
+	if (ldo1->ena_gpiod)
+		gpiod_put(ldo1->ena_gpiod);
+
+	return 0;
+}
+
 static struct platform_driver arizona_ldo1_driver = {
 	.probe = arizona_ldo1_probe,
+	.remove = arizona_ldo1_remove,
 	.driver		= {
 		.name	= "arizona-ldo1",
 	},
-- 
2.11.0

