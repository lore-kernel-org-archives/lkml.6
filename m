Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751683AbeDDLvz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 07:51:55 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43307 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751384AbeDDLvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 07:51:53 -0400
X-Google-Smtp-Source: AIpwx4+3S6MDMwNQ79XNSJMAiakGEWmbAM+RzLkzaBRArOBLVMtAQa4UN+CfZl0aHdGmjt99bW/k0A==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH] ARM: s3c24xx: mini2440: use device properties for at24 eeprom
Date: Wed,  4 Apr 2018 13:51:47 +0200
Message-Id: <20180404115147.16448-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to work towards phasing out the at24_platform_data structure.
There are few users and its contents can be represented using generic
device properties. Using device properties only will allow us to
significantly simplify the at24 configuration code.

Remove the at24_platform_data structure and replace it with an array
of property entries. Drop the byte_len/size property, as the model name
already implies the EEPROM's size.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 arch/arm/mach-s3c24xx/mach-mini2440.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
index 95753e0bc073..f9fc1f8d2b28 100644
--- a/arch/arm/mach-s3c24xx/mach-mini2440.c
+++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
@@ -20,7 +20,7 @@
 #include <linux/serial_core.h>
 #include <linux/serial_s3c.h>
 #include <linux/dm9000.h>
-#include <linux/platform_data/at24.h>
+#include <linux/property.h>
 #include <linux/platform_device.h>
 #include <linux/gpio_keys.h>
 #include <linux/i2c.h>
@@ -481,15 +481,15 @@ static struct platform_device mini2440_audio = {
 /*
  * I2C devices
  */
-static struct at24_platform_data at24c08 = {
-	.byte_len	= SZ_8K / 8,
-	.page_size	= 16,
+static const struct property_entry mini2440_at24_properties[] = {
+	PROPERTY_ENTRY_U32("pagesize", 16),
+	{ }
 };
 
 static struct i2c_board_info mini2440_i2c_devs[] __initdata = {
 	{
 		I2C_BOARD_INFO("24c08", 0x50),
-		.platform_data = &at24c08,
+		.properties = mini2440_at24_properties,
 	},
 };
 
-- 
2.16.3
