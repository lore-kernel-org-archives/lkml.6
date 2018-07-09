Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADF6C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DCFB2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DCFB2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932528AbeGIHXD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 03:23:03 -0400
Received: from mga01.intel.com ([192.55.52.88]:9390 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932419AbeGIHXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 03:23:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2018 00:23:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,329,1526367600"; 
   d="scan'208";a="71129700"
Received: from debian.sh.intel.com ([10.67.104.228])
  by orsmga001.jf.intel.com with ESMTP; 09 Jul 2018 00:22:58 -0700
From:   Tiwei Bie <tiwei.bie@intel.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org
Cc:     wexu@redhat.com, jfreimann@redhat.com, tiwei.bie@intel.com
Subject: [PATCH net-next v1 1/5] virtio: add packed ring definitions
Date:   Mon,  9 Jul 2018 15:22:37 +0800
Message-Id: <20180709072241.8886-2-tiwei.bie@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180709072241.8886-1-tiwei.bie@intel.com>
References: <20180709072241.8886-1-tiwei.bie@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 include/uapi/linux/virtio_config.h |  3 +++
 include/uapi/linux/virtio_ring.h   | 43 ++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index 449132c76b1c..1196e1c1d4f6 100644
--- a/include/uapi/linux/virtio_config.h
+++ b/include/uapi/linux/virtio_config.h
@@ -75,6 +75,9 @@
  */
 #define VIRTIO_F_IOMMU_PLATFORM		33
 
+/* This feature indicates support for the packed virtqueue layout. */
+#define VIRTIO_F_RING_PACKED		34
+
 /*
  * Does the device support Single Root I/O Virtualization?
  */
diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
index 6d5d5faa989b..0254a2ba29cf 100644
--- a/include/uapi/linux/virtio_ring.h
+++ b/include/uapi/linux/virtio_ring.h
@@ -44,6 +44,10 @@
 /* This means the buffer contains a list of buffer descriptors. */
 #define VRING_DESC_F_INDIRECT	4
 
+/* Mark a descriptor as available or used. */
+#define VRING_DESC_F_AVAIL	(1ul << 7)
+#define VRING_DESC_F_USED	(1ul << 15)
+
 /* The Host uses this in used->flags to advise the Guest: don't kick me when
  * you add a buffer.  It's unreliable, so it's simply an optimization.  Guest
  * will still kick if it's out of buffers. */
@@ -53,6 +57,17 @@
  * optimization.  */
 #define VRING_AVAIL_F_NO_INTERRUPT	1
 
+/* Enable events. */
+#define VRING_EVENT_F_ENABLE	0x0
+/* Disable events. */
+#define VRING_EVENT_F_DISABLE	0x1
+/*
+ * Enable events for a specific descriptor
+ * (as specified by Descriptor Ring Change Event Offset/Wrap Counter).
+ * Only valid if VIRTIO_RING_F_EVENT_IDX has been negotiated.
+ */
+#define VRING_EVENT_F_DESC	0x2
+
 /* We support indirect buffer descriptors */
 #define VIRTIO_RING_F_INDIRECT_DESC	28
 
@@ -171,4 +186,32 @@ static inline int vring_need_event(__u16 event_idx, __u16 new_idx, __u16 old)
 	return (__u16)(new_idx - event_idx - 1) < (__u16)(new_idx - old);
 }
 
+struct vring_packed_desc_event {
+	/* Descriptor Ring Change Event Offset/Wrap Counter. */
+	__virtio16 off_wrap;
+	/* Descriptor Ring Change Event Flags. */
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
2.18.0

