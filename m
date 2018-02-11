Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753295AbeBKJj5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 04:39:57 -0500
Received: from mailout2.hostsharing.net ([83.223.90.233]:54069 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753178AbeBKJjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 04:39:54 -0500
X-Mailbox-Line: From b7d2cbb609a80f59ccabfdf479b9d5907c603ea1 Mon Sep 17 00:00:00 2001
Message-Id: <b7d2cbb609a80f59ccabfdf479b9d5907c603ea1.1518338789.git.lukas@wunner.de>
In-Reply-To: <cover.1518338788.git.lukas@wunner.de>
References: <cover.1518338788.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 11 Feb 2018 10:38:28 +0100
Subject: [PATCH 3/5] drm/nouveau: Fix deadlock on runtime suspend
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

nouveau's ->runtime_suspend hook calls drm_kms_helper_poll_disable(),
which waits for the output poll worker to finish if it's running.

The output poll worker meanwhile calls pm_runtime_get_sync() in
nouveau_connector_detect() which waits for the ongoing suspend to finish,
causing a deadlock.

Fix by not acquiring a runtime PM ref if nouveau_connector_detect() is
called in the output poll worker's context.  This is safe because
the poll worker is only enabled while runtime active and we know that
->runtime_suspend waits for it to finish.

Other contexts calling nouveau_connector_detect() do require a runtime
PM ref, these comprise:

  status_store() drm sysfs interface
  ->fill_modes drm callback
  drm_fb_helper_probe_connector_modes()
  drm_mode_getconnector()
  nouveau_connector_hotplug()
  nouveau_display_hpd_work()
  nv17_tv_set_property()

Stack trace for posterity:

  INFO: task kworker/0:1:58 blocked for more than 120 seconds.
  Workqueue: events output_poll_execute [drm_kms_helper]
  Call Trace:
   schedule+0x28/0x80
   rpm_resume+0x107/0x6e0
   __pm_runtime_resume+0x47/0x70
   nouveau_connector_detect+0x7e/0x4a0 [nouveau]
   nouveau_connector_detect_lvds+0x132/0x180 [nouveau]
   drm_helper_probe_detect_ctx+0x85/0xd0 [drm_kms_helper]
   output_poll_execute+0x11e/0x1c0 [drm_kms_helper]
   process_one_work+0x184/0x380
   worker_thread+0x2e/0x390

  INFO: task kworker/0:2:252 blocked for more than 120 seconds.
  Workqueue: pm pm_runtime_work
  Call Trace:
   schedule+0x28/0x80
   schedule_timeout+0x1e3/0x370
   wait_for_completion+0x123/0x190
   flush_work+0x142/0x1c0
   nouveau_pmops_runtime_suspend+0x7e/0xd0 [nouveau]
   pci_pm_runtime_suspend+0x5c/0x180
   vga_switcheroo_runtime_suspend+0x1e/0xa0
   __rpm_callback+0xc1/0x200
   rpm_callback+0x1f/0x70
   rpm_suspend+0x13c/0x640
   pm_runtime_work+0x6e/0x90
   process_one_work+0x184/0x380
   worker_thread+0x2e/0x390

Bugzilla: https://bugs.archlinux.org/task/53497
Bugzilla: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=870523
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=70388#c33
Fixes: 5addcf0a5f0f ("nouveau: add runtime PM support (v0.9)")
Cc: stable@vger.kernel.org # v3.12+: 1234567890ab: workqueue: Allow retrieval of current task's work struct
Cc: stable@vger.kernel.org # v3.12+: 1234567890ab: drm: Allow determining if current task is output poll worker
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Dave Airlie <airlied@redhat.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 69d6e61a01ec..6ed9cb053dfa 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -570,9 +570,15 @@ nouveau_connector_detect(struct drm_connector *connector, bool force)
 		nv_connector->edid = NULL;
 	}
 
-	ret = pm_runtime_get_sync(connector->dev->dev);
-	if (ret < 0 && ret != -EACCES)
-		return conn_status;
+	/* Outputs are only polled while runtime active, so acquiring a
+	 * runtime PM ref here is unnecessary (and would deadlock upon
+	 * runtime suspend because it waits for polling to finish).
+	 */
+	if (!drm_kms_helper_is_poll_worker()) {
+		ret = pm_runtime_get_sync(connector->dev->dev);
+		if (ret < 0 && ret != -EACCES)
+			return conn_status;
+	}
 
 	nv_encoder = nouveau_connector_ddc_detect(connector);
 	if (nv_encoder && (i2c = nv_encoder->i2c) != NULL) {
@@ -647,8 +653,10 @@ nouveau_connector_detect(struct drm_connector *connector, bool force)
 
  out:
 
-	pm_runtime_mark_last_busy(connector->dev->dev);
-	pm_runtime_put_autosuspend(connector->dev->dev);
+	if (!drm_kms_helper_is_poll_worker()) {
+		pm_runtime_mark_last_busy(connector->dev->dev);
+		pm_runtime_put_autosuspend(connector->dev->dev);
+	}
 
 	return conn_status;
 }
-- 
2.15.1
