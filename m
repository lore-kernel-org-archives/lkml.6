Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033136AbeCAQ1p (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:27:45 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:37092 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1032936AbeCAQYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:24:15 -0500
From: Loic Pallardy <loic.pallardy@st.com>
To: <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH v3 02/13] remoteproc: add rproc_va_to_pa function
Date: Thu, 1 Mar 2018 17:23:49 +0100
Message-ID: <1519921440-21356-3-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519921440-21356-1-git-send-email-loic.pallardy@st.com>
References: <1519921440-21356-1-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG7NODE2.st.com
 (10.75.127.20)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new function translates CPU virtual address in
CPU physical one according to virtual address location.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 56b33e4..eb1b779 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -139,6 +139,22 @@ static void rproc_disable_iommu(struct rproc *rproc)
 	iommu_domain_free(domain);
 }
 
+static phys_addr_t rproc_va_to_pa(void *cpu_addr)
+{
+	/*
+	 * Return physical address according to virtual address location
+	 * - in vmalloc: if region ioremapped or defined as dma_alloc_coherent
+	 * - in kernel: if region allocated in generic dma memory pool
+	 */
+	if (is_vmalloc_addr(cpu_addr)) {
+		return page_to_phys(vmalloc_to_page(cpu_addr)) +
+				    offset_in_page(cpu_addr);
+	}
+
+	WARN_ON(!virt_addr_valid(cpu_addr));
+	return virt_to_phys(cpu_addr);
+}
+
 /**
  * rproc_da_to_va() - lookup the kernel virtual address for a remoteproc address
  * @rproc: handle of a remote processor
@@ -708,7 +724,7 @@ static int rproc_handle_carveout(struct rproc *rproc,
 	 * In this case, the device address and the physical address
 	 * are the same.
 	 */
-	rsc->pa = dma;
+	rsc->pa = (u32)rproc_va_to_pa(va);
 
 	carveout->va = va;
 	carveout->len = rsc->len;
-- 
1.9.1
