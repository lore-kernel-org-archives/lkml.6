Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B26ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 06:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B4832086E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 06:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B4832086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbeJSO7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 10:59:37 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:18907 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbeJSO7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 10:59:37 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42bxVg2sgqz9ttFV;
        Fri, 19 Oct 2018 08:54:51 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id QF5DW9GLSdmj; Fri, 19 Oct 2018 08:54:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42bxVg29fYz9ttFM;
        Fri, 19 Oct 2018 08:54:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7BD588B8DF;
        Fri, 19 Oct 2018 08:54:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id wtM3CL0rJWQf; Fri, 19 Oct 2018 08:54:52 +0200 (CEST)
Received: from pc13168vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5147B8B75B;
        Fri, 19 Oct 2018 08:54:52 +0200 (CEST)
Received: by pc13168vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 314466F496; Fri, 19 Oct 2018 06:54:52 +0000 (UTC)
Message-Id: <cover.1539931702.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v6 00/20] Implement use of HW assistance on TLB table walk on 8xx
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 19 Oct 2018 06:54:52 +0000 (UTC)
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

Tested successfully on 8xx.

This serie applies after the two following series:
- [v2 00/24] ban the use of _PAGE_XXX flags outside platform specific code (https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=65376)
- [v2,1/4] powerpc/mm: enable the use of page table cache of order 0 (https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=60777)

Successfull compilation on kisskb (v5)
http://kisskb.ellerman.id.au/kisskb/head/555f5323c8d1459c9a452ae92c18048a4e29af94/

Successfull compilation on kisskb (v4)
http://kisskb.ellerman.id.au/kisskb/branch/chleroy/head/cfdf3349e3877df4cbfa9193ad1f4f4e4ada52de/

Successfull compilation on following defconfigs (v3):
ppc64_defconfig
ppc64e_defconfig

Successfull compilation on following defconfigs (v2):
ppc64_defconfig
ppc64e_defconfig
pseries_defconfig
pmac32_defconfig
linkstation_defconfig
corenet32_smp_defconfig
ppc40x_defconfig
storcenter_defconfig
ppc44x_defconfig

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

Christophe Leroy (20):
  Revert "powerpc/8xx: Use L1 entry APG to handle _PAGE_ACCESSED for
    CONFIG_SWAP"
  powerpc/mm: Move pte_fragment_alloc() to a common location
  powerpc/mm: Avoid useless lock with single page fragments
  powerpc/mm: move platform specific mmu-xxx.h in platform directories
  powerpc/mm: Move pgtable_t into platform headers
  powerpc/code-patching: add a helper to get the address of a patch_site
  powerpc/8xx: Use patch_site for memory setup patching
  powerpc/8xx: Use patch_site for perf counters setup
  powerpc/8xx: Move SW perf counters in first 32kb of memory
  powerpc/8xx: Temporarily disable 16k pages and 512k hugepages
  powerpc/mm: Use hardware assistance in TLB handlers on the 8xx
  powerpc/mm: Enable 512k hugepage support with HW assistance on the 8xx
  powerpc/8xx: don't use r12/SPRN_SPRG_SCRATCH2 in TLB Miss handlers
  powerpc/8xx: regroup TLB handler routines
  powerpc/mm: don't use pte_alloc_one_kernel() before slab is available
  powerpc/mm: inline pte_alloc_one() and pte_alloc_one_kernel() in PPC32
  powerpc/book3s32: Remove CONFIG_BOOKE dependent code
  powerpc/mm: Extend pte_fragment functionality to nohash/32
  powerpc/8xx: Remove PTE_ATOMIC_UPDATES
  powerpc/mm: reintroduce 16K pages with HW assistance on 8xx

 arch/powerpc/include/asm/book3s/32/mmu-hash.h      |   2 +
 arch/powerpc/include/asm/book3s/32/pgalloc.h       |  43 ++-
 arch/powerpc/include/asm/book3s/32/pgtable.h       |  14 -
 arch/powerpc/include/asm/book3s/64/mmu.h           |   9 +
 arch/powerpc/include/asm/book3s/64/pgalloc.h       |   1 +
 arch/powerpc/include/asm/code-patching.h           |   5 +
 arch/powerpc/include/asm/hugetlb.h                 |   4 +-
 arch/powerpc/include/asm/mmu.h                     |  14 +-
 arch/powerpc/include/asm/mmu_context.h             |   2 +-
 arch/powerpc/include/asm/{ => nohash/32}/mmu-40x.h |   1 +
 arch/powerpc/include/asm/{ => nohash/32}/mmu-44x.h |   1 +
 arch/powerpc/include/asm/{ => nohash/32}/mmu-8xx.h |  44 +--
 arch/powerpc/include/asm/nohash/32/mmu.h           |  25 ++
 arch/powerpc/include/asm/nohash/32/pgalloc.h       |  55 ++-
 arch/powerpc/include/asm/nohash/32/pgtable.h       |  29 +-
 arch/powerpc/include/asm/nohash/32/pte-8xx.h       |   3 -
 arch/powerpc/include/asm/nohash/64/mmu.h           |  12 +
 arch/powerpc/include/asm/{ => nohash}/mmu-book3e.h |   1 +
 arch/powerpc/include/asm/nohash/mmu.h              |  11 +
 arch/powerpc/include/asm/nohash/pgtable.h          |   4 +
 arch/powerpc/include/asm/page.h                    |  14 -
 arch/powerpc/include/asm/pgtable-types.h           |   4 +
 arch/powerpc/kernel/cpu_setup_fsl_booke.S          |   2 +-
 arch/powerpc/kernel/head_8xx.S                     | 422 +++++++++------------
 arch/powerpc/kvm/e500.h                            |   2 +-
 arch/powerpc/mm/8xx_mmu.c                          |  29 +-
 arch/powerpc/mm/Makefile                           |   7 +-
 arch/powerpc/mm/hugetlbpage.c                      |  13 +
 arch/powerpc/mm/mmu_context_book3s64.c             |  15 -
 arch/powerpc/mm/mmu_context_nohash.c               |  14 +
 arch/powerpc/mm/pgtable-book3s64.c                 |  88 +----
 arch/powerpc/mm/pgtable-frag.c                     | 119 ++++++
 arch/powerpc/mm/pgtable_32.c                       |  37 +-
 arch/powerpc/perf/8xx-pmu.c                        |  27 +-
 34 files changed, 552 insertions(+), 521 deletions(-)
 rename arch/powerpc/include/asm/{ => nohash/32}/mmu-40x.h (99%)
 rename arch/powerpc/include/asm/{ => nohash/32}/mmu-44x.h (99%)
 rename arch/powerpc/include/asm/{ => nohash/32}/mmu-8xx.h (88%)
 create mode 100644 arch/powerpc/include/asm/nohash/32/mmu.h
 create mode 100644 arch/powerpc/include/asm/nohash/64/mmu.h
 rename arch/powerpc/include/asm/{ => nohash}/mmu-book3e.h (99%)
 create mode 100644 arch/powerpc/include/asm/nohash/mmu.h
 create mode 100644 arch/powerpc/mm/pgtable-frag.c

-- 
2.13.3

