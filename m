Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D95C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 20:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB692064D
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 20:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB692064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbeIJB3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 21:29:54 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47055 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726665AbeIJB3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 21:29:52 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2C4962079D; Sun,  9 Sep 2018 22:38:58 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 00F9A203DC;
        Sun,  9 Sep 2018 22:38:57 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/3] rtc: pl031: switch to devm_rtc_allocate_device/rtc_register_device
Date:   Sun,  9 Sep 2018 22:38:48 +0200
Message-Id: <20180909203848.3470-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.0.rc2
In-Reply-To: <20180909203848.3470-1-alexandre.belloni@bootlin.com>
References: <20180909203848.3470-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to devm_rtc_allocate_device to simplify the erro and driver removal
paths.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pl031.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
index 82eb7da2c478..30943d200c5e 100644
--- a/drivers/rtc/rtc-pl031.c
+++ b/drivers/rtc/rtc-pl031.c
@@ -310,7 +310,6 @@ static int pl031_remove(struct amba_device *adev)
 	device_init_wakeup(&adev->dev, false);
 	if (adev->irq[0])
 		free_irq(adev->irq[0], ldata);
-	rtc_device_unregister(ldata->rtc);
 	amba_release_regions(adev);
 
 	return 0;
@@ -383,24 +382,25 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 
 	device_init_wakeup(&adev->dev, true);
-	ldata->rtc = rtc_device_register("pl031", &adev->dev, ops,
-					THIS_MODULE);
-	if (IS_ERR(ldata->rtc)) {
-		ret = PTR_ERR(ldata->rtc);
+	ldata->rtc = devm_rtc_allocate_device(&adev->dev);
+	if (IS_ERR(ldata->rtc))
+		return PTR_ERR(ldata->rtc);
+
+	ldata->rtc->ops = ops;
+
+	ret = rtc_register_device(ldata->rtc);
+	if (ret)
 		goto out;
-	}
 
 	if (adev->irq[0]) {
 		ret = request_irq(adev->irq[0], pl031_interrupt,
 				  vendor->irqflags, "rtc-pl031", ldata);
 		if (ret)
-			goto out_no_irq;
+			goto out;
 		dev_pm_set_wake_irq(&adev->dev, adev->irq[0]);
 	}
 	return 0;
 
-out_no_irq:
-	rtc_device_unregister(ldata->rtc);
 out:
 	amba_release_regions(adev);
 err_req:
-- 
2.19.0.rc2

