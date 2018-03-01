Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033073AbeCAQ1H (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:27:07 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:31503 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1032975AbeCAQYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:24:17 -0500
From: Loic Pallardy <loic.pallardy@st.com>
To: <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH v3 06/13] remoteproc: introduce rproc_add_carveout function
Date: Thu, 1 Mar 2018 17:23:53 +0100
Message-ID: <1519921440-21356-7-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519921440-21356-1-git-send-email-loic.pallardy@st.com>
References: <1519921440-21356-1-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG7NODE2.st.com
 (10.75.127.20)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a new API to allow platform driver to register
platform specific carveout regions.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 14 ++++++++++++++
 include/linux/remoteproc.h           |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 4c92b7d..91aa22b 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -758,6 +758,20 @@ static int rproc_handle_carveout(struct rproc *rproc,
 }
 
 /**
+ * rproc_add_carveout() - register an allocated carveout region
+ * @rproc: rproc handle
+ * @mem: memory entry to register
+ *
+ * This function registers specified memory entry in @rproc carveouts list.
+ * Specified carveout should have been allocated before registering.
+ */
+void rproc_add_carveout(struct rproc *rproc, struct rproc_mem_entry *mem)
+{
+	list_add_tail(&mem->node, &rproc->carveouts);
+}
+EXPORT_SYMBOL(rproc_add_carveout);
+
+/**
  * rproc_mem_entry_init() - allocate and initialize rproc_mem_entry struct
  * @dev: pointer on device struct
  * @va: virtual address
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 59b60f1..4aa30bd 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -536,6 +536,8 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 int rproc_del(struct rproc *rproc);
 void rproc_free(struct rproc *rproc);
 
+void rproc_add_carveout(struct rproc *rproc, struct rproc_mem_entry *mem);
+
 struct rproc_mem_entry *rproc_mem_entry_init(struct device *dev,
 		void *va, dma_addr_t dma, int len, u32 da,
 		int (*release)(struct rproc *, struct rproc_mem_entry *),
-- 
1.9.1
