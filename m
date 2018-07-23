Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8B9ECDFBB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 05:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080CA20875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 05:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 080CA20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387873AbeGWG4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 02:56:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39448 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728401AbeGWG4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 02:56:45 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6N5s1AW063782
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 01:57:14 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kd50d08tk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 01:57:13 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Mon, 23 Jul 2018 06:57:12 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 23 Jul 2018 06:57:09 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6N5v9wW42729666
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Jul 2018 05:57:09 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0694E4C044;
        Mon, 23 Jul 2018 08:57:25 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8034F4C040;
        Mon, 23 Jul 2018 08:57:23 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.108])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 23 Jul 2018 08:57:23 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Mon, 23 Jul 2018 08:57:06 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-ia64@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 3/4] ia64: use mem_data to detect nodes' minimal and maximal PFNs
Date:   Mon, 23 Jul 2018 08:56:57 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532325418-22617-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1532325418-22617-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18072305-0008-0000-0000-000002565301
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072305-0009-0000-0000-000021BCBE8E
Message-Id: <1532325418-22617-4-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-22_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=931 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807230070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When EFI memory map is traversed to determine the extents of each node, the
minimal and maximal PFNs are stored in the bootmem_data structures. The
same information ls later stored in the mem_data array of 'struct
early_node_data'.

Switch to using mem_data from the very beginning.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 arch/ia64/mm/discontig.c | 60 +++++++++++-------------------------------------
 1 file changed, 14 insertions(+), 46 deletions(-)

diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
index 6148ea8..8e99d8e 100644
--- a/arch/ia64/mm/discontig.c
+++ b/arch/ia64/mm/discontig.c
@@ -57,33 +57,31 @@ pg_data_t *pgdat_list[MAX_NUMNODES];
 	     (((node)*PERCPU_PAGE_SIZE) & (MAX_NODE_ALIGN_OFFSET - 1)))
 
 /**
- * build_node_maps - callback to setup bootmem structs for each node
+ * build_node_maps - callback to setup mem_data structs for each node
  * @start: physical start of range
  * @len: length of range
  * @node: node where this range resides
  *
- * We allocate a struct bootmem_data for each piece of memory that we wish to
+ * Detect extents of each piece of memory that we wish to
  * treat as a virtually contiguous block (i.e. each node). Each such block
  * must start on an %IA64_GRANULE_SIZE boundary, so we round the address down
  * if necessary.  Any non-existent pages will simply be part of the virtual
- * memmap.  We also update min_low_pfn and max_low_pfn here as we receive
- * memory ranges from the caller.
+ * memmap.
  */
 static int __init build_node_maps(unsigned long start, unsigned long len,
 				  int node)
 {
 	unsigned long spfn, epfn, end = start + len;
-	struct bootmem_data *bdp = &bootmem_node_data[node];
 
 	epfn = GRANULEROUNDUP(end) >> PAGE_SHIFT;
 	spfn = GRANULEROUNDDOWN(start) >> PAGE_SHIFT;
 
-	if (!bdp->node_low_pfn) {
-		bdp->node_min_pfn = spfn;
-		bdp->node_low_pfn = epfn;
+	if (!mem_data[node].min_pfn) {
+		mem_data[node].min_pfn = spfn;
+		mem_data[node].max_pfn = epfn;
 	} else {
-		bdp->node_min_pfn = min(spfn, bdp->node_min_pfn);
-		bdp->node_low_pfn = max(epfn, bdp->node_low_pfn);
+		mem_data[node].min_pfn = min(spfn, mem_data[node].min_pfn);
+		mem_data[node].max_pfn = max(epfn, mem_data[node].max_pfn);
 	}
 
 	return 0;
@@ -323,19 +321,18 @@ static int __init find_pernode_space(unsigned long start, unsigned long len,
 {
 	unsigned long spfn, epfn;
 	unsigned long pernodesize = 0, pernode, pages, mapsize;
-	struct bootmem_data *bdp = &bootmem_node_data[node];
 
 	spfn = start >> PAGE_SHIFT;
 	epfn = (start + len) >> PAGE_SHIFT;
 
-	pages = bdp->node_low_pfn - bdp->node_min_pfn;
+	pages = mem_data[node].max_pfn - mem_data[node].min_pfn;
 	mapsize = bootmem_bootmap_pages(pages) << PAGE_SHIFT;
 
 	/*
 	 * Make sure this memory falls within this node's usable memory
 	 * since we may have thrown some away in build_maps().
 	 */
-	if (spfn < bdp->node_min_pfn || epfn > bdp->node_low_pfn)
+	if (spfn < mem_data[node].min_pfn || epfn > mem_data[node].max_pfn)
 		return 0;
 
 	/* Don't setup this node's local space twice... */
@@ -397,7 +394,7 @@ static void __init reserve_pernode_space(void)
 		bdp = pdp->bdata;
 
 		/* First the bootmem_map itself */
-		pages = bdp->node_low_pfn - bdp->node_min_pfn;
+		pages = mem_data[node].max_pfn - mem_data[node].min_pfn;
 		size = bootmem_bootmap_pages(pages) << PAGE_SHIFT;
 		base = __pa(bdp->node_bootmem_map);
 		reserve_bootmem_node(pdp, base, size, BOOTMEM_DEFAULT);
@@ -541,10 +538,8 @@ void __init find_memory(void)
 	efi_memmap_walk(find_max_min_low_pfn, NULL);
 
 	for_each_online_node(node)
-		if (bootmem_node_data[node].node_low_pfn) {
+		if (mem_data[node].min_pfn)
 			node_clear(node, memory_less_mask);
-			mem_data[node].min_pfn = ~0UL;
-		}
 
 	efi_memmap_walk(filter_memory, register_active_ranges);
 
@@ -568,8 +563,8 @@ void __init find_memory(void)
 
 		init_bootmem_node(pgdat_list[node],
 				  map>>PAGE_SHIFT,
-				  bdp->node_min_pfn,
-				  bdp->node_low_pfn);
+				  mem_data[node].min_pfn,
+				  mem_data[node].max_pfn);
 	}
 
 	efi_memmap_walk(filter_rsvd_memory, free_node_bootmem);
@@ -652,31 +647,6 @@ void call_pernode_memory(unsigned long start, unsigned long len, void *arg)
 }
 
 /**
- * count_node_pages - callback to build per-node memory info structures
- * @start: physical start of range
- * @len: length of range
- * @node: node where this range resides
- *
- * Each node has it's own number of physical pages, DMAable pages, start, and
- * end page frame number.  This routine will be called by call_pernode_memory()
- * for each piece of usable memory and will setup these values for each node.
- * Very similar to build_maps().
- */
-static __init int count_node_pages(unsigned long start, unsigned long len, int node)
-{
-	unsigned long end = start + len;
-
-	start = GRANULEROUNDDOWN(start);
-	end = GRANULEROUNDUP(end);
-	mem_data[node].max_pfn = max(mem_data[node].max_pfn,
-				     end >> PAGE_SHIFT);
-	mem_data[node].min_pfn = min(mem_data[node].min_pfn,
-				     start >> PAGE_SHIFT);
-
-	return 0;
-}
-
-/**
  * paging_init - setup page tables
  *
  * paging_init() sets up the page tables for each node of the system and frees
@@ -692,8 +662,6 @@ void __init paging_init(void)
 
 	max_dma = virt_to_phys((void *) MAX_DMA_ADDRESS) >> PAGE_SHIFT;
 
-	efi_memmap_walk(filter_rsvd_memory, count_node_pages);
-
 	sparse_memory_present_with_active_regions(MAX_NUMNODES);
 	sparse_init();
 
-- 
2.7.4

