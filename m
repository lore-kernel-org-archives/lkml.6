Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754019AbeDWFff (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 01:35:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50404 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751117AbeDWFfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 01:35:24 -0400
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        tiwei.bie@intel.com, jfreimann@redhat.com, wexu@redhat.com
Subject: [RFC V3 PATCH 3/8] vhost: do not use vring_used_elem
Date: Mon, 23 Apr 2018 13:34:55 +0800
Message-Id: <1524461700-5469-4-git-send-email-jasowang@redhat.com>
In-Reply-To: <1524461700-5469-1-git-send-email-jasowang@redhat.com>
References: <1524461700-5469-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of depending on the exported vring_used_elem, this patch
switches to use a new internal structure vhost_used_elem which embed
vring_used_elem in itself. This could be used to let vhost to record
extra metadata for the incoming packed ring layout.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c   | 19 ++++++++++---------
 drivers/vhost/scsi.c  | 10 +++++-----
 drivers/vhost/vhost.c | 33 ++++++++++++++++-----------------
 drivers/vhost/vhost.h | 18 +++++++++++-------
 drivers/vhost/vsock.c |  6 +++---
 5 files changed, 45 insertions(+), 41 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 826489c..3826f1f 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -341,10 +341,10 @@ static void vhost_zerocopy_signal_used(struct vhost_net *net,
 	int j = 0;
 
 	for (i = nvq->done_idx; i != nvq->upend_idx; i = (i + 1) % UIO_MAXIOV) {
-		if (vq->heads[i].len == VHOST_DMA_FAILED_LEN)
+		if (vq->heads[i].elem.len == VHOST_DMA_FAILED_LEN)
 			vhost_net_tx_err(net);
-		if (VHOST_DMA_IS_DONE(vq->heads[i].len)) {
-			vq->heads[i].len = VHOST_DMA_CLEAR_LEN;
+		if (VHOST_DMA_IS_DONE(vq->heads[i].elem.len)) {
+			vq->heads[i].elem.len = VHOST_DMA_CLEAR_LEN;
 			++j;
 		} else
 			break;
@@ -367,7 +367,7 @@ static void vhost_zerocopy_callback(struct ubuf_info *ubuf, bool success)
 	rcu_read_lock_bh();
 
 	/* set len to mark this desc buffers done DMA */
-	vq->heads[ubuf->desc].len = success ?
+	vq->heads[ubuf->desc].elem.len = success ?
 		VHOST_DMA_DONE_LEN : VHOST_DMA_FAILED_LEN;
 	cnt = vhost_net_ubuf_put(ubufs);
 
@@ -426,7 +426,7 @@ static int vhost_net_enable_vq(struct vhost_net *n,
 
 static int vhost_net_tx_get_vq_desc(struct vhost_net *net,
 				    struct vhost_virtqueue *vq,
-				    struct vring_used_elem *used_elem,
+				    struct vhost_used_elem *used_elem,
 				    struct iovec iov[], unsigned int iov_size,
 				    unsigned int *out_num, unsigned int *in_num)
 {
@@ -477,7 +477,7 @@ static void handle_tx(struct vhost_net *net)
 	size_t hdr_size;
 	struct socket *sock;
 	struct vhost_net_ubuf_ref *uninitialized_var(ubufs);
-	struct vring_used_elem used;
+	struct vhost_used_elem used;
 	bool zcopy, zcopy_used;
 	int sent_pkts = 0;
 
@@ -542,9 +542,10 @@ static void handle_tx(struct vhost_net *net)
 			struct ubuf_info *ubuf;
 			ubuf = nvq->ubuf_info + nvq->upend_idx;
 
-			vq->heads[nvq->upend_idx].id =
-				cpu_to_vhost32(vq, used.id);
-			vq->heads[nvq->upend_idx].len = VHOST_DMA_IN_PROGRESS;
+			vq->heads[nvq->upend_idx].elem.id =
+				cpu_to_vhost32(vq, used.elem.id);
+			vq->heads[nvq->upend_idx].elem.len =
+				VHOST_DMA_IN_PROGRESS;
 			ubuf->callback = vhost_zerocopy_callback;
 			ubuf->ctx = nvq->ubufs;
 			ubuf->desc = nvq->upend_idx;
diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 654c71f..ac11412 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -67,7 +67,7 @@ struct vhost_scsi_inflight {
 
 struct vhost_scsi_cmd {
 	/* Descriptor from vhost_get_vq_desc() for virt_queue segment */
-	struct vring_used_elem tvc_vq_used;
+	struct vhost_used_elem tvc_vq_used;
 	/* virtio-scsi initiator task attribute */
 	int tvc_task_attr;
 	/* virtio-scsi response incoming iovecs */
@@ -441,7 +441,7 @@ vhost_scsi_do_evt_work(struct vhost_scsi *vs, struct vhost_scsi_evt *evt)
 	struct vhost_virtqueue *vq = &vs->vqs[VHOST_SCSI_VQ_EVT].vq;
 	struct virtio_scsi_event *event = &evt->event;
 	struct virtio_scsi_event __user *eventp;
-	struct vring_used_elem used;
+	struct vhost_used_elem used;
 	unsigned out, in;
 	int ret;
 
@@ -785,7 +785,7 @@ static void vhost_scsi_submission_work(struct work_struct *work)
 static void
 vhost_scsi_send_bad_target(struct vhost_scsi *vs,
 			   struct vhost_virtqueue *vq,
-			   struct vring_used_elem *used, unsigned out)
+			   struct vhost_used_elem *used, unsigned out)
 {
 	struct virtio_scsi_cmd_resp __user *resp;
 	struct virtio_scsi_cmd_resp rsp;
@@ -808,7 +808,7 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 	struct virtio_scsi_cmd_req v_req;
 	struct virtio_scsi_cmd_req_pi v_req_pi;
 	struct vhost_scsi_cmd *cmd;
-	struct vring_used_elem used;
+	struct vhost_used_elem used;
 	struct iov_iter out_iter, in_iter, prot_iter, data_iter;
 	u64 tag;
 	u32 exp_data_len, data_direction;
@@ -837,7 +837,7 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 					ARRAY_SIZE(vq->iov), &out, &in,
 					NULL, NULL);
 		pr_debug("vhost_get_vq_desc: head: %d, out: %u in: %u\n",
-			 used.id, out, in);
+			 used.elem.id, out, in);
 		/* Nothing new?  Wait for eventfd to tell us they refilled. */
 		if (ret == -ENOSPC) {
 			if (unlikely(vhost_enable_notify(&vs->dev, vq))) {
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index e069adc..24f3013 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1955,7 +1955,7 @@ static int get_indirect(struct vhost_virtqueue *vq,
  * never a valid descriptor number) if none was found.  A negative code is
  * returned on error. */
 int vhost_get_vq_desc(struct vhost_virtqueue *vq,
-		      struct vring_used_elem *used,
+		      struct vhost_used_elem *used,
 		      struct iovec iov[], unsigned int iov_size,
 		      unsigned int *out_num, unsigned int *in_num,
 		      struct vhost_log *log, unsigned int *log_num)
@@ -2006,7 +2006,7 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 		return -EFAULT;
 	}
 
-	used->id = ring_head;
+	used->elem.id = ring_head;
 	head = vhost16_to_cpu(vq, ring_head);
 
 	/* If their number is silly, that's an error. */
@@ -2100,9 +2100,9 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 EXPORT_SYMBOL_GPL(vhost_get_vq_desc);
 
 static void vhost_set_used_len(struct vhost_virtqueue *vq,
-			       struct vring_used_elem *used, int len)
+			       struct vhost_used_elem *used, int len)
 {
-	used->len = cpu_to_vhost32(vq, len);
+	used->elem.len = cpu_to_vhost32(vq, len);
 }
 
 /* This is a multi-buffer version of vhost_get_desc, that works if
@@ -2116,7 +2116,7 @@ static void vhost_set_used_len(struct vhost_virtqueue *vq,
  *	returns number of buffer heads allocated, negative on error
  */
 int vhost_get_bufs(struct vhost_virtqueue *vq,
-		   struct vring_used_elem *heads,
+		   struct vhost_used_elem *heads,
 		   int datalen,
 		   unsigned *iovcount,
 		   struct vhost_log *log,
@@ -2189,7 +2189,7 @@ EXPORT_SYMBOL_GPL(vhost_discard_vq_desc);
 
 /* After we've used one of their buffers, we tell them about it.  We'll then
  * want to notify the guest, using eventfd. */
-int vhost_add_used(struct vhost_virtqueue *vq, struct vring_used_elem *used,
+int vhost_add_used(struct vhost_virtqueue *vq, struct vhost_used_elem *used,
 		   int len)
 {
 	vhost_set_used_len(vq, used, len);
@@ -2198,27 +2198,26 @@ int vhost_add_used(struct vhost_virtqueue *vq, struct vring_used_elem *used,
 EXPORT_SYMBOL_GPL(vhost_add_used);
 
 static int __vhost_add_used_n(struct vhost_virtqueue *vq,
-			    struct vring_used_elem *heads,
+			    struct vhost_used_elem *heads,
 			    unsigned count)
 {
 	struct vring_used_elem __user *used;
 	u16 old, new;
-	int start;
+	int start, i;
 
 	start = vq->last_used_idx & (vq->num - 1);
 	used = vq->used->ring + start;
-	if (count == 1) {
-		if (vhost_put_user(vq, heads[0].id, &used->id)) {
+	for (i = 0; i < count; i++) {
+		if (unlikely(vhost_put_user(vq, heads[i].elem.id,
+					    &used[i].id))) {
 			vq_err(vq, "Failed to write used id");
 			return -EFAULT;
 		}
-		if (vhost_put_user(vq, heads[0].len, &used->len)) {
+		if (unlikely(vhost_put_user(vq, heads[i].elem.len,
+					    &used[i].len))) {
 			vq_err(vq, "Failed to write used len");
 			return -EFAULT;
 		}
-	} else if (vhost_copy_to_user(vq, used, heads, count * sizeof *used)) {
-		vq_err(vq, "Failed to write used");
-		return -EFAULT;
 	}
 	if (unlikely(vq->log_used)) {
 		/* Make sure data is seen before log. */
@@ -2242,7 +2241,7 @@ static int __vhost_add_used_n(struct vhost_virtqueue *vq,
 
 /* After we've used one of their buffers, we tell them about it.  We'll then
  * want to notify the guest, using eventfd. */
-int vhost_add_used_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
+int vhost_add_used_n(struct vhost_virtqueue *vq, struct vhost_used_elem *heads,
 		     unsigned count)
 {
 	int start, n, r;
@@ -2326,7 +2325,7 @@ EXPORT_SYMBOL_GPL(vhost_signal);
 /* And here's the combo meal deal.  Supersize me! */
 void vhost_add_used_and_signal(struct vhost_dev *dev,
 			       struct vhost_virtqueue *vq,
-			       struct vring_used_elem *used, int len)
+			       struct vhost_used_elem *used, int len)
 {
 	vhost_add_used(vq, used, len);
 	vhost_signal(dev, vq);
@@ -2336,7 +2335,7 @@ EXPORT_SYMBOL_GPL(vhost_add_used_and_signal);
 /* multi-buffer version of vhost_add_used_and_signal */
 void vhost_add_used_and_signal_n(struct vhost_dev *dev,
 				 struct vhost_virtqueue *vq,
-				 struct vring_used_elem *heads, unsigned count)
+				 struct vhost_used_elem *heads, unsigned count)
 {
 	vhost_add_used_n(vq, heads, count);
 	vhost_signal(dev, vq);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index a7cc7e7..8dea44b 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -34,6 +34,10 @@ struct vhost_poll {
 	struct vhost_dev	 *dev;
 };
 
+struct vhost_used_elem {
+	struct vring_used_elem elem;
+};
+
 void vhost_work_init(struct vhost_work *work, vhost_work_fn_t fn);
 void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work);
 bool vhost_has_work(struct vhost_dev *dev);
@@ -126,7 +130,7 @@ struct vhost_virtqueue {
 	struct iovec iov[UIO_MAXIOV];
 	struct iovec iotlb_iov[64];
 	struct iovec *indirect;
-	struct vring_used_elem *heads;
+	struct vhost_used_elem *heads;
 	/* Protected by virtqueue mutex. */
 	struct vhost_umem *umem;
 	struct vhost_umem *iotlb;
@@ -182,12 +186,12 @@ bool vhost_vq_access_ok(struct vhost_virtqueue *vq);
 bool vhost_log_access_ok(struct vhost_dev *);
 
 int vhost_get_vq_desc(struct vhost_virtqueue *,
-		      struct vring_used_elem *used_elem,
+		      struct vhost_used_elem *used_elem,
 		      struct iovec iov[], unsigned int iov_count,
 		      unsigned int *out_num, unsigned int *in_num,
 		      struct vhost_log *log, unsigned int *log_num);
 int vhost_get_bufs(struct vhost_virtqueue *vq,
-		   struct vring_used_elem *heads,
+		   struct vhost_used_elem *heads,
 		   int datalen,
 		   unsigned *iovcount,
 		   struct vhost_log *log,
@@ -198,13 +202,13 @@ void vhost_discard_vq_desc(struct vhost_virtqueue *, int n);
 
 int vhost_vq_init_access(struct vhost_virtqueue *);
 int vhost_add_used(struct vhost_virtqueue *vq,
-		   struct vring_used_elem *elem, int len);
-int vhost_add_used_n(struct vhost_virtqueue *, struct vring_used_elem *heads,
+		   struct vhost_used_elem *elem, int len);
+int vhost_add_used_n(struct vhost_virtqueue *vq, struct vhost_used_elem *heads,
 		     unsigned count);
 void vhost_add_used_and_signal(struct vhost_dev *, struct vhost_virtqueue *,
-			       struct vring_used_elem *, int len);
+			       struct vhost_used_elem *, int len);
 void vhost_add_used_and_signal_n(struct vhost_dev *, struct vhost_virtqueue *,
-			       struct vring_used_elem *heads, unsigned count);
+			       struct vhost_used_elem *heads, unsigned count);
 void vhost_signal(struct vhost_dev *, struct vhost_virtqueue *);
 void vhost_disable_notify(struct vhost_dev *, struct vhost_virtqueue *);
 bool vhost_vq_avail_empty(struct vhost_dev *, struct vhost_virtqueue *);
diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 59a01cd..695694f 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -98,7 +98,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 
 	for (;;) {
 		struct virtio_vsock_pkt *pkt;
-		struct vring_used_elem used;
+		struct vhost_used_elem used;
 		struct iov_iter iov_iter;
 		unsigned out, in;
 		size_t nbytes;
@@ -146,7 +146,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 			break;
 		}
 
-		len = vhost32_to_cpu(vq, used.len);
+		len = vhost32_to_cpu(vq, used.elem.len);
 		iov_iter_init(&iov_iter, READ, &vq->iov[out], in, len);
 
 		nbytes = copy_to_iter(&pkt->hdr, sizeof(pkt->hdr), &iov_iter);
@@ -346,7 +346,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 	struct vhost_vsock *vsock = container_of(vq->dev, struct vhost_vsock,
 						 dev);
 	struct virtio_vsock_pkt *pkt;
-	struct vring_used_elem used;
+	struct vhost_used_elem used;
 	int ret;
 	unsigned int out, in;
 	bool added = false;
-- 
2.7.4
