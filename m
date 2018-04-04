Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbeDDLpH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 07:45:07 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44609 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeDDLpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 07:45:06 -0400
X-Google-Smtp-Source: AIpwx48v8l7WqNsEsbzRlxIk5+GCAfi09RPmIvmaPdGZDOL2u3pETYZ/dWvDmOy/QoLxAIABtH79Cg==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Jonathan Cameron <jic23@cam.ac.uk>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH] ARM: pxa: stargate2: use device properties for at24 eeprom
Date: Wed,  4 Apr 2018 13:44:58 +0200
Message-Id: <20180404114458.15376-1-brgl@bgdev.pl>
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
 arch/arm/mach-pxa/stargate2.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
index df62bb23dbee..bbea5fa9a140 100644
--- a/arch/arm/mach-pxa/stargate2.c
+++ b/arch/arm/mach-pxa/stargate2.c
@@ -27,11 +27,11 @@
 
 #include <linux/platform_data/i2c-pxa.h>
 #include <linux/platform_data/pcf857x.h>
-#include <linux/platform_data/at24.h>
 #include <linux/smc91x.h>
 #include <linux/gpio/machine.h>
 #include <linux/gpio.h>
 #include <linux/leds.h>
+#include <linux/property.h>
 
 #include <asm/types.h>
 #include <asm/setup.h>
@@ -795,9 +795,9 @@ static struct pcf857x_platform_data platform_data_pcf857x = {
 	.context = NULL,
 };
 
-static struct at24_platform_data pca9500_eeprom_pdata = {
-	.byte_len = 256,
-	.page_size = 4,
+static const struct property_entry pca9500_eeprom_properties[] = {
+	PROPERTY_ENTRY_U32("pagesize", 4),
+	{ }
 };
 
 /**
@@ -935,7 +935,7 @@ static struct i2c_board_info __initdata stargate2_i2c_board_info[] = {
 	}, {
 		.type = "24c02",
 		.addr = 0x57,
-		.platform_data = &pca9500_eeprom_pdata,
+		.properties = pca9500_eeprom_properties,
 	}, {
 		.type = "max1238",
 		.addr = 0x35,
-- 
2.16.3
