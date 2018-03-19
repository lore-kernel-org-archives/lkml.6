Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1521451053; cv=none;
        d=google.com; s=arc-20160816;
        b=S9FXPM5YAtd1yI13qBspLY99D2gLVD92G7Ybv+6W3t/P9QXyuDn4/ABgYqQ2OkxPox
         F5RR/CSDmmlTk4N6lx27rYeRKDf7jSl4E0EfPG1TMqWxCtuBP132/KK4TluG4odt0wxX
         igya/tSyIPFXNCl4DHq6+N6IsfusNrvsikU5qAga/L9K9EakmJdhVmzQ5ql+o54vjs2+
         LhHiTo7otyjdm2/IuM4J9rjrke71cCj0vJuv9QpgG6tW1iWvAI79oxm+soXaGNyVmM8f
         fwWNCN8zAm31TRnAnjgzwxesmuR1iiLRHpdKxNGjsLaK/1vnQMZpD49AVVZhy3Gp1gAM
         q+Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=v3VPrd7wRyIUv3FGcGGyv+0Ad0gIfczJLP/v+0C/a8g=;
        b=pqSGmzQI3B2mNd3s4HBf2AyQcuoMSvB4aiFR/8//gbldrObZhQBp+Az/hRJ5SgSHhD
         ICBoCAZAzw+KI/6i2DFmvCQtLifQyveB/6/BEYpqzDHetd2p5EiLbLBFukrZT5wn9nhi
         5tkuccwhuG7OqVyJ+ob1+/mTqgpguwstzMjcrOq0mpBIGr7onidnux+ti7pyWqJDLzM6
         dL8SdTBqFfa9e+6ZDFDEb/+3YiDqZHark3Tehx+rbTF+NwX3ZuEGDHt0WBpuzXjk2mtt
         nxmT6Y3bb7OGG27Er5IF6B/4FN3rsI0f6LBuPBYYhCujLW8XHdvxXie+jAlm5wVJ0HcE
         OM+g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=TuC8iHy8;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=TuC8iHy8;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AG47ELslQMR57XkJsrc1BjC5pDS535TPvqSkLv42QQGxdS9PnTYHweibhvq1wEJn39cCuDtET08iGQ==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 07/21] eeprom: at24: drop redundant variable in at24_write()
Date: Mon, 19 Mar 2018 10:17:07 +0100
Message-Id: <20180319091721.18193-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595357059742950553?=
X-GMAIL-MSGID: =?utf-8?q?1595357059742950553?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We can reuse ret instead of defining a loop-local status variable.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Tested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/misc/eeprom/at24.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index ff7eb8e382c2..d9d55310ffa4 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -440,18 +440,16 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 	gpiod_set_value_cansleep(at24->wp_gpio, 0);
 
 	while (count) {
-		int status;
-
-		status = at24_regmap_write(at24, buf, off, count);
-		if (status < 0) {
+		ret = at24_regmap_write(at24, buf, off, count);
+		if (ret < 0) {
 			gpiod_set_value_cansleep(at24->wp_gpio, 1);
 			mutex_unlock(&at24->lock);
 			pm_runtime_put(dev);
-			return status;
+			return ret;
 		}
-		buf += status;
-		off += status;
-		count -= status;
+		buf += ret;
+		off += ret;
+		count -= ret;
 	}
 
 	gpiod_set_value_cansleep(at24->wp_gpio, 1);
-- 
2.16.1
