Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033101AbeCAQ0K (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:26:10 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:50735 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1032981AbeCAQYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:24:19 -0500
From: Loic Pallardy <loic.pallardy@st.com>
To: <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH v3 09/13] remoteproc: modify rproc_handle_carveout to support pre-registered region
Date: Thu, 1 Mar 2018 17:23:56 +0100
Message-ID: <1519921440-21356-10-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519921440-21356-1-git-send-email-loic.pallardy@st.com>
References: <1519921440-21356-1-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG7NODE2.st.com
 (10.75.127.20)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current version rproc_handle_carveout function support only dynamic
region allocation.
This patch extends rproc_handle_carveout function to support pre-registered
region. Match is done on region name, then requested device address and
length are checked.
If no name match found, original allocation is used.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 49 +++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 0ebbc4f..49b28a0 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -679,7 +679,7 @@ static int rproc_handle_carveout(struct rproc *rproc,
 				 struct fw_rsc_carveout *rsc,
 				 int offset, int avail)
 {
-	struct rproc_mem_entry *carveout, *mapping = NULL;
+	struct rproc_mem_entry *carveout, *mapping = NULL, *mem;
 	struct device *dev = &rproc->dev;
 	dma_addr_t dma;
 	void *va;
@@ -699,6 +699,51 @@ static int rproc_handle_carveout(struct rproc *rproc,
 	dev_dbg(dev, "carveout rsc: name: %s, da 0x%x, pa 0x%x, len 0x%x, flags 0x%x\n",
 		rsc->name, rsc->da, rsc->pa, rsc->len, rsc->flags);
 
+	/* Check carveout rsc already part of a registered carveout */
+	/* Search by name */
+	mem = rproc_find_carveout_by_name(rproc, rsc->name);
+	if (mem) {
+		int delta = 0;
+
+		if (rsc->da != FW_RSC_ADDR_ANY) {
+			delta = rsc->da - mem->da;
+
+			/* Check requested resource belongs to registered carveout */
+			if (delta < 0) {
+				dev_err(dev->parent,
+					"Registered carveout doesn't fit da request\n");
+				return -ENOMEM;
+			}
+
+			if (delta + rsc->len > mem->len) {
+				dev_err(dev->parent,
+					"Registered carveout doesn't fit len request\n");
+				return -ENOMEM;
+			}
+		} else {
+			/* Check requested resource length */
+			if (rsc->len > mem->len) {
+				dev_err(dev->parent,
+					"Registered carveout doesn't fit len request\n");
+				return -ENOMEM;
+			}
+			/* Update resource da with registered resource value */
+			rsc->da = mem->da;
+		}
+
+		/*
+		 * Update resource pa
+		 * Use va if defined else dma to generate pa
+		 */
+		if (mem->va)
+			rsc->pa = rproc_va_to_pa(mem->va) + delta;
+		else
+			rsc->pa = (u32)mem->dma + delta;
+
+		return 0;
+	}
+
+	/* No registered carveout found, allocate a new one */
 	va = dma_alloc_coherent(dev->parent, rsc->len, &dma, GFP_KERNEL);
 	if (!va) {
 		dev_err(dev->parent,
@@ -761,6 +806,8 @@ static int rproc_handle_carveout(struct rproc *rproc,
 
 		dev_dbg(dev, "carveout mapped 0x%x to %pad\n",
 			rsc->da, &dma);
+	} else {
+		rsc->da = (u32)dma;
 	}
 
 	/*
-- 
1.9.1
