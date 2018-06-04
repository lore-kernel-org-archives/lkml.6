Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751203AbeFDTfP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 15:35:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37022 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750868AbeFDTfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 15:35:14 -0400
From: Lyude Paul <lyude@redhat.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Harry Wentland <harry.wentland@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>, Shirish S <shirish.s@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Grab/put runtime PM references in atomic_commit_tail()
Date: Mon,  4 Jun 2018 15:35:03 -0400
Message-Id: <20180604193509.29153-1-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So, unfortunately I recently made the discovery that in the upstream
kernel, the only reason that amdgpu is not currently suffering from
issues with runtime PM putting the GPU into suspend while it's driving
displays is due to the fact that on most prime systems, we have sound
devices associated with the GPU that hold their own runtime PM ref for
the GPU.

What this means however, is that in the event that there isn't any kind
of sound device active (which can easily be reproduced by building a
kernel with sound drivers disabled), the GPU will fall asleep even when
there's displays active. This appears to be in part due to the fact that
amdgpu has not actually ever relied on it's rpm_idle() function to be
the only thing keeping it running, and normally grabs it's own power
references whenever there are displays active (as can be seen with the
original pre-DC codepath in amdgpu_display_crtc_set_config() in
amdgpu_display.c). This means it's very likely that this bug was
introduced during the switch over the DC.

So to fix this, we start grabbing runtime PM references every time we
enable a previously disabled CRTC in atomic_commit_tail(). This appears
to be the correct solution, as it matches up with what i915 does in
i915/intel_runtime_pm.c.

The one sideaffect of this is that we ignore the variable that the
pre-DC code used to use for tracking when it needed runtime PM refs,
adev->have_disp_power_ref. This is mainly because there's no way for a
driver to tell whether or not all of it's CRTCs are enabled or disabled
when we've begun committing an atomic state, as there may be CRTC
commits happening in parallel that aren't contained within the atomic
state being committed. So, it's safer to just get/put a reference for
each CRTC being enabled or disabled in the new atomic state.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
As a note, I'm not entirely happy with this fix and I wouldn't be
surprised if I missed something while looking through amdgpu. So, please
don't hesistate to suggest a better fix :).

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1dd1142246c2..361b81ef6997 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -46,6 +46,7 @@
 #include <linux/moduleparam.h>
 #include <linux/version.h>
 #include <linux/types.h>
+#include <linux/pm_runtime.h>
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic.h>
@@ -4211,6 +4212,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			if (dm_old_crtc_state->stream)
 				remove_stream(adev, acrtc, dm_old_crtc_state->stream);
 
+			pm_runtime_get_noresume(dev->dev);
+
 			acrtc->enabled = true;
 			acrtc->hw_mode = new_crtc_state->mode;
 			crtc->hwmode = new_crtc_state->mode;
@@ -4396,6 +4399,16 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		drm_atomic_helper_wait_for_flip_done(dev, state);
 
 	drm_atomic_helper_cleanup_planes(dev, state);
+
+	/* Finally, drop a runtime PM reference for each newly disabled CRTC,
+	 * so we can put the GPU into runtime suspend if we're not driving any
+	 * displays anymore
+	 */
+	pm_runtime_mark_last_busy(dev->dev);
+	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
+		if (old_crtc_state->active && !new_crtc_state->active)
+			pm_runtime_put_autosuspend(dev->dev);
+	}
 }
 
 
-- 
2.17.1
