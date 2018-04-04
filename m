Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbeDDNQl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 09:16:41 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34873 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbeDDNQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 09:16:38 -0400
X-Google-Smtp-Source: AIpwx49w33jY5/m1uJ9kEyYDsBebSqnWx692C2HVKWrWX8eiWP+vw9QMdR9l9VAZw+cdwIGVL/JtUQ==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 2/4] ARM: imx: pcm043: use device properties for at24 eeprom
Date: Wed,  4 Apr 2018 15:16:25 +0200
Message-Id: <20180404131627.9135-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180404131627.9135-1-brgl@bgdev.pl>
References: <20180404131627.9135-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to work towards phasing out the at24_platform_data structure.
There are few users and its contents can be represented using generic
device properties. Using device properties only will allow us to
significantly simplify the at24 configuration code.

Remove the at24_platform_data structure and replace it with an array
of property entries. Specify the exact model instead of the "at24"
wildcard and drop the byte_len/size property, as the model name already
implies the EEPROM's size.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 arch/arm/mach-imx/mach-pcm043.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-imx/mach-pcm043.c b/arch/arm/mach-imx/mach-pcm043.c
index 78e2bf8dcd96..e595e5368676 100644
--- a/arch/arm/mach-imx/mach-pcm043.c
+++ b/arch/arm/mach-imx/mach-pcm043.c
@@ -24,7 +24,7 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
-#include <linux/platform_data/at24.h>
+#include <linux/property.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
 
@@ -110,16 +110,15 @@ static const struct imxi2c_platform_data pcm043_i2c0_data __initconst = {
 	.bitrate = 50000,
 };
 
-static struct at24_platform_data board_eeprom = {
-	.byte_len = 4096,
-	.page_size = 32,
-	.flags = AT24_FLAG_ADDR16,
+static const struct property_entry board_eeprom_properties[] = {
+	PROPERTY_ENTRY_U32("pagesize", 32),
+	{ }
 };
 
 static struct i2c_board_info pcm043_i2c_devices[] = {
 	{
-		I2C_BOARD_INFO("at24", 0x52), /* E0=0, E1=1, E2=0 */
-		.platform_data = &board_eeprom,
+		I2C_BOARD_INFO("24c32", 0x52), /* E0=0, E1=1, E2=0 */
+		.properties = board_eeprom_properties,
 	}, {
 		I2C_BOARD_INFO("pcf8563", 0x51),
 	},
-- 
2.16.3
