Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751895AbeBUVWe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:22:34 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:46904 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751379AbeBUU5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:12 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 006/100] rtc: ab-b5ze-s3: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:55:01 +0100
Message-Id: <20180221205635.31314-7-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
References: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC core is always calling rtc_valid_tm after the read_time callback.
It is not necessary to call it just before returning from the callback.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ab-b5ze-s3.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-ab-b5ze-s3.c b/drivers/rtc/rtc-ab-b5ze-s3.c
index a319bf1e49de..e55f35fa0b58 100644
--- a/drivers/rtc/rtc-ab-b5ze-s3.c
+++ b/drivers/rtc/rtc-ab-b5ze-s3.c
@@ -217,7 +217,7 @@ static int _abb5zes3_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct abb5zes3_rtc_data *data = dev_get_drvdata(dev);
 	u8 regs[ABB5ZES3_REG_RTC_SC + ABB5ZES3_RTC_SEC_LEN];
-	int ret;
+	int ret = 0;
 
 	/*
 	 * As we need to read CTRL1 register anyway to access 24/12h
@@ -255,8 +255,6 @@ static int _abb5zes3_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	tm->tm_mon  = bcd2bin(regs[ABB5ZES3_REG_RTC_MO]) - 1; /* starts at 1 */
 	tm->tm_year = bcd2bin(regs[ABB5ZES3_REG_RTC_YR]) + 100;
 
-	ret = rtc_valid_tm(tm);
-
 err:
 	return ret;
 }
-- 
2.16.1
