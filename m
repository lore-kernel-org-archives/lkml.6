Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17FDC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3EB120848
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0FbKFOoX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3EB120848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbeKCDtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:49:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728578AbeKCDtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:49:06 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63ED520843;
        Fri,  2 Nov 2018 18:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184055;
        bh=HucU8TTkCTFp1Nj5PYY4PWHiW1L6nQRUxkBQ2g6uEbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0FbKFOoX3InOhO27LpUoIEYc7bs90d85gMTelX7Dbo/fQRzvZUFpuOnFLq7uQ/Ohc
         ajt7RdEqH8dK6CjiZfnBUVi0i31aEbwDX5KVjMxmSCCe8tLhew5WQO8PyZyVhYHEMQ
         UKbgKjp/1TNPhYhlmHr6ixRclNEb/0vKXN12RlC8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shirish S <shirish.s@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 065/150] drm/amd/display: Signal hw_done() after waiting for flip_done()
Date:   Fri,  2 Nov 2018 19:33:47 +0100
Message-Id: <20181102182908.159266171@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



