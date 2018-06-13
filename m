Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E6C1FC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C6B208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C6B208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935100AbeFMKAW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 06:00:22 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:34177 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934527AbeFMKAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 06:00:19 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5D9xLx0028106;
        Wed, 13 Jun 2018 11:59:56 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2jjp8j2mrc-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 13 Jun 2018 11:59:56 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 86AE03F;
        Wed, 13 Jun 2018 09:59:53 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C951B16AD;
        Wed, 13 Jun 2018 09:59:52 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 13 Jun
 2018 11:59:52 +0200
Received: from localhost (10.201.23.73) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 13 Jun 2018 11:59:52
 +0200
From:   Hugues Fruchet <hugues.fruchet@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Hans Verkuil" <hverkuil@xs4all.nl>
CC:     <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Hugues Fruchet <hugues.fruchet@st.com>
Subject: [PATCH v2] media: stm32-dcmi: add power saving support
Date:   Wed, 13 Jun 2018 11:59:39 +0200
Message-ID: <1528883979-30661-1-git-send-email-hugues.fruchet@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.73]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-13_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implements runtime & system sleep power management ops.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
version 2:
  - Fix missing include file detected by kbuild on i386 & sparc64 arch:
    - https://www.mail-archive.com/linux-media@vger.kernel.org/msg132766.html
    - https://www.mail-archive.com/linux-media@vger.kernel.org/msg132771.html

drivers/media/platform/stm32/stm32-dcmi.c | 81 +++++++++++++++++++++++++------
 1 file changed, 65 insertions(+), 16 deletions(-)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index 2e1933d..2ecf00e 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -22,7 +22,9 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_graph.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/videodev2.h>
 
@@ -578,9 +580,9 @@ static int dcmi_start_streaming(struct vb2_queue *vq, unsigned int count)
 	u32 val = 0;
 	int ret;
 
-	ret = clk_enable(dcmi->mclk);
+	ret = pm_runtime_get_sync(dcmi->dev);
 	if (ret) {
-		dev_err(dcmi->dev, "%s: Failed to start streaming, cannot enable clock\n",
+		dev_err(dcmi->dev, "%s: Failed to start streaming, cannot get sync\n",
 			__func__);
 		goto err_release_buffers;
 	}
@@ -590,7 +592,7 @@ static int dcmi_start_streaming(struct vb2_queue *vq, unsigned int count)
 	if (ret && ret != -ENOIOCTLCMD) {
 		dev_err(dcmi->dev, "%s: Failed to start streaming, subdev streamon error",
 			__func__);
-		goto err_disable_clock;
+		goto err_pm_put;
 	}
 
 	spin_lock_irq(&dcmi->irqlock);
@@ -675,8 +677,8 @@ static int dcmi_start_streaming(struct vb2_queue *vq, unsigned int count)
 err_subdev_streamoff:
 	v4l2_subdev_call(dcmi->entity.subdev, video, s_stream, 0);
 
-err_disable_clock:
-	clk_disable(dcmi->mclk);
+err_pm_put:
+	pm_runtime_put(dcmi->dev);
 
 err_release_buffers:
 	spin_lock_irq(&dcmi->irqlock);
@@ -749,7 +751,7 @@ static void dcmi_stop_streaming(struct vb2_queue *vq)
 	/* Stop all pending DMA operations */
 	dmaengine_terminate_all(dcmi->dma_chan);
 
-	clk_disable(dcmi->mclk);
+	pm_runtime_put(dcmi->dev);
 
 	if (dcmi->errors_count)
 		dev_warn(dcmi->dev, "Some errors found while streaming: errors=%d (overrun=%d), buffers=%d\n",
@@ -1751,12 +1753,6 @@ static int dcmi_probe(struct platform_device *pdev)
 		return -EPROBE_DEFER;
 	}
 
-	ret = clk_prepare(mclk);
-	if (ret) {
-		dev_err(&pdev->dev, "Unable to prepare mclk %p\n", mclk);
-		goto err_dma_release;
-	}
-
 	spin_lock_init(&dcmi->irqlock);
 	mutex_init(&dcmi->lock);
 	init_completion(&dcmi->complete);
@@ -1772,7 +1768,7 @@ static int dcmi_probe(struct platform_device *pdev)
 	/* Initialize the top-level structure */
 	ret = v4l2_device_register(&pdev->dev, &dcmi->v4l2_dev);
 	if (ret)
-		goto err_clk_unprepare;
+		goto err_dma_release;
 
 	dcmi->vdev = video_device_alloc();
 	if (!dcmi->vdev) {
@@ -1832,14 +1828,15 @@ static int dcmi_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "Probe done\n");
 
 	platform_set_drvdata(pdev, dcmi);
+
+	pm_runtime_enable(&pdev->dev);
+
 	return 0;
 
 err_device_release:
 	video_device_release(dcmi->vdev);
 err_device_unregister:
 	v4l2_device_unregister(&dcmi->v4l2_dev);
-err_clk_unprepare:
-	clk_unprepare(dcmi->mclk);
 err_dma_release:
 	dma_release_channel(dcmi->dma_chan);
 
@@ -1850,20 +1847,72 @@ static int dcmi_remove(struct platform_device *pdev)
 {
 	struct stm32_dcmi *dcmi = platform_get_drvdata(pdev);
 
+	pm_runtime_disable(&pdev->dev);
+
 	v4l2_async_notifier_unregister(&dcmi->notifier);
 	v4l2_device_unregister(&dcmi->v4l2_dev);
-	clk_unprepare(dcmi->mclk);
+
 	dma_release_channel(dcmi->dma_chan);
 
 	return 0;
 }
 
+static __maybe_unused int dcmi_runtime_suspend(struct device *dev)
+{
+	struct stm32_dcmi *dcmi = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(dcmi->mclk);
+
+	return 0;
+}
+
+static __maybe_unused int dcmi_runtime_resume(struct device *dev)
+{
+	struct stm32_dcmi *dcmi = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(dcmi->mclk);
+	if (ret)
+		dev_err(dev, "%s: Failed to prepare_enable clock\n", __func__);
+
+	return ret;
+}
+
+static __maybe_unused int dcmi_suspend(struct device *dev)
+{
+	/* disable clock */
+	pm_runtime_force_suspend(dev);
+
+	/* change pinctrl state */
+	pinctrl_pm_select_sleep_state(dev);
+
+	return 0;
+}
+
+static __maybe_unused int dcmi_resume(struct device *dev)
+{
+	/* restore pinctl default state */
+	pinctrl_pm_select_default_state(dev);
+
+	/* clock enable */
+	pm_runtime_force_resume(dev);
+
+	return 0;
+}
+
+static const struct dev_pm_ops dcmi_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(dcmi_suspend, dcmi_resume)
+	SET_RUNTIME_PM_OPS(dcmi_runtime_suspend,
+			   dcmi_runtime_resume, NULL)
+};
+
 static struct platform_driver stm32_dcmi_driver = {
 	.probe		= dcmi_probe,
 	.remove		= dcmi_remove,
 	.driver		= {
 		.name = DRV_NAME,
 		.of_match_table = of_match_ptr(stm32_dcmi_of_match),
+		.pm = &dcmi_pm_ops,
 	},
 };
 
-- 
1.9.1

