Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1521451061; cv=none;
        d=google.com; s=arc-20160816;
        b=cELYe+FINRp9HwBzfP+Q8CwwTS31cR0F3jdSI6LvWTKSgprZkhDxp/U9JSpXiN1L3P
         IJ3cQAxQWDWAaFxmbscWAKtlkk5yheEpsmNFMy1V1U2/bQ0eBAFbAYnKOCHEtCeckB9e
         4E0v7L5dUL5SnZJziVdJuQbttK9WEcVxmyq+NRHm+JbS9tJX8/UPr+nfzqegO254o/a+
         iE7ZMHH0bxz4iJv9VPODPNuTrcYXDh2Hl+7AzEBFKsKVYdwDTbPfx2+CZbJtT1yXxuoB
         6nhqAPGC2ZT87MWOVasFnezVk1tEawJrdqWftbpghzgCMaDyTx5LV3outjD/+7ILBe4+
         bKjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=YLo4/PHlUDB4HkmjE1LT7SzGRoOgICNlfDb7BEuTBO0=;
        b=zfQp/eeHb1ZZHY6FzGqCCzvzvU+3YKpKJ4BhjhvicZg8L4vIl5nggLGpzg/laejWYz
         ogWERnVc6Hky2UxoLWR/nQHWm64kRsvRcXYDaEajQtmxLEXIMaYG7Xi+JR51jLnGazR7
         JYe8l+3cuzU/tulk2MsITcYfGMjjv39U/bt2RYX1dOsW5Olr7AtGjhdDk4tNvwLZzLTO
         Izmg7K+DXuAEuxe6L78at1WLpskOY/smz3wPu3fJ9FiPxPPPiMnEYfrb00lLhVOiG6Wr
         jLr5qqlb7sEe75Ml+slTTGmgsyuoDWEvBpi37z5bayAibvG6QTD566+u8SET4o5EhWId
         j/LQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=qlpUNYwz;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=qlpUNYwz;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AG47ELu90mOpmj5FWU9k2186cmzKOUT0K2cJUeNCiKkZ7uuf+DjBs9qUu1+iIod5nBt0hZnXiEWevQ==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 14/21] eeprom: at24: provide and use at24_base_client_dev()
Date: Mon, 19 Mar 2018 10:17:14 +0100
Message-Id: <20180319091721.18193-15-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595357068450450071?=
X-GMAIL-MSGID: =?utf-8?q?1595357068450450071?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use a helper function for accessing the device struct of the base
i2c client. This routine is named in a way that reflects its purpose
unlike the previously hand-coded dereferencing.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Tested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/misc/eeprom/at24.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index ea5e81cb8e8c..02b710919b8b 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -260,6 +260,11 @@ static struct at24_client *at24_translate_offset(struct at24_data *at24,
 	return &at24->client[i];
 }
 
+static struct device *at24_base_client_dev(struct at24_data *at24)
+{
+	return &at24->client[0].client->dev;
+}
+
 static size_t at24_adjust_read_count(struct at24_data *at24,
 				      unsigned int offset, size_t count)
 {
@@ -371,7 +376,7 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
 	int ret;
 
 	at24 = priv;
-	dev = &at24->client[0].client->dev;
+	dev = at24_base_client_dev(at24);
 
 	if (unlikely(!count))
 		return count;
@@ -418,7 +423,7 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 	int ret;
 
 	at24 = priv;
-	dev = &at24->client[0].client->dev;
+	dev = at24_base_client_dev(at24);
 
 	if (unlikely(!count))
 		return -EINVAL;
-- 
2.16.1
