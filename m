Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C908C282D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 759072083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbfBEMlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 07:41:07 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:37571 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726065AbfBEMk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 07:40:58 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x15CaEJQ002718;
        Tue, 5 Feb 2019 13:40:42 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qd1v06pqn-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 05 Feb 2019 13:40:42 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 43A8A31;
        Tue,  5 Feb 2019 12:40:42 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 20A8829AC;
        Tue,  5 Feb 2019 12:40:42 +0000 (GMT)
Received: from localhost (10.75.127.47) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 5 Feb 2019 13:40:41
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
Subject: [PATCH 2/4] pwm: stm32-lp: Add power management support
Date:   Tue, 5 Feb 2019 13:40:27 +0100
Message-ID: <1549370429-19116-3-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1549370429-19116-1-git-send-email-fabrice.gasnier@st.com>
References: <1549370429-19116-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-05_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suspend/resume PM sleep ops. When going to low power, disable
active PWM channel. Active PWM channel is resumed, by calling
pwm_apply_state(). This is inspired by Thierry's comment in [1].
Don't touch inactive channels, as it may be used by other LPTimer MFD
child driver.
[1]https://lkml.org/lkml/2017/12/5/175

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/pwm/pwm-stm32-lp.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 0059b24c..0c40d48 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -13,6 +13,7 @@
 #include <linux/mfd/stm32-lptimer.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 
@@ -20,6 +21,8 @@ struct stm32_pwm_lp {
 	struct pwm_chip chip;
 	struct clk *clk;
 	struct regmap *regmap;
+	struct pwm_state suspend;
+	bool suspended;
 };
 
 static inline struct stm32_pwm_lp *to_stm32_pwm_lp(struct pwm_chip *chip)
@@ -223,6 +226,40 @@ static int stm32_pwm_lp_remove(struct platform_device *pdev)
 	return pwmchip_remove(&priv->chip);
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int stm32_pwm_lp_suspend(struct device *dev)
+{
+	struct stm32_pwm_lp *priv = dev_get_drvdata(dev);
+
+	pwm_get_state(&priv->chip.pwms[0], &priv->suspend);
+	priv->suspended = priv->suspend.enabled;
+
+	/* safe to call pwm_disable() for already disabled pwm */
+	pwm_disable(&priv->chip.pwms[0]);
+
+	return pinctrl_pm_select_sleep_state(dev);
+}
+
+static int stm32_pwm_lp_resume(struct device *dev)
+{
+	struct stm32_pwm_lp *priv = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pinctrl_pm_select_default_state(dev);
+	if (ret)
+		return ret;
+
+	/* Only restore suspended pwm, not to disrupt other MFD child */
+	if (!priv->suspended)
+		return 0;
+
+	return pwm_apply_state(&priv->chip.pwms[0], &priv->suspend);
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(stm32_pwm_lp_pm_ops, stm32_pwm_lp_suspend,
+			 stm32_pwm_lp_resume);
+
 static const struct of_device_id stm32_pwm_lp_of_match[] = {
 	{ .compatible = "st,stm32-pwm-lp", },
 	{},
@@ -235,6 +272,7 @@ static int stm32_pwm_lp_remove(struct platform_device *pdev)
 	.driver	= {
 		.name = "stm32-pwm-lp",
 		.of_match_table = of_match_ptr(stm32_pwm_lp_of_match),
+		.pm = &stm32_pwm_lp_pm_ops,
 	},
 };
 module_platform_driver(stm32_pwm_lp_driver);
-- 
1.9.1

