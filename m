Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1521451055; cv=none;
        d=google.com; s=arc-20160816;
        b=GR4ARnhQET6zmKuWR1WcyIxB15pg7WKRyDM55+gKgDkz1OXIn0t3FDGfOgy3jLGTSi
         t/resWxOOK/0V847q7rcedYbgExRNUJI0fcdndvY45kC5F8D/D1ypy/Cyh5nkV7FrJzH
         qPWBVEZDV2sS/OUdTNpczv6MUKHeoYNmGeCxOML7+VhcNou1nl6Upa0e+nbws0CDqKUv
         Z9vjq0KX2XM63mR1kLcvqu/M83hMKljk+bPVXvSLiePum1WzMb1qIiPH+sW9LZ1+3ecw
         IYRmppiBwa/tD3dLeHMB1rOgHGPO4EroKNmFxHaa2ScTyGOsz2KvlsYzHmrSm3qvC/YK
         oYCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=jubhM7pJy1ZbQzgITAxjAqQS5Mj/ULOwgC/kQHQDF5E=;
        b=VbYNi/7UCx2NlVvZLQ/9sECVbzTVj81Ri7NDZag8thGfKiUI3RUnmt5rmmZvYgIdan
         4qYxhevaBdUfFStA/YXENYKIBMeBmYCbn6WHEUmredePW5MX/DzRIQx5szi4V+6sCNK9
         J1s7nOUKE7iZpD1yF6KCBVkIrA40fiKiYnuAGel5cQXcEYZRrCg+zYiF0MUv0CiJrZnC
         P+pqAI+Hud+2yZBAsuuCc0TWLbtZju5/Ky3j6jVyE7XWfwxScdp6SSQjlnWEpymAx2Ip
         RfrMsmq2yk6SGcKvn7A35oYS8yW+UAfevzKjhKOIw+Fq4KFUMJTQkdDxx5lAq1ChXhzO
         X4sg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=Nv7n1TEk;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=Nv7n1TEk;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AG47ELvMMmseyvBTq+VfnlZQJhgxJCf40Uxmxg8p/2dRpkrpiZSsyPIKE4FDiT+gqQ4arRsoO5gKfA==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 10/21] eeprom: at24: rename at24_get_pdata()
Date: Mon, 19 Mar 2018 10:17:10 +0100
Message-Id: <20180319091721.18193-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595357062404431702?=
X-GMAIL-MSGID: =?utf-8?q?1595357062404431702?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

As preparation for at24_probe() refactoring: rename at24_get_pdata()
to at24_properties_to_pdata(). We're doing it because we'll move the
pdata parsing code into a separate function which will be called
at24_get_pdata(). Current routine with that name actually parses
the device properties so change its name to reflect its purpose.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Tested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/misc/eeprom/at24.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index d386df6b6100..dad5b0f0606e 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -460,7 +460,8 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 	return 0;
 }
 
-static void at24_get_pdata(struct device *dev, struct at24_platform_data *chip)
+static void at24_properties_to_pdata(struct device *dev,
+				     struct at24_platform_data *chip)
 {
 	int err;
 	u32 val;
@@ -547,7 +548,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 		chip.byte_len = cd->byte_len;
 		chip.flags = cd->flags;
-		at24_get_pdata(&client->dev, &chip);
+		at24_properties_to_pdata(&client->dev, &chip);
 	}
 
 	if (!chip.page_size) {
-- 
2.16.1
