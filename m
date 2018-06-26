Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D07C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29025263BD
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29025263BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935236AbeFZBJk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 21:09:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41452 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934731AbeFZBJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 21:09:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6161F8790F;
        Tue, 26 Jun 2018 01:09:33 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-122-29.rdu2.redhat.com [10.10.122.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D682D111DCEB;
        Tue, 26 Jun 2018 01:09:32 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     amd-gfx@lists.freedesktop.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>, Rex Zhu <Rex.Zhu@amd.com>,
        Jean Delvare <jdelvare@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] drm/amdgpu: Dynamically probe for ATIF handle
Date:   Mon, 25 Jun 2018 21:09:07 -0400
Message-Id: <20180626010916.20300-5-lyude@redhat.com>
In-Reply-To: <20180626010916.20300-1-lyude@redhat.com>
References: <20180626010916.20300-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 26 Jun 2018 01:09:33 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 26 Jun 2018 01:09:33 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The other day I was testing one of the HP laptops at my office with an
i915/amdgpu hybrid setup and noticed that hotplugging was non-functional
on almost all of the display outputs. I eventually discovered that all
of the external outputs were connected to the amdgpu device instead of
i915, and that the hotplugs weren't being detected so long as the GPU
was in runtime suspend. After some talking with folks at AMD, I learned
that amdgpu is actually supposed to support hotplug detection in runtime
suspend so long as the OEM has implemented it properly in the firmware.

On this HP ZBook 15 G4 (the machine in question), amdgpu wasn't managing
to find the ATIF handle at all despite the fact that I could see acpi
events being sent in response to any hotplugging. After going through
dumps of the firmware, I discovered that this machine did in fact
support ATIF, but that it's ATIF method lived in an entirely different
namespace than this device's handle (the device handle was
\_SB_.PCI0.PEG0.PEGP, but ATIF lives in ATPX's handle at
\_SB_.PCI0.GFX0).

So, fix this by probing ATPX's ACPI parent's namespace if we can't find
ATIF elsewhere, along with storing a pointer to the proper handle to use
for ATIF and using that instead of the device's handle.

This fixes HPD detection while in runtime suspend for this ZBook!

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 80 +++++++++++++++++-------
 1 file changed, 59 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 22c7e8ec0b9a..b0d7978c475d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -65,6 +65,8 @@ struct amdgpu_atif_functions {
 };
 
 struct amdgpu_atif {
+	acpi_handle handle;
+
 	struct amdgpu_atif_notifications notifications;
 	struct amdgpu_atif_functions functions;
 	struct amdgpu_atif_notification_cfg notification_cfg;
@@ -83,8 +85,9 @@ struct amdgpu_atif {
  * Executes the requested ATIF function (all asics).
  * Returns a pointer to the acpi output buffer.
  */
-static union acpi_object *amdgpu_atif_call(acpi_handle handle, int function,
-		struct acpi_buffer *params)
+static union acpi_object *amdgpu_atif_call(struct amdgpu_atif *atif,
+					   int function,
+					   struct acpi_buffer *params)
 {
 	acpi_status status;
 	union acpi_object atif_arg_elements[2];
@@ -107,7 +110,8 @@ static union acpi_object *amdgpu_atif_call(acpi_handle handle, int function,
 		atif_arg_elements[1].integer.value = 0;
 	}
 
-	status = acpi_evaluate_object(handle, "ATIF", &atif_arg, &buffer);
+	status = acpi_evaluate_object(atif->handle, NULL, &atif_arg,
+				      &buffer);
 
 	/* Fail only if calling the method fails and ATIF is supported */
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
@@ -178,15 +182,14 @@ static void amdgpu_atif_parse_functions(struct amdgpu_atif_functions *f, u32 mas
  * (all asics).
  * returns 0 on success, error on failure.
  */
-static int amdgpu_atif_verify_interface(acpi_handle handle,
-		struct amdgpu_atif *atif)
+static int amdgpu_atif_verify_interface(struct amdgpu_atif *atif)
 {
 	union acpi_object *info;
 	struct atif_verify_interface output;
 	size_t size;
 	int err = 0;
 
-	info = amdgpu_atif_call(handle, ATIF_FUNCTION_VERIFY_INTERFACE, NULL);
+	info = amdgpu_atif_call(atif, ATIF_FUNCTION_VERIFY_INTERFACE, NULL);
 	if (!info)
 		return -EIO;
 
@@ -213,6 +216,36 @@ static int amdgpu_atif_verify_interface(acpi_handle handle,
 	return err;
 }
 
+static acpi_handle amdgpu_atif_probe_handle(acpi_handle dhandle)
+{
+	acpi_handle handle = NULL;
+	char acpi_method_name[255] = { 0 };
+	struct acpi_buffer buffer = { sizeof(acpi_method_name), acpi_method_name };
+	acpi_status status;
+
+	/* First check the device handle */
+	status = acpi_get_handle(dhandle, "ATIF", &handle);
+	if (ACPI_SUCCESS(status))
+		goto out;
+
+	/* Some vendors stick the ATIF methods in the same namespace as the
+	 * ATPX methods
+	 */
+	if (amdgpu_has_atpx()) {
+		status = acpi_get_handle(amdgpu_atpx_get_dhandle(), "ATIF",
+					 &handle);
+		if (ACPI_SUCCESS(status))
+			goto out;
+	}
+
+	DRM_DEBUG_DRIVER("No ATIF handle found\n");
+	return NULL;
+out:
+	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
+	DRM_DEBUG_DRIVER("Found ATIF handle %s\n", acpi_method_name);
+	return handle;
+}
+
 /**
  * amdgpu_atif_get_notification_params - determine notify configuration
  *
@@ -225,15 +258,16 @@ static int amdgpu_atif_verify_interface(acpi_handle handle,
  * where n is specified in the result if a notifier is used.
  * Returns 0 on success, error on failure.
  */
-static int amdgpu_atif_get_notification_params(acpi_handle handle,
-		struct amdgpu_atif_notification_cfg *n)
+static int amdgpu_atif_get_notification_params(struct amdgpu_atif *atif)
 {
 	union acpi_object *info;
+	struct amdgpu_atif_notification_cfg *n = &atif->notification_cfg;
 	struct atif_system_params params;
 	size_t size;
 	int err = 0;
 
-	info = amdgpu_atif_call(handle, ATIF_FUNCTION_GET_SYSTEM_PARAMETERS, NULL);
+	info = amdgpu_atif_call(atif, ATIF_FUNCTION_GET_SYSTEM_PARAMETERS,
+				NULL);
 	if (!info) {
 		err = -EIO;
 		goto out;
@@ -287,14 +321,15 @@ static int amdgpu_atif_get_notification_params(acpi_handle handle,
  * (all asics).
  * Returns 0 on success, error on failure.
  */
-static int amdgpu_atif_get_sbios_requests(acpi_handle handle,
-		struct atif_sbios_requests *req)
+static int amdgpu_atif_get_sbios_requests(struct amdgpu_atif *atif,
+					  struct atif_sbios_requests *req)
 {
 	union acpi_object *info;
 	size_t size;
 	int count = 0;
 
-	info = amdgpu_atif_call(handle, ATIF_FUNCTION_GET_SYSTEM_BIOS_REQUESTS, NULL);
+	info = amdgpu_atif_call(atif, ATIF_FUNCTION_GET_SYSTEM_BIOS_REQUESTS,
+				NULL);
 	if (!info)
 		return -EIO;
 
@@ -327,11 +362,10 @@ static int amdgpu_atif_get_sbios_requests(acpi_handle handle,
  * Returns NOTIFY code
  */
 static int amdgpu_atif_handler(struct amdgpu_device *adev,
-			struct acpi_bus_event *event)
+			       struct acpi_bus_event *event)
 {
 	struct amdgpu_atif *atif = adev->atif;
 	struct atif_sbios_requests req;
-	acpi_handle handle;
 	int count;
 
 	DRM_DEBUG_DRIVER("event, device_class = %s, type = %#x\n",
@@ -347,8 +381,7 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,
 		return NOTIFY_DONE;
 
 	/* Check pending SBIOS requests */
-	handle = ACPI_HANDLE(&adev->pdev->dev);
-	count = amdgpu_atif_get_sbios_requests(handle, &req);
+	count = amdgpu_atif_get_sbios_requests(atif, &req);
 
 	if (count <= 0)
 		return NOTIFY_DONE;
@@ -679,7 +712,7 @@ static int amdgpu_acpi_event(struct notifier_block *nb,
  */
 int amdgpu_acpi_init(struct amdgpu_device *adev)
 {
-	acpi_handle handle;
+	acpi_handle handle, atif_handle;
 	struct amdgpu_atif *atif;
 	struct amdgpu_atcs *atcs = &adev->atcs;
 	int ret;
@@ -696,14 +729,20 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
 		DRM_DEBUG_DRIVER("Call to ATCS verify_interface failed: %d\n", ret);
 	}
 
-	/* Call the ATIF method */
+	/* Probe for ATIF, and initialize it if found */
+	atif_handle = amdgpu_atif_probe_handle(handle);
+	if (!atif_handle)
+		goto out;
+
 	atif = kzalloc(sizeof(*atif), GFP_KERNEL);
 	if (!atif) {
 		DRM_WARN("Not enough memory to initialize ATIF\n");
 		goto out;
 	}
+	atif->handle = atif_handle;
 
-	ret = amdgpu_atif_verify_interface(handle, atif);
+	/* Call the ATIF method */
+	ret = amdgpu_atif_verify_interface(atif);
 	if (ret) {
 		DRM_DEBUG_DRIVER("Call to ATIF verify_interface failed: %d\n", ret);
 		kfree(atif);
@@ -739,8 +778,7 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
 	}
 
 	if (atif->functions.system_params) {
-		ret = amdgpu_atif_get_notification_params(handle,
-				&atif->notification_cfg);
+		ret = amdgpu_atif_get_notification_params(atif);
 		if (ret) {
 			DRM_DEBUG_DRIVER("Call to GET_SYSTEM_PARAMS failed: %d\n",
 					ret);
-- 
2.17.1

