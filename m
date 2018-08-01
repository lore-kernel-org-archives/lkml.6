Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7246BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF50208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF50208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732509AbeHAXDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:03:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731622AbeHAXC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:02:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2F9C3819702B;
        Wed,  1 Aug 2018 21:15:17 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BEF1A2026D68;
        Wed,  1 Aug 2018 21:15:16 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Karol Herbst <karolherbst@gmail.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/8] drm/fb_helper: Introduce suspend/resume_hotplug()
Date:   Wed,  1 Aug 2018 17:14:53 -0400
Message-Id: <20180801211459.7731-4-lyude@redhat.com>
In-Reply-To: <20180801211459.7731-1-lyude@redhat.com>
References: <20180801211459.7731-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 01 Aug 2018 21:15:17 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 01 Aug 2018 21:15:17 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
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

Because of this, there's an unreasonable number of places that drm
drivers would need to insert special handling to prevent trying to
resume the device from all of these contexts that can deadlock. It's
difficult even to try synchronizing with fb_helper in these contexts as
well, since any of them could introduce a deadlock by waiting to acquire
the top-level fb_helper mutex, while it's being held by another thread
that might potentially call down to pm_runtime_get_sync().

Luckily-there's no actual reason we need to allow fb_helper to handle
hotplugging at all when runtime suspending a device. If a hotplug
happens during a runtime suspend operation, there's no reason the driver
can't just re-enable fbcon's hotplug handling and bring it up to speed
with hotplugging events it may have missed by calling
drm_fb_helper_hotplug_event().

So, let's make this easy and just add helpers to handle disabling and
enabling fb_helper connector probing() without having to potentially
wait on fb_helper to finish it's work. This will let us fix the runtime
suspend/resume deadlocks that we've been experiencing with nouveau,
along with being able to fix some of the incorrect runtime PM core
interaction that other DRM drivers currently perform to work around
these issues.

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
 drivers/gpu/drm/drm_fb_helper.c | 123 +++++++++++++++++++++++++++++++-
 include/drm/drm_fb_helper.h     |  22 ++++++
 2 files changed, 144 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 2ee1eaa66188..b5f1dee0c3a0 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -84,6 +84,11 @@ static DEFINE_MUTEX(kernel_fb_helper_lock);
  * For suspend/resume consider using drm_mode_config_helper_suspend() and
  * drm_mode_config_helper_resume() which takes care of fbdev as well.
  *
+ * For runtime suspend and runtime resume, drivers which need to disable
+ * normal hotplug handling should consider using
+ * drm_fb_helper_suspend_hotplug() and drm_fb_helper_resume_hotplug() to
+ * avoid deadlocking with fb_helper's hotplug handling.
+ *
  * All other functions exported by the fb helper library can be used to
  * implement the fbdev driver interface by the driver.
  *
@@ -2733,6 +2738,118 @@ int drm_fb_helper_initial_config(struct drm_fb_helper *fb_helper, int bpp_sel)
 }
 EXPORT_SYMBOL(drm_fb_helper_initial_config);
 
+/**
+ * drm_fb_helper_resume_hotplug - Uninhibit fb_helper hotplug handling
+ * @fb_helper: driver-allocated fbdev helper, can be NULL
+ *
+ * Uninhibit fb_helper's hotplug handling after it was previously inhibited by
+ * a call to drm_fb_helper_suspend_hotplug(). Unlike
+ * drm_fb_helper_suspend_hotplug(), this function will wait on
+ * fb_helper->lock.
+ *
+ * This helper will take care of handling any hotplug events that happened
+ * while fb_helper's hotplug handling was suspended. Since this possibly
+ * implies a call to drm_fb_helper_hotplug_event(), care must be taken when
+ * calling this function as it may initiate a modeset.
+ *
+ * Please note that this function is different from
+ * drm_fb_helper_set_suspend(). It does not resume fb_helper, it only allows
+ * fb_helper to probe connectors in response to changes to the device's
+ * connector configuration if this functionality was previously disabled by
+ * drm_fb_helper_suspend_hotplug(). Generally, a driver will only want to call
+ * this in it's runtime resume callbacks.
+ *
+ * Drivers calling drm_fb_helper_suspend_hotplug() must make sure to call this
+ * somewhere in their runtime resume callbacks.
+ *
+ * See also: drm_fb_helper_suspend_hotplug()
+ */
+void
+drm_fb_helper_resume_hotplug(struct drm_fb_helper *fb_helper)
+{
+	bool changed;
+
+	if (!drm_fbdev_emulation || !fb_helper)
+		return;
+
+	mutex_lock(&fb_helper->lock);
+
+	changed = !fb_helper->deferred_setup &&
+		  fb_helper->fb &&
+		  drm_fb_helper_is_bound(fb_helper) &&
+		  fb_helper->hotplug_suspended &&
+		  fb_helper->delayed_hotplug;
+	if (changed)
+		fb_helper->delayed_hotplug = false;
+
+	fb_helper->hotplug_suspended = false;
+
+	mutex_unlock(&fb_helper->lock);
+
+	if (changed)
+		drm_fb_helper_hotplug_event(fb_helper);
+}
+EXPORT_SYMBOL(drm_fb_helper_resume_hotplug);
+
+/**
+ * drm_fb_helper_suspend_hotplug - Attempt to temporarily suspend fb_helper's
+ *                                 hotplug handling
+ * @fb_helper: driver-allocated fbdev helper, can be NULL
+ *
+ * Temporarily inhibit fb_helper from responding to connector changes without
+ * blocking on fb_helper->lock, if possible. This can be called by a DRM
+ * driver early on in it's runtime suspend callback to both check whether or
+ * not fb_helper is still busy, and prevent hotplugs that might occur part-way
+ * through the runtime suspend process from being handled by fb_helper until
+ * drm_fb_helper_resume_hotplug() is called. This dramatically simplifies the
+ * runtime suspend process, as it eliminates the possibility that fb_helper
+ * might try to perform a modeset half way through the runtime suspend process
+ * in response to a connector hotplug, something which will almost certainly
+ * lead to deadlocking for drivers that need to disable normal hotplug
+ * handling in their runtime suspend handlers.
+ *
+ * Calls to this function should be put at the very start of a driver's
+ * runtime suspend operation if desired. The driver is then responsible for
+ * re-enabling fb_helper hotplug handling when normal hotplug detection
+ * becomes available on the device again by calling
+ * drm_fb_helper_resume_hotplug(). Usually, a driver will want to re-enable
+ * fb_helper hotplug handling once the hotplug detection capabilities of its
+ * devices have returned to normal (e.g. when the device is runtime resumed,
+ * or after the runtime suspend process was aborted for some reason).
+ *
+ * Please note that this function is different from
+ * drm_fb_helper_set_suspend(), in that it does not actually suspend
+ * fb_helper. It only prevents fb_helper from responding to connector hotplugs
+ * on it's own. Generally, a driver will only want to call this in its
+ * runtime suspend callback.
+ *
+ * See also: drm_fb_helper_resume_hotplug()
+ *
+ * RETURNS:
+ * True if hotplug handling was disabled successfully, or fb_helper wasn't
+ * actually initialized/enabled yet. False if grabbing &fb_helper->lock would
+ * have meant blocking on fb_helper. When this function returns false, this
+ * usually implies means that fb_helper is still busy doing something such as
+ * probing connectors or performing a modeset. Drivers should treat this the
+ * same way they would any other activity on the device, and abort the runtime
+ * suspend process as early as possible in response.
+ */
+bool __must_check
+drm_fb_helper_suspend_hotplug(struct drm_fb_helper *fb_helper)
+{
+	if (!drm_fbdev_emulation || !fb_helper)
+		return true;
+
+	if (!mutex_trylock(&fb_helper->lock))
+		return false;
+
+	fb_helper->hotplug_suspended = true;
+	mutex_unlock(&fb_helper->lock);
+
+	return true;
+}
+EXPORT_SYMBOL(drm_fb_helper_suspend_hotplug);
+
 /**
  * drm_fb_helper_hotplug_event - respond to a hotplug notification by
  *                               probing all the outputs attached to the fb
@@ -2751,6 +2868,9 @@ EXPORT_SYMBOL(drm_fb_helper_initial_config);
  * for a race-free fbcon setup and will make sure that the fbdev emulation will
  * not miss any hotplug events.
  *
+ * See also: drm_fb_helper_suspend_hotplug()
+ * See also: drm_fb_helper_resume_hotplug()
+ *
  * RETURNS:
  * 0 on success and a non-zero error code otherwise.
  */
@@ -2768,7 +2888,8 @@ int drm_fb_helper_hotplug_event(struct drm_fb_helper *fb_helper)
 		return err;
 	}
 
-	if (!fb_helper->fb || !drm_fb_helper_is_bound(fb_helper)) {
+	if (!fb_helper->fb || !drm_fb_helper_is_bound(fb_helper) ||
+	    fb_helper->hotplug_suspended) {
 		fb_helper->delayed_hotplug = true;
 		mutex_unlock(&fb_helper->lock);
 		return err;
diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index b069433e7fc1..9c6e4ceff3af 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -232,6 +232,14 @@ struct drm_fb_helper {
 	 * See also: @deferred_setup
 	 */
 	int preferred_bpp;
+
+	/**
+	 * @hotplug_suspended:
+	 *
+	 * Whether or not we can currently handle hotplug events, or if we
+	 * need to wait for the DRM device to uninhibit us.
+	 */
+	bool hotplug_suspended;
 };
 
 /**
@@ -330,6 +338,11 @@ void drm_fb_helper_fbdev_teardown(struct drm_device *dev);
 
 void drm_fb_helper_lastclose(struct drm_device *dev);
 void drm_fb_helper_output_poll_changed(struct drm_device *dev);
+
+void drm_fb_helper_resume_hotplug(struct drm_fb_helper *fb_helper);
+bool __must_check
+drm_fb_helper_suspend_hotplug(struct drm_fb_helper *fb_helper);
+
 #else
 static inline void drm_fb_helper_prepare(struct drm_device *dev,
 					struct drm_fb_helper *helper,
@@ -564,6 +577,15 @@ static inline void drm_fb_helper_output_poll_changed(struct drm_device *dev)
 {
 }
 
+static inline void
+drm_fb_helper_resume_hotplug(struct drm_fb_helper *fb_helper)
+{
+}
+static inline bool __must_check
+drm_fb_helper_suspend_hotplug(struct drm_fb_helper *fb_helper)
+{
+	return true;
+}
 #endif
 
 static inline int
-- 
2.17.1

