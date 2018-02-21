Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966054AbeBUPNd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 10:13:33 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38349 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965894AbeBUPNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 10:13:31 -0500
X-Google-Smtp-Source: AH8x227tiaZWPNB26JzlR1uZ75PScOZMBkBjQRJ4QdwmU8JNJk/CUXnfsPRhwVR+JHBPf/F8gtHt1w==
Date: Wed, 21 Feb 2018 16:13:27 +0100
From: Guillaume =?utf-8?Q?Dou=C3=A9zan-Grard?= <gdouezangrard@gmail.com>
To: Andy Shevchenko <andy@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] platform/x86: topstar-laptop: add platform device
Message-ID: <beab060b046c0818a1fa92ff034a39d68f67a27d.1519225570.git.gdouezangrard@gmail.com>
References: <cover.1519225570.git.gdouezangrard@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1519225570.git.gdouezangrard@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* add a platform device to support further addition of a led subsystem,

* register the existing input device to this platform device

Signed-off-by: Guillaume Douézan-Grard <gdouezangrard@gmail.com>
---
 drivers/platform/x86/topstar-laptop.c | 59 +++++++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/topstar-laptop.c b/drivers/platform/x86/topstar-laptop.c
index fbf020e8a0e1..792c90d62724 100644
--- a/drivers/platform/x86/topstar-laptop.c
+++ b/drivers/platform/x86/topstar-laptop.c
@@ -20,11 +20,13 @@
 #include <linux/acpi.h>
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
+#include <linux/platform_device.h>
 
 #define TOPSTAR_LAPTOP_CLASS "topstar"
 
 struct topstar_laptop {
 	struct acpi_device *device;
+	struct platform_device *platform;
 	struct input_dev *input;
 };
 
@@ -80,6 +82,7 @@ static int topstar_input_init(struct topstar_laptop *topstar)
 	input->name = "Topstar Laptop extra buttons";
 	input->phys = TOPSTAR_LAPTOP_CLASS "/input0";
 	input->id.bustype = BUS_HOST;
+	input->dev.parent = &topstar->platform->dev;
 
 	err = sparse_keymap_setup(input, topstar_keymap, NULL);
 	if (err) {
@@ -106,6 +109,42 @@ static void topstar_input_exit(struct topstar_laptop *topstar)
 	input_unregister_device(topstar->input);
 }
 
+/*
+ * Platform
+ */
+
+static struct platform_driver topstar_platform_driver = {
+	.driver = {
+		.name = TOPSTAR_LAPTOP_CLASS,
+	},
+};
+
+static int topstar_platform_init(struct topstar_laptop *topstar)
+{
+	int err;
+
+	topstar->platform = platform_device_alloc(TOPSTAR_LAPTOP_CLASS, -1);
+	if (!topstar->platform)
+		return -ENOMEM;
+
+	platform_set_drvdata(topstar->platform, topstar);
+
+	err = platform_device_add(topstar->platform);
+	if (err)
+		goto err_device_put;
+
+	return 0;
+
+err_device_put:
+	platform_device_put(topstar->platform);
+	return err;
+}
+
+static void topstar_platform_exit(struct topstar_laptop *topstar)
+{
+	platform_device_unregister(topstar->platform);
+}
+
 /*
  * ACPI
  */
@@ -171,12 +210,18 @@ static int topstar_acpi_add(struct acpi_device *device)
 	if (err)
 		goto err_free;
 
-	err = topstar_input_init(topstar);
+	err = topstar_platform_init(topstar);
 	if (err)
 		goto err_acpi_exit;
 
+	err = topstar_input_init(topstar);
+	if (err)
+		goto err_platform_exit;
+
 	return 0;
 
+err_platform_exit:
+	topstar_platform_exit(topstar);
 err_acpi_exit:
 	topstar_acpi_exit(topstar);
 err_free:
@@ -189,6 +234,7 @@ static int topstar_acpi_remove(struct acpi_device *device)
 	struct topstar_laptop *topstar = acpi_driver_data(device);
 
 	topstar_input_exit(topstar);
+	topstar_platform_exit(topstar);
 	topstar_acpi_exit(topstar);
 
 	kfree(topstar);
@@ -217,17 +263,26 @@ static int __init topstar_laptop_init(void)
 {
 	int ret;
 
-	ret = acpi_bus_register_driver(&topstar_acpi_driver);
+	ret = platform_driver_register(&topstar_platform_driver);
 	if (ret < 0)
 		return ret;
 
+	ret = acpi_bus_register_driver(&topstar_acpi_driver);
+	if (ret < 0)
+		goto err_driver_unreg;
+
 	pr_info("ACPI extras driver loaded\n");
 	return 0;
+
+err_driver_unreg:
+	platform_driver_unregister(&topstar_platform_driver);
+	return ret;
 }
 
 static void __exit topstar_laptop_exit(void)
 {
 	acpi_bus_unregister_driver(&topstar_acpi_driver);
+	platform_driver_unregister(&topstar_platform_driver);
 }
 
 module_init(topstar_laptop_init);
-- 
2.16.1
