Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D96C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B8F2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B8F2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932695AbeGIHXL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 03:23:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:9390 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932632AbeGIHXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 03:23:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2018 00:23:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,329,1526367600"; 
   d="scan'208";a="71129740"
Received: from debian.sh.intel.com ([10.67.104.228])
  by orsmga001.jf.intel.com with ESMTP; 09 Jul 2018 00:23:05 -0700
From:   Tiwei Bie <tiwei.bie@intel.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org
Cc:     wexu@redhat.com, jfreimann@redhat.com, tiwei.bie@intel.com
Subject: [PATCH net-next v1 5/5] virtio_ring: enable packed ring
Date:   Mon,  9 Jul 2018 15:22:41 +0800
Message-Id: <20180709072241.8886-6-tiwei.bie@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180709072241.8886-1-tiwei.bie@intel.com>
References: <20180709072241.8886-1-tiwei.bie@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 drivers/s390/virtio/virtio_ccw.c | 8 ++++++++
 drivers/virtio/virtio_ring.c     | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 8f5c1d7f751a..ff5b85736d8d 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -765,6 +765,11 @@ static u64 virtio_ccw_get_features(struct virtio_device *vdev)
 	return rc;
 }
 
+static void ccw_transport_features(struct virtio_device *vdev)
+{
+	__virtio_clear_bit(vdev, VIRTIO_F_RING_PACKED);
+}
+
 static int virtio_ccw_finalize_features(struct virtio_device *vdev)
 {
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
@@ -791,6 +796,9 @@ static int virtio_ccw_finalize_features(struct virtio_device *vdev)
 	/* Give virtio_ring a chance to accept features. */
 	vring_transport_features(vdev);
 
+	/* Give virtio_ccw a chance to accept features. */
+	ccw_transport_features(vdev);
+
 	features->index = 0;
 	features->features = cpu_to_le32((u32)vdev->features);
 	/* Write the first half of the feature bits to the host. */
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 4b3f9e1a3cab..64f20023f088 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1968,6 +1968,8 @@ void vring_transport_features(struct virtio_device *vdev)
 			break;
 		case VIRTIO_F_IOMMU_PLATFORM:
 			break;
+		case VIRTIO_F_RING_PACKED:
+			break;
 		default:
 			/* We don't understand this bit. */
 			__virtio_clear_bit(vdev, i);
-- 
2.18.0

