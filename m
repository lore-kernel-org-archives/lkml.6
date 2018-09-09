Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E54C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 20:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DDA22064D
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 20:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DDA22064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbeIJB3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 21:29:52 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47051 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbeIJB3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 21:29:51 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 990CB2071D; Sun,  9 Sep 2018 22:38:57 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6C27D203DC;
        Sun,  9 Sep 2018 22:38:57 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 1/3] rtc: mt6397: fix possible race condition
Date:   Sun,  9 Sep 2018 22:38:46 +0200
Message-Id: <20180909203848.3470-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IRQ is requested before the struct rtc is allocated and registered, but
this struct is used in the IRQ handler. This may lead to a NULL pointer
dereference.

Switch to devm_rtc_allocate_device/rtc_register_device to allocate the rtc
before requesting the IRQ.

Cc: Eddie Huang <eddie.huang@mediatek.com>
Cc: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-mt6397.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index 385f8303bb41..e9a25ec4d434 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -332,6 +332,10 @@ static int mtk_rtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, rtc);
 
+	rtc->rtc_dev = devm_rtc_allocate_device(rtc->dev);
+	if (IS_ERR(rtc->rtc_dev))
+		return PTR_ERR(rtc->rtc_dev);
+
 	ret = request_threaded_irq(rtc->irq, NULL,
 				   mtk_rtc_irq_handler_thread,
 				   IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
@@ -344,11 +348,11 @@ static int mtk_rtc_probe(struct platform_device *pdev)
 
 	device_init_wakeup(&pdev->dev, 1);
 
-	rtc->rtc_dev = rtc_device_register("mt6397-rtc", &pdev->dev,
-					   &mtk_rtc_ops, THIS_MODULE);
-	if (IS_ERR(rtc->rtc_dev)) {
+	rtc->rtc_dev->ops = &mtk_rtc_ops;
+
+	ret = rtc_register_device(rtc->rtc_dev);
+	if (ret) {
 		dev_err(&pdev->dev, "register rtc device failed\n");
-		ret = PTR_ERR(rtc->rtc_dev);
 		goto out_free_irq;
 	}
 
@@ -365,7 +369,6 @@ static int mtk_rtc_remove(struct platform_device *pdev)
 {
 	struct mt6397_rtc *rtc = platform_get_drvdata(pdev);
 
-	rtc_device_unregister(rtc->rtc_dev);
 	free_irq(rtc->irq, rtc->rtc_dev);
 	irq_dispose_mapping(rtc->irq);
 
-- 
2.19.0.rc2

