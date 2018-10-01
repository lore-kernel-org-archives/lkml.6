Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7076CC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B9920666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B9920666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbeJBEbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 00:31:43 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45175 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbeJBEbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 00:31:43 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 74097207CC; Mon,  1 Oct 2018 23:51:49 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5C44C206FF;
        Mon,  1 Oct 2018 23:51:38 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: vr41xx: switch to rtc_time64_to_tm/rtc_tm_to_time64
Date:   Mon,  1 Oct 2018 23:51:35 +0200
Message-Id: <20181001215135.5831-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call the 64bit versions of rtc_time_to_tm now that the range is enforced by
the core.
Also remove the open coded rtc_tm_to_time64.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-vr41xx.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-vr41xx.c b/drivers/rtc/rtc-vr41xx.c
index 70f013e692b0..e66d0f63cee2 100644
--- a/drivers/rtc/rtc-vr41xx.c
+++ b/drivers/rtc/rtc-vr41xx.c
@@ -136,8 +136,7 @@ static int vr41xx_rtc_set_time(struct device *dev, struct rtc_time *time)
 	time64_t epoch_sec, current_sec;
 
 	epoch_sec = mktime64(epoch, 1, 1, 0, 0, 0);
-	current_sec = mktime64(time->tm_year + 1900, time->tm_mon + 1, time->tm_mday,
-			     time->tm_hour, time->tm_min, time->tm_sec);
+	current_sec = rtc_tm_to_time64(time);
 
 	write_elapsed_second(current_sec - epoch_sec);
 
@@ -158,7 +157,7 @@ static int vr41xx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *wkalrm)
 
 	spin_unlock_irq(&rtc_lock);
 
-	rtc_time_to_tm((high << 17) | (mid << 1) | (low >> 15), time);
+	rtc_time64_to_tm((high << 17) | (mid << 1) | (low >> 15), time);
 
 	return 0;
 }
@@ -166,10 +165,8 @@ static int vr41xx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *wkalrm)
 static int vr41xx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *wkalrm)
 {
 	time64_t alarm_sec;
-	struct rtc_time *time = &wkalrm->time;
 
-	alarm_sec = mktime64(time->tm_year + 1900, time->tm_mon + 1, time->tm_mday,
-			     time->tm_hour, time->tm_min, time->tm_sec);
+	alarm_sec = rtc_tm_to_time64(&wkalrm->time);
 
 	spin_lock_irq(&rtc_lock);
 
-- 
2.19.0

