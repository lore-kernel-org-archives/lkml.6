Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B72BC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33496208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33496208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388868AbeG0OiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:38:02 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:43928 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730706AbeG0Oh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:37:28 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w6RDETgI024981;
        Fri, 27 Jul 2018 15:15:26 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2kg1up0nsa-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 27 Jul 2018 15:15:26 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1B40D31;
        Fri, 27 Jul 2018 13:15:26 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag7node2.st.com [10.75.127.20])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F138A577A;
        Fri, 27 Jul 2018 13:15:25 +0000 (GMT)
Received: from localhost (10.75.127.49) by SFHDAG7NODE2.st.com (10.75.127.20)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 27 Jul 2018 15:15:25
 +0200
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <s-anna@ti.com>, Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH v4 08/17] remoteproc: add alloc ops in rproc_mem_entry struct
Date:   Fri, 27 Jul 2018 15:14:43 +0200
Message-ID: <1532697292-14272-9-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG4NODE1.st.com (10.75.127.10) To SFHDAG7NODE2.st.com
 (10.75.127.20)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory entry could be allocated in different ways (ioremap,
dma_alloc_coherent, internal RAM allocator...).
This patch introduces an alloc ops in rproc_mem_entry structure
to associate dedicated allocation mechanism to each memory entry
descriptor in order to do remote core agnostic from memory allocators.

The introduction of this ops allows to perform allocation of all registered
carveout at the same time, just before calling rproc_start().
It simplifies and makes uniform carveout management whatever origin.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 261 ++++++++++++++++++++++-------------
 include/linux/remoteproc.h           |   7 +
 2 files changed, 175 insertions(+), 93 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 77b39ba..2c51549 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -642,74 +642,31 @@ static int rproc_handle_devmem(struct rproc *rproc, struct fw_rsc_devmem *rsc,
 }
 
 /**
- * rproc_release_carveout() - release acquired carveout
+ * rproc_alloc_carveout() - allocated specified carveout
  * @rproc: rproc handle
- * @mem: the memory entry to release
- *
- * This function releases specified memory entry @mem allocated via
- * dma_alloc_coherent() function by @rproc.
- */
-static int rproc_release_carveout(struct rproc *rproc,
-				  struct rproc_mem_entry *mem)
-{
-	struct device *dev = &rproc->dev;
-
-	/* clean up carveout allocations */
-	dma_free_coherent(dev->parent, mem->len, mem->va, mem->dma);
-	return 0;
-}
-
-/**
- * rproc_handle_carveout() - handle phys contig memory allocation requests
- * @rproc: rproc handle
- * @rsc: the resource entry
- * @avail: size of available data (for image validation)
- *
- * This function will handle firmware requests for allocation of physically
- * contiguous memory regions.
- *
- * These request entries should come first in the firmware's resource table,
- * as other firmware entries might request placing other data objects inside
- * these memory regions (e.g. data/code segments, trace resource entries, ...).
+ * @mem: the memory entry to allocate
  *
- * Allocating memory this way helps utilizing the reserved physical memory
- * (e.g. CMA) more efficiently, and also minimizes the number of TLB entries
- * needed to map it (in case @rproc is using an IOMMU). Reducing the TLB
- * pressure is important; it may have a substantial impact on performance.
+ * This function allocate specified memory entry @mem using
+ * dma_alloc_coherent() as default allocator
  */
-static int rproc_handle_carveout(struct rproc *rproc,
-				 struct fw_rsc_carveout *rsc,
-				 int offset, int avail)
+static int rproc_alloc_carveout(struct rproc *rproc,
+				struct rproc_mem_entry *mem)
 {
-	struct rproc_mem_entry *carveout, *mapping = NULL;
+	struct rproc_mem_entry *mapping = NULL;
 	struct device *dev = &rproc->dev;
 	dma_addr_t dma;
 	void *va;
 	int ret;
 
-	if (sizeof(*rsc) > avail) {
-		dev_err(dev, "carveout rsc is truncated\n");
-		return -EINVAL;
-	}
-
-	/* make sure reserved bytes are zeroes */
-	if (rsc->reserved) {
-		dev_err(dev, "carveout rsc has non zero reserved bytes\n");
-		return -EINVAL;
-	}
-
-	dev_dbg(dev, "carveout rsc: name: %s, da 0x%x, pa 0x%x, len 0x%x, flags 0x%x\n",
-		rsc->name, rsc->da, rsc->pa, rsc->len, rsc->flags);
-
-	va = dma_alloc_coherent(dev->parent, rsc->len, &dma, GFP_KERNEL);
+	va = dma_alloc_coherent(dev->parent, mem->len, &dma, GFP_KERNEL);
 	if (!va) {
 		dev_err(dev->parent,
-			"failed to allocate dma memory: len 0x%x\n", rsc->len);
+			"failed to allocate dma memory: len 0x%x\n", mem->len);
 		return -ENOMEM;
 	}
 
 	dev_dbg(dev, "carveout va %pK, dma %pad, len 0x%x\n",
-		va, &dma, rsc->len);
+		va, &dma, mem->len);
 
 	/*
 	 * Ok, this is non-standard.
@@ -729,22 +686,22 @@ static int rproc_handle_carveout(struct rproc *rproc,
 	 * physical address in this case.
 	 */
 
-	if (rsc->da != FW_RSC_ADDR_ANY && !rproc->domain) {
-		dev_err(dev->parent,
-			"Bad carveout rsc configuration\n");
-		ret = -ENOMEM;
-		goto dma_free;
-	}
+	if (mem->da != FW_RSC_ADDR_ANY) {
+		if (!rproc->domain) {
+			dev_err(dev->parent,
+				"Bad carveout rsc configuration\n");
+			ret = -ENOMEM;
+			goto dma_free;
+		}
 
-	if (rsc->da != FW_RSC_ADDR_ANY && rproc->domain) {
 		mapping = kzalloc(sizeof(*mapping), GFP_KERNEL);
 		if (!mapping) {
 			ret = -ENOMEM;
 			goto dma_free;
 		}
 
-		ret = iommu_map(rproc->domain, rsc->da, dma, rsc->len,
-				rsc->flags);
+		ret = iommu_map(rproc->domain, mem->da, dma, mem->len,
+				mem->flags);
 		if (ret) {
 			dev_err(dev, "iommu_map failed: %d\n", ret);
 			goto free_mapping;
@@ -757,52 +714,102 @@ static int rproc_handle_carveout(struct rproc *rproc,
 		 * We can't trust the remote processor not to change the
 		 * resource table, so we must maintain this info independently.
 		 */
-		mapping->da = rsc->da;
-		mapping->len = rsc->len;
+		mapping->da = mem->da;
+		mapping->len = mem->len;
 		list_add_tail(&mapping->node, &rproc->mappings);
 
 		dev_dbg(dev, "carveout mapped 0x%x to %pad\n",
-			rsc->da, &dma);
+			mem->da, &dma);
+	} else {
+		mem->da = (u32)dma;
 	}
 
-	/*
-	 * Some remote processors might need to know the pa
-	 * even though they are behind an IOMMU. E.g., OMAP4's
-	 * remote M3 processor needs this so it can control
-	 * on-chip hardware accelerators that are not behind
-	 * the IOMMU, and therefor must know the pa.
-	 *
-	 * Generally we don't want to expose physical addresses
-	 * if we don't have to (remote processors are generally
-	 * _not_ trusted), so we might want to do this only for
-	 * remote processor that _must_ have this (e.g. OMAP4's
-	 * dual M3 subsystem).
-	 *
-	 * Non-IOMMU processors might also want to have this info.
-	 * In this case, the device address and the physical address
-	 * are the same.
-	 */
-	rsc->pa = (u32)rproc_va_to_pa(va);
-
-	carveout = rproc_mem_entry_init(dev, va, dma, rsc->len, rsc->da,
-					rproc_release_carveout, rsc->name);
-	if (!carveout)
-		goto free_carv;
-
-	rproc_add_carveout(rproc, carveout);
+	mem->dma = (u32)dma;
+	mem->va = va;
 
 	return 0;
 
-free_carv:
-	kfree(carveout);
 free_mapping:
 	kfree(mapping);
 dma_free:
-	dma_free_coherent(dev->parent, rsc->len, va, dma);
+	dma_free_coherent(dev->parent, mem->len, va, dma);
 	return ret;
 }
 
 /**
+ * rproc_release_carveout() - release acquired carveout
+ * @rproc: rproc handle
+ * @mem: the memory entry to release
+ *
+ * This function releases specified memory entry @mem allocated via
+ * rproc_alloc_carveout() function by @rproc.
+ */
+static int rproc_release_carveout(struct rproc *rproc,
+				  struct rproc_mem_entry *mem)
+{
+	struct device *dev = &rproc->dev;
+
+	/* clean up carveout allocations */
+	dma_free_coherent(dev->parent, mem->len, mem->va, mem->dma);
+	return 0;
+}
+
+/**
+ * rproc_handle_carveout() - handle phys contig memory allocation requests
+ * @rproc: rproc handle
+ * @rsc: the resource entry
+ * @avail: size of available data (for image validation)
+ *
+ * This function will handle firmware requests for allocation of physically
+ * contiguous memory regions.
+ *
+ * These request entries should come first in the firmware's resource table,
+ * as other firmware entries might request placing other data objects inside
+ * these memory regions (e.g. data/code segments, trace resource entries, ...).
+ *
+ * Allocating memory this way helps utilizing the reserved physical memory
+ * (e.g. CMA) more efficiently, and also minimizes the number of TLB entries
+ * needed to map it (in case @rproc is using an IOMMU). Reducing the TLB
+ * pressure is important; it may have a substantial impact on performance.
+ */
+static int rproc_handle_carveout(struct rproc *rproc,
+				 struct fw_rsc_carveout *rsc,
+				 int offset, int avail)
+{
+	struct rproc_mem_entry *carveout;
+	struct device *dev = &rproc->dev;
+
+	if (sizeof(*rsc) > avail) {
+		dev_err(dev, "carveout rsc is truncated\n");
+		return -EINVAL;
+	}
+
+	/* make sure reserved bytes are zeroes */
+	if (rsc->reserved) {
+		dev_err(dev, "carveout rsc has non zero reserved bytes\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "carveout rsc: name: %s, da 0x%x, pa 0x%x, len 0x%x, flags 0x%x\n",
+		rsc->name, rsc->da, rsc->pa, rsc->len, rsc->flags);
+
+	/* Register carveout in in list */
+	carveout = rproc_mem_entry_init(dev, 0, 0, rsc->len, rsc->da,
+					rproc_alloc_carveout,
+					rproc_release_carveout, rsc->name);
+	if (!carveout) {
+		dev_err(dev, "Can't allocate memory entry structure\n");
+		return -ENOMEM;
+	}
+
+	carveout->flags = rsc->flags;
+	carveout->rsc_offset = offset;
+	rproc_add_carveout(rproc, carveout);
+
+	return 0;
+}
+
+/**
  * rproc_add_carveout() - register an allocated carveout region
  * @rproc: rproc handle
  * @mem: memory entry to register
@@ -832,6 +839,7 @@ void rproc_add_carveout(struct rproc *rproc, struct rproc_mem_entry *mem)
 struct rproc_mem_entry *
 rproc_mem_entry_init(struct device *dev,
 		     void *va, dma_addr_t dma, int len, u32 da,
+		     int (*alloc)(struct rproc *, struct rproc_mem_entry *),
 		     int (*release)(struct rproc *, struct rproc_mem_entry *),
 		     const char *name, ...)
 {
@@ -846,7 +854,9 @@ struct rproc_mem_entry *
 	mem->dma = dma;
 	mem->da = da;
 	mem->len = len;
+	mem->alloc = alloc;
 	mem->release = release;
+	mem->rsc_offset = FW_RSC_ADDR_ANY;
 
 	va_start(args, name);
 	vsnprintf(mem->name, sizeof(mem->name), name, args);
@@ -978,6 +988,63 @@ static void rproc_unprepare_subdevices(struct rproc *rproc)
 }
 
 /**
+ * rproc_alloc_registered_carveouts() - allocate all carveouts registered
+ * in the list
+ * @rproc: the remote processor handle
+ *
+ * This function parses registered carveout list, performs allocation
+ * if alloc() ops registered and updates resource table information
+ * if rsc_offset set.
+ *
+ * Return: 0 on success
+ */
+static int rproc_alloc_registered_carveouts(struct rproc *rproc)
+{
+	struct rproc_mem_entry *entry, *tmp;
+	struct fw_rsc_carveout *rsc;
+	struct device *dev = &rproc->dev;
+	int ret;
+
+	list_for_each_entry_safe(entry, tmp, &rproc->carveouts, node) {
+		if (entry->alloc) {
+			ret = entry->alloc(rproc, entry);
+			if (ret) {
+				dev_err(dev, "Unable to allocate carveout %s: %d\n",
+					entry->name, ret);
+				return -ENOMEM;
+			}
+		}
+
+		if (entry->rsc_offset != FW_RSC_ADDR_ANY) {
+			/* update resource table */
+			rsc = (void *)rproc->table_ptr + entry->rsc_offset;
+
+			/*
+			 * Some remote processors might need to know the pa
+			 * even though they are behind an IOMMU. E.g., OMAP4's
+			 * remote M3 processor needs this so it can control
+			 * on-chip hardware accelerators that are not behind
+			 * the IOMMU, and therefor must know the pa.
+			 *
+			 * Generally we don't want to expose physical addresses
+			 * if we don't have to (remote processors are generally
+			 * _not_ trusted), so we might want to do this only for
+			 * remote processor that _must_ have this (e.g. OMAP4's
+			 * dual M3 subsystem).
+			 *
+			 * Non-IOMMU processors might also want to have this info.
+			 * In this case, the device address and the physical address
+			 * are the same.
+			 */
+			if (entry->va)
+				rsc->pa = (u32)rproc_va_to_pa(entry->va);
+		}
+	}
+
+	return 0;
+}
+
+/**
  * rproc_coredump_cleanup() - clean up dump_segments list
  * @rproc: the remote processor handle
  */
@@ -1148,6 +1215,14 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 		goto clean_up_resources;
 	}
 
+	/* Allocate carveout resources associated to rproc */
+	ret = rproc_alloc_registered_carveouts(rproc);
+	if (ret) {
+		dev_err(dev, "Failed to allocate associated carveouts: %d\n",
+			ret);
+		goto clean_up_resources;
+	}
+
 	ret = rproc_start(rproc, fw);
 	if (ret)
 		goto clean_up_resources;
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 55f30fc..ea95b04 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -317,6 +317,9 @@ struct fw_rsc_vdev {
  * @priv: associated data
  * @name: associated memory region name (optional)
  * @node: list node
+ * @rsc_offset: offset in resource table
+ * @flags: iommu protection flags
+ * @alloc: specific memory allocator function
  */
 struct rproc_mem_entry {
 	void *va;
@@ -326,6 +329,9 @@ struct rproc_mem_entry {
 	void *priv;
 	char name[32];
 	struct list_head node;
+	u32 rsc_offset;
+	u32 flags;
+	int (*alloc)(struct rproc *rproc, struct rproc_mem_entry *mem);
 	int (*release)(struct rproc *rproc, struct rproc_mem_entry *mem);
 };
 
@@ -563,6 +569,7 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 struct rproc_mem_entry *
 rproc_mem_entry_init(struct device *dev,
 		     void *va, dma_addr_t dma, int len, u32 da,
+		     int (*alloc)(struct rproc *, struct rproc_mem_entry *),
 		     int (*release)(struct rproc *, struct rproc_mem_entry *),
 		     const char *name, ...);
 
-- 
1.9.1

