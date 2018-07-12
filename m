Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E652C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B8820BEC
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B8820BEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbeGLKbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 06:31:41 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56132 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbeGLKbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 06:31:41 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DC33120703; Thu, 12 Jul 2018 12:22:44 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id A761A2069C;
        Thu, 12 Jul 2018 12:22:44 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: fix alarm read and set offset
Date:   Thu, 12 Jul 2018 12:22:44 +0200
Message-Id: <20180712102244.12162-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The offset needs to be added after reading the alarm value.

It also needs to be subtracted after the now < alarm test.

Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/interface.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 6d4012dd6922..bac1eeb3d312 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -265,8 +265,10 @@ int __rtc_read_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 			return err;
 
 		/* full-function RTCs won't have such missing fields */
-		if (rtc_valid_tm(&alarm->time) == 0)
+		if (rtc_valid_tm(&alarm->time) == 0) {
+			rtc_add_offset(rtc, &alarm->time);
 			return 0;
+		}
 
 		/* get the "after" timestamp, to detect wrapped fields */
 		err = rtc_read_time(rtc, &now);
@@ -409,7 +411,6 @@ static int __rtc_set_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 	if (err)
 		return err;
 
-	rtc_subtract_offset(rtc, &alarm->time);
 	scheduled = rtc_tm_to_time64(&alarm->time);
 
 	/* Make sure we're not setting alarms in the past */
@@ -426,6 +427,8 @@ static int __rtc_set_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 	 * over right here, before we set the alarm.
 	 */
 
+	rtc_subtract_offset(rtc, &alarm->time);
+
 	if (!rtc->ops)
 		err = -ENODEV;
 	else if (!rtc->ops->set_alarm)
@@ -467,7 +470,6 @@ int rtc_set_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 
 	mutex_unlock(&rtc->ops_lock);
 
-	rtc_add_offset(rtc, &alarm->time);
 	return err;
 }
 EXPORT_SYMBOL_GPL(rtc_set_alarm);
-- 
2.18.0

