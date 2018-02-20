Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AH8x227wWsEKBw4jG4tie1fWtDgqa8IjDIUrVd69fFMhVJ+bt4e+moQuWp9jlT8LkyIiZgpS1/hu
ARC-Seal: i=1; a=rsa-sha256; t=1519163050; cv=none;
        d=google.com; s=arc-20160816;
        b=uFQjyfF9JpRQdatNJwkg/RGOR3c0V5WH0BXSNDD74wXMMrdFSnG5EqmD4SRPT8qdZl
         OAilrVUfHg+WoIEgCVI16EwVHBDLvwJhsJ8IlUT7NqhyyRDPzaZVqtSBqaRNm6Mo03+Q
         EwBLI5MPb+wMRyaX/WSGwqaDvO5GUyuWb45RewAhxmL9G8KjgUZ9miCn10FIXnwEC3qI
         Xbc9GmUK+AUiSmoz6mpfUOFYXuvOQ8WnShPg26uOX+X8yaGzGuw3OFblsXgs6jA34Ifz
         pdgyJyagvpbcwSUqocddySxLB3WvJ1VYJMG7tdpzdy0VNRDEJNHI4/qUfRYciGnD5o9/
         XQrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=oZ3rNN+6gXVoYI6ck1dFD2jJ1KbSswx9mxs2kwoAf1M=;
        b=GUPeLr8fl3HJJvEvO41jpYwYdEMDd5BG9tiNxWRFh2/LbykJ943ThhExlJYssmXvc9
         aHfTdt2HMpq0iyz2cs81H6xs2oQHJDcA+LRKV5pIe3ytvd1zAkHScQDJxb0drCZl6Tpl
         bNAod2sOtEnyZfmOWSIXCN0IsY07953PDuXaiwNcB1OqKNFTHwnMdjTtASL9TRegiKwN
         hpBgI8quUKm+JulkzJAyLYiKPbMH5lrGwya142uEau1u2P6mOZgBe0WixdzJMCJrGZq9
         EnlRYLbC25YAMjKZWwJyNQZHKGf7aRduXdbcSFSwT9d9XVp/mAlh51Ll3OvNUt/Wv0QZ
         1upw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,541,1511856000";
   d="scan'208";a="176774919"
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
Subject: [PATCH v2 05/21] rtc: m41t80: Switch to use %ptR
Date: Tue, 20 Feb 2018 23:43:44 +0200
Message-Id: <20180220214400.66749-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592957915224863954?=
X-GMAIL-MSGID: =?utf-8?q?1592957915224863954?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use %ptR instead of open coded variant to print content of
struct rtc_time in human readable format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-m41t80.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index c90fba3ed861..0ffc03826efb 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -950,11 +950,7 @@ static int m41t80_probe(struct i2c_client *client,
 		if (m41t80_data->features & M41T80_FEATURE_HT) {
 			m41t80_get_datetime(client, &tm);
 			dev_info(&client->dev, "HT bit was set!\n");
-			dev_info(&client->dev,
-				 "Power Down at %04i-%02i-%02i %02i:%02i:%02i\n",
-				 tm.tm_year + 1900,
-				 tm.tm_mon + 1, tm.tm_mday, tm.tm_hour,
-				 tm.tm_min, tm.tm_sec);
+			dev_info(&client->dev, "Power Down at %ptR\n", &tm);
 		}
 		rc = i2c_smbus_write_byte_data(client, M41T80_REG_ALARM_HOUR,
 					       rc & ~M41T80_ALHOUR_HT);
-- 
2.15.1
