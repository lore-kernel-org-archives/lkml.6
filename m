Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF08EC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD673208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD673208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbeJBEpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 00:45:34 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45634 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbeJBEpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 00:45:34 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 168BA207CC; Tue,  2 Oct 2018 00:05:37 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id E57CB209D6;
        Tue,  2 Oct 2018 00:05:26 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: mv: let the core handle invalid alarms
Date:   Tue,  2 Oct 2018 00:05:25 +0200
Message-Id: <20181001220525.6735-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of lying to the core when the alarm is invalid, let it handle that
by returning the error.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-mv.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-mv.c b/drivers/rtc/rtc-mv.c
index 4b198b3778d3..e7f14bd12fe3 100644
--- a/drivers/rtc/rtc-mv.c
+++ b/drivers/rtc/rtc-mv.c
@@ -125,13 +125,9 @@ static int mv_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	/* hw counts from year 2000, but tm_year is relative to 1900 */
 	alm->time.tm_year = bcd2bin(year) + 100;
 
-	if (rtc_valid_tm(&alm->time) < 0) {
-		dev_err(dev, "retrieved alarm date/time is not valid.\n");
-		rtc_time_to_tm(0, &alm->time);
-	}
-
 	alm->enabled = !!readl(ioaddr + RTC_ALARM_INTERRUPT_MASK_REG_OFFS);
-	return 0;
+
+	return rtc_valid_tm(&alm->time);
 }
 
 static int mv_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
-- 
2.19.0

