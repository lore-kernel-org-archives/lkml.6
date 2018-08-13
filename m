Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35561C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51C821798
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:17:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D51C821798
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731079AbeHMWAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 18:00:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50170 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729990AbeHMWAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 18:00:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4C40D818A6A9;
        Mon, 13 Aug 2018 19:17:07 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B61C22156712;
        Mon, 13 Aug 2018 19:17:06 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Karol Herbst <karolherbst@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thierry Reding <treding@nvidia.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/5] drm/nouveau: Fix deadlock with fb_helper with async RPM requests
Date:   Mon, 13 Aug 2018 15:16:43 -0400
Message-Id: <20180813191648.27419-4-lyude@redhat.com>
In-Reply-To: <20180813191648.27419-1-lyude@redhat.com>
References: <20180813191648.27419-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 13 Aug 2018 19:17:07 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 13 Aug 2018 19:17:07 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sure I don't need to tell you that fb_helper's locking is a mess.
That being said; fb_helper's locking mess can seriously complicate the
runtime suspend/resume operations of drivers because it can invoke
atomic commits and connector probing from anywhere that calls
drm_fb_helper_hotplug_event(). Since most drivers use
drm_fb_helper_output_poll_changed() as their output_poll_changed
handler, this can happen in every single context that can fire off a
hotplug event. An example:

[  246.669625] INFO: task kworker/4:0:37 blocked for more than 120 seconds.
[  246.673398]       Not tainted 4.18.0-rc5Lyude-Test+ #2
[  246.675271] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  246.676527] kworker/4:0     D    0    37      2 0x80000000
[  246.677580] Workqueue: events output_poll_execute [drm_kms_helper]
[  246.678704] Call Trace:
[  246.679753]  __schedule+0x322/0xaf0
[  246.680916]  schedule+0x33/0x90
[  246.681924]  schedule_preempt_disabled+0x15/0x20
[  246.683023]  __mutex_lock+0x569/0x9a0
[  246.684035]  ? kobject_uevent_env+0x117/0x7b0
[  246.685132]  ? drm_fb_helper_hotplug_event.part.28+0x20/0xb0 [drm_kms_helper]
[  246.686179]  mutex_lock_nested+0x1b/0x20
[  246.687278]  ? mutex_lock_nested+0x1b/0x20
[  246.688307]  drm_fb_helper_hotplug_event.part.28+0x20/0xb0 [drm_kms_helper]
[  246.689420]  drm_fb_helper_output_poll_changed+0x23/0x30 [drm_kms_helper]
[  246.690462]  drm_kms_helper_hotplug_event+0x2a/0x30 [drm_kms_helper]
[  246.691570]  output_poll_execute+0x198/0x1c0 [drm_kms_helper]
[  246.692611]  process_one_work+0x231/0x620
[  246.693725]  worker_thread+0x214/0x3a0
[  246.694756]  kthread+0x12b/0x150
[  246.695856]  ? wq_pool_ids_show+0x140/0x140
[  246.696888]  ? kthread_create_worker_on_cpu+0x70/0x70
[  246.697998]  ret_from_fork+0x3a/0x50
[  246.699034] INFO: task kworker/0:1:60 blocked for more than 120 seconds.
[  246.700153]       Not tainted 4.18.0-rc5Lyude-Test+ #2
[  246.701182] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  246.702278] kworker/0:1     D    0    60      2 0x80000000
[  246.703293] Workqueue: pm pm_runtime_work
[  246.704393] Call Trace:
[  246.705403]  __schedule+0x322/0xaf0
[  246.706439]  ? wait_for_completion+0x104/0x190
[  246.707393]  schedule+0x33/0x90
[  246.708375]  schedule_timeout+0x3a5/0x590
[  246.709289]  ? mark_held_locks+0x58/0x80
[  246.710208]  ? _raw_spin_unlock_irq+0x2c/0x40
[  246.711222]  ? wait_for_completion+0x104/0x190
[  246.712134]  ? trace_hardirqs_on_caller+0xf4/0x190
[  246.713094]  ? wait_for_completion+0x104/0x190
[  246.713964]  wait_for_completion+0x12c/0x190
[  246.714895]  ? wake_up_q+0x80/0x80
[  246.715727]  ? get_work_pool+0x90/0x90
[  246.716649]  flush_work+0x1c9/0x280
[  246.717483]  ? flush_workqueue_prep_pwqs+0x1b0/0x1b0
[  246.718442]  __cancel_work_timer+0x146/0x1d0
[  246.719247]  cancel_delayed_work_sync+0x13/0x20
[  246.720043]  drm_kms_helper_poll_disable+0x1f/0x30 [drm_kms_helper]
[  246.721123]  nouveau_pmops_runtime_suspend+0x3d/0xb0 [nouveau]
[  246.721897]  pci_pm_runtime_suspend+0x6b/0x190
[  246.722825]  ? pci_has_legacy_pm_support+0x70/0x70
[  246.723737]  __rpm_callback+0x7a/0x1d0
[  246.724721]  ? pci_has_legacy_pm_support+0x70/0x70
[  246.725607]  rpm_callback+0x24/0x80
[  246.726553]  ? pci_has_legacy_pm_support+0x70/0x70
[  246.727376]  rpm_suspend+0x142/0x6b0
[  246.728185]  pm_runtime_work+0x97/0xc0
[  246.728938]  process_one_work+0x231/0x620
[  246.729796]  worker_thread+0x44/0x3a0
[  246.730614]  kthread+0x12b/0x150
[  246.731395]  ? wq_pool_ids_show+0x140/0x140
[  246.732202]  ? kthread_create_worker_on_cpu+0x70/0x70
[  246.732878]  ret_from_fork+0x3a/0x50
[  246.733768] INFO: task kworker/4:2:422 blocked for more than 120 seconds.
[  246.734587]       Not tainted 4.18.0-rc5Lyude-Test+ #2
[  246.735393] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  246.736113] kworker/4:2     D    0   422      2 0x80000080
[  246.736789] Workqueue: events_long drm_dp_mst_link_probe_work [drm_kms_helper]
[  246.737665] Call Trace:
[  246.738490]  __schedule+0x322/0xaf0
[  246.739250]  schedule+0x33/0x90
[  246.739908]  rpm_resume+0x19c/0x850
[  246.740750]  ? finish_wait+0x90/0x90
[  246.741541]  __pm_runtime_resume+0x4e/0x90
[  246.742370]  nv50_disp_atomic_commit+0x31/0x210 [nouveau]
[  246.743124]  drm_atomic_commit+0x4a/0x50 [drm]
[  246.743775]  restore_fbdev_mode_atomic+0x1c8/0x240 [drm_kms_helper]
[  246.744603]  restore_fbdev_mode+0x31/0x140 [drm_kms_helper]
[  246.745373]  drm_fb_helper_restore_fbdev_mode_unlocked+0x54/0xb0 [drm_kms_helper]
[  246.746220]  drm_fb_helper_set_par+0x2d/0x50 [drm_kms_helper]
[  246.746884]  drm_fb_helper_hotplug_event.part.28+0x96/0xb0 [drm_kms_helper]
[  246.747675]  drm_fb_helper_output_poll_changed+0x23/0x30 [drm_kms_helper]
[  246.748544]  drm_kms_helper_hotplug_event+0x2a/0x30 [drm_kms_helper]
[  246.749439]  nv50_mstm_hotplug+0x15/0x20 [nouveau]
[  246.750111]  drm_dp_send_link_address+0x177/0x1c0 [drm_kms_helper]
[  246.750764]  drm_dp_check_and_send_link_address+0xa8/0xd0 [drm_kms_helper]
[  246.751602]  drm_dp_mst_link_probe_work+0x51/0x90 [drm_kms_helper]
[  246.752314]  process_one_work+0x231/0x620
[  246.752979]  worker_thread+0x44/0x3a0
[  246.753838]  kthread+0x12b/0x150
[  246.754619]  ? wq_pool_ids_show+0x140/0x140
[  246.755386]  ? kthread_create_worker_on_cpu+0x70/0x70
[  246.756162]  ret_from_fork+0x3a/0x50
[  246.756847]
           Showing all locks held in the system:
[  246.758261] 3 locks held by kworker/4:0/37:
[  246.759016]  #0: 00000000f8df4d2d ((wq_completion)"events"){+.+.}, at: process_one_work+0x1b3/0x620
[  246.759856]  #1: 00000000e6065461 ((work_completion)(&(&dev->mode_config.output_poll_work)->work)){+.+.}, at: process_one_work+0x1b3/0x620
[  246.760670]  #2: 00000000cb66735f (&helper->lock){+.+.}, at: drm_fb_helper_hotplug_event.part.28+0x20/0xb0 [drm_kms_helper]
[  246.761516] 2 locks held by kworker/0:1/60:
[  246.762274]  #0: 00000000fff6be0f ((wq_completion)"pm"){+.+.}, at: process_one_work+0x1b3/0x620
[  246.762982]  #1: 000000005ab44fb4 ((work_completion)(&dev->power.work)){+.+.}, at: process_one_work+0x1b3/0x620
[  246.763890] 1 lock held by khungtaskd/64:
[  246.764664]  #0: 000000008cb8b5c3 (rcu_read_lock){....}, at: debug_show_all_locks+0x23/0x185
[  246.765588] 5 locks held by kworker/4:2/422:
[  246.766440]  #0: 00000000232f0959 ((wq_completion)"events_long"){+.+.}, at: process_one_work+0x1b3/0x620
[  246.767390]  #1: 00000000bb59b134 ((work_completion)(&mgr->work)){+.+.}, at: process_one_work+0x1b3/0x620
[  246.768154]  #2: 00000000cb66735f (&helper->lock){+.+.}, at: drm_fb_helper_restore_fbdev_mode_unlocked+0x4c/0xb0 [drm_kms_helper]
[  246.768966]  #3: 000000004c8f0b6b (crtc_ww_class_acquire){+.+.}, at: restore_fbdev_mode_atomic+0x4b/0x240 [drm_kms_helper]
[  246.769921]  #4: 000000004c34a296 (crtc_ww_class_mutex){+.+.}, at: drm_modeset_backoff+0x8a/0x1b0 [drm]
[  246.770839] 1 lock held by dmesg/1038:
[  246.771739] 2 locks held by zsh/1172:
[  246.772650]  #0: 00000000836d0438 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40
[  246.773680]  #1: 000000001f4f4d48 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0xc1/0x870

[  246.775522] =============================================

After trying dozens of different solutions, I found one very simple one
that should also have the benefit of preventing us from having to fight
locking for the rest of our lives. So, we work around these deadlocks by
deferring all fbcon hotplug events that happen after the runtime suspend
process starts until after the device is resumed again.

Changes since v6:
 - Remove unused nouveau_fbcon_hotplugged_in_suspend() - Ilia

Changes since v5:
 - Come up with the (hopefully final) solution for solving this dumb
   problem, one that is a lot less likely to cause issues with locking in
   the future. This should work around all deadlock conditions with fbcon
   brought up thus far.

Changes since v4:
 - Add nouveau_fbcon_hotplugged_in_suspend() to workaround deadlock
   condition that Lukas described
 - Just move all of this out of drm_fb_helper. It seems that other DRM
   drivers have already figured out other workarounds for this. If other
   drivers do end up needing this in the future, we can just move this
   back into drm_fb_helper again.

Changes since v3:
- Actually check if fb_helper is NULL in both new helpers
- Actually check drm_fbdev_emulation in both new helpers
- Don't fire off a fb_helper hotplug unconditionally; only do it if
  the following conditions are true (as otherwise, calling this in the
  wrong spot will cause Bad Things to happen):
  - fb_helper hotplug handling was actually inhibited previously
  - fb_helper actually has a delayed hotplug pending
  - fb_helper is actually bound
  - fb_helper is actually initialized
- Add __must_check to drm_fb_helper_suspend_hotplug(). There's no
  situation where a driver would actually want to use this without
  checking the return value, so enforce that
- Rewrite and clarify the documentation for both helpers.
- Make sure to return true in the drm_fb_helper_suspend_hotplug() stub
  that's provided in drm_fb_helper.h when CONFIG_DRM_FBDEV_EMULATION
  isn't enabled
- Actually grab the toplevel fb_helper lock in
  drm_fb_helper_resume_hotplug(), since it's possible other activity
  (such as a hotplug) could be going on at the same time the driver
  calls drm_fb_helper_resume_hotplug(). We need this to check whether or
  not drm_fb_helper_hotplug_event() needs to be called anyway

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Karol Herbst <karolherbst@gmail.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c   |  2 +-
 drivers/gpu/drm/nouveau/nouveau_display.c |  2 +-
 drivers/gpu/drm/nouveau/nouveau_fbcon.c   | 57 +++++++++++++++++++++++
 drivers/gpu/drm/nouveau/nouveau_fbcon.h   |  5 ++
 4 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 8b522a9b12f6..a0772389ed90 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -2049,7 +2049,7 @@ nv50_disp_atomic_state_alloc(struct drm_device *dev)
 static const struct drm_mode_config_funcs
 nv50_disp_func = {
 	.fb_create = nouveau_user_framebuffer_create,
-	.output_poll_changed = drm_fb_helper_output_poll_changed,
+	.output_poll_changed = nouveau_fbcon_output_poll_changed,
 	.atomic_check = nv50_disp_atomic_check,
 	.atomic_commit = nv50_disp_atomic_commit,
 	.atomic_state_alloc = nv50_disp_atomic_state_alloc,
diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
index 1d36ab5d4796..4b873e668b26 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -293,7 +293,7 @@ nouveau_user_framebuffer_create(struct drm_device *dev,
 
 static const struct drm_mode_config_funcs nouveau_mode_config_funcs = {
 	.fb_create = nouveau_user_framebuffer_create,
-	.output_poll_changed = drm_fb_helper_output_poll_changed,
+	.output_poll_changed = nouveau_fbcon_output_poll_changed,
 };
 
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_fbcon.c b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
index 85c1f10bc2b6..8cf966690963 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fbcon.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
@@ -466,6 +466,7 @@ nouveau_fbcon_set_suspend_work(struct work_struct *work)
 	console_unlock();
 
 	if (state == FBINFO_STATE_RUNNING) {
+		nouveau_fbcon_hotplug_resume(drm->fbcon);
 		pm_runtime_mark_last_busy(drm->dev->dev);
 		pm_runtime_put_sync(drm->dev->dev);
 	}
@@ -487,6 +488,61 @@ nouveau_fbcon_set_suspend(struct drm_device *dev, int state)
 	schedule_work(&drm->fbcon_work);
 }
 
+void
+nouveau_fbcon_output_poll_changed(struct drm_device *dev)
+{
+	struct nouveau_drm *drm = nouveau_drm(dev);
+	struct nouveau_fbdev *fbcon = drm->fbcon;
+	int ret;
+
+	if (!fbcon)
+		return;
+
+	mutex_lock(&fbcon->hotplug_lock);
+
+	ret = pm_runtime_get(dev->dev);
+	if (ret == 1 || ret == -EACCES) {
+		drm_fb_helper_hotplug_event(&fbcon->helper);
+
+		pm_runtime_mark_last_busy(dev->dev);
+		pm_runtime_put_autosuspend(dev->dev);
+	} else if (ret == 0) {
+		/* If the GPU was already in the process of suspending before
+		 * this event happened, then we can't block here as we'll
+		 * deadlock the runtime pmops since they wait for us to
+		 * finish. So, just defer this event for when we runtime
+		 * resume again. It will be handled by fbcon_work.
+		 */
+		NV_DEBUG(drm, "fbcon HPD event deferred until runtime resume\n");
+		fbcon->hotplug_waiting = true;
+		pm_runtime_put_noidle(drm->dev->dev);
+	} else {
+		DRM_WARN("fbcon HPD event lost due to RPM failure: %d\n",
+			 ret);
+	}
+
+	mutex_unlock(&fbcon->hotplug_lock);
+}
+
+void
+nouveau_fbcon_hotplug_resume(struct nouveau_fbdev *fbcon)
+{
+	struct nouveau_drm *drm;
+
+	if (!fbcon)
+		return;
+	drm = nouveau_drm(fbcon->helper.dev);
+
+	mutex_lock(&fbcon->hotplug_lock);
+	if (fbcon->hotplug_waiting) {
+		fbcon->hotplug_waiting = false;
+
+		NV_DEBUG(drm, "Handling deferred fbcon HPD events\n");
+		drm_fb_helper_hotplug_event(&fbcon->helper);
+	}
+	mutex_unlock(&fbcon->hotplug_lock);
+}
+
 int
 nouveau_fbcon_init(struct drm_device *dev)
 {
@@ -505,6 +561,7 @@ nouveau_fbcon_init(struct drm_device *dev)
 
 	drm->fbcon = fbcon;
 	INIT_WORK(&drm->fbcon_work, nouveau_fbcon_set_suspend_work);
+	mutex_init(&fbcon->hotplug_lock);
 
 	drm_fb_helper_prepare(dev, &fbcon->helper, &nouveau_fbcon_helper_funcs);
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_fbcon.h b/drivers/gpu/drm/nouveau/nouveau_fbcon.h
index a6f192ea3fa6..db9d52047ef8 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fbcon.h
+++ b/drivers/gpu/drm/nouveau/nouveau_fbcon.h
@@ -41,6 +41,9 @@ struct nouveau_fbdev {
 	struct nvif_object gdi;
 	struct nvif_object blit;
 	struct nvif_object twod;
+
+	struct mutex hotplug_lock;
+	bool hotplug_waiting;
 };
 
 void nouveau_fbcon_restore(void);
@@ -68,6 +71,8 @@ void nouveau_fbcon_set_suspend(struct drm_device *dev, int state);
 void nouveau_fbcon_accel_save_disable(struct drm_device *dev);
 void nouveau_fbcon_accel_restore(struct drm_device *dev);
 
+void nouveau_fbcon_output_poll_changed(struct drm_device *dev);
+void nouveau_fbcon_hotplug_resume(struct nouveau_fbdev *fbcon);
 extern int nouveau_nofbaccel;
 
 #endif /* __NV50_FBCON_H__ */
-- 
2.17.1

