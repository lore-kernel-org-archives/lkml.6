Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A095C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A83E218C3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbfBFJu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 04:50:58 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48415 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbfBFJu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 04:50:58 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1grJr4-0008BE-1z; Wed, 06 Feb 2019 09:50:54 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: 88pm860x: fix unintended sign extension
Date:   Wed,  6 Feb 2019 09:50:53 +0000
Message-Id: <20190206095053.12894-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Shifting a u8 by 24 will cause the value to be promoted to an integer. If
the top bit of the u8 is set then the following conversion to an unsigned
long will sign extend the value causing the upper 32 bits to be set in
the result.

Fix this by casting the u8 value to an unsigned long before the shift.

Detected by CoverityScan, CID#144925-144928 ("Unintended sign extension")

Fixes: 008b30408c40 ("mfd: Add rtc support to 88pm860x")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/rtc/rtc-88pm860x.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-88pm860x.c b/drivers/rtc/rtc-88pm860x.c
index 01ffc0ef8033..d25282b4a7dd 100644
--- a/drivers/rtc/rtc-88pm860x.c
+++ b/drivers/rtc/rtc-88pm860x.c
@@ -115,11 +115,13 @@ static int pm860x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	pm860x_page_bulk_read(info->i2c, REG0_ADDR, 8, buf);
 	dev_dbg(info->dev, "%x-%x-%x-%x-%x-%x-%x-%x\n", buf[0], buf[1],
 		buf[2], buf[3], buf[4], buf[5], buf[6], buf[7]);
-	base = (buf[1] << 24) | (buf[3] << 16) | (buf[5] << 8) | buf[7];
+	base = ((unsigned long)buf[1] << 24) | (buf[3] << 16) |
+		(buf[5] << 8) | buf[7];
 
 	/* load 32-bit read-only counter */
 	pm860x_bulk_read(info->i2c, PM8607_RTC_COUNTER1, 4, buf);
-	data = (buf[3] << 24) | (buf[2] << 16) | (buf[1] << 8) | buf[0];
+	data = ((unsigned long)buf[3] << 24) | (buf[2] << 16) |
+		(buf[1] << 8) | buf[0];
 	ticks = base + data;
 	dev_dbg(info->dev, "get base:0x%lx, RO count:0x%lx, ticks:0x%lx\n",
 		base, data, ticks);
@@ -145,7 +147,8 @@ static int pm860x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 
 	/* load 32-bit read-only counter */
 	pm860x_bulk_read(info->i2c, PM8607_RTC_COUNTER1, 4, buf);
-	data = (buf[3] << 24) | (buf[2] << 16) | (buf[1] << 8) | buf[0];
+	data = ((unsigned long)buf[3] << 24) | (buf[2] << 16) |
+		(buf[1] << 8) | buf[0];
 	base = ticks - data;
 	dev_dbg(info->dev, "set base:0x%lx, RO count:0x%lx, ticks:0x%lx\n",
 		base, data, ticks);
@@ -170,10 +173,12 @@ static int pm860x_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	pm860x_page_bulk_read(info->i2c, REG0_ADDR, 8, buf);
 	dev_dbg(info->dev, "%x-%x-%x-%x-%x-%x-%x-%x\n", buf[0], buf[1],
 		buf[2], buf[3], buf[4], buf[5], buf[6], buf[7]);
-	base = (buf[1] << 24) | (buf[3] << 16) | (buf[5] << 8) | buf[7];
+	base = ((unsigned long)buf[1] << 24) | (buf[3] << 16) |
+		(buf[5] << 8) | buf[7];
 
 	pm860x_bulk_read(info->i2c, PM8607_RTC_EXPIRE1, 4, buf);
-	data = (buf[3] << 24) | (buf[2] << 16) | (buf[1] << 8) | buf[0];
+	data = ((unsigned long)buf[3] << 24) | (buf[2] << 16) |
+		(buf[1] << 8) | buf[0];
 	ticks = base + data;
 	dev_dbg(info->dev, "get base:0x%lx, RO count:0x%lx, ticks:0x%lx\n",
 		base, data, ticks);
@@ -198,11 +203,13 @@ static int pm860x_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	pm860x_page_bulk_read(info->i2c, REG0_ADDR, 8, buf);
 	dev_dbg(info->dev, "%x-%x-%x-%x-%x-%x-%x-%x\n", buf[0], buf[1],
 		buf[2], buf[3], buf[4], buf[5], buf[6], buf[7]);
-	base = (buf[1] << 24) | (buf[3] << 16) | (buf[5] << 8) | buf[7];
+	base = ((unsigned long)buf[1] << 24) | (buf[3] << 16) |
+		(buf[5] << 8) | buf[7];
 
 	/* load 32-bit read-only counter */
 	pm860x_bulk_read(info->i2c, PM8607_RTC_COUNTER1, 4, buf);
-	data = (buf[3] << 24) | (buf[2] << 16) | (buf[1] << 8) | buf[0];
+	data = ((unsigned long)buf[3] << 24) | (buf[2] << 16) |
+		(buf[1] << 8) | buf[0];
 	ticks = base + data;
 	dev_dbg(info->dev, "get base:0x%lx, RO count:0x%lx, ticks:0x%lx\n",
 		base, data, ticks);
-- 
2.20.1

