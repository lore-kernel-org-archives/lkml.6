Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966584AbeBNCr2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 21:47:28 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56338 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966382AbeBNCr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 21:47:27 -0500
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: wexu@redhat.com, jfreimann@redhat.com, tiwei.bie@intel.com,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH RFC 1/2] virtio: introduce packed ring defines
Date: Wed, 14 Feb 2018 10:37:08 +0800
Message-Id: <1518575829-1431-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1518575829-1431-1-git-send-email-jasowang@redhat.com>
References: <1518575829-1431-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/uapi/linux/virtio_config.h |  9 +++++++++
 include/uapi/linux/virtio_ring.h   | 17 +++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index 308e209..5903d51 100644
--- a/include/uapi/linux/virtio_config.h
+++ b/include/uapi/linux/virtio_config.h
@@ -71,4 +71,13 @@
  * this is for compatibility with legacy systems.
  */
 #define VIRTIO_F_IOMMU_PLATFORM		33
+
+#define VIRTIO_F_RING_PACKED		34
+
+/*
+ * This feature indicates that all buffers are used by the device in
+ * the same order in which they have been made available.
+ */
+#define VIRTIO_F_IN_ORDER		35
+
 #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */
diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
index 6d5d5fa..a169b53 100644
--- a/include/uapi/linux/virtio_ring.h
+++ b/include/uapi/linux/virtio_ring.h
@@ -43,6 +43,8 @@
 #define VRING_DESC_F_WRITE	2
 /* This means the buffer contains a list of buffer descriptors. */
 #define VRING_DESC_F_INDIRECT	4
+#define VRING_DESC_F_AVAIL      7
+#define VRING_DESC_F_USED	15
 
 /* The Host uses this in used->flags to advise the Guest: don't kick me when
  * you add a buffer.  It's unreliable, so it's simply an optimization.  Guest
@@ -62,6 +64,17 @@
  * at the end of the used ring. Guest should ignore the used->flags field. */
 #define VIRTIO_RING_F_EVENT_IDX		29
 
+struct vring_desc_packed {
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
 /* Virtio ring descriptors: 16 bytes.  These can chain together via "next". */
 struct vring_desc {
 	/* Address (guest-physical). */
@@ -86,6 +99,10 @@ struct vring_used_elem {
 	__virtio32 id;
 	/* Total length of the descriptor chain which was used (written to) */
 	__virtio32 len;
+	/* Index of the descriptor that needs to write, used by packed ring. */
+	u16 idx;
+	/* Wrap counter for this used desc, used by packed ring. */
+	bool wrap_counter;
 };
 
 struct vring_used {
-- 
2.7.4
