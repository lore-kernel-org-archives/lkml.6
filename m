Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AH8x227qrCgs8oNbU2R6vWfaEQt+7DlJEq/dN2+B8ccid6EDe72Gg2k02lUA22gp/5XhX+0RDHvw
ARC-Seal: i=1; a=rsa-sha256; t=1519163049; cv=none;
        d=google.com; s=arc-20160816;
        b=ttaVJ2pVedXUYqQ+MetGg59mJXuMpgdckJseMJ3VxnqV+7cVytl0WLx0kU3NPaXcg1
         fjSyGzL/b/32i8wJ3XQiukkl2Jnxe2BnJaxsVCi8UHzgdInL74o3adxaAi5RtcgwHuXe
         G9Lwfz/uSSrp3quPJ31s/7EAHDhblRVc+g9jR+13HyvGIBynUBQiHy6padaYg+WHBnM5
         e5rVZLWa2wWAVxNVIEb8svNaj63JrbLkf2IiOXjwo4DEN0Cd9GeZ4dw5/CsyknRmXD6G
         9wPzdUE62sdFiDuaMr4izX6+JdeBydqKNYnImrf8Jn1H1HO/rsTQeDmNnKmnGodgftHu
         7KHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=pvMn9b+NPIs9WVA0JGwP1idautQv10i0uoYjSyUQmLQ=;
        b=OZhoyX4Cc707Olj4o3AHKNlZ6UJreeO7kgYt4IHMyURy+UuIvhhi4VXO0GOt9r2Q7t
         IQyxnNwlCMPShctPQ0dnTrep8jAaguZCdOlchbLgbi5PIWocSKTaoHHyMh+jUIS9xoVY
         skGy671+QiaSeYw4O7XijVxT+RkGIk8Sh40zSCvPOeTzUpPXs6oCrNt4n6raInbqfiXA
         viHXWRCO+5I53BErmAuk0WKZUnTZAb3Or8FPHweb0DlpXEhjD/lXt7RQLSvnv9yWfAEk
         v4HDnvs4bv0JEDUiPbdTNbK8b0ePodlMIBLdIoMPIXChudPaWSLOwBOqsDgJVr5uxLFA
         VP7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,541,1511856000";
   d="scan'208";a="19827916"
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
Subject: [PATCH v2 08/21] rtc: pcf50633: Switch to use %ptR
Date: Tue, 20 Feb 2018 23:43:47 +0200
Message-Id: <20180220214400.66749-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592957913342036676?=
X-GMAIL-MSGID: =?utf-8?q?1592957913342036676?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use %ptR instead of open coded variant to print content of
struct rtc_time in human readable format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-pcf50633.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-pcf50633.c b/drivers/rtc/rtc-pcf50633.c
index 00c31c91b245..ace2080daf10 100644
--- a/drivers/rtc/rtc-pcf50633.c
+++ b/drivers/rtc/rtc-pcf50633.c
@@ -131,9 +131,7 @@ static int pcf50633_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 	pcf2rtc_time(tm, &pcf_tm);
 
-	dev_dbg(dev, "RTC_TIME: %u.%u.%u %u:%u:%u\n",
-		tm->tm_mday, tm->tm_mon, tm->tm_year,
-		tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "RTC_TIME: %ptRr\n", tm);
 
 	return rtc_valid_tm(tm);
 }
@@ -146,9 +144,7 @@ static int pcf50633_rtc_set_time(struct device *dev, struct rtc_time *tm)
 
 	rtc = dev_get_drvdata(dev);
 
-	dev_dbg(dev, "RTC_TIME: %u.%u.%u %u:%u:%u\n",
-		tm->tm_mday, tm->tm_mon, tm->tm_year,
-		tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "RTC_TIME: %ptRr\n", tm);
 
 	rtc2pcf_time(&pcf_tm, tm);
 
-- 
2.15.1
