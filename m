Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AA7ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C085B21480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C085B21480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731759AbeIXU2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:28:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41714 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729174AbeIXU2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:28:06 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AF9D0208A1; Mon, 24 Sep 2018 16:25:40 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 86DE720725;
        Mon, 24 Sep 2018 16:25:40 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/3] rtc: armada38x: switch to rtc_time64_to_tm/rtc_tm_to_time64
Date:   Mon, 24 Sep 2018 16:25:36 +0200
Message-Id: <20180924142536.27801-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924142536.27801-1-alexandre.belloni@bootlin.com>
References: <20180924142536.27801-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call the 64bit versions of rtc_time_to_tm and rtc_tm_to_time now that the
range is enforced by the core.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-armada38x.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
index d0278ad0a7f9..9e78f004670b 100644
--- a/drivers/rtc/rtc-armada38x.c
+++ b/drivers/rtc/rtc-armada38x.c
@@ -224,7 +224,7 @@ static int armada38x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	time = rtc->data->read_rtc_reg(rtc, RTC_TIME);
 	spin_unlock_irqrestore(&rtc->lock, flags);
 
-	rtc_time_to_tm(time, tm);
+	rtc_time64_to_tm(time, tm);
 
 	return 0;
 }
@@ -249,13 +249,9 @@ static void armada38x_rtc_reset(struct armada38x_rtc *rtc)
 static int armada38x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct armada38x_rtc *rtc = dev_get_drvdata(dev);
-	int ret = 0;
 	unsigned long time, flags;
 
-	ret = rtc_tm_to_time(tm, &time);
-
-	if (ret)
-		goto out;
+	time = rtc_tm_to_time64(tm);
 
 	if (!rtc->initialized)
 		armada38x_rtc_reset(rtc);
@@ -264,8 +260,7 @@ static int armada38x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	rtc_delayed_write(time, rtc, RTC_TIME);
 	spin_unlock_irqrestore(&rtc->lock, flags);
 
-out:
-	return ret;
+	return 0;
 }
 
 static int armada38x_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
@@ -284,7 +279,7 @@ static int armada38x_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	spin_unlock_irqrestore(&rtc->lock, flags);
 
 	alrm->enabled = val ? 1 : 0;
-	rtc_time_to_tm(time,  &alrm->time);
+	rtc_time64_to_tm(time,  &alrm->time);
 
 	return 0;
 }
@@ -295,12 +290,8 @@ static int armada38x_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	u32 reg = ALARM_REG(RTC_ALARM1, rtc->data->alarm);
 	u32 reg_irq = ALARM_REG(RTC_IRQ1_CONF, rtc->data->alarm);
 	unsigned long time, flags;
-	int ret = 0;
 
-	ret = rtc_tm_to_time(&alrm->time, &time);
-
-	if (ret)
-		goto out;
+	time = rtc_tm_to_time64(&alrm->time);
 
 	spin_lock_irqsave(&rtc->lock, flags);
 
@@ -313,8 +304,7 @@ static int armada38x_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 	spin_unlock_irqrestore(&rtc->lock, flags);
 
-out:
-	return ret;
+	return 0;
 }
 
 static int armada38x_rtc_alarm_irq_enable(struct device *dev,
-- 
2.19.0

