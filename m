Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871A8C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC8020856
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbfA2Sjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:39:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52230 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbfA2Sjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:39:42 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C0A6891D3D;
        Tue, 29 Jan 2019 18:39:40 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 941F15D6A6;
        Tue, 29 Jan 2019 18:39:39 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] drm/atomic: Add drm_atomic_state->suspend_or_resume
Date:   Tue, 29 Jan 2019 13:39:26 -0500
Message-Id: <20190129183928.26779-3-lyude@redhat.com>
In-Reply-To: <20190129183928.26779-1-lyude@redhat.com>
References: <20190129183928.26779-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 29 Jan 2019 18:39:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since

commit 39b50c603878 ("drm/atomic_helper: Stop modesets on unregistered
connectors harder")

We've been failing atomic checks if they try to enable new displays on
unregistered connectors. This is fine except for the one situation that
breaks atomic assumptions: suspend/resume. If a connector is
unregistered before we attempt to restore the atomic state, something we
end up failing the atomic check that happens when trying to restore the
state during resume.

Normally this would be OK: we try our best to make sure that the atomic
state pre-suspend can be restored post-suspend, but failures at that
point usually don't cause problems. That is of course, until we
introduced the new atomic MST VCPI helpers:

[drm:drm_atomic_helper_check_modeset [drm_kms_helper]] [CRTC:65:pipe B] active changed
[drm:drm_atomic_helper_check_modeset [drm_kms_helper]] Updating routing for [CONNECTOR:123:DP-5]
[drm:drm_atomic_helper_check_modeset [drm_kms_helper]] Disabling [CONNECTOR:123:DP-5]
[drm:drm_atomic_get_private_obj_state [drm]] Added new private object 0000000025844636 state 000000009fd2899a to 000000003a13d7b8
WARNING: CPU: 6 PID: 1070 at drivers/gpu/drm/drm_dp_mst_topology.c:3153 drm_dp_atomic_release_vcpi_slots+0xb9/0x200 [drm_kms_helper]
Modules linked in: fuse vfat fat snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic joydev iTCO_wdt i915(O) wmi_bmof intel_rapl btusb btrtl x86_pkg_temp_thermal btbcm btintel coretemp i2c_algo_bit drm_kms_helper(O) crc32_pclmul snd_hda_intel syscopyarea sysfillrect snd_hda_codec sysimgblt snd_hda_core bluetooth fb_sys_fops snd_pcm pcspkr drm(O) psmouse snd_timer mei_me ecdh_generic i2c_i801 mei i2c_core ucsi_acpi typec_ucsi typec wmi thinkpad_acpi ledtrig_audio snd soundcore tpm_tis rfkill tpm_tis_core video tpm acpi_pad pcc_cpufreq uas usb_storage crc32c_intel nvme serio_raw xhci_pci nvme_core xhci_hcd
CPU: 6 PID: 1070 Comm: gnome-shell Tainted: G        W  O      5.0.0-rc2Lyude-Test+ #1
Hardware name: LENOVO 20L8S2N800/20L8S2N800, BIOS N22ET35W (1.12 ) 04/09/2018
RIP: 0010:drm_dp_atomic_release_vcpi_slots+0xb9/0x200 [drm_kms_helper]
Code: 00 4c 39 6d f0 74 49 48 8d 7b 10 48 89 f9 48 c1 e9 03 42 80 3c 21 00 0f 85 d2 00 00 00 48 8b 6b 10 48 8d 5d f0 49 39 ee 75 c5 <0f> 0b 48 c7 c7 c0 78 b3 a0 48 89 c2 4c 89 ee e8 03 6c aa ff b8 ea
RSP: 0018:ffff88841235f268 EFLAGS: 00010246
RAX: ffff88841bf12ab0 RBX: ffff88841bf12aa8 RCX: 1ffff110837e2557
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffffed108246bde0
RBP: ffff88841bf12ab8 R08: ffffed1083db3c93 R09: ffffed1083db3c92
R10: ffffed1083db3c92 R11: ffff88841ed9e497 R12: ffff888419555d80
R13: ffff8883bc499100 R14: ffff88841bf12ab8 R15: 0000000000000000
FS:  00007f16fbd4cd00(0000) GS:ffff88841ed80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1687c9f000 CR3: 00000003ba3cc003 CR4: 00000000003606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 drm_atomic_helper_check_modeset+0xf21/0x2f50 [drm_kms_helper]
 ? drm_atomic_helper_commit_modeset_enables+0xa90/0xa90 [drm_kms_helper]
 ? __printk_safe_exit+0x10/0x10
 ? save_stack+0x8c/0xb0
 ? vprintk_func+0x96/0x1bf
 ? __printk_safe_exit+0x10/0x10
 intel_atomic_check+0x234/0x4750 [i915]
 ? printk+0x9f/0xc5
 ? kmsg_dump_rewind_nolock+0xd9/0xd9
 ? _raw_spin_lock_irqsave+0xa4/0x140
 ? drm_atomic_check_only+0xb1/0x28b0 [drm]
 ? drm_dbg+0x186/0x1b0 [drm]
 ? drm_dev_dbg+0x200/0x200 [drm]
 ? intel_link_compute_m_n+0xb0/0xb0 [i915]
 ? drm_mode_put_tile_group+0x20/0x20 [drm]
 ? skl_plane_format_mod_supported+0x17f/0x1b0 [i915]
 ? drm_plane_check_pixel_format+0x14a/0x310 [drm]
 drm_atomic_check_only+0x13c4/0x28b0 [drm]
 ? drm_state_info+0x220/0x220 [drm]
 ? drm_atomic_helper_disable_plane+0x1d0/0x1d0 [drm_kms_helper]
 ? pick_single_encoder_for_connector+0xe0/0xe0 [drm_kms_helper]
 ? kasan_unpoison_shadow+0x35/0x40
 drm_atomic_commit+0x3b/0x100 [drm]
 drm_atomic_helper_set_config+0xd5/0x100 [drm_kms_helper]
 drm_mode_setcrtc+0x636/0x1660 [drm]
 ? vprintk_func+0x96/0x1bf
 ? drm_dev_dbg+0x200/0x200 [drm]
 ? drm_mode_getcrtc+0x790/0x790 [drm]
 ? printk+0x9f/0xc5
 ? mutex_unlock+0x1d/0x40
 ? drm_mode_addfb2+0x2e9/0x3a0 [drm]
 ? rcu_sync_dtor+0x2e0/0x2e0
 ? drm_dbg+0x186/0x1b0 [drm]
 ? set_page_dirty+0x271/0x4d0
 drm_ioctl_kernel+0x203/0x290 [drm]
 ? drm_mode_getcrtc+0x790/0x790 [drm]
 ? drm_setversion+0x7f0/0x7f0 [drm]
 ? __switch_to_asm+0x34/0x70
 ? __switch_to_asm+0x34/0x70
 drm_ioctl+0x445/0x950 [drm]
 ? drm_mode_getcrtc+0x790/0x790 [drm]
 ? drm_getunique+0x220/0x220 [drm]
 ? expand_files.part.10+0x920/0x920
 do_vfs_ioctl+0x1a1/0x13d0
 ? ioctl_preallocate+0x2b0/0x2b0
 ? __fget_light+0x2d6/0x390
 ? schedule+0xd7/0x2e0
 ? fget_raw+0x10/0x10
 ? apic_timer_interrupt+0xa/0x20
 ? apic_timer_interrupt+0xa/0x20
 ? rcu_cleanup_dead_rnp+0x2c0/0x2c0
 ksys_ioctl+0x60/0x90
 __x64_sys_ioctl+0x6f/0xb0
 do_syscall_64+0x136/0x440
 ? syscall_return_slowpath+0x2d0/0x2d0
 ? do_page_fault+0x89/0x330
 ? __do_page_fault+0x9c0/0x9c0
 ? prepare_exit_to_usermode+0x188/0x200
 ? perf_trace_sys_enter+0x1090/0x1090
 ? __x64_sys_sigaltstack+0x280/0x280
 ? __put_user_4+0x1c/0x30
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f16ff89a09b
Code: 0f 1e fa 48 8b 05 ed bd 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d bd bd 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007fff001232b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fff001232f0 RCX: 00007f16ff89a09b
RDX: 00007fff001232f0 RSI: 00000000c06864a2 RDI: 000000000000000b
RBP: 00007fff001232f0 R08: 0000000000000000 R09: 000055a79d484460
R10: 000055a79d44e770 R11: 0000000000000246 R12: 00000000c06864a2
R13: 000000000000000b R14: 0000000000000000 R15: 000055a79d44e770
WARNING: CPU: 6 PID: 1070 at drivers/gpu/drm/drm_dp_mst_topology.c:3153 drm_dp_atomic_release_vcpi_slots+0xb9/0x200 [drm_kms_helper]
---[ end trace d536c05c13c83be2 ]---
[drm:drm_dp_atomic_release_vcpi_slots [drm_kms_helper]] *ERROR* no VCPI for [MST PORT:00000000f9e2b143] found in mst state 000000009fd2899a

This appears to be happening because we destroy the VCPI allocations
when disabling all connected displays while suspending, and those VCPI
allocations don't get restored on resume due to failing to restore the
atomic state.

So, fix this by introducing the suspending option to
drm_atomic_helper_duplicate_state() and use that to indicate in the
atomic state that it's being used for suspending or resuming the system,
and thus needs to be fixed up by the driver. We can then use the new
state->suspend_or_resume hook to fixup the atomic VCPI helpers so they
merely save and restore the VCPI allocations for such states instead of
performing error checking on them. This fixes the warnings during
suspend/resume when a topology is removed from the system, and allows
us to once again restore the atomic state on resume without any issues.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: eceae1472467 ("drm/dp_mst: Start tracking per-port VCPI allocations")
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/drm_atomic_helper.c   | 16 +++++++++---
 drivers/gpu/drm/drm_dp_mst_topology.c | 36 ++++++++++++++++++++++++---
 drivers/gpu/drm/i915/intel_display.c  |  4 +--
 include/drm/drm_atomic.h              | 11 ++++++++
 include/drm/drm_atomic_helper.h       |  3 ++-
 5 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 6fe2303fccd9..7d23dafdffbc 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -332,8 +332,15 @@ update_connector_routing(struct drm_atomic_state *state,
 	 * about is ensuring that userspace can't do anything but shut off the
 	 * display on a connector that was destroyed after its been notified,
 	 * not before.
+	 *
+	 * Additionally, we also want to ignore connector registration when
+	 * we're trying to restore an atomic state during system resume since
+	 * there's a chance the connector may have been destroyed during the
+	 * process, but it's better to ignore that then cause
+	 * drm_atomic_helper_resume() to fail.
 	 */
-	if (drm_connector_is_unregistered(connector) && crtc_state->active) {
+	if (!state->suspend_or_resume &&
+	    drm_connector_is_unregistered(connector) && crtc_state->active) {
 		DRM_DEBUG_ATOMIC("[CONNECTOR:%d:%s] is not registered\n",
 				 connector->base.id, connector->name);
 		return -EINVAL;
@@ -3144,6 +3151,7 @@ EXPORT_SYMBOL(drm_atomic_helper_shutdown);
  * drm_atomic_helper_duplicate_state - duplicate an atomic state object
  * @dev: DRM device
  * @ctx: lock acquisition context
+ * @suspending: If this state is being duplicated as part of system suspend
  *
  * Makes a copy of the current atomic state by looping over all objects and
  * duplicating their respective states. This is used for example by suspend/
@@ -3166,7 +3174,8 @@ EXPORT_SYMBOL(drm_atomic_helper_shutdown);
  */
 struct drm_atomic_state *
 drm_atomic_helper_duplicate_state(struct drm_device *dev,
-				  struct drm_modeset_acquire_ctx *ctx)
+				  struct drm_modeset_acquire_ctx *ctx,
+				  bool suspending)
 {
 	struct drm_atomic_state *state;
 	struct drm_connector *conn;
@@ -3180,6 +3189,7 @@ drm_atomic_helper_duplicate_state(struct drm_device *dev,
 		return ERR_PTR(-ENOMEM);
 
 	state->acquire_ctx = ctx;
+	state->suspend_or_resume = suspending;
 
 	drm_for_each_crtc(crtc, dev) {
 		struct drm_crtc_state *crtc_state;
@@ -3263,7 +3273,7 @@ struct drm_atomic_state *drm_atomic_helper_suspend(struct drm_device *dev)
 
 	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, err);
 
-	state = drm_atomic_helper_duplicate_state(dev, &ctx);
+	state = drm_atomic_helper_duplicate_state(dev, &ctx, true);
 	if (IS_ERR(state))
 		goto unlock;
 
diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 8ba0e5b368da..371010f8d42e 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3032,6 +3032,10 @@ static int drm_dp_init_vcpi(struct drm_dp_mst_topology_mgr *mgr,
  * @port as needed. It is not OK however, to call this function and
  * drm_dp_atomic_release_vcpi_slots() in the same atomic check phase.
  *
+ * When &drm_atomic_state.suspend_or_resume is set to %true%, this function
+ * will not perform any error checking and will instead simply retrieve the
+ * previously recorded VCPI allocation that was present before system suspend.
+ *
  * See also:
  * drm_dp_atomic_release_vcpi_slots()
  * drm_dp_mst_atomic_check()
@@ -3052,9 +3056,11 @@ int drm_dp_atomic_find_vcpi_slots(struct drm_atomic_state *state,
 	if (IS_ERR(topology_state))
 		return PTR_ERR(topology_state);
 
-	port = drm_dp_mst_topology_get_port_validated(mgr, port);
-	if (port == NULL)
-		return -EINVAL;
+	if (!state->suspend_or_resume) {
+		port = drm_dp_mst_topology_get_port_validated(mgr, port);
+		if (!port)
+			return -EINVAL;
+	}
 
 	/* Find the current allocation for this port, if any */
 	list_for_each_entry(pos, &topology_state->vcpis, next) {
@@ -3062,6 +3068,19 @@ int drm_dp_atomic_find_vcpi_slots(struct drm_atomic_state *state,
 			vcpi = pos;
 			prev_slots = vcpi->vcpi;
 
+			/*
+			 * When resuming, we just want to restore the previous
+			 * VCPI without doing error checking
+			 */
+			if (state->suspend_or_resume) {
+				DRM_DEBUG_ATOMIC("[CONNECTOR:%d:%s] [MST PORT:%p] restoring VCPI of %d\n",
+						 port->connector->base.id,
+						 port->connector->name,
+						 port, prev_slots);
+
+				return prev_slots;
+			}
+
 			/*
 			 * This should never happen, unless the driver tries
 			 * releasing and allocating the same VCPI allocation,
@@ -3124,6 +3143,11 @@ EXPORT_SYMBOL(drm_dp_atomic_find_vcpi_slots);
  * drm_dp_atomic_find_vcpi_slots() on the same @port in a single atomic check
  * phase.
  *
+ * When &drm_atomic_state.suspend_or_resume is set, this function will not
+ * modify the VCPI allocations in &drm_dp_mst_topology_state.vcpis, so that
+ * those VCPI allocations may be restored as-is during system resume. In this
+ * scenario, this function will always return 0.
+ *
  * See also:
  * drm_dp_atomic_find_vcpi_slots()
  * drm_dp_mst_atomic_check()
@@ -3140,6 +3164,12 @@ int drm_dp_atomic_release_vcpi_slots(struct drm_atomic_state *state,
 	struct drm_dp_vcpi_allocation *pos;
 	bool found = false;
 
+	/* During suspend, just keep our VCPI allocations as-is in the atomic
+	 * state so they can be restored as-is at resume
+	 */
+	if (state->suspend_or_resume)
+		return 0;
+
 	topology_state = drm_atomic_get_mst_topology_state(state, mgr);
 	if (IS_ERR(topology_state))
 		return PTR_ERR(topology_state);
diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
index 4a282532af81..4c70f1531119 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -3824,7 +3824,7 @@ void intel_prepare_reset(struct drm_i915_private *dev_priv)
 	 * Disabling the crtcs gracefully seems nicer. Also the
 	 * g33 docs say we should at least disable all the planes.
 	 */
-	state = drm_atomic_helper_duplicate_state(dev, ctx);
+	state = drm_atomic_helper_duplicate_state(dev, ctx, false);
 	if (IS_ERR(state)) {
 		ret = PTR_ERR(state);
 		DRM_ERROR("Duplicating state failed with %i\n", ret);
@@ -15043,7 +15043,7 @@ static void sanitize_watermarks(struct drm_device *dev)
 		goto fail;
 	}
 
-	state = drm_atomic_helper_duplicate_state(dev, &ctx);
+	state = drm_atomic_helper_duplicate_state(dev, &ctx, false);
 	if (WARN_ON(IS_ERR(state)))
 		goto fail;
 
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 811b4a92568f..0897f51dcd62 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -329,6 +329,17 @@ struct drm_atomic_state {
 	bool allow_modeset : 1;
 	bool legacy_cursor_update : 1;
 	bool async_update : 1;
+	/**
+	 * @suspend_or_resume:
+	 *
+	 * Indicates whether or not this atomic state is being saved or
+	 * committed as part of suspending or resuming the system
+	 * respectively. Drivers and atomic helpers hould use this to fixup
+	 * normal state inconsistencies that might arise between system
+	 * suspend and resume, so as to ensure that restoring the atomic state
+	 * at resume never fails.
+	 */
+	bool suspend_or_resume : 1;
 	struct __drm_planes_state *planes;
 	struct __drm_crtcs_state *crtcs;
 	int num_connector;
diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic_helper.h
index 58214be3bf3d..359f557b6898 100644
--- a/include/drm/drm_atomic_helper.h
+++ b/include/drm/drm_atomic_helper.h
@@ -129,7 +129,8 @@ int drm_atomic_helper_disable_all(struct drm_device *dev,
 void drm_atomic_helper_shutdown(struct drm_device *dev);
 struct drm_atomic_state *
 drm_atomic_helper_duplicate_state(struct drm_device *dev,
-				  struct drm_modeset_acquire_ctx *ctx);
+				  struct drm_modeset_acquire_ctx *ctx,
+				  bool suspending);
 struct drm_atomic_state *drm_atomic_helper_suspend(struct drm_device *dev);
 int drm_atomic_helper_commit_duplicated_state(struct drm_atomic_state *state,
 					      struct drm_modeset_acquire_ctx *ctx);
-- 
2.20.1

