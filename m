Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1521451048; cv=none;
        d=google.com; s=arc-20160816;
        b=Sjlb4Ur2XB4mi+YC4Nm+m4x1bUZoawEuY+iQj7Q8xd8u6hUo56RM3DWobYSrNZR9Zl
         ge2vFQ9gKOn/QiB0kUZH5G3AP5XK99PqRSqbvf4Y0rP3xhFdjanAqZhPp7xLO8Gd3jRw
         8d1KowM1e578V4+B46pOD5TxLNCvRlPnjC5wY3f9tJh/YnU/DCk0R0WrHATML+etol23
         nkdaSAKDYC7ygRk3CvQEzy8/NVo8RuufKs1lKvXFrzfkwchIq6YJNS3S6SUQySz/Zh9R
         JNvRa/KSjLV6CW9BtF74p0HITIe/wqEPB9Or4AGPo3NPJ/NgBk8rjTDMK0ebOqk+F7w6
         oa/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=RiW5ljRh2wjDgTrvwWxaVLDsTVg8vUwjEhNT8VwwwXw=;
        b=GdMq6EDvZtVnZajjK0F8GXsE07ZOyqzci3TEgC3dInvOm8XvD6sTP3S2oIT0IxNbTb
         i4Xtm6qLrfhe4O902q+N1Xna9C9VLfhr/HacbvsKxfMGRwMGPqh8NytZBVVJcvXvqJMq
         IBt9a1TpilwXwwPLqZdFLiT0/st8ipt2hDhUa4O3JQXp1elUvg0zHArPVXvMnwb97m8N
         4g1jlR6osYzdX7UWyQYRsO4psb7oVhDefFjHATfqTL7Y4ExHSp+i/n8T+Sm6KbmDfz3J
         TJ3FuepFebNai7l4SoSzOwd1kIUGMya7qMZHRD6WJTU38t8taL+n8nUM83/8YZBsT+Qp
         KcCg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=E2+zFs85;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=E2+zFs85;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AG47ELthlpfw32Qjw+tSRnnsNLG9k1ReXHGq72KmM6nmKvIcjxNfoPAIMw99BtkbYXP4Dge4VkYrTA==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 02/21] eeprom: at24: remove nvmem_config from at24_data
Date: Mon, 19 Mar 2018 10:17:02 +0100
Message-Id: <20180319091721.18193-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595357054156233605?=
X-GMAIL-MSGID: =?utf-8?q?1595357054156233605?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This structure only needs to exist during the call to nvmem_register().

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Tested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/misc/eeprom/at24.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 73af6c5a2d73..2600657c7034 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -75,7 +75,6 @@ struct at24_data {
 	unsigned int num_addresses;
 	unsigned int offset_adj;
 
-	struct nvmem_config nvmem_config;
 	struct nvmem_device *nvmem;
 
 	struct gpio_desc *wp_gpio;
@@ -523,6 +522,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	int err;
 	unsigned int i, num_addresses;
 	struct regmap_config regmap_config = { };
+	struct nvmem_config nvmem_config = { };
 	u8 test_byte;
 
 	if (client->dev.platform_data) {
@@ -650,21 +650,21 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		goto err_clients;
 	}
 
-	at24->nvmem_config.name = dev_name(&client->dev);
-	at24->nvmem_config.dev = &client->dev;
-	at24->nvmem_config.read_only = !writable;
-	at24->nvmem_config.root_only = true;
-	at24->nvmem_config.owner = THIS_MODULE;
-	at24->nvmem_config.compat = true;
-	at24->nvmem_config.base_dev = &client->dev;
-	at24->nvmem_config.reg_read = at24_read;
-	at24->nvmem_config.reg_write = at24_write;
-	at24->nvmem_config.priv = at24;
-	at24->nvmem_config.stride = 1;
-	at24->nvmem_config.word_size = 1;
-	at24->nvmem_config.size = chip.byte_len;
-
-	at24->nvmem = nvmem_register(&at24->nvmem_config);
+	nvmem_config.name = dev_name(&client->dev);
+	nvmem_config.dev = &client->dev;
+	nvmem_config.read_only = !writable;
+	nvmem_config.root_only = true;
+	nvmem_config.owner = THIS_MODULE;
+	nvmem_config.compat = true;
+	nvmem_config.base_dev = &client->dev;
+	nvmem_config.reg_read = at24_read;
+	nvmem_config.reg_write = at24_write;
+	nvmem_config.priv = at24;
+	nvmem_config.stride = 1;
+	nvmem_config.word_size = 1;
+	nvmem_config.size = chip.byte_len;
+
+	at24->nvmem = nvmem_register(&nvmem_config);
 
 	if (IS_ERR(at24->nvmem)) {
 		err = PTR_ERR(at24->nvmem);
-- 
2.16.1
