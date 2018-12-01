Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD73CC64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869ED20673
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 869ED20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbeLAMJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 07:09:17 -0500
Received: from anholt.net ([50.246.234.109]:42748 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbeLAMJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 07:09:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 2958710A156D;
        Fri, 30 Nov 2018 16:58:04 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id w7ud59fdKjYI; Fri, 30 Nov 2018 16:58:02 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 7DE2410A1521;
        Fri, 30 Nov 2018 16:58:00 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 73E4C2FE36F0; Fri, 30 Nov 2018 16:57:59 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Emett <david.emett@broadcom.com>,
        Thomas Spurden <thomas.spurden@broadcom.com>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 5/6] drm/v3d: Add more tracepoints for V3D GPU rendering.
Date:   Fri, 30 Nov 2018 16:57:58 -0800
Message-Id: <20181201005759.28093-5-eric@anholt.net>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181201005759.28093-1-eric@anholt.net>
References: <20181201005759.28093-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core scheduler tells us when the job is pushed to the scheduler's
queue, and I had the job_run functions saying when they actually queue
the job to the hardware.  By adding tracepoints for the very top of
the ioctls and the IRQs signaling job completion, "perf record -a -e
v3d:.\* -e gpu_scheduler:.\* <job>; perf script" gets you a pretty
decent timeline.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/v3d/v3d_gem.c   |   4 ++
 drivers/gpu/drm/v3d/v3d_irq.c   |  19 +++++-
 drivers/gpu/drm/v3d/v3d_trace.h | 101 ++++++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 0bd6892e3044..2f82e2724b1f 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -484,6 +484,8 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 	struct drm_syncobj *sync_out;
 	int ret = 0;
 
+	trace_v3d_submit_cl_ioctl(&v3d->drm, args->rcl_start, args->rcl_end);
+
 	if (args->pad != 0) {
 		DRM_INFO("pad must be zero: %d\n", args->pad);
 		return -EINVAL;
@@ -611,6 +613,8 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
 	int ret = 0;
 	int bo_count;
 
+	trace_v3d_submit_tfu_ioctl(&v3d->drm, args->iia);
+
 	job = kcalloc(1, sizeof(*job), GFP_KERNEL);
 	if (!job)
 		return -ENOMEM;
diff --git a/drivers/gpu/drm/v3d/v3d_irq.c b/drivers/gpu/drm/v3d/v3d_irq.c
index dd7a7b0bd5a1..69338da70ddc 100644
--- a/drivers/gpu/drm/v3d/v3d_irq.c
+++ b/drivers/gpu/drm/v3d/v3d_irq.c
@@ -15,6 +15,7 @@
 
 #include "v3d_drv.h"
 #include "v3d_regs.h"
+#include "v3d_trace.h"
 
 #define V3D_CORE_IRQS ((u32)(V3D_INT_OUTOMEM |	\
 			     V3D_INT_FLDONE |	\
@@ -88,12 +89,20 @@ v3d_irq(int irq, void *arg)
 	}
 
 	if (intsts & V3D_INT_FLDONE) {
-		dma_fence_signal(v3d->bin_job->bin.done_fence);
+		struct v3d_fence *fence =
+			to_v3d_fence(v3d->bin_job->bin.done_fence);
+
+		trace_v3d_bcl_irq(&v3d->drm, fence->seqno);
+		dma_fence_signal(&fence->base);
 		status = IRQ_HANDLED;
 	}
 
 	if (intsts & V3D_INT_FRDONE) {
-		dma_fence_signal(v3d->render_job->render.done_fence);
+		struct v3d_fence *fence =
+			to_v3d_fence(v3d->render_job->render.done_fence);
+
+		trace_v3d_rcl_irq(&v3d->drm, fence->seqno);
+		dma_fence_signal(&fence->base);
 		status = IRQ_HANDLED;
 	}
 
@@ -119,7 +128,11 @@ v3d_hub_irq(int irq, void *arg)
 	V3D_WRITE(V3D_HUB_INT_CLR, intsts);
 
 	if (intsts & V3D_HUB_INT_TFUC) {
-		dma_fence_signal(v3d->tfu_job->done_fence);
+		struct v3d_fence *fence =
+			to_v3d_fence(v3d->tfu_job->done_fence);
+
+		trace_v3d_tfu_irq(&v3d->drm, fence->seqno);
+		dma_fence_signal(&fence->base);
 		status = IRQ_HANDLED;
 	}
 
diff --git a/drivers/gpu/drm/v3d/v3d_trace.h b/drivers/gpu/drm/v3d/v3d_trace.h
index f54ed9cd3444..edd984afa33f 100644
--- a/drivers/gpu/drm/v3d/v3d_trace.h
+++ b/drivers/gpu/drm/v3d/v3d_trace.h
@@ -12,6 +12,28 @@
 #define TRACE_SYSTEM v3d
 #define TRACE_INCLUDE_FILE v3d_trace
 
+TRACE_EVENT(v3d_submit_cl_ioctl,
+	    TP_PROTO(struct drm_device *dev, u32 ct1qba, u32 ct1qea),
+	    TP_ARGS(dev, ct1qba, ct1qea),
+
+	    TP_STRUCT__entry(
+			     __field(u32, dev)
+			     __field(u32, ct1qba)
+			     __field(u32, ct1qea)
+			     ),
+
+	    TP_fast_assign(
+			   __entry->dev = dev->primary->index;
+			   __entry->ct1qba = ct1qba;
+			   __entry->ct1qea = ct1qea;
+			   ),
+
+	    TP_printk("dev=%u, RCL 0x%08x..0x%08x",
+		      __entry->dev,
+		      __entry->ct1qba,
+		      __entry->ct1qea)
+);
+
 TRACE_EVENT(v3d_submit_cl,
 	    TP_PROTO(struct drm_device *dev, bool is_render,
 		     uint64_t seqno,
@@ -42,6 +64,85 @@ TRACE_EVENT(v3d_submit_cl,
 		      __entry->ctnqea)
 );
 
+TRACE_EVENT(v3d_bcl_irq,
+	    TP_PROTO(struct drm_device *dev,
+		     uint64_t seqno),
+	    TP_ARGS(dev, seqno),
+
+	    TP_STRUCT__entry(
+			     __field(u32, dev)
+			     __field(u64, seqno)
+			     ),
+
+	    TP_fast_assign(
+			   __entry->dev = dev->primary->index;
+			   __entry->seqno = seqno;
+			   ),
+
+	    TP_printk("dev=%u, seqno=%llu",
+		      __entry->dev,
+		      __entry->seqno)
+);
+
+TRACE_EVENT(v3d_rcl_irq,
+	    TP_PROTO(struct drm_device *dev,
+		     uint64_t seqno),
+	    TP_ARGS(dev, seqno),
+
+	    TP_STRUCT__entry(
+			     __field(u32, dev)
+			     __field(u64, seqno)
+			     ),
+
+	    TP_fast_assign(
+			   __entry->dev = dev->primary->index;
+			   __entry->seqno = seqno;
+			   ),
+
+	    TP_printk("dev=%u, seqno=%llu",
+		      __entry->dev,
+		      __entry->seqno)
+);
+
+TRACE_EVENT(v3d_tfu_irq,
+	    TP_PROTO(struct drm_device *dev,
+		     uint64_t seqno),
+	    TP_ARGS(dev, seqno),
+
+	    TP_STRUCT__entry(
+			     __field(u32, dev)
+			     __field(u64, seqno)
+			     ),
+
+	    TP_fast_assign(
+			   __entry->dev = dev->primary->index;
+			   __entry->seqno = seqno;
+			   ),
+
+	    TP_printk("dev=%u, seqno=%llu",
+		      __entry->dev,
+		      __entry->seqno)
+);
+
+TRACE_EVENT(v3d_submit_tfu_ioctl,
+	    TP_PROTO(struct drm_device *dev, u32 iia),
+	    TP_ARGS(dev, iia),
+
+	    TP_STRUCT__entry(
+			     __field(u32, dev)
+			     __field(u32, iia)
+			     ),
+
+	    TP_fast_assign(
+			   __entry->dev = dev->primary->index;
+			   __entry->iia = iia;
+			   ),
+
+	    TP_printk("dev=%u, IIA 0x%08x",
+		      __entry->dev,
+		      __entry->iia)
+);
+
 TRACE_EVENT(v3d_submit_tfu,
 	    TP_PROTO(struct drm_device *dev,
 		     uint64_t seqno),
-- 
2.20.0.rc1

