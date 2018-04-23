Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754116AbeDWFhl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 01:37:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60456 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752968AbeDWFf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 01:35:28 -0400
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        tiwei.bie@intel.com, jfreimann@redhat.com, wexu@redhat.com
Subject: [RFC V3 PATCH 4/8] vhost_net: do not explicitly manipulate vhost_used_elem
Date: Mon, 23 Apr 2018 13:34:56 +0800
Message-Id: <1524461700-5469-5-git-send-email-jasowang@redhat.com>
In-Reply-To: <1524461700-5469-1-git-send-email-jasowang@redhat.com>
References: <1524461700-5469-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two helpers of setting/getting used len were introduced to avoid
explicitly manipulating vhost_used_elem in zerocopy code. This will be
used to hide used_elem internals and simplify packed ring
implementation.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c   | 11 +++++------
 drivers/vhost/vhost.c | 12 ++++++++++--
 drivers/vhost/vhost.h |  5 +++++
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 3826f1f..30273ad 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -341,9 +341,10 @@ static void vhost_zerocopy_signal_used(struct vhost_net *net,
 	int j = 0;
 
 	for (i = nvq->done_idx; i != nvq->upend_idx; i = (i + 1) % UIO_MAXIOV) {
-		if (vq->heads[i].elem.len == VHOST_DMA_FAILED_LEN)
+		if (vhost_get_used_len(vq, &vq->heads[i]) ==
+		    VHOST_DMA_FAILED_LEN)
 			vhost_net_tx_err(net);
-		if (VHOST_DMA_IS_DONE(vq->heads[i].elem.len)) {
+		if (VHOST_DMA_IS_DONE(vhost_get_used_len(vq, &vq->heads[i]))) {
 			vq->heads[i].elem.len = VHOST_DMA_CLEAR_LEN;
 			++j;
 		} else
@@ -542,10 +543,8 @@ static void handle_tx(struct vhost_net *net)
 			struct ubuf_info *ubuf;
 			ubuf = nvq->ubuf_info + nvq->upend_idx;
 
-			vq->heads[nvq->upend_idx].elem.id =
-				cpu_to_vhost32(vq, used.elem.id);
-			vq->heads[nvq->upend_idx].elem.len =
-				VHOST_DMA_IN_PROGRESS;
+			vhost_set_used_len(vq, &used, VHOST_DMA_IN_PROGRESS);
+			vq->heads[nvq->upend_idx] = used;
 			ubuf->callback = vhost_zerocopy_callback;
 			ubuf->ctx = nvq->ubufs;
 			ubuf->desc = nvq->upend_idx;
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 24f3013..5cc1cdb 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2099,11 +2099,19 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 }
 EXPORT_SYMBOL_GPL(vhost_get_vq_desc);
 
-static void vhost_set_used_len(struct vhost_virtqueue *vq,
-			       struct vhost_used_elem *used, int len)
+void vhost_set_used_len(struct vhost_virtqueue *vq,
+			struct vhost_used_elem *used, int len)
 {
 	used->elem.len = cpu_to_vhost32(vq, len);
 }
+EXPORT_SYMBOL_GPL(vhost_set_used_len);
+
+int vhost_get_used_len(struct vhost_virtqueue *vq,
+		       struct vhost_used_elem *used)
+{
+	return vhost32_to_cpu(vq, used->elem.len);
+}
+EXPORT_SYMBOL_GPL(vhost_get_used_len);
 
 /* This is a multi-buffer version of vhost_get_desc, that works if
  *	vq has read descriptors only.
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 8dea44b..604821b 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -198,6 +198,11 @@ int vhost_get_bufs(struct vhost_virtqueue *vq,
 		   unsigned *log_num,
 		   unsigned int quota,
 		   s16 *count);
+void vhost_set_used_len(struct vhost_virtqueue *vq,
+			struct vhost_used_elem *used,
+			int len);
+int vhost_get_used_len(struct vhost_virtqueue *vq,
+		       struct vhost_used_elem *used);
 void vhost_discard_vq_desc(struct vhost_virtqueue *, int n);
 
 int vhost_vq_init_access(struct vhost_virtqueue *);
-- 
2.7.4
