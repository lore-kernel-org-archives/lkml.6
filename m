Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751803AbeBBD4q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 22:56:46 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33103 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751869AbeBBDzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 22:55:21 -0500
X-Google-Smtp-Source: AH8x226DcLcoE+aoo9gVVTjgr0l9eNyw8NLSDhUyMxf4Ug2WJmDB27xCO/UnTp50Tu1o+hoQcLxYYg==
From: Serge Semin <fancer.lancer@gmail.com>
To: ralf@linux-mips.org, miodrag.dinic@mips.com, jhogan@kernel.org,
        goran.ferenc@mips.com, david.daney@cavium.com,
        paul.gortmaker@windriver.com, paul.burton@mips.com,
        alex.belits@cavium.com, Steven.Hill@cavium.com
Cc: alexander.sverdlin@nokia.com, matt.redfearn@mips.com, kumba@gentoo.org,
        marcin.nowakowski@mips.com, James.hogan@mips.com,
        Peter.Wotton@mips.com, Sergey.Semin@t-platforms.ru,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v2 13/15] MIPS: memblock: Discard bootmem from Loongson3 code
Date: Fri,  2 Feb 2018 06:54:56 +0300
Message-Id: <20180202035458.30456-14-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180202035458.30456-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180202035458.30456-1-fancer.lancer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Loongson64/3 runs its own code to initialize memory allocator in
case of NUMA configuration is selected. So in order to move to the
pure memblock utilization we discard the bootmem allocator usage
and insert the memblock reservation method for kernel/addrspace_offset
memory regions.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/loongson64/loongson-3/numa.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/mips/loongson64/loongson-3/numa.c b/arch/mips/loongson64/loongson-3/numa.c
index f17ef520799a..2f1ebf496c17 100644
--- a/arch/mips/loongson64/loongson-3/numa.c
+++ b/arch/mips/loongson64/loongson-3/numa.c
@@ -180,7 +180,6 @@ static void __init szmem(unsigned int node)
 
 static void __init node_mem_init(unsigned int node)
 {
-	unsigned long bootmap_size;
 	unsigned long node_addrspace_offset;
 	unsigned long start_pfn, end_pfn, freepfn;
 
@@ -197,26 +196,21 @@ static void __init node_mem_init(unsigned int node)
 
 	__node_data[node] = prealloc__node_data + node;
 
-	NODE_DATA(node)->bdata = &bootmem_node_data[node];
 	NODE_DATA(node)->node_start_pfn = start_pfn;
 	NODE_DATA(node)->node_spanned_pages = end_pfn - start_pfn;
 
-	bootmap_size = init_bootmem_node(NODE_DATA(node), freepfn,
-					start_pfn, end_pfn);
 	free_bootmem_with_active_regions(node, end_pfn);
 	if (node == 0) /* used by finalize_initrd() */
 		max_low_pfn = end_pfn;
 
-	/* This is reserved for the kernel and bdata->node_bootmem_map */
-	reserve_bootmem_node(NODE_DATA(node), start_pfn << PAGE_SHIFT,
-		((freepfn - start_pfn) << PAGE_SHIFT) + bootmap_size,
-		BOOTMEM_DEFAULT);
+	/* This is reserved for the kernel only */
+	if (node == 0)
+		memblock_reserve(start_pfn << PAGE_SHIFT,
+			((freepfn - start_pfn) << PAGE_SHIFT));
 
 	if (node == 0 && node_end_pfn(0) >= (0xffffffff >> PAGE_SHIFT)) {
 		/* Reserve 0xfe000000~0xffffffff for RS780E integrated GPU */
-		reserve_bootmem_node(NODE_DATA(node),
-				(node_addrspace_offset | 0xfe000000),
-				32 << 20, BOOTMEM_DEFAULT);
+		memblock_reserve(node_addrspace_offset | 0xfe000000, 32 << 20);
 	}
 
 	sparse_memory_present_with_active_regions(node);
-- 
2.12.0
