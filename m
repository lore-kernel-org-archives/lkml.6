Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467F2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157B2224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157B2224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbeKMBWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:22:23 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:47492 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728416AbeKMBWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:22:22 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wACFOIMM002539;
        Mon, 12 Nov 2018 09:28:38 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0a-001ae601.pphosted.com with ESMTP id 2nnwm9udh4-1;
        Mon, 12 Nov 2018 09:28:38 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id 03A5F611C8AF;
        Mon, 12 Nov 2018 09:31:53 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Mon, 12 Nov 2018
 15:28:37 +0000
Received: from edi-sw-dsktp006.ad.cirrus.com (edi-sw-dsktp006.ad.cirrus.com
 [198.90.251.121])      by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 wACFSb5k008055;        Mon, 12 Nov 2018 15:28:37 GMT
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] mfd: madera: Add shared data for accessory detection
Date:   Mon, 12 Nov 2018 15:28:37 +0000
Message-ID: <20181112152837.21553-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=890 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1811120135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add variables to struct madera that will be shared by the
extcon and audio codec drivers to synchronize output state
during accessory detection. Also add a mutex to protect
the DAPM pointer.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/mfd/madera-core.c       | 3 +++
 include/linux/mfd/madera/core.h | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
index 440030cecbbd..5b58a8aea902 100644
--- a/drivers/mfd/madera-core.c
+++ b/drivers/mfd/madera-core.c
@@ -15,6 +15,7 @@
 #include <linux/gpio.h>
 #include <linux/mfd/core.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
@@ -357,6 +358,8 @@ int madera_dev_init(struct madera *madera)
 
 	dev_set_drvdata(madera->dev, madera);
 	BLOCKING_INIT_NOTIFIER_HEAD(&madera->notifier);
+	mutex_init(&madera->dapm_ptr_lock);
+
 	madera_set_micbias_info(madera);
 
 	/*
diff --git a/include/linux/mfd/madera/core.h b/include/linux/mfd/madera/core.h
index fe69c0f4398f..4d5d51a9c8a6 100644
--- a/include/linux/mfd/madera/core.h
+++ b/include/linux/mfd/madera/core.h
@@ -15,6 +15,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/mfd/madera/pdata.h>
+#include <linux/mutex.h>
 #include <linux/notifier.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
@@ -37,6 +38,8 @@ enum madera_type {
 
 #define MADERA_MAX_MICBIAS		4
 
+#define MADERA_MAX_HP_OUTPUT		3
+
 /* Notifier events */
 #define MADERA_NOTIFY_VOICE_TRIGGER	0x1
 #define MADERA_NOTIFY_HPDET		0x2
@@ -183,6 +186,10 @@ struct madera {
 	unsigned int num_childbias[MADERA_MAX_MICBIAS];
 
 	struct snd_soc_dapm_context *dapm;
+	struct mutex dapm_ptr_lock;
+	unsigned int hp_ena;
+	bool out_clamp[MADERA_MAX_HP_OUTPUT];
+	bool out_shorted[MADERA_MAX_HP_OUTPUT];
 
 	struct blocking_notifier_head notifier;
 };
-- 
2.11.0

