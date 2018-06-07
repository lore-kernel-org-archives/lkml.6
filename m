Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id FeieEHBMGVuZYQAAmS7hNA
	; Thu, 07 Jun 2018 15:17:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AFC00608B8; Thu,  7 Jun 2018 15:17:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E252860590;
	Thu,  7 Jun 2018 15:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E252860590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936008AbeFGPRi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:17:38 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41314 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935246AbeFGPAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:00:01 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvba-0005Zl-KI; Thu, 07 Jun 2018 15:09:34 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb8-00035E-H0; Thu, 07 Jun 2018 15:09:06 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Dave Airlie" <airlied@redhat.com>,
        "Lukas Wunner" <lukas@wunner.de>, "Lyude Paul" <lyude@redhat.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        "Ismo Toijala" <ismo.toijala@gmail.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.454260914@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 257/410] drm/radeon: Fix deadlock on runtime suspend
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

commit 15734feff2bdac24aa3266c437cffa42851990e3 upstream.

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
Cc: Ismo Toijala <ismo.toijala@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Dave Airlie <airlied@redhat.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Link: https://patchwork.freedesktop.org/patch/msgid/64ea02c44f91dda19bc563902b97bbc699040392.1518338789.git.lukas@wunner.de
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/radeon/radeon_connectors.c | 74 ++++++++++++++--------
 1 file changed, 49 insertions(+), 25 deletions(-)

--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -707,9 +707,11 @@ radeon_lvds_detect(struct drm_connector
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
@@ -739,8 +741,12 @@ radeon_lvds_detect(struct drm_connector
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
 
@@ -842,9 +848,11 @@ radeon_vga_detect(struct drm_connector *
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
@@ -913,8 +921,10 @@ radeon_vga_detect(struct drm_connector *
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
@@ -977,9 +987,11 @@ radeon_tv_detect(struct drm_connector *c
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
@@ -991,8 +1003,12 @@ radeon_tv_detect(struct drm_connector *c
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
 
@@ -1064,9 +1080,11 @@ radeon_dvi_detect(struct drm_connector *
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
 
 	if (!force && radeon_check_hpd_status_unchanged(connector)) {
 		ret = connector->status;
@@ -1225,8 +1243,10 @@ out:
 	radeon_connector_update_scratch_regs(connector, ret);
 
 exit:
-	pm_runtime_mark_last_busy(connector->dev->dev);
-	pm_runtime_put_autosuspend(connector->dev->dev);
+	if (!drm_kms_helper_is_poll_worker()) {
+		pm_runtime_mark_last_busy(connector->dev->dev);
+		pm_runtime_put_autosuspend(connector->dev->dev);
+	}
 
 	return ret;
 }
@@ -1480,9 +1500,11 @@ radeon_dp_detect(struct drm_connector *c
 	struct drm_encoder *encoder = radeon_best_single_encoder(connector);
 	int r;
 
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
@@ -1557,8 +1579,10 @@ radeon_dp_detect(struct drm_connector *c
 
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
