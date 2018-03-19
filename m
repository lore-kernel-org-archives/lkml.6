Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1521451081; cv=none;
        d=google.com; s=arc-20160816;
        b=V9C7hsrUhjgjuyX18aukIyYvynb8FYG5rR8aBauqpmluShfXGg0364UCJhIo9X3+yF
         mD1EZTj4Uc+h7q4vdKLGdPdXBOO7VlEc2BSbYLFCw8D4+HW0gNssITsXOsn8l+lIs6mN
         QnBj3ZN8NP8i0wSpPdVhtr72n2AZMZ/yenK8dO35mhbxjBd7lWSIEXELmMkl5coY1W2A
         UbYCEuS8Rru1EguPZ5iaAEAsV6GjMYdPTyLdwFw7+MGZcIuQNNHikQoOOzAD4grAthKg
         pyx55k6TX33sJYOo+84HbM5yQMMqYxPLc0o4xr1282uXc0vw1Yk8Q3cgpgRqGTm+ErGs
         S6ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=ARycEKbnRqT/dsJRfq9ndeAK7kIS3m3ahzPm0WygvEA=;
        b=CzcmnK0gDJM7FYhRdHvPEHDDXwVXoJrscYd0zSspufYByw2nSC0CCMOvU2iG8WRPlz
         UHjlMT/BGf7PIDGoD50qDVEBN3WWUYoDcIKkgt1FABG1UQJouLILgR71kUeVYV9mhHxR
         KbEF8owV4hnxdzKLS8eyJ8BIhE34RFlIWM0cPVIZ6gy5veMAFFTQz4P2t+tXUrvRtuG+
         ZRtrq8XVFpDgv6Iq0Inm0NMTlFNo3MXkIdbZYxQRsek1UpGfKhOsspqY6sMs00oFA8aw
         FsT6vTDT57Bpxu9MZ21PtGNcrfckQH01aOf09MLn7JnxVddW7hMh9opD6RM/sagOIhJH
         cB9g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=P4nXmD0Z;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=P4nXmD0Z;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AG47ELtVJSGGKZt4okLbv73pFb+ui0aGTcPepz0WUrqNOvHwxmx1PWosRvPm2ujiLeIl1Zk4UyJilw==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 21/21] eeprom: at24: simplify the i2c functionality checking
Date: Mon, 19 Mar 2018 10:17:21 +0100
Message-Id: <20180319091721.18193-22-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595357089008637445?=
X-GMAIL-MSGID: =?utf-8?q?1595357089008637445?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Save one call and make code prettier by checking the i2c functionality
in the beginning of at24_probe(), saving the relevant values and
reusing them later.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Tested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/misc/eeprom/at24.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index c42e479b880a..d15934b876c1 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -561,6 +561,7 @@ static int at24_probe(struct i2c_client *client)
 	struct nvmem_config nvmem_config = { };
 	struct at24_platform_data pdata = { };
 	struct device *dev = &client->dev;
+	bool i2c_fn_i2c, i2c_fn_block;
 	unsigned int i, num_addresses;
 	struct at24_data *at24;
 	struct regmap *regmap;
@@ -569,13 +570,15 @@ static int at24_probe(struct i2c_client *client)
 	u8 test_byte;
 	int err;
 
+	i2c_fn_i2c = i2c_check_functionality(client->adapter, I2C_FUNC_I2C);
+	i2c_fn_block = i2c_check_functionality(client->adapter,
+					       I2C_FUNC_SMBUS_WRITE_I2C_BLOCK);
+
 	err = at24_get_pdata(dev, &pdata);
 	if (err)
 		return err;
 
-	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C) &&
-	    !i2c_check_functionality(client->adapter,
-				     I2C_FUNC_SMBUS_WRITE_I2C_BLOCK))
+	if (!i2c_fn_i2c && !i2c_fn_block)
 		pdata.page_size = 1;
 
 	if (!pdata.page_size) {
@@ -628,8 +631,7 @@ static int at24_probe(struct i2c_client *client)
 	if (writable) {
 		at24->write_max = min_t(unsigned int,
 					pdata.page_size, at24_io_limit);
-		if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C) &&
-		    at24->write_max > I2C_SMBUS_BLOCK_MAX)
+		if (!i2c_fn_i2c && at24->write_max > I2C_SMBUS_BLOCK_MAX)
 			at24->write_max = I2C_SMBUS_BLOCK_MAX;
 	}
 
-- 
2.16.1
