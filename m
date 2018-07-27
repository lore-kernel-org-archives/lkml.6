Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335EAC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC097208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC097208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388745AbeG0Oh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:37:29 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:14997 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388298AbeG0Oh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:37:28 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w6RDEJ10016198;
        Fri, 27 Jul 2018 15:15:31 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2kg26xrjw3-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 27 Jul 2018 15:15:31 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2757F31;
        Fri, 27 Jul 2018 13:15:30 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag7node2.st.com [10.75.127.20])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 04A96577A;
        Fri, 27 Jul 2018 13:15:30 +0000 (GMT)
Received: from localhost (10.75.127.51) by SFHDAG7NODE2.st.com (10.75.127.20)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 27 Jul 2018 15:15:29
 +0200
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <s-anna@ti.com>, Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH v4 12/17] remoteproc: modify vring allocation to rely on centralized carveout allocator
Date:   Fri, 27 Jul 2018 15:14:47 +0200
Message-ID: <1532697292-14272-13-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG7NODE2.st.com
 (10.75.127.20)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current version of rproc_alloc_vring function supports only dynamic vring
allocation.

This patch allows to allocate vrings based on memory region declatation.
Vrings are now manage like memory carveouts, to communize memory management
code in rproc_alloc_registered_carveouts().

Allocated buffer is retrieved in rp_find_vq() thanks to
rproc_find_carveout_by_name() functions for.

This patch sets vrings names to vdev"x"vring"y" with x vdev index in
resource table and y vring index in vdev. This will be updated when
name will be associated to vdev in firmware resource table.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
---
 drivers/remoteproc/remoteproc_core.c     | 61 +++++++++++++++++---------------
 drivers/remoteproc/remoteproc_internal.h |  2 ++
 drivers/remoteproc/remoteproc_virtio.c   | 14 +++++++-
 include/linux/remoteproc.h               |  6 ++--
 4 files changed, 51 insertions(+), 32 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index c543d04..4edc6f0 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -53,6 +53,11 @@ typedef int (*rproc_handle_resources_t)(struct rproc *rproc,
 typedef int (*rproc_handle_resource_t)(struct rproc *rproc,
 				 void *, int offset, int avail);
 
+static int rproc_alloc_carveout(struct rproc *rproc,
+				struct rproc_mem_entry *mem);
+static int rproc_release_carveout(struct rproc *rproc,
+				  struct rproc_mem_entry *mem);
+
 /* Unique indices for remoteproc devices */
 static DEFINE_IDA(rproc_dev_index);
 
@@ -312,21 +317,33 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
 	struct device *dev = &rproc->dev;
 	struct rproc_vring *rvring = &rvdev->vring[i];
 	struct fw_rsc_vdev *rsc;
-	dma_addr_t dma;
-	void *va;
 	int ret, size, notifyid;
+	struct rproc_mem_entry *mem;
 
 	/* actual size of vring (in bytes) */
 	size = PAGE_ALIGN(vring_size(rvring->len, rvring->align));
 
-	/*
-	 * Allocate non-cacheable memory for the vring. In the future
-	 * this call will also configure the IOMMU for us
-	 */
-	va = dma_alloc_coherent(dev->parent, size, &dma, GFP_KERNEL);
-	if (!va) {
-		dev_err(dev->parent, "dma_alloc_coherent failed\n");
-		return -EINVAL;
+	rsc = (void *)rproc->table_ptr + rvdev->rsc_offset;
+
+	/* Search for pre-registered carveout */
+	mem = rproc_find_carveout_by_name(rproc, "vdev%dvring%d", rvdev->index,
+					  i);
+	if (mem) {
+		if (rproc_check_carveout_da(rproc, mem, rsc->vring[i].da, size))
+			return -ENOMEM;
+	} else {
+		/* Register carveout in in list */
+		mem = rproc_mem_entry_init(dev, 0, 0, size, rsc->vring[i].da,
+					   rproc_alloc_carveout,
+					   rproc_release_carveout,
+					   "vdev%dvring%d",
+					   rvdev->index, i);
+		if (!mem) {
+			dev_err(dev, "Can't allocate memory entry structure\n");
+			return -ENOMEM;
+		}
+
+		rproc_add_carveout(rproc, mem);
 	}
 
 	/*
@@ -337,7 +354,6 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
 	ret = idr_alloc(&rproc->notifyids, rvring, 0, 0, GFP_KERNEL);
 	if (ret < 0) {
 		dev_err(dev, "idr_alloc failed: %d\n", ret);
-		dma_free_coherent(dev->parent, size, va, dma);
 		return ret;
 	}
 	notifyid = ret;
@@ -346,21 +362,9 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
 	if (notifyid > rproc->max_notifyid)
 		rproc->max_notifyid = notifyid;
 
-	dev_dbg(dev, "vring%d: va %pK dma %pad size 0x%x idr %d\n",
-		i, va, &dma, size, notifyid);
-
-	rvring->va = va;
-	rvring->dma = dma;
 	rvring->notifyid = notifyid;
 
-	/*
-	 * Let the rproc know the notifyid and da of this vring.
-	 * Not all platforms use dma_alloc_coherent to automatically
-	 * set up the iommu. In this case the device address (da) will
-	 * hold the physical address and not the device address.
-	 */
-	rsc = (void *)rproc->table_ptr + rvdev->rsc_offset;
-	rsc->vring[i].da = dma;
+	/* Let the rproc know the notifyid of this vring.*/
 	rsc->vring[i].notifyid = notifyid;
 	return 0;
 }
@@ -392,12 +396,10 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
 
 void rproc_free_vring(struct rproc_vring *rvring)
 {
-	int size = PAGE_ALIGN(vring_size(rvring->len, rvring->align));
 	struct rproc *rproc = rvring->rvdev->rproc;
 	int idx = rvring->rvdev->vring - rvring;
 	struct fw_rsc_vdev *rsc;
 
-	dma_free_coherent(rproc->dev.parent, size, rvring->va, rvring->dma);
 	idr_remove(&rproc->notifyids, rvring->notifyid);
 
 	/* reset resource entry info */
@@ -484,6 +486,7 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
 
 	rvdev->id = rsc->id;
 	rvdev->rproc = rproc;
+	rvdev->index = rproc->nb_vdev++;
 
 	/* parse the vrings */
 	for (i = 0; i < rsc->num_of_vrings; i++) {
@@ -528,9 +531,6 @@ void rproc_vdev_release(struct kref *ref)
 
 	for (id = 0; id < ARRAY_SIZE(rvdev->vring); id++) {
 		rvring = &rvdev->vring[id];
-		if (!rvring->va)
-			continue;
-
 		rproc_free_vring(rvring);
 	}
 
@@ -1322,6 +1322,9 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 	/* reset max_notifyid */
 	rproc->max_notifyid = -1;
 
+	/* reset handled vdev */
+	rproc->nb_vdev = 0;
+
 	/* handle fw resources which are required to boot rproc */
 	ret = rproc_handle_resources(rproc, rproc_loading_handlers);
 	if (ret) {
diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index 7570beb..f6cad24 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -60,6 +60,8 @@ struct dentry *rproc_create_trace_file(const char *name, struct rproc *rproc,
 int rproc_elf_load_rsc_table(struct rproc *rproc, const struct firmware *fw);
 struct resource_table *rproc_elf_find_loaded_rsc_table(struct rproc *rproc,
 						       const struct firmware *fw);
+struct rproc_mem_entry *
+rproc_find_carveout_by_name(struct rproc *rproc, const char *name, ...);
 
 static inline
 int rproc_fw_sanity_check(struct rproc *rproc, const struct firmware *fw)
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index bbecd44..de21f62 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -76,7 +76,9 @@ static struct virtqueue *rp_find_vq(struct virtio_device *vdev,
 	struct rproc_vdev *rvdev = vdev_to_rvdev(vdev);
 	struct rproc *rproc = vdev_to_rproc(vdev);
 	struct device *dev = &rproc->dev;
+	struct rproc_mem_entry *mem;
 	struct rproc_vring *rvring;
+	struct fw_rsc_vdev *rsc;
 	struct virtqueue *vq;
 	void *addr;
 	int len, size;
@@ -88,8 +90,14 @@ static struct virtqueue *rp_find_vq(struct virtio_device *vdev,
 	if (!name)
 		return NULL;
 
+	/* Search allocated memory region by name */
+	mem = rproc_find_carveout_by_name(rproc, "vdev%dvring%d", rvdev->index,
+					  id);
+	if (!mem || !mem->va)
+		return ERR_PTR(-ENOMEM);
+
 	rvring = &rvdev->vring[id];
-	addr = rvring->va;
+	addr = mem->va;
 	len = rvring->len;
 
 	/* zero vring */
@@ -114,6 +122,10 @@ static struct virtqueue *rp_find_vq(struct virtio_device *vdev,
 	rvring->vq = vq;
 	vq->priv = rvring;
 
+	/* Update vring in resource table */
+	rsc = (void *)rproc->table_ptr + rvdev->rsc_offset;
+	rsc->vring[id].da = mem->da;
+
 	return vq;
 }
 
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 4cdd0c6..6b3a234 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -453,6 +453,7 @@ struct rproc_dump_segment {
  * @table_sz: size of @cached_table
  * @has_iommu: flag to indicate if remote processor is behind an MMU
  * @dump_segments: list of segments in the firmware
+ * @nb_vdev: number of vdev currently handled by rproc
  */
 struct rproc {
 	struct list_head node;
@@ -485,6 +486,7 @@ struct rproc {
 	bool has_iommu;
 	bool auto_boot;
 	struct list_head dump_segments;
+	int nb_vdev;
 };
 
 /**
@@ -512,7 +514,6 @@ struct rproc_subdev {
 /**
  * struct rproc_vring - remoteproc vring state
  * @va:	virtual address
- * @dma: dma address
  * @len: length, in bytes
  * @da: device address
  * @align: vring alignment
@@ -522,7 +523,6 @@ struct rproc_subdev {
  */
 struct rproc_vring {
 	void *va;
-	dma_addr_t dma;
 	int len;
 	u32 da;
 	u32 align;
@@ -541,6 +541,7 @@ struct rproc_vring {
  * @vdev: the virio device
  * @vring: the vrings for this vdev
  * @rsc_offset: offset of the vdev's resource entry
+ * @index: vdev position versus other vdev declared in resource table
  */
 struct rproc_vdev {
 	struct kref refcount;
@@ -553,6 +554,7 @@ struct rproc_vdev {
 	struct virtio_device vdev;
 	struct rproc_vring vring[RVDEV_NUM_VRINGS];
 	u32 rsc_offset;
+	u32 index;
 };
 
 struct rproc *rproc_get_by_phandle(phandle phandle);
-- 
1.9.1

