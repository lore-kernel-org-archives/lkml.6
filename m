Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AH8x224cT2L7urtCDAhbve8D1oiFE3RC0tv3SGeKSYOOgr0mrE8ks3UDyMlAgFzG/szr8ORbWgxT
ARC-Seal: i=1; a=rsa-sha256; t=1519163049; cv=none;
        d=google.com; s=arc-20160816;
        b=Md9xe5RDcVcMI2ccKKPunGW/Ytq3mIWkvuuEylXqGmmEypP7L3My8DdlxzZ9mJ8jnk
         x3hmU1aW/q4LOICAlXwl4B2Q0KAren2m2eN/ST58k9sDk1pBfMfxUMHgEr2fg3NxBba0
         MJOphgUewUhfX9OzwpVWfo4Te2+ecitQjgVq5LRkyi/sz9CezZiGDb1OCLfEK6yHEMn8
         KOdjx0Yih7w5WpGzeclZHRibBYYM5uAftgihB+af6wp0T2Miw7ZAUPt1byCWJIC3vv95
         rrYx0JCT/R5dETmZtYi9TMh9g5M77oqbDW2kbyUaNPk45XYbkHfxaBmgBiXQuSv5jWQ+
         paqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=WwMZTv9/4CztWs74dNFzQsxq+3NyaSD4B9b3IQjGSWI=;
        b=Vm3xG+hB3pef0eIYKKrAsQhao6sBdcI/SeweiknOA1BfZLS0wzGIh3OKlO3ve2ok1c
         F9lUKCcmGlkovMXU+uoYVjjkDQnOg8gdvt8CPtodevlooJdAfNw5K8Rfmw6KPQ/I0l3w
         cLZwFiBGbzNfNqx4qnDoJgKyFJCYTHBZX7jF38Vj9C+UszaN58a2gbCIpkkMzYAqJ55I
         J9q6oJkCdLqdGo6ymmzcsNS4spJDfvzGHLGofdgr1nZdd2z5f/HKHvWiCaZ68WFpZxn1
         63CzUGf+kUyDUePd2o0WMAIpUvDS0yZh5Tvg4tnQjvj9ttKD0CRnrhesRB+V6t+LBQbZ
         qx/A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,541,1511856000";
   d="scan'208";a="19075771"
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
Subject: [PATCH v2 07/21] rtc: mcp795: Switch to use %ptR
Date: Tue, 20 Feb 2018 23:43:46 +0200
Message-Id: <20180220214400.66749-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592957913565770829?=
X-GMAIL-MSGID: =?utf-8?q?1592957913565770829?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use %ptR instead of open coded variant to print content of
struct rtc_time in human readable format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-mcp795.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-mcp795.c b/drivers/rtc/rtc-mcp795.c
index 77f21331ae21..fad71527e417 100644
--- a/drivers/rtc/rtc-mcp795.c
+++ b/drivers/rtc/rtc-mcp795.c
@@ -233,9 +233,7 @@ static int mcp795_set_time(struct device *dev, struct rtc_time *tim)
 	if (ret)
 		return ret;
 
-	dev_dbg(dev, "Set mcp795: %04d-%02d-%02d(%d) %02d:%02d:%02d\n",
-			tim->tm_year + 1900, tim->tm_mon, tim->tm_mday,
-			tim->tm_wday, tim->tm_hour, tim->tm_min, tim->tm_sec);
+	dev_dbg(dev, "Set mcp795: %ptR\n", tim);
 
 	return 0;
 }
@@ -258,9 +256,7 @@ static int mcp795_read_time(struct device *dev, struct rtc_time *tim)
 	tim->tm_mon	= bcd2bin(data[5] & 0x1F) - 1;
 	tim->tm_year	= bcd2bin(data[6]) + 100; /* Assume we are in 20xx */
 
-	dev_dbg(dev, "Read from mcp795: %04d-%02d-%02d(%d) %02d:%02d:%02d\n",
-			tim->tm_year + 1900, tim->tm_mon, tim->tm_mday,
-			tim->tm_wday, tim->tm_hour, tim->tm_min, tim->tm_sec);
+	dev_dbg(dev, "Read from mcp795: %ptR\n", tim);
 
 	return rtc_valid_tm(tim);
 }
@@ -319,9 +315,8 @@ static int mcp795_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 			return ret;
 		dev_dbg(dev, "Alarm IRQ armed\n");
 	}
-	dev_dbg(dev, "Set alarm: %02d-%02d(%d) %02d:%02d:%02d\n",
-			alm->time.tm_mon, alm->time.tm_mday, alm->time.tm_wday,
-			alm->time.tm_hour, alm->time.tm_min, alm->time.tm_sec);
+	dev_dbg(dev, "Set alarm: %ptRdr(%d) %ptRt\n",
+		&alm->time, alm->time.tm_wday, &alm->time);
 	return 0;
 }
 
@@ -345,9 +340,8 @@ static int mcp795_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	alm->time.tm_isdst	= -1;
 	alm->time.tm_yday	= -1;
 
-	dev_dbg(dev, "Read alarm: %02d-%02d(%d) %02d:%02d:%02d\n",
-			alm->time.tm_mon, alm->time.tm_mday, alm->time.tm_wday,
-			alm->time.tm_hour, alm->time.tm_min, alm->time.tm_sec);
+	dev_dbg(dev, "Read alarm: %ptRdr(%d) %ptRt\n",
+		&alm->time, alm->time.tm_wday, &alm->time);
 	return 0;
 }
 
-- 
2.15.1
