Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9B5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 07:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7ED205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 07:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731870AbeL1H4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 02:56:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40206 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731533AbeL1Hz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 02:55:57 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6551512F8EA;
        Fri, 28 Dec 2018 07:55:56 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-196.pek2.redhat.com [10.72.12.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D54D75D9C9;
        Fri, 28 Dec 2018 07:55:53 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH V2 3/3] vhost: access vq metadata through kernel virtual address
Date:   Fri, 28 Dec 2018 15:55:37 +0800
Message-Id: <20181228075537.21402-4-jasowang@redhat.com>
In-Reply-To: <20181228075537.21402-1-jasowang@redhat.com>
References: <20181228075537.21402-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 28 Dec 2018 07:55:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was noticed that the copy_user() friends that was used to access
virtqueue metdata tends to be very expensive for dataplane
implementation like vhost since it involves lots of software checks,
speculation barrier, hardware feature toggling (e.g SMAP). The
extra cost will be more obvious when transferring small packets since
the time spent on metadata accessing become significant..

This patch tries to eliminate those overhead by accessing them through
kernel virtual address by vmap(). To make the pages can be migrated,
instead of pinning them through GUP, we use mmu notifiers to
invalidate vmaps and re-establish vmaps during each round of metadata
prefetching in necessary. For devices that doesn't use metadata
prefetch, the memory acessors fallback to normal copy_user()
implementation gracefully.

Note that this was only done when device IOTLB is not enabled. We
could use similar method to optimize it in the future.

Tests shows about ~24% improvement on TX PPS when using virtio-user +
vhost_net + xdp1 on TAP:

Before: ~5.0Mpps
After:  ~6.1Mpps

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c   |   4 +-
 drivers/vhost/vhost.c | 259 +++++++++++++++++++++++++++++++++++++++++-
 drivers/vhost/vhost.h |  15 ++-
 3 files changed, 271 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 36f3d0f49e60..0b4b3deab5aa 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -971,7 +971,7 @@ static void handle_tx(struct vhost_net *net)
 	if (!sock)
 		goto out;
 
-	if (!vq_iotlb_prefetch(vq))
+	if (!vq_meta_prefetch(vq))
 		goto out;
 
 	vhost_disable_notify(&net->dev, vq);
@@ -1140,7 +1140,7 @@ static void handle_rx(struct vhost_net *net)
 	if (!sock)
 		goto out;
 
-	if (!vq_iotlb_prefetch(vq))
+	if (!vq_meta_prefetch(vq))
 		goto out;
 
 	vhost_disable_notify(&net->dev, vq);
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 337ce6f5a098..46a889b61a4d 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -440,6 +440,9 @@ void vhost_dev_init(struct vhost_dev *dev,
 		vq->indirect = NULL;
 		vq->heads = NULL;
 		vq->dev = dev;
+		memset(&vq->avail_ring, 0, sizeof(vq->avail_ring));
+		memset(&vq->used_ring, 0, sizeof(vq->used_ring));
+		memset(&vq->desc_ring, 0, sizeof(vq->desc_ring));
 		mutex_init(&vq->mutex);
 		vhost_vq_reset(dev, vq);
 		if (vq->handle_kick)
@@ -489,6 +492,61 @@ bool vhost_dev_has_owner(struct vhost_dev *dev)
 }
 EXPORT_SYMBOL_GPL(vhost_dev_has_owner);
 
+static int vhost_invalidate_vmap(struct vhost_virtqueue *vq,
+				 struct vhost_vmap *map,
+				 unsigned long uaddr,
+				 unsigned long start,
+				 unsigned long end,
+				 bool blockable)
+{
+	if (start < uaddr && end >= uaddr) {
+		if (!blockable)
+			return -EAGAIN;
+		mutex_lock(&vq->mutex);
+		if (map->addr)
+			vunmap(map->unmap_addr);
+		map->addr = NULL;
+		map->unmap_addr = NULL;
+		mutex_unlock(&vq->mutex);
+	}
+
+	return 0;
+}
+
+static int vhost_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
+						     struct mm_struct *mm,
+						     unsigned long start,
+						     unsigned long end,
+						     bool blockable)
+{
+	struct vhost_dev *dev = container_of(mn, struct vhost_dev,
+					     mmu_notifier);
+	int i;
+
+	for (i = 0; i < dev->nvqs; i++) {
+		struct vhost_virtqueue *vq = dev->vqs[i];
+
+		if (vhost_invalidate_vmap(vq, &vq->avail_ring,
+					  (unsigned long)vq->avail,
+					  start, end, blockable))
+			return -EAGAIN;
+		if (vhost_invalidate_vmap(vq, &vq->desc_ring,
+					  (unsigned long)vq->desc,
+					  start, end, blockable))
+			return -EAGAIN;
+		if (vhost_invalidate_vmap(vq, &vq->used_ring,
+					  (unsigned long)vq->used,
+					  start, end, blockable))
+			return -EAGAIN;
+	}
+
+	return 0;
+}
+
+static const struct mmu_notifier_ops vhost_mmu_notifier_ops = {
+	.invalidate_range_start = vhost_mmu_notifier_invalidate_range_start,
+};
+
 /* Caller should have device mutex */
 long vhost_dev_set_owner(struct vhost_dev *dev)
 {
@@ -520,7 +578,14 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 	if (err)
 		goto err_cgroup;
 
+	dev->mmu_notifier.ops = &vhost_mmu_notifier_ops;
+	err = mmu_notifier_register(&dev->mmu_notifier, dev->mm);
+	if (err)
+		goto err_mmu_notifier;
+
 	return 0;
+err_mmu_notifier:
+	vhost_dev_free_iovecs(dev);
 err_cgroup:
 	kthread_stop(worker);
 	dev->worker = NULL;
@@ -611,6 +676,87 @@ static void vhost_clear_msg(struct vhost_dev *dev)
 	spin_unlock(&dev->iotlb_lock);
 }
 
+static int vhost_init_vmap(struct vhost_vmap *map, unsigned long uaddr,
+			   size_t size, int write)
+{
+	struct page **pages;
+	int npages = DIV_ROUND_UP(size, PAGE_SIZE);
+	int npinned;
+	void *vaddr;
+	int err = 0;
+
+	pages = kmalloc_array(npages, sizeof(struct page *), GFP_KERNEL);
+	if (!pages)
+		return -ENOMEM;
+
+	npinned = get_user_pages_fast(uaddr, npages, write, pages);
+	if (npinned != npages) {
+		err = -EFAULT;
+		goto err;
+	}
+
+	vaddr = vmap(pages, npages, VM_MAP, PAGE_KERNEL);
+	if (!vaddr) {
+		err = EFAULT;
+		goto err;
+	}
+
+	map->addr = vaddr + (uaddr & (PAGE_SIZE - 1));
+	map->unmap_addr = vaddr;
+
+err:
+	/* Don't pin pages, mmu notifier will notify us about page
+	 * migration.
+	 */
+	if (npinned > 0)
+		release_pages(pages, npinned);
+	kfree(pages);
+	return err;
+}
+
+static void vhost_uninit_vmap(struct vhost_vmap *map)
+{
+	if (map->addr) {
+		vunmap(map->unmap_addr);
+		map->addr = NULL;
+	}
+}
+
+static void vhost_clean_vmaps(struct vhost_virtqueue *vq)
+{
+	vhost_uninit_vmap(&vq->avail_ring);
+	vhost_uninit_vmap(&vq->desc_ring);
+	vhost_uninit_vmap(&vq->used_ring);
+}
+
+static int vhost_setup_avail_vmap(struct vhost_virtqueue *vq,
+				  unsigned long avail)
+{
+	size_t event = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
+	size_t avail_size = sizeof(*vq->avail) +
+			    sizeof(*vq->avail->ring) * vq->num + event;
+
+	return vhost_init_vmap(&vq->avail_ring, avail, avail_size, false);
+}
+
+static int vhost_setup_desc_vmap(struct vhost_virtqueue *vq,
+				 unsigned long desc)
+{
+	size_t desc_size = sizeof(*vq->desc) * vq->num;
+
+	return vhost_init_vmap(&vq->desc_ring, desc, desc_size, false);
+}
+
+static int vhost_setup_used_vmap(struct vhost_virtqueue *vq,
+				 unsigned long used)
+{
+	size_t event = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
+	size_t used_size = sizeof(*vq->used) +
+			   sizeof(*vq->used->ring) * vq->num + event;
+
+	return vhost_init_vmap(&vq->used_ring, used, used_size, true);
+}
+
 void vhost_dev_cleanup(struct vhost_dev *dev)
 {
 	int i;
@@ -623,6 +769,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
 		if (dev->vqs[i]->call_ctx)
 			eventfd_ctx_put(dev->vqs[i]->call_ctx);
 		vhost_vq_reset(dev, dev->vqs[i]);
+		vhost_clean_vmaps(dev->vqs[i]);
 	}
 	vhost_dev_free_iovecs(dev);
 	if (dev->log_ctx)
@@ -640,8 +787,10 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
 		kthread_stop(dev->worker);
 		dev->worker = NULL;
 	}
-	if (dev->mm)
+	if (dev->mm) {
+		mmu_notifier_unregister(&dev->mmu_notifier, dev->mm);
 		mmput(dev->mm);
+	}
 	dev->mm = NULL;
 }
 EXPORT_SYMBOL_GPL(vhost_dev_cleanup);
@@ -870,6 +1019,16 @@ static inline void __user *__vhost_get_user(struct vhost_virtqueue *vq,
 
 static inline int vhost_put_avail_event(struct vhost_virtqueue *vq)
 {
+	if (!vq->iotlb) {
+		struct vring_used *used = vq->used_ring.addr;
+
+		if (likely(used)) {
+			*((__virtio16 *)&used->ring[vq->num]) =
+				cpu_to_vhost16(vq, vq->avail_idx);
+			return 0;
+		}
+	}
+
 	return vhost_put_user(vq, cpu_to_vhost16(vq, vq->avail_idx),
 			      vhost_avail_event(vq));
 }
@@ -878,6 +1037,16 @@ static inline int vhost_put_used(struct vhost_virtqueue *vq,
 				 struct vring_used_elem *head, int idx,
 				 int count)
 {
+	if (!vq->iotlb) {
+		struct vring_used *used = vq->used_ring.addr;
+
+		if (likely(used)) {
+			memcpy(used->ring + idx, head,
+			       count * sizeof(*head));
+			return 0;
+		}
+	}
+
 	return vhost_copy_to_user(vq, vq->used->ring + idx, head,
 				  count * sizeof(*head));
 }
@@ -885,6 +1054,15 @@ static inline int vhost_put_used(struct vhost_virtqueue *vq,
 static inline int vhost_put_used_flags(struct vhost_virtqueue *vq)
 
 {
+	if (!vq->iotlb) {
+		struct vring_used *used = vq->used_ring.addr;
+
+		if (likely(used)) {
+			used->flags = cpu_to_vhost16(vq, vq->used_flags);
+			return 0;
+		}
+	}
+
 	return vhost_put_user(vq, cpu_to_vhost16(vq, vq->used_flags),
 			      &vq->used->flags);
 }
@@ -892,6 +1070,15 @@ static inline int vhost_put_used_flags(struct vhost_virtqueue *vq)
 static inline int vhost_put_used_idx(struct vhost_virtqueue *vq)
 
 {
+	if (!vq->iotlb) {
+		struct vring_used *used = vq->used_ring.addr;
+
+		if (likely(used)) {
+			used->idx = cpu_to_vhost16(vq, vq->last_used_idx);
+			return 0;
+		}
+	}
+
 	return vhost_put_user(vq, cpu_to_vhost16(vq, vq->last_used_idx),
 			      &vq->used->idx);
 }
@@ -937,12 +1124,30 @@ static void vhost_dev_unlock_vqs(struct vhost_dev *d)
 static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq,
 				      __virtio16 *idx)
 {
+	if (!vq->iotlb) {
+		struct vring_avail *avail = vq->avail_ring.addr;
+
+		if (likely(avail)) {
+			*idx = avail->idx;
+			return 0;
+		}
+	}
+
 	return vhost_get_avail(vq, *idx, &vq->avail->idx);
 }
 
 static inline int vhost_get_avail_head(struct vhost_virtqueue *vq,
 				       __virtio16 *head, int idx)
 {
+	if (!vq->iotlb) {
+		struct vring_avail *avail = vq->avail_ring.addr;
+
+		if (likely(avail)) {
+			*head = avail->ring[idx & (vq->num - 1)];
+			return 0;
+		}
+	}
+
 	return vhost_get_avail(vq, *head,
 			       &vq->avail->ring[idx & (vq->num - 1)]);
 }
@@ -950,24 +1155,60 @@ static inline int vhost_get_avail_head(struct vhost_virtqueue *vq,
 static inline int vhost_get_avail_flags(struct vhost_virtqueue *vq,
 					__virtio16 *flags)
 {
+	if (!vq->iotlb) {
+		struct vring_avail *avail = vq->avail_ring.addr;
+
+		if (likely(avail)) {
+			*flags = avail->flags;
+			return 0;
+		}
+	}
+
 	return vhost_get_avail(vq, *flags, &vq->avail->flags);
 }
 
 static inline int vhost_get_used_event(struct vhost_virtqueue *vq,
 				       __virtio16 *event)
 {
+	if (!vq->iotlb) {
+		struct vring_avail *avail = vq->avail_ring.addr;
+
+		if (likely(avail)) {
+			*event = (__virtio16)avail->ring[vq->num];
+			return 0;
+		}
+	}
+
 	return vhost_get_avail(vq, *event, vhost_used_event(vq));
 }
 
 static inline int vhost_get_used_idx(struct vhost_virtqueue *vq,
 				     __virtio16 *idx)
 {
+	if (!vq->iotlb) {
+		struct vring_used *used = vq->used_ring.addr;
+
+		if (likely(used)) {
+			*idx = used->idx;
+			return 0;
+		}
+	}
+
 	return vhost_get_used(vq, *idx, &vq->used->idx);
 }
 
 static inline int vhost_get_desc(struct vhost_virtqueue *vq,
 				 struct vring_desc *desc, int idx)
 {
+	if (!vq->iotlb) {
+		struct vring_desc *d = vq->desc_ring.addr;
+
+		if (likely(d)) {
+			*desc = *(d + idx);
+			return 0;
+		}
+	}
+
 	return vhost_copy_from_user(vq, desc, vq->desc + idx, sizeof(*desc));
 }
 
@@ -1304,13 +1545,21 @@ static bool iotlb_access_ok(struct vhost_virtqueue *vq,
 	return true;
 }
 
-int vq_iotlb_prefetch(struct vhost_virtqueue *vq)
+int vq_meta_prefetch(struct vhost_virtqueue *vq)
 {
 	size_t s = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
 	unsigned int num = vq->num;
 
-	if (!vq->iotlb)
+	if (!vq->iotlb) {
+		if (unlikely(!vq->avail_ring.addr))
+			vhost_setup_avail_vmap(vq, (unsigned long)vq->avail);
+		if (unlikely(!vq->desc_ring.addr))
+			vhost_setup_desc_vmap(vq, (unsigned long)vq->desc);
+		if (unlikely(!vq->used_ring.addr))
+			vhost_setup_used_vmap(vq, (unsigned long)vq->used);
+
 		return 1;
+	}
 
 	return iotlb_access_ok(vq, VHOST_ACCESS_RO, (u64)(uintptr_t)vq->desc,
 			       num * sizeof(*vq->desc), VHOST_ADDR_DESC) &&
@@ -1323,7 +1572,7 @@ int vq_iotlb_prefetch(struct vhost_virtqueue *vq)
 			       num * sizeof(*vq->used->ring) + s,
 			       VHOST_ADDR_USED);
 }
-EXPORT_SYMBOL_GPL(vq_iotlb_prefetch);
+EXPORT_SYMBOL_GPL(vq_meta_prefetch);
 
 /* Can we log writes? */
 /* Caller should have device mutex but not vq mutex */
@@ -1561,6 +1810,8 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 			}
 		}
 
+		vhost_clean_vmaps(vq);
+
 		vq->log_used = !!(a.flags & (0x1 << VHOST_VRING_F_LOG));
 		vq->desc = (void __user *)(unsigned long)a.desc_user_addr;
 		vq->avail = (void __user *)(unsigned long)a.avail_user_addr;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 466ef7542291..00f016a4f198 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -12,6 +12,8 @@
 #include <linux/virtio_config.h>
 #include <linux/virtio_ring.h>
 #include <linux/atomic.h>
+#include <linux/pagemap.h>
+#include <linux/mmu_notifier.h>
 
 struct vhost_work;
 typedef void (*vhost_work_fn_t)(struct vhost_work *work);
@@ -80,6 +82,11 @@ enum vhost_uaddr_type {
 	VHOST_NUM_ADDRS = 3,
 };
 
+struct vhost_vmap {
+	void *addr;
+	void *unmap_addr;
+};
+
 /* The virtqueue structure describes a queue attached to a device. */
 struct vhost_virtqueue {
 	struct vhost_dev *dev;
@@ -90,6 +97,11 @@ struct vhost_virtqueue {
 	struct vring_desc __user *desc;
 	struct vring_avail __user *avail;
 	struct vring_used __user *used;
+
+	struct vhost_vmap avail_ring;
+	struct vhost_vmap desc_ring;
+	struct vhost_vmap used_ring;
+
 	const struct vhost_umem_node *meta_iotlb[VHOST_NUM_ADDRS];
 	struct file *kick;
 	struct eventfd_ctx *call_ctx;
@@ -158,6 +170,7 @@ struct vhost_msg_node {
 
 struct vhost_dev {
 	struct mm_struct *mm;
+	struct mmu_notifier mmu_notifier;
 	struct mutex mutex;
 	struct vhost_virtqueue **vqs;
 	int nvqs;
@@ -206,7 +219,7 @@ bool vhost_enable_notify(struct vhost_dev *, struct vhost_virtqueue *);
 
 int vhost_log_write(struct vhost_virtqueue *vq, struct vhost_log *log,
 		    unsigned int log_num, u64 len);
-int vq_iotlb_prefetch(struct vhost_virtqueue *vq);
+int vq_meta_prefetch(struct vhost_virtqueue *vq);
 
 struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type);
 void vhost_enqueue_msg(struct vhost_dev *dev,
-- 
2.17.1

