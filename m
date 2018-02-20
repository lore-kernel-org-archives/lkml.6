Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AH8x225PWwYF5p9skZnje4zqd+SH1Px9JiB0xf0SR4uRnl5NUqCx9nblZwTamZj2/6qs++g5qV8P
ARC-Seal: i=1; a=rsa-sha256; t=1519163045; cv=none;
        d=google.com; s=arc-20160816;
        b=SeIa2KIvgd0sq4ZD4PqzjYO5/PB9+uXU2j4WL6QBx6SGcbgHWF0hBzsVVmSRR3KT1m
         YAFpVCwTuZQLMZH5/LKPLwqWytFEs5lXhrAgDgVBYb7NqCzz+Tlk+vMr8t/LYlGq+vMI
         ZatgKOUnZmfm0w1M9uyWyLXtCM3FZ2wZBcx8V9NZehXgrAbxDWJT0F/jkmZ+wW6Qx9Dj
         nencLBODUihTAGq/+NsIZdajXWgotib6MV8NLjwjWrd06d9VNz3LbhRZ34ckhbDusBNs
         c6hISZU99TqeeKDi4phdbkmGwn5DxjYhf36h2VgD/FLc2Jo16HtyU2h++n4kWcUu07LA
         YrKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=ACEcN1JeGi7z/+EP0SDGacjtuKMn77mH5XcFQHebqtg=;
        b=VS+edfx/39nkV62dIfi7/+s8V89Q/vSKnbMlGaWAs0Z5cig+BKd1ptWXzvJhjksiXa
         GiPbksfFgTXk385E8qMMlBZdUR3o0D7sO6bXTlg/Y2idHXMe2c6WLE7HnPVSujK0rnid
         cxsjuOOnZ4xMm6qMXR/9Lkn6MYJHrfcsxBYt8sngFw9a98RGfXDQCnOlg/daQKkWKtvS
         i5wlMfTfGuPZQVLntVvuRuKJAKaL290ETF8kIxoEiGT+8sO+kDdGSGV4lUEiw9AqEed7
         X8TdmRqnsRrFMAGDkHOS/kX3FApT7bOAAKLVBJRkR/r/iP70ZIVhRxKLUwl3gOrXg0Ms
         /GOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,541,1511856000";
   d="scan'208";a="19211158"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-rtc@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Joe Perches <joe@perches.com>,
	Mark Salyzyn <salyzyn@android.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 04/21] rtc: at91sam9: Switch to use %ptR
Date: Tue, 20 Feb 2018 23:43:43 +0200
Message-Id: <20180220214400.66749-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592957909653262367?=
X-GMAIL-MSGID: =?utf-8?q?1592957909653262367?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use %ptR instead of open coded variant to print content of
struct rtc_time in human readable format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-at91sam9.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index 7418a763ce52..8d8994f79619 100644
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
2.15.1
