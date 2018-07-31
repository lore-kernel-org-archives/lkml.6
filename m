Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2879C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6EB5208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6EB5208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732027AbeGaCgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 22:36:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731785AbeGaCgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 22:36:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7310440216FC;
        Tue, 31 Jul 2018 00:58:39 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 307A22026D68;
        Tue, 31 Jul 2018 00:58:39 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/nouveau: Prevent redundant connector probes from ACPI
Date:   Mon, 30 Jul 2018 20:58:35 -0400
Message-Id: <20180731005835.21032-2-lyude@redhat.com>
In-Reply-To: <20180731005835.21032-1-lyude@redhat.com>
References: <20180731005835.21032-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 31 Jul 2018 00:58:39 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 31 Jul 2018 00:58:39 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the Lenovo P50 I've been working on, ACPI notifications for hotplugs
always seem happen even while the GPU has it's hotplugs enabled. This
means that we're uselessly scheduling two connector probes every time we
get a hotplug.

Since we can't unregister the acpi handler without causing userspace to
start getting mysterious keypresses from the ACPI_VIDEO_REPROBE events
that are meant for us, simply add a member to nouveau_drm that can be
used to enable/disable our ACPI event handler from being able to
schedule connector probes on it's own.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_display.c | 40 +++++++++++++++--------
 drivers/gpu/drm/nouveau/nouveau_display.h |  4 +--
 drivers/gpu/drm/nouveau/nouveau_drm.c     |  4 +--
 drivers/gpu/drm/nouveau/nouveau_drv.h     |  1 +
 4 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
index b2a93e3fa67b..b80226c87487 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -382,13 +382,16 @@ nouveau_display_acpi_ntfy(struct notifier_block *nb, unsigned long val,
 
 	if (!strcmp(info->device_class, ACPI_VIDEO_CLASS)) {
 		if (info->type == ACPI_VIDEO_NOTIFY_PROBE) {
-			/*
-			 * This may be the only indication we receive of a
-			 * connector hotplug on a runtime suspended GPU,
-			 * schedule hpd_work to check.
-			 */
-			NV_DEBUG(drm, "ACPI requested connector probe\n");
-			schedule_work(&drm->hpd_work);
+			if (READ_ONCE(drm->acpi_hpd_enabled)) {
+				/*
+				 * This may be the only indication we receive
+				 * of a connector hotplug on a runtime
+				 * suspended GPU, schedule hpd_work to check.
+				 */
+				NV_DEBUG(drm,
+					 "ACPI requested connector probe\n");
+				schedule_work(&drm->hpd_work);
+			}
 
 			/* acpi-video should not generate keypresses for this */
 			return NOTIFY_BAD;
@@ -400,7 +403,7 @@ nouveau_display_acpi_ntfy(struct notifier_block *nb, unsigned long val,
 #endif
 
 int
-nouveau_display_init(struct drm_device *dev)
+nouveau_display_init(struct drm_device *dev, bool runtime)
 {
 	struct nouveau_display *disp = nouveau_display(dev);
 	struct nouveau_drm *drm = nouveau_drm(dev);
@@ -420,13 +423,20 @@ nouveau_display_init(struct drm_device *dev)
 	}
 	drm_connector_list_iter_end(&conn_iter);
 
+	/* disable ACPI hotplug handling to prevent duplicate connector
+	 * probes
+	 * FIXME: make sure that WRITE_ONCE() implies a store barrier
+	 * beforehand
+	 */
+	WRITE_ONCE(drm->acpi_hpd_enabled, false);
+
 	/* enable flip completion events */
 	nvif_notify_get(&drm->flip);
 	return ret;
 }
 
 void
-nouveau_display_fini(struct drm_device *dev, bool suspend)
+nouveau_display_fini(struct drm_device *dev, bool suspend, bool runtime)
 {
 	struct nouveau_display *disp = nouveau_display(dev);
 	struct nouveau_drm *drm = nouveau_drm(dev);
@@ -443,6 +453,10 @@ nouveau_display_fini(struct drm_device *dev, bool suspend)
 	/* disable flip completion events */
 	nvif_notify_put(&drm->flip);
 
+	/* let ACPI handle hotplugs since we won't have them enabled */
+	if (runtime)
+		WRITE_ONCE(drm->acpi_hpd_enabled, true);
+
 	/* disable hotplug interrupts */
 	drm_connector_list_iter_begin(dev, &conn_iter);
 	nouveau_for_each_non_mst_connector_iter(connector, &conn_iter) {
@@ -619,11 +633,11 @@ nouveau_display_suspend(struct drm_device *dev, bool runtime)
 			}
 		}
 
-		nouveau_display_fini(dev, true);
+		nouveau_display_fini(dev, true, runtime);
 		return 0;
 	}
 
-	nouveau_display_fini(dev, true);
+	nouveau_display_fini(dev, true, runtime);
 
 	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
 		struct nouveau_framebuffer *nouveau_fb;
@@ -656,7 +670,7 @@ nouveau_display_resume(struct drm_device *dev, bool runtime)
 	int ret;
 
 	if (drm_drv_uses_atomic_modeset(dev)) {
-		nouveau_display_init(dev);
+		nouveau_display_init(dev, runtime);
 		if (disp->suspend) {
 			drm_atomic_helper_resume(dev, disp->suspend);
 			disp->suspend = NULL;
@@ -689,7 +703,7 @@ nouveau_display_resume(struct drm_device *dev, bool runtime)
 			NV_ERROR(drm, "Could not pin/map cursor.\n");
 	}
 
-	nouveau_display_init(dev);
+	nouveau_display_init(dev, runtime);
 
 	/* Force CLUT to get re-loaded during modeset */
 	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
diff --git a/drivers/gpu/drm/nouveau/nouveau_display.h b/drivers/gpu/drm/nouveau/nouveau_display.h
index 54aa7c3fa42d..473411120225 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.h
+++ b/drivers/gpu/drm/nouveau/nouveau_display.h
@@ -61,8 +61,8 @@ nouveau_display(struct drm_device *dev)
 
 int  nouveau_display_create(struct drm_device *dev);
 void nouveau_display_destroy(struct drm_device *dev);
-int  nouveau_display_init(struct drm_device *dev);
-void nouveau_display_fini(struct drm_device *dev, bool suspend);
+int  nouveau_display_init(struct drm_device *dev, bool runtime);
+void nouveau_display_fini(struct drm_device *dev, bool suspend, bool runtime);
 int  nouveau_display_suspend(struct drm_device *dev, bool runtime);
 void nouveau_display_resume(struct drm_device *dev, bool runtime);
 int  nouveau_display_vblank_enable(struct drm_device *, unsigned int);
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index c7ec86d6c3c9..65dc5b5cf6ce 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -574,7 +574,7 @@ nouveau_drm_load(struct drm_device *dev, unsigned long flags)
 		goto fail_dispctor;
 
 	if (dev->mode_config.num_crtc) {
-		ret = nouveau_display_init(dev);
+		ret = nouveau_display_init(dev, false);
 		if (ret)
 			goto fail_dispinit;
 	}
@@ -629,7 +629,7 @@ nouveau_drm_unload(struct drm_device *dev)
 	nouveau_debugfs_fini(drm);
 
 	if (dev->mode_config.num_crtc)
-		nouveau_display_fini(dev, false);
+		nouveau_display_fini(dev, false, false);
 	nouveau_display_destroy(dev);
 
 	nouveau_bios_takedown(dev);
diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h b/drivers/gpu/drm/nouveau/nouveau_drv.h
index 6e1acaec3400..22e70e72ec8b 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drv.h
+++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
@@ -201,6 +201,7 @@ struct nouveau_drm {
 	int fbcon_new_state;
 #ifdef CONFIG_ACPI
 	struct notifier_block acpi_nb;
+	bool acpi_hpd_enabled;
 #endif
 
 	/* power management */
-- 
2.17.1

