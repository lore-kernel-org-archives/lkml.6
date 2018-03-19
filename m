Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1521451069; cv=none;
        d=google.com; s=arc-20160816;
        b=xEiJBEdT20B1sjRwAFWkztQ69/ZMpphmeqmtetlgKYmxaWJ2OYPdk19g4AtMjkBhWi
         tjGP/UlvdHtslGI3GfJawlmr50NKusg4Set1D0v9i90DNWbZRvBKeKi1JXuWmr8l1OG+
         Ch7vV9S4S2hM5wy1uxRV3cJs9VHRtjRlJByW05+k7ZRlCClEugYuSgwCFBP9Xz3Q/JkV
         HMWJ44gcHjzzXDTNAfR+6sZK7FPd0waoKJBZihDeo2xks7faqYoJ9q21VsdyvxNsHWx3
         UUE7QVESuCe/ESsWJZYpzQg2sSfrYgpmmHTA1bjV5UsKdHG/8LP+9ii7Kk2bzZP+9RJ9
         1afg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=X+Bf9cRe7mV3ltKpCaJyQl/tCmCpgR2GtsBhxpEI/0Q=;
        b=WeRJ1PqNaGVzRsvwOAF8zUspjDwPei5kdrM3yJaRMuVXlIp7HR2fzdbbzWZWQa78W/
         78EWxwsIJmVG+32F69lSSyLtDy4Rm8VKO3uunJj2Yg4G2DUtZFCrHJYJSZbxWl3/FIH+
         j/fJdcX0Y5sI9e2HzPeGiNp8PQCPkaOu3vle0yLFDgnLO8I+r2tD1F8GpSt31rJyFkB+
         jb4xpI/0qWkdRPyG3GyiW/5BipjQ6d1jUTjFNefc+aE6yOLL3dQOiat7JpO80uGvBVVK
         dKjeov6FFd+XDBI2jchigiDU5XSYR38ha1jkPHNDXijiUOaMOxd+JQLuFLEA/ohooYme
         urqw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=1Itu3tuo;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=1Itu3tuo;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AG47ELsclsAjTjJ6Z7TheWjiRvAkBeHLzK0T7ozF3VEFDgwIW/huZVVmJlAn7oUqvvatCJfxsJNfOA==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 17/21] eeprom: at24: remove at24_platform_data from at24_data
Date: Mon, 19 Mar 2018 10:17:17 +0100
Message-Id: <20180319091721.18193-18-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595357076999565354?=
X-GMAIL-MSGID: =?utf-8?q?1595357076999565354?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Not all fields from at24_platform_data are needed in at24_data. Let's
keep just the ones we need and not carry the whole platform_data
structure all the time.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Tested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/misc/eeprom/at24.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index bed6917468e1..4888999a62cc 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -60,8 +60,6 @@ struct at24_client {
 };
 
 struct at24_data {
-	struct at24_platform_data chip;
-
 	/*
 	 * Lock protects against activities from other Linux tasks,
 	 * but not from changes by other I2C masters.
@@ -72,6 +70,10 @@ struct at24_data {
 	unsigned int num_addresses;
 	unsigned int offset_adj;
 
+	u32 byte_len;
+	u16 page_size;
+	u8 flags;
+
 	struct nvmem_device *nvmem;
 
 	struct gpio_desc *wp_gpio;
@@ -249,7 +251,7 @@ static struct at24_client *at24_translate_offset(struct at24_data *at24,
 {
 	unsigned int i;
 
-	if (at24->chip.flags & AT24_FLAG_ADDR16) {
+	if (at24->flags & AT24_FLAG_ADDR16) {
 		i = *offset >> 16;
 		*offset &= 0xffff;
 	} else {
@@ -276,8 +278,8 @@ static size_t at24_adjust_read_count(struct at24_data *at24,
 	 * the next slave address: truncate the count to the slave boundary,
 	 * so that the read never straddles slaves.
 	 */
-	if (at24->chip.flags & AT24_FLAG_NO_RDROL) {
-		bits = (at24->chip.flags & AT24_FLAG_ADDR16) ? 16 : 8;
+	if (at24->flags & AT24_FLAG_NO_RDROL) {
+		bits = (at24->flags & AT24_FLAG_ADDR16) ? 16 : 8;
 		remainder = BIT(bits) - offset;
 		if (count > remainder)
 			count = remainder;
@@ -336,7 +338,7 @@ static size_t at24_adjust_write_count(struct at24_data *at24,
 		count = at24->write_max;
 
 	/* Never roll over backwards, to the start of this page */
-	next_page = roundup(offset + 1, at24->chip.page_size);
+	next_page = roundup(offset + 1, at24->page_size);
 	if (offset + count > next_page)
 		count = next_page - offset;
 
@@ -381,7 +383,7 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
 	if (unlikely(!count))
 		return count;
 
-	if (off + count > at24->chip.byte_len)
+	if (off + count > at24->byte_len)
 		return -EINVAL;
 
 	ret = pm_runtime_get_sync(dev);
@@ -428,7 +430,7 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 	if (unlikely(!count))
 		return -EINVAL;
 
-	if (off + count > at24->chip.byte_len)
+	if (off + count > at24->byte_len)
 		return -EINVAL;
 
 	ret = pm_runtime_get_sync(dev);
@@ -598,7 +600,9 @@ static int at24_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	mutex_init(&at24->lock);
-	at24->chip = pdata;
+	at24->byte_len = pdata.byte_len;
+	at24->page_size = pdata.page_size;
+	at24->flags = pdata.flags;
 	at24->num_addresses = num_addresses;
 	at24->offset_adj = at24_get_offset_adj(pdata.flags, pdata.byte_len);
 
-- 
2.16.1
