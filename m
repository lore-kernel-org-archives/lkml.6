Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752061AbeCPVdP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 17:33:15 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:45398 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751944AbeCPVdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 17:33:12 -0400
X-Google-Smtp-Source: AG47ELuJGwHjBT6QBtGx7a/V8yS8mqtaX4HaGp5XMivzhKAOAM+jQgI618l85qDMDD2Xse+CtgCYSQ==
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: uclinux-h8-devel@lists.sourceforge.jp
Subject: [PATCH] h8300: switch to NO_BOOTMEM
Date: Fri, 16 Mar 2018 16:33:06 -0500
Message-Id: <20180316213306.20424-1-robh@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0fa1c579349f ("of/fdt: use memblock_virt_alloc for early alloc")
inadvertently switched the DT unflattening allocations from memblock to
bootmem which doesn't work because the unflattening happens before
bootmem is initialized. Swapping the order of bootmem init and
unflattening could also fix this, but removing bootmem is desired. So
enable NO_BOOTMEM on h8300 like other architectures have done.

Fixes: 0fa1c579349f ("of/fdt: use memblock_virt_alloc for early alloc")
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: uclinux-h8-devel@lists.sourceforge.jp
Signed-off-by: Rob Herring <robh@kernel.org>
---
I haven't seen any reports, but 4.16 is likely broken. This is compile 
tested only.

Moving unflattening after bootmem_init should also work if a smaller 
change for 4.16 is desired.

Rob

 arch/h8300/Kconfig        |  1 +
 arch/h8300/kernel/setup.c | 36 ++++++++----------------------------
 2 files changed, 9 insertions(+), 28 deletions(-)

diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index 091d6d04b5e5..efc602634064 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -16,6 +16,7 @@ config H8300
 	select OF_IRQ
 	select OF_EARLY_FLATTREE
 	select HAVE_MEMBLOCK
+	select NO_BOOTMEM
 	select TIMER_OF
 	select H8300_TMR8
 	select HAVE_KERNEL_GZIP
diff --git a/arch/h8300/kernel/setup.c b/arch/h8300/kernel/setup.c
index a4d0470c10a9..33ed980e7aea 100644
--- a/arch/h8300/kernel/setup.c
+++ b/arch/h8300/kernel/setup.c
@@ -71,10 +71,6 @@ void __init h8300_fdt_init(void *fdt, char *bootargs)
 
 static void __init bootmem_init(void)
 {
-	int bootmap_size;
-	unsigned long ram_start_pfn;
-	unsigned long free_ram_start_pfn;
-	unsigned long ram_end_pfn;
 	struct memblock_region *region;
 
 	memory_end = memory_start = 0;
@@ -88,33 +84,17 @@ static void __init bootmem_init(void)
 	if (!memory_end)
 		panic("No memory!");
 
-	ram_start_pfn = PFN_UP(memory_start);
-	/* free_ram_start_pfn is first page after kernel */
-	free_ram_start_pfn = PFN_UP(__pa(_end));
-	ram_end_pfn = PFN_DOWN(memblock_end_of_DRAM());
+	/* setup bootmem globals (we use no_bootmem, but mm still depends on this) */
+	min_low_pfn = PFN_UP(memory_start);
+	max_low_pfn = PFN_DOWN(memblock_end_of_DRAM());
+	max_pfn = max_low_pfn;
 
-	max_pfn = ram_end_pfn;
+	memblock_reserve(__pa(_stext), _end - _stext);
 
-	/*
-	 * give all the memory to the bootmap allocator,  tell it to put the
-	 * boot mem_map at the start of memory
-	 */
-	bootmap_size = init_bootmem_node(NODE_DATA(0),
-					 free_ram_start_pfn,
-					 0,
-					 ram_end_pfn);
-	/*
-	 * free the usable memory,  we have to make sure we do not free
-	 * the bootmem bitmap so we then reserve it after freeing it :-)
-	 */
-	free_bootmem(PFN_PHYS(free_ram_start_pfn),
-		     (ram_end_pfn - free_ram_start_pfn) << PAGE_SHIFT);
-	reserve_bootmem(PFN_PHYS(free_ram_start_pfn), bootmap_size,
-			BOOTMEM_DEFAULT);
+	early_init_fdt_reserve_self();
+	early_init_fdt_scan_reserved_mem();
 
-	for_each_memblock(reserved, region) {
-		reserve_bootmem(region->base, region->size, BOOTMEM_DEFAULT);
-	}
+	memblock_dump_all();
 }
 
 void __init setup_arch(char **cmdline_p)
-- 
2.14.1
