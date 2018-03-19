Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1521451056; cv=none;
        d=google.com; s=arc-20160816;
        b=z08xQ3zW7v9nbQGIguRtduuGnIpOTQ/rHwBhYU9fY6w056+JFxCTwsiEFGg1hnkA1k
         CSmGpofugzw0o1FQSW4ySllaE8H4srWbBM4zCky+qRYJ6YPwOWCkKuve1zEX9QgdLwvL
         wk5nvTdGiENI/CS/x/pJBiIYdsyNNTVtfbr+Fn0HeDb4mQj7nqT+k19hjw1+m2++fCEz
         5XpVnPs5xxbbNQ2D0Ab7C/JNWHp4VFVgogbq1A1tNtmjtGBBMaW0JNQIyIfdRO+NJCO2
         rx1uuvTcQ1jhFK3XOAS5TQIiEbcMBEzgRwUTrfcQMb2C/rr689QBEfggMBdAJPmg6pPy
         M7gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=GlCXTj2MOexWQnvoy3zqtkC5bSc47uHEteq26zxlq/8=;
        b=K1O+2SNCHTAU+A6bYBbIjtbgUTm+3rpp9BrIVYFTDBkqLZqsHwpyP2Cvvi4wKto44i
         iqa3HSA2Or28IP0Ckl4zva66pQ20TJqSYqLk6PYoJzC2/iSsQRdJ/KXpMEx1ZZNxRFZl
         egyPqDiWRA01IPBIudCp3Qy3//vp3A2UJP0HBzm5m0oHh7v7iXyVugmuwm21CGQ1kGvZ
         H799Vhk3Aq5xixoJ+MS4eArOLdY3ANpdAl8Az08a7Z9gF13Wq1PhRzS1Puhanw3Vy3cy
         CbXpMT3ml8ODP/whHamHzXP2C9828OWy6mHP4D5op8xkM/vezxNpR6MgfhcIMke5EPUe
         1OUw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=PnDPoO33;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=PnDPoO33;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AG47ELvd0ULsQ/w0chQbh/IJdDIdpT5pJrpCbfvnFkidRCvKF/WFgYje6HSg2lKa8xoo8IRtMff8Yg==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 11/21] eeprom: at24: rename chip to pdata in at24_probe()
Date: Mon, 19 Mar 2018 10:17:11 +0100
Message-Id: <20180319091721.18193-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595357063628880731?=
X-GMAIL-MSGID: =?utf-8?q?1595357063628880731?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Reflect the purpose of this variable: it contains platform data so name
it such.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Tested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/misc/eeprom/at24.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index dad5b0f0606e..93431d1296d9 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -516,7 +516,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	struct regmap_config regmap_config = { };
 	struct nvmem_config nvmem_config = { };
 	const struct at24_chip_data *cd = NULL;
-	struct at24_platform_data chip = { };
+	struct at24_platform_data pdata = { };
 	unsigned int i, num_addresses;
 	struct at24_data *at24;
 	bool writable;
@@ -524,7 +524,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	int err;
 
 	if (client->dev.platform_data) {
-		chip = *(struct at24_platform_data *)client->dev.platform_data;
+		pdata = *(struct at24_platform_data *)client->dev.platform_data;
 	} else {
 		/*
 		 * The I2C core allows OF nodes compatibles to match against the
@@ -546,32 +546,32 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		if (!cd)
 			return -ENODEV;
 
-		chip.byte_len = cd->byte_len;
-		chip.flags = cd->flags;
-		at24_properties_to_pdata(&client->dev, &chip);
+		pdata.byte_len = cd->byte_len;
+		pdata.flags = cd->flags;
+		at24_properties_to_pdata(&client->dev, &pdata);
 	}
 
-	if (!chip.page_size) {
+	if (!pdata.page_size) {
 		dev_err(&client->dev, "page_size must not be 0!\n");
 		return -EINVAL;
 	}
-	if (!is_power_of_2(chip.page_size))
+	if (!is_power_of_2(pdata.page_size))
 		dev_warn(&client->dev,
 			"page_size looks suspicious (no power of 2)!\n");
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C) &&
 	    !i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_WRITE_I2C_BLOCK))
-		chip.page_size = 1;
+		pdata.page_size = 1;
 
-	if (chip.flags & AT24_FLAG_TAKE8ADDR)
+	if (pdata.flags & AT24_FLAG_TAKE8ADDR)
 		num_addresses = 8;
 	else
-		num_addresses =	DIV_ROUND_UP(chip.byte_len,
-			(chip.flags & AT24_FLAG_ADDR16) ? 65536 : 256);
+		num_addresses =	DIV_ROUND_UP(pdata.byte_len,
+			(pdata.flags & AT24_FLAG_ADDR16) ? 65536 : 256);
 
 	regmap_config.val_bits = 8;
-	regmap_config.reg_bits = (chip.flags & AT24_FLAG_ADDR16) ? 16 : 8;
+	regmap_config.reg_bits = (pdata.flags & AT24_FLAG_ADDR16) ? 16 : 8;
 	regmap_config.disable_locking = true;
 
 	at24 = devm_kzalloc(&client->dev, sizeof(struct at24_data) +
@@ -580,9 +580,9 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		return -ENOMEM;
 
 	mutex_init(&at24->lock);
-	at24->chip = chip;
+	at24->chip = pdata;
 	at24->num_addresses = num_addresses;
-	at24->offset_adj = at24_get_offset_adj(chip.flags, chip.byte_len);
+	at24->offset_adj = at24_get_offset_adj(pdata.flags, pdata.byte_len);
 
 	at24->wp_gpio = devm_gpiod_get_optional(&client->dev,
 						"wp", GPIOD_OUT_HIGH);
@@ -594,16 +594,16 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (IS_ERR(at24->client[0].regmap))
 		return PTR_ERR(at24->client[0].regmap);
 
-	if ((chip.flags & AT24_FLAG_SERIAL) && (chip.flags & AT24_FLAG_MAC)) {
+	if ((pdata.flags & AT24_FLAG_SERIAL) && (pdata.flags & AT24_FLAG_MAC)) {
 		dev_err(&client->dev,
 			"invalid device data - cannot have both AT24_FLAG_SERIAL & AT24_FLAG_MAC.");
 		return -EINVAL;
 	}
 
-	writable = !(chip.flags & AT24_FLAG_READONLY);
+	writable = !(pdata.flags & AT24_FLAG_READONLY);
 	if (writable) {
 		at24->write_max = min_t(unsigned int,
-					chip.page_size, at24_io_limit);
+					pdata.page_size, at24_io_limit);
 		if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C) &&
 		    at24->write_max > I2C_SMBUS_BLOCK_MAX)
 			at24->write_max = I2C_SMBUS_BLOCK_MAX;
@@ -657,7 +657,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	nvmem_config.priv = at24;
 	nvmem_config.stride = 1;
 	nvmem_config.word_size = 1;
-	nvmem_config.size = chip.byte_len;
+	nvmem_config.size = pdata.byte_len;
 
 	at24->nvmem = nvmem_register(&nvmem_config);
 
@@ -667,12 +667,12 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	}
 
 	dev_info(&client->dev, "%u byte %s EEPROM, %s, %u bytes/write\n",
-		chip.byte_len, client->name,
+		pdata.byte_len, client->name,
 		writable ? "writable" : "read-only", at24->write_max);
 
 	/* export data to kernel code */
-	if (chip.setup)
-		chip.setup(at24->nvmem, chip.context);
+	if (pdata.setup)
+		pdata.setup(at24->nvmem, pdata.context);
 
 	return 0;
 
-- 
2.16.1
