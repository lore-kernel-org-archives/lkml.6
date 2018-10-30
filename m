Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB3BC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3761120838
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZSFvJP/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3761120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbeJ3WVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:21:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbeJ3WVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:21:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00C4D20838;
        Tue, 30 Oct 2018 13:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906096;
        bh=RNSA6mgXzA94MasOgzmiCt2dRDRFi4PkgmErCdFHW4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oZSFvJP/U1MkfAdF3ExlHfB7yoQ2wEbEE4MA0PLRokznp4p5h21ueiT1blh7ldxtG
         hOhBqUFnukHJ+LZw+2a4YdhWGegyg9YQAa2uT39gEQAXCP73eZG9S8ss+Z4jO9H6YX
         ziw4NjUoEGE+Mh9Kkmvl2oamPHS/Fe1SFW+8BBe8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Li <sunpeng.li@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 29/33] drm: Get ref on CRTC commit object when waiting for flip_done
Date:   Tue, 30 Oct 2018 09:26:53 -0400
Message-Id: <20181030132657.217970-29-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030132657.217970-1-sashal@kernel.org>
References: <20181030132657.217970-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Li <sunpeng.li@amd.com>

[ Upstream commit 4364bcb2cd21d042bde4776448417ddffbc54045 ]

This fixes a general protection fault, caused by accessing the contents
of a flip_done completion object that has already been freed. It occurs
due to the preemption of a non-blocking commit worker thread W by
another commit thread X. X continues to clear its atomic state at the
end, destroying the CRTC commit object that W still needs. Switching
back to W and accessing the commit objects then leads to bad results.

Worker W becomes preemptable when waiting for flip_done to complete. At
this point, a frequently occurring commit thread X can take over. Here's
an example where W is a worker thread that flips on both CRTCs, and X
does a legacy cursor update on both CRTCs:

        ...
     1. W does flip work
     2. W runs commit_hw_done()
     3. W waits for flip_done on CRTC 1
     4. > flip_done for CRTC 1 completes
     5. W finishes waiting for CRTC 1
     6. W waits for flip_done on CRTC 2

     7. > Preempted by X
     8. > flip_done for CRTC 2 completes
     9. X atomic_check: hw_done and flip_done are complete on all CRTCs
    10. X updates cursor on both CRTCs
    11. X destroys atomic state
    12. X done

    13. > Switch back to W
    14. W waits for flip_done on CRTC 2
    15. W raises general protection fault

The error looks like so:

    general protection fault: 0000 [#1] PREEMPT SMP PTI
    **snip**
    Call Trace:
     lock_acquire+0xa2/0x1b0
     _raw_spin_lock_irq+0x39/0x70
     wait_for_completion_timeout+0x31/0x130
     drm_atomic_helper_wait_for_flip_done+0x64/0x90 [drm_kms_helper]
     amdgpu_dm_atomic_commit_tail+0xcae/0xdd0 [amdgpu]
     commit_tail+0x3d/0x70 [drm_kms_helper]
     process_one_work+0x212/0x650
     worker_thread+0x49/0x420
     kthread+0xfb/0x130
     ret_from_fork+0x3a/0x50
    Modules linked in: x86_pkg_temp_thermal amdgpu(O) chash(O)
    gpu_sched(O) drm_kms_helper(O) syscopyarea sysfillrect sysimgblt
    fb_sys_fops ttm(O) drm(O)

Note that i915 has this issue masked, since hw_done is signaled after
waiting for flip_done. Doing so will block the cursor update from
happening until hw_done is signaled, preventing the cursor commit from
destroying the state.

v2: The reference on the commit object needs to be obtained before
    hw_done() is signaled, since that's the point where another commit
    is allowed to modify the state. Assuming that the
    new_crtc_state->commit object still exists within flip_done() is
    incorrect.

    Fix by getting a reference in setup_commit(), and releasing it
    during default_clear().

Signed-off-by: Leo Li <sunpeng.li@amd.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1539611200-6184-1-git-send-email-sunpeng.li@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c        |  5 +++++
 drivers/gpu/drm/drm_atomic_helper.c | 12 ++++++++----
 include/drm/drm_atomic.h            | 11 +++++++++++
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 895741e9cd7d..52ccf1c31855 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -173,6 +173,11 @@ void drm_atomic_state_default_clear(struct drm_atomic_state *state)
 		state->crtcs[i].state = NULL;
 		state->crtcs[i].old_state = NULL;
 		state->crtcs[i].new_state = NULL;
+
+		if (state->crtcs[i].commit) {
+			drm_crtc_commit_put(state->crtcs[i].commit);
+			state->crtcs[i].commit = NULL;
+		}
 	}
 
 	for (i = 0; i < config->num_total_plane; i++) {
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 81e32199d3ef..abca95b970ea 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1384,15 +1384,16 @@ EXPORT_SYMBOL(drm_atomic_helper_wait_for_vblanks);
 void drm_atomic_helper_wait_for_flip_done(struct drm_device *dev,
 					  struct drm_atomic_state *old_state)
 {
-	struct drm_crtc_state *new_crtc_state;
 	struct drm_crtc *crtc;
 	int i;
 
-	for_each_new_crtc_in_state(old_state, crtc, new_crtc_state, i) {
-		struct drm_crtc_commit *commit = new_crtc_state->commit;
+	for (i = 0; i < dev->mode_config.num_crtc; i++) {
+		struct drm_crtc_commit *commit = old_state->crtcs[i].commit;
 		int ret;
 
-		if (!commit)
+		crtc = old_state->crtcs[i].ptr;
+
+		if (!crtc || !commit)
 			continue;
 
 		ret = wait_for_completion_timeout(&commit->flip_done, 10 * HZ);
@@ -1906,6 +1907,9 @@ int drm_atomic_helper_setup_commit(struct drm_atomic_state *state,
 		drm_crtc_commit_get(commit);
 
 		commit->abort_completion = true;
+
+		state->crtcs[i].commit = commit;
+		drm_crtc_commit_get(commit);
 	}
 
 	for_each_oldnew_connector_in_state(state, conn, old_conn_state, new_conn_state, i) {
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index a57a8aa90ffb..2b0d02458a18 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -153,6 +153,17 @@ struct __drm_planes_state {
 struct __drm_crtcs_state {
 	struct drm_crtc *ptr;
 	struct drm_crtc_state *state, *old_state, *new_state;
+
+	/**
+	 * @commit:
+	 *
+	 * A reference to the CRTC commit object that is kept for use by
+	 * drm_atomic_helper_wait_for_flip_done() after
+	 * drm_atomic_helper_commit_hw_done() is called. This ensures that a
+	 * concurrent commit won't free a commit object that is still in use.
+	 */
+	struct drm_crtc_commit *commit;
+
 	s32 __user *out_fence_ptr;
 	u64 last_vblank_count;
 };
-- 
2.17.1

