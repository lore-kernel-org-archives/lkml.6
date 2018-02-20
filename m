Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AH8x225dpueaw1fKHaDhtPdOY1xmmsRUba7k3RK9FxEe/nL4TAsHvFi7fNCcDC8cM5AIUJIvYpqx
ARC-Seal: i=1; a=rsa-sha256; t=1519163051; cv=none;
        d=google.com; s=arc-20160816;
        b=Wc4rwWosuLjUgYEKKkVIlgSLo3H+BCss1EGotsr3Fi0REt09donlMsle6WuxUqRt++
         GimVt4TkXr6mWO+LPJWTHZP8iVfoUsrDaUskRP6hGRxFl+RRCGIoch2CvZFbPR9eHqhW
         wzlD6l0UQY7rlHRiy93Cw2Q9IoPoDFmKhrklEwJ1HjOLVt8B1nLyFzo4BWoTGb98SUAX
         ueB7OoVdx7QFFhlKesWvoJOpKKqfgq3YZ9gpaWLe70yfmK6YiHpL7YXHJUJk6j+CYbay
         O88K1Gth1SsdxCS2ajCwswAabkWvIwH+AMrNRnBtHpx8LXLwYhw/Z0lzg4ROeSOIq8BR
         E5FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=upXsRD6/SD8dfxcKX73WNkAktiGfjqgyVDfwA5dqs2s=;
        b=BuAk4yUijaIIU8CiBx6GYTFjL2GcQHEzbuLQjHJa9q6Ade8uRL7uqF4m2I5qb5hcQA
         04nuPv6AY+5KWoJr7mu+vDJcGcb3ZTVmMk4Zn4JeWlDk62BPZaSUADMSMywlClNnRfmE
         NCkeTnmWxEtqSHyGly0mTl1d3YJIU1uJI9ga37QEMzqj+8v2CZA1sW6hpTf5J1KuYa6s
         Oh/+OEaxRLC4nyOEQLLYZ9kQpOASjiaTRWYiuEJeja0TQ/iC27WZAxOl+k599uU+P2Rt
         L90mHPspuuD129qE2ekBsQDCUxTcaEr6faJm4WKV8oD540XZs0f+i2tHsswuA3H5NovM
         VYIg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,541,1511856000";
   d="scan'208";a="28597066"
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
Subject: [PATCH v2 09/21] rtc: pic32: Switch to use %ptR
Date: Tue, 20 Feb 2018 23:43:48 +0200
Message-Id: <20180220214400.66749-10-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592957916074747888?=
X-GMAIL-MSGID: =?utf-8?q?1592957916074747888?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use %ptR instead of open coded variant to print content of
struct rtc_time in human readable format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-pic32.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/rtc/rtc-pic32.c b/drivers/rtc/rtc-pic32.c
index 5cfb6df5c430..c35b62564d3d 100644
--- a/drivers/rtc/rtc-pic32.c
+++ b/drivers/rtc/rtc-pic32.c
@@ -170,9 +170,7 @@ static int pic32_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
 
 	rtc_tm->tm_year += 100;
 
-	dev_dbg(dev, "read time %04d.%02d.%02d %02d:%02d:%02d\n",
-		1900 + rtc_tm->tm_year, rtc_tm->tm_mon, rtc_tm->tm_mday,
-		rtc_tm->tm_hour, rtc_tm->tm_min, rtc_tm->tm_sec);
+	dev_dbg(dev, "read time %ptR\n", rtc_tm);
 
 	clk_disable(pdata->clk);
 	return rtc_valid_tm(rtc_tm);
@@ -184,9 +182,7 @@ static int pic32_rtc_settime(struct device *dev, struct rtc_time *tm)
 	void __iomem *base = pdata->reg_base;
 	int year = tm->tm_year - 100;
 
-	dev_dbg(dev, "set time %04d.%02d.%02d %02d:%02d:%02d\n",
-		1900 + tm->tm_year, tm->tm_mon, tm->tm_mday,
-		tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "set time %ptR\n", tm);
 
 	if (year < 0 || year >= 100) {
 		dev_err(dev, "rtc only supports 100 years\n");
@@ -224,10 +220,7 @@ static int pic32_rtc_getalarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 	alrm->enabled = (alm_en & PIC32_RTCALRM_ALRMEN) ? 1 : 0;
 
-	dev_dbg(dev, "getalarm: %d, %04d.%02d.%02d %02d:%02d:%02d\n",
-		alm_en,
-		1900 + alm_tm->tm_year, alm_tm->tm_mon, alm_tm->tm_mday,
-		alm_tm->tm_hour, alm_tm->tm_min, alm_tm->tm_sec);
+	dev_dbg(dev, "getalarm: %d, %ptR\n", alm_en, alm_tm);
 
 	alm_tm->tm_sec = bcd2bin(alm_tm->tm_sec);
 	alm_tm->tm_min = bcd2bin(alm_tm->tm_min);
@@ -247,10 +240,7 @@ static int pic32_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	void __iomem *base = pdata->reg_base;
 
 	clk_enable(pdata->clk);
-	dev_dbg(dev, "setalarm: %d, %04d.%02d.%02d %02d:%02d:%02d\n",
-		alrm->enabled,
-		1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
-		tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "setalarm: %d, %ptR\n", alrm->enabled, tm);
 
 	writel(0x00, base + PIC32_ALRMTIME);
 	writel(0x00, base + PIC32_ALRMDATE);
-- 
2.15.1
