Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3ACC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E417920824
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E417920824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406364AbeKWEKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 23:10:42 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:50770 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404220AbeKWEKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 23:10:41 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAMHPDF2012957;
        Thu, 22 Nov 2018 11:30:17 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0a-001ae601.pphosted.com with ESMTP id 2nth9891d5-1;
        Thu, 22 Nov 2018 11:30:17 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id A7509611CE60;
        Thu, 22 Nov 2018 11:33:41 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Thu, 22 Nov 2018
 17:30:16 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wAMHUFt7029517; Thu,
 22 Nov 2018 17:30:16 GMT
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <linus.walleij@linaro.org>, <lgirdwood@gmail.com>,
        <m.szyprowski@samsung.com>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 3/3] gpio: Add reference counting for non-exclusive GPIOs
Date:   Thu, 22 Nov 2018 17:30:15 +0000
Message-ID: <20181122173015.23905-3-ckeepax@opensource.cirrus.com>
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

Currently, a GPIO can be requested multiple times when the
NONEXCLUSIVE flag is set, however it must still be freed a single
time. This makes client code rather complex, since multiple drivers
may request the GPIO but only a single one can free it. Rather than
manually handling this in each driver add some basic reference
counting into the core.  Currently, this is fairly primitive but
so is the support for the NONEXCLUSIVE flag and the implementation
covers those use-cases.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/gpio/gpiolib.c | 13 ++++++++++++-
 drivers/gpio/gpiolib.h |  2 ++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 230e41562462b..42ba86fb495a5 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2407,6 +2407,13 @@ static bool gpiod_free_commit(struct gpio_desc *desc)
 
 	might_sleep();
 
+	if (desc->n_users > 1) {
+		desc->n_users--;
+		return true;
+	} else {
+		desc->n_users = 0;
+	}
+
 	gpiod_unexport(desc);
 
 	spin_lock_irqsave(&gpio_lock, flags);
@@ -4142,7 +4149,8 @@ struct gpio_desc *__must_check gpiod_get_index(struct device *dev,
 			 */
 			dev_info(dev, "nonexclusive access to GPIO for %s\n",
 				 con_id ? con_id : devname);
-			return desc;
+
+			goto done;
 		} else {
 			return ERR_PTR(status);
 		}
@@ -4155,6 +4163,9 @@ struct gpio_desc *__must_check gpiod_get_index(struct device *dev,
 		return ERR_PTR(status);
 	}
 
+done:
+	desc->n_users++;
+
 	return desc;
 }
 EXPORT_SYMBOL_GPL(gpiod_get_index);
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 087d865286a0c..f96eda90281a3 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -230,6 +230,8 @@ struct gpio_desc {
 	const char		*label;
 	/* Name of the GPIO */
 	const char		*name;
+
+	unsigned int		n_users;
 };
 
 int gpiod_request(struct gpio_desc *desc, const char *label);
-- 
2.11.0

