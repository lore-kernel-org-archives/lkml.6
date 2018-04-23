Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754150AbeDWFgF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 01:36:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754105AbeDWFfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 01:35:51 -0400
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        tiwei.bie@intel.com, jfreimann@redhat.com, wexu@redhat.com
Subject: [RFC V3 PATCH 8/8] vhost: event suppression for packed ring
Date: Mon, 23 Apr 2018 13:35:00 +0800
Message-Id: <1524461700-5469-9-git-send-email-jasowang@redhat.com>
In-Reply-To: <1524461700-5469-1-git-send-email-jasowang@redhat.com>
References: <1524461700-5469-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces basic support for event suppression aka driver
and device area.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c            | 170 ++++++++++++++++++++++++++++++++++++---
 drivers/vhost/vhost.h            |  10 ++-
 include/uapi/linux/virtio_ring.h |  19 +++++
 3 files changed, 184 insertions(+), 15 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 7759441..53a4673 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1143,10 +1143,15 @@ static int vq_access_ok_packed(struct vhost_virtqueue *vq, unsigned int num,
 			       struct vring_used __user *used)
 {
 	struct vring_desc_packed *packed = (struct vring_desc_packed *)desc;
+	struct vring_packed_desc_event *driver_event =
+		(struct vring_packed_desc_event *)avail;
+	struct vring_packed_desc_event *device_event =
+		(struct vring_packed_desc_event *)used;
 
-	/* FIXME: check device area and driver area */
 	return access_ok(VERIFY_READ, packed, num * sizeof(*packed)) &&
-	       access_ok(VERIFY_WRITE, packed, num * sizeof(*packed));
+	       access_ok(VERIFY_WRITE, packed, num * sizeof(*packed)) &&
+	       access_ok(VERIFY_READ, driver_event, sizeof(*driver_event)) &&
+	       access_ok(VERIFY_WRITE, device_event, sizeof(*device_event));
 }
 
 static int vq_access_ok_split(struct vhost_virtqueue *vq, unsigned int num,
@@ -1221,14 +1226,27 @@ static bool iotlb_access_ok(struct vhost_virtqueue *vq,
 	return true;
 }
 
-int vq_iotlb_prefetch(struct vhost_virtqueue *vq)
+int vq_iotlb_prefetch_packed(struct vhost_virtqueue *vq)
+{
+	int num = vq->num;
+
+	return iotlb_access_ok(vq, VHOST_ACCESS_RO, (u64)(uintptr_t)vq->desc,
+			       num * sizeof(*vq->desc), VHOST_ADDR_DESC) &&
+	       iotlb_access_ok(vq, VHOST_ACCESS_WO, (u64)(uintptr_t)vq->desc,
+			       num * sizeof(*vq->desc), VHOST_ADDR_DESC) &&
+	       iotlb_access_ok(vq, VHOST_ACCESS_RO,
+			       (u64)(uintptr_t)vq->driver_event,
+			       sizeof(*vq->driver_event), VHOST_ADDR_AVAIL) &&
+	       iotlb_access_ok(vq, VHOST_ACCESS_WO,
+			       (u64)(uintptr_t)vq->device_event,
+			       sizeof(*vq->device_event), VHOST_ADDR_USED);
+}
+
+int vq_iotlb_prefetch_split(struct vhost_virtqueue *vq)
 {
 	size_t s = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
 	unsigned int num = vq->num;
 
-	if (!vq->iotlb)
-		return 1;
-
 	return iotlb_access_ok(vq, VHOST_ACCESS_RO, (u64)(uintptr_t)vq->desc,
 			       num * sizeof(*vq->desc), VHOST_ADDR_DESC) &&
 	       iotlb_access_ok(vq, VHOST_ACCESS_RO, (u64)(uintptr_t)vq->avail,
@@ -1240,6 +1258,17 @@ int vq_iotlb_prefetch(struct vhost_virtqueue *vq)
 			       num * sizeof(*vq->used->ring) + s,
 			       VHOST_ADDR_USED);
 }
+
+int vq_iotlb_prefetch(struct vhost_virtqueue *vq)
+{
+	if (!vq->iotlb)
+		return 1;
+
+	if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
+		return vq_iotlb_prefetch_packed(vq);
+	else
+		return vq_iotlb_prefetch_split(vq);
+}
 EXPORT_SYMBOL_GPL(vq_iotlb_prefetch);
 
 /* Can we log writes? */
@@ -1755,6 +1784,29 @@ static int vhost_update_used_flags(struct vhost_virtqueue *vq)
 	return 0;
 }
 
+static int vhost_update_device_flags(struct vhost_virtqueue *vq,
+				     __virtio16 device_flags)
+{
+	void __user *flags;
+
+	if (vhost_put_user(vq, cpu_to_vhost16(vq, device_flags),
+			   &vq->device_event->desc_event_flags,
+			   VHOST_ADDR_USED) < 0)
+		return -EFAULT;
+	if (unlikely(vq->log_used)) {
+		/* Make sure the flag is seen before log. */
+		smp_wmb();
+		/* Log used flag write. */
+		flags = &vq->device_event->desc_event_flags;
+		log_write(vq->log_base, vq->log_addr +
+			  (flags - (void __user *)vq->device_event),
+			  sizeof(vq->used->flags));
+		if (vq->log_ctx)
+			eventfd_signal(vq->log_ctx, 1);
+	}
+	return 0;
+}
+
 static int vhost_update_avail_event(struct vhost_virtqueue *vq, u16 avail_event)
 {
 	if (vhost_put_user(vq, cpu_to_vhost16(vq, vq->avail_idx),
@@ -2671,16 +2723,13 @@ int vhost_add_used_n(struct vhost_virtqueue *vq,
 }
 EXPORT_SYMBOL_GPL(vhost_add_used_n);
 
-static bool vhost_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
+static bool vhost_notify_split(struct vhost_dev *dev,
+			       struct vhost_virtqueue *vq)
 {
 	__u16 old, new;
 	__virtio16 event;
 	bool v;
 
-	/* FIXME: check driver area */
-	if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
-		return false;
-
 	/* Flush out used index updates. This is paired
 	 * with the barrier that the Guest executes when enabling
 	 * interrupts. */
@@ -2713,6 +2762,80 @@ static bool vhost_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 	return vring_need_event(vhost16_to_cpu(vq, event), new, old);
 }
 
+static u16 vhost_idx_diff(struct vhost_virtqueue *vq, u16 old, u16 new)
+{
+	if (new > old)
+		return new - old;
+	return  (new + vq->num - old);
+}
+
+static bool vhost_vring_packed_need_event(struct vhost_virtqueue *vq,
+					  __u16 event_off, __u16 new,
+					  __u16 old)
+{
+	return (__u16)(vhost_idx_diff(vq, new, event_off) - 1) <
+	       (__u16)vhost_idx_diff(vq, new, old);
+}
+
+static bool vhost_notify_packed(struct vhost_dev *dev,
+				struct vhost_virtqueue *vq)
+{
+	__virtio16 event_off_wrap, event_flags;
+	__u16 old, new;
+	bool v, wrap;
+	int off;
+
+	/* Flush out used descriptors updates. This is paired
+	 * with the barrier that the Guest executes when enabling
+	 * interrupts.
+	 */
+	smp_mb();
+
+	if (vhost_get_avail(vq, event_flags,
+			   &vq->driver_event->desc_event_flags) < 0) {
+		vq_err(vq, "Failed to get driver desc_event_flags");
+		return true;
+	}
+
+	if (event_flags == cpu_to_vhost16(vq, RING_EVENT_FLAGS_DISABLE))
+		return false;
+	else if (event_flags == cpu_to_vhost16(vq, RING_EVENT_FLAGS_ENABLE))
+		return true;
+
+	/* Read desc event flags before event_off and event_wrap */
+	smp_rmb();
+
+	if (vhost_get_avail(vq, event_off_wrap,
+			    &vq->driver_event->desc_event_off_warp) < 0) {
+		vq_err(vq, "Failed to get driver desc_event_off/wrap");
+		return true;
+	}
+
+	off = vhost16_to_cpu(vq, event_off_wrap);
+
+	wrap = off >> 15;
+	off = off & ~((1 << 15) - 1);
+
+	old = vq->signalled_used;
+	v = vq->signalled_used_valid;
+	new = vq->signalled_used = vq->last_used_idx;
+	vq->signalled_used_valid = true;
+
+	if (unlikely(!v))
+		return true;
+
+	return vhost_vring_packed_need_event(vq, new, old, off) &&
+	       wrap == vq->used_wrap_counter;
+}
+
+static bool vhost_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
+{
+	if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
+		return vhost_notify_packed(dev, vq);
+	else
+		return vhost_notify_split(dev, vq);
+}
+
 /* This actually signals the guest, using eventfd. */
 void vhost_signal(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 {
@@ -2793,7 +2916,17 @@ static bool vhost_enable_notify_packed(struct vhost_dev *dev,
 	__virtio16 flags;
 	int ret;
 
-	/* FIXME: disable notification through device area */
+	if (!(vq->used_flags & VRING_USED_F_NO_NOTIFY))
+		return false;
+	vq->used_flags &= ~VRING_USED_F_NO_NOTIFY;
+
+	flags = cpu_to_vhost16(vq, RING_EVENT_FLAGS_ENABLE);
+	ret = vhost_update_device_flags(vq, flags);
+	if (ret) {
+		vq_err(vq, "Failed to enable notification at %p: %d\n",
+		       &vq->device_event->desc_event_flags, ret);
+		return false;
+	}
 
 	/* They could have slipped one in as we were doing that: make
 	 * sure it's written, then check again. */
@@ -2859,7 +2992,18 @@ EXPORT_SYMBOL_GPL(vhost_enable_notify);
 static void vhost_disable_notify_packed(struct vhost_dev *dev,
 					struct vhost_virtqueue *vq)
 {
-	/* FIXME: disable notification through device area */
+	__virtio16 flags;
+	int r;
+
+	if (vq->used_flags & VRING_USED_F_NO_NOTIFY)
+		return;
+	vq->used_flags |= VRING_USED_F_NO_NOTIFY;
+
+	flags = cpu_to_vhost16(vq, RING_EVENT_FLAGS_DISABLE);
+	r = vhost_update_device_flags(vq, flags);
+	if (r)
+		vq_err(vq, "Failed to enable notification at %p: %d\n",
+		       &vq->device_event->desc_event_flags, r);
 }
 
 static void vhost_disable_notify_split(struct vhost_dev *dev,
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 286b470..0750659 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -96,8 +96,14 @@ struct vhost_virtqueue {
 		struct vring_desc __user *desc;
 		struct vring_desc_packed __user *desc_packed;
 	};
-	struct vring_avail __user *avail;
-	struct vring_used __user *used;
+	union {
+		struct vring_avail __user *avail;
+		struct vring_packed_desc_event __user *driver_event;
+	};
+	union {
+		struct vring_used __user *used;
+		struct vring_packed_desc_event __user *device_event;
+	};
 	const struct vhost_umem_node *meta_iotlb[VHOST_NUM_ADDRS];
 	struct file *kick;
 	struct eventfd_ctx *call_ctx;
diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
index e297580..7cdbf06 100644
--- a/include/uapi/linux/virtio_ring.h
+++ b/include/uapi/linux/virtio_ring.h
@@ -75,6 +75,25 @@ struct vring_desc_packed {
 	__virtio16 flags;
 };
 
+/* Enable events */
+#define RING_EVENT_FLAGS_ENABLE 0x0
+/* Disable events */
+#define RING_EVENT_FLAGS_DISABLE 0x1
+/*
+ * Enable events for a specific descriptor
+ * (as specified by Descriptor Ring Change Event Offset/Wrap Counter).
+ * Only valid if VIRTIO_F_RING_EVENT_IDX has been negotiated.
+ */
+#define RING_EVENT_FLAGS_DESC 0x2
+/* The value 0x3 is reserved */
+
+struct vring_packed_desc_event {
+	/* Descriptor Ring Change Event Offset and Wrap Counter */
+	__virtio16 desc_event_off_warp;
+	/* Descriptor Ring Change Event Flags */
+	__virtio16 desc_event_flags;
+};
+
 /* Virtio ring descriptors: 16 bytes.  These can chain together via "next". */
 struct vring_desc {
 	/* Address (guest-physical). */
-- 
2.7.4
