Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8365C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B49E620851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B49E620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbeLDV3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:29:45 -0500
Received: from mga04.intel.com ([192.55.52.120]:21301 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbeLDV3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 16:29:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 13:23:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,315,1539673200"; 
   d="scan'208";a="280939607"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 04 Dec 2018 13:23:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0D8B37F8; Tue,  4 Dec 2018 23:23:32 +0200 (EET)
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
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH v6 17/20] rtc: tegra: Switch to use %ptR
Date:   Tue,  4 Dec 2018 23:23:27 +0200
Message-Id: <20181204212330.69515-18-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204212330.69515-1-andriy.shevchenko@linux.intel.com>
References: <20181204212330.69515-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use %ptR instead of open coded variant to print content of
struct rtc_time in human readable format.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/rtc/rtc-tegra.c | 30 +++---------------------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/drivers/rtc/rtc-tegra.c b/drivers/rtc/rtc-tegra.c
index c9e77a83cd1b..c6b0a99aa3a9 100644
--- a/drivers/rtc/rtc-tegra.c
+++ b/drivers/rtc/rtc-tegra.c
@@ -125,15 +125,7 @@ static int tegra_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 	rtc_time_to_tm(sec, tm);
 
-	dev_vdbg(dev, "time read as %lu. %d/%d/%d %d:%02u:%02u\n",
-		sec,
-		tm->tm_mon + 1,
-		tm->tm_mday,
-		tm->tm_year + 1900,
-		tm->tm_hour,
-		tm->tm_min,
-		tm->tm_sec
-	);
+	dev_vdbg(dev, "time read as %lu. %ptR\n", sec, tm);
 
 	return 0;
 }
@@ -147,15 +139,7 @@ static int tegra_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	/* convert tm to seconds. */
 	rtc_tm_to_time(tm, &sec);
 
-	dev_vdbg(dev, "time set to %lu. %d/%d/%d %d:%02u:%02u\n",
-		sec,
-		tm->tm_mon+1,
-		tm->tm_mday,
-		tm->tm_year+1900,
-		tm->tm_hour,
-		tm->tm_min,
-		tm->tm_sec
-	);
+	dev_vdbg(dev, "time set to %lu. %ptR\n", sec, tm);
 
 	/* seconds only written if wait succeeded. */
 	ret = tegra_rtc_wait_while_busy(dev);
@@ -232,15 +216,7 @@ static int tegra_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	/* if successfully written and alarm is enabled ... */
 	if (sec) {
 		tegra_rtc_alarm_irq_enable(dev, 1);
-
-		dev_vdbg(dev, "alarm set as %lu. %d/%d/%d %d:%02u:%02u\n",
-			sec,
-			alarm->time.tm_mon+1,
-			alarm->time.tm_mday,
-			alarm->time.tm_year+1900,
-			alarm->time.tm_hour,
-			alarm->time.tm_min,
-			alarm->time.tm_sec);
+		dev_vdbg(dev, "alarm set as %lu. %ptR\n", sec, &alarm->time);
 	} else {
 		/* disable alarm if 0 or write error. */
 		dev_vdbg(dev, "alarm disabled\n");
-- 
2.19.2

