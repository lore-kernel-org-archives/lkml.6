Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CA4C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2833214DB
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OTRez8PA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JDtkz9f2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2833214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbeLFGrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 01:47:20 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49136 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbeLFGrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 01:47:20 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2A4AF60C65; Thu,  6 Dec 2018 06:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544078838;
        bh=GO7TKZdEH2RWA9o4HpJ11VVGNuLJzeBhjyry+gYpF7U=;
        h=From:To:Cc:Subject:Date:From;
        b=OTRez8PAa7QordOAvxWlaGoJgNX7AEVk9Hkb+x4KEBE87vjcf8aJxu/WmgKip72Kj
         hbYf8HCG/c3YBJSSbtwxOSfvNT/6nsOqeiKDHBX4PLmFSLnKf0fHVOTsgw1KLpm2mc
         czOG8auLsR/QzYw/ECV5yrO2WuJBJzYt4l3S3Ivo=
Received: from jshekhar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jshekhar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5898561374;
        Thu,  6 Dec 2018 06:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544078830;
        bh=GO7TKZdEH2RWA9o4HpJ11VVGNuLJzeBhjyry+gYpF7U=;
        h=From:To:Cc:Subject:Date:From;
        b=JDtkz9f2ZxmtACiuhlYk8DGdHXORsQ6mtbpDaQvWiqR1h4m9WUEQOuruKDQt9K051
         SxEmtLkdZAgkdRXeQp4OGwm7Hh1WoubR/ZqRzOXvAaPtpaBn8U/On6aYSlfNFFmOtb
         rw9RbllzO/o6WWXWCboImBWhM0T/DDrLIwqcwDqA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5898561374
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jshekhar@codeaurora.org
From:   Jayant Shekhar <jshekhar@codeaurora.org>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Jayant Shekhar <jshekhar@codeaurora.org>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org,
        abhinavk@codeaurora.org, jsanka@codeaurora.org,
        chandanu@codeaurora.org, nganji@codeaurora.org
Subject: [DPU PATCH] drm/msm/dpu: Fix vblank refcount mismatch
Date:   Thu,  6 Dec 2018 12:16:53 +0530
Message-Id: <1544078813-10945-1-git-send-email-jshekhar@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_dpu_crtc_vblank_enable_no_lock releases crtc_lock as
its needed for power handle operations. This opens up a
window where in a thread running dpu_crtc_disable and a thread
running dpu_crtc_vblank can race in using dpu_crtc->enabled.

dpu_crtc_disable will change the state, where as dpu_crtc_vblank
use the variable. The fix is to cache the crtc enabled state
while holding the lock and use it as a gate in calling
_dpu_crtc_vblank_enable_no_lock.

This issue was introduced with the commit cf871c48
(drm/msm/dpu: Remove suspend state tracking from crtc).

Below are stack traces of thread 1 and thread 2 in good case
and bad case:

Bad case:
-------------
Thread 1
dpu_encoder_phys_vid_control_vblank_irq+0xd0/0x170
dpu_encoder_register_vblank_callback+0xb8/0x100
_dpu_crtc_vblank_enable_no_lock+0x240/0x288
dpu_crtc_disable+0xc4/0x288
drm_atomic_helper_commit_modeset_disables+0x19c/0x350
msm_atomic_commit_tail+0x48/0x144
commit_tail+0x44/0x70
drm_atomic_helper_commit+0xf0/0xf8
drm_atomic_commit+0x40/0x4c
drm_mode_atomic_ioctl+0x374/0x90c
drm_ioctl_kernel+0xac/0xec
drm_ioctl+0x218/0x384
drm_compat_ioctl+0xd8/0xe8

Thread 2:
dpu_encoder_phys_vid_control_vblank_irq+0x74/0x170
dpu_encoder_register_vblank_callback+0xb8/0x100
_dpu_crtc_vblank_enable_no_lock+0x240/0x288
dpu_crtc_vblank+0xa8/0x118
dpu_kms_disable_vblank+0x20/0x2c
vblank_ctrl_worker+0xa0/0xe0
kthread_worker_fn+0xe4/0x1a4
kthread+0x11c/0x12c
ret_from_fork+0x10/0x18

Good case:
--------------
Thread 1:
dpu_encoder_phys_vid_control_vblank_irq+0xd0/0x170
dpu_encoder_phys_vid_irq_control+0xc8/0x110
_dpu_encoder_irq_control+0x48/0xa0
_dpu_encoder_resource_control_helper+0xb4/0x10c
dpu_encoder_resource_control+0x4e0/0x664
dpu_encoder_virt_enable+0xb8/0x120
dpu_kms_encoder_enable+0x34/0xcc
drm_atomic_helper_commit_modeset_enables+0x120/0x1b8
msm_atomic_commit_tail+0x5c/0x144
commit_tail+0x44/0x70
drm_atomic_helper_commit+0xf0/0xf8
drm_atomic_commit+0x40/0x4c
drm_mode_atomic_ioctl+0x374/0x90c

Thread 2:
dpu_crtc_vblank+0xc8/0x118
dpu_kms_disable_vblank+0x20/0x2c
vblank_ctrl_worker+0xa0/0xe0
kthread_worker_fn+0xe4/0x1a4
kthread+0x11c/0x12c

Signed-off-by: Jayant Shekhar <jshekhar@codeaurora.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 630cbaa..e81ad8c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -877,6 +877,7 @@ static void dpu_crtc_disable(struct drm_crtc *crtc)
 	struct drm_encoder *encoder;
 	struct msm_drm_private *priv;
 	unsigned long flags;
+	bool crtc_en;
 
 	if (!crtc || !crtc->dev || !crtc->dev->dev_private || !crtc->state) {
 		DPU_ERROR("invalid crtc\n");
@@ -901,11 +902,21 @@ static void dpu_crtc_disable(struct drm_crtc *crtc)
 				atomic_read(&dpu_crtc->frame_pending));
 
 	trace_dpu_crtc_disable(DRMID(crtc), false, dpu_crtc);
-	if (dpu_crtc->enabled && dpu_crtc->vblank_requested) {
-		_dpu_crtc_vblank_enable_no_lock(dpu_crtc, false);
-	}
+
+	/*
+	 * Cache vblank enabled before calling _dpu_crtc_vblank_enable_no_lock,
+	 * because we release crtc_lock inside and acquire it back. While lock
+	 * is released, there are cases where dpu_crtc_vblank comes in between
+	 * while disable is going on. dpu_crtc_vblank further calls
+	 * _dpu_crtc_vblank_enable_no_lock which tries vblank disable again
+	 * resulting in refcount mismatch.
+	 */
+	crtc_en = dpu_crtc->enabled;
 	dpu_crtc->enabled = false;
 
+	if (crtc_en && dpu_crtc->vblank_requested)
+		_dpu_crtc_vblank_enable_no_lock(dpu_crtc, false);
+
 	if (atomic_read(&dpu_crtc->frame_pending)) {
 		trace_dpu_crtc_disable_frame_pending(DRMID(crtc),
 				     atomic_read(&dpu_crtc->frame_pending));
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

