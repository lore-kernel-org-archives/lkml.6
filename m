Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966038AbeBUPNY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 10:13:24 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46419 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935404AbeBUPNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 10:13:21 -0500
X-Google-Smtp-Source: AH8x2258jmC8W85kgo4pn1Z6myziwj6ad4lG4MJtAecbGfARg+OKkootMUHQAgYbffP3un6bnI/7vQ==
Date: Wed, 21 Feb 2018 16:13:17 +0100
From: Guillaume =?utf-8?Q?Dou=C3=A9zan-Grard?= <gdouezangrard@gmail.com>
To: Andy Shevchenko <andy@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] platform/x86: topstar-laptop: split ACPI events and
 input handling
Message-ID: <a2c2c74033dee3ca1f2b97768e0c6f523c2313b5.1519225570.git.gdouezangrard@gmail.com>
References: <cover.1519225570.git.gdouezangrard@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1519225570.git.gdouezangrard@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* get the `acpi_device` from the `topstar_laptop` struct,

* split input registering and `sparse_keymap` events from ACPI events
handling,

* use notify, init and exit functions for ACPI and input handling

Signed-off-by: Guillaume Douézan-Grard <gdouezangrard@gmail.com>
---
 drivers/platform/x86/topstar-laptop.c | 109 ++++++++++++++++++++++------------
 1 file changed, 71 insertions(+), 38 deletions(-)

diff --git a/drivers/platform/x86/topstar-laptop.c b/drivers/platform/x86/topstar-laptop.c
index 17f22a085d9a..fbf020e8a0e1 100644
--- a/drivers/platform/x86/topstar-laptop.c
+++ b/drivers/platform/x86/topstar-laptop.c
@@ -24,9 +24,14 @@
 #define TOPSTAR_LAPTOP_CLASS "topstar"
 
 struct topstar_laptop {
+	struct acpi_device *device;
 	struct input_dev *input;
 };
 
+/*
+ * Input
+ */
+
 static const struct key_entry topstar_keymap[] = {
 	{ KE_KEY, 0x80, { KEY_BRIGHTNESSUP } },
 	{ KE_KEY, 0x81, { KEY_BRIGHTNESSDOWN } },
@@ -57,40 +62,12 @@ static const struct key_entry topstar_keymap[] = {
 	{ KE_END, 0 }
 };
 
-static void topstar_acpi_notify(struct acpi_device *device, u32 event)
+static void topstar_input_notify(struct topstar_laptop *topstar, int event)
 {
-	static bool dup_evnt[2];
-	bool *dup;
-	struct topstar_laptop *topstar = acpi_driver_data(device);
-
-	/* 0x83 and 0x84 key events comes duplicated... */
-	if (event == 0x83 || event == 0x84) {
-		dup = &dup_evnt[event - 0x83];
-		if (*dup) {
-			*dup = false;
-			return;
-		}
-		*dup = true;
-	}
-
 	if (!sparse_keymap_report_event(topstar->input, event, 1, true))
 		pr_info("unknown event = 0x%02x\n", event);
 }
 
-static int topstar_acpi_fncx_switch(struct acpi_device *device, bool state)
-{
-	acpi_status status;
-
-	status = acpi_execute_simple_method(device->handle, "FNCX",
-						state ? 0x86 : 0x87);
-	if (ACPI_FAILURE(status)) {
-		pr_err("Unable to switch FNCX notifications\n");
-		return -ENODEV;
-	}
-
-	return 0;
-}
-
 static int topstar_input_init(struct topstar_laptop *topstar)
 {
 	struct input_dev *input;
@@ -124,9 +101,62 @@ static int topstar_input_init(struct topstar_laptop *topstar)
 	return err;
 }
 
+static void topstar_input_exit(struct topstar_laptop *topstar)
+{
+	input_unregister_device(topstar->input);
+}
+
+/*
+ * ACPI
+ */
+
+static int topstar_acpi_fncx_switch(struct acpi_device *device, bool state)
+{
+	acpi_status status;
+	u64 arg = state ? 0x86 : 0x87;
+
+	status = acpi_execute_simple_method(device->handle, "FNCX", arg);
+	if (ACPI_FAILURE(status)) {
+		pr_err("Unable to switch FNCX notifications\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void topstar_acpi_notify(struct acpi_device *device, u32 event)
+{
+	struct topstar_laptop *topstar = acpi_driver_data(device);
+	static bool dup_evnt[2];
+	bool *dup;
+
+	/* 0x83 and 0x84 key events comes duplicated... */
+	if (event == 0x83 || event == 0x84) {
+		dup = &dup_evnt[event - 0x83];
+		if (*dup) {
+			*dup = false;
+			return;
+		}
+		*dup = true;
+	}
+
+	topstar_input_notify(topstar, event);
+}
+
+static int topstar_acpi_init(struct topstar_laptop *topstar)
+{
+	return topstar_acpi_fncx_switch(topstar->device, true);
+}
+
+static void topstar_acpi_exit(struct topstar_laptop *topstar)
+{
+	topstar_acpi_fncx_switch(topstar->device, false);
+}
+
 static int topstar_acpi_add(struct acpi_device *device)
 {
 	struct topstar_laptop *topstar;
+	int err;
 
 	topstar = kzalloc(sizeof(struct topstar_laptop), GFP_KERNEL);
 	if (!topstar)
@@ -134,30 +164,34 @@ static int topstar_acpi_add(struct acpi_device *device)
 
 	strcpy(acpi_device_name(device), "Topstar TPSACPI");
 	strcpy(acpi_device_class(device), TOPSTAR_LAPTOP_CLASS);
+	device->driver_data = topstar;
+	topstar->device = device;
 
-	if (topstar_acpi_fncx_switch(device, true))
+	err = topstar_acpi_init(topstar);
+	if (err)
 		goto err_free;
 
-	if (topstar_input_init(topstar))
-		goto err_free;
+	err = topstar_input_init(topstar);
+	if (err)
+		goto err_acpi_exit;
 
-	device->driver_data = topstar;
 	return 0;
 
+err_acpi_exit:
+	topstar_acpi_exit(topstar);
 err_free:
 	kfree(topstar);
-	return -ENODEV;
+	return err;
 }
 
 static int topstar_acpi_remove(struct acpi_device *device)
 {
 	struct topstar_laptop *topstar = acpi_driver_data(device);
 
-	topstar_acpi_fncx_switch(device, false);
+	topstar_input_exit(topstar);
+	topstar_acpi_exit(topstar);
 
-	input_unregister_device(topstar->input);
 	kfree(topstar);
-
 	return 0;
 }
 
@@ -188,7 +222,6 @@ static int __init topstar_laptop_init(void)
 		return ret;
 
 	pr_info("ACPI extras driver loaded\n");
-
 	return 0;
 }
 
-- 
2.16.1
