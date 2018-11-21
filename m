Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A212C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB1F220684
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB1F220684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbeKUUjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:39:40 -0500
Received: from mga18.intel.com ([134.134.136.126]:14789 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729792AbeKUUjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:39:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2018 02:05:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,260,1539673200"; 
   d="scan'208";a="275727123"
Received: from btwcube1.sh.intel.com ([10.67.104.173])
  by orsmga005.jf.intel.com with ESMTP; 21 Nov 2018 02:05:48 -0800
From:   Tiwei Bie <tiwei.bie@intel.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org
Cc:     wexu@redhat.com, jfreimann@redhat.com, maxime.coquelin@redhat.com,
        tiwei.bie@intel.com
Subject: [PATCH net-next v3 12/13] virtio_ring: disable packed ring on unsupported transports
Date:   Wed, 21 Nov 2018 18:03:29 +0800
Message-Id: <20181121100330.24846-13-tiwei.bie@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181121100330.24846-1-tiwei.bie@intel.com>
References: <20181121100330.24846-1-tiwei.bie@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, ccw, vop and remoteproc need some legacy virtio
APIs to create or access virtio rings, which are not supported
by packed ring. So disable packed ring on these transports
for now.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 drivers/misc/mic/vop/vop_main.c        | 13 +++++++++++++
 drivers/remoteproc/remoteproc_virtio.c | 13 +++++++++++++
 drivers/s390/virtio/virtio_ccw.c       | 14 ++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
index 3633202e18f4..6b212c8b78e7 100644
--- a/drivers/misc/mic/vop/vop_main.c
+++ b/drivers/misc/mic/vop/vop_main.c
@@ -129,6 +129,16 @@ static u64 vop_get_features(struct virtio_device *vdev)
 	return features;
 }
 
+static void vop_transport_features(struct virtio_device *vdev)
+{
+	/*
+	 * Packed ring isn't enabled on virtio_vop for now,
+	 * because virtio_vop uses vring_new_virtqueue() which
+	 * creates virtio rings on preallocated memory.
+	 */
+	__virtio_clear_bit(vdev, VIRTIO_F_RING_PACKED);
+}
+
 static int vop_finalize_features(struct virtio_device *vdev)
 {
 	unsigned int i, bits;
@@ -141,6 +151,9 @@ static int vop_finalize_features(struct virtio_device *vdev)
 	/* Give virtio_ring a chance to accept features. */
 	vring_transport_features(vdev);
 
+	/* Give virtio_vop a chance to accept features. */
+	vop_transport_features(vdev);
+
 	memset_io(out_features, 0, feature_len);
 	bits = min_t(unsigned, feature_len,
 		     sizeof(vdev->features)) * 8;
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index de21f620b882..183fc42a510a 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -214,6 +214,16 @@ static u64 rproc_virtio_get_features(struct virtio_device *vdev)
 	return rsc->dfeatures;
 }
 
+static void rproc_transport_features(struct virtio_device *vdev)
+{
+	/*
+	 * Packed ring isn't enabled on remoteproc for now,
+	 * because remoteproc uses vring_new_virtqueue() which
+	 * creates virtio rings on preallocated memory.
+	 */
+	__virtio_clear_bit(vdev, VIRTIO_F_RING_PACKED);
+}
+
 static int rproc_virtio_finalize_features(struct virtio_device *vdev)
 {
 	struct rproc_vdev *rvdev = vdev_to_rvdev(vdev);
@@ -224,6 +234,9 @@ static int rproc_virtio_finalize_features(struct virtio_device *vdev)
 	/* Give virtio_ring a chance to accept features */
 	vring_transport_features(vdev);
 
+	/* Give virtio_rproc a chance to accept features. */
+	rproc_transport_features(vdev);
+
 	/* Make sure we don't have any features > 32 bits! */
 	BUG_ON((u32)vdev->features != vdev->features);
 
diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 97b6f197f007..406d1f64ad65 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -765,6 +765,17 @@ static u64 virtio_ccw_get_features(struct virtio_device *vdev)
 	return rc;
 }
 
+static void ccw_transport_features(struct virtio_device *vdev)
+{
+	/*
+	 * Packed ring isn't enabled on virtio_ccw for now,
+	 * because virtio_ccw uses some legacy accessors,
+	 * e.g. virtqueue_get_avail() and virtqueue_get_used()
+	 * which aren't available in packed ring currently.
+	 */
+	__virtio_clear_bit(vdev, VIRTIO_F_RING_PACKED);
+}
+
 static int virtio_ccw_finalize_features(struct virtio_device *vdev)
 {
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
@@ -791,6 +802,9 @@ static int virtio_ccw_finalize_features(struct virtio_device *vdev)
 	/* Give virtio_ring a chance to accept features. */
 	vring_transport_features(vdev);
 
+	/* Give virtio_ccw a chance to accept features. */
+	ccw_transport_features(vdev);
+
 	features->index = 0;
 	features->features = cpu_to_le32((u32)vdev->features);
 	/* Write the first half of the feature bits to the host. */
-- 
2.14.5

