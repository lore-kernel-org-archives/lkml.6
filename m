Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28624C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE55F2081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE55F2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbeK2WKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 17:10:54 -0500
Received: from mga18.intel.com ([134.134.136.126]:63383 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbeK2WJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 17:09:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2018 03:04:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,294,1539673200"; 
   d="scan'208";a="96699581"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 29 Nov 2018 03:04:40 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7CB0D4E7; Thu, 29 Nov 2018 13:04:38 +0200 (EET)
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
Subject: [PATCH v5 08/21] rtc: mcp795: Switch to use %ptR
Date:   Thu, 29 Nov 2018 12:59:46 +0200
Message-Id: <20181129105956.25933-9-andriy.shevchenko@linux.intel.com>
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
 drivers/rtc/rtc-mcp795.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-mcp795.c b/drivers/rtc/rtc-mcp795.c
index 00e11c1b2186..f22a945a3794 100644
--- a/drivers/rtc/rtc-mcp795.c
+++ b/drivers/rtc/rtc-mcp795.c
@@ -233,9 +233,7 @@ static int mcp795_set_time(struct device *dev, struct rtc_time *tim)
 	if (ret)
 		return ret;
 
-	dev_dbg(dev, "Set mcp795: %04d-%02d-%02d(%d) %02d:%02d:%02d\n",
-			tim->tm_year + 1900, tim->tm_mon, tim->tm_mday,
-			tim->tm_wday, tim->tm_hour, tim->tm_min, tim->tm_sec);
+	dev_dbg(dev, "Set mcp795: %ptR\n", tim);
 
 	return 0;
 }
@@ -258,9 +256,7 @@ static int mcp795_read_time(struct device *dev, struct rtc_time *tim)
 	tim->tm_mon	= bcd2bin(data[5] & 0x1F) - 1;
 	tim->tm_year	= bcd2bin(data[6]) + 100; /* Assume we are in 20xx */
 
-	dev_dbg(dev, "Read from mcp795: %04d-%02d-%02d(%d) %02d:%02d:%02d\n",
-			tim->tm_year + 1900, tim->tm_mon, tim->tm_mday,
-			tim->tm_wday, tim->tm_hour, tim->tm_min, tim->tm_sec);
+	dev_dbg(dev, "Read from mcp795: %ptR\n", tim);
 
 	return 0;
 }
@@ -319,9 +315,8 @@ static int mcp795_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 			return ret;
 		dev_dbg(dev, "Alarm IRQ armed\n");
 	}
-	dev_dbg(dev, "Set alarm: %02d-%02d(%d) %02d:%02d:%02d\n",
-			alm->time.tm_mon, alm->time.tm_mday, alm->time.tm_wday,
-			alm->time.tm_hour, alm->time.tm_min, alm->time.tm_sec);
+	dev_dbg(dev, "Set alarm: %ptRdr(%d) %ptRt\n",
+		&alm->time, alm->time.tm_wday, &alm->time);
 	return 0;
 }
 
@@ -345,9 +340,8 @@ static int mcp795_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	alm->time.tm_isdst	= -1;
 	alm->time.tm_yday	= -1;
 
-	dev_dbg(dev, "Read alarm: %02d-%02d(%d) %02d:%02d:%02d\n",
-			alm->time.tm_mon, alm->time.tm_mday, alm->time.tm_wday,
-			alm->time.tm_hour, alm->time.tm_min, alm->time.tm_sec);
+	dev_dbg(dev, "Read alarm: %ptRdr(%d) %ptRt\n",
+		&alm->time, alm->time.tm_wday, &alm->time);
 	return 0;
 }
 
-- 
2.19.2

