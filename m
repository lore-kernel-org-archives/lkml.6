Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751804AbeAaS0U (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:26:20 -0500
Received: from mga06.intel.com ([134.134.136.31]:44625 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751753AbeAaS0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:26:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,441,1511856000";
   d="scan'208";a="30975005"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        AceLan Kao <acelan.kao@canonical.com>, linux-kernel@vger.kernel.org,
        pali.rohar@gmail.com, Mario Limonciello <mario.limonciello@dell.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [RFC, PATCH v1] platform/x86: intel-vbtn: Convert to pure ACPI driver
Date: Wed, 31 Jan 2018 20:26:14 +0200
Message-Id: <20180131182614.19524-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove code duplication by converting driver to pure ACPI one.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
- not tested
 drivers/platform/x86/intel-vbtn.c | 93 +++++++++------------------------------
 1 file changed, 22 insertions(+), 71 deletions(-)

diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
index b703d6f5b099..7201effdf37a 100644
--- a/drivers/platform/x86/intel-vbtn.c
+++ b/drivers/platform/x86/intel-vbtn.c
@@ -24,6 +24,7 @@ static const struct acpi_device_id intel_vbtn_ids[] = {
 	{"INT33D6", 0},
 	{"", 0},
 };
+MODULE_DEVICE_TABLE(acpi, intel_vbtn_ids);
 
 /* In theory, these are HID usages. */
 static const struct key_entry intel_vbtn_keymap[] = {
@@ -47,9 +48,9 @@ struct intel_vbtn_priv {
 	bool wakeup_mode;
 };
 
-static int intel_vbtn_input_setup(struct platform_device *device)
+static int intel_vbtn_input_setup(struct acpi_device *device)
 {
-	struct intel_vbtn_priv *priv = dev_get_drvdata(&device->dev);
+	struct intel_vbtn_priv *priv = acpi_driver_data(device);
 	int ret;
 
 	priv->input_dev = devm_input_allocate_device(&device->dev);
@@ -60,17 +61,15 @@ static int intel_vbtn_input_setup(struct platform_device *device)
 	if (ret)
 		return ret;
 
-	priv->input_dev->dev.parent = &device->dev;
 	priv->input_dev->name = "Intel Virtual Button driver";
 	priv->input_dev->id.bustype = BUS_HOST;
 
 	return input_register_device(priv->input_dev);
 }
 
-static void notify_handler(acpi_handle handle, u32 event, void *context)
+static void notify_handler(struct acpi_device *device, u32 event)
 {
-	struct platform_device *device = context;
-	struct intel_vbtn_priv *priv = dev_get_drvdata(&device->dev);
+	struct intel_vbtn_priv *priv = acpi_driver_data(device);
 	unsigned int val = !(event & 1); /* Even=press, Odd=release */
 	const struct key_entry *ke_rel;
 	bool autorelease;
@@ -97,10 +96,10 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
 	dev_dbg(&device->dev, "unknown event index 0x%x\n", event);
 }
 
-static int intel_vbtn_probe(struct platform_device *device)
+static int intel_vbtn_add(struct acpi_device *device)
 {
 	struct acpi_buffer vgbs_output = { ACPI_ALLOCATE_BUFFER, NULL };
-	acpi_handle handle = ACPI_HANDLE(&device->dev);
+	acpi_handle handle = acpi_device_handle(device);
 	struct intel_vbtn_priv *priv;
 	acpi_status status;
 	int err;
@@ -114,11 +113,11 @@ static int intel_vbtn_probe(struct platform_device *device)
 	priv = devm_kzalloc(&device->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
-	dev_set_drvdata(&device->dev, priv);
+	device->driver_data = priv;
 
 	err = intel_vbtn_input_setup(device);
 	if (err) {
-		pr_err("Failed to setup Intel Virtual Button\n");
+		dev_warn(&device->dev, "Failed to setup Intel Virtual Button\n");
 		return err;
 	}
 
@@ -139,33 +138,14 @@ static int intel_vbtn_probe(struct platform_device *device)
 
 	kfree(vgbs_output.pointer);
 
-	status = acpi_install_notify_handler(handle,
-					     ACPI_DEVICE_NOTIFY,
-					     notify_handler,
-					     device);
-	if (ACPI_FAILURE(status))
-		return -EBUSY;
-
 	device_init_wakeup(&device->dev, true);
 	return 0;
 }
 
-static int intel_vbtn_remove(struct platform_device *device)
-{
-	acpi_handle handle = ACPI_HANDLE(&device->dev);
-
-	acpi_remove_notify_handler(handle, ACPI_DEVICE_NOTIFY, notify_handler);
-
-	/*
-	 * Even if we failed to shut off the event stream, we can still
-	 * safely detach from the device.
-	 */
-	return 0;
-}
-
 static int intel_vbtn_pm_prepare(struct device *dev)
 {
-	struct intel_vbtn_priv *priv = dev_get_drvdata(dev);
+	struct acpi_device *device = to_acpi_device(dev);
+	struct intel_vbtn_priv *priv = acpi_driver_data(device);
 
 	priv->wakeup_mode = true;
 	return 0;
@@ -173,7 +153,8 @@ static int intel_vbtn_pm_prepare(struct device *dev)
 
 static int intel_vbtn_pm_resume(struct device *dev)
 {
-	struct intel_vbtn_priv *priv = dev_get_drvdata(dev);
+	struct acpi_device *device = to_acpi_device(dev);
+	struct intel_vbtn_priv *priv = acpi_driver_data(device);
 
 	priv->wakeup_mode = false;
 	return 0;
@@ -186,46 +167,16 @@ static const struct dev_pm_ops intel_vbtn_pm_ops = {
 	.thaw = intel_vbtn_pm_resume,
 };
 
-static struct platform_driver intel_vbtn_pl_driver = {
+static struct acpi_driver intel_vbtn_driver = {
+	.name = "intel-vbtn",
+	.class = ACPI_BUTTON_CLASS,
+	.ids = intel_vbtn_ids,
+	.ops = {
+		.add = intel_vbtn_add,
+		.notify = notify_handler,
+	},
 	.driver = {
-		.name = "intel-vbtn",
-		.acpi_match_table = intel_vbtn_ids,
 		.pm = &intel_vbtn_pm_ops,
 	},
-	.probe = intel_vbtn_probe,
-	.remove = intel_vbtn_remove,
 };
-MODULE_DEVICE_TABLE(acpi, intel_vbtn_ids);
-
-static acpi_status __init
-check_acpi_dev(acpi_handle handle, u32 lvl, void *context, void **rv)
-{
-	const struct acpi_device_id *ids = context;
-	struct acpi_device *dev;
-
-	if (acpi_bus_get_device(handle, &dev) != 0)
-		return AE_OK;
-
-	if (acpi_match_device_ids(dev, ids) == 0)
-		if (acpi_create_platform_device(dev, NULL))
-			dev_info(&dev->dev,
-				 "intel-vbtn: created platform device\n");
-
-	return AE_OK;
-}
-
-static int __init intel_vbtn_init(void)
-{
-	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-			    ACPI_UINT32_MAX, check_acpi_dev, NULL,
-			    (void *)intel_vbtn_ids, NULL);
-
-	return platform_driver_register(&intel_vbtn_pl_driver);
-}
-module_init(intel_vbtn_init);
-
-static void __exit intel_vbtn_exit(void)
-{
-	platform_driver_unregister(&intel_vbtn_pl_driver);
-}
-module_exit(intel_vbtn_exit);
+module_acpi_driver(intel_vbtn_driver);
-- 
2.15.1
