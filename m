Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F085CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C26232081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26232081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbeK2WJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 17:09:41 -0500
Received: from mga01.intel.com ([192.55.52.88]:15235 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbeK2WJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 17:09:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2018 03:04:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,294,1539673200"; 
   d="scan'208";a="289684549"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 29 Nov 2018 03:04:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4FA202A9; Thu, 29 Nov 2018 13:04:38 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Joe Perches <joe@perches.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 05/21] rtc: at91sam9: Switch to use %ptR
Date:   Thu, 29 Nov 2018 12:59:43 +0200
Message-Id: <20181129105956.25933-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129105956.25933-1-andriy.shevchenko@linux.intel.com>
References: <20181129105956.25933-1-andriy.shevchenko@linux.intel.com>
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
 drivers/rtc/rtc-at91sam9.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index ee71e647fd43..1d31c0ae6334 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -124,9 +124,7 @@ static int at91_rtc_readtime(struct device *dev, struct rtc_time *tm)
 
 	rtc_time_to_tm(offset + secs, tm);
 
-	dev_dbg(dev, "%s: %4d-%02d-%02d %02d:%02d:%02d\n", "readtime",
-		1900 + tm->tm_year, tm->tm_mon, tm->tm_mday,
-		tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "%s: %ptR\n", __func__, tm);
 
 	return 0;
 }
@@ -141,9 +139,7 @@ static int at91_rtc_settime(struct device *dev, struct rtc_time *tm)
 	u32 offset, alarm, mr;
 	unsigned long secs;
 
-	dev_dbg(dev, "%s: %4d-%02d-%02d %02d:%02d:%02d\n", "settime",
-		1900 + tm->tm_year, tm->tm_mon, tm->tm_mday,
-		tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "%s: %ptR\n", __func__, tm);
 
 	err = rtc_tm_to_time(tm, &secs);
 	if (err != 0)
@@ -199,9 +195,7 @@ static int at91_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	if (alarm != ALARM_DISABLED && offset != 0) {
 		rtc_time_to_tm(offset + alarm, tm);
 
-		dev_dbg(dev, "%s: %4d-%02d-%02d %02d:%02d:%02d\n", "readalarm",
-			1900 + tm->tm_year, tm->tm_mon, tm->tm_mday,
-			tm->tm_hour, tm->tm_min, tm->tm_sec);
+		dev_dbg(dev, "%s: %ptR\n", __func__, tm);
 
 		if (rtt_readl(rtc, MR) & AT91_RTT_ALMIEN)
 			alrm->enabled = 1;
@@ -242,9 +236,7 @@ static int at91_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	if (alrm->enabled)
 		rtt_writel(rtc, MR, mr | AT91_RTT_ALMIEN);
 
-	dev_dbg(dev, "%s: %4d-%02d-%02d %02d:%02d:%02d\n", "setalarm",
-		tm->tm_year, tm->tm_mon, tm->tm_mday, tm->tm_hour,
-		tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "%s: %ptR\n", __func__, tm);
 
 	return 0;
 }
-- 
2.19.2

