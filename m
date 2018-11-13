Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF691C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C6A2082A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C6A2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732265AbeKNDQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:16:43 -0500
Received: from mga18.intel.com ([134.134.136.126]:65091 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732198AbeKNDQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:16:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 09:17:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,228,1539673200"; 
   d="scan'208";a="108246606"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 13 Nov 2018 09:17:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7B2139F1; Tue, 13 Nov 2018 19:17:31 +0200 (EET)
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
Subject: [PATCH v3 14/20] rtc: rx8025: Switch to use %ptR
Date:   Tue, 13 Nov 2018 19:17:23 +0200
Message-Id: <20181113171729.19645-15-andriy.shevchenko@linux.intel.com>
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
 drivers/rtc/rtc-rx8025.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/rtc/rtc-rx8025.c b/drivers/rtc/rtc-rx8025.c
index 41127adf5765..41de38acc570 100644
--- a/drivers/rtc/rtc-rx8025.c
+++ b/drivers/rtc/rtc-rx8025.c
@@ -193,10 +193,7 @@ static int rx8025_get_time(struct device *dev, struct rtc_time *dt)
 	if (err)
 		return err;
 
-	dev_dbg(dev, "%s: read 0x%02x 0x%02x "
-		"0x%02x 0x%02x 0x%02x 0x%02x 0x%02x\n", __func__,
-		date[0], date[1], date[2], date[3], date[4],
-		date[5], date[6]);
+	dev_dbg(dev, "%s: read %7ph\n", __func__, date);
 
 	dt->tm_sec = bcd2bin(date[RX8025_REG_SEC] & 0x7f);
 	dt->tm_min = bcd2bin(date[RX8025_REG_MIN] & 0x7f);
@@ -210,9 +207,7 @@ static int rx8025_get_time(struct device *dev, struct rtc_time *dt)
 	dt->tm_mon = bcd2bin(date[RX8025_REG_MONTH] & 0x1f) - 1;
 	dt->tm_year = bcd2bin(date[RX8025_REG_YEAR]) + 100;
 
-	dev_dbg(dev, "%s: date %ds %dm %dh %dmd %dm %dy\n", __func__,
-		dt->tm_sec, dt->tm_min, dt->tm_hour,
-		dt->tm_mday, dt->tm_mon, dt->tm_year);
+	dev_dbg(dev, "%s: date %ptRr\n", __func__, dt);
 
 	return 0;
 }
@@ -243,10 +238,7 @@ static int rx8025_set_time(struct device *dev, struct rtc_time *dt)
 	date[RX8025_REG_MONTH] = bin2bcd(dt->tm_mon + 1);
 	date[RX8025_REG_YEAR] = bin2bcd(dt->tm_year - 100);
 
-	dev_dbg(dev,
-		"%s: write 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x\n",
-		__func__,
-		date[0], date[1], date[2], date[3], date[4], date[5], date[6]);
+	dev_dbg(dev, "%s: write %7ph\n", __func__, date);
 
 	ret = rx8025_write_regs(rx8025->client, RX8025_REG_SEC, 7, date);
 	if (ret < 0)
@@ -319,10 +311,7 @@ static int rx8025_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 		t->time.tm_hour = bcd2bin(ald[1] & 0x1f) % 12
 			+ (ald[1] & 0x20 ? 12 : 0);
 
-	dev_dbg(dev, "%s: date: %ds %dm %dh %dmd %dm %dy\n",
-		__func__,
-		t->time.tm_sec, t->time.tm_min, t->time.tm_hour,
-		t->time.tm_mday, t->time.tm_mon, t->time.tm_year);
+	dev_dbg(dev, "%s: date: %ptRr\n", __func__, t);
 	t->enabled = !!(rx8025->ctrl1 & RX8025_BIT_CTRL1_DALE);
 	t->pending = (ctrl2 & RX8025_BIT_CTRL2_DAFG) && t->enabled;
 
-- 
2.19.1

