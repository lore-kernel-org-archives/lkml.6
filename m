Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F28C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F3B20879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfAJNvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:51:01 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:54998 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727000AbfAJNu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:50:59 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0ADffKI000651;
        Thu, 10 Jan 2019 14:50:54 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ptybn9mcy-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 10 Jan 2019 14:50:54 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9A1A434;
        Thu, 10 Jan 2019 13:50:53 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7EFFC505F;
        Thu, 10 Jan 2019 13:50:53 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 10 Jan
 2019 14:50:53 +0100
Received: from localhost (10.201.20.178) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 10 Jan 2019 14:50:52
 +0100
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <s-anna@ti.com>, Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH v2 1/3] remoteproc: create vdev subdevice with specific dma memory pool
Date:   Thu, 10 Jan 2019 14:50:49 +0100
Message-ID: <1547128251-44137-2-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547128251-44137-1-git-send-email-loic.pallardy@st.com>
References: <1547128251-44137-1-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-10_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch creates a dedicated vdev subdevice for each vdev declared
in firmware resource table and associates carveout named "vdev%dbuffer"
(with %d vdev index in resource table) if any as dma coherent memory pool.

Then vdev subdevice is used as parent for virtio device.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>

---
Changes from v1:
- rebase on v5.0-rc1 (dma_declare_coherent_memory() API change)
- call put_device() in case of error returned by device_register()
---
 drivers/remoteproc/remoteproc_core.c     | 47 ++++++++++++++++++++++++++++++--
 drivers/remoteproc/remoteproc_internal.h |  1 +
 drivers/remoteproc/remoteproc_virtio.c   | 42 +++++++++++++++++++++++++++-
 include/linux/remoteproc.h               |  1 +
 4 files changed, 87 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 54ec38fc5dca..821dbedef18e 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -39,9 +39,11 @@
 #include <linux/idr.h>
 #include <linux/elf.h>
 #include <linux/crc32.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/virtio_ids.h>
 #include <linux/virtio_ring.h>
 #include <asm/byteorder.h>
+#include <linux/platform_device.h>
 
 #include "remoteproc_internal.h"
 
@@ -145,7 +147,7 @@ static void rproc_disable_iommu(struct rproc *rproc)
 	iommu_domain_free(domain);
 }
 
-static phys_addr_t rproc_va_to_pa(void *cpu_addr)
+phys_addr_t rproc_va_to_pa(void *cpu_addr)
 {
 	/*
 	 * Return physical address according to virtual address location
@@ -160,6 +162,7 @@ static phys_addr_t rproc_va_to_pa(void *cpu_addr)
 	WARN_ON(!virt_addr_valid(cpu_addr));
 	return virt_to_phys(cpu_addr);
 }
+EXPORT_SYMBOL(rproc_va_to_pa);
 
 /**
  * rproc_da_to_va() - lookup the kernel virtual address for a remoteproc address
@@ -423,6 +426,20 @@ static void rproc_vdev_do_stop(struct rproc_subdev *subdev, bool crashed)
 }
 
 /**
+ * rproc_rvdev_release() - release the existence of a rvdev
+ *
+ * @dev: the subdevice's dev
+ */
+static void rproc_rvdev_release(struct device *dev)
+{
+	struct rproc_vdev *rvdev = container_of(dev, struct rproc_vdev, dev);
+
+	of_reserved_mem_device_release(dev);
+
+	kfree(rvdev);
+}
+
+/**
  * rproc_handle_vdev() - handle a vdev fw resource
  * @rproc: the remote processor
  * @rsc: the vring resource descriptor
@@ -455,6 +472,7 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
 	struct device *dev = &rproc->dev;
 	struct rproc_vdev *rvdev;
 	int i, ret;
+	char name[16];
 
 	/* make sure resource isn't truncated */
 	if (sizeof(*rsc) + rsc->num_of_vrings * sizeof(struct fw_rsc_vdev_vring)
@@ -488,6 +506,29 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
 	rvdev->rproc = rproc;
 	rvdev->index = rproc->nb_vdev++;
 
+	/* Initialise vdev subdevice */
+	snprintf(name, sizeof(name), "vdev%dbuffer", rvdev->index);
+	rvdev->dev.parent = rproc->dev.parent;
+	rvdev->dev.release = rproc_rvdev_release;
+	dev_set_name(&rvdev->dev, "%s#%s", dev_name(rvdev->dev.parent), name);
+	dev_set_drvdata(&rvdev->dev, rvdev);
+
+	ret = device_register(&rvdev->dev);
+	if (ret) {
+		put_device(&rvdev->dev);
+		return ret;
+	}
+	/* Make device dma capable by inheriting from parent's capabilities */
+	set_dma_ops(&rvdev->dev, get_dma_ops(rproc->dev.parent));
+
+	ret = dma_coerce_mask_and_coherent(&rvdev->dev,
+					   dma_get_mask(rproc->dev.parent));
+	if (ret) {
+		dev_warn(dev,
+			 "Failed to set DMA mask %llx. Trying to continue... %x\n",
+			 dma_get_mask(rproc->dev.parent), ret);
+	}
+
 	/* parse the vrings */
 	for (i = 0; i < rsc->num_of_vrings; i++) {
 		ret = rproc_parse_vring(rvdev, rsc, i);
@@ -518,7 +559,7 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
 	for (i--; i >= 0; i--)
 		rproc_free_vring(&rvdev->vring[i]);
 free_rvdev:
-	kfree(rvdev);
+	device_unregister(&rvdev->dev);
 	return ret;
 }
 
@@ -536,7 +577,7 @@ void rproc_vdev_release(struct kref *ref)
 
 	rproc_remove_subdev(rproc, &rvdev->subdev);
 	list_del(&rvdev->node);
-	kfree(rvdev);
+	device_unregister(&rvdev->dev);
 }
 
 /**
diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index f6cad243d7ca..bfeacfd40947 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -52,6 +52,7 @@ void rproc_free_vring(struct rproc_vring *rvring);
 int rproc_alloc_vring(struct rproc_vdev *rvdev, int i);
 
 void *rproc_da_to_va(struct rproc *rproc, u64 da, int len);
+phys_addr_t rproc_va_to_pa(void *cpu_addr);
 int rproc_trigger_recovery(struct rproc *rproc);
 
 int rproc_elf_sanity_check(struct rproc *rproc, const struct firmware *fw);
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index 183fc42a510a..d08b2cfd875b 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -17,7 +17,9 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/dma-mapping.h>
 #include <linux/export.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/remoteproc.h>
 #include <linux/virtio.h>
 #include <linux/virtio_config.h>
@@ -328,10 +330,48 @@ static void rproc_virtio_dev_release(struct device *dev)
 int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
 {
 	struct rproc *rproc = rvdev->rproc;
-	struct device *dev = &rproc->dev;
+	struct device *dev = &rvdev->dev;
 	struct virtio_device *vdev = &rvdev->vdev;
+	struct rproc_mem_entry *mem;
 	int ret;
 
+	/* Try to find dedicated vdev buffer carveout */
+	mem = rproc_find_carveout_by_name(rproc, "vdev%dbuffer", rvdev->index);
+	if (mem) {
+		phys_addr_t pa;
+
+		if (mem->of_resm_idx != -1) {
+			struct device_node *np = rproc->dev.parent->of_node;
+
+			/* Associate reserved memory to vdev device */
+			ret = of_reserved_mem_device_init_by_idx(dev, np,
+								 mem->of_resm_idx);
+			if (ret) {
+				dev_err(dev, "Can't associate reserved memory\n");
+				goto out;
+			}
+		} else {
+			if (mem->va) {
+				dev_warn(dev, "vdev %d buffer already mapped\n",
+					 rvdev->index);
+				pa = rproc_va_to_pa(mem->va);
+			} else {
+				/* Use dma address as carveout no memmapped yet */
+				pa = (phys_addr_t)mem->dma;
+			}
+
+			/* Associate vdev buffer memory pool to vdev subdev */
+			ret = dma_declare_coherent_memory(dev, pa,
+							   mem->da,
+							   mem->len,
+							   DMA_MEMORY_EXCLUSIVE);
+			if (ret < 0) {
+				dev_err(dev, "Failed to associate buffer\n");
+				goto out;
+			}
+		}
+	}
+
 	vdev->id.device	= id,
 	vdev->config = &rproc_virtio_config_ops,
 	vdev->dev.parent = dev;
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 507a2b524208..beecd8cf2eb5 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -554,6 +554,7 @@ struct rproc_vdev {
 	struct kref refcount;
 
 	struct rproc_subdev subdev;
+	struct device dev;
 
 	unsigned int id;
 	struct list_head node;
-- 
2.7.4

