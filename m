Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752263AbeEQNSa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 09:18:30 -0400
Received: from anholt.net ([50.246.234.109]:45454 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750779AbeEQNS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 09:18:29 -0400
From: Eric Anholt <eric@anholt.net>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>
Subject: [PATCH] drm/vc4: Introduce tracepoints for CL execution.
Date: Thu, 17 May 2018 14:18:24 +0100
Message-Id: <20180517131824.29619-1-eric@anholt.net>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This has been useful for debugging the window movement lag in X11, and
I have patches to sysprof that watch these to produce nice
visualizations.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/vc4/vc4_gem.c   |  4 +++
 drivers/gpu/drm/vc4/vc4_irq.c   |  4 +++
 drivers/gpu/drm/vc4/vc4_trace.h | 58 +++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index 7910b9acedd6..7e98eb93bcc0 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -479,6 +479,7 @@ vc4_submit_next_bin_job(struct drm_device *dev)
 	 */
 	if (exec->ct0ca != exec->ct0ea) {
 		submit_cl(dev, 0, exec->ct0ca, exec->ct0ea);
+		trace_vc4_submit_cl(dev, exec->seqno, false);
 	} else {
 		struct vc4_exec_info *next;
 
@@ -513,6 +514,7 @@ vc4_submit_next_render_job(struct drm_device *dev)
 	vc4_flush_texture_caches(dev);
 
 	submit_cl(dev, 1, exec->ct1ca, exec->ct1ea);
+	trace_vc4_submit_cl(dev, exec->seqno, true);
 }
 
 void
@@ -1124,6 +1126,8 @@ vc4_submit_cl_ioctl(struct drm_device *dev, void *data,
 	struct dma_fence *in_fence;
 	int ret = 0;
 
+	trace_vc4_submit_cl_begin(dev);
+
 	if ((args->flags & ~(VC4_SUBMIT_CL_USE_CLEAR_COLOR |
 			     VC4_SUBMIT_CL_FIXED_RCL_ORDER |
 			     VC4_SUBMIT_CL_RCL_ORDER_INCREASING_X |
diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
index 4cd2ccfe15f4..d331ad136ae8 100644
--- a/drivers/gpu/drm/vc4/vc4_irq.c
+++ b/drivers/gpu/drm/vc4/vc4_irq.c
@@ -47,6 +47,7 @@
 
 #include "vc4_drv.h"
 #include "vc4_regs.h"
+#include "vc4_trace.h"
 
 #define V3D_DRIVER_IRQS (V3D_INT_OUTOMEM | \
 			 V3D_INT_FLDONE | \
@@ -109,6 +110,7 @@ vc4_irq_finish_bin_job(struct drm_device *dev)
 	if (!exec)
 		return;
 
+	trace_vc4_finish_cl(dev, exec->seqno, false);
 	vc4_move_job_to_render(dev, exec);
 	next = vc4_first_bin_job(vc4);
 
@@ -147,6 +149,8 @@ vc4_irq_finish_render_job(struct drm_device *dev)
 	if (!exec)
 		return;
 
+	trace_vc4_finish_cl(dev, exec->seqno, true);
+
 	vc4->finished_seqno++;
 	list_move_tail(&exec->head, &vc4->job_done_list);
 
diff --git a/drivers/gpu/drm/vc4/vc4_trace.h b/drivers/gpu/drm/vc4/vc4_trace.h
index deafb32923e1..d5f2b91035a5 100644
--- a/drivers/gpu/drm/vc4/vc4_trace.h
+++ b/drivers/gpu/drm/vc4/vc4_trace.h
@@ -55,6 +55,64 @@ TRACE_EVENT(vc4_wait_for_seqno_end,
 		      __entry->dev, __entry->seqno)
 );
 
+TRACE_EVENT(vc4_submit_cl_begin,
+	    TP_PROTO(struct drm_device *dev),
+	    TP_ARGS(dev),
+
+	    TP_STRUCT__entry(
+			     __field(u32, dev)
+			     ),
+
+	    TP_fast_assign(
+			   __entry->dev = dev->primary->index;
+			   ),
+
+	    TP_printk("dev=%u",
+		      __entry->dev)
+);
+
+TRACE_EVENT(vc4_submit_cl,
+	    TP_PROTO(struct drm_device *dev, uint64_t seqno, int ring),
+	    TP_ARGS(dev, seqno, ring),
+
+	    TP_STRUCT__entry(
+			     __field(u32, dev)
+			     __field(u64, seqno)
+			     __field(bool, ring)
+			     ),
+
+	    TP_fast_assign(
+			   __entry->dev = dev->primary->index;
+			   __entry->seqno = seqno;
+			   __entry->ring = ring;
+			   ),
+
+	    TP_printk("dev=%u, seqno=%llu %s",
+		      __entry->dev, __entry->seqno,
+		      __entry->ring ? "RCL" : "BCL")
+);
+
+TRACE_EVENT(vc4_finish_cl,
+	    TP_PROTO(struct drm_device *dev, uint64_t seqno, int ring),
+	    TP_ARGS(dev, seqno, ring),
+
+	    TP_STRUCT__entry(
+			     __field(u32, dev)
+			     __field(u64, seqno)
+			     __field(bool, ring)
+			     ),
+
+	    TP_fast_assign(
+			   __entry->dev = dev->primary->index;
+			   __entry->seqno = seqno;
+			   __entry->ring = ring;
+			   ),
+
+	    TP_printk("dev=%u, seqno=%llu %s",
+		      __entry->dev, __entry->seqno,
+		      __entry->ring ? "RCL" : "BCL")
+);
+
 #endif /* _VC4_TRACE_H_ */
 
 /* This part must be outside protection */
-- 
2.17.0
