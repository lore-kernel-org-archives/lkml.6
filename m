Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033083AbeCAQZm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:25:42 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22475 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1032994AbeCAQYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:24:20 -0500
From: Loic Pallardy <loic.pallardy@st.com>
To: <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH v3 10/13] remoteproc: modify vring allocation to support pre-registered region
Date: Thu, 1 Mar 2018 17:23:57 +0100
Message-ID: <1519921440-21356-11-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519921440-21356-1-git-send-email-loic.pallardy@st.com>
References: <1519921440-21356-1-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG7NODE2.st.com
 (10.75.127.20)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current version of rproc_alloc_vring function supports only dynamic vring
allocation.
This patch proposes to manage vrings like memory carveouts to commonize
memory management codeand to rely on rproc_handle_carveout and
rproc_find_carveout_by_name functions for vrings allocation.

This patch sets vrings names to vdev"x"vring"y" as no name defined in
firmware resource table.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 58 +++++++++++++++++++++++++-----------
 include/linux/remoteproc.h           |  3 +-
 2 files changed, 42 insertions(+), 19 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 49b28a0..3041772 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -52,6 +52,10 @@ typedef int (*rproc_handle_resources_t)(struct rproc *rproc,
 typedef int (*rproc_handle_resource_t)(struct rproc *rproc,
 				 void *, int offset, int avail);
 
+static int rproc_handle_carveout(struct rproc *rproc,
+				 struct fw_rsc_carveout *rsc,
+				 int offset, int avail);
+
 /* Unique indices for remoteproc devices */
 static DEFINE_IDA(rproc_dev_index);
 
@@ -265,23 +269,45 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
 	struct device *dev = &rproc->dev;
 	struct rproc_vring *rvring = &rvdev->vring[i];
 	struct fw_rsc_vdev *rsc;
-	dma_addr_t dma;
-	void *va;
 	int ret, size, notifyid;
+	struct fw_rsc_carveout rsc_carveout;
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
+	rsc = (void *)rproc->table_ptr + rvdev->rsc_offset;
+
+	/* Create virtual firmware carveout resource */
+	rsc_carveout.da = rsc->vring[i].da;
+	rsc_carveout.pa = FW_RSC_ADDR_ANY;
+	rsc_carveout.len = size;
+	rsc_carveout.flags = 0;
+	rsc_carveout.reserved = 0;
+	snprintf(rsc_carveout.name, sizeof(rsc_carveout.name), "vdev%dvring%d",
+		 rvdev->index, i);
+
+	/* Do vring carveout allocation */
+	ret = rproc_handle_carveout(rproc, &rsc_carveout, 0,
+				    sizeof(rsc_carveout));
+	if (ret) {
+		dev_err(dev->parent, "Failled to process vring carveout\n");
 		return -EINVAL;
 	}
 
+	/* Retrieve memory entry */
+	mem = rproc_find_carveout_by_name(rproc, rsc_carveout.name);
+	if (!mem) {
+		dev_err(dev->parent, "Failled to find vring carveout\n");
+		return -ENOMEM;
+	}
+
+	/* Verify carveout is well mapped */
+	if (!mem->va) {
+		dev_err(dev->parent, "Invalid vring carveout\n");
+		return -ENOMEM;
+	}
+
 	/*
 	 * Assign an rproc-wide unique index for this vring
 	 * TODO: assign a notifyid for rvdev updates as well
@@ -290,7 +316,6 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
 	ret = idr_alloc(&rproc->notifyids, rvring, 0, 0, GFP_KERNEL);
 	if (ret < 0) {
 		dev_err(dev, "idr_alloc failed: %d\n", ret);
-		dma_free_coherent(dev->parent, size, va, dma);
 		return ret;
 	}
 	notifyid = ret;
@@ -300,10 +325,9 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
 		rproc->max_notifyid = notifyid;
 
 	dev_dbg(dev, "vring%d: va %p dma %pad size 0x%x idr %d\n",
-		i, va, &dma, size, notifyid);
+		i, mem->va, &mem->dma, size, notifyid);
 
-	rvring->va = va;
-	rvring->dma = dma;
+	rvring->va = mem->va;
 	rvring->notifyid = notifyid;
 
 	/*
@@ -312,8 +336,8 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
 	 * set up the iommu. In this case the device address (da) will
 	 * hold the physical address and not the device address.
 	 */
-	rsc = (void *)rproc->table_ptr + rvdev->rsc_offset;
-	rsc->vring[i].da = dma;
+	if (rsc->vring[i].da == FW_RSC_ADDR_ANY)
+		rsc->vring[i].da = mem->da;
 	rsc->vring[i].notifyid = notifyid;
 	return 0;
 }
@@ -345,12 +369,10 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
 
 void rproc_free_vring(struct rproc_vring *rvring)
 {
-	int size = PAGE_ALIGN(vring_size(rvring->len, rvring->align));
 	struct rproc *rproc = rvring->rvdev->rproc;
 	int idx = rvring->rvdev->vring - rvring;
 	struct fw_rsc_vdev *rsc;
 
-	dma_free_coherent(rproc->dev.parent, size, rvring->va, rvring->dma);
 	idr_remove(&rproc->notifyids, rvring->notifyid);
 
 	/* reset resource entry info */
@@ -406,6 +428,7 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
 	struct device *dev = &rproc->dev;
 	struct rproc_vdev *rvdev;
 	int i, ret;
+	static int index;
 
 	/* make sure resource isn't truncated */
 	if (sizeof(*rsc) + rsc->num_of_vrings * sizeof(struct fw_rsc_vdev_vring)
@@ -437,6 +460,7 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
 
 	rvdev->id = rsc->id;
 	rvdev->rproc = rproc;
+	rvdev->index = index++;
 
 	/* parse the vrings */
 	for (i = 0; i < rsc->num_of_vrings; i++) {
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index dcfa601..0c9d0f6 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -486,7 +486,6 @@ struct rproc_subdev {
 /**
  * struct rproc_vring - remoteproc vring state
  * @va:	virtual address
- * @dma: dma address
  * @len: length, in bytes
  * @da: device address
  * @align: vring alignment
@@ -496,7 +495,6 @@ struct rproc_subdev {
  */
 struct rproc_vring {
 	void *va;
-	dma_addr_t dma;
 	int len;
 	u32 da;
 	u32 align;
@@ -522,6 +520,7 @@ struct rproc_vdev {
 	struct rproc_subdev subdev;
 
 	unsigned int id;
+	unsigned int index;
 	struct list_head node;
 	struct rproc *rproc;
 	struct virtio_device vdev;
-- 
1.9.1
