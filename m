Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AH8x226a4B2I2ImgsKO2weRvE6R+rlZ0xFMi/NlG7Vh1hkzzUY+G4ZorORQS9xSoF/Oj5egZ2cKH
ARC-Seal: i=1; a=rsa-sha256; t=1519163049; cv=none;
        d=google.com; s=arc-20160816;
        b=Oc+kxsWB6LNAjp8TFM5pTtB8Q5Z5sKn8koVY7i3NwnPgGAh5BzTWc7E5cnlsgaRHC2
         EwpIlRziTJOkz2hyLITP4bcQVnFAcT4GogYE1lJveRp5cg4iFqJyOCxeld2OE68nM1/L
         dCwC9vAyk7062v+Zo08It1dYPrUnD2WWScj2ydqbk3bN6boQsC//Vps7KxIgU82BEkF7
         l9kbzr4RDxZjtyuupGS8mdAsm+ZaXpMfbI5hAAcAcFAbYbqvNQL0b0X8/MkBinln1VQe
         Uf59VV67dt1nFlMWGSUvP5cwe9hTXDM44/z6aqzgGbVgEdnNAwYoeLZZlfyAmKmaydLa
         +1Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=6Xmp1BSrkAKibCMRKdegnLQFhMIzVAvG16W0eacND+w=;
        b=P6Ed5dDCPPBrHwQ3lYqP0zZMvfa2BItDJoqsLHFruR9K4aGhUIKDu4TRq3Sv4VTJ+q
         HARqLol5PRRBfLyG9ijoWDIJs/2coGNuQ8jwzGdHj5hopt5T09csVcOfvV774N7S7KzJ
         pjLMNKZVf+niqMTMgEoBl7oEJ4lFNMH9P7ZYt0IqVFT2x5BUd33cEpnlOhvhm7fMOx2Y
         RwdrLV8vhNTS6MzTEDnXN3aZFLUXuzQ5fbNPtGoT4tXRp3dSngom2O8C6BnCQHELccY7
         8fk2sY3z2hxzbUvJ0mwsvPqJKTQjNZk7zEsID5jbAlat5Otkh2Iqe0NUexQQwFM8kTJq
         nnDQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,541,1511856000";
   d="scan'208";a="31520269"
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
Subject: [PATCH v2 12/21] rtc: rk808: Switch to use %ptR
Date: Tue, 20 Feb 2018 23:43:51 +0200
Message-Id: <20180220214400.66749-13-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592957913495439021?=
X-GMAIL-MSGID: =?utf-8?q?1592957913495439021?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use %ptR instead of open coded variant to print content of
struct rtc_time in human readable format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-rk808.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/rtc/rtc-rk808.c b/drivers/rtc/rtc-rk808.c
index 35c9aada07c8..09d6653bc0de 100644
--- a/drivers/rtc/rtc-rk808.c
+++ b/drivers/rtc/rtc-rk808.c
@@ -138,9 +138,7 @@ static int rk808_rtc_readtime(struct device *dev, struct rtc_time *tm)
 	tm->tm_year = (bcd2bin(rtc_data[5] & YEARS_REG_MSK)) + 100;
 	tm->tm_wday = bcd2bin(rtc_data[6] & WEEKS_REG_MSK);
 	rockchip_to_gregorian(tm);
-	dev_dbg(dev, "RTC date/time %4d-%02d-%02d(%d) %02d:%02d:%02d\n",
-		1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
-		tm->tm_wday, tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "RTC date/time %ptRd(%d) %ptRt\n", tm, tm->tm_wday, tm);
 
 	return ret;
 }
@@ -153,9 +151,7 @@ static int rk808_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	u8 rtc_data[NUM_TIME_REGS];
 	int ret;
 
-	dev_dbg(dev, "set RTC date/time %4d-%02d-%02d(%d) %02d:%02d:%02d\n",
-		1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
-		tm->tm_wday, tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "set RTC date/time %ptRd(%d) %ptRt\n", tm, tm->tm_wday, tm);
 	gregorian_to_rockchip(tm);
 	rtc_data[0] = bin2bcd(tm->tm_sec);
 	rtc_data[1] = bin2bcd(tm->tm_min);
@@ -216,10 +212,8 @@ static int rk808_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
 		return ret;
 	}
 
-	dev_dbg(dev, "alrm read RTC date/time %4d-%02d-%02d(%d) %02d:%02d:%02d\n",
-		1900 + alrm->time.tm_year, alrm->time.tm_mon + 1,
-		alrm->time.tm_mday, alrm->time.tm_wday, alrm->time.tm_hour,
-		alrm->time.tm_min, alrm->time.tm_sec);
+	dev_dbg(dev, "alrm read RTC date/time %ptRd(%d) %ptRt\n",
+		&alrm->time, alrm->time.tm_wday, &alrm->time);
 
 	alrm->enabled = (int_reg & BIT_RTC_INTERRUPTS_REG_IT_ALARM_M) ? 1 : 0;
 
@@ -261,10 +255,8 @@ static int rk808_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 		dev_err(dev, "Failed to stop alarm: %d\n", ret);
 		return ret;
 	}
-	dev_dbg(dev, "alrm set RTC date/time %4d-%02d-%02d(%d) %02d:%02d:%02d\n",
-		1900 + alrm->time.tm_year, alrm->time.tm_mon + 1,
-		alrm->time.tm_mday, alrm->time.tm_wday, alrm->time.tm_hour,
-		alrm->time.tm_min, alrm->time.tm_sec);
+	dev_dbg(dev, "alrm set RTC date/time %ptRd(%d) %ptRt\n",
+		&alrm->time, alrm->time.tm_wday, &alrm->time);
 
 	gregorian_to_rockchip(&alrm->time);
 	alrm_data[0] = bin2bcd(alrm->time.tm_sec);
-- 
2.15.1
