Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AH8x227k+G4l77EjNyguu4ud+z+hxZFonbI5StYSFFCIYWSr+vFzWEoeUTHH/CY4K0SH1eWLZ6x+
ARC-Seal: i=1; a=rsa-sha256; t=1519163051; cv=none;
        d=google.com; s=arc-20160816;
        b=zgsBcTwHKFonjrOL79RiyqSGOSV6Tq1XeXIQRhu66kNeECzosSrAXhp2HaVVoR6nRI
         1cmdgAKCNxBNCDw1V9LojaLCdKfIlzLQzsONh8V8wlgpMoyNl8beFL14QS6c4Q7AP9+k
         +04FrwsvmX8K8bybXvjbnh14BWCtDHYbdDG0CuzEjoym0BOy6FUs/Pi3SnOF25HLbxAU
         SJHz0tMbpxnnPYTIVXpjVWyAvRxsNl/CW3pvB168vG9mluSrkylEDFWMco6ovRxK1RU5
         b+7rJLonrZWxBxOyUDg2/s4aotWbnnq1uf/OdBlPqzqVIspwnZ9fsnqRPt/H+njwXlkk
         8L2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=t6NbQ0xNKUS0ThMqNw7uw1KaeGkeg2VocFu82D+rNyo=;
        b=WUKS2J5w3w4gAgHwTxZtGXFDqo6w8yVOch5ahQEX/PPX/r9rIjBLO+E4l2B2Pa3Ztj
         O94lcgVNbxA3c9Lj4cjIVebIifTJjkUvTGtT9yWXCWsQOOD41LgBhujfOOIJCNXyjZOg
         9cLJEzV49KHVW+sYur1CdXijnyu5vRNkLZsXGSbE3dDBM8jfElxcciUS5BGhfi9WMC4V
         DXVAEJ3cZ7mq40dv48Bku03bJ5FDSV4HIoLnjySvfQrOdOMzGAX0Sur4ugWjIpCYP4K/
         eP5dBBWj7abmqYt6nUKkns55Nn0jKC4niewBEw40HpH+OwwwR1s7vZ648RXBzCL3dZNS
         qTVg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,541,1511856000";
   d="scan'208";a="32870263"
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
Subject: [PATCH v2 13/21] rtc: rx6110: Switch to use %ptR
Date: Tue, 20 Feb 2018 23:43:52 +0200
Message-Id: <20180220214400.66749-14-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592957915897089222?=
X-GMAIL-MSGID: =?utf-8?q?1592957915897089222?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use %ptR instead of open coded variant to print content of
struct rtc_time in human readable format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-rx6110.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-rx6110.c b/drivers/rtc/rtc-rx6110.c
index 7c9c08eab5e5..1705358fc706 100644
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
 
 	return rtc_valid_tm(tm);
 }
-- 
2.15.1
