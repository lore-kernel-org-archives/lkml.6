Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41664C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17F6206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:17:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F17F6206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbeKUAqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:46:05 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:37858 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725995AbeKUAqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:46:04 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAKEEHBi030453;
        Tue, 20 Nov 2018 08:16:35 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2nth984dqk-1;
        Tue, 20 Nov 2018 08:16:34 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id CEC07611E126;
        Tue, 20 Nov 2018 08:16:33 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Tue, 20 Nov 2018
 14:16:32 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wAKEGVqu000703; Tue,
 20 Nov 2018 14:16:32 GMT
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <broonie@kernel.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>
CC:     <mark.rutland@arm.com>, <lgirdwood@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
Subject: [PATCH v5 1/8] regulator: lochnagar: Move driver to binding from DT
Date:   Tue, 20 Nov 2018 14:16:24 +0000
Message-ID: <20181120141631.18949-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=981 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1811200128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on review comments on the MFD driver, move the child drivers for
the Lochnagar MFD over to binding through device tree.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v4:
 - Split out regulator binding for each regulator

Thanks,
Charles

 drivers/regulator/lochnagar-regulator.c | 48 +++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/lochnagar-regulator.c b/drivers/regulator/lochnagar-regulator.c
index 182198246479..5a89e6d4b9a6 100644
--- a/drivers/regulator/lochnagar-regulator.c
+++ b/drivers/regulator/lochnagar-regulator.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
@@ -214,28 +215,52 @@ static const struct regulator_desc lochnagar_regulators[] = {
 	},
 };
 
+static const struct of_device_id lochnagar_of_match[] = {
+	{
+		.compatible = "cirrus,lochnagar2-micvdd",
+		.data = &lochnagar_regulators[LOCHNAGAR_MICVDD],
+	},
+	{
+		.compatible = "cirrus,lochnagar2-mic1vdd",
+		.data = &lochnagar_regulators[LOCHNAGAR_MIC1VDD],
+	},
+	{
+		.compatible = "cirrus,lochnagar2-mic2vdd",
+		.data = &lochnagar_regulators[LOCHNAGAR_MIC1VDD],
+	},
+	{
+		.compatible = "cirrus,lochnagar2-vddcore",
+		.data = &lochnagar_regulators[LOCHNAGAR_VDDCORE],
+	},
+	{},
+};
+
 static int lochnagar_regulator_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct lochnagar *lochnagar = dev_get_drvdata(dev->parent);
 	struct regulator_config config = { };
+	const struct of_device_id *of_id;
+	const struct regulator_desc *desc;
 	struct regulator_dev *rdev;
-	int ret, i;
+	int ret;
 
-	config.dev = lochnagar->dev;
+	config.dev = dev;
 	config.regmap = lochnagar->regmap;
 	config.driver_data = lochnagar;
 
-	for (i = 0; i < ARRAY_SIZE(lochnagar_regulators); i++) {
-		const struct regulator_desc *desc = &lochnagar_regulators[i];
+	of_id = of_match_device(lochnagar_of_match, dev);
+	if (!of_id)
+		return -EINVAL;
 
-		rdev = devm_regulator_register(dev, desc, &config);
-		if (IS_ERR(rdev)) {
-			ret = PTR_ERR(rdev);
-			dev_err(dev, "Failed to register %s regulator: %d\n",
-				desc->name, ret);
-			return ret;
-		}
+	desc = of_id->data;
+
+	rdev = devm_regulator_register(dev, desc, &config);
+	if (IS_ERR(rdev)) {
+		ret = PTR_ERR(rdev);
+		dev_err(dev, "Failed to register %s regulator: %d\n",
+			desc->name, ret);
+		return ret;
 	}
 
 	return 0;
@@ -244,6 +269,7 @@ static int lochnagar_regulator_probe(struct platform_device *pdev)
 static struct platform_driver lochnagar_regulator_driver = {
 	.driver = {
 		.name = "lochnagar-regulator",
+		.of_match_table = of_match_ptr(lochnagar_of_match),
 	},
 
 	.probe = lochnagar_regulator_probe,
-- 
2.11.0

