Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751733AbeBWLTl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 06:19:41 -0500
Received: from mga04.intel.com ([192.55.52.120]:53962 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751559AbeBWLTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 06:19:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,383,1515484800";
   d="scan'208";a="19758523"
From: Tiwei Bie <tiwei.bie@intel.com>
To: mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: jasowang@redhat.com, wexu@redhat.com, jfreimann@redhat.com,
        tiwei.bie@intel.com
Subject: [PATCH RFC 1/2] virtio: introduce packed ring defines
Date: Fri, 23 Feb 2018 19:18:00 +0800
Message-Id: <20180223111801.15240-2-tiwei.bie@intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180223111801.15240-1-tiwei.bie@intel.com>
References: <20180223111801.15240-1-tiwei.bie@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 include/uapi/linux/virtio_config.h | 18 +++++++++-
 include/uapi/linux/virtio_ring.h   | 68 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index 308e2096291f..e3d077ef5207 100644
--- a/include/uapi/linux/virtio_config.h
+++ b/include/uapi/linux/virtio_config.h
@@ -49,7 +49,7 @@
  * transport being used (eg. virtio_ring), the rest are per-device feature
  * bits. */
 #define VIRTIO_TRANSPORT_F_START	28
-#define VIRTIO_TRANSPORT_F_END		34
+#define VIRTIO_TRANSPORT_F_END		37
 
 #ifndef VIRTIO_CONFIG_NO_LEGACY
 /* Do we get callbacks when the ring is completely used, even if we've
@@ -71,4 +71,20 @@
  * this is for compatibility with legacy systems.
  */
 #define VIRTIO_F_IOMMU_PLATFORM		33
+
+/* This feature indicates support for the packed virtqueue layout. */
+#define VIRTIO_F_RING_PACKED		34
+
+/*
+ * This feature indicates that all buffers are used by the device
+ * in the same order in which they have been made available.
+ */
+#define VIRTIO_F_IN_ORDER		35
+
+/*
+ * This feature indicates that drivers pass extra data (besides
+ * identifying the Virtqueue) in their device notifications.
+ */
+#define VIRTIO_F_NOTIFICATION_DATA	36
+
 #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */
diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
index 6d5d5faa989b..77b1d4aeef72 100644
--- a/include/uapi/linux/virtio_ring.h
+++ b/include/uapi/linux/virtio_ring.h
@@ -44,6 +44,9 @@
 /* This means the buffer contains a list of buffer descriptors. */
 #define VRING_DESC_F_INDIRECT	4
 
+#define VRING_DESC_F_AVAIL(b)	((b) << 7)
+#define VRING_DESC_F_USED(b)	((b) << 15)
+
 /* The Host uses this in used->flags to advise the Guest: don't kick me when
  * you add a buffer.  It's unreliable, so it's simply an optimization.  Guest
  * will still kick if it's out of buffers. */
@@ -104,6 +107,36 @@ struct vring {
 	struct vring_used *used;
 };
 
+struct vring_packed_desc_event {
+	/* Descriptor Event Offset */
+	__virtio16 desc_event_off   : 15,
+	/* Descriptor Event Wrap Counter */
+		   desc_event_wrap  : 1;
+	/* Descriptor Event Flags */
+	__virtio16 desc_event_flags : 2;
+};
+
+struct vring_packed_desc {
+	/* Buffer Address. */
+	__virtio64 addr;
+	/* Buffer Length. */
+	__virtio32 len;
+	/* Buffer ID. */
+	__virtio16 id;
+	/* The flags depending on descriptor type. */
+	__virtio16 flags;
+};
+
+struct vring_packed {
+	unsigned int num;
+
+	struct vring_packed_desc *desc;
+
+	struct vring_packed_desc_event *driver;
+
+	struct vring_packed_desc_event *device;
+};
+
 /* Alignment requirements for vring elements.
  * When using pre-virtio 1.0 layout, these fall out naturally.
  */
@@ -171,4 +204,39 @@ static inline int vring_need_event(__u16 event_idx, __u16 new_idx, __u16 old)
 	return (__u16)(new_idx - event_idx - 1) < (__u16)(new_idx - old);
 }
 
+/* The standard layout for the packed ring is a continuous chunk of memory
+ * which looks like this.
+ *
+ * struct vring_packed
+ * {
+ *	// The actual descriptors (16 bytes each)
+ *	struct vring_packed_desc desc[num];
+ *
+ *	// Padding to the next align boundary.
+ *	char pad[];
+ *
+ *	// Driver Event Suppression
+ *	struct vring_packed_desc_event driver;
+ *
+ *	// Device Event Suppression
+ *	struct vring_packed_desc_event device;
+ * };
+ */
+
+static inline void vring_packed_init(struct vring_packed *vr, unsigned int num,
+				     void *p, unsigned long align)
+{
+	vr->num = num;
+	vr->desc = p;
+	vr->driver = (void *)(((uintptr_t)p + sizeof(struct vring_packed_desc)
+		* num + align - 1) & ~(align - 1));
+	vr->device = vr->driver + 1;
+}
+
+static inline unsigned vring_packed_size(unsigned int num, unsigned long align)
+{
+	return ((sizeof(struct vring_packed_desc) * num + align - 1)
+		& ~(align - 1)) + sizeof(struct vring_packed_desc_event) * 2;
+}
+
 #endif /* _UAPI_LINUX_VIRTIO_RING_H */
-- 
2.14.1
