Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCC2C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79920208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79920208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389802AbeGJSgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:36:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48450 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389774AbeGJSgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:36:14 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6924CEC2;
        Tue, 10 Jul 2018 18:36:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.17 07/56] drm/amdgpu: Make struct amdgpu_atif private to amdgpu_acpi.c
Date:   Tue, 10 Jul 2018 20:24:49 +0200
Message-Id: <20180710182503.862537447@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182503.544433950@linuxfoundation.org>
References: <20180710182503.544433950@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lyude Paul <lyude@redhat.com>

commit 2cd5fe22d9a45cdf11c62bbe8db3ce9101207510 upstream.

Currently, there is nothing in amdgpu that actually uses these structs
other than amdgpu_acpi.c. Additionally, since we're about to start
saving the correct ACPI handle to use for calling ATIF in this struct
this saves us from having to handle making sure that the acpi_handle
(and by proxy, the type definition for acpi_handle and all of the other
acpi headers) doesn't need to be included within the amdgpu_drv struct
itself. This follows the example set by amdgpu_atpx_handler.c.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   40 +---------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c |   54 +++++++++++++++++++++++++++++--
 2 files changed, 53 insertions(+), 41 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -188,6 +188,7 @@ struct amdgpu_job;
 struct amdgpu_irq_src;
 struct amdgpu_fpriv;
 struct amdgpu_bo_va_mapping;
+struct amdgpu_atif;
 
 enum amdgpu_cp_irq {
 	AMDGPU_CP_IRQ_GFX_EOP = 0,
@@ -1246,43 +1247,6 @@ struct amdgpu_vram_scratch {
 /*
  * ACPI
  */
-struct amdgpu_atif_notification_cfg {
-	bool enabled;
-	int command_code;
-};
-
-struct amdgpu_atif_notifications {
-	bool display_switch;
-	bool expansion_mode_change;
-	bool thermal_state;
-	bool forced_power_state;
-	bool system_power_state;
-	bool display_conf_change;
-	bool px_gfx_switch;
-	bool brightness_change;
-	bool dgpu_display_event;
-};
-
-struct amdgpu_atif_functions {
-	bool system_params;
-	bool sbios_requests;
-	bool select_active_disp;
-	bool lid_state;
-	bool get_tv_standard;
-	bool set_tv_standard;
-	bool get_panel_expansion_mode;
-	bool set_panel_expansion_mode;
-	bool temperature_change;
-	bool graphics_device_types;
-};
-
-struct amdgpu_atif {
-	struct amdgpu_atif_notifications notifications;
-	struct amdgpu_atif_functions functions;
-	struct amdgpu_atif_notification_cfg notification_cfg;
-	struct amdgpu_encoder *encoder_for_bl;
-};
-
 struct amdgpu_atcs_functions {
 	bool get_ext_state;
 	bool pcie_perf_req;
@@ -1430,7 +1394,7 @@ struct amdgpu_device {
 #if defined(CONFIG_DEBUG_FS)
 	struct dentry			*debugfs_regs[AMDGPU_DEBUGFS_MAX_COMPONENTS];
 #endif
-	struct amdgpu_atif		atif;
+	struct amdgpu_atif		*atif;
 	struct amdgpu_atcs		atcs;
 	struct mutex			srbm_mutex;
 	/* GRBM index mutex. Protects concurrent access to GRBM index */
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -34,6 +34,43 @@
 #include "amd_acpi.h"
 #include "atom.h"
 
+struct amdgpu_atif_notification_cfg {
+	bool enabled;
+	int command_code;
+};
+
+struct amdgpu_atif_notifications {
+	bool display_switch;
+	bool expansion_mode_change;
+	bool thermal_state;
+	bool forced_power_state;
+	bool system_power_state;
+	bool display_conf_change;
+	bool px_gfx_switch;
+	bool brightness_change;
+	bool dgpu_display_event;
+};
+
+struct amdgpu_atif_functions {
+	bool system_params;
+	bool sbios_requests;
+	bool select_active_disp;
+	bool lid_state;
+	bool get_tv_standard;
+	bool set_tv_standard;
+	bool get_panel_expansion_mode;
+	bool set_panel_expansion_mode;
+	bool temperature_change;
+	bool graphics_device_types;
+};
+
+struct amdgpu_atif {
+	struct amdgpu_atif_notifications notifications;
+	struct amdgpu_atif_functions functions;
+	struct amdgpu_atif_notification_cfg notification_cfg;
+	struct amdgpu_encoder *encoder_for_bl;
+};
+
 /* Call the ATIF method
  */
 /**
@@ -292,7 +329,7 @@ out:
 static int amdgpu_atif_handler(struct amdgpu_device *adev,
 			struct acpi_bus_event *event)
 {
-	struct amdgpu_atif *atif = &adev->atif;
+	struct amdgpu_atif *atif = adev->atif;
 	struct atif_sbios_requests req;
 	acpi_handle handle;
 	int count;
@@ -303,7 +340,8 @@ static int amdgpu_atif_handler(struct am
 	if (strcmp(event->device_class, ACPI_VIDEO_CLASS) != 0)
 		return NOTIFY_DONE;
 
-	if (!atif->notification_cfg.enabled ||
+	if (!atif ||
+	    !atif->notification_cfg.enabled ||
 	    event->type != atif->notification_cfg.command_code)
 		/* Not our event */
 		return NOTIFY_DONE;
@@ -642,7 +680,7 @@ static int amdgpu_acpi_event(struct noti
 int amdgpu_acpi_init(struct amdgpu_device *adev)
 {
 	acpi_handle handle;
-	struct amdgpu_atif *atif = &adev->atif;
+	struct amdgpu_atif *atif;
 	struct amdgpu_atcs *atcs = &adev->atcs;
 	int ret;
 
@@ -659,11 +697,19 @@ int amdgpu_acpi_init(struct amdgpu_devic
 	}
 
 	/* Call the ATIF method */
+	atif = kzalloc(sizeof(*atif), GFP_KERNEL);
+	if (!atif) {
+		DRM_WARN("Not enough memory to initialize ATIF\n");
+		goto out;
+	}
+
 	ret = amdgpu_atif_verify_interface(handle, atif);
 	if (ret) {
 		DRM_DEBUG_DRIVER("Call to ATIF verify_interface failed: %d\n", ret);
+		kfree(atif);
 		goto out;
 	}
+	adev->atif = atif;
 
 	if (atif->notifications.brightness_change) {
 		struct drm_encoder *tmp;
@@ -720,4 +766,6 @@ out:
 void amdgpu_acpi_fini(struct amdgpu_device *adev)
 {
 	unregister_acpi_notifier(&adev->acpi_nb);
+	if (adev->atif)
+		kfree(adev->atif);
 }


