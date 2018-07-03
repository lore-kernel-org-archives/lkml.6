Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDA5C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B3421C66
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B3421C66
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934282AbeGCRGM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:06:12 -0400
Received: from anholt.net ([50.246.234.109]:41060 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932559AbeGCRFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:05:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id BD85310A18B0;
        Tue,  3 Jul 2018 10:05:18 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id AtTd0EDNhnr9; Tue,  3 Jul 2018 10:05:16 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 7A9F210A17E3;
        Tue,  3 Jul 2018 10:05:16 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 6AEA62FE2D94; Tue,  3 Jul 2018 10:05:15 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH 1/4] drm/v3d: Delay the scheduler timeout if we're still making progress.
Date:   Tue,  3 Jul 2018 10:05:12 -0700
Message-Id: <20180703170515.6298-1-eric@anholt.net>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GTF-GLES2.gtf.GL.acos.acos_float_vert_xvary submits jobs that take 4
seconds at maximum resolution, but we still want to reset quickly if a
job is really hung.  Sample the CL's current address and the return
address (since we call into tile lists repeatedly) and if either has
changed then assume we've made progress.

Signed-off-by: Eric Anholt <eric@anholt.net>
Cc: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/gpu/drm/v3d/v3d_drv.h   |  2 ++
 drivers/gpu/drm/v3d/v3d_regs.h  |  1 +
 drivers/gpu/drm/v3d/v3d_sched.c | 18 ++++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index f546e0ab9562..a5d96d823416 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -189,6 +189,8 @@ struct v3d_job {
 
 	/* GPU virtual addresses of the start/end of the CL job. */
 	u32 start, end;
+
+	u32 timedout_ctca, timedout_ctra;
 };
 
 struct v3d_exec_info {
diff --git a/drivers/gpu/drm/v3d/v3d_regs.h b/drivers/gpu/drm/v3d/v3d_regs.h
index fc13282dfc2f..854046565989 100644
--- a/drivers/gpu/drm/v3d/v3d_regs.h
+++ b/drivers/gpu/drm/v3d/v3d_regs.h
@@ -222,6 +222,7 @@
 #define V3D_CLE_CTNCA(n) (V3D_CLE_CT0CA + 4 * n)
 #define V3D_CLE_CT0RA                                  0x00118
 #define V3D_CLE_CT1RA                                  0x0011c
+#define V3D_CLE_CTNRA(n) (V3D_CLE_CT0RA + 4 * n)
 #define V3D_CLE_CT0LC                                  0x00120
 #define V3D_CLE_CT1LC                                  0x00124
 #define V3D_CLE_CT0PC                                  0x00128
diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 808bc901f567..00667c733dca 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -153,7 +153,25 @@ v3d_job_timedout(struct drm_sched_job *sched_job)
 	struct v3d_job *job = to_v3d_job(sched_job);
 	struct v3d_exec_info *exec = job->exec;
 	struct v3d_dev *v3d = exec->v3d;
+	enum v3d_queue job_q = job == &exec->bin ? V3D_BIN : V3D_RENDER;
 	enum v3d_queue q;
+	u32 ctca = V3D_CORE_READ(0, V3D_CLE_CTNCA(job_q));
+	u32 ctra = V3D_CORE_READ(0, V3D_CLE_CTNRA(job_q));
+
+	/* If the current address or return address have changed, then
+	 * the GPU has probably made progress and we should delay the
+	 * reset.  This could fail if the GPU got in an infinite loop
+	 * in the CL, but that is pretty unlikely outside of an i-g-t
+	 * testcase.
+	 */
+	if (job->timedout_ctca != ctca || job->timedout_ctra != ctra) {
+		job->timedout_ctca = ctca;
+		job->timedout_ctra = ctra;
+
+		schedule_delayed_work(&job->base.work_tdr,
+				      job->base.sched->timeout);
+		return;
+	}
 
 	mutex_lock(&v3d->reset_lock);
 
-- 
2.18.0

