Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1763C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B59FC20824
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B59FC20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406388AbeKWEKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 23:10:43 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:50774 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406345AbeKWEKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 23:10:42 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAMHODan012430;
        Thu, 22 Nov 2018 11:30:18 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0a-001ae601.pphosted.com with ESMTP id 2nth9891d6-1;
        Thu, 22 Nov 2018 11:30:17 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id B1B3D611CE61;
        Thu, 22 Nov 2018 11:33:41 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Thu, 22 Nov 2018
 17:30:16 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wAMHUFt6029517; Thu,
 22 Nov 2018 17:30:16 GMT
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <linus.walleij@linaro.org>, <lgirdwood@gmail.com>,
        <m.szyprowski@samsung.com>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 2/3] regulator: Only free GPIOs if the core requested them
Date:   Thu, 22 Nov 2018 17:30:14 +0000
Message-ID: <20181122173015.23905-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181122173015.23905-1-ckeepax@opensource.cirrus.com>
References: <20181122173015.23905-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1811220155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the regulator core will take ownership of any GPIO passed
into it. Makes end driver code fairly error prone as the normal devm_
patterns of allocation don't work. Update the regulator core to only
free the GPIO if it requested it, this allows the drivers to manage the
GPIO lifetime as they normally would.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/regulator/core.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index dbe2f2e6e6254..9da7d27c7145e 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -83,6 +83,7 @@ struct regulator_enable_gpio {
 	u32 enable_count;	/* a number of enabled shared GPIO */
 	u32 request_count;	/* a number of requested shared GPIO */
 	unsigned int ena_gpio_invert:1;
+	unsigned int locally_requested:1;
 };
 
 /*
@@ -2233,19 +2234,20 @@ static int regulator_ena_gpio_request(struct regulator_dev *rdev,
 		}
 	}
 
+	pin = kzalloc(sizeof(struct regulator_enable_gpio), GFP_KERNEL);
+	if (pin == NULL)
+		return -ENOMEM;
+
 	if (!config->ena_gpiod) {
 		ret = gpio_request_one(config->ena_gpio,
 				       GPIOF_DIR_OUT | config->ena_gpio_flags,
 				       rdev_get_name(rdev));
-		if (ret)
+		if (ret) {
+			kfree(pin);
 			return ret;
-	}
+		}
 
-	pin = kzalloc(sizeof(struct regulator_enable_gpio), GFP_KERNEL);
-	if (pin == NULL) {
-		if (!config->ena_gpiod)
-			gpio_free(config->ena_gpio);
-		return -ENOMEM;
+		pin->locally_requested = 1;
 	}
 
 	pin->gpiod = gpiod;
@@ -2270,7 +2272,8 @@ static void regulator_ena_gpio_free(struct regulator_dev *rdev)
 		if (pin->gpiod == rdev->ena_pin->gpiod) {
 			if (pin->request_count <= 1) {
 				pin->request_count = 0;
-				gpiod_put(pin->gpiod);
+				if (pin->locally_requested)
+					gpiod_put(pin->gpiod);
 				list_del(&pin->list);
 				kfree(pin);
 				rdev->ena_pin = NULL;
-- 
2.11.0

