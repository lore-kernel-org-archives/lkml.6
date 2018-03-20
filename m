Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752014AbeCTWcW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 18:32:22 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:40897 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751776AbeCTWb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 18:31:59 -0400
X-Google-Smtp-Source: AG47ELsM9biEyYiXIoCt6N462QeT9dwvmHcZald0VZRJL16hvkqlC95q+vcB2yKN0zDGwxLk9Njo2w==
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>
Cc: Nick Dyer <nick@shmanahar.org>, Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/14] platform/chrome: chromeos_laptop - use device properties for Pixel
Date: Tue, 20 Mar 2018 15:31:36 -0700
Message-Id: <20180320223138.234724-13-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
In-Reply-To: <20180320223138.234724-1-dmitry.torokhov@gmail.com>
References: <20180320223138.234724-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that Atmel driver uses generic device properties we can use them
instead of platform data when setting up touchpad on the original
Google Pixel.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/chrome/chromeos_laptop.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platform/chrome/chromeos_laptop.c
index 1191c1a3a0cd1..fe83a2a4900e4 100644
--- a/drivers/platform/chrome/chromeos_laptop.c
+++ b/drivers/platform/chrome/chromeos_laptop.c
@@ -8,13 +8,13 @@
 
 #include <linux/dmi.h>
 #include <linux/i2c.h>
-#include <linux/platform_data/atmel_mxt_ts.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 
 #define ATMEL_TP_I2C_ADDR	0x4b
 #define ATMEL_TP_I2C_BL_ADDR	0x25
@@ -229,9 +229,9 @@ static int chromebook_pixel_tp_keys[] = {
 	BTN_LEFT
 };
 
-static struct mxt_platform_data chromebook_pixel_tp_platform_data = {
-	.t19_num_keys		= ARRAY_SIZE(chromebook_pixel_tp_keys),
-	.t19_keymap		= chromebook_pixel_tp_keys,
+static const struct property_entry chromebook_pixel_trackpad_props[] = {
+	PROPERTY_ENTRY_U32_ARRAY("linux,gpio-keymap", chromebook_pixel_tp_keys),
+	{ }
 };
 
 static struct chromeos_laptop chromebook_pixel = {
@@ -253,8 +253,8 @@ static struct chromeos_laptop chromebook_pixel = {
 			.board_info	= {
 				I2C_BOARD_INFO("atmel_mxt_tp",
 						ATMEL_TP_I2C_ADDR),
-				.platform_data	=
-					&chromebook_pixel_tp_platform_data,
+				.properties	=
+					chromebook_pixel_trackpad_props,
 				.flags		= I2C_CLIENT_WAKE,
 			},
 			.dmi_name	= "trackpad",
-- 
2.16.2.804.g6dcf76e118-goog
