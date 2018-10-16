Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8D2C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990AE20869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vi3S7QeY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990AE20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbeJPMCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:02:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbeJPMCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:02:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8EA321480;
        Tue, 16 Oct 2018 04:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663220;
        bh=EgCur0T0J64rPQbrh2bomyCzMR+FQDkd7VEIWEwCvts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vi3S7QeYdmbvCVwOTboz45M2R4hZjk9qyEvVHd9TS7qmc44ISpOPG2CZxLVPSuCNU
         /q7eGMvAmrpLB/u/2cye11iQVhr74tomlXRrtuqZLXGxG69cjAXGQIWFhufAwqOryq
         uXyyHTs3fYU8y5u+YnCPwiswTYj9gZoN0VMefQmU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shirish S <shirish.s@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 082/100] drm/amd/display: Signal hw_done() after waiting for flip_done()
Date:   Tue, 16 Oct 2018 00:12:03 -0400
Message-Id: <20181016041221.135528-82-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shirish S <shirish.s@amd.com>

[ Upstream commit 987bf116445db5d63a5c2ed94c4479687d9c9973 ]

In amdgpu_dm_commit_tail(), wait until flip_done() is signaled before
we signal hw_done().

[Why]

This is to temporarily address a paging error that occurs when a
nonblocking commit contends with another commit, particularly in a
mirrored display configuration where at least 2 CRTCs are updated.
The error occurs in drm_atomic_helper_wait_for_flip_done(), when we
attempt to access the contents of new_crtc_state->commit.

Here's the sequence for a mirrored 2 display setup (irrelevant steps
left out for clarity):

**THREAD 1**                        | **THREAD 2**
                                    |
Initialize atomic state for flip    |
                                    |
Queue worker                        |
                                   ...

                                    | Do work for flip
                                    |
                                    | Signal hw_done() on CRTC 1
                                    | Signal hw_done() on CRTC 2
                                    |
                                    | Wait for flip_done() on CRTC 1

                                <---- **PREEMPTED BY THREAD 1**

Initialize atomic state for cursor  |
update (1)                          |
                                    |
Do cursor update work on both CRTCs |
                                    |
Clear atomic state (2)              |
**DONE**                            |
                                   ...
                                    |
                                    | Wait for flip_done() on CRTC 2
                                    | *ERROR*
                                    |

The issue starts with (1). When the atomic state is initialized, the
current CRTC states are duplicated to be the new_crtc_states, and
referenced to be the old_crtc_states. (The new_crtc_states are to be
filled with update data.)

Some things to note:

* Due to the mirrored configuration, the cursor updates on both CRTCs.

* At this point, the pflip IRQ has already been handled, and flip_done
  signaled on all CRTCs. The cursor commit can therefore continue.

* The old_crtc_states used by the cursor update are the **same states**
  as the new_crtc_states used by the flip worker.

At (2), the old_crtc_state is freed (*), and the cursor commit
completes. We then context switch back to the flip worker, where we
attempt to access the new_crtc_state->commit object. This is
problematic, as this state has already been freed.

(*) Technically, 'state->crtcs[i].state' is freed, which was made to
    reference old_crtc_state in drm_atomic_helper_swap_state()

[How]

By moving hw_done() after wait_for_flip_done(), we're guaranteed that
the new_crtc_state (from the flip worker's perspective) still exists.
This is because any other commit will be blocked, waiting for the
hw_done() signal.

Note that both the i915 and imx drivers have this sequence flipped
already, masking this problem.

Signed-off-by: Shirish S <shirish.s@amd.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e484d0a94bdc..5b9cc3aeaa55 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4494,12 +4494,18 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 	}
 	spin_unlock_irqrestore(&adev->ddev->event_lock, flags);
 
-	/* Signal HW programming completion */
-	drm_atomic_helper_commit_hw_done(state);
 
 	if (wait_for_vblank)
 		drm_atomic_helper_wait_for_flip_done(dev, state);
 
+	/*
+	 * FIXME:
+	 * Delay hw_done() until flip_done() is signaled. This is to block
+	 * another commit from freeing the CRTC state while we're still
+	 * waiting on flip_done.
+	 */
+	drm_atomic_helper_commit_hw_done(state);
+
 	drm_atomic_helper_cleanup_planes(dev, state);
 
 	/* Finally, drop a runtime PM reference for each newly disabled CRTC,
-- 
2.17.1

