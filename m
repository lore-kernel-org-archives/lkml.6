Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966625AbeBNCr3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 21:47:29 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56340 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966497AbeBNCr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 21:47:27 -0500
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: wexu@redhat.com, jfreimann@redhat.com, tiwei.bie@intel.com,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH RFC 2/2] vhost: packed ring support
Date: Wed, 14 Feb 2018 10:37:09 +0800
Message-Id: <1518575829-1431-3-git-send-email-jasowang@redhat.com>
In-Reply-To: <1518575829-1431-1-git-send-email-jasowang@redhat.com>
References: <1518575829-1431-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c   |  14 +-
 drivers/vhost/vhost.c | 351 ++++++++++++++++++++++++++++++++++++++++++++++----
 drivers/vhost/vhost.h |   6 +-
 3 files changed, 343 insertions(+), 28 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index c613d2e..65b27c9 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -67,7 +67,8 @@ enum {
 	VHOST_NET_FEATURES = VHOST_FEATURES |
 			 (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
 			 (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
-			 (1ULL << VIRTIO_F_IOMMU_PLATFORM)
+			 (1ULL << VIRTIO_F_IOMMU_PLATFORM) |
+			 (1ULL << VIRTIO_F_RING_PACKED)
 };
 
 enum {
@@ -473,6 +474,7 @@ static void handle_tx(struct vhost_net *net)
 	struct socket *sock;
 	struct vhost_net_ubuf_ref *uninitialized_var(ubufs);
 	bool zcopy, zcopy_used;
+	struct vring_used_elem used;
 
 	mutex_lock(&vq->mutex);
 	sock = vq->private_data;
@@ -494,6 +496,8 @@ static void handle_tx(struct vhost_net *net)
 			vhost_zerocopy_signal_used(net, vq);
 
 
+		used.idx = vq->last_avail_idx & (vq->num - 1);
+		used.wrap_counter = vq->used_wrap_counter;
 		head = vhost_net_tx_get_vq_desc(net, vq, vq->iov,
 						ARRAY_SIZE(vq->iov),
 						&out, &in);
@@ -515,6 +519,8 @@ static void handle_tx(struct vhost_net *net)
 		}
 		/* Skip header. TODO: support TSO. */
 		len = iov_length(vq->iov, out);
+		used.id = head;
+		used.len = 0;
 		iov_iter_init(&msg.msg_iter, WRITE, vq->iov, out, len);
 		iov_iter_advance(&msg.msg_iter, hdr_size);
 		/* Sanity check */
@@ -576,7 +582,7 @@ static void handle_tx(struct vhost_net *net)
 			pr_debug("Truncated TX packet: "
 				 " len %d != %zd\n", err, len);
 		if (!zcopy_used)
-			vhost_add_used_and_signal(&net->dev, vq, head, 0);
+			vhost_add_used_and_signal_n(&net->dev, vq, &used, 1);
 		else
 			vhost_zerocopy_signal_used(net, vq);
 		vhost_net_tx_packet(net);
@@ -691,6 +697,8 @@ static int get_rx_bufs(struct vhost_virtqueue *vq,
 			r = -ENOBUFS;
 			goto err;
 		}
+		heads[headcount].idx = vq->last_avail_idx & (vq->num - 1);
+		heads[headcount].wrap_counter = vq->used_wrap_counter;
 		r = vhost_get_vq_desc(vq, vq->iov + seg,
 				      ARRAY_SIZE(vq->iov) - seg, &out,
 				      &in, log, log_num);
@@ -780,6 +788,8 @@ static void handle_rx(struct vhost_net *net)
 	vq_log = unlikely(vhost_has_feature(vq, VHOST_F_LOG_ALL)) ?
 		vq->log : NULL;
 	mergeable = vhost_has_feature(vq, VIRTIO_NET_F_MRG_RXBUF);
+	/* FIXME: workaround for current dpdk prototype */
+	mergeable = false;
 
 	while ((sock_len = vhost_net_rx_peek_head_len(net, sock->sk))) {
 		sock_len += sock_hlen;
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 2db5af8..5667d03 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -324,6 +324,7 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 	vhost_reset_is_le(vq);
 	vhost_disable_cross_endian(vq);
 	vq->busyloop_timeout = 0;
+	vq->used_wrap_counter = true;
 	vq->umem = NULL;
 	vq->iotlb = NULL;
 	__vhost_vq_meta_reset(vq);
@@ -1136,10 +1137,22 @@ static int vhost_iotlb_miss(struct vhost_virtqueue *vq, u64 iova, int access)
 	return 0;
 }
 
-static int vq_access_ok(struct vhost_virtqueue *vq, unsigned int num,
-			struct vring_desc __user *desc,
-			struct vring_avail __user *avail,
-			struct vring_used __user *used)
+static int vq_access_ok_packed(struct vhost_virtqueue *vq, unsigned int num,
+			       struct vring_desc __user *desc,
+			       struct vring_avail __user *avail,
+			       struct vring_used __user *used)
+{
+	struct vring_desc_packed *packed = (struct vring_desc_packed *)desc;
+
+	/* FIXME: check device area and driver area */
+	return access_ok(VERIFY_READ, packed, num * sizeof(*packed)) &&
+	       access_ok(VERIFY_WRITE, packed, num * sizeof(*packed));
+}
+
+static int vq_access_ok_split(struct vhost_virtqueue *vq, unsigned int num,
+			      struct vring_desc __user *desc,
+			      struct vring_avail __user *avail,
+			      struct vring_used __user *used)
 
 {
 	size_t s = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
@@ -1151,6 +1164,17 @@ static int vq_access_ok(struct vhost_virtqueue *vq, unsigned int num,
 			sizeof *used + num * sizeof *used->ring + s);
 }
 
+static int vq_access_ok(struct vhost_virtqueue *vq, unsigned int num,
+			struct vring_desc __user *desc,
+			struct vring_avail __user *avail,
+			struct vring_used __user *used)
+{
+	if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
+		return vq_access_ok_packed(vq, num, desc, avail, used);
+	else
+		return vq_access_ok_split(vq, num, desc, avail, used);
+}
+
 static void vhost_vq_meta_update(struct vhost_virtqueue *vq,
 				 const struct vhost_umem_node *node,
 				 int type)
@@ -1763,6 +1787,9 @@ int vhost_vq_init_access(struct vhost_virtqueue *vq)
 
 	vhost_init_is_le(vq);
 
+	if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
+		return 0;
+
 	r = vhost_update_used_flags(vq);
 	if (r)
 		goto err;
@@ -1947,18 +1974,136 @@ static int get_indirect(struct vhost_virtqueue *vq,
 	return 0;
 }
 
-/* This looks in the virtqueue and for the first available buffer, and converts
- * it to an iovec for convenient access.  Since descriptors consist of some
- * number of output then some number of input descriptors, it's actually two
- * iovecs, but we pack them into one and note how many of each there were.
- *
- * This function returns the descriptor number found, or vq->num (which is
- * never a valid descriptor number) if none was found.  A negative code is
- * returned on error. */
-int vhost_get_vq_desc(struct vhost_virtqueue *vq,
-		      struct iovec iov[], unsigned int iov_size,
-		      unsigned int *out_num, unsigned int *in_num,
-		      struct vhost_log *log, unsigned int *log_num)
+#define DESC_AVAIL (1 << VRING_DESC_F_AVAIL)
+#define DESC_USED  (1 << VRING_DESC_F_USED)
+static bool desc_is_avail(struct vhost_virtqueue *vq,
+			  struct vring_desc_packed *desc)
+{
+	if (vq->used_wrap_counter)
+		if ((desc->flags & DESC_AVAIL) && !(desc->flags & DESC_USED))
+			return true;
+	if (vq->used_wrap_counter == false)
+		if (!(desc->flags & DESC_AVAIL) && (desc->flags & DESC_USED))
+			return true;
+
+	return false;
+}
+
+static void set_desc_used(struct vhost_virtqueue *vq,
+			  struct vring_desc_packed *desc, bool wrap_counter)
+{
+	__virtio16 flags = desc->flags;
+
+	if (wrap_counter) {
+		desc->flags |= cpu_to_vhost16(vq, DESC_AVAIL);
+		desc->flags |= cpu_to_vhost16(vq, DESC_USED);
+	} else {
+		desc->flags &= ~cpu_to_vhost16(vq, DESC_AVAIL);
+		desc->flags &= ~cpu_to_vhost16(vq, DESC_USED);
+	}
+
+	desc->flags = flags;
+}
+
+static int vhost_get_vq_desc_packed(struct vhost_virtqueue *vq,
+				    struct iovec iov[], unsigned int iov_size,
+				    unsigned int *out_num, unsigned int *in_num,
+				    struct vhost_log *log,
+				    unsigned int *log_num)
+{
+	struct vring_desc_packed desc;
+	int ret, access, i;
+	u16 avail_idx = vq->last_avail_idx;
+
+	/* When we start there are none of either input nor output. */
+	*out_num = *in_num = 0;
+	if (unlikely(log))
+		*log_num = 0;
+
+	do {
+		unsigned int iov_count = *in_num + *out_num;
+
+		i = vq->last_avail_idx & (vq->num - 1);
+		ret = vhost_copy_from_user(vq, &desc, vq->desc_packed + i,
+					   sizeof(desc));
+		if (unlikely(ret)) {
+			vq_err(vq, "Failed to get descriptor: idx %d addr %p\n",
+				i, vq->desc_packed + i);
+			return -EFAULT;
+		}
+
+		if (!desc_is_avail(vq, &desc)) {
+			/* If there's nothing new since last we looked, return
+			 * invalid.
+			 */
+			if (likely(avail_idx == vq->last_avail_idx))
+				return vq->num;
+		}
+
+		/* Only start to read descriptor after we're sure it was
+		 * available.
+		 */
+		smp_rmb();
+
+		/* FIXME: support indirect */
+		if (desc.flags & cpu_to_vhost16(vq, VRING_DESC_F_INDIRECT)) {
+			vq_err(vq, "Indirect descriptor is not supported\n");
+			return -EFAULT;
+		}
+
+		if (desc.flags & cpu_to_vhost16(vq, VRING_DESC_F_WRITE))
+			access = VHOST_ACCESS_WO;
+		else
+			access = VHOST_ACCESS_RO;
+		ret = translate_desc(vq, vhost64_to_cpu(vq, desc.addr),
+				     vhost32_to_cpu(vq, desc.len),
+				     iov + iov_count, iov_size - iov_count,
+				     access);
+		if (unlikely(ret < 0)) {
+			if (ret != -EAGAIN)
+				vq_err(vq, "Translation failure %d idx %d\n",
+					ret, i);
+			return ret;
+		}
+
+		if (access == VHOST_ACCESS_WO) {
+			/* If this is an input descriptor,
+			 * increment that count.
+			 */
+			*in_num += ret;
+			if (unlikely(log)) {
+				log[*log_num].addr =
+					vhost64_to_cpu(vq, desc.addr);
+				log[*log_num].len =
+					vhost32_to_cpu(vq, desc.len);
+				++*log_num;
+			}
+		} else {
+			/* If it's an output descriptor, they're all supposed
+			 * to come before any input descriptors.
+			 */
+			if (unlikely(*in_num)) {
+				vq_err(vq, "Desc out after in: idx %d\n",
+				       i);
+				return -EINVAL;
+			}
+			*out_num += ret;
+		}
+
+		/* On success, increment avail index. */
+		if ((++vq->last_avail_idx & (vq->num - 1)) == 0)
+			vq->used_wrap_counter ^= 1;
+
+	/* If this descriptor says it doesn't chain, we're done. */
+	} while (desc.flags & cpu_to_vhost16(vq, VRING_DESC_F_NEXT));
+
+	return desc.id;
+}
+
+static int vhost_get_vq_desc_split(struct vhost_virtqueue *vq,
+				   struct iovec iov[], unsigned int iov_size,
+				   unsigned int *out_num, unsigned int *in_num,
+				   struct vhost_log *log, unsigned int *log_num)
 {
 	struct vring_desc desc;
 	unsigned int i, head, found = 0;
@@ -2096,6 +2241,30 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 	BUG_ON(!(vq->used_flags & VRING_USED_F_NO_NOTIFY));
 	return head;
 }
+
+/* This looks in the virtqueue and for the first available buffer, and converts
+ * it to an iovec for convenient access.  Since descriptors consist of some
+ * number of output then some number of input descriptors, it's actually two
+ * iovecs, but we pack them into one and note how many of each there were.
+ *
+ * This function returns the descriptor number found, or vq->num (which is
+ * never a valid descriptor number) if none was found.  A negative code is
+ * returned on error.
+ */
+int vhost_get_vq_desc(struct vhost_virtqueue *vq,
+		      struct iovec iov[], unsigned int iov_size,
+		      unsigned int *out_num, unsigned int *in_num,
+		      struct vhost_log *log, unsigned int *log_num)
+{
+	if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
+		return vhost_get_vq_desc_packed(vq, iov, iov_size,
+						out_num, in_num,
+						log, log_num);
+	else
+		return vhost_get_vq_desc_split(vq, iov, iov_size,
+					       out_num, in_num,
+					       log, log_num);
+}
 EXPORT_SYMBOL_GPL(vhost_get_vq_desc);
 
 /* Reverse the effect of vhost_get_vq_desc. Useful for error handling. */
@@ -2161,10 +2330,48 @@ static int __vhost_add_used_n(struct vhost_virtqueue *vq,
 	return 0;
 }
 
-/* After we've used one of their buffers, we tell them about it.  We'll then
- * want to notify the guest, using eventfd. */
-int vhost_add_used_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
-		     unsigned count)
+static int vhost_add_used_n_packed(struct vhost_virtqueue *vq,
+				   struct vring_used_elem *heads,
+				   unsigned int count)
+{
+	struct vring_desc_packed desc = {
+		.addr = 0,
+		.flags = 0,
+	};
+	int i, ret;
+
+	for (i = 0; i < count; i++) {
+		desc.id = heads[i].id;
+		desc.len = heads[i].len;
+		set_desc_used(vq, &desc, heads[i].wrap_counter);
+
+		/* Update flags etc before desc is written */
+		smp_mb();
+
+		ret = vhost_copy_to_user(vq, vq->desc_packed + heads[i].idx,
+					 &desc, sizeof(desc));
+		if (unlikely(ret)) {
+			vq_err(vq, "Failed to set descriptor: idx %d addr %p\n",
+			       heads[i].idx, vq->desc_packed + heads[i].idx);
+			return -EFAULT;
+		}
+		if (unlikely(vq->log_used)) {
+			/* Make sure desc is written before update log. */
+			smp_wmb();
+			log_write(vq->log_base,
+				  vq->log_addr + heads[i].idx * sizeof(desc),
+				  sizeof(desc));
+			if (vq->log_ctx)
+				eventfd_signal(vq->log_ctx, 1);
+		}
+	}
+
+	return 0;
+}
+
+static int vhost_add_used_n_split(struct vhost_virtqueue *vq,
+				  struct vring_used_elem *heads,
+				  unsigned int count)
 {
 	int start, n, r;
 
@@ -2196,6 +2403,19 @@ int vhost_add_used_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
 	}
 	return r;
 }
+
+/* After we've used one of their buffers, we tell them about it.  We'll then
+ * want to notify the guest, using eventfd.
+ */
+int vhost_add_used_n(struct vhost_virtqueue *vq,
+		     struct vring_used_elem *heads,
+		     unsigned int count)
+{
+	if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
+		return vhost_add_used_n_packed(vq, heads, count);
+	else
+		return vhost_add_used_n_split(vq, heads, count);
+}
 EXPORT_SYMBOL_GPL(vhost_add_used_n);
 
 static bool vhost_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
@@ -2203,6 +2423,11 @@ static bool vhost_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 	__u16 old, new;
 	__virtio16 event;
 	bool v;
+
+	/* FIXME: check driver area */
+	if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
+		return false;
+
 	/* Flush out used index updates. This is paired
 	 * with the barrier that the Guest executes when enabling
 	 * interrupts. */
@@ -2265,7 +2490,8 @@ void vhost_add_used_and_signal_n(struct vhost_dev *dev,
 EXPORT_SYMBOL_GPL(vhost_add_used_and_signal_n);
 
 /* return true if we're sure that avaiable ring is empty */
-bool vhost_vq_avail_empty(struct vhost_dev *dev, struct vhost_virtqueue *vq)
+static bool vhost_vq_avail_empty_split(struct vhost_dev *dev,
+				       struct vhost_virtqueue *vq)
 {
 	__virtio16 avail_idx;
 	int r;
@@ -2280,10 +2506,61 @@ bool vhost_vq_avail_empty(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 
 	return vq->avail_idx == vq->last_avail_idx;
 }
+
+/* FIXME: unify codes with vhost_enable_notify_packed() */
+static bool vhost_vq_avail_empty_packed(struct vhost_dev *dev,
+					struct vhost_virtqueue *vq)
+{
+	struct vring_desc_packed desc;
+	int ret, i = vq->last_avail_idx & (vq->num - 1);
+
+	ret = vhost_copy_from_user(vq, &desc, vq->desc_packed + i,
+				   sizeof(desc));
+	if (unlikely(ret)) {
+		vq_err(vq, "Failed to get descriptor: idx %d addr %p\n",
+			i, vq->desc_packed + i);
+		return -EFAULT;
+	}
+
+	/* Read flag after desc is read */
+	smp_mb();
+
+	return desc_is_avail(vq, &desc);
+}
+
+bool vhost_vq_avail_empty(struct vhost_dev *dev, struct vhost_virtqueue *vq)
+{
+	if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
+		return vhost_vq_avail_empty_packed(dev, vq);
+	else
+		return vhost_vq_avail_empty_split(dev, vq);
+}
 EXPORT_SYMBOL_GPL(vhost_vq_avail_empty);
 
-/* OK, now we need to know about added descriptors. */
-bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
+static bool vhost_enable_notify_packed(struct vhost_dev *dev,
+				       struct vhost_virtqueue *vq)
+{
+	struct vring_desc_packed desc;
+	int ret, i = vq->last_avail_idx & (vq->num - 1);
+
+	/* FIXME: disable notification through device area */
+
+	ret = vhost_copy_from_user(vq, &desc, vq->desc_packed + i,
+				   sizeof(desc));
+	if (unlikely(ret)) {
+		vq_err(vq, "Failed to get descriptor: idx %d addr %p\n",
+			i, vq->desc_packed + i);
+		return -EFAULT;
+	}
+
+	/* Read flag after desc is read */
+	smp_mb();
+
+	return desc_is_avail(vq, &desc);
+}
+
+static bool vhost_enable_notify_split(struct vhost_dev *dev,
+				      struct vhost_virtqueue *vq)
 {
 	__virtio16 avail_idx;
 	int r;
@@ -2318,10 +2595,25 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 
 	return vhost16_to_cpu(vq, avail_idx) != vq->avail_idx;
 }
+
+/* OK, now we need to know about added descriptors. */
+bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
+{
+	if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
+		return vhost_enable_notify_packed(dev, vq);
+	else
+		return vhost_enable_notify_split(dev, vq);
+}
 EXPORT_SYMBOL_GPL(vhost_enable_notify);
 
-/* We don't need to be notified again. */
-void vhost_disable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
+static void vhost_disable_notify_packed(struct vhost_dev *dev,
+					struct vhost_virtqueue *vq)
+{
+	/* FIXME: disable notification through device area */
+}
+
+static void vhost_disable_notify_split(struct vhost_dev *dev,
+				       struct vhost_virtqueue *vq)
 {
 	int r;
 
@@ -2335,6 +2627,15 @@ void vhost_disable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 			       &vq->used->flags, r);
 	}
 }
+
+/* We don't need to be notified again. */
+void vhost_disable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
+{
+	if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
+		return vhost_disable_notify_packed(dev, vq);
+	else
+		return vhost_disable_notify_split(dev, vq);
+}
 EXPORT_SYMBOL_GPL(vhost_disable_notify);
 
 /* Create a new message. */
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index ac4b605..cf6533a 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -87,7 +87,10 @@ struct vhost_virtqueue {
 	/* The actual ring of buffers. */
 	struct mutex mutex;
 	unsigned int num;
-	struct vring_desc __user *desc;
+	union {
+		struct vring_desc __user *desc;
+		struct vring_desc_packed __user *desc_packed;
+	};
 	struct vring_avail __user *avail;
 	struct vring_used __user *used;
 	const struct vhost_umem_node *meta_iotlb[VHOST_NUM_ADDRS];
@@ -144,6 +147,7 @@ struct vhost_virtqueue {
 	bool user_be;
 #endif
 	u32 busyloop_timeout;
+	bool used_wrap_counter;
 };
 
 struct vhost_msg_node {
-- 
2.7.4
