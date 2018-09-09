Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CFCC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 20:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1627420865
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 20:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1627420865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbeIJB3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 21:29:53 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47053 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbeIJB3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 21:29:52 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DB2A820726; Sun,  9 Sep 2018 22:38:57 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id B349F203DC;
        Sun,  9 Sep 2018 22:38:57 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/3] rtc: pl030: fix possible race condition
Date:   Sun,  9 Sep 2018 22:38:47 +0200
Message-Id: <20180909203848.3470-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.0.rc2
In-Reply-To: <20180909203848.3470-1-alexandre.belloni@bootlin.com>
References: <20180909203848.3470-1-alexandre.belloni@bootlin.com>
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

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pl030.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-pl030.c b/drivers/rtc/rtc-pl030.c
index f85a1a93e669..343bb6ed1783 100644
--- a/drivers/rtc/rtc-pl030.c
+++ b/drivers/rtc/rtc-pl030.c
@@ -112,6 +112,13 @@ static int pl030_probe(struct amba_device *dev, const struct amba_id *id)
 		goto err_rtc;
 	}
 
+	rtc->rtc = devm_rtc_allocate_device(&dev->dev);
+	if (IS_ERR(rtc->rtc)) {
+		ret = PTR_ERR(rtc->rtc);
+		goto err_rtc;
+	}
+
+	rtc->rtc->ops = &pl030_ops;
 	rtc->base = ioremap(dev->res.start, resource_size(&dev->res));
 	if (!rtc->base) {
 		ret = -ENOMEM;
@@ -128,12 +135,9 @@ static int pl030_probe(struct amba_device *dev, const struct amba_id *id)
 	if (ret)
 		goto err_irq;
 
-	rtc->rtc = rtc_device_register("pl030", &dev->dev, &pl030_ops,
-				       THIS_MODULE);
-	if (IS_ERR(rtc->rtc)) {
-		ret = PTR_ERR(rtc->rtc);
+	ret = rtc_register_device(rtc->rtc);
+	if (ret)
 		goto err_reg;
-	}
 
 	return 0;
 
@@ -154,7 +158,6 @@ static int pl030_remove(struct amba_device *dev)
 	writel(0, rtc->base + RTC_CR);
 
 	free_irq(dev->irq[0], rtc);
-	rtc_device_unregister(rtc->rtc);
 	iounmap(rtc->base);
 	amba_release_regions(dev);
 
-- 
2.19.0.rc2

