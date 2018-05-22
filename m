Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbeEVIRV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 04:17:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:23522 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751002AbeEVIRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 04:17:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,429,1520924400";
   d="scan'208";a="51200164"
From: Tiwei Bie <tiwei.bie@intel.com>
To: mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: wexu@redhat.com, jfreimann@redhat.com, tiwei.bie@intel.com
Subject: [RFC v5 1/5] virtio: add packed ring definitions
Date: Tue, 22 May 2018 16:16:44 +0800
Message-Id: <20180522081648.14768-2-tiwei.bie@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180522081648.14768-1-tiwei.bie@intel.com>
References: <20180522081648.14768-1-tiwei.bie@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 include/uapi/linux/virtio_config.h |  5 ++++-
 include/uapi/linux/virtio_ring.h   | 36 ++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index 308e2096291f..932a6ecc8e46 100644
--- a/include/uapi/linux/virtio_config.h
+++ b/include/uapi/linux/virtio_config.h
@@ -49,7 +49,7 @@
  * transport being used (eg. virtio_ring), the rest are per-device feature
  * bits. */
 #define VIRTIO_TRANSPORT_F_START	28
-#define VIRTIO_TRANSPORT_F_END		34
+#define VIRTIO_TRANSPORT_F_END		35
 
 #ifndef VIRTIO_CONFIG_NO_LEGACY
 /* Do we get callbacks when the ring is completely used, even if we've
@@ -71,4 +71,7 @@
  * this is for compatibility with legacy systems.
  */
 #define VIRTIO_F_IOMMU_PLATFORM		33
+
+/* This feature indicates support for the packed virtqueue layout. */
+#define VIRTIO_F_RING_PACKED		34
 #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */
diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
index 6d5d5faa989b..3932cb80c347 100644
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
@@ -53,6 +56,10 @@
  * optimization.  */
 #define VRING_AVAIL_F_NO_INTERRUPT	1
 
+#define VRING_EVENT_F_ENABLE	0x0
+#define VRING_EVENT_F_DISABLE	0x1
+#define VRING_EVENT_F_DESC	0x2
+
 /* We support indirect buffer descriptors */
 #define VIRTIO_RING_F_INDIRECT_DESC	28
 
@@ -171,4 +178,33 @@ static inline int vring_need_event(__u16 event_idx, __u16 new_idx, __u16 old)
 	return (__u16)(new_idx - event_idx - 1) < (__u16)(new_idx - old);
 }
 
+struct vring_packed_desc_event {
+	/* __virtio16 off  : 15; // Descriptor Event Offset
+	 * __virtio16 wrap : 1;  // Descriptor Event Wrap Counter */
+	__virtio16 off_wrap;
+	/* __virtio16 flags : 2; // Descriptor Event Flags */
+	__virtio16 flags;
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
 #endif /* _UAPI_LINUX_VIRTIO_RING_H */
-- 
2.17.0
