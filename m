Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AH8x2263uV6p242eQwZA1d9CFRew8/plBC3wjsEEaUjOKrY4O7UsoVe4P+BqH1pbSw9GsdzpiSNz
ARC-Seal: i=1; a=rsa-sha256; t=1519163052; cv=none;
        d=google.com; s=arc-20160816;
        b=GENWrVs9HbCD1goFp18m5Lz8rvDN7xy+Kv5Eyqq+M1+jr6FCLT98YPmhofUAv1VpWP
         t5PGTKuC8Wswuwewly6AcYvU2nYBogqVvo/QhSB0UHovvZV/2itd+uw3VtjOPl8Pgqhs
         R44kWHschcrpei+fS/7EbAm5TqSjJN7KvdxVK3+ZrdzC24yesg0q2Ef+LY0CDJFSlWWi
         xaML6Aa3WvIbBvy0NXaw2GTl6VUjzye5wLuv3Wr1sLbZV0KI2u8iVod5KpAZBf9MOA8d
         OwW/v7RgJ1xfgQMaZZETU9/RRBwzxRQtZbfGz1EDF+YfGLrjiHiUknbwuPFdedv4dolB
         h8UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=7nA9N8GSh3H48wcuQD3eyc/u7BItbbawRiDI306G7ts=;
        b=fwtDHKz9sTwYFJpPvAw+4fQdgJ1jEIRauQtmMwOPsjWbothGfQAWQkFgN1YhV3bLBW
         sKfhD2Yd7ZhA9T+xe5/aYSokWZ9uT+xY0SukydBVDLtSR1Gfa091Exjelvp+DLtgW/YM
         Np06WqcuWamMPVHQRle1HQnRyNWET+CM/8pXDioyt/chK3BP/E4jBjEFDwyyaMJshz8n
         xXSa6wfcsrTwvvp30PrIrREWkgk7f7yymAvwZ4zeokipaC9eIQR0uV1CxlayNqLOiV8y
         GFf4tqgJDfVSj3d5TZYLrPMDRpZLhKfZXCGimwPsYOeHYPIHVruyXWDX22SXsAGA2nuJ
         enhQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,541,1511856000";
   d="scan'208";a="28597065"
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
Subject: [PATCH v2 10/21] rtc: pm8xxx: Switch to use %ptR
Date: Tue, 20 Feb 2018 23:43:49 +0200
Message-Id: <20180220214400.66749-11-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592957916738575236?=
X-GMAIL-MSGID: =?utf-8?q?1592957916738575236?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use %ptR instead of open coded variant to print content of
struct rtc_time in human readable format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-pm8xxx.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index fac835530671..deb0f14f9e37 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -196,9 +196,7 @@ static int pm8xxx_rtc_read_time(struct device *dev, struct rtc_time *tm)
 		return rc;
 	}
 
-	dev_dbg(dev, "secs = %lu, h:m:s == %d:%d:%d, d/m/y = %d/%d/%d\n",
-		secs, tm->tm_hour, tm->tm_min, tm->tm_sec,
-		tm->tm_mday, tm->tm_mon, tm->tm_year);
+	dev_dbg(dev, "secs = %lu, h:m:s == %ptRt, y-m-d = %ptRdr\n", secs, tm, tm);
 
 	return 0;
 }
@@ -243,10 +241,8 @@ static int pm8xxx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 		goto rtc_rw_fail;
 	}
 
-	dev_dbg(dev, "Alarm Set for h:r:s=%d:%d:%d, d/m/y=%d/%d/%d\n",
-		alarm->time.tm_hour, alarm->time.tm_min,
-		alarm->time.tm_sec, alarm->time.tm_mday,
-		alarm->time.tm_mon, alarm->time.tm_year);
+	dev_dbg(dev, "Alarm Set for h:m:s=%ptRt, y-m-d=%ptRdr\n",
+		&alarm->time, &alarm->time);
 rtc_rw_fail:
 	spin_unlock_irqrestore(&rtc_dd->ctrl_reg_lock, irq_flags);
 	return rc;
@@ -277,10 +273,8 @@ static int pm8xxx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 		return rc;
 	}
 
-	dev_dbg(dev, "Alarm set for - h:r:s=%d:%d:%d, d/m/y=%d/%d/%d\n",
-		alarm->time.tm_hour, alarm->time.tm_min,
-		alarm->time.tm_sec, alarm->time.tm_mday,
-		alarm->time.tm_mon, alarm->time.tm_year);
+	dev_dbg(dev, "Alarm set for - h:m:s=%ptRt, y-m-d=%ptRdr\n",
+		&alarm->time, &alarm->time);
 
 	return 0;
 }
-- 
2.15.1
