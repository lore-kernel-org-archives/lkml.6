Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FD6C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB47424762
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB47424762
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967753AbeF1STK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 14:19:10 -0400
Received: from mga12.intel.com ([192.55.52.136]:32148 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965855AbeF1STJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 14:19:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2018 11:19:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,284,1526367600"; 
   d="scan'208";a="241131470"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jun 2018 11:19:08 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     alex.hung@canonical.com, dvhart@infradead.org, andy@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, Mario.Limonciello@dell.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2] platform/x86: intel-hid: Add support for Device Specific Methods
Date:   Thu, 28 Jun 2018 11:19:06 -0700
Message-Id: <20180628181906.54910-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some of the recent platforms, it is possible that stand alone methods
for HEBC() or other methods used in this driver may not exist. In this
case intel-hid driver will fail to load and power button will not be
functional.

It is also possible that some quirks in this driver added for some
platforms may have same issue in loading intel-hid driver.

There is an update to the ACPI details for the HID event filter driver.
In the updated specification a _DSM is added, which has separate function
indexes for each of the previous stand alone methods.

This change brings in support for the _DSM and allows usage of function
index for corresponding stand alone methods.

Details of Device Specific Method:

Intel HID Event Filter Driver _DSM UUID:
eeec56b3-4442-408f-a792-4edd4d758054

• Function index 0: Returns a buffer with a bit-field representing the
supported function IDs.

Function Index	ASL Object
--------------------------------
1		BTNL
2		HDMM
3		HDSM
4		HDEM
5		BTNS
6		BTNE
7		HEBC
8		VGBS
9		HEBC

One significant change is to query the supported methods implemented on
the platform. So the previous HEBC() has two variants. HEBC v1 and
HEBC v2. The v2 version allowed further define which of the 5-button
are actually defined by the platform. HEBC v2 support is only available
via new DSM.

v1 Button details:
Bits [0] - Rotation Lock, Num Lock, Home, End, Page Up,
Page Down
Bits [1] - Wireless Radio Control
Bits [2] - System Power Down
Bits [3] - System Hibernate
Bits [4] - System Sleep/ System Wake
Bits [5] - Scan Next Track
Bits [6] - Scan Previous Track
Bits [7] - Stop
Bits [8] - Play/Pause
Bits [9] - Mute
Bits [10] - Volume Increment
Bits [11] - Volume Decrement
Bits [12] - Display Brightness Increment
Bits [13] - Display Brightness Decrement
Bits [14] - Lock Tablet
Bits [15] - Release Tablet
Bits [16] - Toggle Bezel
Bits [17] - 5 button array
Bits [18-31] - reserved

v2 Buttom details:
Bits [0-16] - Same as v1 version
Bits [17] - 5 button array
Bits [18] – Power Button
Bits [19] - W Home Button
Bits [20] - Volume Up Button
Bits [21] - Volume Down Button
Bits [22] – Rotation Lock Button
Bits [23-31] – reserved

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
Accidently sent the patch without change of version, so please ignore
the previous one sent today.
v2:
	Minor changes suggested by Andy

 drivers/platform/x86/intel-hid.c | 178 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 157 insertions(+), 21 deletions(-)

diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel-hid.c
index b5adba227783..6cf9b7fa5bf0 100644
--- a/drivers/platform/x86/intel-hid.c
+++ b/drivers/platform/x86/intel-hid.c
@@ -96,13 +96,140 @@ struct intel_hid_priv {
 	bool wakeup_mode;
 };
 
-static int intel_hid_set_enable(struct device *device, bool enable)
+#define HID_EVENT_FILTER_UUID	"eeec56b3-4442-408f-a792-4edd4d758054"
+
+enum intel_hid_dsm_fn_codes {
+	INTEL_HID_DSM_FN_INVALID,
+	INTEL_HID_DSM_BTNL_FN,
+	INTEL_HID_DSM_HDMM_FN,
+	INTEL_HID_DSM_HDSM_FN,
+	INTEL_HID_DSM_HDEM_FN,
+	INTEL_HID_DSM_BTNS_FN,
+	INTEL_HID_DSM_BTNE_FN,
+	INTEL_HID_DSM_HEBC_V1_FN,
+	INTEL_HID_DSM_VGBS_FN,
+	INTEL_HID_DSM_HEBC_V2_FN,
+	INTEL_HID_DSM_FN_MAX
+};
+
+static const char *intel_hid_dsm_fn_to_method[INTEL_HID_DSM_FN_MAX] = {
+	NULL,
+	"BTNL",
+	"HDMM",
+	"HDSM",
+	"HDEM",
+	"BTNS",
+	"BTNE",
+	"HEBC",
+	"VGBS",
+	"HEBC"
+};
+
+static unsigned long long intel_hid_dsm_fn_mask;
+static guid_t intel_dsm_guid;
+
+static bool intel_hid_execute_method(acpi_handle handle,
+				     enum intel_hid_dsm_fn_codes fn_index,
+				     unsigned long long arg)
 {
+	union acpi_object *obj, argv4, req;
 	acpi_status status;
+	char *method_name;
 
-	status = acpi_execute_simple_method(ACPI_HANDLE(device), "HDSM",
-					    enable);
-	if (ACPI_FAILURE(status)) {
+	if (fn_index <= INTEL_HID_DSM_FN_INVALID ||
+	    fn_index >= INTEL_HID_DSM_FN_MAX)
+		return false;
+
+	method_name = (char *)intel_hid_dsm_fn_to_method[fn_index];
+
+	if (!(intel_hid_dsm_fn_mask & fn_index))
+		goto skip_dsm_exec;
+
+	/* All methods expects a package with one integer element */
+	req.type = ACPI_TYPE_INTEGER;
+	req.integer.value = arg;
+
+	argv4.type = ACPI_TYPE_PACKAGE;
+	argv4.package.count = 1;
+	argv4.package.elements = &req;
+
+	obj = acpi_evaluate_dsm(handle, &intel_dsm_guid, 1, fn_index, &argv4);
+	if (obj) {
+		acpi_handle_debug(handle, "Exec DSM Fn code: %d[%s] success\n",
+				  fn_index, method_name);
+		ACPI_FREE(obj);
+		return true;
+	}
+
+skip_dsm_exec:
+	status = acpi_execute_simple_method(handle, method_name, arg);
+	if (ACPI_SUCCESS(status))
+		return true;
+
+	return false;
+}
+
+static bool intel_hid_evaluate_method(acpi_handle handle,
+				      enum intel_hid_dsm_fn_codes fn_index,
+				      unsigned long long *result)
+{
+	union acpi_object *obj;
+	acpi_status status;
+	char *method_name;
+
+	if (fn_index <= INTEL_HID_DSM_FN_INVALID ||
+	    fn_index >= INTEL_HID_DSM_FN_MAX)
+		return false;
+
+	method_name = (char *)intel_hid_dsm_fn_to_method[fn_index];
+
+	if (!(intel_hid_dsm_fn_mask & fn_index))
+		goto skip_dsm_eval;
+
+	obj = acpi_evaluate_dsm_typed(handle, &intel_dsm_guid,
+				      1, fn_index,
+				      NULL,  ACPI_TYPE_INTEGER);
+	if (obj) {
+		*result = obj->integer.value;
+		acpi_handle_debug(handle,
+				  "Eval DSM Fn code: %d[%s] results: 0x%llx\n",
+				  fn_index, method_name, *result);
+		ACPI_FREE(obj);
+		return true;
+	}
+
+skip_dsm_eval:
+	status = acpi_evaluate_integer(handle, method_name, NULL, result);
+	if (ACPI_SUCCESS(status))
+		return true;
+
+	return false;
+}
+
+static void intel_hid_init_dsm(acpi_handle handle)
+{
+	union acpi_object *obj;
+
+	guid_parse(HID_EVENT_FILTER_UUID, &intel_dsm_guid);
+
+	obj = acpi_evaluate_dsm_typed(handle, &intel_dsm_guid, 1, 0, NULL,
+				      ACPI_TYPE_BUFFER);
+	if (obj) {
+		intel_hid_dsm_fn_mask = *obj->buffer.pointer;
+		ACPI_FREE(obj);
+	}
+
+	acpi_handle_debug(handle, "intel_hid_dsm_fn_mask = %llx\n",
+			  intel_hid_dsm_fn_mask);
+}
+
+static int intel_hid_set_enable(struct device *device, bool enable)
+{
+	acpi_handle handle = ACPI_HANDLE(device);
+
+	/* Enable|disable features - power button is always enabled */
+	if (!intel_hid_execute_method(handle, INTEL_HID_DSM_HDSM_FN,
+				      enable)) {
 		dev_warn(device, "failed to %sable hotkeys\n",
 			 enable ? "en" : "dis");
 		return -EIO;
@@ -129,9 +256,8 @@ static void intel_button_array_enable(struct device *device, bool enable)
 	}
 
 	/* Enable|disable features - power button is always enabled */
-	status = acpi_execute_simple_method(handle, "BTNE",
-					    enable ? button_cap : 1);
-	if (ACPI_FAILURE(status))
+	if (!intel_hid_execute_method(handle, INTEL_HID_DSM_BTNE_FN,
+				      enable ? button_cap : 1))
 		dev_warn(device, "failed to set button capability\n");
 }
 
@@ -217,7 +343,6 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
 	struct platform_device *device = context;
 	struct intel_hid_priv *priv = dev_get_drvdata(&device->dev);
 	unsigned long long ev_index;
-	acpi_status status;
 
 	if (priv->wakeup_mode) {
 		/*
@@ -269,8 +394,8 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
 		return;
 	}
 
-	status = acpi_evaluate_integer(handle, "HDEM", NULL, &ev_index);
-	if (ACPI_FAILURE(status)) {
+	if (!intel_hid_evaluate_method(handle, INTEL_HID_DSM_HDEM_FN,
+				       &ev_index)) {
 		dev_warn(&device->dev, "failed to get event index\n");
 		return;
 	}
@@ -284,17 +409,24 @@ static bool button_array_present(struct platform_device *device)
 {
 	acpi_handle handle = ACPI_HANDLE(&device->dev);
 	unsigned long long event_cap;
-	acpi_status status;
-	bool supported = false;
 
-	status = acpi_evaluate_integer(handle, "HEBC", NULL, &event_cap);
-	if (ACPI_SUCCESS(status) && (event_cap & 0x20000))
-		supported = true;
+	if (intel_hid_evaluate_method(handle, INTEL_HID_DSM_HEBC_V2_FN,
+				      &event_cap)) {
+		/* Check presence of 5 button array or v2 power button */
+		if (event_cap & 0x60000)
+			return true;
+	}
+
+	if (intel_hid_evaluate_method(handle, INTEL_HID_DSM_HEBC_V1_FN,
+				      &event_cap)) {
+		if (event_cap & 0x20000)
+			return true;
+	}
 
 	if (dmi_check_system(button_array_table))
-		supported = true;
+		return true;
 
-	return supported;
+	return false;
 }
 
 static int intel_hid_probe(struct platform_device *device)
@@ -305,8 +437,9 @@ static int intel_hid_probe(struct platform_device *device)
 	acpi_status status;
 	int err;
 
-	status = acpi_evaluate_integer(handle, "HDMM", NULL, &mode);
-	if (ACPI_FAILURE(status)) {
+	intel_hid_init_dsm(handle);
+
+	if (!intel_hid_evaluate_method(handle, INTEL_HID_DSM_HDMM_FN, &mode)) {
 		dev_warn(&device->dev, "failed to read mode\n");
 		return -ENODEV;
 	}
@@ -352,13 +485,16 @@ static int intel_hid_probe(struct platform_device *device)
 		goto err_remove_notify;
 
 	if (priv->array) {
+		unsigned long long dummy;
+
 		intel_button_array_enable(&device->dev, true);
 
 		/* Call button load method to enable HID power button */
-		status = acpi_evaluate_object(handle, "BTNL", NULL, NULL);
-		if (ACPI_FAILURE(status))
+		if (!intel_hid_evaluate_method(handle, INTEL_HID_DSM_BTNL_FN,
+					       &dummy)) {
 			dev_warn(&device->dev,
 				 "failed to enable HID power button\n");
+		}
 	}
 
 	device_init_wakeup(&device->dev, true);
-- 
2.14.1

