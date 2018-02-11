Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753355AbeBKJkV (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 04:40:21 -0500
Received: from mailout3.hostsharing.net ([176.9.242.54]:53969 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753230AbeBKJkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 04:40:17 -0500
X-Mailbox-Line: From 64ea02c44f91dda19bc563902b97bbc699040392 Mon Sep 17 00:00:00 2001
Message-Id: <64ea02c44f91dda19bc563902b97bbc699040392.1518338789.git.lukas@wunner.de>
In-Reply-To: <cover.1518338788.git.lukas@wunner.de>
References: <cover.1518338788.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 11 Feb 2018 10:38:28 +0100
Subject: [PATCH 4/5] drm/radeon: Fix deadlock on runtime suspend
To: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dave Airlie <airlied@redhat.com>, Ben Skeggs <bskeggs@redhat.com>
Cc: dri-devel@lists.freedesktop.org, Peter Wu <peter@lekensteyn.nl>,
        nouveau@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Pierre Moreau <pierre.morrow@free.fr>, linux-kernel@vger.kernel.org,
        Ismo Toijala <ismo.toijala@gmail.com>, intel-gfx@lists.freedesktop.org,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Archit Taneja <architt@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

radeon's ->runtime_suspend hook calls drm_kms_helper_poll_disable(),
which waits for the output poll worker to finish if it's running.

The output poll worker meanwhile calls pm_runtime_get_sync() in
radeon's ->detect hooks, which waits for the ongoing suspend to finish,
causing a deadlock.

Fix by not acquiring a runtime PM ref if the ->detect hooks are called
in the output poll worker's context.  This is safe because the poll
worker is only enabled while runtime active and we know that
->runtime_suspend waits for it to finish.

Stack trace for posterity:

  INFO: task kworker/0:3:31847 blocked for more than 120 seconds
  Workqueue: events output_poll_execute [drm_kms_helper]
  Call Trace:
   schedule+0x3c/0x90
   rpm_resume+0x1e2/0x690
   __pm_runtime_resume+0x3f/0x60
   radeon_lvds_detect+0x39/0xf0 [radeon]
   output_poll_execute+0xda/0x1e0 [drm_kms_helper]
   process_one_work+0x14b/0x440
   worker_thread+0x48/0x4a0

  INFO: task kworker/2:0:10493 blocked for more than 120 seconds.
  Workqueue: pm pm_runtime_work
  Call Trace:
   schedule+0x3c/0x90
   schedule_timeout+0x1b3/0x240
   wait_for_common+0xc2/0x180
   wait_for_completion+0x1d/0x20
   flush_work+0xfc/0x1a0
   __cancel_work_timer+0xa5/0x1d0
   cancel_delayed_work_sync+0x13/0x20
   drm_kms_helper_poll_disable+0x1f/0x30 [drm_kms_helper]
   radeon_pmops_runtime_suspend+0x3d/0xa0 [radeon]
   pci_pm_runtime_suspend+0x61/0x1a0
   vga_switcheroo_runtime_suspend+0x21/0x70
   __rpm_callback+0x32/0x70
   rpm_callback+0x24/0x80
   rpm_suspend+0x12b/0x640
   pm_runtime_work+0x6f/0xb0
   process_one_work+0x14b/0x440
   worker_thread+0x48/0x4a0

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=94147
Fixes: 10ebc0bc0934 ("drm/radeon: add runtime PM support (v2)")
Cc: stable@vger.kernel.org # v3.13+: 1234567890ab: workqueue: Allow retrieval of current task's work struct
Cc: stable@vger.kernel.org # v3.13+: 1234567890ab: drm: Allow determining if current task is output poll worker
Cc: Ismo Toijala <ismo.toijala@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Dave Airlie <airlied@redhat.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/gpu/drm/radeon/radeon_connectors.c | 74 ++++++++++++++++++++----------
 1 file changed, 49 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
index 5012f5e47a1e..2e2ca3c6b47d 100644
--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -899,9 +899,11 @@ radeon_lvds_detect(struct drm_connector *connector, bool force)
 	enum drm_connector_status ret = connector_status_disconnected;
 	int r;
 
-	r = pm_runtime_get_sync(connector->dev->dev);
-	if (r < 0)
-		return connector_status_disconnected;
+	if (!drm_kms_helper_is_poll_worker()) {
+		r = pm_runtime_get_sync(connector->dev->dev);
+		if (r < 0)
+			return connector_status_disconnected;
+	}
 
 	if (encoder) {
 		struct radeon_encoder *radeon_encoder = to_radeon_encoder(encoder);
@@ -924,8 +926,12 @@ radeon_lvds_detect(struct drm_connector *connector, bool force)
 	/* check acpi lid status ??? */
 
 	radeon_connector_update_scratch_regs(connector, ret);
-	pm_runtime_mark_last_busy(connector->dev->dev);
-	pm_runtime_put_autosuspend(connector->dev->dev);
+
+	if (!drm_kms_helper_is_poll_worker()) {
+		pm_runtime_mark_last_busy(connector->dev->dev);
+		pm_runtime_put_autosuspend(connector->dev->dev);
+	}
+
 	return ret;
 }
 
@@ -1039,9 +1045,11 @@ radeon_vga_detect(struct drm_connector *connector, bool force)
 	enum drm_connector_status ret = connector_status_disconnected;
 	int r;
 
-	r = pm_runtime_get_sync(connector->dev->dev);
-	if (r < 0)
-		return connector_status_disconnected;
+	if (!drm_kms_helper_is_poll_worker()) {
+		r = pm_runtime_get_sync(connector->dev->dev);
+		if (r < 0)
+			return connector_status_disconnected;
+	}
 
 	encoder = radeon_best_single_encoder(connector);
 	if (!encoder)
@@ -1108,8 +1116,10 @@ radeon_vga_detect(struct drm_connector *connector, bool force)
 	radeon_connector_update_scratch_regs(connector, ret);
 
 out:
-	pm_runtime_mark_last_busy(connector->dev->dev);
-	pm_runtime_put_autosuspend(connector->dev->dev);
+	if (!drm_kms_helper_is_poll_worker()) {
+		pm_runtime_mark_last_busy(connector->dev->dev);
+		pm_runtime_put_autosuspend(connector->dev->dev);
+	}
 
 	return ret;
 }
@@ -1173,9 +1183,11 @@ radeon_tv_detect(struct drm_connector *connector, bool force)
 	if (!radeon_connector->dac_load_detect)
 		return ret;
 
-	r = pm_runtime_get_sync(connector->dev->dev);
-	if (r < 0)
-		return connector_status_disconnected;
+	if (!drm_kms_helper_is_poll_worker()) {
+		r = pm_runtime_get_sync(connector->dev->dev);
+		if (r < 0)
+			return connector_status_disconnected;
+	}
 
 	encoder = radeon_best_single_encoder(connector);
 	if (!encoder)
@@ -1187,8 +1199,12 @@ radeon_tv_detect(struct drm_connector *connector, bool force)
 	if (ret == connector_status_connected)
 		ret = radeon_connector_analog_encoder_conflict_solve(connector, encoder, ret, false);
 	radeon_connector_update_scratch_regs(connector, ret);
-	pm_runtime_mark_last_busy(connector->dev->dev);
-	pm_runtime_put_autosuspend(connector->dev->dev);
+
+	if (!drm_kms_helper_is_poll_worker()) {
+		pm_runtime_mark_last_busy(connector->dev->dev);
+		pm_runtime_put_autosuspend(connector->dev->dev);
+	}
+
 	return ret;
 }
 
@@ -1251,9 +1267,11 @@ radeon_dvi_detect(struct drm_connector *connector, bool force)
 	enum drm_connector_status ret = connector_status_disconnected;
 	bool dret = false, broken_edid = false;
 
-	r = pm_runtime_get_sync(connector->dev->dev);
-	if (r < 0)
-		return connector_status_disconnected;
+	if (!drm_kms_helper_is_poll_worker()) {
+		r = pm_runtime_get_sync(connector->dev->dev);
+		if (r < 0)
+			return connector_status_disconnected;
+	}
 
 	if (radeon_connector->detected_hpd_without_ddc) {
 		force = true;
@@ -1436,8 +1454,10 @@ radeon_dvi_detect(struct drm_connector *connector, bool force)
 	}
 
 exit:
-	pm_runtime_mark_last_busy(connector->dev->dev);
-	pm_runtime_put_autosuspend(connector->dev->dev);
+	if (!drm_kms_helper_is_poll_worker()) {
+		pm_runtime_mark_last_busy(connector->dev->dev);
+		pm_runtime_put_autosuspend(connector->dev->dev);
+	}
 
 	return ret;
 }
@@ -1688,9 +1708,11 @@ radeon_dp_detect(struct drm_connector *connector, bool force)
 	if (radeon_dig_connector->is_mst)
 		return connector_status_disconnected;
 
-	r = pm_runtime_get_sync(connector->dev->dev);
-	if (r < 0)
-		return connector_status_disconnected;
+	if (!drm_kms_helper_is_poll_worker()) {
+		r = pm_runtime_get_sync(connector->dev->dev);
+		if (r < 0)
+			return connector_status_disconnected;
+	}
 
 	if (!force && radeon_check_hpd_status_unchanged(connector)) {
 		ret = connector->status;
@@ -1777,8 +1799,10 @@ radeon_dp_detect(struct drm_connector *connector, bool force)
 	}
 
 out:
-	pm_runtime_mark_last_busy(connector->dev->dev);
-	pm_runtime_put_autosuspend(connector->dev->dev);
+	if (!drm_kms_helper_is_poll_worker()) {
+		pm_runtime_mark_last_busy(connector->dev->dev);
+		pm_runtime_put_autosuspend(connector->dev->dev);
+	}
 
 	return ret;
 }
-- 
2.15.1
