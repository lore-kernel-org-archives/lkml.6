Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033008AbeCAQYV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:24:21 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:15371 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1032974AbeCAQYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:24:16 -0500
From: Loic Pallardy <loic.pallardy@st.com>
To: <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH v3 05/13] remoteproc: add helper function to allocate and init rproc_mem_entry struct
Date: Thu, 1 Mar 2018 17:23:52 +0100
Message-ID: <1519921440-21356-6-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519921440-21356-1-git-send-email-loic.pallardy@st.com>
References: <1519921440-21356-1-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG7NODE2.st.com
 (10.75.127.20)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces rproc_mem_entry_init helper function to
simplify rproc_mem_entry structure allocation and filling by
client.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 64 +++++++++++++++++++++++++++---------
 include/linux/remoteproc.h           |  5 +++
 2 files changed, 53 insertions(+), 16 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index f73a0cf..4c92b7d 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -636,7 +636,7 @@ static int rproc_handle_carveout(struct rproc *rproc,
 				 struct fw_rsc_carveout *rsc,
 				 int offset, int avail)
 {
-	struct rproc_mem_entry *carveout, *mapping;
+	struct rproc_mem_entry *carveout, *mapping = NULL;
 	struct device *dev = &rproc->dev;
 	dma_addr_t dma;
 	void *va;
@@ -656,16 +656,11 @@ static int rproc_handle_carveout(struct rproc *rproc,
 	dev_dbg(dev, "carveout rsc: name: %s, da 0x%x, pa 0x%x, len 0x%x, flags 0x%x\n",
 		rsc->name, rsc->da, rsc->pa, rsc->len, rsc->flags);
 
-	carveout = kzalloc(sizeof(*carveout), GFP_KERNEL);
-	if (!carveout)
-		return -ENOMEM;
-
 	va = dma_alloc_coherent(dev->parent, rsc->len, &dma, GFP_KERNEL);
 	if (!va) {
 		dev_err(dev->parent,
 			"failed to allocate dma memory: len 0x%x\n", rsc->len);
-		ret = -ENOMEM;
-		goto free_carv;
+		return -ENOMEM;
 	}
 
 	dev_dbg(dev, "carveout va %p, dma %pad, len 0x%x\n",
@@ -744,27 +739,64 @@ static int rproc_handle_carveout(struct rproc *rproc,
 	 */
 	rsc->pa = (u32)rproc_va_to_pa(va);
 
-	carveout->va = va;
-	carveout->len = rsc->len;
-	carveout->dma = dma;
-	carveout->da = rsc->da;
-	carveout->release = rproc_release_carveout;
-	strlcpy(carveout->name, rsc->name, sizeof(carveout->name));
+	carveout = rproc_mem_entry_init(dev, va, dma, rsc->len, rsc->da,
+					rproc_release_carveout, rsc->name);
+	if (!carveout)
+		goto free_carv;
 
 	list_add_tail(&carveout->node, &rproc->carveouts);
 
 	return 0;
 
+free_carv:
+	kfree(carveout);
 free_mapping:
 	kfree(mapping);
 dma_free:
 	dma_free_coherent(dev->parent, rsc->len, va, dma);
-free_carv:
-	kfree(carveout);
 	return ret;
 }
 
-/*
+/**
+ * rproc_mem_entry_init() - allocate and initialize rproc_mem_entry struct
+ * @dev: pointer on device struct
+ * @va: virtual address
+ * @dma: dma address
+ * @len: memory carveout length
+ * @da: device address
+ * @release: memory carveout function
+ * @name: carveout name
+ *
+ * This function allocates a rproc_mem_entry struct and fill it with parameters
+ * provided by client.
+ */
+struct rproc_mem_entry *rproc_mem_entry_init(struct device *dev,
+		void *va, dma_addr_t dma, int len, u32 da,
+		int (*release)(struct rproc *, struct rproc_mem_entry *),
+		const char *name, ...)
+{
+	struct rproc_mem_entry *mem;
+	va_list args;
+
+	mem = devm_kzalloc(dev, sizeof(*mem), GFP_KERNEL);
+	if (!mem)
+		return ERR_PTR(-ENOMEM);
+
+	mem->va = va;
+	mem->dma = dma;
+	mem->da = da;
+	mem->len = len;
+	mem->release = release;
+
+	va_start(args, name);
+	snprintf(mem->name, sizeof(mem->name), name, args);
+	va_end(args);
+
+	return mem;
+}
+EXPORT_SYMBOL(rproc_mem_entry_init);
+
+/**
  * A lookup table for resource handlers. The indices are defined in
  * enum fw_resource_type.
  */
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 2202c08..59b60f1 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -536,6 +536,11 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 int rproc_del(struct rproc *rproc);
 void rproc_free(struct rproc *rproc);
 
+struct rproc_mem_entry *rproc_mem_entry_init(struct device *dev,
+		void *va, dma_addr_t dma, int len, u32 da,
+		int (*release)(struct rproc *, struct rproc_mem_entry *),
+		const char *name, ...);
+
 int rproc_boot(struct rproc *rproc);
 void rproc_shutdown(struct rproc *rproc);
 void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type);
-- 
1.9.1
