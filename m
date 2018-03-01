Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032993AbeCAQYT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:24:19 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43966 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1032698AbeCAQYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:24:16 -0500
From: Loic Pallardy <loic.pallardy@st.com>
To: <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH v3 04/13] remoteproc: add name in rproc_mem_entry struct
Date: Thu, 1 Mar 2018 17:23:51 +0100
Message-ID: <1519921440-21356-5-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519921440-21356-1-git-send-email-loic.pallardy@st.com>
References: <1519921440-21356-1-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG7NODE2.st.com
 (10.75.127.20)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add name field in struct rproc_mem_entry.
This new field will be used to match memory area
requested in resource table with pre-registered carveout.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
---
 drivers/remoteproc/remoteproc_core.c    | 1 +
 drivers/remoteproc/remoteproc_debugfs.c | 1 +
 include/linux/remoteproc.h              | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 5f11536..f73a0cf 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -749,6 +749,7 @@ static int rproc_handle_carveout(struct rproc *rproc,
 	carveout->dma = dma;
 	carveout->da = rsc->da;
 	carveout->release = rproc_release_carveout;
+	strlcpy(carveout->name, rsc->name, sizeof(carveout->name));
 
 	list_add_tail(&carveout->node, &rproc->carveouts);
 
diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
index a204883..fc0e570 100644
--- a/drivers/remoteproc/remoteproc_debugfs.c
+++ b/drivers/remoteproc/remoteproc_debugfs.c
@@ -260,6 +260,7 @@ static int rproc_carveouts_show(struct seq_file *seq, void *p)
 
 	list_for_each_entry(carveout, &rproc->carveouts, node) {
 		seq_puts(seq, "Carveout memory entry:\n");
+		seq_printf(seq, "\tName: %s\n", carveout->name);
 		seq_printf(seq, "\tVirtual address: %p\n", carveout->va);
 		seq_printf(seq, "\tDMA address: %pad\n", &carveout->dma);
 		seq_printf(seq, "\tDevice address: 0x%x\n", carveout->da);
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index dedc138..2202c08 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -315,6 +315,7 @@ struct fw_rsc_vdev {
  * @da: device address
  * @release: release associated memory
  * @priv: associated data
+ * @name: associated memory region name (optional)
  * @node: list node
  */
 struct rproc_mem_entry {
@@ -323,6 +324,7 @@ struct rproc_mem_entry {
 	int len;
 	u32 da;
 	void *priv;
+	char name[32];
 	struct list_head node;
 	int (*release)(struct rproc *rproc, struct rproc_mem_entry *mem);
 };
-- 
1.9.1
