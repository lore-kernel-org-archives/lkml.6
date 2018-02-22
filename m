Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbeBVT6x (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 14:58:53 -0500
Received: from esa4.dell-outbound.iphmx.com ([68.232.149.214]:48154 "EHLO
        esa4.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750816AbeBVT6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 14:58:51 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ErAwAoII9ah2Oa6ERcGgEBAQEBAgEBA?=
 =?us-ascii?q?QEIAQEBAYUlKH0DmwmDGIN2kliCFgo3hH2CMFYWAQIBAQEBAQECAQIQAQEBCgs?=
 =?us-ascii?q?JCCgvgjgkAYJ1Uk9vARKKI61MOoh3gkmFGYIngVeBZ4srgyIFinKIeJBVCYJOk?=
 =?us-ascii?q?0AClEACmCqBPCYCggJwgxKCBAFPEAyCJVmMaAEBAQ?=
X-IPAS-Result: =?us-ascii?q?A2ErAwAoII9ah2Oa6ERcGgEBAQEBAgEBAQEIAQEBAYUlKH0?=
 =?us-ascii?q?DmwmDGIN2kliCFgo3hH2CMFYWAQIBAQEBAQECAQIQAQEBCgsJCCgvgjgkAYJ1U?=
 =?us-ascii?q?k9vARKKI61MOoh3gkmFGYIngVeBZ4srgyIFinKIeJBVCYJOk0AClEACmCqBPCY?=
 =?us-ascii?q?CggJwgxKCBAFPEAyCJVmMaAEBAQ?=
X-LoopCount0: from 10.208.86.39
X-IronPort-AV: E=Sophos;i="5.47,378,1515477600";
   d="scan'208";a="621359774"
X-DLP: DLP_GlobalPCIDSS
From: Mario Limonciello <mario.limonciello@dell.com>
To: dvhart@infradead.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, Jeremy Cline <jeremy@jcline.org>,
        Alex Hung <alex.hung@canonical.com>,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH] platform/x86: Only activate tablet mode switch on 2-in-1's
Date: Thu, 22 Feb 2018 13:58:42 -0600
Message-Id: <1519329522-16919-1-git-send-email-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some laptops such as the XPS 9360 support the intel-vbtn INT33D6
interface but don't initialize the bit that intel-vbtn uses to
represent switching tablet mode.

By running this only on real 2-in-1's it shouldn't cause false
positives.

Fixes: 30323fb6d5 ("Support tablet mode switch")
Reported-by: Jeremy Cline <jeremy@jcline.org>
Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
Note: I also moved the code for detecting tablet into it's own
function.  To keep things under 80 lines with if statements was
making the code very unreadable otherwise.

 drivers/platform/x86/intel-vbtn.c | 46 ++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
index b703d6f..8173307 100644
--- a/drivers/platform/x86/intel-vbtn.c
+++ b/drivers/platform/x86/intel-vbtn.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/dmi.h>
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
 #include <linux/kernel.h>
@@ -97,9 +98,35 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
 	dev_dbg(&device->dev, "unknown event index 0x%x\n", event);
 }
 
-static int intel_vbtn_probe(struct platform_device *device)
+static void detect_tablet_mode(struct platform_device *device)
 {
+	const char *chassis_type = dmi_get_system_info(DMI_CHASSIS_TYPE);
+	struct intel_vbtn_priv *priv = dev_get_drvdata(&device->dev);
+	acpi_handle handle = ACPI_HANDLE(&device->dev);
 	struct acpi_buffer vgbs_output = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+	acpi_status status;
+	int m;
+
+	if (!(chassis_type && strcmp(chassis_type, "31") == 0))
+		goto out;
+
+	status = acpi_evaluate_object(handle, "VGBS", NULL, &vgbs_output);
+	if (ACPI_FAILURE(status))
+		goto out;
+
+	obj = vgbs_output.pointer;
+	if (!(obj && obj->type == ACPI_TYPE_INTEGER))
+		goto out;
+
+	m = !(obj->integer.value & TABLET_MODE_FLAG);
+	input_report_switch(priv->input_dev, SW_TABLET_MODE, m);
+out:
+	kfree(vgbs_output.pointer);
+}
+
+static int intel_vbtn_probe(struct platform_device *device)
+{
 	acpi_handle handle = ACPI_HANDLE(&device->dev);
 	struct intel_vbtn_priv *priv;
 	acpi_status status;
@@ -122,22 +149,7 @@ static int intel_vbtn_probe(struct platform_device *device)
 		return err;
 	}
 
-	/*
-	 * VGBS being present and returning something means we have
-	 * a tablet mode switch.
-	 */
-	status = acpi_evaluate_object(handle, "VGBS", NULL, &vgbs_output);
-	if (ACPI_SUCCESS(status)) {
-		union acpi_object *obj = vgbs_output.pointer;
-
-		if (obj && obj->type == ACPI_TYPE_INTEGER) {
-			int m = !(obj->integer.value & TABLET_MODE_FLAG);
-
-			input_report_switch(priv->input_dev, SW_TABLET_MODE, m);
-		}
-	}
-
-	kfree(vgbs_output.pointer);
+	detect_tablet_mode(device);
 
 	status = acpi_install_notify_handler(handle,
 					     ACPI_DEVICE_NOTIFY,
-- 
2.7.4
