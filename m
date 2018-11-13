Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21438C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC34E223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC34E223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732481AbeKNDR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:17:58 -0500
Received: from mga17.intel.com ([192.55.52.151]:55846 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731961AbeKNDQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:16:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 09:17:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,228,1539673200"; 
   d="scan'208";a="90813325"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 13 Nov 2018 09:17:36 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6757D914; Tue, 13 Nov 2018 19:17:31 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Joe Perches <joe@perches.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 12/20] rtc: rk808: Switch to use %ptR
Date:   Tue, 13 Nov 2018 19:17:21 +0200
Message-Id: <20181113171729.19645-13-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181113171729.19645-1-andriy.shevchenko@linux.intel.com>
References: <20181113171729.19645-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use %ptR instead of open coded variant to print content of
struct rtc_time in human readable format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-rk808.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/rtc/rtc-rk808.c b/drivers/rtc/rtc-rk808.c
index b2f9e45e0298..1fb864d4ef83 100644
--- a/drivers/rtc/rtc-rk808.c
+++ b/drivers/rtc/rtc-rk808.c
@@ -138,9 +138,7 @@ static int rk808_rtc_readtime(struct device *dev, struct rtc_time *tm)
 	tm->tm_year = (bcd2bin(rtc_data[5] & YEARS_REG_MSK)) + 100;
 	tm->tm_wday = bcd2bin(rtc_data[6] & WEEKS_REG_MSK);
 	rockchip_to_gregorian(tm);
-	dev_dbg(dev, "RTC date/time %4d-%02d-%02d(%d) %02d:%02d:%02d\n",
-		1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
-		tm->tm_wday, tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "RTC date/time %ptRd(%d) %ptRt\n", tm, tm->tm_wday, tm);
 
 	return ret;
 }
@@ -153,9 +151,7 @@ static int rk808_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	u8 rtc_data[NUM_TIME_REGS];
 	int ret;
 
-	dev_dbg(dev, "set RTC date/time %4d-%02d-%02d(%d) %02d:%02d:%02d\n",
-		1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
-		tm->tm_wday, tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "set RTC date/time %ptRd(%d) %ptRt\n", tm, tm->tm_wday, tm);
 	gregorian_to_rockchip(tm);
 	rtc_data[0] = bin2bcd(tm->tm_sec);
 	rtc_data[1] = bin2bcd(tm->tm_min);
@@ -216,10 +212,8 @@ static int rk808_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
 		return ret;
 	}
 
-	dev_dbg(dev, "alrm read RTC date/time %4d-%02d-%02d(%d) %02d:%02d:%02d\n",
-		1900 + alrm->time.tm_year, alrm->time.tm_mon + 1,
-		alrm->time.tm_mday, alrm->time.tm_wday, alrm->time.tm_hour,
-		alrm->time.tm_min, alrm->time.tm_sec);
+	dev_dbg(dev, "alrm read RTC date/time %ptRd(%d) %ptRt\n",
+		&alrm->time, alrm->time.tm_wday, &alrm->time);
 
 	alrm->enabled = (int_reg & BIT_RTC_INTERRUPTS_REG_IT_ALARM_M) ? 1 : 0;
 
@@ -261,10 +255,8 @@ static int rk808_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 		dev_err(dev, "Failed to stop alarm: %d\n", ret);
 		return ret;
 	}
-	dev_dbg(dev, "alrm set RTC date/time %4d-%02d-%02d(%d) %02d:%02d:%02d\n",
-		1900 + alrm->time.tm_year, alrm->time.tm_mon + 1,
-		alrm->time.tm_mday, alrm->time.tm_wday, alrm->time.tm_hour,
-		alrm->time.tm_min, alrm->time.tm_sec);
+	dev_dbg(dev, "alrm set RTC date/time %ptRd(%d) %ptRt\n",
+		&alrm->time, alrm->time.tm_wday, &alrm->time);
 
 	gregorian_to_rockchip(&alrm->time);
 	alrm_data[0] = bin2bcd(alrm->time.tm_sec);
-- 
2.19.1

