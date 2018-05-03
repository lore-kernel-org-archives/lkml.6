Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752073AbeECC7T (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 22:59:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:63857 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751993AbeECC7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 22:59:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,356,1520924400";
   d="scan'208";a="38273855"
From: Tiwei Bie <tiwei.bie@intel.com>
To: mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc: dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
Subject: [RFC] virtio: support VIRTIO_F_IO_BARRIER
Date: Thu,  3 May 2018 10:59:55 +0800
Message-Id: <20180503025955.28816-1-tiwei.bie@intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the support for VIRTIO_F_IO_BARRIER.
When this feature is negotiated, driver will use the barriers
suitable for hardware devices.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 drivers/virtio/virtio_ring.c       | 5 +++++
 include/uapi/linux/virtio_config.h | 8 +++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 21d464a29cf8..edb565643bf4 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -996,6 +996,9 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 		!context;
 	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
 
+	if (virtio_has_feature(vdev, VIRTIO_F_IO_BARRIER))
+		vq->weak_barriers = false;
+
 	/* No callback?  Tell other side not to bother us. */
 	if (!callback) {
 		vq->avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
@@ -1164,6 +1167,8 @@ void vring_transport_features(struct virtio_device *vdev)
 			break;
 		case VIRTIO_F_IOMMU_PLATFORM:
 			break;
+		case VIRTIO_F_IO_BARRIER:
+			break;
 		default:
 			/* We don't understand this bit. */
 			__virtio_clear_bit(vdev, i);
diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index 308e2096291f..6ca8d24bf468 100644
--- a/include/uapi/linux/virtio_config.h
+++ b/include/uapi/linux/virtio_config.h
@@ -49,7 +49,7 @@
  * transport being used (eg. virtio_ring), the rest are per-device feature
  * bits. */
 #define VIRTIO_TRANSPORT_F_START	28
-#define VIRTIO_TRANSPORT_F_END		34
+#define VIRTIO_TRANSPORT_F_END		38
 
 #ifndef VIRTIO_CONFIG_NO_LEGACY
 /* Do we get callbacks when the ring is completely used, even if we've
@@ -71,4 +71,10 @@
  * this is for compatibility with legacy systems.
  */
 #define VIRTIO_F_IOMMU_PLATFORM		33
+
+/*
+ * If clear - driver may use barriers suitable for CPU cores.
+ * If set - driver must use barriers suitable for hardware devices.
+ */
+#define VIRTIO_F_IO_BARRIER		37
 #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */
-- 
2.11.0
