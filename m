Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1521451067; cv=none;
        d=google.com; s=arc-20160816;
        b=lpgA+rh5tzdiWd4b9+0NrW/OIMCRo/BLqEU7qF8uYtu//N5nZ3ntF4R7V9GZW/1p65
         a76lpznX8MPwndSDJsgBErbILSaWraA6rGxHiM7dS5Y1wf8I8taGmQZQzaTYv85wAyFE
         rJHrpa/EqjN1upI/ZK2938mYUbrC3bdh0mH5hbYULKuUb6AfgdSjd5xrNtgQm5PFqnCq
         iidJ8C/6MEejKyvY6g3MxPoZjxdUOBYFco0Rqdm2LjE9D903KNb4grYdNC+/dyBlvfb4
         lQeAc5VJXNdrVVlE8LPt8NUtyc7a+Ep2OdFn/W7CH5zfRDPo82+WiUbqTMmtumI1ni3k
         1yuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=IRAlaEQIxYIiTyD3WO4s0TX+VBmyZdOgp05LySNfmlg=;
        b=cWb3yTiQxSHhJ8OqCRjm0deoW/XqNKT8hkxuVm7dPbzL1ucMTJYTMZV3DVRN8M4R2p
         yqXnWuI9sJ/z1+JczJohfYgYJdGTWTgRRDYXDA+5+g5DOb5IAqKlHkgpLOavYxXe+gen
         V5VLVzg7gEdgmoTRFUZF/ecaIPRfN8OdNmxGz8jBAZ8zyELv8SvIfnCgnv0L2yGJuiEW
         BAulL0oPi1Yletp01KMLlOB8SV23xosDDsxS6hlMvVIO2aXN3k2H/ObKX9EpaX7GqteF
         mAREpqVZ2smrnLbqEOKYoSLUnjQ/GMBhbevv3NUGmK4CNul58g0fzNcR8Na70yW7mVCY
         O9ww==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=1bNnInGk;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=1bNnInGk;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AG47ELsCAVkcq/10L8TLAGe7Zi4eF3d4z20vRFko+Q8LFGaL8m+z/+pqmwDeG+9s+n7WcbkQjB8ylQ==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 16/21] eeprom: at24: move platform data processing into a separate routine
Date: Mon, 19 Mar 2018 10:17:16 +0100
Message-Id: <20180319091721.18193-17-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595357074047156341?=
X-GMAIL-MSGID: =?utf-8?q?1595357074047156341?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This driver can receive its device data from different sources
depending on the system. Move the entire code processing platform data,
device tree and acpi into a separate function.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Tested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/misc/eeprom/at24.c | 70 ++++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 30 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 243d46912f29..bed6917468e1 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -493,6 +493,43 @@ static void at24_properties_to_pdata(struct device *dev,
 	}
 }
 
+static int at24_get_pdata(struct device *dev, struct at24_platform_data *pdata)
+{
+	struct device_node *of_node = dev->of_node;
+	const struct at24_chip_data *cdata;
+	const struct i2c_device_id *id;
+	struct at24_platform_data *pd;
+
+	pd = dev_get_platdata(dev);
+	if (pd) {
+		memcpy(pdata, pd, sizeof(*pdata));
+		return 0;
+	}
+
+	id = i2c_match_id(at24_ids, to_i2c_client(dev));
+
+	/*
+	 * The I2C core allows OF nodes compatibles to match against the
+	 * I2C device ID table as a fallback, so check not only if an OF
+	 * node is present but also if it matches an OF device ID entry.
+	 */
+	if (of_node && of_match_device(at24_of_match, dev))
+		cdata = of_device_get_match_data(dev);
+	else if (id)
+		cdata = (void *)&id->driver_data;
+	else
+		cdata = acpi_device_get_match_data(dev);
+
+	if (!cdata)
+		return -ENODEV;
+
+	pdata->byte_len = cdata->byte_len;
+	pdata->flags = cdata->flags;
+	at24_properties_to_pdata(dev, pdata);
+
+	return 0;
+}
+
 static unsigned int at24_get_offset_adj(u8 flags, unsigned int byte_len)
 {
 	if (flags & AT24_FLAG_MAC) {
@@ -520,10 +557,8 @@ static int at24_probe(struct i2c_client *client)
 {
 	struct regmap_config regmap_config = { };
 	struct nvmem_config nvmem_config = { };
-	const struct at24_chip_data *cd = NULL;
 	struct at24_platform_data pdata = { };
 	struct device *dev = &client->dev;
-	const struct i2c_device_id *id;
 	unsigned int i, num_addresses;
 	struct at24_data *at24;
 	size_t at24_size;
@@ -531,34 +566,9 @@ static int at24_probe(struct i2c_client *client)
 	u8 test_byte;
 	int err;
 
-	id = i2c_match_id(at24_ids, client);
-
-	if (dev->platform_data) {
-		pdata = *(struct at24_platform_data *)dev->platform_data;
-	} else {
-		/*
-		 * The I2C core allows OF nodes compatibles to match against the
-		 * I2C device ID table as a fallback, so check not only if an OF
-		 * node is present but also if it matches an OF device ID entry.
-		 */
-		if (dev->of_node && of_match_device(at24_of_match, dev)) {
-			cd = of_device_get_match_data(dev);
-		} else if (id) {
-			cd = (void *)id->driver_data;
-		} else {
-			const struct acpi_device_id *aid;
-
-			aid = acpi_match_device(at24_acpi_ids, dev);
-			if (aid)
-				cd = (void *)aid->driver_data;
-		}
-		if (!cd)
-			return -ENODEV;
-
-		pdata.byte_len = cd->byte_len;
-		pdata.flags = cd->flags;
-		at24_properties_to_pdata(dev, &pdata);
-	}
+	err = at24_get_pdata(dev, &pdata);
+	if (err)
+		return err;
 
 	if (!pdata.page_size) {
 		dev_err(dev, "page_size must not be 0!\n");
-- 
2.16.1
