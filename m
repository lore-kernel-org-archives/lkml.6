Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0B6ECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C165620BED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C165620BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbeGQAhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 20:37:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59416 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729613AbeGQAhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 20:37:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CB6504067720;
        Mon, 16 Jul 2018 23:59:57 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-124-27.rdu2.redhat.com [10.10.124.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FA672026D65;
        Mon, 16 Jul 2018 23:59:57 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Karol Herbst <karolherbst@gmail.com>, stable@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] drm/nouveau: Grab RPM ref while probing outputs
Date:   Mon, 16 Jul 2018 19:59:26 -0400
Message-Id: <20180716235936.11268-3-lyude@redhat.com>
In-Reply-To: <20180716235936.11268-1-lyude@redhat.com>
References: <20180716235936.11268-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 16 Jul 2018 23:59:57 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 16 Jul 2018 23:59:57 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When DP MST hubs get confused, they can occasionally stop responding for
a good bit of time up until the point where the DRM driver manages to
do the right DPCD accesses to get it to start responding again. In a
worst case scenario however, this process can take upwards of 10+
seconds.

Currently we use the default output_poll_changed handler
drm_fb_helper_output_poll_changed() to handle output polling, which
doesn't happen to grab any power references on the device when polling.
If we're unlucky enough to have a hub (such as Lenovo's infamous laptop
docks for the P5x/P7x series) that's easily startled and confused, this
can lead to a pretty nasty deadlock situation that looks like this:

- Hotplug event from hub happens, we enter
  drm_fb_helper_output_poll_changed() and start communicating with the
  hub
- While we're in drm_fb_helper_output_poll_changed() and attempting to
  communicate with the hub, we end up confusing it and cause it to stop
  responding for at least 10 seconds
- After 5 seconds of being in drm_fb_helper_output_poll_changed(), the
  pm core attempts to put the GPU into autosuspend, which ends up
  calling drm_kms_helper_poll_disable()
- While the runtime PM core is waiting in drm_kms_helper_poll_disable()
  for the output poll to finish, we end up finally detecting an MST
  display
- We notice the new display and tries to enable it, which triggers
  an atomic commit which triggers a call to pm_runtime_get_sync()
- the output poll thread deadlocks the pm core waiting for the pm core
  to finish the autosuspend request while the pm core waits for the
  output poll thread to finish

Sample:
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

So, to fix this (and any other possible deadlock issues like this that
could occur in the output_poll_changed patch) we make sure that
nouveau's output_poll_changed functions grab a runtime power ref before
sending any hotplug events, and hold it until we're finished.

This fixes deadlock issues when in fbcon with nouveau on my P50, and
should fix it for everyone else's as well!

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Karol Herbst <karolherbst@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index eb3e41a78806..ea2a886854fe 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -2012,10 +2012,18 @@ nv50_disp_atomic_state_alloc(struct drm_device *dev)
 	return &atom->state;
 }
 
+static void
+nouveau_output_poll_changed(struct drm_device *dev)
+{
+	pm_runtime_get_sync(dev->dev);
+	drm_fb_helper_hotplug_event(dev->fb_helper);
+	pm_runtime_put_autosuspend(dev->dev);
+}
+
 static const struct drm_mode_config_funcs
 nv50_disp_func = {
 	.fb_create = nouveau_user_framebuffer_create,
-	.output_poll_changed = drm_fb_helper_output_poll_changed,
+	.output_poll_changed = nouveau_output_poll_changed,
 	.atomic_check = nv50_disp_atomic_check,
 	.atomic_commit = nv50_disp_atomic_commit,
 	.atomic_state_alloc = nv50_disp_atomic_state_alloc,
-- 
2.17.1

