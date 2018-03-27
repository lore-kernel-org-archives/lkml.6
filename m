Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/RKDp4aaqDw+YNSnOBybdH42JYysYMDdpjnibWdgyEN6n7uSJQHpAuhIFCyzdWWfquFdwI
ARC-Seal: i=1; a=rsa-sha256; t=1522168478; cv=none;
        d=google.com; s=arc-20160816;
        b=mfPj9O8ArcC4JdL6G2WYamrLVTRZEEmJl0Y8rqJFfSJQRc/vSjt0z9S33epZSaL6AM
         jw4+fM9lzhyTSx2lpV/HuLL3zmfkbJEWAbiQj+/efkGKvZilQeLyP0EphWaypHxnPFtF
         hlUQzA3haSBaE6/PgWIuMn/78/aCKmlbnHDPxxWU8vrD9YpK9w5ZA3mCxkRqfvlMsY13
         WTWZ6bUN8HNIMcDZIaTCj5M9/12pLi5suBTZda5q5Fx0J92d4OTqjmTUztFV1A5dY9Kl
         pi9RUhTSyQ0IiZHrZZ7pg0CY8Kq3mILWt43OKKW/O8oKK3h3Towv0lOxMQ9s2jbpsPEr
         n+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QXtHyYuJEyXtc50t6lheLPuY5tk/rAY+icavo5ej5m0=;
        b=i6paRmcjLIf9G6PZQDlVhe3cLaJ9nv5vtge6vfQ8qmyxunFkQciNs7DchmIDAQXTSP
         7Eu5f1QfZhXCgxD+Bj1MRsSwkfw7IZfHgIsSZDQew7Yy02ClCUAQREbuRGmO0t9p4eZN
         DHfoUfrVse8N5BRrYLnFZcHkjmIbxXdbaObtrXkUbjRXt+JRqFcuc3cKFlU8ByJkrjaJ
         z/ZWXLAbyv4bzm4XJzB4+IQ591g6xBMCvb1I57WAqxLor3ljrPc+0O3jWPfHldVQa+Y5
         qog1qWm7M7wffS6KloxkYhqhLMBuHG3L1THzt55FXRqtRta0qCMtzqpVLujbTRnuPKCJ
         BOvw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.14 008/101] iio: adc: meson-saradc: unlock on error in meson_sar_adc_lock()
Date: Tue, 27 Mar 2018 18:26:40 +0200
Message-Id: <20180327162750.547377222@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109334162552316?=
X-GMAIL-MSGID: =?utf-8?q?1596109334162552316?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 3c3e4b3a708a9d6451052e348981f37d2b3e92b0 upstream.

The meson_sar_adc_lock() function is not supposed to hold the
"indio_dev->mlock" on the error path.

Fixes: 3adbf3427330 ("iio: adc: add a driver for the SAR ADC found in Amlogic Meson SoCs")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/adc/meson_saradc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -462,8 +462,10 @@ static int meson_sar_adc_lock(struct iio
 			regmap_read(priv->regmap, MESON_SAR_ADC_DELAY, &val);
 		} while (val & MESON_SAR_ADC_DELAY_BL30_BUSY && timeout--);
 
-		if (timeout < 0)
+		if (timeout < 0) {
+			mutex_unlock(&indio_dev->mlock);
 			return -ETIMEDOUT;
+		}
 	}
 
 	return 0;
