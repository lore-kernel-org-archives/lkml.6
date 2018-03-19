Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1521451064; cv=none;
        d=google.com; s=arc-20160816;
        b=ydmKQu8O9GdoDa2KSmWGH9sjcfxfLvmM+/oWloU8dcSpoeU16M+3UdW4FZanYdwnF8
         3gPWBIDBWRRRfmljB0hb0u9h+v5edPP/ZMp9He2H7u1/hiTqdBLy+O4f0R9zgmcoEiOs
         p2mM2VCXFJnCVwch6+cq17XBIsOfTyEDJZoy6OSUU++CLsv/ODBamy2pKwLTSx8C7UZR
         MWwF4FYvZpuAhkZEK88KhozmLqVTCqXXRIICSa08IOsM0Cqz6TWw3o4YUBOo2wHEBPBC
         fqvSwDR5LSkkV6+PGbUGyWpI9Mkd6RSYTO37A6anQMhPvIE4lTI4y/d1bvw77gSn0GDm
         Pupg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=YAZjNh/QSMTQSs8+zfxvCc4WuRCEKEooPQot8yEQH2Y=;
        b=XKmLiGi5UaJ9tKF3H9Mtraj7c77zPCN43gZPs5ra5SXdFj7YCmAm2b8PlDT1HHFEw1
         TXcsb+XYsxgqg9178M1vWsaxEVu6wop3keto4+Nb+V5E+6wPasYj2vsDT2yOooOvKWPl
         JvmS44IpA2qjyD6LtXsZpsif31L2C/uD7o1Qvn5iYAMTc/Tixx3If/NyKNDK2lUmD3ze
         baMf+0NpZj+5SPNMRu/H4HZxmLIPxfrBJMW5AncwnG0Qp3vdS/es/VhElybl6pzxs+NV
         n/qZipfdynYLh/oTcjKq4kxzvDEdxL+uY+u8/U/0AN9jHQImtvFFTOH+EPP4tiJKdGuD
         Vhgg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=xS5eYslX;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=xS5eYslX;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AG47ELumJHw4U9NZ8yd1DGxJ7s/2c6mpmUaxvny3fKVYITfcA9NsjG9iwuPdz76ab1GhA/2Si8/uPg==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 15/21] eeprom: at24: switch to using probe_new() from the i2c framework
Date: Mon, 19 Mar 2018 10:17:15 +0100
Message-Id: <20180319091721.18193-16-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595357071143199806?=
X-GMAIL-MSGID: =?utf-8?q?1595357071143199806?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use the new probe() style for i2c drivers.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Tested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/misc/eeprom/at24.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 02b710919b8b..243d46912f29 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -516,13 +516,14 @@ static unsigned int at24_get_offset_adj(u8 flags, unsigned int byte_len)
 	}
 }
 
-static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
+static int at24_probe(struct i2c_client *client)
 {
 	struct regmap_config regmap_config = { };
 	struct nvmem_config nvmem_config = { };
 	const struct at24_chip_data *cd = NULL;
 	struct at24_platform_data pdata = { };
 	struct device *dev = &client->dev;
+	const struct i2c_device_id *id;
 	unsigned int i, num_addresses;
 	struct at24_data *at24;
 	size_t at24_size;
@@ -530,6 +531,8 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	u8 test_byte;
 	int err;
 
+	id = i2c_match_id(at24_ids, client);
+
 	if (dev->platform_data) {
 		pdata = *(struct at24_platform_data *)dev->platform_data;
 	} else {
@@ -714,7 +717,7 @@ static struct i2c_driver at24_driver = {
 		.of_match_table = at24_of_match,
 		.acpi_match_table = ACPI_PTR(at24_acpi_ids),
 	},
-	.probe = at24_probe,
+	.probe_new = at24_probe,
 	.remove = at24_remove,
 	.id_table = at24_ids,
 };
-- 
2.16.1
