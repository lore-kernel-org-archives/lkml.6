Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F5DC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64F1219CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B64F1219CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753787AbeGEO0O convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:26:14 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:52871 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753912AbeGEO0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:26:06 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w65EOELN027763;
        Thu, 5 Jul 2018 16:25:58 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2k0dr4hjfm-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 05 Jul 2018 16:25:58 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A5DC534;
        Thu,  5 Jul 2018 14:25:57 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8140623E2;
        Thu,  5 Jul 2018 14:25:57 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE3.st.com
 (10.75.127.18) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 5 Jul
 2018 16:25:57 +0200
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Thu, 5 Jul 2018 16:25:57 +0200
From:   Pascal PAILLET-LME <p.paillet@st.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
CC:     Pascal PAILLET-LME <p.paillet@st.com>
Subject: [PATCH 3/3] regulator: core: Change suspend_late to suspend
Thread-Topic: [PATCH 3/3] regulator: core: Change suspend_late to suspend
Thread-Index: AQHUFGwWCbnoGgPVJ0WEbmwWsxsVHg==
Date:   Thu, 5 Jul 2018 14:25:57 +0000
Message-ID: <1530800748-7300-4-git-send-email-p.paillet@st.com>
References: <1530800748-7300-1-git-send-email-p.paillet@st.com>
In-Reply-To: <1530800748-7300-1-git-send-email-p.paillet@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: pascal paillet <p.paillet@st.com>

Change suspend_late ops to suspend normal ops. The goal is to avoid
requesting all the regulator drivers to be operational in suspend late
phase.

Signed-off-by: pascal paillet <p.paillet@st.com>
---
 drivers/regulator/core.c         | 26 +++++++++++++-------------
 include/linux/regulator/driver.h |  2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 607ec47..bb1324f 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4455,7 +4455,7 @@ void regulator_unregister(struct regulator_dev *rdev)
 EXPORT_SYMBOL_GPL(regulator_unregister);
 
 #ifdef CONFIG_SUSPEND
-static int _regulator_suspend_late(struct device *dev, void *data)
+static int _regulator_suspend(struct device *dev, void *data)
 {
 	struct regulator_dev *rdev = dev_to_rdev(dev);
 	suspend_state_t *state = data;
@@ -4469,20 +4469,20 @@ static int _regulator_suspend_late(struct device *dev, void *data)
 }
 
 /**
- * regulator_suspend_late - prepare regulators for system wide suspend
+ * regulator_suspend - prepare regulators for system wide suspend
  * @state: system suspend state
  *
  * Configure each regulator with it's suspend operating parameters for state.
  */
-static int regulator_suspend_late(struct device *dev)
+static int regulator_suspend(struct device *dev)
 {
 	suspend_state_t state = pm_suspend_target_state;
 
 	return class_for_each_device(&regulator_class, NULL, &state,
-				     _regulator_suspend_late);
+				     _regulator_suspend);
 }
 
-static int _regulator_resume_early(struct device *dev, void *data)
+static int _regulator_resume(struct device *dev, void *data)
 {
 	int ret = 0;
 	struct regulator_dev *rdev = dev_to_rdev(dev);
@@ -4495,35 +4495,35 @@ static int _regulator_resume_early(struct device *dev, void *data)
 
 	regulator_lock(rdev);
 
-	if (rdev->desc->ops->resume_early &&
+	if (rdev->desc->ops->resume &&
 	    (rstate->enabled == ENABLE_IN_SUSPEND ||
 	     rstate->enabled == DISABLE_IN_SUSPEND))
-		ret = rdev->desc->ops->resume_early(rdev);
+		ret = rdev->desc->ops->resume(rdev);
 
 	regulator_unlock(rdev);
 
 	return ret;
 }
 
-static int regulator_resume_early(struct device *dev)
+static int regulator_resume(struct device *dev)
 {
 	suspend_state_t state = pm_suspend_target_state;
 
 	return class_for_each_device(&regulator_class, NULL, &state,
-				     _regulator_resume_early);
+				     _regulator_resume);
 }
 
 #else /* !CONFIG_SUSPEND */
 
-#define regulator_suspend_late	NULL
-#define regulator_resume_early	NULL
+#define regulator_suspend	NULL
+#define regulator_resume	NULL
 
 #endif /* !CONFIG_SUSPEND */
 
 #ifdef CONFIG_PM
 static const struct dev_pm_ops __maybe_unused regulator_pm_ops = {
-	.suspend_late	= regulator_suspend_late,
-	.resume_early	= regulator_resume_early,
+	.suspend	= regulator_suspend,
+	.resume		= regulator_resume,
 };
 #endif
 
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index fc2dc8d..3a0302b 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -220,7 +220,7 @@ struct regulator_ops {
 	/* set regulator suspend operating mode (defined in consumer.h) */
 	int (*set_suspend_mode) (struct regulator_dev *, unsigned int mode);
 
-	int (*resume_early)(struct regulator_dev *rdev);
+	int (*resume)(struct regulator_dev *rdev);
 
 	int (*set_pull_down) (struct regulator_dev *);
 };
-- 
1.9.1
