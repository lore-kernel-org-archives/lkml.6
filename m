Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032824AbeCAQYw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:24:52 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:6823 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1032997AbeCAQYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:24:21 -0500
From: Loic Pallardy <loic.pallardy@st.com>
To: <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH v3 11/13] remoteproc: create vdev subdevice with specific dma memory pool
Date: Thu, 1 Mar 2018 17:23:58 +0100
Message-ID: <1519921440-21356-12-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519921440-21356-1-git-send-email-loic.pallardy@st.com>
References: <1519921440-21356-1-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG7NODE2.st.com
 (10.75.127.20)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch creates a dedicated vdev subdevice for each vdev declared
in firmware resource table and associates carveout named "vdev%dbuffer"
(with %d vdev index in resource table) if any as dma coherent memory pool.

Then vdev subdevice is used as parent for virtio device.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
---
 drivers/remoteproc/remoteproc_core.c   | 40 ++++++++++++++++++++++++++++++++++
 drivers/remoteproc/remoteproc_virtio.c |  2 +-
 include/linux/remoteproc.h             |  1 +
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 3041772..61c9927 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -427,8 +427,10 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
 {
 	struct device *dev = &rproc->dev;
 	struct rproc_vdev *rvdev;
+	struct rproc_mem_entry *carveout;
 	int i, ret;
 	static int index;
+	char name[16];
 
 	/* make sure resource isn't truncated */
 	if (sizeof(*rsc) + rsc->num_of_vrings * sizeof(struct fw_rsc_vdev_vring)
@@ -479,6 +481,41 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
 			goto unwind_vring_allocations;
 	}
 
+	/* Initialise vdev subdevice */
+	snprintf(name, sizeof(name), "vdev%dbuffer", rvdev->index);
+	rvdev->dev.parent = rproc->dev.parent;
+	dev_set_name(&rvdev->dev, "%s#%s", dev_name(rvdev->dev.parent), name);
+	dev_set_drvdata(&rvdev->dev, rvdev);
+	dma_set_coherent_mask(&rvdev->dev, DMA_BIT_MASK(32));
+
+	ret = device_register(&rvdev->dev);
+	if (ret)
+		goto unwind_vring_allocations;
+
+	/* Try to find dedicated vdev buffer carveout */
+	carveout = rproc_find_carveout_by_name(rproc, name);
+
+	if (carveout) {
+		phys_addr_t pa;
+
+		if (carveout->va) {
+			dev_warn(dev, "vdev %d buffer carveout already mapped\n",
+				 rvdev->index);
+			pa = rproc_va_to_pa(carveout->va);
+		} else {
+			/* Use dma address as carveout no memmapped yet */
+			pa = (phys_addr_t)carveout->dma;
+		}
+
+		/* Associate vdev buffer memory pool to vdev subdevice */
+		ret = dmam_declare_coherent_memory(&rvdev->dev, pa,
+						   carveout->da,
+						   carveout->len,
+						   DMA_MEMORY_EXCLUSIVE);
+		if (ret < 0)
+			goto unregister_device;
+	}
+
 	list_add_tail(&rvdev->node, &rproc->rvdevs);
 
 	rproc_add_subdev(rproc, &rvdev->subdev,
@@ -486,6 +523,9 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
 
 	return 0;
 
+unregister_device:
+	put_device(&rvdev->dev);
+
 unwind_vring_allocations:
 	for (i--; i >= 0; i--)
 		rproc_free_vring(&rvdev->vring[i]);
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index b0633fd..f80014f 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -303,7 +303,7 @@ static void rproc_virtio_dev_release(struct device *dev)
 int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
 {
 	struct rproc *rproc = rvdev->rproc;
-	struct device *dev = &rproc->dev;
+	struct device *dev = &rvdev->dev;
 	struct virtio_device *vdev = &rvdev->vdev;
 	int ret;
 
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 0c9d0f6..dfc44af7 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -518,6 +518,7 @@ struct rproc_vdev {
 	struct kref refcount;
 
 	struct rproc_subdev subdev;
+	struct device dev;
 
 	unsigned int id;
 	unsigned int index;
-- 
1.9.1
