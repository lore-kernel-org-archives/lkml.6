Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AH8x2273ASeHcT7bmxHrcmq9+8jtUl/SI/KvUAKQTxtXlrP2FHIWQFxv3mFGQf0h89IP1tfi7v3+
ARC-Seal: i=1; a=rsa-sha256; t=1519163051; cv=none;
        d=google.com; s=arc-20160816;
        b=1KR0nYqy6Isg5QzrjiXyFFbDb1yYrwm8dXwjHBrf9mKTvcmw/SmhNqXdCCsCovlBnv
         +Nm4gDssG9ykGpwFMxOVQHFzrGk5/CkmL8C+GJF6iEQkWn74HNHdauehRDdXebY8WqCR
         MHyEeZp9xCD2zITAbVSa49yG2h8TfztjXMBnFszQ85EWDs7sSdDgSE9NRrBQiZqi+T9E
         Li9p6GqYGW3M8N1Y21WO5hjefy7GnztkwNgof7zTirDWuJfWY93p1wVZPYU+ySty3++8
         Vrjheamb7WJvA/AILVpurmWRq9oSLJOcgqlXQ4qSzoiRwJU1wDEhN86Es2oBY3shbRVK
         CXJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=g+abjIko0dGoFgQ/EstzvW0EY+GI8TDJb2nyVG2cVN8=;
        b=J70t9qK30V4GNG9swoWDEbVf0oxOY8DljiY3fiZfyYyfCcTVa8CHbzEBbqn2L2fEGU
         N1Qa/xr0/V/ATNCnEYHyVgI6GI7+xykE+Ks0JnVuSYHjUM5oW5sItgQaZkZpuJg1XyVL
         lnEGetNAW75wfnAmMZWwFSPXa69UEwzwMiHXQbTlcUvdA2pPDwSTpwzmPoK2z1SFd0GM
         bjk8PMTOUIs3aXUrELBVQUjgDhV6oWQioTkj17AIdf4EOBVpqBQQh1jXTO8rdCfm5oe1
         8LpduUouvVdQURJflza5QeqkC0fQ/GutrLarIN1rYo1lEZtBI+qM7xQSbILZuW9RyEP5
         6cZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,541,1511856000";
   d="scan'208";a="31520283"
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
Subject: [PATCH v2 14/21] rtc: rx8025: Switch to use %ptR
Date: Tue, 20 Feb 2018 23:43:53 +0200
Message-Id: <20180220214400.66749-15-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592957915627620528?=
X-GMAIL-MSGID: =?utf-8?q?1592957915627620528?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use %ptR instead of open coded variant to print content of
struct rtc_time in human readable format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-rx8025.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/rtc/rtc-rx8025.c b/drivers/rtc/rtc-rx8025.c
index 91857d8d2df8..a44125eba15c 100644
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
 
 	return rtc_valid_tm(dt);
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
2.15.1
