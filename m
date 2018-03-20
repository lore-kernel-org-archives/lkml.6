Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbeCTWcZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 18:32:25 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42164 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751873AbeCTWb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 18:31:58 -0400
X-Google-Smtp-Source: AG47ELvMzQ1BxjZT/PdyegKbgD2WFvTOveWY4dIn7eZt/K9u7cYk9gP/aw9VhZ9ttyGVGjf/yc/DzQ==
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>
Cc: Nick Dyer <nick@shmanahar.org>, Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/14] platform/chrome: chromeos_laptop - rely on I2C to set up interrupt trigger
Date: Tue, 20 Mar 2018 15:31:35 -0700
Message-Id: <20180320223138.234724-12-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
In-Reply-To: <20180320223138.234724-1-dmitry.torokhov@gmail.com>
References: <20180320223138.234724-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of passing interrupt flags via platform data to drivers, or
hoping that drivers will do the right thing and set it up the way we
need, let's set up IRQ resource and attach it to the I2C board info, and
let I2C core set it up for us.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/chrome/chromeos_laptop.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platform/chrome/chromeos_laptop.c
index e5015dfaa81ec..1191c1a3a0cd1 100644
--- a/drivers/platform/chrome/chromeos_laptop.c
+++ b/drivers/platform/chrome/chromeos_laptop.c
@@ -11,6 +11,7 @@
 #include <linux/platform_data/atmel_mxt_ts.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
+#include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
@@ -42,7 +43,11 @@ enum i2c_adapter_type {
 struct i2c_peripheral {
 	struct i2c_board_info board_info;
 	unsigned short alt_addr;
+
 	const char *dmi_name;
+	unsigned long irqflags;
+	struct resource irq_resource;
+
 	enum i2c_adapter_type type;
 	u32 pci_devid;
 
@@ -215,10 +220,6 @@ static struct chromeos_laptop samsung_series_5 = {
 	},
 };
 
-static struct mxt_platform_data atmel_1664s_platform_data = {
-	.irqflags		= IRQF_TRIGGER_FALLING,
-};
-
 static int chromebook_pixel_tp_keys[] = {
 	KEY_RESERVED,
 	KEY_RESERVED,
@@ -229,7 +230,6 @@ static int chromebook_pixel_tp_keys[] = {
 };
 
 static struct mxt_platform_data chromebook_pixel_tp_platform_data = {
-	.irqflags		= IRQF_TRIGGER_FALLING,
 	.t19_num_keys		= ARRAY_SIZE(chromebook_pixel_tp_keys),
 	.t19_keymap		= chromebook_pixel_tp_keys,
 };
@@ -241,10 +241,10 @@ static struct chromeos_laptop chromebook_pixel = {
 			.board_info	= {
 				I2C_BOARD_INFO("atmel_mxt_ts",
 						ATMEL_TS_I2C_ADDR),
-				.platform_data	= &atmel_1664s_platform_data,
 				.flags		= I2C_CLIENT_WAKE,
 			},
 			.dmi_name	= "touchscreen",
+			.irqflags	= IRQF_TRIGGER_FALLING,
 			.type		= I2C_ADAPTER_PANEL,
 			.alt_addr	= ATMEL_TS_I2C_BL_ADDR,
 		},
@@ -258,6 +258,7 @@ static struct chromeos_laptop chromebook_pixel = {
 				.flags		= I2C_CLIENT_WAKE,
 			},
 			.dmi_name	= "trackpad",
+			.irqflags	= IRQF_TRIGGER_FALLING,
 			.type		= I2C_ADAPTER_VGADDC,
 			.alt_addr	= ATMEL_TP_I2C_BL_ADDR,
 		},
@@ -356,10 +357,10 @@ static struct chromeos_laptop acer_c720 = {
 			.board_info	= {
 				I2C_BOARD_INFO("atmel_mxt_ts",
 						ATMEL_TS_I2C_ADDR),
-				.platform_data	= &atmel_1664s_platform_data,
 				.flags		= I2C_CLIENT_WAKE,
 			},
 			.dmi_name	= "touchscreen",
+			.irqflags	= IRQF_TRIGGER_FALLING,
 			.type		= I2C_ADAPTER_DESIGNWARE,
 			.pci_devid	= PCI_DEVID(0, PCI_DEVFN(0x15, 0x2)),
 			.alt_addr	= ATMEL_TS_I2C_BL_ADDR,
@@ -558,6 +559,12 @@ chromeos_laptop_prepare(const struct dmi_system_id *id)
 		irq = chromeos_laptop_get_irq_from_dmi(i2c_dev->dmi_name);
 		if (irq < 0)
 			return ERR_PTR(irq);
+
+		i2c_dev->irq_resource  = (struct resource)
+			DEFINE_RES_NAMED(irq, 1, NULL,
+					 IORESOURCE_IRQ | i2c_dev->irqflags);
+		i2c_dev->board_info.resources = &i2c_dev->irq_resource;
+		i2c_dev->board_info.num_resources = 1;
 	}
 
 	return cros_laptop;
-- 
2.16.2.804.g6dcf76e118-goog
