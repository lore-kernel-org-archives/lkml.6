Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0B9C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7681E21479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7681E21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbeKUUjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:39:33 -0500
Received: from mga18.intel.com ([134.134.136.126]:14789 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729792AbeKUUjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:39:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2018 02:05:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,260,1539673200"; 
   d="scan'208";a="275727086"
Received: from btwcube1.sh.intel.com ([10.67.104.173])
  by orsmga005.jf.intel.com with ESMTP; 21 Nov 2018 02:05:41 -0800
From:   Tiwei Bie <tiwei.bie@intel.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org
Cc:     wexu@redhat.com, jfreimann@redhat.com, maxime.coquelin@redhat.com,
        tiwei.bie@intel.com
Subject: [PATCH net-next v3 09/13] virtio_ring: cache whether we will use DMA API
Date:   Wed, 21 Nov 2018 18:03:26 +0800
Message-Id: <20181121100330.24846-10-tiwei.bie@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181121100330.24846-1-tiwei.bie@intel.com>
References: <20181121100330.24846-1-tiwei.bie@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cache whether we will use DMA API, instead of doing the
check every time. We are going to check whether DMA API
is used more often in packed ring.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 drivers/virtio/virtio_ring.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index d00a87909a7e..aafe1969b45e 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -86,6 +86,9 @@ struct vring_desc_state_split {
 struct vring_virtqueue {
 	struct virtqueue vq;
 
+	/* Is DMA API used? */
+	bool use_dma_api;
+
 	/* Can we use weak barriers? */
 	bool weak_barriers;
 
@@ -262,7 +265,7 @@ static dma_addr_t vring_map_one_sg(const struct vring_virtqueue *vq,
 				   struct scatterlist *sg,
 				   enum dma_data_direction direction)
 {
-	if (!vring_use_dma_api(vq->vq.vdev))
+	if (!vq->use_dma_api)
 		return (dma_addr_t)sg_phys(sg);
 
 	/*
@@ -279,7 +282,7 @@ static dma_addr_t vring_map_single(const struct vring_virtqueue *vq,
 				   void *cpu_addr, size_t size,
 				   enum dma_data_direction direction)
 {
-	if (!vring_use_dma_api(vq->vq.vdev))
+	if (!vq->use_dma_api)
 		return (dma_addr_t)virt_to_phys(cpu_addr);
 
 	return dma_map_single(vring_dma_dev(vq),
@@ -289,7 +292,7 @@ static dma_addr_t vring_map_single(const struct vring_virtqueue *vq,
 static int vring_mapping_error(const struct vring_virtqueue *vq,
 			       dma_addr_t addr)
 {
-	if (!vring_use_dma_api(vq->vq.vdev))
+	if (!vq->use_dma_api)
 		return 0;
 
 	return dma_mapping_error(vring_dma_dev(vq), addr);
@@ -305,7 +308,7 @@ static void vring_unmap_one_split(const struct vring_virtqueue *vq,
 {
 	u16 flags;
 
-	if (!vring_use_dma_api(vq->vq.vdev))
+	if (!vq->use_dma_api)
 		return;
 
 	flags = virtio16_to_cpu(vq->vq.vdev, desc->flags);
@@ -1202,6 +1205,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	vq->broken = false;
 	vq->last_used_idx = 0;
 	vq->num_added = 0;
+	vq->use_dma_api = vring_use_dma_api(vdev);
 	list_add_tail(&vq->vq.list, &vdev->vqs);
 #ifdef DEBUG
 	vq->in_use = false;
-- 
2.14.5

