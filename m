Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753206AbeEKNqE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 09:46:04 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:34021 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752578AbeEKNqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 09:46:02 -0400
X-Google-Smtp-Source: AB8JxZrnOUi5GOXG6GXrS756x1Y/xLqWTOGj4yRMQSDxr6tJimXsIzQj0YfP75BhjjgGpgSwEVG9cw==
From: Rob Herring <robh@kernel.org>
To: Rich Felker <dalias@libc.org>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH] sh: switch to NO_BOOTMEM
Date: Fri, 11 May 2018 08:45:59 -0500
Message-Id: <20180511134559.13464-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0fa1c579349f ("of/fdt: use memblock_virt_alloc for early alloc")
inadvertently switched the DT unflattening allocations from memblock to
bootmem which doesn't work because the unflattening happens before
bootmem is initialized. Swapping the order of bootmem init and
unflattening could also fix this, but removing bootmem is desired. So
enable NO_BOOTMEM on SH like other architectures have done.

Fixes: 0fa1c579349f ("of/fdt: use memblock_virt_alloc for early alloc")
Reported-by: Rich Felker <dalias@libc.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Rob Herring <robh@kernel.org>
---
This is compile tested only, but similar to microblaze and h8300 
conversions. The additional complexity for SH is NUMA support (which to 
me looks like an abuse of NUMA support to map a small amount of 
on-chip? RAM to NUMA nodes). 

 arch/sh/Kconfig        |  1 +
 arch/sh/kernel/setup.c |  1 -
 arch/sh/mm/init.c      | 68 ++++--------------------------------------
 arch/sh/mm/numa.c      | 19 ------------
 4 files changed, 7 insertions(+), 82 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 97fe29316476..1851eaeee131 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -9,6 +9,7 @@ config SUPERH
 	select HAVE_IDE if HAS_IOPORT_MAP
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP
+	select NO_BOOTMEM
 	select ARCH_DISCARD_MEMBLOCK
 	select HAVE_OPROFILE
 	select HAVE_GENERIC_DMA_COHERENT
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index d34e998b809f..c286cf5da6e7 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -11,7 +11,6 @@
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/initrd.h>
-#include <linux/bootmem.h>
 #include <linux/console.h>
 #include <linux/root_dev.h>
 #include <linux/utsname.h>
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index ce0bbaa7e404..4034035fbede 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -211,59 +211,15 @@ void __init allocate_pgdat(unsigned int nid)
 
 	NODE_DATA(nid) = __va(phys);
 	memset(NODE_DATA(nid), 0, sizeof(struct pglist_data));
-
-	NODE_DATA(nid)->bdata = &bootmem_node_data[nid];
 #endif
 
 	NODE_DATA(nid)->node_start_pfn = start_pfn;
 	NODE_DATA(nid)->node_spanned_pages = end_pfn - start_pfn;
 }
 
-static void __init bootmem_init_one_node(unsigned int nid)
-{
-	unsigned long total_pages, paddr;
-	unsigned long end_pfn;
-	struct pglist_data *p;
-
-	p = NODE_DATA(nid);
-
-	/* Nothing to do.. */
-	if (!p->node_spanned_pages)
-		return;
-
-	end_pfn = pgdat_end_pfn(p);
-
-	total_pages = bootmem_bootmap_pages(p->node_spanned_pages);
-
-	paddr = memblock_alloc(total_pages << PAGE_SHIFT, PAGE_SIZE);
-	if (!paddr)
-		panic("Can't allocate bootmap for nid[%d]\n", nid);
-
-	init_bootmem_node(p, paddr >> PAGE_SHIFT, p->node_start_pfn, end_pfn);
-
-	free_bootmem_with_active_regions(nid, end_pfn);
-
-	/*
-	 * XXX Handle initial reservations for the system memory node
-	 * only for the moment, we'll refactor this later for handling
-	 * reservations in other nodes.
-	 */
-	if (nid == 0) {
-		struct memblock_region *reg;
-
-		/* Reserve the sections we're already using. */
-		for_each_memblock(reserved, reg) {
-			reserve_bootmem(reg->base, reg->size, BOOTMEM_DEFAULT);
-		}
-	}
-
-	sparse_memory_present_with_active_regions(nid);
-}
-
 static void __init do_init_bootmem(void)
 {
 	struct memblock_region *reg;
-	int i;
 
 	/* Add active regions with valid PFNs. */
 	for_each_memblock(memory, reg) {
@@ -279,9 +235,12 @@ static void __init do_init_bootmem(void)
 
 	plat_mem_setup();
 
-	for_each_online_node(i)
-		bootmem_init_one_node(i);
+	for_each_memblock(memory, reg) {
+		int nid = memblock_get_region_node(reg);
 
+		memory_present(nid, memblock_region_memory_base_pfn(reg),
+			memblock_region_memory_end_pfn(reg));
+	}
 	sparse_init();
 }
 
@@ -322,7 +281,6 @@ void __init paging_init(void)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES];
 	unsigned long vaddr, end;
-	int nid;
 
 	sh_mv.mv_mem_init();
 
@@ -377,21 +335,7 @@ void __init paging_init(void)
 	kmap_coherent_init();
 
 	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
-
-	for_each_online_node(nid) {
-		pg_data_t *pgdat = NODE_DATA(nid);
-		unsigned long low, start_pfn;
-
-		start_pfn = pgdat->bdata->node_min_pfn;
-		low = pgdat->bdata->node_low_pfn;
-
-		if (max_zone_pfns[ZONE_NORMAL] < low)
-			max_zone_pfns[ZONE_NORMAL] = low;
-
-		printk("Node %u: start_pfn = 0x%lx, low = 0x%lx\n",
-		       nid, start_pfn, low);
-	}
-
+	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
 	free_area_init_nodes(max_zone_pfns);
 }
 
diff --git a/arch/sh/mm/numa.c b/arch/sh/mm/numa.c
index 05713d190247..830e8b3684e4 100644
--- a/arch/sh/mm/numa.c
+++ b/arch/sh/mm/numa.c
@@ -8,7 +8,6 @@
  * for more details.
  */
 #include <linux/module.h>
-#include <linux/bootmem.h>
 #include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/numa.h>
@@ -26,9 +25,7 @@ EXPORT_SYMBOL_GPL(node_data);
  */
 void __init setup_bootmem_node(int nid, unsigned long start, unsigned long end)
 {
-	unsigned long bootmap_pages;
 	unsigned long start_pfn, end_pfn;
-	unsigned long bootmem_paddr;
 
 	/* Don't allow bogus node assignment */
 	BUG_ON(nid >= MAX_NUMNODES || nid <= 0);
@@ -48,25 +45,9 @@ void __init setup_bootmem_node(int nid, unsigned long start, unsigned long end)
 					     SMP_CACHE_BYTES, end));
 	memset(NODE_DATA(nid), 0, sizeof(struct pglist_data));
 
-	NODE_DATA(nid)->bdata = &bootmem_node_data[nid];
 	NODE_DATA(nid)->node_start_pfn = start_pfn;
 	NODE_DATA(nid)->node_spanned_pages = end_pfn - start_pfn;
 
-	/* Node-local bootmap */
-	bootmap_pages = bootmem_bootmap_pages(end_pfn - start_pfn);
-	bootmem_paddr = memblock_alloc_base(bootmap_pages << PAGE_SHIFT,
-				       PAGE_SIZE, end);
-	init_bootmem_node(NODE_DATA(nid), bootmem_paddr >> PAGE_SHIFT,
-			  start_pfn, end_pfn);
-
-	free_bootmem_with_active_regions(nid, end_pfn);
-
-	/* Reserve the pgdat and bootmap space with the bootmem allocator */
-	reserve_bootmem_node(NODE_DATA(nid), start_pfn << PAGE_SHIFT,
-			     sizeof(struct pglist_data), BOOTMEM_DEFAULT);
-	reserve_bootmem_node(NODE_DATA(nid), bootmem_paddr,
-			     bootmap_pages << PAGE_SHIFT, BOOTMEM_DEFAULT);
-
 	/* It's up */
 	node_set_online(nid);
 
-- 
2.17.0
