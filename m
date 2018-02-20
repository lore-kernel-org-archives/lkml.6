Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AH8x2264cExIRSU9Vr7C4PRBOxaCRJDIdN5pNZ7Uc6IFu25TC0f8P/6Jlef8BttObe6VkAs6YYd5
ARC-Seal: i=1; a=rsa-sha256; t=1519163051; cv=none;
        d=google.com; s=arc-20160816;
        b=UxXIBkz4TEu/dJnm1VnfU0HJRsZCLOG7Meu44CMxoZ7/26Dtx+kb03s+FNnq9cqnYk
         V5uw3gx0B7j/BSaQnCEgOjhoGVLVXgkKlMJnagnr04HOKTSltVwXaG6x2VlDwpbO6T03
         6vgcJfoOn0sgAXIklfJuTE46USlLNQHbLKYfkR1+n7tNgTD1ycu/l2lPl2c4OMoD+QxC
         bWXq9ZJc2EMeYhnHd/9ABCRB5nv+pFHY8hQfD3pZB+3Ztyo6p0X9T6pG3X4l9gsJUcCO
         QKyRIKtdrf9yxR8pNYoWZMG4JK2MnOxW1mxbeH5v65FUlk4Ut0LCABXVMkqjIL3cF1Qi
         1Gyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=XoVFbAKgcle3IrpCP4c0o1EvTl/KVV5+49/uZUHjP+A=;
        b=FFdL/GEhbDBkAFR79U1nBHpr7Wi2rRsy+aJ1cYVqIGVecxbmwG5uLlseniTJMDP3ih
         azUaLpgYND5xIi8WRsXXptfMmZD3loe9zHhE9WusdSU0ot0A3LrMB1XwcNN1TpcA8uy7
         MZqp0WJeDs9qr7ize6jt4k0BX2f1Bx22x+ngeazs6QY/8XYJ/00aKuEoHZL41f4j0uzB
         W6zHnwsMGaK4te9QCmDVbGfWVnW1S2TDqO3PK17smu5fY3qBGDxs0jrnyrO42wbKZj8P
         CvkeSuYPxXbwM6mflVcxnodcmCCoucrQD9cbB1UNU8g/YlpvhkgsHeW1f7roIyjlhuZt
         bXng==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,541,1511856000";
   d="scan'208";a="19075780"
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
Subject: [PATCH v2 15/21] rtc: s3c: Switch to use %ptR
Date: Tue, 20 Feb 2018 23:43:54 +0200
Message-Id: <20180220214400.66749-16-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592957915957932873?=
X-GMAIL-MSGID: =?utf-8?q?1592957915957932873?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use %ptR instead of open coded variant to print content of
struct rtc_time in human readable format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-s3c.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index a8992c227f61..4a18824a39b1 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -225,13 +225,10 @@ static int s3c_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
 	s3c_rtc_disable_clk(info);
 
 	rtc_tm->tm_year += 100;
-
-	dev_dbg(dev, "read time %04d.%02d.%02d %02d:%02d:%02d\n",
-		1900 + rtc_tm->tm_year, rtc_tm->tm_mon, rtc_tm->tm_mday,
-		rtc_tm->tm_hour, rtc_tm->tm_min, rtc_tm->tm_sec);
-
 	rtc_tm->tm_mon -= 1;
 
+	dev_dbg(dev, "read time %ptR\n", rtc_tm);
+
 	return rtc_valid_tm(rtc_tm);
 }
 
@@ -241,9 +238,7 @@ static int s3c_rtc_settime(struct device *dev, struct rtc_time *tm)
 	int year = tm->tm_year - 100;
 	int ret;
 
-	dev_dbg(dev, "set time %04d.%02d.%02d %02d:%02d:%02d\n",
-		1900 + tm->tm_year, tm->tm_mon, tm->tm_mday,
-		tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "set time %ptR\n", tm);
 
 	/* we get around y2k by simply not supporting it */
 
@@ -292,10 +287,7 @@ static int s3c_rtc_getalarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 	alrm->enabled = (alm_en & S3C2410_RTCALM_ALMEN) ? 1 : 0;
 
-	dev_dbg(dev, "read alarm %d, %04d.%02d.%02d %02d:%02d:%02d\n",
-		alm_en,
-		1900 + alm_tm->tm_year, alm_tm->tm_mon, alm_tm->tm_mday,
-		alm_tm->tm_hour, alm_tm->tm_min, alm_tm->tm_sec);
+	dev_dbg(dev, "read alarm %d, %ptR\n", alm_en, alm_tm);
 
 	/* decode the alarm enable field */
 	if (alm_en & S3C2410_RTCALM_SECEN)
@@ -329,10 +321,7 @@ static int s3c_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	int ret;
 	int year = tm->tm_year - 100;
 
-	dev_dbg(dev, "s3c_rtc_setalarm: %d, %04d.%02d.%02d %02d:%02d:%02d\n",
-		alrm->enabled,
-		1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
-		tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "s3c_rtc_setalarm: %d, %ptR\n", alrm->enabled, tm);
 
 	ret = s3c_rtc_enable_clk(info);
 	if (ret)
-- 
2.15.1
