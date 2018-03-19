Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1521451072; cv=none;
        d=google.com; s=arc-20160816;
        b=H9AK0w6PqT+QLGYCe86LnNiakaxIlQE/hoGIytVNHV84lZ+d4XtKBVb+m9gn/i8zTS
         3///G+8gRbtgftmsaapzb6wsV446NdpcK+ffb0Be5Wi8RSn2/8Cgx99HzItN8TAeJYGm
         C4qPDzvOrcpFMZDGHJjZ7Zte1z/OkZ7Guiqe1QkJ4ul5JCFAtpgF2nxzhCep2UFZeUsL
         9nuz56bW503kTKT4ICUdetrqjXeuAzU5twuUKQd78sk4xmfqIFyp7AadkmbwRS4rjPxP
         ZuFwELvLKBUrXBtcyyu09UI2nkYwRUNP8y4RhuQzNlf++VWGDB19HNakHsCFIAJ/eWEI
         ZWbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=RwGKHsCUyPU1AKXYdhzOLBLrPtRQp2sMI5p+vDQqzg8=;
        b=MNAoH+lqlDa6XKlbM89q/ifxmkEhn8L2kOMj1tFb7mJM/lZp3wfdlPTeVnBANNdurg
         su3AFmA7kASKfdT3oLqRwtZiXSch6m+6DIAodQzfxvAAxSEzLszmKyDzsULpZdrsDKYt
         CKHCtWE7RATCFVZpanr2sTlPvk4s0VHGp5wTe/0VWekFeoyVLFgQCEleSLrMB10Di/Sh
         m88G0j79DowURqI7sgU2XpyFUqt+zkKRFAGZknCabt4hxyciS4R2LsVSfNZxv+HgNKUo
         xBy6VE7+ow+UprwYy6e3A3YkwUl4xf2/RXuarvcRAoYKpGMFbNGN1LomojNapTBexOiC
         X/Fw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=TL0mwHSv;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=TL0mwHSv;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AG47ELudGAxNzBBm2XcwwTp7JlFVuwQ1O6Jn3HbJlnJLnFPYJlr+/yUE8K0Cjmoc5THPFS1TEyvs2Q==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 18/21] eeprom: at24: refactor at24_probe()
Date: Mon, 19 Mar 2018 10:17:18 +0100
Message-Id: <20180319091721.18193-19-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595357079944965833?=
X-GMAIL-MSGID: =?utf-8?q?1595357079944965833?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The code in at24_probe() is pretty mangled. It can be cleaned up a bit
by doing things one by one.

Let's group the code by logic: parse and verify pdata, initialize the
regmap, allocate and fill the fields of at24_data, allocate dummy i2c
devices, initialize pm & register with nvmem.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Tested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/misc/eeprom/at24.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 4888999a62cc..f67f5f626617 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -563,6 +563,7 @@ static int at24_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	unsigned int i, num_addresses;
 	struct at24_data *at24;
+	struct regmap *regmap;
 	size_t at24_size;
 	bool writable;
 	u8 test_byte;
@@ -572,6 +573,11 @@ static int at24_probe(struct i2c_client *client)
 	if (err)
 		return err;
 
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C) &&
+	    !i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_WRITE_I2C_BLOCK))
+		pdata.page_size = 1;
+
 	if (!pdata.page_size) {
 		dev_err(dev, "page_size must not be 0!\n");
 		return -EINVAL;
@@ -579,21 +585,26 @@ static int at24_probe(struct i2c_client *client)
 	if (!is_power_of_2(pdata.page_size))
 		dev_warn(dev, "page_size looks suspicious (no power of 2)!\n");
 
-	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C) &&
-	    !i2c_check_functionality(client->adapter,
-				     I2C_FUNC_SMBUS_WRITE_I2C_BLOCK))
-		pdata.page_size = 1;
-
 	if (pdata.flags & AT24_FLAG_TAKE8ADDR)
 		num_addresses = 8;
 	else
 		num_addresses =	DIV_ROUND_UP(pdata.byte_len,
 			(pdata.flags & AT24_FLAG_ADDR16) ? 65536 : 256);
 
+	if ((pdata.flags & AT24_FLAG_SERIAL) && (pdata.flags & AT24_FLAG_MAC)) {
+		dev_err(dev,
+			"invalid device data - cannot have both AT24_FLAG_SERIAL & AT24_FLAG_MAC.");
+		return -EINVAL;
+	}
+
 	regmap_config.val_bits = 8;
 	regmap_config.reg_bits = (pdata.flags & AT24_FLAG_ADDR16) ? 16 : 8;
 	regmap_config.disable_locking = true;
 
+	regmap = devm_regmap_init_i2c(client, &regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
 	at24_size = sizeof(*at24) + num_addresses * sizeof(struct at24_client);
 	at24 = devm_kzalloc(dev, at24_size, GFP_KERNEL);
 	if (!at24)
@@ -605,22 +616,13 @@ static int at24_probe(struct i2c_client *client)
 	at24->flags = pdata.flags;
 	at24->num_addresses = num_addresses;
 	at24->offset_adj = at24_get_offset_adj(pdata.flags, pdata.byte_len);
+	at24->client[0].client = client;
+	at24->client[0].regmap = regmap;
 
 	at24->wp_gpio = devm_gpiod_get_optional(dev, "wp", GPIOD_OUT_HIGH);
 	if (IS_ERR(at24->wp_gpio))
 		return PTR_ERR(at24->wp_gpio);
 
-	at24->client[0].client = client;
-	at24->client[0].regmap = devm_regmap_init_i2c(client, &regmap_config);
-	if (IS_ERR(at24->client[0].regmap))
-		return PTR_ERR(at24->client[0].regmap);
-
-	if ((pdata.flags & AT24_FLAG_SERIAL) && (pdata.flags & AT24_FLAG_MAC)) {
-		dev_err(dev,
-			"invalid device data - cannot have both AT24_FLAG_SERIAL & AT24_FLAG_MAC.");
-		return -EINVAL;
-	}
-
 	writable = !(pdata.flags & AT24_FLAG_READONLY);
 	if (writable) {
 		at24->write_max = min_t(unsigned int,
-- 
2.16.1
