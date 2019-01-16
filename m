Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251ACC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C643420657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405752AbfAPQdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:33:09 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:42719 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405731AbfAPQdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:33:06 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id ED59718511;
        Wed, 16 Jan 2019 17:33:04 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id KJ6wtmplNcG0; Wed, 16 Jan 2019 17:33:00 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id 4CD4F1855C;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C0B51E06E;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D4701E076;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by seth.se.axis.com (Postfix) with ESMTP id 0BDC72FB6;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 0A49A80B46; Wed, 16 Jan 2019 17:32:58 +0100 (CET)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH 7/8] vop: Use consistent DMA
Date:   Wed, 16 Jan 2019 17:32:52 +0100
Message-Id: <20190116163253.23780-8-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190116163253.23780-1-vincent.whitchurch@axis.com>
References: <20190116163253.23780-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vop code maps buffers using the streaming DMA API but never syncs
them so it doesn't work on systems without cache coherence.  The vrings
want consistent mappings, and not streaming mappings so use that API to
allocate and map buffers.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/misc/mic/bus/vop_bus.h    |   2 +
 drivers/misc/mic/host/mic_boot.c  |  46 +++++++++++++
 drivers/misc/mic/vop/vop_main.c   |  23 ++-----
 drivers/misc/mic/vop/vop_vringh.c | 111 ++++++++++++++++--------------
 4 files changed, 114 insertions(+), 68 deletions(-)

diff --git a/drivers/misc/mic/bus/vop_bus.h b/drivers/misc/mic/bus/vop_bus.h
index fff7a865d721..a2db11bea277 100644
--- a/drivers/misc/mic/bus/vop_bus.h
+++ b/drivers/misc/mic/bus/vop_bus.h
@@ -86,6 +86,7 @@ struct vop_driver {
  *                 node to add/remove/configure virtio devices.
  * @get_dp: Get access to the virtio device page used by the self
  *          node to add/remove/configure virtio devices.
+ * @get_dp_dma: Get DMA address of the virtio device page.
  * @send_intr: Send an interrupt to the peer node on a specified doorbell.
  * @ioremap: Map a buffer with the specified DMA address and length.
  * @iounmap: Unmap a buffer previously mapped.
@@ -103,6 +104,7 @@ struct vop_hw_ops {
 	void (*ack_interrupt)(struct vop_device *vpdev, int num);
 	void __iomem * (*get_remote_dp)(struct vop_device *vpdev);
 	void * (*get_dp)(struct vop_device *vpdev);
+	dma_addr_t (*get_dp_dma)(struct vop_device *vpdev);
 	void (*send_intr)(struct vop_device *vpdev, int db);
 	void __iomem * (*ioremap)(struct vop_device *vpdev,
 				  dma_addr_t pa, size_t len);
diff --git a/drivers/misc/mic/host/mic_boot.c b/drivers/misc/mic/host/mic_boot.c
index 6479435ac96b..1dcd25917eca 100644
--- a/drivers/misc/mic/host/mic_boot.c
+++ b/drivers/misc/mic/host/mic_boot.c
@@ -55,9 +55,47 @@ static void _mic_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
 	mic_unmap_single(mdev, dma_addr, size);
 }
 
+static int _mic_dma_mmap(struct device *dev, struct vm_area_struct *vma,
+		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		 unsigned long attrs)
+{
+	return remap_pfn_range(vma, vma->vm_start,
+			       virt_to_pfn(cpu_addr), size,
+			       vma->vm_page_prot);
+}
+
+static void *_mic_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
+		    gfp_t gfp, unsigned long attrs)
+{
+	void *cpu_addr = (void *) __get_free_pages(gfp, get_order(size));
+	dma_addr_t dma_addr;
+
+	if (!cpu_addr)
+		return NULL;
+
+	*handle = dma_map_single(dev, p, size, attrs);
+	if (dma_mapping_error(dev, *handle)) {
+		free_pages((unsigned long) (uintptr_t) cpu_addr,
+			   get_order(size));
+		return NULL;
+	}
+
+	return cpu_addr;
+}
+
+static void _mic_dma_free(struct device *dev, size_t size, void *cpu_addr,
+		  dma_addr_t handle, unsigned long attrs)
+{
+	dma_unmap_single(dev, cpu_addr, handle, attrs);
+	free_pages((unsigned long) (uintptr_t) cpu_addr, get_order(size));
+}
+
 static const struct dma_map_ops _mic_dma_ops = {
 	.map_page = _mic_dma_map_page,
 	.unmap_page = _mic_dma_unmap_page,
+	.mmap = _mic_dma_mmap,
+	.alloc = _mic_dma_alloc,
+	.free = _mic_dma_free,
 };
 
 static struct mic_irq *
@@ -100,6 +138,13 @@ static void *__mic_get_dp(struct vop_device *vpdev)
 	return mdev->dp;
 }
 
+static void *__mic_get_dp_dma(struct vop_device *vpdev)
+{
+	struct mic_device *mdev = vpdev_to_mdev(&vpdev->dev);
+
+	return mdev->dp_dma_addr;
+}
+
 static void __iomem *__mic_get_remote_dp(struct vop_device *vpdev)
 {
 	return NULL;
@@ -131,6 +176,7 @@ static struct vop_hw_ops vop_hw_ops = {
 	.ack_interrupt = __mic_ack_interrupt,
 	.next_db = __mic_next_db,
 	.get_dp = __mic_get_dp,
+	.get_dp_dma = __mic_get_dp_dma,
 	.get_remote_dp = __mic_get_remote_dp,
 	.send_intr = __mic_send_intr,
 	.ioremap = __mic_ioremap,
diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
index dd49169ef53d..6d4a4e8993bb 100644
--- a/drivers/misc/mic/vop/vop_main.c
+++ b/drivers/misc/mic/vop/vop_main.c
@@ -264,9 +264,8 @@ static void vop_del_vq(struct virtqueue *vq, int n)
 	struct vring *vr = (struct vring *)(vq + 1);
 	struct vop_device *vpdev = vdev->vpdev;
 
-	dma_unmap_single(&vpdev->dev, vdev->used[n],
-			 vdev->used_size[n], DMA_BIDIRECTIONAL);
-	free_pages((unsigned long)vr->used, get_order(vdev->used_size[n]));
+	dma_free_wc(&vpdev->dev, vdev->used_size[n], vr->used, vdev->used[n]);
+
 	vring_del_virtqueue(vq);
 	vpdev->hw_ops->iounmap(vpdev, vdev->vr[n]);
 	vdev->vr[n] = NULL;
@@ -346,23 +345,16 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
 	vdev->used_size[index] = PAGE_ALIGN(sizeof(__u16) * 3 +
 					     sizeof(struct vring_used_elem) *
 					     le16_to_cpu(config.num));
-	used = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-					get_order(vdev->used_size[index]));
+	used = dma_alloc_wc(&vpdev->dev, vdev->used_size[index],
+			    &vdev->used[index], GFP_KERNEL | __GFP_ZERO);
+
 	if (!used) {
 		err = -ENOMEM;
 		dev_err(_vop_dev(vdev), "%s %d err %d\n",
 			__func__, __LINE__, err);
 		goto del_vq;
 	}
-	vdev->used[index] = dma_map_single(&vpdev->dev, used,
-					    vdev->used_size[index],
-					    DMA_BIDIRECTIONAL);
-	if (dma_mapping_error(&vpdev->dev, vdev->used[index])) {
-		err = -ENOMEM;
-		dev_err(_vop_dev(vdev), "%s %d err %d\n",
-			__func__, __LINE__, err);
-		goto free_used;
-	}
+
 	writeq(vdev->used[index], &vqconfig->used_address);
 	/*
 	 * To reassign the used ring here we are directly accessing
@@ -376,9 +368,6 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
 
 	vq->priv = vdev;
 	return vq;
-free_used:
-	free_pages((unsigned long)used,
-		   get_order(vdev->used_size[index]));
 del_vq:
 	vring_del_virtqueue(vq);
 unmap:
diff --git a/drivers/misc/mic/vop/vop_vringh.c b/drivers/misc/mic/vop/vop_vringh.c
index 18d6ecff1834..4b8ab0d319b0 100644
--- a/drivers/misc/mic/vop/vop_vringh.c
+++ b/drivers/misc/mic/vop/vop_vringh.c
@@ -310,9 +310,8 @@ static int vop_virtio_add_device(struct vop_vdev *vdev,
 		mutex_init(&vvr->vr_mutex);
 		vr_size = PAGE_ALIGN(vring_size(num, MIC_VIRTIO_RING_ALIGN) +
 			sizeof(struct _mic_vring_info));
-		vr->va = (void *)
-			__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-					 get_order(vr_size));
+		vr->va = dma_alloc_wc(&vpdev->dev, vr_size, &vr_addr,
+				      GFP_KERNEL | __GFP_ZERO);
 		if (!vr->va) {
 			ret = -ENOMEM;
 			dev_err(vop_dev(vdev), "%s %d err %d\n",
@@ -322,15 +321,6 @@ static int vop_virtio_add_device(struct vop_vdev *vdev,
 		vr->len = vr_size;
 		vr->info = vr->va + vring_size(num, MIC_VIRTIO_RING_ALIGN);
 		vr->info->magic = cpu_to_le32(MIC_MAGIC + vdev->virtio_id + i);
-		vr_addr = dma_map_single(&vpdev->dev, vr->va, vr_size,
-					 DMA_BIDIRECTIONAL);
-		if (dma_mapping_error(&vpdev->dev, vr_addr)) {
-			free_pages((unsigned long)vr->va, get_order(vr_size));
-			ret = -ENOMEM;
-			dev_err(vop_dev(vdev), "%s %d err %d\n",
-				__func__, __LINE__, ret);
-			goto err;
-		}
 		vqconfig[i].address = cpu_to_le64(vr_addr);
 
 		vring_init(&vr->vr, num, vr->va, MIC_VIRTIO_RING_ALIGN);
@@ -394,10 +384,8 @@ static int vop_virtio_add_device(struct vop_vdev *vdev,
 	for (j = 0; j < i; j++) {
 		struct vop_vringh *vvr = &vdev->vvr[j];
 
-		dma_unmap_single(&vpdev->dev, le64_to_cpu(vqconfig[j].address),
-				 vvr->vring.len, DMA_BIDIRECTIONAL);
-		free_pages((unsigned long)vvr->vring.va,
-			   get_order(vvr->vring.len));
+		dma_free_wc(&vpdev->dev, vvr->vring.len, vvr->vring.va,
+			    le64_to_cpu(vqconfig[j].address));
 	}
 	return ret;
 }
@@ -452,10 +440,8 @@ static void vop_virtio_del_device(struct vop_vdev *vdev)
 			   get_order(VOP_INT_DMA_BUF_SIZE));
 		vringh_kiov_cleanup(&vvr->riov);
 		vringh_kiov_cleanup(&vvr->wiov);
-		dma_unmap_single(&vpdev->dev, le64_to_cpu(vqconfig[i].address),
-				 vvr->vring.len, DMA_BIDIRECTIONAL);
-		free_pages((unsigned long)vvr->vring.va,
-			   get_order(vvr->vring.len));
+		dma_free_wc(&vpdev->dev, vvr->vring.len, vvr->vring.va,
+			    le64_to_cpu(vqconfig[i].address));
 	}
 	/*
 	 * Order the type update with previous stores. This write barrier
@@ -1046,49 +1032,44 @@ static __poll_t vop_poll(struct file *f, poll_table *wait)
 }
 
 static inline int
-vop_query_offset(struct vop_vdev *vdev, unsigned long offset,
-		 unsigned long *size, unsigned long *pa)
+vop_query_offset(struct vop_vdev *vdev, unsigned long offset)
 {
-	struct vop_device *vpdev = vdev->vpdev;
 	unsigned long start = MIC_DP_SIZE;
 	int i;
 
-	/*
-	 * MMAP interface is as follows:
-	 * offset				region
-	 * 0x0					virtio device_page
-	 * 0x1000				first vring
-	 * 0x1000 + size of 1st vring		second vring
-	 * ....
-	 */
-	if (!offset) {
-		*pa = virt_to_phys(vpdev->hw_ops->get_dp(vpdev));
-		*size = MIC_DP_SIZE;
-		return 0;
-	}
-
 	for (i = 0; i < vdev->dd->num_vq; i++) {
 		struct vop_vringh *vvr = &vdev->vvr[i];
 
-		if (offset == start) {
-			*pa = virt_to_phys(vvr->vring.va);
-			*size = vvr->vring.len;
-			return 0;
-		}
+		if (offset == start)
+			return i;
+
 		start += vvr->vring.len;
 	}
+
 	return -1;
 }
 
 /*
  * Maps the device page and virtio rings to user space for readonly access.
+ *
+ * MMAP interface is as follows:
+ * offset				region
+ * 0x0					virtio device_page
+ * 0x1000				first vring
+ * 0x1000 + size of 1st vring		second vring
+ * ....
  */
 static int vop_mmap(struct file *f, struct vm_area_struct *vma)
 {
 	struct vop_vdev *vdev = f->private_data;
+	struct vop_device *vpdev = vdev->vpdev;
+	struct mic_vqconfig *vqconfig = mic_vq_config(vdev->dd);
 	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
-	unsigned long pa, size = vma->vm_end - vma->vm_start, size_rem = size;
-	int i, err;
+	unsigned long size_rem = vma->vm_end - vma->vm_start;
+	unsigned long saved_pgoff = vma->vm_pgoff;
+	unsigned long saved_start = vma->vm_start;
+	unsigned long saved_end = vma->vm_end;
+	int err;
 
 	err = vop_vdev_inited(vdev);
 	if (err)
@@ -1098,16 +1079,44 @@ static int vop_mmap(struct file *f, struct vm_area_struct *vma)
 		goto ret;
 	}
 	while (size_rem) {
-		i = vop_query_offset(vdev, offset, &size, &pa);
-		if (i < 0) {
-			err = -EINVAL;
-			goto ret;
+		unsigned long size;
+		dma_addr_t dma_addr;
+		void *cpu_addr;
+
+		if (!offset) {
+			cpu_addr = vpdev->hw_ops->get_dp(vpdev);
+			dma_addr = vpdev->hw_ops->get_dp_dma(vpdev);
+			size = MIC_DP_SIZE;
+		} else {
+			struct vop_vringh *vvr;
+			int i;
+
+			i = vop_query_offset(vdev, offset);
+			if (i < 0) {
+				err = -EINVAL;
+				goto ret;
+			}
+
+			vvr = &vdev->vvr[i];
+			cpu_addr = vvr->vring.va;
+			dma_addr = vqconfig[i].address;
+			size = vvr->vring.len;
 		}
-		err = remap_pfn_range(vma, vma->vm_start + offset,
-				      pa >> PAGE_SHIFT, size,
-				      vma->vm_page_prot);
+
+		/* dma_mmap() wants to think it's mapping the entire vma */
+		vma->vm_start += offset;
+		vma->vm_end = vma->vm_start + PAGE_ALIGN(size);
+		vma->vm_pgoff = 0;
+
+		err = dma_mmap_wc(&vpdev->dev, vma, cpu_addr, dma_addr, size);
+
+		vma->vm_start = saved_start;
+		vma->vm_end = saved_end;
+		vma->vm_pgoff = saved_pgoff;
+
 		if (err)
 			goto ret;
+
 		size_rem -= size;
 		offset += size;
 	}
-- 
2.20.0

