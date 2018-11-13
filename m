Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D018CC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4D3223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4D3223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732389AbeKNDRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:17:05 -0500
Received: from mga14.intel.com ([192.55.52.115]:10705 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732195AbeKNDQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:16:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 09:17:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,228,1539673200"; 
   d="scan'208";a="249393034"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 13 Nov 2018 09:17:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 71B67989; Tue, 13 Nov 2018 19:17:31 +0200 (EET)
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
Subject: [PATCH v3 13/20] rtc: rx6110: Switch to use %ptR
Date:   Tue, 13 Nov 2018 19:17:22 +0200
Message-Id: <20181113171729.19645-14-andriy.shevchenko@linux.intel.com>
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
 drivers/rtc/rtc-rx6110.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-rx6110.c b/drivers/rtc/rtc-rx6110.c
index 8e322d884cc2..5899ca368d59 100644
--- a/drivers/rtc/rtc-rx6110.c
+++ b/drivers/rtc/rtc-rx6110.c
@@ -114,9 +114,7 @@ struct rx6110_data {
  */
 static int rx6110_rtc_tm_to_data(struct rtc_time *tm, u8 *data)
 {
-	pr_debug("%s: date %ds %dm %dh %dmd %dm %dy\n", __func__,
-		 tm->tm_sec, tm->tm_min, tm->tm_hour,
-		 tm->tm_mday, tm->tm_mon, tm->tm_year);
+	pr_debug("%s: date %ptRr\n", __func__, tm);
 
 	/*
 	 * The year in the RTC is a value between 0 and 99.
@@ -154,9 +152,7 @@ static int rx6110_data_to_rtc_tm(u8 *data, struct rtc_time *tm)
 	tm->tm_mon = bcd2bin(data[RTC_MONTH] & 0x1f) - 1;
 	tm->tm_year = bcd2bin(data[RTC_YEAR]) + 100;
 
-	pr_debug("%s: date %ds %dm %dh %dmd %dm %dy\n", __func__,
-		 tm->tm_sec, tm->tm_min, tm->tm_hour,
-		 tm->tm_mday, tm->tm_mon, tm->tm_year);
+	pr_debug("%s: date %ptRr\n", __func__, tm);
 
 	/*
 	 * The year in the RTC is a value between 0 and 99.
@@ -248,9 +244,7 @@ static int rx6110_get_time(struct device *dev, struct rtc_time *tm)
 	if (ret)
 		return ret;
 
-	dev_dbg(dev, "%s: date %ds %dm %dh %dmd %dm %dy\n", __func__,
-		tm->tm_sec, tm->tm_min, tm->tm_hour,
-		tm->tm_mday, tm->tm_mon, tm->tm_year);
+	dev_dbg(dev, "%s: date %ptRr\n", __func__, tm);
 
 	return 0;
 }
-- 
2.19.1

