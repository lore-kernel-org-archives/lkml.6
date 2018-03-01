Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033149AbeCAQ1r (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:27:47 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:19567 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1032933AbeCAQYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:24:14 -0500
From: Loic Pallardy <loic.pallardy@st.com>
To: <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH v3 03/13] remoteproc: add release ops in rproc_mem_entry struct
Date: Thu, 1 Mar 2018 17:23:50 +0100
Message-ID: <1519921440-21356-4-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519921440-21356-1-git-send-email-loic.pallardy@st.com>
References: <1519921440-21356-1-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG7NODE2.st.com
 (10.75.127.20)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory entry could be allocated in different ways (ioremap,
dma_alloc_coherent, internal RAM allocator...).
This patch introduces a release ops in rproc_mem_entry structure
to associate dedicated release mechanism to each memory entry descriptor
in order to keep remoteproc core generic.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 23 +++++++++++++++++++++--
 include/linux/remoteproc.h           |  5 ++++-
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index eb1b779..5f11536 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -597,6 +597,24 @@ static int rproc_handle_devmem(struct rproc *rproc, struct fw_rsc_devmem *rsc,
 }
 
 /**
+ * rproc_release_carveout() - release acquired carveout
+ * @rproc: rproc handle
+ * @mem: the memory entry to release
+ *
+ * This function releases specified memory entry @mem allocated via
+ * dma_alloc_coherent() function by @rproc.
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
  * rproc_handle_carveout() - handle phys contig memory allocation requests
  * @rproc: rproc handle
  * @rsc: the resource entry
@@ -730,6 +748,7 @@ static int rproc_handle_carveout(struct rproc *rproc,
 	carveout->len = rsc->len;
 	carveout->dma = dma;
 	carveout->da = rsc->da;
+	carveout->release = rproc_release_carveout;
 
 	list_add_tail(&carveout->node, &rproc->carveouts);
 
@@ -863,8 +882,8 @@ static void rproc_resource_cleanup(struct rproc *rproc)
 
 	/* clean up carveout allocations */
 	list_for_each_entry_safe(entry, tmp, &rproc->carveouts, node) {
-		dma_free_coherent(dev->parent, entry->len, entry->va,
-				  entry->dma);
+		if (entry->release)
+			entry->release(rproc, entry);
 		list_del(&entry->node);
 		kfree(entry);
 	}
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 728d421..dedc138 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -305,12 +305,15 @@ struct fw_rsc_vdev {
 	struct fw_rsc_vdev_vring vring[0];
 } __packed;
 
+struct rproc;
+
 /**
  * struct rproc_mem_entry - memory entry descriptor
  * @va:	virtual address
  * @dma: dma address
  * @len: length, in bytes
  * @da: device address
+ * @release: release associated memory
  * @priv: associated data
  * @node: list node
  */
@@ -321,9 +324,9 @@ struct rproc_mem_entry {
 	u32 da;
 	void *priv;
 	struct list_head node;
+	int (*release)(struct rproc *rproc, struct rproc_mem_entry *mem);
 };
 
-struct rproc;
 struct firmware;
 
 /**
-- 
1.9.1
