Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938526AbeBUQJn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:09:43 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46772 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932605AbeBUQJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:09:41 -0500
X-Google-Smtp-Source: AH8x226OHFkxy1g1Ktp6PEhfqsKud0LleBWYjkW4bOjJo9Fsnw/btH4JH7cV9BONTUrT47ONTq9D+A==
Date: Wed, 21 Feb 2018 17:09:37 +0100
From: Guillaume =?utf-8?Q?Dou=C3=A9zan-Grard?= <gdouezangrard@gmail.com>
To: Andy Shevchenko <andy@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/7] platform/x86: topstar-laptop: use consistent naming
 scheme
Message-ID: <4e73ff0de19be2973df565ad0074fb8b58e3937d.1519228823.git.gdouezangrard@gmail.com>
References: <cover.1519228823.git.gdouezangrard@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1519228823.git.gdouezangrard@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* use module prefix naming scheme for functions and programming
constructs,

* consistent label names

Signed-off-by: Guillaume Douézan-Grard <gdouezangrard@gmail.com>
---
 drivers/platform/x86/topstar-laptop.c | 82 +++++++++++++++++------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/platform/x86/topstar-laptop.c b/drivers/platform/x86/topstar-laptop.c
index b4807b868a69..17f22a085d9a 100644
--- a/drivers/platform/x86/topstar-laptop.c
+++ b/drivers/platform/x86/topstar-laptop.c
@@ -21,10 +21,10 @@
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
 
-#define ACPI_TOPSTAR_CLASS "topstar"
+#define TOPSTAR_LAPTOP_CLASS "topstar"
 
-struct topstar_hkey {
-	struct input_dev *inputdev;
+struct topstar_laptop {
+	struct input_dev *input;
 };
 
 static const struct key_entry topstar_keymap[] = {
@@ -57,11 +57,11 @@ static const struct key_entry topstar_keymap[] = {
 	{ KE_END, 0 }
 };
 
-static void acpi_topstar_notify(struct acpi_device *device, u32 event)
+static void topstar_acpi_notify(struct acpi_device *device, u32 event)
 {
 	static bool dup_evnt[2];
 	bool *dup;
-	struct topstar_hkey *hkey = acpi_driver_data(device);
+	struct topstar_laptop *topstar = acpi_driver_data(device);
 
 	/* 0x83 and 0x84 key events comes duplicated... */
 	if (event == 0x83 || event == 0x84) {
@@ -73,11 +73,11 @@ static void acpi_topstar_notify(struct acpi_device *device, u32 event)
 		*dup = true;
 	}
 
-	if (!sparse_keymap_report_event(hkey->inputdev, event, 1, true))
+	if (!sparse_keymap_report_event(topstar->input, event, 1, true))
 		pr_info("unknown event = 0x%02x\n", event);
 }
 
-static int acpi_topstar_fncx_switch(struct acpi_device *device, bool state)
+static int topstar_acpi_fncx_switch(struct acpi_device *device, bool state)
 {
 	acpi_status status;
 
@@ -91,72 +91,72 @@ static int acpi_topstar_fncx_switch(struct acpi_device *device, bool state)
 	return 0;
 }
 
-static int acpi_topstar_init_hkey(struct topstar_hkey *hkey)
+static int topstar_input_init(struct topstar_laptop *topstar)
 {
 	struct input_dev *input;
-	int error;
+	int err;
 
 	input = input_allocate_device();
 	if (!input)
 		return -ENOMEM;
 
 	input->name = "Topstar Laptop extra buttons";
-	input->phys = "topstar/input0";
+	input->phys = TOPSTAR_LAPTOP_CLASS "/input0";
 	input->id.bustype = BUS_HOST;
 
-	error = sparse_keymap_setup(input, topstar_keymap, NULL);
-	if (error) {
+	err = sparse_keymap_setup(input, topstar_keymap, NULL);
+	if (err) {
 		pr_err("Unable to setup input device keymap\n");
 		goto err_free_dev;
 	}
 
-	error = input_register_device(input);
-	if (error) {
+	err = input_register_device(input);
+	if (err) {
 		pr_err("Unable to register input device\n");
 		goto err_free_dev;
 	}
 
-	hkey->inputdev = input;
+	topstar->input = input;
 	return 0;
 
- err_free_dev:
+err_free_dev:
 	input_free_device(input);
-	return error;
+	return err;
 }
 
-static int acpi_topstar_add(struct acpi_device *device)
+static int topstar_acpi_add(struct acpi_device *device)
 {
-	struct topstar_hkey *tps_hkey;
+	struct topstar_laptop *topstar;
 
-	tps_hkey = kzalloc(sizeof(struct topstar_hkey), GFP_KERNEL);
-	if (!tps_hkey)
+	topstar = kzalloc(sizeof(struct topstar_laptop), GFP_KERNEL);
+	if (!topstar)
 		return -ENOMEM;
 
 	strcpy(acpi_device_name(device), "Topstar TPSACPI");
-	strcpy(acpi_device_class(device), ACPI_TOPSTAR_CLASS);
+	strcpy(acpi_device_class(device), TOPSTAR_LAPTOP_CLASS);
 
-	if (acpi_topstar_fncx_switch(device, true))
-		goto add_err;
+	if (topstar_acpi_fncx_switch(device, true))
+		goto err_free;
 
-	if (acpi_topstar_init_hkey(tps_hkey))
-		goto add_err;
+	if (topstar_input_init(topstar))
+		goto err_free;
 
-	device->driver_data = tps_hkey;
+	device->driver_data = topstar;
 	return 0;
 
-add_err:
-	kfree(tps_hkey);
+err_free:
+	kfree(topstar);
 	return -ENODEV;
 }
 
-static int acpi_topstar_remove(struct acpi_device *device)
+static int topstar_acpi_remove(struct acpi_device *device)
 {
-	struct topstar_hkey *tps_hkey = acpi_driver_data(device);
+	struct topstar_laptop *topstar = acpi_driver_data(device);
 
-	acpi_topstar_fncx_switch(device, false);
+	topstar_acpi_fncx_switch(device, false);
 
-	input_unregister_device(tps_hkey->inputdev);
-	kfree(tps_hkey);
+	input_unregister_device(topstar->input);
+	kfree(topstar);
 
 	return 0;
 }
@@ -168,14 +168,14 @@ static const struct acpi_device_id topstar_device_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, topstar_device_ids);
 
-static struct acpi_driver acpi_topstar_driver = {
+static struct acpi_driver topstar_acpi_driver = {
 	.name = "Topstar laptop ACPI driver",
-	.class = ACPI_TOPSTAR_CLASS,
+	.class = TOPSTAR_LAPTOP_CLASS,
 	.ids = topstar_device_ids,
 	.ops = {
-		.add = acpi_topstar_add,
-		.remove = acpi_topstar_remove,
-		.notify = acpi_topstar_notify,
+		.add = topstar_acpi_add,
+		.remove = topstar_acpi_remove,
+		.notify = topstar_acpi_notify,
 	},
 };
 
@@ -183,7 +183,7 @@ static int __init topstar_laptop_init(void)
 {
 	int ret;
 
-	ret = acpi_bus_register_driver(&acpi_topstar_driver);
+	ret = acpi_bus_register_driver(&topstar_acpi_driver);
 	if (ret < 0)
 		return ret;
 
@@ -194,7 +194,7 @@ static int __init topstar_laptop_init(void)
 
 static void __exit topstar_laptop_exit(void)
 {
-	acpi_bus_unregister_driver(&acpi_topstar_driver);
+	acpi_bus_unregister_driver(&topstar_acpi_driver);
 }
 
 module_init(topstar_laptop_init);
-- 
2.16.1
