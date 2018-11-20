Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDD1C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2596120685
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2596120685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbeKUDcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:32:10 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:53200 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726281AbeKUDcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:32:10 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAKGxTe9014706;
        Tue, 20 Nov 2018 11:01:54 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2nth984pd4-1;
        Tue, 20 Nov 2018 11:01:54 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id 6B1D9611E125;
        Tue, 20 Nov 2018 11:01:53 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Tue, 20 Nov 2018
 17:01:52 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wAKH1qfH008270; Tue,
 20 Nov 2018 17:01:52 GMT
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <linus.walleij@linaro.org>, <lgirdwood@gmail.com>,
        <m.szyprowski@samsung.com>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH] regulator: wm8994: Don't use devres for enable GPIOs
Date:   Tue, 20 Nov 2018 17:01:52 +0000
Message-ID: <20181120170152.24652-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=816 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1811200151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to manage the life time of the enable GPIO against the regulator
device but the OF node lives on the parent MFD device. As such we can't
use the devm functions which assume the same device will be used for
both.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

This patch is only build tested so it would be good to get a
tested by from Marek before applying.

Thanks,
Charles

 drivers/regulator/wm8994-regulator.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/wm8994-regulator.c b/drivers/regulator/wm8994-regulator.c
index d7fec533c403..f2592c30d0ca 100644
--- a/drivers/regulator/wm8994-regulator.c
+++ b/drivers/regulator/wm8994-regulator.c
@@ -31,6 +31,7 @@ struct wm8994_ldo {
 	struct wm8994 *wm8994;
 	struct regulator_consumer_supply supply;
 	struct regulator_init_data init_data;
+	struct gpio_desc *ena_gpiod;
 };
 
 #define WM8994_LDO1_MAX_SELECTOR 0x7
@@ -147,14 +148,19 @@ static int wm8994_ldo_probe(struct platform_device *pdev)
 	config.regmap = wm8994->regmap;
 	config.init_data = &ldo->init_data;
 
-	/* Look up LDO enable GPIO from the parent device node */
-	gpiod = devm_gpiod_get_optional(pdev->dev.parent,
-					id ? "wlf,ldo2ena" : "wlf,ldo1ena",
-					GPIOD_OUT_LOW |
-					GPIOD_FLAGS_BIT_NONEXCLUSIVE);
+	/*
+	 * Look up LDO enable GPIO from the parent device node, we can't
+	 * use devm because it assumes the device we want to allocate
+	 * against is the same one that holds the OF node
+	 */
+	gpiod = gpiod_get_optional(pdev->dev.parent,
+				   id ? "wlf,ldo2ena" : "wlf,ldo1ena",
+				   GPIOD_OUT_LOW |
+				   GPIOD_FLAGS_BIT_NONEXCLUSIVE);
 	if (IS_ERR(gpiod))
 		return PTR_ERR(gpiod);
 	config.ena_gpiod = gpiod;
+	ldo->ena_gpiod = gpiod;
 
 	/* Use default constraints if none set up */
 	if (!pdata || !pdata->ldo[id].init_data || wm8994->dev->of_node) {
@@ -184,11 +190,23 @@ static int wm8994_ldo_probe(struct platform_device *pdev)
 	return 0;
 
 err:
+	gpiod_put(gpiod);
 	return ret;
 }
 
+static int wm8994_ldo_remove(struct platform_device *pdev)
+{
+	struct wm8994_ldo *ldo = platform_get_drvdata(pdev);
+
+	if (ldo->ena_gpiod)
+		gpiod_put(ldo->ena_gpiod);
+
+	return 0;
+}
+
 static struct platform_driver wm8994_ldo_driver = {
 	.probe = wm8994_ldo_probe,
+	.remove = wm8994_ldo_remove,
 	.driver		= {
 		.name	= "wm8994-ldo",
 	},
-- 
2.11.0

