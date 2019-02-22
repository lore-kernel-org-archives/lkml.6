Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EC6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD692075A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfBVPbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:31:34 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:45368 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbfBVPbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:31:32 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 9475618685;
        Fri, 22 Feb 2019 16:31:30 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id O4EZt4Rb8QsF; Fri, 22 Feb 2019 16:31:22 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id 9AF0618547;
        Fri, 22 Feb 2019 16:31:21 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6AB881E070;
        Fri, 22 Feb 2019 16:31:21 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EBD81E066;
        Fri, 22 Feb 2019 16:31:21 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Fri, 22 Feb 2019 16:31:21 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by thoth.se.axis.com (Postfix) with ESMTP id 522CA2048;
        Fri, 22 Feb 2019 16:31:21 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 506BE80DC0; Fri, 22 Feb 2019 16:31:21 +0100 (CET)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH v2 char-misc-next 5/7] mic: vop: Fix init race with shared interrupts
Date:   Fri, 22 Feb 2019 16:30:54 +0100
Message-Id: <20190222153056.18878-9-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190222153056.18878-1-vincent.whitchurch@axis.com>
References: <20190222153056.18878-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a vop virtio device's interrupt is shared with others, there is a
window where the interrupt can hit and the ->vqs list can be attempted
to be traversed before register_virtio_device() has initialized it,
leading to a NULL pointer dereference in vop_virtio_intr_handler().

Fix this by keeping a local list of virtqueues in this driver and using
that instead of the list inside the struct virtio_device, similar to how
virtio-pci handles this.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/misc/mic/vop/vop_main.c | 42 ++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
index e37b2c2152a2..6764feea6f55 100644
--- a/drivers/misc/mic/vop/vop_main.c
+++ b/drivers/misc/mic/vop/vop_main.c
@@ -40,6 +40,11 @@
 
 #define VOP_MAX_VRINGS 4
 
+struct vop_vq {
+	struct virtqueue *vq;
+	struct list_head list;
+};
+
 /*
  * _vop_vdev - Allocated per virtio device instance injected by the peer.
  *
@@ -68,6 +73,9 @@ struct _vop_vdev {
 	int used_size[VOP_MAX_VRINGS];
 	struct completion reset_done;
 	struct mic_irq *virtio_cookie;
+	struct vop_vq *vqs;
+	struct list_head virtqueues;
+	spinlock_t virtqueues_lock;
 	int c2h_vdev_db;
 	int h2c_vdev_db;
 	int dnode;
@@ -264,6 +272,12 @@ static void vop_del_vq(struct virtqueue *vq, int n)
 {
 	struct _vop_vdev *vdev = to_vopvdev(vq->vdev);
 	struct vop_device *vpdev = vdev->vpdev;
+	struct vop_vq *vopvq = &vdev->vqs[n];
+	unsigned long flags;
+
+	spin_lock_irqsave(&vdev->virtqueues_lock, flags);
+	list_del(&vopvq->list);
+	spin_unlock_irqrestore(&vdev->virtqueues_lock, flags);
 
 	dma_unmap_single(&vpdev->dev, vdev->used[n],
 			 vdev->used_size[n], DMA_BIDIRECTIONAL);
@@ -284,6 +298,9 @@ static void vop_del_vqs(struct virtio_device *dev)
 
 	list_for_each_entry_safe(vq, n, &dev->vqs, list)
 		vop_del_vq(vq, idx++);
+
+	kfree(vdev->vqs);
+	vdev->vqs = NULL;
 }
 
 static struct virtqueue *vop_new_virtqueue(unsigned int index,
@@ -411,7 +428,13 @@ static int vop_find_vqs(struct virtio_device *dev, unsigned nvqs,
 	if (nvqs > ioread8(&vdev->desc->num_vq))
 		return -ENOENT;
 
+	vdev->vqs = kcalloc(nvqs, sizeof(*vdev->vqs), GFP_KERNEL);
+	if (!vdev->vqs)
+		return -ENOMEM;
+
 	for (i = 0; i < nvqs; ++i) {
+		unsigned long flags;
+
 		if (!names[i]) {
 			vqs[i] = NULL;
 			continue;
@@ -425,6 +448,12 @@ static int vop_find_vqs(struct virtio_device *dev, unsigned nvqs,
 			err = PTR_ERR(vqs[i]);
 			goto error;
 		}
+
+		vdev->vqs[i].vq = vqs[i];
+
+		spin_lock_irqsave(&vdev->virtqueues_lock, flags);
+		list_add(&vdev->vqs[i].list, &vdev->virtqueues);
+		spin_unlock_irqrestore(&vdev->virtqueues_lock, flags);
 	}
 
 	iowrite8(1, &dc->used_address_updated);
@@ -468,13 +497,17 @@ static struct virtio_config_ops vop_vq_config_ops = {
 
 static irqreturn_t vop_virtio_intr_handler(int irq, void *data)
 {
+	unsigned long flags;
 	struct _vop_vdev *vdev = data;
 	struct vop_device *vpdev = vdev->vpdev;
-	struct virtqueue *vq;
+	struct vop_vq *vopvq;
 
 	vpdev->hw_ops->ack_interrupt(vpdev, vdev->h2c_vdev_db);
-	list_for_each_entry(vq, &vdev->vdev.vqs, list)
-		vring_interrupt(0, vq);
+
+	spin_lock_irqsave(&vdev->virtqueues_lock, flags);
+	list_for_each_entry(vopvq, &vdev->virtqueues, list)
+		vring_interrupt(0, vopvq->vq);
+	spin_unlock_irqrestore(&vdev->virtqueues_lock, flags);
 
 	return IRQ_HANDLED;
 }
@@ -516,6 +549,9 @@ static int _vop_add_device(struct mic_device_desc __iomem *d,
 	vdev->vdev.priv = (void *)(unsigned long)dnode;
 	init_completion(&vdev->reset_done);
 
+	INIT_LIST_HEAD(&vdev->virtqueues);
+	spin_lock_init(&vdev->virtqueues_lock);
+
 	vdev->h2c_vdev_db = vpdev->hw_ops->next_db(vpdev);
 	vdev->virtio_cookie = vpdev->hw_ops->request_irq(vpdev,
 			vop_virtio_intr_handler, "virtio intr",
-- 
2.20.0

