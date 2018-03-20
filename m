Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752130AbeCTWej (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 18:34:39 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33697 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751783AbeCTWbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 18:31:50 -0400
X-Google-Smtp-Source: AG47ELtu7mMcNZdkjMZktcFFpccJNZJASlK8wJT42b2F6z4Fd6eM+mFMWpGIvPTh+UrJKJ75cTP26w==
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>
Cc: Nick Dyer <nick@shmanahar.org>, Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/14] platform/chrome: chromeos_laptop - introduce pr_fmt()
Date: Tue, 20 Mar 2018 15:31:30 -0700
Message-Id: <20180320223138.234724-7-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
In-Reply-To: <20180320223138.234724-1-dmitry.torokhov@gmail.com>
References: <20180320223138.234724-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define pr_fmt() to standardize driver messages.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/chrome/chromeos_laptop.c | 31 ++++++++++-------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platform/chrome/chromeos_laptop.c
index 0a43f1833de3f..08ce7a105e768 100644
--- a/drivers/platform/chrome/chromeos_laptop.c
+++ b/drivers/platform/chrome/chromeos_laptop.c
@@ -4,6 +4,8 @@
 // Copyright (C) 2012 Google, Inc.
 // Author: Benson Leung <bleung@chromium.org>
 
+#define pr_fmt(fmt)		KBUILD_MODNAME ": " fmt
+
 #include <linux/dmi.h>
 #include <linux/i2c.h>
 #include <linux/platform_data/atmel_mxt_ts.h>
@@ -139,15 +141,12 @@ static struct i2c_client *__add_probed_i2c_device(
 	if (name) {
 		dmi_dev = dmi_find_device(DMI_DEV_TYPE_DEV_ONBOARD, name, NULL);
 		if (!dmi_dev) {
-			pr_err("%s failed to dmi find device %s.\n",
-			       __func__,
-			       name);
+			pr_err("failed to dmi find device %s\n", name);
 			return NULL;
 		}
 		dev_data = (struct dmi_dev_onboard *)dmi_dev->device_data;
 		if (!dev_data) {
-			pr_err("%s failed to get data from dmi for %s.\n",
-			       __func__, name);
+			pr_err("failed to get data from dmi for %s\n", name);
 			return NULL;
 		}
 		info->irq = dev_data->instance;
@@ -155,7 +154,7 @@ static struct i2c_client *__add_probed_i2c_device(
 
 	adapter = i2c_get_adapter(bus);
 	if (!adapter) {
-		pr_err("%s failed to get i2c adapter %d.\n", __func__, bus);
+		pr_err("failed to get i2c adapter %d\n", bus);
 		return NULL;
 	}
 
@@ -174,19 +173,18 @@ static struct i2c_client *__add_probed_i2c_device(
 		dummy = i2c_new_probed_device(adapter, &dummy_info,
 					      alt_addr_list, NULL);
 		if (dummy) {
-			pr_debug("%s %d-%02x is probed at %02x\n",
-				  __func__, bus, info->addr, dummy->addr);
+			pr_debug("%d-%02x is probed at %02x\n",
+				 bus, info->addr, dummy->addr);
 			i2c_unregister_device(dummy);
 			client = i2c_new_device(adapter, info);
 		}
 	}
 
 	if (!client)
-		pr_notice("%s failed to register device %d-%02x\n",
-			  __func__, bus, info->addr);
+		pr_notice("failed to register device %d-%02x\n",
+			  bus, info->addr);
 	else
-		pr_debug("%s added i2c device %d-%02x\n",
-			 __func__, bus, info->addr);
+		pr_debug("added i2c device %d-%02x\n", bus, info->addr);
 
 	i2c_put_adapter(adapter);
 	return client;
@@ -227,7 +225,7 @@ static int find_i2c_adapter_num(enum i2c_adapter_type type)
 	dev = bus_find_device(&i2c_bus_type, NULL, &lookup, __find_i2c_adap);
 	if (!dev) {
 		/* Adapters may appear later. Deferred probing will retry */
-		pr_notice("%s: i2c adapter %s not found on system.\n", __func__,
+		pr_notice("i2c adapter %s not found on system.\n",
 			  lookup.name);
 		return -ENODEV;
 	}
@@ -349,7 +347,7 @@ static int setup_tsl2563_als(enum i2c_adapter_type type)
 static int __init chromeos_laptop_dmi_matched(const struct dmi_system_id *id)
 {
 	cros_laptop = (void *)id->driver_data;
-	pr_debug("DMI Matched %s.\n", id->ident);
+	pr_debug("DMI Matched %s\n", id->ident);
 
 	/* Indicate to dmi_scan that processing is done. */
 	return 1;
@@ -392,8 +390,7 @@ static int chromeos_laptop_probe(struct platform_device *pdev)
 				ret = -EPROBE_DEFER;
 			} else {
 				/* Ran out of tries. */
-				pr_notice("%s: Ran out of tries for device.\n",
-					  __func__);
+				pr_notice("ran out of tries for device.\n");
 				i2c_dev->state = TIMEDOUT;
 			}
 		} else {
@@ -600,7 +597,7 @@ static int __init chromeos_laptop_init(void)
 	int ret;
 
 	if (!dmi_check_system(chromeos_laptop_dmi_table)) {
-		pr_debug("%s unsupported system.\n", __func__);
+		pr_debug("unsupported system\n");
 		return -ENODEV;
 	}
 
-- 
2.16.2.804.g6dcf76e118-goog
