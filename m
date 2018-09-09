Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAEAC4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 21:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA102075A
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 21:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA102075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbeIJCGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 22:06:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47526 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbeIJCGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 22:06:18 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A7C582071D; Sun,  9 Sep 2018 23:15:17 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 78EA2203DC;
        Sun,  9 Sep 2018 23:15:07 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Matt Turner <mattst88@gmail.com>
Cc:     Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] alpha: rtc: simplify alpha_rtc_init
Date:   Sun,  9 Sep 2018 23:15:04 +0200
Message-Id: <20180909211504.11768-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_rtc_allocate_device to simplify choosing the rtc_ops in
alpha_rtc_init().

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/alpha/kernel/rtc.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/alpha/kernel/rtc.c b/arch/alpha/kernel/rtc.c
index 1376a2867048..1b1d5963ac55 100644
--- a/arch/alpha/kernel/rtc.c
+++ b/arch/alpha/kernel/rtc.c
@@ -198,26 +198,24 @@ static const struct rtc_class_ops remote_rtc_ops = {
 static int __init
 alpha_rtc_init(void)
 {
-	const struct rtc_class_ops *ops;
 	struct platform_device *pdev;
 	struct rtc_device *rtc;
-	const char *name;
 
 	init_rtc_epoch();
-	name = "rtc-alpha";
-	ops = &alpha_rtc_ops;
 
-#ifdef HAVE_REMOTE_RTC
-	if (alpha_mv.rtc_boot_cpu_only)
-		ops = &remote_rtc_ops;
-#endif
-
-	pdev = platform_device_register_simple(name, -1, NULL, 0);
-	rtc = devm_rtc_device_register(&pdev->dev, name, ops, THIS_MODULE);
+	pdev = platform_device_register_simple("rtc-alpha", -1, NULL, 0);
+	rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
 
 	platform_set_drvdata(pdev, rtc);
-	return 0;
+	rtc->ops = &alpha_rtc_ops;
+
+#ifdef HAVE_REMOTE_RTC
+	if (alpha_mv.rtc_boot_cpu_only)
+		rtc->ops = &remote_rtc_ops;
+#endif
+
+	return rtc_register_device(rtc);
 }
 device_initcall(alpha_rtc_init);
-- 
2.19.0.rc2

