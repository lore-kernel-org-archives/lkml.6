Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FF9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD02120660
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD02120660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbeK1Wrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 17:47:47 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:56313 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727841AbeK1Wrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 17:47:46 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 434f4Y017Kz9v09t;
        Wed, 28 Nov 2018 12:46:21 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id mlbki0NNHsNr; Wed, 28 Nov 2018 12:46:20 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 434f4X6S2fz9v09s;
        Wed, 28 Nov 2018 12:46:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DDC868B869;
        Wed, 28 Nov 2018 12:46:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id J-zpBxXAtI4k; Wed, 28 Nov 2018 12:46:21 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B080C8B867;
        Wed, 28 Nov 2018 12:46:21 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id A1A7569B1B; Wed, 28 Nov 2018 11:46:21 +0000 (UTC)
Message-Id: <cover.1543405086.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v7 00/16] Implement use of HW assistance on TLB table walk on 8xx
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 28 Nov 2018 11:46:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this serie is to implement hardware assistance for TLB table walk
on the 8xx.

First part prepares for using HW assistance in TLB routines:
- Reverts a former patch which broke SWAP on the 8xx
- move book3s64 page fragment code in a common part for reusing it by the
8xx as 16k page size mode still uses 4k page tables.
- switches to patch_site instead of patch_instruction, as it makes the code
clearer and avoids pollution with global symbols.
- Optimise access to perf counters (hence reducing number of registers used)

Second part implements HW assistance in TLB routines in the following steps:
- Disable 16k page size mode and 512k hugepages
- Switch 4k to HW assistance
- Bring back 512k hugepages
- Bring back 16k page size mode.

Tested successfully on 8xx and 83xx (book3s/32)

Changes in v7:
 - Reordered to get trivial and already reviewed patches in front.
 - Reordered to regroup all HW assistance related patches together.
 - Rebased on today merge branch (28 Nov)
 - Added a helper for access to mm_context_t.frag
 - Reduced the amount of changes in PPC32 to support pte_fragment
 - Applied pte_fragment to both nohash/32 and book3s/32

Changes in v6:
 - Droped the part related to handling GUARD attribute at PGD/PMD level.
 - Moved the commonalisation of page_fragment in the begining (this part has been reviewed by Aneesh)
 - Rebased on today merge branch (19 Oct)

Changes in v5:
 - Also avoid useless lock in get_pmd_from_cache()
 - A new patch to relocate mmu headers in platform specific directories
 - A new patch to distribute pgtable_t typedefs in platform specific
   mmu headers instead of the uggly #ifdef
 - Moved early_pte_alloc_kernel() in platform specific pgalloc
 - Restricted definition of PTE_FRAG_SIZE and PTE_FRAG_NR to platforms
   using the pte fragmentation.
 - arch_exit_mmap() and destroy_pagetable_cache() are now platform specific.

Changes in v4:
 - Reordered the serie to put at the end the modifications which makes
   L1 and L2 entries independant.
 - No modifications to ppc64 ioremap (we still have an opportunity to
   merge them, for a future patch serie)
 - 8xx code modified to use patch_site instead of patch_instruction
   to get a clearer code and avoid object pollution with global symbols
 - Moved perf counters in first 32kb of memory to optimise access
 - Split the big bang to HW assistance in several steps:
   1. Temporarily removes support of 16k pages and 512k hugepages
   2. Change TLB routines to use HW assistance for 4k pages and 8M hugepages
   3. Add back support for 512k hugepages
   4. Add back support for 16k pages (using pte_fragment as page tables are still 4k)

Changes in v3:
 - Fixed an issue in the 09/14 when CONFIG_PIN_TLB_TEXT was not enabled
 - Added performance measurement in the 09/14 commit log
 - Rebased on latest 'powerpc/merge' tree, which conflicted with 13/14

Changes in v2:
 - Removed the 3 first patchs which have been applied already
 - Fixed compilation errors reported by Michael
 - Squashed the commonalisation of ioremap functions into a single patch
 - Fixed the use of pte_fragment
 - Added a patch optimising perf counting of TLB misses and instructions


Christophe Leroy (16):
  powerpc/book3s32: Remove CONFIG_BOOKE dependent code
  powerpc/8xx: Remove PTE_ATOMIC_UPDATES
  powerpc/mm: Move pte_fragment_alloc() to a common location
  powerpc/mm: Avoid useless lock with single page fragments
  powerpc/mm: move platform specific mmu-xxx.h in platform directories
  powerpc/mm: Move pgtable_t into platform headers
  powerpc/mm: add helpers to get/set mm.context->pte_frag
  powerpc/mm: Extend pte_fragment functionality to PPC32
  powerpc/8xx: Move SW perf counters in first 32kb of memory
  powerpc/8xx: Temporarily disable 16k pages and hugepages
  powerpc/mm: Use hardware assistance in TLB handlers on the 8xx
  powerpc/mm: Enable 8M hugepage support with HW assistance on the 8xx
  powerpc/mm: Enable 512k hugepage support with HW assistance on the 8xx
  powerpc/mm: reintroduce 16K pages with HW assistance on 8xx
  powerpc/8xx: don't use r12/SPRN_SPRG_SCRATCH2 in TLB Miss handlers
  powerpc/8xx: regroup TLB handler routines

 arch/powerpc/include/asm/book3s/32/mmu-hash.h      |   5 +
 arch/powerpc/include/asm/book3s/32/pgalloc.h       |  36 +-
 arch/powerpc/include/asm/book3s/32/pgtable.h       |  19 +-
 arch/powerpc/include/asm/book3s/64/mmu.h           |   9 +
 arch/powerpc/include/asm/book3s/64/pgalloc.h       |   1 +
 arch/powerpc/include/asm/hugetlb.h                 |   4 +-
 arch/powerpc/include/asm/mmu.h                     |  14 +-
 arch/powerpc/include/asm/mmu_context.h             |   2 +-
 arch/powerpc/include/asm/{ => nohash/32}/mmu-40x.h |   0
 arch/powerpc/include/asm/{ => nohash/32}/mmu-44x.h |   0
 arch/powerpc/include/asm/{ => nohash/32}/mmu-8xx.h |   1 +
 arch/powerpc/include/asm/nohash/32/mmu.h           |  25 ++
 arch/powerpc/include/asm/nohash/32/pgalloc.h       |  23 +-
 arch/powerpc/include/asm/nohash/32/pgtable.h       |  27 +-
 arch/powerpc/include/asm/nohash/32/pte-8xx.h       |   3 -
 arch/powerpc/include/asm/nohash/64/mmu.h           |  12 +
 arch/powerpc/include/asm/{ => nohash}/mmu-book3e.h |   0
 arch/powerpc/include/asm/nohash/mmu.h              |  11 +
 arch/powerpc/include/asm/nohash/pgtable.h          |   4 +
 arch/powerpc/include/asm/page.h                    |  14 -
 arch/powerpc/include/asm/pgtable-types.h           |   4 +
 arch/powerpc/include/asm/pgtable.h                 |  31 ++
 arch/powerpc/kernel/cpu_setup_fsl_booke.S          |   2 +-
 arch/powerpc/kernel/head_8xx.S                     | 366 ++++++++-------------
 arch/powerpc/kvm/e500.h                            |   2 +-
 arch/powerpc/mm/8xx_mmu.c                          |   4 +-
 arch/powerpc/mm/Makefile                           |   5 +-
 arch/powerpc/mm/hugetlbpage.c                      |  13 +
 arch/powerpc/mm/mmu_context.c                      |  10 +
 arch/powerpc/mm/mmu_context_book3s64.c             |  15 -
 arch/powerpc/mm/mmu_context_nohash.c               |   2 +-
 arch/powerpc/mm/pgtable-book3s64.c                 |  88 +----
 arch/powerpc/mm/pgtable-frag.c                     | 119 +++++++
 arch/powerpc/mm/pgtable_32.c                       |  25 +-
 34 files changed, 452 insertions(+), 444 deletions(-)
 rename arch/powerpc/include/asm/{ => nohash/32}/mmu-40x.h (100%)
 rename arch/powerpc/include/asm/{ => nohash/32}/mmu-44x.h (100%)
 rename arch/powerpc/include/asm/{ => nohash/32}/mmu-8xx.h (99%)
 create mode 100644 arch/powerpc/include/asm/nohash/32/mmu.h
 create mode 100644 arch/powerpc/include/asm/nohash/64/mmu.h
 rename arch/powerpc/include/asm/{ => nohash}/mmu-book3e.h (100%)
 create mode 100644 arch/powerpc/include/asm/nohash/mmu.h
 create mode 100644 arch/powerpc/mm/pgtable-frag.c

-- 
2.13.3

