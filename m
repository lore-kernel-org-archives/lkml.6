Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880FFC07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D10A20834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D10A20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbeLDVYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:24:00 -0500
Received: from mga05.intel.com ([192.55.52.43]:63757 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726425AbeLDVX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 16:23:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 13:23:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,315,1539673200"; 
   d="scan'208";a="107299329"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 04 Dec 2018 13:23:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 008D97EE; Tue,  4 Dec 2018 23:23:31 +0200 (EET)
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
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v6 16/20] rtc: s5m: Switch to use %ptR
Date:   Tue,  4 Dec 2018 23:23:26 +0200
Message-Id: <20181204212330.69515-17-andriy.shevchenko@linux.intel.com>
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

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-s5m.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
index 6495f84f7428..c7f1bf823ea0 100644
--- a/drivers/rtc/rtc-s5m.c
+++ b/drivers/rtc/rtc-s5m.c
@@ -406,9 +406,7 @@ static int s5m_rtc_read_time(struct device *dev, struct rtc_time *tm)
 		return -EINVAL;
 	}
 
-	dev_dbg(dev, "%s: %d/%d/%d %d:%d:%d(%d)\n", __func__,
-		1900 + tm->tm_year, 1 + tm->tm_mon, tm->tm_mday,
-		tm->tm_hour, tm->tm_min, tm->tm_sec, tm->tm_wday);
+	dev_dbg(dev, "%s: %ptR(%d)\n", __func__, tm, tm->tm_wday);
 
 	return 0;
 }
@@ -436,9 +434,7 @@ static int s5m_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	if (ret < 0)
 		return ret;
 
-	dev_dbg(dev, "%s: %d/%d/%d %d:%d:%d(%d)\n", __func__,
-		1900 + tm->tm_year, 1 + tm->tm_mon, tm->tm_mday,
-		tm->tm_hour, tm->tm_min, tm->tm_sec, tm->tm_wday);
+	dev_dbg(dev, "%s: %ptR(%d)\n", __func__, tm, tm->tm_wday);
 
 	ret = regmap_raw_write(info->regmap, info->regs->time, data,
 			info->regs->regs_count);
@@ -490,11 +486,7 @@ static int s5m_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 		return -EINVAL;
 	}
 
-	dev_dbg(dev, "%s: %d/%d/%d %d:%d:%d(%d)\n", __func__,
-		1900 + alrm->time.tm_year, 1 + alrm->time.tm_mon,
-		alrm->time.tm_mday, alrm->time.tm_hour,
-		alrm->time.tm_min, alrm->time.tm_sec,
-		alrm->time.tm_wday);
+	dev_dbg(dev, "%s: %ptR(%d)\n", __func__, &alrm->time, alrm->time.tm_wday);
 
 	ret = s5m_check_peding_alarm_interrupt(info, alrm);
 
@@ -513,9 +505,7 @@ static int s5m_rtc_stop_alarm(struct s5m_rtc_info *info)
 		return ret;
 
 	s5m8767_data_to_tm(data, &tm, info->rtc_24hr_mode);
-	dev_dbg(info->dev, "%s: %d/%d/%d %d:%d:%d(%d)\n", __func__,
-		1900 + tm.tm_year, 1 + tm.tm_mon, tm.tm_mday,
-		tm.tm_hour, tm.tm_min, tm.tm_sec, tm.tm_wday);
+	dev_dbg(info->dev, "%s: %ptR(%d)\n", __func__, &tm, tm.tm_wday);
 
 	switch (info->device_type) {
 	case S5M8763X:
@@ -558,9 +548,7 @@ static int s5m_rtc_start_alarm(struct s5m_rtc_info *info)
 		return ret;
 
 	s5m8767_data_to_tm(data, &tm, info->rtc_24hr_mode);
-	dev_dbg(info->dev, "%s: %d/%d/%d %d:%d:%d(%d)\n", __func__,
-		1900 + tm.tm_year, 1 + tm.tm_mon, tm.tm_mday,
-		tm.tm_hour, tm.tm_min, tm.tm_sec, tm.tm_wday);
+	dev_dbg(info->dev, "%s: %ptR(%d)\n", __func__, &tm, tm.tm_wday);
 
 	switch (info->device_type) {
 	case S5M8763X:
@@ -620,10 +608,7 @@ static int s5m_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 		return -EINVAL;
 	}
 
-	dev_dbg(dev, "%s: %d/%d/%d %d:%d:%d(%d)\n", __func__,
-		1900 + alrm->time.tm_year, 1 + alrm->time.tm_mon,
-		alrm->time.tm_mday, alrm->time.tm_hour, alrm->time.tm_min,
-		alrm->time.tm_sec, alrm->time.tm_wday);
+	dev_dbg(dev, "%s: %ptR(%d)\n", __func__, &alrm->time, alrm->time.tm_wday);
 
 	ret = s5m_rtc_stop_alarm(info);
 	if (ret < 0)
-- 
2.19.2

