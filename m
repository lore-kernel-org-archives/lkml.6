Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC293ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 05:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678EF20858
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 05:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678EF20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387899AbeGWG4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 02:56:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59250 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387880AbeGWG4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 02:56:47 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6N5rv5q135646
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 01:57:16 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kd96g08gd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 01:57:16 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Mon, 23 Jul 2018 06:57:13 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 23 Jul 2018 06:57:12 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6N5vB2k36569156
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Jul 2018 05:57:11 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5319FA4057;
        Mon, 23 Jul 2018 08:57:26 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C271FA405F;
        Mon, 23 Jul 2018 08:57:24 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.108])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 23 Jul 2018 08:57:24 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Mon, 23 Jul 2018 08:57:08 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-ia64@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 4/4] ia64: switch to NO_BOOTMEM
Date:   Mon, 23 Jul 2018 08:56:58 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532325418-22617-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1532325418-22617-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18072305-4275-0000-0000-0000029C3DB9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072305-4276-0000-0000-000037A46DCC
Message-Id: <1532325418-22617-5-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-22_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807230070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since ia64 already uses memblock to register available physical memory it
is only required to move the calls to register_active_ranges() that wrap
memblock_add_node() earlier and replace bootmem memory reservations with
memblock_reserve(). Of course, all the code that find the place to put the
bootmem bitmap is removed.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 arch/ia64/Kconfig        |  1 +
 arch/ia64/kernel/setup.c | 11 ++++++-
 arch/ia64/mm/contig.c    | 71 ++++------------------------------------------
 arch/ia64/mm/discontig.c | 74 ++++--------------------------------------------
 4 files changed, 22 insertions(+), 135 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index ff86142..107b138 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -31,6 +31,7 @@ config IA64
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP
+	select NO_BOOTMEM
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select ARCH_HAS_DMA_MARK_CLEAN
 	select ARCH_HAS_SG_CHAIN
diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
index ad43cbf..b042d0c 100644
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -32,6 +32,7 @@
 #include <linux/delay.h>
 #include <linux/cpu.h>
 #include <linux/kernel.h>
+#include <linux/memblock.h>
 #include <linux/reboot.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/clock.h>
@@ -383,8 +384,16 @@ reserve_memory (void)
 
 	sort_regions(rsvd_region, num_rsvd_regions);
 	num_rsvd_regions = merge_regions(rsvd_region, num_rsvd_regions);
-}
 
+	/* reserve all regions except the end of memory marker with meblock */
+	for (n = 0; n < num_rsvd_regions - 1; n++) {
+		struct rsvd_region *region = &rsvd_region[n];
+		phys_addr_t addr = __pa(region->start);
+		phys_addr_t size = region->end - region->start;
+
+		memblock_reserve(addr, size);
+	}
+}
 
 /**
  * find_initrd - get initrd parameters from the boot parameter structure
diff --git a/arch/ia64/mm/contig.c b/arch/ia64/mm/contig.c
index 1835144..e2e40bb 100644
--- a/arch/ia64/mm/contig.c
+++ b/arch/ia64/mm/contig.c
@@ -34,53 +34,6 @@ static unsigned long max_gap;
 /* physical address where the bootmem map is located */
 unsigned long bootmap_start;
 
-/**
- * find_bootmap_location - callback to find a memory area for the bootmap
- * @start: start of region
- * @end: end of region
- * @arg: unused callback data
- *
- * Find a place to put the bootmap and return its starting address in
- * bootmap_start.  This address must be page-aligned.
- */
-static int __init
-find_bootmap_location (u64 start, u64 end, void *arg)
-{
-	u64 needed = *(unsigned long *)arg;
-	u64 range_start, range_end, free_start;
-	int i;
-
-#if IGNORE_PFN0
-	if (start == PAGE_OFFSET) {
-		start += PAGE_SIZE;
-		if (start >= end)
-			return 0;
-	}
-#endif
-
-	free_start = PAGE_OFFSET;
-
-	for (i = 0; i < num_rsvd_regions; i++) {
-		range_start = max(start, free_start);
-		range_end   = min(end, rsvd_region[i].start & PAGE_MASK);
-
-		free_start = PAGE_ALIGN(rsvd_region[i].end);
-
-		if (range_end <= range_start)
-			continue; /* skip over empty range */
-
-		if (range_end - range_start >= needed) {
-			bootmap_start = __pa(range_start);
-			return -1;	/* done */
-		}
-
-		/* nothing more available in this segment */
-		if (range_end == end)
-			return 0;
-	}
-	return 0;
-}
-
 #ifdef CONFIG_SMP
 static void *cpu_data;
 /**
@@ -196,8 +149,6 @@ setup_per_cpu_areas(void)
 void __init
 find_memory (void)
 {
-	unsigned long bootmap_size;
-
 	reserve_memory();
 
 	/* first find highest page frame number */
@@ -205,21 +156,12 @@ find_memory (void)
 	max_low_pfn = 0;
 	efi_memmap_walk(find_max_min_low_pfn, NULL);
 	max_pfn = max_low_pfn;
-	/* how many bytes to cover all the pages */
-	bootmap_size = bootmem_bootmap_pages(max_pfn) << PAGE_SHIFT;
 
-	/* look for a location to hold the bootmap */
-	bootmap_start = ~0UL;
-	efi_memmap_walk(find_bootmap_location, &bootmap_size);
-	if (bootmap_start == ~0UL)
-		panic("Cannot find %ld bytes for bootmap\n", bootmap_size);
-
-	bootmap_size = init_bootmem_node(NODE_DATA(0),
-			(bootmap_start >> PAGE_SHIFT), 0, max_pfn);
-
-	/* Free all available memory, then mark bootmem-map as being in use. */
-	efi_memmap_walk(filter_rsvd_memory, free_bootmem);
-	reserve_bootmem(bootmap_start, bootmap_size, BOOTMEM_DEFAULT);
+#ifdef CONFIG_VIRTUAL_MEM_MAP
+	efi_memmap_walk(filter_memory, register_active_ranges);
+#else
+	memblock_add_node(0, PFN_PHYS(max_low_pfn), 0);
+#endif
 
 	find_initrd();
 
@@ -244,7 +186,6 @@ paging_init (void)
 	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
 
 #ifdef CONFIG_VIRTUAL_MEM_MAP
-	efi_memmap_walk(filter_memory, register_active_ranges);
 	efi_memmap_walk(find_largest_hole, (u64 *)&max_gap);
 	if (max_gap < LARGE_GAP) {
 		vmem_map = (struct page *) 0;
@@ -268,8 +209,6 @@ paging_init (void)
 
 		printk("Virtual mem_map starts at 0x%p\n", mem_map);
 	}
-#else /* !CONFIG_VIRTUAL_MEM_MAP */
-	memblock_add_node(0, PFN_PHYS(max_low_pfn), 0);
 #endif /* !CONFIG_VIRTUAL_MEM_MAP */
 	free_area_init_nodes(max_zone_pfns);
 	zero_page_memmap_ptr = virt_to_page(ia64_imva(empty_zero_page));
diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
index 8e99d8e..1928d57 100644
--- a/arch/ia64/mm/discontig.c
+++ b/arch/ia64/mm/discontig.c
@@ -20,6 +20,7 @@
 #include <linux/nmi.h>
 #include <linux/swap.h>
 #include <linux/bootmem.h>
+#include <linux/memblock.h>
 #include <linux/acpi.h>
 #include <linux/efi.h>
 #include <linux/nodemask.h>
@@ -264,7 +265,6 @@ static void __init fill_pernode(int node, unsigned long pernode,
 {
 	void *cpu_data;
 	int cpus = early_nr_cpus_node(node);
-	struct bootmem_data *bdp = &bootmem_node_data[node];
 
 	mem_data[node].pernode_addr = pernode;
 	mem_data[node].pernode_size = pernodesize;
@@ -279,8 +279,6 @@ static void __init fill_pernode(int node, unsigned long pernode,
 
 	mem_data[node].node_data = __va(pernode);
 	pernode += L1_CACHE_ALIGN(sizeof(struct ia64_node_data));
-
-	pgdat_list[node]->bdata = bdp;
 	pernode += L1_CACHE_ALIGN(sizeof(pg_data_t));
 
 	cpu_data = per_cpu_node_setup(cpu_data, node);
@@ -320,14 +318,11 @@ static int __init find_pernode_space(unsigned long start, unsigned long len,
 				     int node)
 {
 	unsigned long spfn, epfn;
-	unsigned long pernodesize = 0, pernode, pages, mapsize;
+	unsigned long pernodesize = 0, pernode;
 
 	spfn = start >> PAGE_SHIFT;
 	epfn = (start + len) >> PAGE_SHIFT;
 
-	pages = mem_data[node].max_pfn - mem_data[node].min_pfn;
-	mapsize = bootmem_bootmap_pages(pages) << PAGE_SHIFT;
-
 	/*
 	 * Make sure this memory falls within this node's usable memory
 	 * since we may have thrown some away in build_maps().
@@ -347,32 +342,13 @@ static int __init find_pernode_space(unsigned long start, unsigned long len,
 	pernode = NODEDATA_ALIGN(start, node);
 
 	/* Is this range big enough for what we want to store here? */
-	if (start + len > (pernode + pernodesize + mapsize))
+	if (start + len > (pernode + pernodesize))
 		fill_pernode(node, pernode, pernodesize);
 
 	return 0;
 }
 
 /**
- * free_node_bootmem - free bootmem allocator memory for use
- * @start: physical start of range
- * @len: length of range
- * @node: node where this range resides
- *
- * Simply calls the bootmem allocator to free the specified ranged from
- * the given pg_data_t's bdata struct.  After this function has been called
- * for all the entries in the EFI memory map, the bootmem allocator will
- * be ready to service allocation requests.
- */
-static int __init free_node_bootmem(unsigned long start, unsigned long len,
-				    int node)
-{
-	free_bootmem_node(pgdat_list[node], start, len);
-
-	return 0;
-}
-
-/**
  * reserve_pernode_space - reserve memory for per-node space
  *
  * Reserve the space used by the bootmem maps & per-node space in the boot
@@ -381,28 +357,17 @@ static int __init free_node_bootmem(unsigned long start, unsigned long len,
  */
 static void __init reserve_pernode_space(void)
 {
-	unsigned long base, size, pages;
-	struct bootmem_data *bdp;
+	unsigned long base, size;
 	int node;
 
 	for_each_online_node(node) {
-		pg_data_t *pdp = pgdat_list[node];
-
 		if (node_isset(node, memory_less_mask))
 			continue;
 
-		bdp = pdp->bdata;
-
-		/* First the bootmem_map itself */
-		pages = mem_data[node].max_pfn - mem_data[node].min_pfn;
-		size = bootmem_bootmap_pages(pages) << PAGE_SHIFT;
-		base = __pa(bdp->node_bootmem_map);
-		reserve_bootmem_node(pdp, base, size, BOOTMEM_DEFAULT);
-
 		/* Now the per-node space */
 		size = mem_data[node].pernode_size;
 		base = __pa(mem_data[node].pernode_addr);
-		reserve_bootmem_node(pdp, base, size, BOOTMEM_DEFAULT);
+		memblock_reserve(base, size);
 	}
 }
 
@@ -522,6 +487,7 @@ void __init find_memory(void)
 	int node;
 
 	reserve_memory();
+	efi_memmap_walk(filter_memory, register_active_ranges);
 
 	if (num_online_nodes() == 0) {
 		printk(KERN_ERR "node info missing!\n");
@@ -541,34 +507,6 @@ void __init find_memory(void)
 		if (mem_data[node].min_pfn)
 			node_clear(node, memory_less_mask);
 
-	efi_memmap_walk(filter_memory, register_active_ranges);
-
-	/*
-	 * Initialize the boot memory maps in reverse order since that's
-	 * what the bootmem allocator expects
-	 */
-	for (node = MAX_NUMNODES - 1; node >= 0; node--) {
-		unsigned long pernode, pernodesize, map;
-		struct bootmem_data *bdp;
-
-		if (!node_online(node))
-			continue;
-		else if (node_isset(node, memory_less_mask))
-			continue;
-
-		bdp = &bootmem_node_data[node];
-		pernode = mem_data[node].pernode_addr;
-		pernodesize = mem_data[node].pernode_size;
-		map = pernode + pernodesize;
-
-		init_bootmem_node(pgdat_list[node],
-				  map>>PAGE_SHIFT,
-				  mem_data[node].min_pfn,
-				  mem_data[node].max_pfn);
-	}
-
-	efi_memmap_walk(filter_rsvd_memory, free_node_bootmem);
-
 	reserve_pernode_space();
 	memory_less_nodes();
 	initialize_pernode_data();
-- 
2.7.4

