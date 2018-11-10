Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF5FC43610
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 20:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB1920840
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 20:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FB1920840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbeKKGMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 01:12:13 -0500
Received: from mail.bootlin.com ([62.4.15.54]:40517 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbeKKGMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 01:12:13 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A9382208EB; Sat, 10 Nov 2018 21:25:57 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 74FA920701;
        Sat, 10 Nov 2018 21:25:47 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: class: remove devm_rtc_device_unregister
Date:   Sat, 10 Nov 2018 21:25:44 +0100
Message-Id: <20181110202544.17924-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_rtc_device_unregister is not used by any driver and should not be used
by any new driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/class.c | 26 --------------------------
 include/linux/rtc.h |  2 --
 2 files changed, 28 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 3b43787f154b..6d364085bd86 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -380,13 +380,6 @@ static void devm_rtc_device_release(struct device *dev, void *res)
 	rtc_device_unregister(rtc);
 }
 
-static int devm_rtc_device_match(struct device *dev, void *res, void *data)
-{
-	struct rtc **r = res;
-
-	return *r == data;
-}
-
 /**
  * devm_rtc_device_register - resource managed rtc_device_register()
  * @dev: the device to register
@@ -424,25 +417,6 @@ struct rtc_device *devm_rtc_device_register(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_rtc_device_register);
 
-/**
- * devm_rtc_device_unregister - resource managed devm_rtc_device_unregister()
- * @dev: the device to unregister
- * @rtc: the RTC class device to unregister
- *
- * Deallocated a rtc allocated with devm_rtc_device_register(). Normally this
- * function will not need to be called and the resource management code will
- * ensure that the resource is freed.
- */
-void devm_rtc_device_unregister(struct device *dev, struct rtc_device *rtc)
-{
-	int rc;
-
-	rc = devres_release(dev, devm_rtc_device_release,
-				devm_rtc_device_match, rtc);
-	WARN_ON(rc);
-}
-EXPORT_SYMBOL_GPL(devm_rtc_device_unregister);
-
 static void devm_rtc_release_device(struct device *dev, void *res)
 {
 	struct rtc_device *rtc = *(struct rtc_device **)res;
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 40ecdb5a369e..58147b057acd 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -172,8 +172,6 @@ extern struct rtc_device *devm_rtc_device_register(struct device *dev,
 					struct module *owner);
 struct rtc_device *devm_rtc_allocate_device(struct device *dev);
 int __rtc_register_device(struct module *owner, struct rtc_device *rtc);
-extern void devm_rtc_device_unregister(struct device *dev,
-					struct rtc_device *rtc);
 
 extern int rtc_read_time(struct rtc_device *rtc, struct rtc_time *tm);
 extern int rtc_set_time(struct rtc_device *rtc, struct rtc_time *tm);
-- 
2.19.1

