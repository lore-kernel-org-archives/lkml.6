Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C672C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4600520700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732269AbfBKQNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:13:05 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:37394 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727799AbfBKQM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:12:59 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1BG89Ce026964;
        Mon, 11 Feb 2019 17:12:46 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qhurhu1dh-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 11 Feb 2019 17:12:46 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ABE2D31;
        Mon, 11 Feb 2019 16:12:44 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C8E9751C1;
        Mon, 11 Feb 2019 16:12:43 +0000 (GMT)
Received: from localhost (10.75.127.49) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 11 Feb 2019 17:12:43
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
Subject: [PATCH v2 3/3] pwm: core: add consumer device link
Date:   Mon, 11 Feb 2019 17:12:02 +0100
Message-ID: <1549901522-15071-4-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1549901522-15071-1-git-send-email-fabrice.gasnier@st.com>
References: <1549901522-15071-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-11_10:,,
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
- pwm_get()
- devm_pwm_get()
- devm_of_pwm_get()
as it requires a reference to the device for the PWM consumer.

[1] https://lkml.org/lkml/2019/2/5/770

Suggested-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/pwm/core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 1581f6a..2835e27 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -770,8 +770,13 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
 	int err;
 
 	/* look up via DT first */
-	if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node)
-		return of_pwm_get(dev->of_node, con_id);
+	if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node) {
+		pwm = of_pwm_get(dev->of_node, con_id);
+		if (!IS_ERR(pwm))
+			device_link_add(dev, pwm->chip->dev,
+					DL_FLAG_AUTOREMOVE_CONSUMER);
+		return pwm;
+	}
 
 	/*
 	 * We look up the provider in the static table typically provided by
@@ -851,6 +856,8 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
 	pwm->args.period = chosen->period;
 	pwm->args.polarity = chosen->polarity;
 
+	device_link_add(dev, pwm->chip->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
+
 	return pwm;
 }
 EXPORT_SYMBOL_GPL(pwm_get);
@@ -943,6 +950,8 @@ struct pwm_device *devm_of_pwm_get(struct device *dev, struct device_node *np,
 	if (!IS_ERR(pwm)) {
 		*ptr = pwm;
 		devres_add(dev, ptr);
+		device_link_add(dev, pwm->chip->dev,
+				DL_FLAG_AUTOREMOVE_CONSUMER);
 	} else {
 		devres_free(ptr);
 	}
-- 
1.9.1

