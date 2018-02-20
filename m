Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AH8x227xEH5SzGKKXsV0Y/Zzg0Im51TTgKmzBY1YrksSbKbIP/UWLyb3oPGZn+2RQeydEPzEGFWq
ARC-Seal: i=1; a=rsa-sha256; t=1519163052; cv=none;
        d=google.com; s=arc-20160816;
        b=cFZYTRCr5Ymxb8Red+pPl2TLFuoKLnw4FUh65aWsaTizML3luqiMQdwkfGn14QVeEx
         qI+zGltRulbYqzgwRNejq92Tfl6rFrHuy0Ia1ZG7/PSInMOp0++VfnZoQT66RieEnXHn
         REYWiEMpCL05G1/rgUe330XLPy+HIGKVIG7IeTCp98ZQgZbUsZx2yPRsQkBywz1YXLZz
         wxVRg7P5GB4gIlWrc5lG8gzCL43BT3gjWMwVZL/ysg4l6ApCWCmPSo2sy6eTXmRsWJUs
         QQOIpHFQA0NP7oDFVBGHvekJgDY2k+I0wvp1h1eX+xnqpZVzpncvuW7ATi7gizaFdGm3
         Svug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=uFpTZFjcdnEOV3wfc8I9uJn24hbnyxsVphm4Q0gj64s=;
        b=dvCLBbux04DC3qqu9UdctSeQByz3fPikvbN4YwYXsg0uDYCv/ce7vPV68jwgSJqMkf
         voBiMDQDiDJchLbu68bM878JnzyJAPsF5bs4QkJG1gZXMOU31hf6Ky2O/qi991l67i9d
         hu85vPyiO/QZcTsNGSs2YvrbCKfvcbHSohFK+m/174ZY3Vrup1O7kAZDy6ghXSIf26Nh
         lHMzAjwmkf2U5SgNmcr6flkbJCIUdRMbjuyvtgSM8c9nYexs4h6JJT7aw2IaGH/EStd3
         yuBN8DRSsjuW1zUX2qqXatELebvX36xsfQVKUPqfgxZ9es/m8Si3sRS7JUjCgLqrYLvv
         tVdQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,541,1511856000";
   d="scan'208";a="205722122"
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
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 16/21] rtc: s5m: Switch to use %ptR
Date: Tue, 20 Feb 2018 23:43:55 +0200
Message-Id: <20180220214400.66749-17-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592957917080698824?=
X-GMAIL-MSGID: =?utf-8?q?1592957917080698824?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use %ptR instead of open coded variant to print content of
struct rtc_time in human readable format.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-s5m.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
index 0477678d968f..5c6916ee335c 100644
--- a/drivers/rtc/rtc-s5m.c
+++ b/drivers/rtc/rtc-s5m.c
@@ -403,9 +403,7 @@ static int s5m_rtc_read_time(struct device *dev, struct rtc_time *tm)
 		return -EINVAL;
 	}
 
-	dev_dbg(dev, "%s: %d/%d/%d %d:%d:%d(%d)\n", __func__,
-		1900 + tm->tm_year, 1 + tm->tm_mon, tm->tm_mday,
-		tm->tm_hour, tm->tm_min, tm->tm_sec, tm->tm_wday);
+	dev_dbg(dev, "%s: %ptR(%d)\n", __func__, tm, tm->tm_wday);
 
 	return rtc_valid_tm(tm);
 }
@@ -433,9 +431,7 @@ static int s5m_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	if (ret < 0)
 		return ret;
 
-	dev_dbg(dev, "%s: %d/%d/%d %d:%d:%d(%d)\n", __func__,
-		1900 + tm->tm_year, 1 + tm->tm_mon, tm->tm_mday,
-		tm->tm_hour, tm->tm_min, tm->tm_sec, tm->tm_wday);
+	dev_dbg(dev, "%s: %ptR(%d)\n", __func__, tm, tm->tm_wday);
 
 	ret = regmap_raw_write(info->regmap, info->regs->time, data,
 			info->regs->regs_count);
@@ -487,11 +483,7 @@ static int s5m_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 		return -EINVAL;
 	}
 
-	dev_dbg(dev, "%s: %d/%d/%d %d:%d:%d(%d)\n", __func__,
-		1900 + alrm->time.tm_year, 1 + alrm->time.tm_mon,
-		alrm->time.tm_mday, alrm->time.tm_hour,
-		alrm->time.tm_min, alrm->time.tm_sec,
-		alrm->time.tm_wday);
+	dev_dbg(dev, "%s: %ptR(%d)\n", __func__, &alrm->time, alrm->time.tm_wday);
 
 	ret = s5m_check_peding_alarm_interrupt(info, alrm);
 
@@ -510,9 +502,7 @@ static int s5m_rtc_stop_alarm(struct s5m_rtc_info *info)
 		return ret;
 
 	s5m8767_data_to_tm(data, &tm, info->rtc_24hr_mode);
-	dev_dbg(info->dev, "%s: %d/%d/%d %d:%d:%d(%d)\n", __func__,
-		1900 + tm.tm_year, 1 + tm.tm_mon, tm.tm_mday,
-		tm.tm_hour, tm.tm_min, tm.tm_sec, tm.tm_wday);
+	dev_dbg(info->dev, "%s: %ptR(%d)\n", __func__, &tm, tm.tm_wday);
 
 	switch (info->device_type) {
 	case S5M8763X:
@@ -555,9 +545,7 @@ static int s5m_rtc_start_alarm(struct s5m_rtc_info *info)
 		return ret;
 
 	s5m8767_data_to_tm(data, &tm, info->rtc_24hr_mode);
-	dev_dbg(info->dev, "%s: %d/%d/%d %d:%d:%d(%d)\n", __func__,
-		1900 + tm.tm_year, 1 + tm.tm_mon, tm.tm_mday,
-		tm.tm_hour, tm.tm_min, tm.tm_sec, tm.tm_wday);
+	dev_dbg(info->dev, "%s: %ptR(%d)\n", __func__, &tm, tm.tm_wday);
 
 	switch (info->device_type) {
 	case S5M8763X:
@@ -617,10 +605,7 @@ static int s5m_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
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
2.15.1
