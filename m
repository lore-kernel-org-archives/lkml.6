Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195C3C18E01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FAB20671
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:13:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1FAB20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbeKTUmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:42:06 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:38946 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725983AbeKTUmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:42:05 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id wAKA90qw018886;
        Tue, 20 Nov 2018 11:13:06 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2nvg2c034x-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 20 Nov 2018 11:13:06 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 52D733D;
        Tue, 20 Nov 2018 10:13:05 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 30E00266D;
        Tue, 20 Nov 2018 10:13:05 +0000 (GMT)
Received: from localhost (10.75.127.44) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 20 Nov 2018 11:13:04
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 3/3] iio: adc: stm32-adc: switch off running adc when going to low power
Date:   Tue, 20 Nov 2018 11:12:32 +0100
Message-ID: <1542708752-26163-4-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1542708752-26163-1-git-send-email-fabrice.gasnier@st.com>
References: <1542708752-26163-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-20_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch off ADC when going to low power mode, in case it has been left
running in buffer mode. Then re-enable it when resuming.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-adc.c | 79 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 63 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 32c9c61..2a9891c 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1518,7 +1518,7 @@ static int stm32_adc_dma_start(struct iio_dev *indio_dev)
 	return 0;
 }
 
-static int stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
+static int __stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct stm32_adc *adc = iio_priv(indio_dev);
 	struct device *dev = indio_dev->dev.parent;
@@ -1542,10 +1542,6 @@ static int stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
 		goto err_clr_trig;
 	}
 
-	ret = iio_triggered_buffer_postenable(indio_dev);
-	if (ret < 0)
-		goto err_stop_dma;
-
 	/* Reset adc buffer index */
 	adc->bufi = 0;
 
@@ -1556,9 +1552,6 @@ static int stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
 
 	return 0;
 
-err_stop_dma:
-	if (adc->dma_chan)
-		dmaengine_terminate_all(adc->dma_chan);
 err_clr_trig:
 	stm32_adc_set_trig(indio_dev, NULL);
 err_pm_put:
@@ -1568,20 +1561,30 @@ static int stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
 	return ret;
 }
 
-static int stm32_adc_buffer_predisable(struct iio_dev *indio_dev)
+static int stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
+{
+	int ret;
+
+	ret = iio_triggered_buffer_postenable(indio_dev);
+	if (ret < 0)
+		return ret;
+
+	ret = __stm32_adc_buffer_postenable(indio_dev);
+	if (ret < 0)
+		iio_triggered_buffer_predisable(indio_dev);
+
+	return ret;
+}
+
+static void __stm32_adc_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct stm32_adc *adc = iio_priv(indio_dev);
 	struct device *dev = indio_dev->dev.parent;
-	int ret;
 
 	adc->cfg->stop_conv(adc);
 	if (!adc->dma_chan)
 		stm32_adc_conv_irq_disable(adc);
 
-	ret = iio_triggered_buffer_predisable(indio_dev);
-	if (ret < 0)
-		dev_err(&indio_dev->dev, "predisable failed\n");
-
 	if (adc->dma_chan)
 		dmaengine_terminate_all(adc->dma_chan);
 
@@ -1590,6 +1593,17 @@ static int stm32_adc_buffer_predisable(struct iio_dev *indio_dev)
 
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
+}
+
+static int stm32_adc_buffer_predisable(struct iio_dev *indio_dev)
+{
+	int ret;
+
+	__stm32_adc_buffer_predisable(indio_dev);
+
+	ret = iio_triggered_buffer_predisable(indio_dev);
+	if (ret < 0)
+		dev_err(&indio_dev->dev, "predisable failed\n");
 
 	return ret;
 }
@@ -2013,6 +2027,40 @@ static int stm32_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#if defined(CONFIG_PM_SLEEP)
+static int stm32_adc_suspend(struct device *dev)
+{
+	struct stm32_adc *adc = dev_get_drvdata(dev);
+	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+
+	if (iio_buffer_enabled(indio_dev))
+		__stm32_adc_buffer_predisable(indio_dev);
+
+	return pm_runtime_force_suspend(dev);
+}
+
+static int stm32_adc_resume(struct device *dev)
+{
+	struct stm32_adc *adc = dev_get_drvdata(dev);
+	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	int ret;
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret < 0)
+		return ret;
+
+	if (!iio_buffer_enabled(indio_dev))
+		return 0;
+
+	ret = stm32_adc_update_scan_mode(indio_dev,
+					 indio_dev->active_scan_mask);
+	if (ret < 0)
+		return ret;
+
+	return __stm32_adc_buffer_postenable(indio_dev);
+}
+#endif
+
 #if defined(CONFIG_PM)
 static int stm32_adc_runtime_suspend(struct device *dev)
 {
@@ -2026,8 +2074,7 @@ static int stm32_adc_runtime_resume(struct device *dev)
 #endif
 
 static const struct dev_pm_ops stm32_adc_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(stm32_adc_suspend, stm32_adc_resume)
 	SET_RUNTIME_PM_OPS(stm32_adc_runtime_suspend, stm32_adc_runtime_resume,
 			   NULL)
 };
-- 
1.9.1

