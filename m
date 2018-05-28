Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033164AbeE1KUZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:20:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033118AbeE1KUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:20:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Alvaro Gamez Machado <alvaro.gamez@hazent.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 137/268] microblaze: switch to NO_BOOTMEM
Date: Mon, 28 May 2018 12:01:51 +0200
Message-Id: <20180528100217.757727910@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Herring <robh@kernel.org>

[ Upstream commit 101646a24a2f9cdb61d7732459fbf068a7bbb542 ]

Microblaze doesn't set CONFIG_NO_BOOTMEM and so memblock_virt_alloc()
doesn't work for CONFIG_HAVE_MEMBLOCK && !CONFIG_NO_BOOTMEM.

Similar change was already done by others architectures
"ARM: mm: Remove bootmem code and switch to NO_BOOTMEM"
(sha1: 84f452b1e8fc73ac0e31254c66e3e2260ce5263d)
or
"openrisc: Consolidate setup to use memblock instead of bootmem"
(sha1: 266c7fad157265bb54d17db1c9545f2aaa488643)
or
"parisc: Drop bootmem and switch to memblock"
(sha1: 4fe9e1d957e45ad8eba9885ee860a0e93d13a7c7)
or
"powerpc: Remove bootmem allocator"
(sha1: 10239733ee8617bac3f1c1769af43a88ed979324)
or
"s390/mm: Convert bootmem to memblock"
(sha1: 50be634507284eea38df78154d22615d21200b42)
or
"sparc64: Convert over to NO_BOOTMEM."
(sha1: 625d693e9784f988371e69c2b41a2172c0be6c11)
or
"xtensa: drop sysmem and switch to memblock"
(sha1: 0e46c1115f5816949220d62dd3ff04aa68e7ac6b)

Issue was introduced by:
"of/fdt: use memblock_virt_alloc for early alloc"
(sha1: 0fa1c579349fdd90173381712ad78aa99c09d38b)

Signed-off-by: Rob Herring <robh@kernel.org>
Tested-by: Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Tested-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/microblaze/Kconfig   |    1 
 arch/microblaze/mm/init.c |   56 ++++------------------------------------------
 2 files changed, 7 insertions(+), 50 deletions(-)

--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -24,6 +24,7 @@ config MICROBLAZE
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
+	select NO_BOOTMEM
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_OPROFILE
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -32,9 +32,6 @@ int mem_init_done;
 #ifndef CONFIG_MMU
 unsigned int __page_offset;
 EXPORT_SYMBOL(__page_offset);
-
-#else
-static int init_bootmem_done;
 #endif /* CONFIG_MMU */
 
 char *klimit = _end;
@@ -117,7 +114,6 @@ static void __init paging_init(void)
 
 void __init setup_memory(void)
 {
-	unsigned long map_size;
 	struct memblock_region *reg;
 
 #ifndef CONFIG_MMU
@@ -174,17 +170,6 @@ void __init setup_memory(void)
 	pr_info("%s: max_low_pfn: %#lx\n", __func__, max_low_pfn);
 	pr_info("%s: max_pfn: %#lx\n", __func__, max_pfn);
 
-	/*
-	 * Find an area to use for the bootmem bitmap.
-	 * We look for the first area which is at least
-	 * 128kB in length (128kB is enough for a bitmap
-	 * for 4GB of memory, using 4kB pages), plus 1 page
-	 * (in case the address isn't page-aligned).
-	 */
-	map_size = init_bootmem_node(NODE_DATA(0),
-		PFN_UP(TOPHYS((u32)klimit)), min_low_pfn, max_low_pfn);
-	memblock_reserve(PFN_UP(TOPHYS((u32)klimit)) << PAGE_SHIFT, map_size);
-
 	/* Add active regions with valid PFNs */
 	for_each_memblock(memory, reg) {
 		unsigned long start_pfn, end_pfn;
@@ -196,32 +181,9 @@ void __init setup_memory(void)
 				  &memblock.memory, 0);
 	}
 
-	/* free bootmem is whole main memory */
-	free_bootmem_with_active_regions(0, max_low_pfn);
-
-	/* reserve allocate blocks */
-	for_each_memblock(reserved, reg) {
-		unsigned long top = reg->base + reg->size - 1;
-
-		pr_debug("reserved - 0x%08x-0x%08x, %lx, %lx\n",
-			 (u32) reg->base, (u32) reg->size, top,
-						memory_start + lowmem_size - 1);
-
-		if (top <= (memory_start + lowmem_size - 1)) {
-			reserve_bootmem(reg->base, reg->size, BOOTMEM_DEFAULT);
-		} else if (reg->base < (memory_start + lowmem_size - 1)) {
-			unsigned long trunc_size = memory_start + lowmem_size -
-								reg->base;
-			reserve_bootmem(reg->base, trunc_size, BOOTMEM_DEFAULT);
-		}
-	}
-
 	/* XXX need to clip this if using highmem? */
 	sparse_memory_present_with_active_regions(0);
 
-#ifdef CONFIG_MMU
-	init_bootmem_done = 1;
-#endif
 	paging_init();
 }
 
@@ -398,18 +360,12 @@ asmlinkage void __init mmu_init(void)
 /* This is only called until mem_init is done. */
 void __init *early_get_page(void)
 {
-	void *p;
-	if (init_bootmem_done) {
-		p = alloc_bootmem_pages(PAGE_SIZE);
-	} else {
-		/*
-		 * Mem start + kernel_tlb -> here is limit
-		 * because of mem mapping from head.S
-		 */
-		p = __va(memblock_alloc_base(PAGE_SIZE, PAGE_SIZE,
-					memory_start + kernel_tlb));
-	}
-	return p;
+	/*
+	 * Mem start + kernel_tlb -> here is limit
+	 * because of mem mapping from head.S
+	 */
+	return __va(memblock_alloc_base(PAGE_SIZE, PAGE_SIZE,
+				memory_start + kernel_tlb));
 }
 
 #endif /* CONFIG_MMU */
