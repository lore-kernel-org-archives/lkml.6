Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AH8x226mcOJk7dJLfkqbQaTsceI11k9MTuysKMo4BSXBqHDaW89P/+3XdpCXT70+tQU3JuKIwneF
ARC-Seal: i=1; a=rsa-sha256; t=1519163048; cv=none;
        d=google.com; s=arc-20160816;
        b=CYGm3J4kfCYunt+nWQ28IIzdp9XcH6JgFQLXYfH+jpxeFvwfRHTW2gfDv/uDeua+Ty
         bo7XV32wjIG4ORTsoAiOcF4M2+gHT/yh8HE3awx6C9EUo5XQ4t1EVuqWptRVggx3487J
         XeL9x5JeBm8lJ8HVoNAlSGqaDn3sgyZxlksAd8ZJMm9EpotbnpJSeVpHU5BO1gHgFOlw
         NfAeBh1uRGvyW9Dnij9Obsr11+1HGRI2gozdjSA9Kwj+6m9AHSKy/B78j6C7aMLuMbiP
         KgqMNyXC2p0+aLlE/61e5xdtUWPfGE/FaaF6gXdFA5mbLhmr4oelGVWNxCINTjYb8OTe
         vc6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=bWwQz9KxOdJDxkZMKcXKUlocKLScWzcgAgaTTY2IPXo=;
        b=EVrOR8I8CEp7XrqpXeaqxPse4KUqYdkxZsaYuisD5fIbA6Kqy3QCk6ua9N4RMc0daG
         dI741Eai2YdiXanxN8h3dKFaXQUQEc/Bn3RJnyK7BRGphnzZF1HBZOwRc/IS02NSsU9z
         Fh1uFKt8j+pxQyyFUBpp1SR2Pp2ygnnDdL6duHr6tqYTzcsrx4PZwTz26dEchrXTaWIS
         GC4e/larai6H1pT3vmY4PhgPAljXDQ4MOa+1sfnp7BsfPn2BxcLIoIZNLIzOJwl3j/Ng
         /piEkppyBhDnvILkHDrtzV3hJNwMmtlhMjkmh+Au9JdN8ZDEIiY6dHEiyerlJbSoOIK7
         zP0w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,541,1511856000";
   d="scan'208";a="19075770"
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
Subject: [PATCH v2 06/21] rtc: m48t59: Switch to use %ptR
Date: Tue, 20 Feb 2018 23:43:45 +0200
Message-Id: <20180220214400.66749-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592957912787147919?=
X-GMAIL-MSGID: =?utf-8?q?1592957912787147919?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use %ptR instead of open coded variant to print content of
struct rtc_time in human readable format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-m48t59.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-m48t59.c b/drivers/rtc/rtc-m48t59.c
index 399fc4255d54..67ba7cb2bbe4 100644
--- a/drivers/rtc/rtc-m48t59.c
+++ b/drivers/rtc/rtc-m48t59.c
@@ -102,9 +102,7 @@ static int m48t59_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	M48T59_CLEAR_BITS(M48T59_CNTL_READ, M48T59_CNTL);
 	spin_unlock_irqrestore(&m48t59->lock, flags);
 
-	dev_dbg(dev, "RTC read time %04d-%02d-%02d %02d/%02d/%02d\n",
-		tm->tm_year + 1900, tm->tm_mon, tm->tm_mday,
-		tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "RTC read time %ptR\n", tm);
 	return rtc_valid_tm(tm);
 }
 
@@ -193,9 +191,7 @@ static int m48t59_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	M48T59_CLEAR_BITS(M48T59_CNTL_READ, M48T59_CNTL);
 	spin_unlock_irqrestore(&m48t59->lock, flags);
 
-	dev_dbg(dev, "RTC read alarm time %04d-%02d-%02d %02d/%02d/%02d\n",
-		tm->tm_year + 1900, tm->tm_mon, tm->tm_mday,
-		tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "RTC read alarm time %ptR\n", tm);
 	return rtc_valid_tm(tm);
 }
 
-- 
2.15.1
