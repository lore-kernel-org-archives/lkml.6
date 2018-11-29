Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0181C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9352081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F9352081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbeK2WJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 17:09:45 -0500
Received: from mga02.intel.com ([134.134.136.20]:18595 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728235AbeK2WJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 17:09:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2018 03:04:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,294,1539673200"; 
   d="scan'208";a="97516445"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 29 Nov 2018 03:04:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9DA0B772; Thu, 29 Nov 2018 13:04:38 +0200 (EET)
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
Subject: [PATCH v5 10/21] rtc: pic32: Switch to use %ptR
Date:   Thu, 29 Nov 2018 12:59:48 +0200
Message-Id: <20181129105956.25933-11-andriy.shevchenko@linux.intel.com>
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
 drivers/rtc/rtc-pic32.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/rtc/rtc-pic32.c b/drivers/rtc/rtc-pic32.c
index 3c08eab4f1a8..d7ef0a6f8931 100644
--- a/drivers/rtc/rtc-pic32.c
+++ b/drivers/rtc/rtc-pic32.c
@@ -170,9 +170,7 @@ static int pic32_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
 
 	rtc_tm->tm_year += 100;
 
-	dev_dbg(dev, "read time %04d.%02d.%02d %02d:%02d:%02d\n",
-		1900 + rtc_tm->tm_year, rtc_tm->tm_mon, rtc_tm->tm_mday,
-		rtc_tm->tm_hour, rtc_tm->tm_min, rtc_tm->tm_sec);
+	dev_dbg(dev, "read time %ptR\n", rtc_tm);
 
 	clk_disable(pdata->clk);
 	return 0;
@@ -184,9 +182,7 @@ static int pic32_rtc_settime(struct device *dev, struct rtc_time *tm)
 	void __iomem *base = pdata->reg_base;
 	int year = tm->tm_year - 100;
 
-	dev_dbg(dev, "set time %04d.%02d.%02d %02d:%02d:%02d\n",
-		1900 + tm->tm_year, tm->tm_mon, tm->tm_mday,
-		tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "set time %ptR\n", tm);
 
 	if (year < 0 || year >= 100) {
 		dev_err(dev, "rtc only supports 100 years\n");
@@ -224,10 +220,7 @@ static int pic32_rtc_getalarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 	alrm->enabled = (alm_en & PIC32_RTCALRM_ALRMEN) ? 1 : 0;
 
-	dev_dbg(dev, "getalarm: %d, %04d.%02d.%02d %02d:%02d:%02d\n",
-		alm_en,
-		1900 + alm_tm->tm_year, alm_tm->tm_mon, alm_tm->tm_mday,
-		alm_tm->tm_hour, alm_tm->tm_min, alm_tm->tm_sec);
+	dev_dbg(dev, "getalarm: %d, %ptR\n", alm_en, alm_tm);
 
 	alm_tm->tm_sec = bcd2bin(alm_tm->tm_sec);
 	alm_tm->tm_min = bcd2bin(alm_tm->tm_min);
@@ -247,10 +240,7 @@ static int pic32_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	void __iomem *base = pdata->reg_base;
 
 	clk_enable(pdata->clk);
-	dev_dbg(dev, "setalarm: %d, %04d.%02d.%02d %02d:%02d:%02d\n",
-		alrm->enabled,
-		1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
-		tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "setalarm: %d, %ptR\n", alrm->enabled, tm);
 
 	writel(0x00, base + PIC32_ALRMTIME);
 	writel(0x00, base + PIC32_ALRMDATE);
-- 
2.19.2

