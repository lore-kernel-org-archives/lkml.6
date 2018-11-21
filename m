Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D64C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4DE20989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C4DE20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbeKUUrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:47:13 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:37048 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726016AbeKUUrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:47:13 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wALA9eXa004613;
        Wed, 21 Nov 2018 04:13:19 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0a-001ae601.pphosted.com with ESMTP id 2nth986mfx-1;
        Wed, 21 Nov 2018 04:13:18 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id 99D9A611C8BB;
        Wed, 21 Nov 2018 04:16:41 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Wed, 21 Nov 2018
 10:13:17 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wALADGkx014959; Wed,
 21 Nov 2018 10:13:16 GMT
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <linus.walleij@linaro.org>, <lgirdwood@gmail.com>,
        <m.szyprowski@samsung.com>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2] regulator: wm8994: Don't use devres for enable GPIOs
Date:   Wed, 21 Nov 2018 10:13:16 +0000
Message-ID: <20181121101316.32194-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=861 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1811210093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regulator core takes over managing the lifetime of the enable GPIO
once the regulator is registered. As such we shouldn't register the
enable GPIO using devm, or it will be freed twice.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Again only build tested.

Thanks,
Charles

 drivers/regulator/wm8994-regulator.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/wm8994-regulator.c b/drivers/regulator/wm8994-regulator.c
index d7fec533c4032..46e6b4ee1491a 100644
--- a/drivers/regulator/wm8994-regulator.c
+++ b/drivers/regulator/wm8994-regulator.c
@@ -147,11 +147,14 @@ static int wm8994_ldo_probe(struct platform_device *pdev)
 	config.regmap = wm8994->regmap;
 	config.init_data = &ldo->init_data;
 
-	/* Look up LDO enable GPIO from the parent device node */
-	gpiod = devm_gpiod_get_optional(pdev->dev.parent,
-					id ? "wlf,ldo2ena" : "wlf,ldo1ena",
-					GPIOD_OUT_LOW |
-					GPIOD_FLAGS_BIT_NONEXCLUSIVE);
+	/*
+	 * Look up LDO enable GPIO from the parent device node, we don't
+	 * use devm because the regulator core will free the GPIO
+	 */
+	gpiod = gpiod_get_optional(pdev->dev.parent,
+				   id ? "wlf,ldo2ena" : "wlf,ldo1ena",
+				   GPIOD_OUT_LOW |
+				   GPIOD_FLAGS_BIT_NONEXCLUSIVE);
 	if (IS_ERR(gpiod))
 		return PTR_ERR(gpiod);
 	config.ena_gpiod = gpiod;
@@ -184,6 +187,7 @@ static int wm8994_ldo_probe(struct platform_device *pdev)
 	return 0;
 
 err:
+	gpiod_put(gpiod);
 	return ret;
 }
 
-- 
2.11.0

