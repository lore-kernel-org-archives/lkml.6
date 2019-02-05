Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CA8C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CDE22083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbfBEMlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 07:41:06 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:23951 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728472AbfBEMk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 07:40:58 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x15CZncn027439;
        Tue, 5 Feb 2019 13:40:44 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qdjdnkkn7-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 05 Feb 2019 13:40:44 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DA21D31;
        Tue,  5 Feb 2019 12:40:43 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A9CF229AF;
        Tue,  5 Feb 2019 12:40:43 +0000 (GMT)
Received: from localhost (10.75.127.44) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 5 Feb 2019 13:40:43
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>
CC:     <mark.rutland@arm.com>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <vilhelm.gray@gmail.com>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 4/4] iio: counter: stm32-lptimer: Add power management support
Date:   Tue, 5 Feb 2019 13:40:29 +0100
Message-ID: <1549370429-19116-5-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1549370429-19116-1-git-send-email-fabrice.gasnier@st.com>
References: <1549370429-19116-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-05_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suspend/resume PM sleep ops. When going to low power, disable
active counter. Only active counter should be resumed: don't touch
disabled counter, as it may be used by other LPTimer MFD child driver.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/counter/stm32-lptimer-cnt.c | 55 +++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/iio/counter/stm32-lptimer-cnt.c b/drivers/iio/counter/stm32-lptimer-cnt.c
index 42fb8ba..2a49cce 100644
--- a/drivers/iio/counter/stm32-lptimer-cnt.c
+++ b/drivers/iio/counter/stm32-lptimer-cnt.c
@@ -14,6 +14,7 @@
 #include <linux/iio/iio.h>
 #include <linux/mfd/stm32-lptimer.h>
 #include <linux/module.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 
 struct stm32_lptim_cnt {
@@ -23,6 +24,7 @@ struct stm32_lptim_cnt {
 	u32 preset;
 	u32 polarity;
 	u32 quadrature_mode;
+	bool enabled;
 };
 
 static int stm32_lptim_is_enabled(struct stm32_lptim_cnt *priv)
@@ -50,6 +52,7 @@ static int stm32_lptim_set_enable_state(struct stm32_lptim_cnt *priv,
 
 	if (!enable) {
 		clk_disable(priv->clk);
+		priv->enabled = false;
 		return 0;
 	}
 
@@ -79,6 +82,7 @@ static int stm32_lptim_set_enable_state(struct stm32_lptim_cnt *priv,
 		regmap_write(priv->regmap, STM32_LPTIM_CR, 0);
 		return ret;
 	}
+	priv->enabled = true;
 
 	/* Start LP timer in continuous mode */
 	return regmap_update_bits(priv->regmap, STM32_LPTIM_CR,
@@ -361,6 +365,56 @@ static int stm32_lptim_cnt_probe(struct platform_device *pdev)
 	return devm_iio_device_register(&pdev->dev, indio_dev);
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int stm32_lptim_cnt_suspend(struct device *dev)
+{
+	struct stm32_lptim_cnt *priv = dev_get_drvdata(dev);
+	int ret;
+
+	/* Only take care of enabled counter: don't disturb other MFD child */
+	if (priv->enabled) {
+		ret = stm32_lptim_setup(priv, 0);
+		if (ret)
+			return ret;
+
+		ret = stm32_lptim_set_enable_state(priv, 0);
+		if (ret)
+			return ret;
+
+		/* Force enable state for later resume */
+		priv->enabled = true;
+	}
+
+	return pinctrl_pm_select_sleep_state(dev);
+}
+
+static int stm32_lptim_cnt_resume(struct device *dev)
+{
+	struct stm32_lptim_cnt *priv = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pinctrl_pm_select_default_state(dev);
+	if (ret)
+		return ret;
+
+	if (priv->enabled) {
+		priv->enabled = false;
+		ret = stm32_lptim_setup(priv, 1);
+		if (ret)
+			return ret;
+
+		ret = stm32_lptim_set_enable_state(priv, 1);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(stm32_lptim_cnt_pm_ops, stm32_lptim_cnt_suspend,
+			 stm32_lptim_cnt_resume);
+
 static const struct of_device_id stm32_lptim_cnt_of_match[] = {
 	{ .compatible = "st,stm32-lptimer-counter", },
 	{},
@@ -372,6 +426,7 @@ static int stm32_lptim_cnt_probe(struct platform_device *pdev)
 	.driver = {
 		.name = "stm32-lptimer-counter",
 		.of_match_table = stm32_lptim_cnt_of_match,
+		.pm = &stm32_lptim_cnt_pm_ops,
 	},
 };
 module_platform_driver(stm32_lptim_cnt_driver);
-- 
1.9.1

