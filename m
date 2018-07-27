Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE957C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B01E208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B01E208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388925AbeG0Oij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:38:39 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:31524 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732452AbeG0OhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:37:20 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w6RDEOMl020459;
        Fri, 27 Jul 2018 15:15:22 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2kg25fgjtj-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 27 Jul 2018 15:15:22 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6DCCA3D;
        Fri, 27 Jul 2018 13:15:21 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag7node2.st.com [10.75.127.20])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 49C0A577A;
        Fri, 27 Jul 2018 13:15:21 +0000 (GMT)
Received: from localhost (10.75.127.51) by SFHDAG7NODE2.st.com (10.75.127.20)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 27 Jul 2018 15:15:20
 +0200
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <s-anna@ti.com>, Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH v4 03/17] remoteproc: add release ops in rproc_mem_entry struct
Date:   Fri, 27 Jul 2018 15:14:38 +0200
Message-ID: <1532697292-14272-4-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG7NODE2.st.com
 (10.75.127.20)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory entry could be allocated in different ways (ioremap,
dma_alloc_coherent, internal RAM allocator...).
This patch introduces a release ops in rproc_mem_entry structure
to associate dedicated release mechanism to each memory entry descriptor
in order to keep remoteproc core generic.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 23 +++++++++++++++++++++--
 include/linux/remoteproc.h           |  5 ++++-
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 8e5fe1e..24fe11f 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -600,6 +600,24 @@ static int rproc_handle_devmem(struct rproc *rproc, struct fw_rsc_devmem *rsc,
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
@@ -733,6 +751,7 @@ static int rproc_handle_carveout(struct rproc *rproc,
 	carveout->len = rsc->len;
 	carveout->dma = dma;
 	carveout->da = rsc->da;
+	carveout->release = rproc_release_carveout;
 
 	list_add_tail(&carveout->node, &rproc->carveouts);
 
@@ -920,8 +939,8 @@ static void rproc_resource_cleanup(struct rproc *rproc)
 
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
index e3c5d85..bef2e83 100644
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

