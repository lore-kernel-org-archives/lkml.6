Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AH8x224NLGViKpGxj39yBPUtD7z7req/xuVSDT4/q/dnO5vk3tKEZ7pe0pAsEBkpE66JJNafGqnw
ARC-Seal: i=1; a=rsa-sha256; t=1519163052; cv=none;
        d=google.com; s=arc-20160816;
        b=yNH4hHqS+nvfSVRsUpr+tghJ/jzoYwkr+IWUW+qWElzhSG2yKORf8lWXZ3QpFeJk+N
         0TA29XMjbJ2cBtXT8wwhdfgpJ3gbuAf3VCVf0yEGuo9uPRdGJ+7mslkVPwFSYUk15TtZ
         EpWMZPPiAPtfbFPPMRv/ZenC3xNcY1ivAOl9SO6eUkOGh0G8+ZoEIwjCcLHFRzbHtI5G
         uusjI5vn7YDW3pS3LFPbp+LeGmBEY56Ju945TxBCyrAsNWTdrx2UAyBMpkpmr1HdiGbY
         FR7VQqJx2jiLSmfpJahAcnCTQb2GGwt54QHk4Xf1lcAnFrBxKqCCrTVi9nRYuBlOh+rS
         zF0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=xfNNvcWLqYSJy2kO7cLb03D/RiWQt+qGf8F6nXEOoAI=;
        b=Qi2vd+En4RVwLm1hgs8cUov0l6IsvqBpWnGsL6KwnNMp5MBJtYSBfTVub3/0qIRVnp
         aV07YcH/x99SdEoSqPeVY5jpSOnx7hywTHQ4naXOyChrr+HRFSLL3TfGAE1zZE6Utc1T
         u8+wQbYtB5OfLvQcUdwtGqMlZ2/7RZSv9vx8mvUQKFQknlEvtOpKVQ7RrF+lxv9jFCrQ
         jcAy5B5Xv0JjjS+JZe056PXVAm5KAKgXs0yRod3ZyxPur1ef4Hh4IN9sRh73OTrSZM3h
         V485sTKOLidbPhEnfUg7FYGudxVP5aRq97fydC2Vnasi3KxdXnopi6qLdr1dyw0N6QpR
         meTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,541,1511856000";
   d="scan'208";a="28597072"
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
Subject: [PATCH v2 18/21] ds1302: Switch to use %ptR
Date: Tue, 20 Feb 2018 23:43:57 +0200
Message-Id: <20180220214400.66749-19-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592957917331093375?=
X-GMAIL-MSGID: =?utf-8?q?1592957917331093375?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use %ptR instead of open coded variant to print content of
struct rtc_time in human readable format.

Cc: Arnd Bergmann <arnd@arndb.de>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/char/Kconfig  |  1 +
 drivers/char/ds1302.c | 39 ++++++++++-----------------------------
 2 files changed, 11 insertions(+), 29 deletions(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index c96e00ebeae9..2bd83d3951c1 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -350,6 +350,7 @@ config EFI_RTC
 config DS1302
 	tristate "DS1302 RTC support"
 	depends on M32R && (PLAT_M32700UT || PLAT_OPSPUT)
+	select PRINTK_PEXT_TIMEDATE
 	help
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 121 and minor number 0 using mknod ("man mknod"), you
diff --git a/drivers/char/ds1302.c b/drivers/char/ds1302.c
index 8e16ad5d6d89..1e8bd9bf4bc9 100644
--- a/drivers/char/ds1302.c
+++ b/drivers/char/ds1302.c
@@ -5,7 +5,7 @@
 *!
 *! DESCRIPTION: Implements an interface for the DS1302 RTC
 *!
-*! Functions exported: ds1302_readreg, ds1302_writereg, ds1302_init, get_rtc_status
+*! Functions exported: ds1302_readreg, ds1302_writereg, ds1302_init
 *!
 *! ---------------------------------------------------------------------------
 *!
@@ -258,31 +258,6 @@ static long rtc_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	}
 }
 
-int
-get_rtc_status(char *buf)
-{
-	char *p;
-	struct rtc_time tm;
-
-	p = buf;
-
-	get_rtc_time(&tm);
-
-	/*
-	 * There is no way to tell if the luser has the RTC set for local
-	 * time or for Universal Standard Time (GMT). Probably local though.
-	 */
-
-	p += sprintf(p,
-		"rtc_time\t: %02d:%02d:%02d\n"
-		"rtc_date\t: %04d-%02d-%02d\n",
-		tm.tm_hour, tm.tm_min, tm.tm_sec,
-		tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday);
-
-	return  p - buf;
-}
-
-
 /* The various file operations we support. */
 
 static const struct file_operations rtc_fops = {
@@ -299,6 +274,7 @@ static int __init
 ds1302_probe(void)
 {
 	int retval, res, baur;
+	struct rtc_time tm;
 
 	baur=(boot_cpu_data.bus_clock/(2*1000*1000));
 
@@ -317,11 +293,16 @@ ds1302_probe(void)
 
 	/* read RAM byte 0 */
 	if((res = in_byte_rtc(0xc1)) == MAGIC_PATTERN) {
-		char buf[100];
 		ds1302_wdisable();
 		printk("%s: RTC found.\n", ds1302_name);
-		get_rtc_status(buf);
-		printk(buf);
+		/*
+		 * There is no way to tell if the luser has the RTC set
+		 * for local time or for Universal Standard Time (GMT).
+		 * Probably local though.
+		 */
+		get_rtc_time(&tm);
+		printk("rtc_time\t: %ptRt\n", &tm);
+		printk("rtc_date\t: %ptRd\n", &tm);
 		retval = 1;
 	} else {
 		printk("%s: RTC not found.\n", ds1302_name);
-- 
2.15.1
