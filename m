Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A909AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83AF92176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbeLTI0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 03:26:09 -0500
Received: from ozlabs.ru ([107.173.13.209]:54238 "EHLO ozlabs.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730882AbeLTIYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 03:24:19 -0500
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
        by ozlabs.ru (Postfix) with ESMTP id D3A1CAE802F9;
        Thu, 20 Dec 2018 03:24:15 -0500 (EST)
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
        Alistair Popple <alistair@popple.id.au>,
        Reza Arbab <arbab@linux.ibm.com>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Piotr Jaroszynski <pjaroszynski@nvidia.com>,
        =?UTF-8?q?Leonardo=20Augusto=20Guimar=C3=A3es=20Garcia?= 
        <lagarcia@br.ibm.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>,
        Daniel Henrique Barboza <danielhb413@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: [PATCH kernel v7 06/20] powerpc/pseries/iommu: Use memory@ nodes in max RAM address calculation
Date:   Thu, 20 Dec 2018 19:23:36 +1100
Message-Id: <20181220082350.58113-7-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181220082350.58113-1-aik@ozlabs.ru>
References: <20181220082350.58113-1-aik@ozlabs.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We might have memory@ nodes with "linux,usable-memory" set to zero
(for example, to replicate powernv's behaviour for GPU coherent memory)
which means that the memory needs an extra initialization but since
it can be used afterwards, the pseries platform will try mapping it
for DMA so the DMA window needs to cover those memory regions too;
if the window cannot cover new memory regions, the memory onlining fails.

This walks through the memory nodes to find the highest RAM address to
let a huge DMA window cover that too in case this memory gets onlined
later.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v4:
* uses of_read_number directly instead of cut-n-pasted read_n_cells
---
 arch/powerpc/platforms/pseries/iommu.c | 33 +++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 06f0296..cbcc8ce 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -964,6 +964,37 @@ struct failed_ddw_pdn {
 
 static LIST_HEAD(failed_ddw_pdn_list);
 
+static phys_addr_t ddw_memory_hotplug_max(void)
+{
+	phys_addr_t max_addr = memory_hotplug_max();
+	struct device_node *memory;
+
+	for_each_node_by_type(memory, "memory") {
+		unsigned long start, size;
+		int ranges, n_mem_addr_cells, n_mem_size_cells, len;
+		const __be32 *memcell_buf;
+
+		memcell_buf = of_get_property(memory, "reg", &len);
+		if (!memcell_buf || len <= 0)
+			continue;
+
+		n_mem_addr_cells = of_n_addr_cells(memory);
+		n_mem_size_cells = of_n_size_cells(memory);
+
+		/* ranges in cell */
+		ranges = (len >> 2) / (n_mem_addr_cells + n_mem_size_cells);
+
+		start = of_read_number(memcell_buf, n_mem_addr_cells);
+		memcell_buf += n_mem_addr_cells;
+		size = of_read_number(memcell_buf, n_mem_size_cells);
+		memcell_buf += n_mem_size_cells;
+
+		max_addr = max_t(phys_addr_t, max_addr, start + size);
+	}
+
+	return max_addr;
+}
+
 /*
  * If the PE supports dynamic dma windows, and there is space for a table
  * that can map all pages in a linear offset, then setup such a table,
@@ -1053,7 +1084,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	}
 	/* verify the window * number of ptes will map the partition */
 	/* check largest block * page size > max memory hotplug addr */
-	max_addr = memory_hotplug_max();
+	max_addr = ddw_memory_hotplug_max();
 	if (query.largest_available_block < (max_addr >> page_shift)) {
 		dev_dbg(&dev->dev, "can't map partition max 0x%llx with %u "
 			  "%llu-sized pages\n", max_addr,  query.largest_available_block,
-- 
2.17.1

