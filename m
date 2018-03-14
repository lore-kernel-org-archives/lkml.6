Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751620AbeCNNpF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 09:45:05 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35178 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbeCNNpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 09:45:02 -0400
X-Google-Smtp-Source: AG47ELuoU6BVCJJtJ0sgwMed45i/e5dwwluOAxW/SfpgSj45SeI8kTTaR95GG7ovLFwXNJuAhQZl3g==
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: mark.rutland@arm.com, will.deacon@arm.com, catalin.marinas@arm.com,
        marc.zyngier@arm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Vacek <neelx@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>, Paul Burton <paul.burton@imgtec.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] Revert "mm/page_alloc: fix memmap_init_zone pageblock alignment"
Date: Wed, 14 Mar 2018 13:44:31 +0000
Message-Id: <20180314134431.13241-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 864b75f9d6b0100bb24fdd9a20d156e7cda9b5ae.

It breaks the boot on my Socionext SynQuacer based system, because
it enters an infinite loop iterating over the pfns.

Adding the following debug output to memmap_init_zone()

  --- a/mm/page_alloc.c
  +++ b/mm/page_alloc.c
  @@ -5365,6 +5365,11 @@
   			 * the valid region but still depends on correct page
   			 * metadata.
   			 */
  +			pr_err("pfn:%lx oldnext:%lx newnext:%lx\n", pfn,
  +				memblock_next_valid_pfn(pfn, end_pfn) - 1,
  +				(memblock_next_valid_pfn(pfn, end_pfn) &
  +					~(pageblock_nr_pages-1)) - 1);
  +
   			pfn = (memblock_next_valid_pfn(pfn, end_pfn) &
   					~(pageblock_nr_pages-1)) - 1;
   #endif

results in

   Booting Linux on physical CPU 0x0000000000 [0x410fd034]
   Linux version 4.16.0-rc5-00004-gfc6eabbbf8ef-dirty (ard@dogfood) ...
   Machine model: Socionext Developer Box
   earlycon: pl11 at MMIO 0x000000002a400000 (options '')
   bootconsole [pl11] enabled
   efi: Getting EFI parameters from FDT:
   efi: EFI v2.70 by Linaro
   efi:  SMBIOS 3.0=0xff580000  ESRT=0xf9948198  MEMATTR=0xf83b1a98  RNG=0xff7ac898
   random: fast init done
   efi: seeding entropy pool
   esrt: Reserving ESRT space from 0x00000000f9948198 to 0x00000000f99481d0.
   cma: Reserved 16 MiB at 0x00000000fd800000
   NUMA: No NUMA configuration found
   NUMA: Faking a node at [mem 0x0000000000000000-0x0000000fffffffff]
   NUMA: NODE_DATA [mem 0xffffd8d80-0xffffda87f]
   Zone ranges:
     DMA32    [mem 0x0000000080000000-0x00000000ffffffff]
     Normal   [mem 0x0000000100000000-0x0000000fffffffff]
   Movable zone start for each node
   Early memory node ranges
     node   0: [mem 0x0000000080000000-0x00000000febeffff]
     node   0: [mem 0x00000000febf0000-0x00000000fefcffff]
     node   0: [mem 0x00000000fefd0000-0x00000000ff43ffff]
     node   0: [mem 0x00000000ff440000-0x00000000ff7affff]
     node   0: [mem 0x00000000ff7b0000-0x00000000ffffffff]
     node   0: [mem 0x0000000880000000-0x0000000fffffffff]
   Initmem setup node 0 [mem 0x0000000080000000-0x0000000fffffffff]
   pfn:febf0 oldnext:febf0 newnext:fe9ff
   pfn:febf0 oldnext:febf0 newnext:fe9ff
   pfn:febf0 oldnext:febf0 newnext:fe9ff
   etc etc

and the boot never proceeds after this point.

So the logic is obviously flawed, and so it is best to revert this at
the current -rc stage (unless someone can fix the logic instead)

Fixes: 864b75f9d6b0 ("mm/page_alloc: fix memmap_init_zone pageblock alignment")
Cc: Daniel Vacek <neelx@redhat.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 mm/page_alloc.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3d974cb2a1a1..cb416723538f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5359,14 +5359,9 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 			/*
 			 * Skip to the pfn preceding the next valid one (or
 			 * end_pfn), such that we hit a valid pfn (or end_pfn)
-			 * on our next iteration of the loop. Note that it needs
-			 * to be pageblock aligned even when the region itself
-			 * is not. move_freepages_block() can shift ahead of
-			 * the valid region but still depends on correct page
-			 * metadata.
+			 * on our next iteration of the loop.
 			 */
-			pfn = (memblock_next_valid_pfn(pfn, end_pfn) &
-					~(pageblock_nr_pages-1)) - 1;
+			pfn = memblock_next_valid_pfn(pfn, end_pfn) - 1;
 #endif
 			continue;
 		}
-- 
2.15.1
