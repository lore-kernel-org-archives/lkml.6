Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754102AbeDWFft (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 01:35:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50414 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754027AbeDWFfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 01:35:38 -0400
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        tiwei.bie@intel.com, jfreimann@redhat.com, wexu@redhat.com
Subject: [RFC V3 PATCH 6/8] virtio: introduce packed ring defines
Date: Mon, 23 Apr 2018 13:34:58 +0800
Message-Id: <1524461700-5469-7-git-send-email-jasowang@redhat.com>
In-Reply-To: <1524461700-5469-1-git-send-email-jasowang@redhat.com>
References: <1524461700-5469-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/uapi/linux/virtio_config.h |  9 +++++++++
 include/uapi/linux/virtio_ring.h   | 13 +++++++++++++
 2 files changed, 22 insertions(+)

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
index 6d5d5fa..e297580 100644
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
-- 
2.7.4
