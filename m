Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD9DC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B16E2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731949AbfA3Q20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:28:26 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:39536 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbfA3Q20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:28:26 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 1E81B18490;
        Wed, 30 Jan 2019 17:28:24 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id bOrrqYrt9cTy; Wed, 30 Jan 2019 17:28:22 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bastet.se.axis.com (Postfix) with ESMTPS id BCB08184E5;
        Wed, 30 Jan 2019 17:28:22 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A21881A062;
        Wed, 30 Jan 2019 17:28:22 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95EFC1A061;
        Wed, 30 Jan 2019 17:28:22 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Wed, 30 Jan 2019 17:28:22 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by seth.se.axis.com (Postfix) with ESMTP id 88648230D;
        Wed, 30 Jan 2019 17:28:22 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 850F980C3B; Wed, 30 Jan 2019 17:28:22 +0100 (CET)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, tiwei.bie@intel.com,
        luto@kernel.org, Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH v2] mic: vop: Fix broken virtqueues
Date:   Wed, 30 Jan 2019 17:28:09 +0100
Message-Id: <20190130162809.14620-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VOP is broken in mainline since commit 1ce9e6055fa0a9043 ("virtio_ring:
introduce packed ring support"); attempting to use the virtqueues leads
to various kernel crashes.  I'm testing it with my not-yet-merged
loopback patches, but even the in-tree MIC hardware cannot work.

The problem is not in the referenced commit per se, but is due to the
following hack in vop_find_vq() which depends on the layout of private
structures in other source files, which that commit happened to change:

  /*
   * To reassign the used ring here we are directly accessing
   * struct vring_virtqueue which is a private data structure
   * in virtio_ring.c. At the minimum, a BUILD_BUG_ON() in
   * vring_new_virtqueue() would ensure that
   *  (&vq->vring == (struct vring *) (&vq->vq + 1));
   */
  vr = (struct vring *)(vq + 1);
  vr->used = used;

Fix vop by using __vring_new_virtqueue() to create the needed vring
layout from the start, instead of attempting to patch in the used ring
later.  __vring_new_virtqueue() was added way back in commit
2a2d1382fe9dcc ("virtio: Add improved queue allocation API") in order to
address mic's usecase, according to the commit message.

The removal patch also has the hack and we need to save the used ring
pointer separately to remove it.

Fixes: 1ce9e6055fa0 ("virtio_ring: introduce packed ring support")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
v2: fix removal path also

 drivers/misc/mic/vop/vop_main.c | 69 +++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 29 deletions(-)

diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
index b60b5ec4a28a..c4517703dc1d 100644
--- a/drivers/misc/mic/vop/vop_main.c
+++ b/drivers/misc/mic/vop/vop_main.c
@@ -48,7 +48,8 @@
  * @dc: Virtio device control
  * @vpdev: VOP device which is the parent for this virtio device
  * @vr: Buffer for accessing the VRING
- * @used: Buffer for used
+ * @used_virt: Virtual address of used ring
+ * @used: DMA address of used ring
  * @used_size: Size of the used buffer
  * @reset_done: Track whether VOP reset is complete
  * @virtio_cookie: Cookie returned upon requesting a interrupt
@@ -62,6 +63,7 @@ struct _vop_vdev {
 	struct mic_device_ctrl __iomem *dc;
 	struct vop_device *vpdev;
 	void __iomem *vr[VOP_MAX_VRINGS];
+	void *used_virt[VOP_MAX_VRINGS];
 	dma_addr_t used[VOP_MAX_VRINGS];
 	int used_size[VOP_MAX_VRINGS];
 	struct completion reset_done;
@@ -261,12 +263,12 @@ static bool vop_notify(struct virtqueue *vq)
 static void vop_del_vq(struct virtqueue *vq, int n)
 {
 	struct _vop_vdev *vdev = to_vopvdev(vq->vdev);
-	struct vring *vr = (struct vring *)(vq + 1);
 	struct vop_device *vpdev = vdev->vpdev;
 
 	dma_unmap_single(&vpdev->dev, vdev->used[n],
 			 vdev->used_size[n], DMA_BIDIRECTIONAL);
-	free_pages((unsigned long)vr->used, get_order(vdev->used_size[n]));
+	free_pages((unsigned long)vdev->used_virt[n],
+		   get_order(vdev->used_size[n]));
 	vring_del_virtqueue(vq);
 	vpdev->hw_ops->unmap(vpdev, vdev->vr[n]);
 	vdev->vr[n] = NULL;
@@ -284,6 +286,26 @@ static void vop_del_vqs(struct virtio_device *dev)
 		vop_del_vq(vq, idx++);
 }
 
+static struct virtqueue *vop_new_virtqueue(unsigned int index,
+				      unsigned int num,
+				      struct virtio_device *vdev,
+				      bool context,
+				      void *pages,
+				      bool (*notify)(struct virtqueue *vq),
+				      void (*callback)(struct virtqueue *vq),
+				      const char *name,
+				      void *used)
+{
+	bool weak_barriers = false;
+	struct vring vring;
+
+	vring_init(&vring, num, pages, MIC_VIRTIO_RING_ALIGN);
+	vring.used = used;
+
+	return __vring_new_virtqueue(index, vring, vdev, weak_barriers, context,
+				     notify, callback, name);
+}
+
 /*
  * This routine will assign vring's allocated in host/io memory. Code in
  * virtio_ring.c however continues to access this io memory as if it were local
@@ -303,7 +325,6 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
 	struct _mic_vring_info __iomem *info;
 	void *used;
 	int vr_size, _vr_size, err, magic;
-	struct vring *vr;
 	u8 type = ioread8(&vdev->desc->type);
 
 	if (index >= ioread8(&vdev->desc->num_vq))
@@ -322,17 +343,7 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
 		return ERR_PTR(-ENOMEM);
 	vdev->vr[index] = va;
 	memset_io(va, 0x0, _vr_size);
-	vq = vring_new_virtqueue(
-				index,
-				le16_to_cpu(config.num), MIC_VIRTIO_RING_ALIGN,
-				dev,
-				false,
-				ctx,
-				(void __force *)va, vop_notify, callback, name);
-	if (!vq) {
-		err = -ENOMEM;
-		goto unmap;
-	}
+
 	info = va + _vr_size;
 	magic = ioread32(&info->magic);
 
@@ -341,18 +352,27 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
 		goto unmap;
 	}
 
-	/* Allocate and reassign used ring now */
 	vdev->used_size[index] = PAGE_ALIGN(sizeof(__u16) * 3 +
 					     sizeof(struct vring_used_elem) *
 					     le16_to_cpu(config.num));
 	used = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
 					get_order(vdev->used_size[index]));
+	vdev->used_virt[index] = used;
 	if (!used) {
 		err = -ENOMEM;
 		dev_err(_vop_dev(vdev), "%s %d err %d\n",
 			__func__, __LINE__, err);
-		goto del_vq;
+		goto unmap;
+	}
+
+	vq = vop_new_virtqueue(index, le16_to_cpu(config.num), dev, ctx,
+			       (void __force *)va, vop_notify, callback,
+			       name, used);
+	if (!vq) {
+		err = -ENOMEM;
+		goto free_used;
 	}
+
 	vdev->used[index] = dma_map_single(&vpdev->dev, used,
 					    vdev->used_size[index],
 					    DMA_BIDIRECTIONAL);
@@ -360,26 +380,17 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
 		err = -ENOMEM;
 		dev_err(_vop_dev(vdev), "%s %d err %d\n",
 			__func__, __LINE__, err);
-		goto free_used;
+		goto del_vq;
 	}
 	writeq(vdev->used[index], &vqconfig->used_address);
-	/*
-	 * To reassign the used ring here we are directly accessing
-	 * struct vring_virtqueue which is a private data structure
-	 * in virtio_ring.c. At the minimum, a BUILD_BUG_ON() in
-	 * vring_new_virtqueue() would ensure that
-	 *  (&vq->vring == (struct vring *) (&vq->vq + 1));
-	 */
-	vr = (struct vring *)(vq + 1);
-	vr->used = used;
 
 	vq->priv = vdev;
 	return vq;
+del_vq:
+	vring_del_virtqueue(vq);
 free_used:
 	free_pages((unsigned long)used,
 		   get_order(vdev->used_size[index]));
-del_vq:
-	vring_del_virtqueue(vq);
 unmap:
 	vpdev->hw_ops->unmap(vpdev, vdev->vr[index]);
 	return ERR_PTR(err);
-- 
2.20.0

