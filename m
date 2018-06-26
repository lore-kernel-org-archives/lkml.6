Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7B7C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A85DA263BD
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A85DA263BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934834AbeFZBJ2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 21:09:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36908 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933294AbeFZBJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 21:09:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 83673401EF1D;
        Tue, 26 Jun 2018 01:09:25 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-122-29.rdu2.redhat.com [10.10.122.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D9C4F111DCEB;
        Tue, 26 Jun 2018 01:09:24 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     amd-gfx@lists.freedesktop.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>, Monk Liu <Monk.Liu@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Shaoyun Liu <Shaoyun.Liu@amd.com>, Rex Zhu <Rex.Zhu@amd.com>,
        Jean Delvare <jdelvare@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] drm/amdgpu: Make struct amdgpu_atif private to amdgpu_acpi.c
Date:   Mon, 25 Jun 2018 21:09:04 -0400
Message-Id: <20180626010916.20300-2-lyude@redhat.com>
In-Reply-To: <20180626010916.20300-1-lyude@redhat.com>
References: <20180626010916.20300-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 26 Jun 2018 01:09:25 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 26 Jun 2018 01:09:25 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there is nothing in amdgpu that actually uses these structs
other than amdgpu_acpi.c. Additionally, since we're about to start
saving the correct ACPI handle to use for calling ATIF in this struct
this saves us from having to handle making sure that the acpi_handle
(and by proxy, the type definition for acpi_handle and all of the other
acpi headers) doesn't need to be included within the amdgpu_drv struct
itself. This follows the example set by amdgpu_atpx_handler.c.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 40 +-----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 54 ++++++++++++++++++++++--
 2 files changed, 53 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c8b605f3dc05..e7e70518748a 100644
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 8fa850a070e0..22c7e8ec0b9a 100644
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
@@ -292,7 +329,7 @@ static int amdgpu_atif_get_sbios_requests(acpi_handle handle,
 static int amdgpu_atif_handler(struct amdgpu_device *adev,
 			struct acpi_bus_event *event)
 {
-	struct amdgpu_atif *atif = &adev->atif;
+	struct amdgpu_atif *atif = adev->atif;
 	struct atif_sbios_requests req;
 	acpi_handle handle;
 	int count;
@@ -303,7 +340,8 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,
 	if (strcmp(event->device_class, ACPI_VIDEO_CLASS) != 0)
 		return NOTIFY_DONE;
 
-	if (!atif->notification_cfg.enabled ||
+	if (!atif ||
+	    !atif->notification_cfg.enabled ||
 	    event->type != atif->notification_cfg.command_code)
 		/* Not our event */
 		return NOTIFY_DONE;
@@ -642,7 +680,7 @@ static int amdgpu_acpi_event(struct notifier_block *nb,
 int amdgpu_acpi_init(struct amdgpu_device *adev)
 {
 	acpi_handle handle;
-	struct amdgpu_atif *atif = &adev->atif;
+	struct amdgpu_atif *atif;
 	struct amdgpu_atcs *atcs = &adev->atcs;
 	int ret;
 
@@ -659,11 +697,19 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
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
@@ -720,4 +766,6 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
 void amdgpu_acpi_fini(struct amdgpu_device *adev)
 {
 	unregister_acpi_notifier(&adev->acpi_nb);
+	if (adev->atif)
+		kfree(adev->atif);
 }
-- 
2.17.1

