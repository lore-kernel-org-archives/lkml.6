Return-Path: <masneyb@onstation.org>
X-Google-Smtp-Source: AG47ELvkLLwWb9zvBQYWga4LWDXyrr31+CQrBGvXmFC6dr6WCidLQHXHXw9/cP7aeVBnfXjP/cYr
ARC-Seal: i=1; a=rsa-sha256; t=1520128193; cv=none;
        d=google.com; s=arc-20160816;
        b=td5TMwge5iBTxCObemvzaqoM4C9NTf9W/B9cZVfuaFScp2ewbHnxQpyp2aSHUOwEHW
         QcTTwUvxw5ziMTH+XRicLo71yIIkHjfhx/ogk6nF5AcMNyPw15afUsIuzZdsFka729Hc
         AjXzOhsRKfM7t+JXdEOOEccjACjoylHRkGS4ujtc0cuNIfACJbmcah6js/Dxr7qvCe7P
         Qxb+C6wpLscNe5C6HBama0w52EgIsW6R2Ber+xKNR2F/bKlNfl8UiHeDPDRn4Bchv0ij
         OwlK0ECb6hDLCzHNaxKmCzF5xKwcPHYnqcvXDexTsWN5s5VQGnsxMixT/F98qReCqY/v
         Y2mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=mPClE6og0fwxCJnJ0CxJjzFg7qmkluHoZ2rHZTRkXWw=;
        b=R9xk3megd40D9F2DyQjm/7hko1lMF1+bktVE/S6Ou5UVL3PmuSsPN2eHopZvNF2g4u
         wtkkvVkJDv1xQdtttNFyAvP3yaTHuyeVNhJUNxySiuaojGqx0M7wtYpKzjWmYURwCmz3
         tYR/pPlef5Uk3lk1lo7+au52tKNlrqS53X3BUoACBY/MkgQyzWBzKbFuaAJwlXSrX/Fs
         90nxKJAwQM5SJf54ThiHckTyR4UH41j3fbP/WBnXmPvsYkB7xwal4Jz74bgr+gJa4SAy
         0eJc1fkBP4qjpn0yEzDUaGr7osNAJ5o+2k1euzPdhed+UF+7AzuTUYycxM82Hy3Zqw07
         ZbgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@onstation.org header.s=default header.b=OrK86R/7;
       spf=pass (google.com: best guess record for domain of masneyb@onstation.org designates 52.200.56.107 as permitted sender) smtp.mailfrom=masneyb@onstation.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@onstation.org header.s=default header.b=OrK86R/7;
       spf=pass (google.com: best guess record for domain of masneyb@onstation.org designates 52.200.56.107 as permitted sender) smtp.mailfrom=masneyb@onstation.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org,
	Jon.Brenner@ams.com
Subject: [PATCH 05/12] staging: iio: tsl2x7x: convert mutex_trylock() to mutex_lock()
Date: Sat,  3 Mar 2018 20:49:35 -0500
Message-Id: <20180304014942.18727-6-masneyb@onstation.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180304014942.18727-1-masneyb@onstation.org>
References: <20180304014942.18727-1-masneyb@onstation.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593969940157389590?=
X-GMAIL-MSGID: =?utf-8?q?1593969940157389590?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The driver uses mutex_lock() and mutex_trylock() in several places.
Convert the mutex_trylock() to mutex_lock() for consistency with other
IIO light drivers in mainline.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index cf16dd206c0b..5c611250127f 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -350,8 +350,7 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
 	u32 ch0lux = 0;
 	u32 ch1lux = 0;
 
-	if (mutex_trylock(&chip->als_mutex) == 0)
-		return chip->als_cur_info.lux; /* busy, so return LAST VALUE */
+	mutex_lock(&chip->als_mutex);
 
 	if (chip->tsl2x7x_chip_status != TSL2X7X_CHIP_WORKING) {
 		/* device is not enabled */
@@ -478,11 +477,7 @@ static int tsl2x7x_get_prox(struct iio_dev *indio_dev)
 	u8 chdata[2];
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
 
-	if (mutex_trylock(&chip->prox_mutex) == 0) {
-		dev_err(&chip->client->dev,
-			"%s: Can't get prox mutex\n", __func__);
-		return -EBUSY;
-	}
+	mutex_lock(&chip->prox_mutex);
 
 	ret = tsl2x7x_read_status(chip);
 	if (ret < 0)
-- 
2.14.3
