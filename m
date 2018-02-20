Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AH8x224p52MZesUFqN9E7cw6aNRvUE92EHb+oShw6iNLhV2v8SoPfC2ILZk9AnWeU53wzlS2Ab1j
ARC-Seal: i=1; a=rsa-sha256; t=1519163046; cv=none;
        d=google.com; s=arc-20160816;
        b=L5Dh0JPf5ve9ln/lWY3sr9DADqq+5odFWc2tglCRuaZnS8XuW+QLGDKOMlym4vPVME
         A99L8+iZ4cjECSRhMf0mcgtdZOJIwkg+peTnGxxv7oropnz9g0dku1x6+LQq/mTaz/bc
         R7MAhm+LFeBBnAnlOvjykVJtpPpqdsNr/DeXNvUFhzgmZKqMHNNnDOkArj78ixWbrVUa
         ef2Smscg56lrxcPdfKdqMHNpXszanSWzzMhSDViJ8G6TKfU50h0P0G/QoaqFQamv+jJG
         Lw4CrDDGS+0EA7DIg6JgyL1Xa6me9iTaB28LfdK/mZPj8BT654VwKidlVjqi8iiFuyYM
         2tcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Rfcgi9XlG32BXzgAis4TspNm25i1gO8WM5hp7LmWoFU=;
        b=X0WGCTc69/86IorkUN8V4P5B1RfHkOeHJZTUAM8WiX7TqC2wy17JtgjbRG8HbP+C+h
         /t8SH3585zUXxVuhrcWRcLLSiZ1AZGyE+MItwgR6ajBr9yKmWKFt0oDvjm3hf4CneIIU
         OMOLrB0Eehk5wrCfHeNQg+V0WbX0axKB/73sg96nMMKRjHx/yX4mkfeApPLgsyhZ2tlJ
         ADsbI6vlcRIbnfp4QT2tU5COXvt5GAazEzw1Q3dFGk8wB3LiVb61Lj+M+URtJYHGqUE0
         5AEjAIaGVFa6F+I72YBtq4HV2T+MAyFy9/O1xGU0HkMDJQ6PRoiQboCkcFpGYIBWSFFn
         MXtw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,541,1511856000";
   d="scan'208";a="36180329"
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
Subject: [PATCH v2 02/21] rtc: Switch to use %ptR
Date: Tue, 20 Feb 2018 23:43:41 +0200
Message-Id: <20180220214400.66749-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592957910723724835?=
X-GMAIL-MSGID: =?utf-8?q?1592957910723724835?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use %ptR instead of open coded variant to print content of
struct rtc_time in human readable format.

Cc: Arnd Bergmann <arnd@arndb.de>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/char/Kconfig    |  1 +
 drivers/char/rtc.c      |  7 +++----
 drivers/rtc/Kconfig     |  1 +
 drivers/rtc/hctosys.c   |  8 ++------
 drivers/rtc/interface.c |  8 ++------
 drivers/rtc/rtc-proc.c  | 36 +++++-------------------------------
 drivers/rtc/rtc-sysfs.c | 12 ++++--------
 7 files changed, 18 insertions(+), 55 deletions(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index c28dca0c613d..c96e00ebeae9 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -297,6 +297,7 @@ if RTC_LIB=n
 config RTC
 	tristate "Enhanced Real Time Clock Support (legacy PC RTC driver)"
 	depends on ALPHA || (MIPS && MACH_LOONGSON64)
+	select PRINTK_PEXT_TIMEDATE
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
diff --git a/drivers/char/rtc.c b/drivers/char/rtc.c
index 57dc546628b5..379023328a6f 100644
--- a/drivers/char/rtc.c
+++ b/drivers/char/rtc.c
@@ -1148,11 +1148,10 @@ static int rtc_proc_show(struct seq_file *seq, void *v)
 	 * time or for Universal Standard Time (GMT). Probably local though.
 	 */
 	seq_printf(seq,
-		   "rtc_time\t: %02d:%02d:%02d\n"
-		   "rtc_date\t: %04d-%02d-%02d\n"
+		   "rtc_time\t: %ptRt\n"
+		   "rtc_date\t: %ptRd\n"
 		   "rtc_epoch\t: %04lu\n",
-		   tm.tm_hour, tm.tm_min, tm.tm_sec,
-		   tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday, epoch);
+		   &tm, &tm, epoch);
 
 	get_rtc_alm_time(&tm);
 
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index f6d7e490e714..da9e49e7c30e 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -4,6 +4,7 @@
 
 config RTC_LIB
 	bool
+	select PRINTK_PEXT_TIMEDATE
 
 config RTC_MC146818_LIB
 	bool
diff --git a/drivers/rtc/hctosys.c b/drivers/rtc/hctosys.c
index e1cfa06810ef..9989109781b8 100644
--- a/drivers/rtc/hctosys.c
+++ b/drivers/rtc/hctosys.c
@@ -51,12 +51,8 @@ static int __init rtc_hctosys(void)
 
 	err = do_settimeofday64(&tv64);
 
-	dev_info(rtc->dev.parent,
-		"setting system clock to "
-		"%d-%02d-%02d %02d:%02d:%02d UTC (%lld)\n",
-		tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
-		tm.tm_hour, tm.tm_min, tm.tm_sec,
-		(long long) tv64.tv_sec);
+	dev_info(rtc->dev.parent, "setting system clock to %ptR UTC (%lld)\n",
+		 &tm, (long long)tv64.tv_sec);
 
 err_read:
 	rtc_class_close(rtc);
diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 7e253be19ba7..ea4afe3893f2 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -297,12 +297,8 @@ int __rtc_read_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 	err = rtc_valid_tm(&alarm->time);
 
 done:
-	if (err) {
-		dev_warn(&rtc->dev, "invalid alarm value: %d-%d-%d %d:%d:%d\n",
-			alarm->time.tm_year + 1900, alarm->time.tm_mon + 1,
-			alarm->time.tm_mday, alarm->time.tm_hour, alarm->time.tm_min,
-			alarm->time.tm_sec);
-	}
+	if (err)
+		dev_warn(&rtc->dev, "invalid alarm value: %ptR\n", &alarm->time);
 
 	return err;
 }
diff --git a/drivers/rtc/rtc-proc.c b/drivers/rtc/rtc-proc.c
index 31e7e23cc5be..2aed9a0042d8 100644
--- a/drivers/rtc/rtc-proc.c
+++ b/drivers/rtc/rtc-proc.c
@@ -50,41 +50,15 @@ static int rtc_proc_show(struct seq_file *seq, void *offset)
 	err = rtc_read_time(rtc, &tm);
 	if (err == 0) {
 		seq_printf(seq,
-			"rtc_time\t: %02d:%02d:%02d\n"
-			"rtc_date\t: %04d-%02d-%02d\n",
-			tm.tm_hour, tm.tm_min, tm.tm_sec,
-			tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday);
+				"rtc_time\t: %ptRt\n"
+				"rtc_date\t: %ptRd\n",
+				&tm, &tm);
 	}
 
 	err = rtc_read_alarm(rtc, &alrm);
 	if (err == 0) {
-		seq_printf(seq, "alrm_time\t: ");
-		if ((unsigned int)alrm.time.tm_hour <= 24)
-			seq_printf(seq, "%02d:", alrm.time.tm_hour);
-		else
-			seq_printf(seq, "**:");
-		if ((unsigned int)alrm.time.tm_min <= 59)
-			seq_printf(seq, "%02d:", alrm.time.tm_min);
-		else
-			seq_printf(seq, "**:");
-		if ((unsigned int)alrm.time.tm_sec <= 59)
-			seq_printf(seq, "%02d\n", alrm.time.tm_sec);
-		else
-			seq_printf(seq, "**\n");
-
-		seq_printf(seq, "alrm_date\t: ");
-		if ((unsigned int)alrm.time.tm_year <= 200)
-			seq_printf(seq, "%04d-", alrm.time.tm_year + 1900);
-		else
-			seq_printf(seq, "****-");
-		if ((unsigned int)alrm.time.tm_mon <= 11)
-			seq_printf(seq, "%02d-", alrm.time.tm_mon + 1);
-		else
-			seq_printf(seq, "**-");
-		if (alrm.time.tm_mday && (unsigned int)alrm.time.tm_mday <= 31)
-			seq_printf(seq, "%02d\n", alrm.time.tm_mday);
-		else
-			seq_printf(seq, "**\n");
+		seq_printf(seq, "alrm_time\t: %ptRtv\n", &alrm.time);
+		seq_printf(seq, "alrm_date\t: %ptRdv\n", &alrm.time);
 		seq_printf(seq, "alarm_IRQ\t: %s\n",
 				alrm.enabled ? "yes" : "no");
 		seq_printf(seq, "alrm_pending\t: %s\n",
diff --git a/drivers/rtc/rtc-sysfs.c b/drivers/rtc/rtc-sysfs.c
index 92ff2edb86a6..0b96926a98e4 100644
--- a/drivers/rtc/rtc-sysfs.c
+++ b/drivers/rtc/rtc-sysfs.c
@@ -39,10 +39,8 @@ date_show(struct device *dev, struct device_attribute *attr, char *buf)
 	struct rtc_time tm;
 
 	retval = rtc_read_time(to_rtc_device(dev), &tm);
-	if (retval == 0) {
-		retval = sprintf(buf, "%04d-%02d-%02d\n",
-			tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday);
-	}
+	if (retval == 0)
+		retval = sprintf(buf, "%ptRd\n", &tm);
 
 	return retval;
 }
@@ -55,10 +53,8 @@ time_show(struct device *dev, struct device_attribute *attr, char *buf)
 	struct rtc_time tm;
 
 	retval = rtc_read_time(to_rtc_device(dev), &tm);
-	if (retval == 0) {
-		retval = sprintf(buf, "%02d:%02d:%02d\n",
-			tm.tm_hour, tm.tm_min, tm.tm_sec);
-	}
+	if (retval == 0)
+		retval = sprintf(buf, "%ptRt\n", &tm);
 
 	return retval;
 }
-- 
2.15.1
