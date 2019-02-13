Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44071C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B5F21901
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403847AbfBMKvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:51:40 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22984 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391543AbfBMKuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 05:50:51 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1DAg5cj024997;
        Wed, 13 Feb 2019 11:50:39 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qhv0m6nd9-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 13 Feb 2019 11:50:39 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0F86B31;
        Wed, 13 Feb 2019 10:50:39 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D3E6A4EDF;
        Wed, 13 Feb 2019 10:50:38 +0000 (GMT)
Received: from localhost (10.75.127.48) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 13 Feb 2019 11:50:38
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>
CC:     <u.kleine-koenig@pengutronix.de>, <tduszyns@gmail.com>,
        <mark.rutland@arm.com>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v3 3/3] pwm: core: add consumer device link
Date:   Wed, 13 Feb 2019 11:50:12 +0100
Message-ID: <1550055012-23348-4-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550055012-23348-1-git-send-email-fabrice.gasnier@st.com>
References: <1550055012-23348-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-13_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a device link between the PWM consumer and the PWM provider. This
enforces the PWM user to get suspended before the PWM provider. It
allows proper synchronization of suspend/resume sequences: the PWM user
is responsible for properly stopping PWM, before the provider gets
suspended: see [1]. Add the device link in:
- of_pwm_get()
- pwm_get()
- devm_ variants
as it requires a reference to the device for the PWM consumer.

[1] https://lkml.org/lkml/2019/2/5/770

Suggested-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in v3:
- add struct device to of_get_pwm() arguments to handle device link from
  there.
---
 drivers/pwm/core.c  | 14 +++++++++++---
 include/linux/pwm.h |  6 ++++--
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 1581f6a..8cb5d4bc 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -638,6 +638,7 @@ static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
 
 /**
  * of_pwm_get() - request a PWM via the PWM framework
+ * @dev: device for PWM consumer
  * @np: device node to get the PWM from
  * @con_id: consumer name
  *
@@ -655,7 +656,8 @@ static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
  * Returns: A pointer to the requested PWM device or an ERR_PTR()-encoded
  * error code on failure.
  */
-struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
+struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
+			      const char *con_id)
 {
 	struct pwm_device *pwm = NULL;
 	struct of_phandle_args args;
@@ -689,6 +691,9 @@ struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
 	if (IS_ERR(pwm))
 		goto put;
 
+	if (!device_link_add(dev, pwm->chip->dev, DL_FLAG_AUTOREMOVE_CONSUMER))
+		pr_debug("%s(): device link not added\n", __func__);
+
 	/*
 	 * If a consumer name was not given, try to look it up from the
 	 * "pwm-names" property if it exists. Otherwise use the name of
@@ -771,7 +776,7 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
 
 	/* look up via DT first */
 	if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node)
-		return of_pwm_get(dev->of_node, con_id);
+		return of_pwm_get(dev, dev->of_node, con_id);
 
 	/*
 	 * We look up the provider in the static table typically provided by
@@ -851,6 +856,9 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
 	pwm->args.period = chosen->period;
 	pwm->args.polarity = chosen->polarity;
 
+	if (!device_link_add(dev, pwm->chip->dev, DL_FLAG_AUTOREMOVE_CONSUMER))
+		pr_debug("%s(): device link not added\n", __func__);
+
 	return pwm;
 }
 EXPORT_SYMBOL_GPL(pwm_get);
@@ -939,7 +947,7 @@ struct pwm_device *devm_of_pwm_get(struct device *dev, struct device_node *np,
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	pwm = of_pwm_get(np, con_id);
+	pwm = of_pwm_get(dev, np, con_id);
 	if (!IS_ERR(pwm)) {
 		*ptr = pwm;
 		devres_add(dev, ptr);
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index d5199b5..895e074 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -406,7 +406,8 @@ struct pwm_device *of_pwm_xlate_with_flags(struct pwm_chip *pc,
 		const struct of_phandle_args *args);
 
 struct pwm_device *pwm_get(struct device *dev, const char *con_id);
-struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id);
+struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
+			      const char *con_id);
 void pwm_put(struct pwm_device *pwm);
 
 struct pwm_device *devm_pwm_get(struct device *dev, const char *con_id);
@@ -494,7 +495,8 @@ static inline struct pwm_device *pwm_get(struct device *dev,
 	return ERR_PTR(-ENODEV);
 }
 
-static inline struct pwm_device *of_pwm_get(struct device_node *np,
+static inline struct pwm_device *of_pwm_get(struct device *dev,
+					    struct device_node *np,
 					    const char *con_id)
 {
 	return ERR_PTR(-ENODEV);
-- 
1.9.1

