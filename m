Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752714AbeEPMdJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 08:33:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752610AbeEPMdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 08:33:07 -0400
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jfreimann@redhat.com, wexu@redhat.com, tiwei.bie@intel.com
Subject: [RFC V4 PATCH 7/8] vhost: packed ring support
Date: Wed, 16 May 2018 20:32:20 +0800
Message-Id: <1526473941-16199-8-git-send-email-jasowang@redhat.com>
In-Reply-To: <1526473941-16199-1-git-send-email-jasowang@redhat.com>
References: <1526473941-16199-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c   |   3 +-
 drivers/vhost/vhost.c | 539 ++++++++++++++++++++++++++++++++++++++++++++++----
 drivers/vhost/vhost.h |   8 +-
 3 files changed, 513 insertions(+), 37 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 30273ad..f55c82f8 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -71,7 +71,8 @@ enum {
 	VHOST_NET_FEATURES = VHOST_FEATURES |
 			 (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
 			 (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
-			 (1ULL << VIRTIO_F_IOMMU_PLATFORM)
+			 (1ULL << VIRTIO_F_IOMMU_PLATFORM) |
+			 (1ULL << VIRTIO_F_RING_PACKED)
 };
 
 enum {
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 8304c30..f2a0f5b 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -323,6 +323,8 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 	vhost_reset_is_le(vq);
 	vhost_disable_cross_endian(vq);
 	vq->busyloop_timeout = 0;
+	vq->used_wrap_counter = true;
+	vq->avail_wrap_counter = true;
 	vq->umem = NULL;
 	vq->iotlb = NULL;
 	__vhost_vq_meta_reset(vq);
@@ -1100,11 +1102,22 @@ static int vhost_iotlb_miss(struct vhost_virtqueue *vq, u64 iova, int access)
 	return 0;
 }
 
-static bool vq_access_ok(struct vhost_virtqueue *vq, unsigned int num,
-			 struct vring_desc __user *desc,
-			 struct vring_avail __user *avail,
-			 struct vring_used __user *used)
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
 
+static int vq_access_ok_split(struct vhost_virtqueue *vq, unsigned int num,
+			      struct vring_desc __user *desc,
+			      struct vring_avail __user *avail,
+			      struct vring_used __user *used)
 {
 	size_t s = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
 
@@ -1115,6 +1128,17 @@ static bool vq_access_ok(struct vhost_virtqueue *vq, unsigned int num,
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
@@ -1358,6 +1382,8 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 			break;
 		}
 		vq->last_avail_idx = s.num;
+		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
+			vq->avail_wrap_counter = s.num >> 31;
 		/* Forget the cached index value. */
 		vq->avail_idx = vq->last_avail_idx;
 		break;
@@ -1366,6 +1392,8 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 		s.num = vq->last_avail_idx;
 		if (copy_to_user(argp, &s, sizeof s))
 			r = -EFAULT;
+		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
+			s.num |= vq->avail_wrap_counter << 31;
 		break;
 	case VHOST_SET_VRING_ADDR:
 		if (copy_from_user(&a, argp, sizeof a)) {
@@ -1727,6 +1755,9 @@ int vhost_vq_init_access(struct vhost_virtqueue *vq)
 
 	vhost_init_is_le(vq);
 
+	if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
+		return 0;
+
 	r = vhost_update_used_flags(vq);
 	if (r)
 		goto err;
@@ -1800,7 +1831,8 @@ static int translate_desc(struct vhost_virtqueue *vq, u64 addr, u32 len,
 /* Each buffer in the virtqueues is actually a chain of descriptors.  This
  * function returns the next descriptor in the chain,
  * or -1U if we're at the end. */
-static unsigned next_desc(struct vhost_virtqueue *vq, struct vring_desc *desc)
+static unsigned next_desc_split(struct vhost_virtqueue *vq,
+				struct vring_desc *desc)
 {
 	unsigned int next;
 
@@ -1813,11 +1845,17 @@ static unsigned next_desc(struct vhost_virtqueue *vq, struct vring_desc *desc)
 	return next;
 }
 
-static int get_indirect(struct vhost_virtqueue *vq,
-			struct iovec iov[], unsigned int iov_size,
-			unsigned int *out_num, unsigned int *in_num,
-			struct vhost_log *log, unsigned int *log_num,
-			struct vring_desc *indirect)
+static unsigned next_desc_packed(struct vhost_virtqueue *vq,
+				 struct vring_desc_packed *desc)
+{
+	return desc->flags & cpu_to_vhost16(vq, VRING_DESC_F_NEXT);
+}
+
+static int get_indirect_split(struct vhost_virtqueue *vq,
+			      struct iovec iov[], unsigned int iov_size,
+			      unsigned int *out_num, unsigned int *in_num,
+			      struct vhost_log *log, unsigned int *log_num,
+			      struct vring_desc *indirect)
 {
 	struct vring_desc desc;
 	unsigned int i = 0, count, found = 0;
@@ -1907,23 +1945,274 @@ static int get_indirect(struct vhost_virtqueue *vq,
 			}
 			*out_num += ret;
 		}
-	} while ((i = next_desc(vq, &desc)) != -1);
+	} while ((i = next_desc_split(vq, &desc)) != -1);
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
-		      struct vhost_used_elem *used,
-		      struct iovec iov[], unsigned int iov_size,
-		      unsigned int *out_num, unsigned int *in_num,
-		      struct vhost_log *log, unsigned int *log_num)
+static int get_indirect_packed(struct vhost_virtqueue *vq,
+			       struct iovec iov[], unsigned int iov_size,
+			       unsigned int *out_num, unsigned int *in_num,
+			       struct vhost_log *log, unsigned int *log_num,
+			       struct vring_desc_packed *indirect)
+{
+	struct vring_desc_packed desc;
+	unsigned int i = 0, count, found = 0;
+	u32 len = vhost32_to_cpu(vq, indirect->len);
+	struct iov_iter from;
+	int ret, access;
+
+	/* Sanity check */
+	if (unlikely(len % sizeof(desc))) {
+		vq_err(vq, "Invalid length in indirect descriptor: "
+		       "len 0x%llx not multiple of 0x%zx\n",
+		       (unsigned long long)len,
+		       sizeof desc);
+		return -EINVAL;
+	}
+
+	ret = translate_desc(vq, vhost64_to_cpu(vq, indirect->addr),
+			     len, vq->indirect,
+			     UIO_MAXIOV, VHOST_ACCESS_RO);
+	if (unlikely(ret < 0)) {
+		if (ret != -EAGAIN)
+			vq_err(vq, "Translation failure %d in indirect.\n",
+			       ret);
+		return ret;
+	}
+	iov_iter_init(&from, READ, vq->indirect, ret, len);
+
+	/* We will use the result as an address to read from, so most
+	 * architectures only need a compiler barrier here. */
+	read_barrier_depends();
+
+	count = len / sizeof desc;
+	/* Buffers are chained via a 16 bit next field, so
+	 * we can have at most 2^16 of these. */
+	if (unlikely(count > USHRT_MAX + 1)) {
+		vq_err(vq, "Indirect buffer length too big: %d\n",
+		       indirect->len);
+		return -E2BIG;
+	}
+
+	do {
+		unsigned iov_count = *in_num + *out_num;
+		if (unlikely(++found > count)) {
+			vq_err(vq, "Loop detected: last one at %u "
+			       "indirect size %u\n",
+			       i, count);
+			return -EINVAL;
+		}
+		if (unlikely(!copy_from_iter_full(&desc, sizeof(desc),
+						  &from))) {
+			vq_err(vq, "Failed indirect descriptor: idx %d, %zx\n",
+			       i, (size_t)vhost64_to_cpu(vq, indirect->addr)
+				  + i * sizeof desc);
+			return -EINVAL;
+		}
+		if (unlikely(desc.flags &
+			     cpu_to_vhost16(vq, VRING_DESC_F_INDIRECT))) {
+			vq_err(vq, "Nested indirect descriptor: idx %d, %zx\n",
+			       i, (size_t)vhost64_to_cpu(vq, indirect->addr)
+				  + i * sizeof desc);
+			return -EINVAL;
+		}
+
+		if (desc.flags & cpu_to_vhost16(vq, VRING_DESC_F_WRITE))
+			access = VHOST_ACCESS_WO;
+		else
+			access = VHOST_ACCESS_RO;
+
+		ret = translate_desc(vq, vhost64_to_cpu(vq, desc.addr),
+				     vhost32_to_cpu(vq, desc.len),
+				     iov + iov_count,
+				     iov_size - iov_count, access);
+		if (unlikely(ret < 0)) {
+			if (ret != -EAGAIN)
+				vq_err(vq, "Translation failure %d "
+					   "indirect idx %d\n",
+				       ret, i);
+			return ret;
+		}
+		/* If this is an input descriptor, increment that count. */
+		if (access == VHOST_ACCESS_WO) {
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
+			 * to come before any input descriptors. */
+			if (unlikely(*in_num)) {
+				vq_err(vq, "Indirect descriptor "
+				       "has out after in: idx %d\n", i);
+				return -EINVAL;
+			}
+			*out_num += ret;
+		}
+		i++;
+	} while (next_desc_packed(vq, &desc));
+	return 0;
+}
+
+#define DESC_AVAIL (1 << VRING_DESC_F_AVAIL)
+#define DESC_USED  (1 << VRING_DESC_F_USED)
+static bool desc_is_avail(struct vhost_virtqueue *vq, __virtio16 flags)
+{
+	bool avail = flags & cpu_to_vhost16(vq, DESC_AVAIL);
+
+	return avail == vq->avail_wrap_counter;
+}
+
+static __virtio16 get_desc_flags(struct vhost_virtqueue *vq, bool write)
+{
+	__virtio16 flags = 0;
+
+	if (vq->used_wrap_counter) {
+		flags |= cpu_to_vhost16(vq, DESC_AVAIL);
+		flags |= cpu_to_vhost16(vq, DESC_USED);
+	} else {
+		flags &= ~cpu_to_vhost16(vq, DESC_AVAIL);
+		flags &= ~cpu_to_vhost16(vq, DESC_USED);
+	}
+
+	if (write)
+		flags |= cpu_to_vhost16(vq, VRING_DESC_F_WRITE);
+
+	return flags;
+}
+
+static int vhost_get_vq_desc_packed(struct vhost_virtqueue *vq,
+				    struct vhost_used_elem *used,
+				    struct iovec iov[], unsigned int iov_size,
+				    unsigned int *out_num, unsigned int *in_num,
+				    struct vhost_log *log,
+				    unsigned int *log_num)
+{
+	struct vring_desc_packed desc;
+	int ret, access, i;
+
+	/* When we start there are none of either input nor output. */
+	*out_num = *in_num = 0;
+	if (unlikely(log))
+		*log_num = 0;
+
+	used->count = 0;
+
+	do {
+		struct vring_desc_packed *d = vq->desc_packed +
+					      vq->last_avail_idx;
+		unsigned int iov_count = *in_num + *out_num;
+
+		ret = vhost_get_user(vq, desc.flags, &d->flags,
+				     VHOST_ADDR_DESC);
+		if (unlikely(ret)) {
+			vq_err(vq, "Failed to get flags: idx %d addr %p\n",
+			       vq->last_avail_idx, &d->flags);
+			return -EFAULT;
+		}
+
+		if (!desc_is_avail(vq, desc.flags)) {
+			/* If there's nothing new since last we looked, return
+			 * invalid.
+			 */
+			if (!used->count)
+				return -ENOSPC;
+			vq_err(vq, "Unexpected unavail descriptor: idx %d\n",
+			       vq->last_avail_idx);
+			return -EFAULT;
+		}
+
+		/* Read desc content after we're sure it was available. */
+		smp_rmb();
+
+		ret = vhost_copy_from_user(vq, &desc, d, sizeof(desc));
+		if (unlikely(ret)) {
+			vq_err(vq, "Failed to get descriptor: idx %d addr %p\n",
+				vq->last_avail_idx, d);
+			return -EFAULT;
+		}
+
+		used->elem.id = desc.id;
+
+		if (desc.flags & cpu_to_vhost16(vq, VRING_DESC_F_INDIRECT)) {
+			ret = get_indirect_packed(vq, iov, iov_size,
+						  out_num, in_num, log,
+						  log_num, &desc);
+			if (unlikely(ret < 0)) {
+				if (ret != -EAGAIN)
+					vq_err(vq, "Failure detected "
+						   "in indirect descriptor "
+						   "at idx %d\n", i);
+				return ret;
+			}
+			goto next;
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
+next:
+		if (unlikely(++used->count > vq->num)) {
+			vq_err(vq, "Loop detected: last one at %u "
+			       "vq size %u head %u\n",
+			       i, vq->num, used->elem.id);
+			return -EINVAL;
+		}
+		if (++vq->last_avail_idx >= vq->num) {
+			vq->last_avail_idx = 0;
+			vq->avail_wrap_counter ^= 1;
+		}
+	/* If this descriptor says it doesn't chain, we're done. */
+	} while (next_desc_packed(vq, &desc));
+
+	return 0;
+}
+
+static int vhost_get_vq_desc_split(struct vhost_virtqueue *vq,
+				   struct vhost_used_elem *used,
+				   struct iovec iov[], unsigned int iov_size,
+				   unsigned int *out_num, unsigned int *in_num,
+				   struct vhost_log *log, unsigned int *log_num)
 {
 	struct vring_desc desc;
 	unsigned int i, head, found = 0;
@@ -2008,9 +2297,9 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 			return -EFAULT;
 		}
 		if (desc.flags & cpu_to_vhost16(vq, VRING_DESC_F_INDIRECT)) {
-			ret = get_indirect(vq, iov, iov_size,
-					   out_num, in_num,
-					   log, log_num, &desc);
+			ret = get_indirect_split(vq, iov, iov_size,
+						 out_num, in_num,
+						 log, log_num, &desc);
 			if (unlikely(ret < 0)) {
 				if (ret != -EAGAIN)
 					vq_err(vq, "Failure detected "
@@ -2052,7 +2341,7 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 			}
 			*out_num += ret;
 		}
-	} while ((i = next_desc(vq, &desc)) != -1);
+	} while ((i = next_desc_split(vq, &desc)) != -1);
 
 	/* On success, increment avail index. */
 	vq->last_avail_idx++;
@@ -2062,6 +2351,31 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 	BUG_ON(!(vq->used_flags & VRING_USED_F_NO_NOTIFY));
 	return 0;
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
+		      struct vhost_used_elem *used,
+		      struct iovec iov[], unsigned int iov_size,
+		      unsigned int *out_num, unsigned int *in_num,
+		      struct vhost_log *log, unsigned int *log_num)
+{
+	if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
+		return vhost_get_vq_desc_packed(vq, used, iov, iov_size,
+						out_num, in_num,
+						log, log_num);
+	else
+		return vhost_get_vq_desc_split(vq, used, iov, iov_size,
+					       out_num, in_num,
+					       log, log_num);
+}
 EXPORT_SYMBOL_GPL(vhost_get_vq_desc);
 
 void vhost_set_used_len(struct vhost_virtqueue *vq,
@@ -2157,6 +2471,11 @@ EXPORT_SYMBOL_GPL(vhost_get_bufs);
 void vhost_discard_vq_desc(struct vhost_virtqueue *vq, int n)
 {
 	vq->last_avail_idx -= n;
+	if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED) &&
+	    vq->last_avail_idx >= vq->num) {
+		vq->avail_wrap_counter ^= 1;
+		vq->last_avail_idx += vq->num;
+	}
 }
 EXPORT_SYMBOL_GPL(vhost_discard_vq_desc);
 
@@ -2212,10 +2531,69 @@ static int __vhost_add_used_n(struct vhost_virtqueue *vq,
 	return 0;
 }
 
+static int vhost_add_used_n_packed(struct vhost_virtqueue *vq,
+				   struct vhost_used_elem *heads,
+				   unsigned int count)
+{
+	struct vring_desc_packed __user *desc;
+	int i, ret;
+
+	for (i = 0; i < count; i++) {
+		desc = vq->desc_packed + vq->last_used_idx;
+
+		ret = vhost_put_user(vq, heads[i].elem.id, &desc->id,
+				     VHOST_ADDR_DESC);
+		if (unlikely(ret)) {
+			vq_err(vq, "Failed to update id: idx %d addr %p\n",
+			       vq->last_used_idx, desc);
+			return -EFAULT;
+		}
+		ret = vhost_put_user(vq, heads[i].elem.len, &desc->len,
+				     VHOST_ADDR_DESC);
+		if (unlikely(ret)) {
+			vq_err(vq, "Failed to update len: idx %d addr %p\n",
+			       vq->last_used_idx, desc);
+			return -EFAULT;
+		}
+
+		/* Update flags after descriptor id and len is wrote,
+		 * TODO: Update head flags at last for saving barriers */
+		smp_wmb();
+
+		ret = vhost_put_user(vq, get_desc_flags(vq, heads[i].elem.len),
+				     &desc->flags, VHOST_ADDR_DESC);
+		if (unlikely(ret)) {
+			vq_err(vq, "Failed to update flags: idx %d addr %p\n",
+			       vq->last_used_idx, desc);
+			return -EFAULT;
+		}
+
+		if (unlikely(vq->log_used)) {
+			/* Make sure desc is written before update log. */
+			smp_wmb();
+			log_write(vq->log_base, vq->log_addr +
+				  vq->last_used_idx * sizeof(*desc),
+				  sizeof(*desc));
+			if (vq->log_ctx)
+				eventfd_signal(vq->log_ctx, 1);
+		}
+
+		vq->last_used_idx += heads[i].count;
+		if (vq->last_used_idx >= vq->num) {
+			vq->used_wrap_counter ^= 1;
+			vq->last_used_idx -= vq->num;
+		}
+	}
+
+	return 0;
+}
+
 /* After we've used one of their buffers, we tell them about it.  We'll then
  * want to notify the guest, using eventfd. */
-int vhost_add_used_n(struct vhost_virtqueue *vq, struct vhost_used_elem *heads,
-		     unsigned count)
+static int vhost_add_used_n_split(struct vhost_virtqueue *vq,
+				  struct vhost_used_elem *heads,
+				  unsigned count)
+
 {
 	int start, n, r;
 
@@ -2247,6 +2625,19 @@ int vhost_add_used_n(struct vhost_virtqueue *vq, struct vhost_used_elem *heads,
 	}
 	return r;
 }
+
+/* After we've used one of their buffers, we tell them about it.  We'll then
+ * want to notify the guest, using eventfd.
+ */
+int vhost_add_used_n(struct vhost_virtqueue *vq,
+		     struct vhost_used_elem *heads,
+		     unsigned int count)
+{
+	if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
+		return vhost_add_used_n_packed(vq, heads, count);
+	else
+		return vhost_add_used_n_split(vq, heads, count);
+}
 EXPORT_SYMBOL_GPL(vhost_add_used_n);
 
 static bool vhost_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
@@ -2254,6 +2645,11 @@ static bool vhost_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
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
@@ -2316,7 +2712,8 @@ void vhost_add_used_and_signal_n(struct vhost_dev *dev,
 EXPORT_SYMBOL_GPL(vhost_add_used_and_signal_n);
 
 /* return true if we're sure that avaiable ring is empty */
-bool vhost_vq_avail_empty(struct vhost_dev *dev, struct vhost_virtqueue *vq)
+static bool vhost_vq_avail_empty_split(struct vhost_dev *dev,
+				       struct vhost_virtqueue *vq)
 {
 	__virtio16 avail_idx;
 	int r;
@@ -2331,10 +2728,58 @@ bool vhost_vq_avail_empty(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 
 	return vq->avail_idx == vq->last_avail_idx;
 }
+
+static bool vhost_vq_avail_empty_packed(struct vhost_dev *dev,
+					struct vhost_virtqueue *vq)
+{
+	struct vring_desc_packed *d = vq->desc_packed + vq->last_avail_idx;
+	__virtio16 flags;
+	int ret;
+
+	ret = vhost_get_user(vq, flags, &d->flags, VHOST_ADDR_DESC);
+	if (unlikely(ret)) {
+		vq_err(vq, "Failed to get flags: idx %d addr %p\n",
+			vq->last_avail_idx, d);
+		return -EFAULT;
+	}
+
+	return !desc_is_avail(vq, flags);
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
+	struct vring_desc_packed *d = vq->desc_packed + vq->last_avail_idx;
+	__virtio16 flags;
+	int ret;
+
+	/* FIXME: disable notification through device area */
+
+	/* They could have slipped one in as we were doing that: make
+	 * sure it's written, then check again. */
+	smp_mb();
+
+	ret = vhost_get_user(vq, flags, &d->flags, VHOST_ADDR_DESC);
+	if (unlikely(ret)) {
+		vq_err(vq, "Failed to get descriptor: idx %d addr %p\n",
+			vq->last_avail_idx, &d->flags);
+		return -EFAULT;
+	}
+
+	return desc_is_avail(vq, flags);
+}
+
+static bool vhost_enable_notify_split(struct vhost_dev *dev,
+				      struct vhost_virtqueue *vq)
 {
 	__virtio16 avail_idx;
 	int r;
@@ -2369,10 +2814,25 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 
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
 
@@ -2386,6 +2846,15 @@ void vhost_disable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
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
index 604821b..286b470 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -36,6 +36,7 @@ struct vhost_poll {
 
 struct vhost_used_elem {
 	struct vring_used_elem elem;
+	int count;
 };
 
 void vhost_work_init(struct vhost_work *work, vhost_work_fn_t fn);
@@ -91,7 +92,10 @@ struct vhost_virtqueue {
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
@@ -148,6 +152,8 @@ struct vhost_virtqueue {
 	bool user_be;
 #endif
 	u32 busyloop_timeout;
+	bool used_wrap_counter;
+	bool avail_wrap_counter;
 };
 
 struct vhost_msg_node {
-- 
2.7.4
