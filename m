Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752023AbeBBD4h (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 22:56:37 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:45571 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751873AbeBBDzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 22:55:23 -0500
X-Google-Smtp-Source: AH8x2264dtwq9j4QWGaYGoZR4gaAApe47Z1sRCxqBjikBdf7zJPN/2KgqgWAhY1ATrfawB+6+Bl49w==
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
Subject: [PATCH v2 14/15] MIPS: memblock: Discard bootmem from SGI IP27 code
Date: Fri,  2 Feb 2018 06:54:57 +0300
Message-Id: <20180202035458.30456-15-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180202035458.30456-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180202035458.30456-1-fancer.lancer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGI IP27 got its own code to set the early memory allocator up since it's
NUMA-based system. So in order to be compatible with NO_BOOTMEM config
we need to discard the bootmem allocator initialization and insert the
memblock reservation method. Although in my opinion the code isn't
working anyway since I couldn't find a place where prom_meminit() called
and kernel memory isn't reserved. It must have been untested since the
time the arch/mips/mips-boards/generic code was in the kernel.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/sgi-ip27/ip27-memory.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
index 59133d0abc83..c480ee3eca96 100644
--- a/arch/mips/sgi-ip27/ip27-memory.c
+++ b/arch/mips/sgi-ip27/ip27-memory.c
@@ -389,7 +389,6 @@ static void __init node_mem_init(cnodeid_t node)
 {
 	unsigned long slot_firstpfn = slot_getbasepfn(node, 0);
 	unsigned long slot_freepfn = node_getfirstfree(node);
-	unsigned long bootmap_size;
 	unsigned long start_pfn, end_pfn;
 
 	get_pfn_range_for_nid(node, &start_pfn, &end_pfn);
@@ -400,7 +399,6 @@ static void __init node_mem_init(cnodeid_t node)
 	__node_data[node] = __va(slot_freepfn << PAGE_SHIFT);
 	memset(__node_data[node], 0, PAGE_SIZE);
 
-	NODE_DATA(node)->bdata = &bootmem_node_data[node];
 	NODE_DATA(node)->node_start_pfn = start_pfn;
 	NODE_DATA(node)->node_spanned_pages = end_pfn - start_pfn;
 
@@ -409,12 +407,9 @@ static void __init node_mem_init(cnodeid_t node)
 	slot_freepfn += PFN_UP(sizeof(struct pglist_data) +
 			       sizeof(struct hub_data));
 
-	bootmap_size = init_bootmem_node(NODE_DATA(node), slot_freepfn,
-					start_pfn, end_pfn);
 	free_bootmem_with_active_regions(node, end_pfn);
-	reserve_bootmem_node(NODE_DATA(node), slot_firstpfn << PAGE_SHIFT,
-		((slot_freepfn - slot_firstpfn) << PAGE_SHIFT) + bootmap_size,
-		BOOTMEM_DEFAULT);
+	memblock_reserve(slot_firstpfn << PAGE_SHIFT,
+		((slot_freepfn - slot_firstpfn) << PAGE_SHIFT));
 	sparse_memory_present_with_active_regions(node);
 }
 
-- 
2.12.0
