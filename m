Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336C5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FE520C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfB0RG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:06:29 -0500
Received: from foss.arm.com ([217.140.101.70]:35734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfB0RG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:06:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BEFFA78;
        Wed, 27 Feb 2019 09:06:28 -0800 (PST)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3EBB3F738;
        Wed, 27 Feb 2019 09:06:24 -0800 (PST)
From:   Steven Price <steven.price@arm.com>
To:     linux-mm@kvack.org
Cc:     Steven Price <steven.price@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Subject: [PATCH v3 00/34] Convert x86 & arm64 to use generic page walk
Date:   Wed, 27 Feb 2019 17:05:34 +0000
Message-Id: <20190227170608.27963-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most architectures current have a debugfs file for dumping the kernel
page tables. Currently each architecture has to implement custom
functions for walking the page tables because the generic
walk_page_range() function is unable to walk the page tables used by the
kernel.

This series extends the capabilities of walk_page_range() so that it can
deal with the page tables of the kernel (which have no VMAs and can
contain larger huge pages than exist for user space). x86 and arm64 are
then converted to make use of walk_page_range() removing the custom page
table walkers.

To enable a generic page table walker to walk the unusual mappings of
the kernel we need to implement a set of functions which let us know
when the walker has reached the leaf entry. Since arm, powerpc, s390,
sparc and x86 all have p?d_large macros lets standardise on that and
implement those that are missing.

Potentially future changes could unify the implementations of the
debugfs walkers further, moving the common functionality into common
code. This would require a common way of handling the effective
permissions (currently implemented only for x86) along with a per-arch
way of formatting the page table information for debugfs. One
immediate benefit would be getting the KASAN speed up optimisation in
arm64 (and other arches) which is currently only implemented for x86.

Changes since v2:
 * Rather than attemping to provide generic macros, actually implement
   p?d_large() for each architecture.

Changes since v1:
 * Added p4d_large() macro
 * Comments to explain p?d_large() macro semantics
 * Expanded comment for pte_hole() callback to explain mapping between
   depth and P?D
 * Handle folded page tables at all levels, so depth from pte_hole()
   ignores folding at any level (see real_depth() function in
   mm/pagewalk.c)

Steven Price (34):
  alpha: mm: Add p?d_large() definitions
  arc: mm: Add p?d_large() definitions
  arm: mm: Add p?d_large() definitions
  arm64: mm: Add p?d_large() definitions
  c6x: mm: Add p?d_large() definitions
  csky: mm: Add p?d_large() definitions
  hexagon: mm: Add p?d_large() definitions
  ia64: mm: Add p?d_large() definitions
  m68k: mm: Add p?d_large() definitions
  microblaze: mm: Add p?d_large() definitions
  mips: mm: Add p?d_large() definitions
  nds32: mm: Add p?d_large() definitions
  nios2: mm: Add p?d_large() definitions
  openrisc: mm: Add p?d_large() definitions
  parisc: mm: Add p?d_large() definitions
  powerpc: mm: Add p?d_large() definitions
  riscv: mm: Add p?d_large() definitions
  s390: mm: Add p?d_large() definitions
  sh: mm: Add p?d_large() definitions
  sparc: mm: Add p?d_large() definitions
  um: mm: Add p?d_large() definitions
  unicore32: mm: Add p?d_large() definitions
  xtensa: mm: Add p?d_large() definitions
  mm: Add generic p?d_large() macros
  mm: pagewalk: Add p4d_entry() and pgd_entry()
  mm: pagewalk: Allow walking without vma
  mm: pagewalk: Add 'depth' parameter to pte_hole
  mm: pagewalk: Add test_p?d callbacks
  arm64: mm: Convert mm/dump.c to use walk_page_range()
  x86/mm: Point to struct seq_file from struct pg_state
  x86/mm+efi: Convert ptdump_walk_pgd_level() to take a mm_struct
  x86/mm: Convert ptdump_walk_pgd_level_debugfs() to take an mm_struct
  x86/mm: Convert ptdump_walk_pgd_level_core() to take an mm_struct
  x86: mm: Convert dump_pagetables to use walk_page_range

 arch/alpha/include/asm/pgtable.h              |   2 +
 arch/arc/include/asm/pgtable.h                |   1 +
 arch/arm/include/asm/pgtable-2level.h         |   1 +
 arch/arm/include/asm/pgtable-3level.h         |   1 +
 arch/arm64/include/asm/pgtable.h              |   2 +
 arch/arm64/mm/dump.c                          | 108 +++---
 arch/c6x/include/asm/pgtable.h                |   2 +
 arch/csky/include/asm/pgtable.h               |   2 +
 arch/hexagon/include/asm/pgtable.h            |   5 +
 arch/ia64/include/asm/pgtable.h               |   3 +
 arch/m68k/include/asm/mcf_pgtable.h           |   2 +
 arch/m68k/include/asm/motorola_pgtable.h      |   2 +
 arch/m68k/include/asm/pgtable_no.h            |   1 +
 arch/m68k/include/asm/sun3_pgtable.h          |   2 +
 arch/microblaze/include/asm/pgtable.h         |   2 +
 arch/mips/include/asm/pgtable-32.h            |   5 +
 arch/mips/include/asm/pgtable-64.h            |  15 +
 arch/mips/include/asm/pgtable-bits.h          |   2 +-
 arch/nds32/include/asm/pgtable.h              |   2 +
 arch/nios2/include/asm/pgtable.h              |   5 +
 arch/openrisc/include/asm/pgtable.h           |   1 +
 arch/parisc/include/asm/pgtable.h             |   3 +
 arch/powerpc/include/asm/book3s/32/pgtable.h  |   1 +
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  27 +-
 arch/powerpc/include/asm/nohash/32/pgtable.h  |   1 +
 .../include/asm/nohash/64/pgtable-4k.h        |   1 +
 arch/powerpc/kvm/book3s_64_mmu_radix.c        |  12 +-
 arch/riscv/include/asm/pgtable-64.h           |   6 +
 arch/riscv/include/asm/pgtable.h              |   6 +
 arch/s390/include/asm/pgtable.h               |  10 +
 arch/sh/include/asm/pgtable-3level.h          |   1 +
 arch/sh/include/asm/pgtable_32.h              |   1 +
 arch/sh/include/asm/pgtable_64.h              |   1 +
 arch/sparc/include/asm/pgtable_32.h           |  10 +
 arch/sparc/include/asm/pgtable_64.h           |   1 +
 arch/um/include/asm/pgtable-3level.h          |   1 +
 arch/um/include/asm/pgtable.h                 |   1 +
 arch/unicore32/include/asm/pgtable.h          |   1 +
 arch/x86/include/asm/pgtable.h                |  26 +-
 arch/x86/mm/debug_pagetables.c                |   8 +-
 arch/x86/mm/dump_pagetables.c                 | 342 +++++++++---------
 arch/x86/platform/efi/efi_32.c                |   2 +-
 arch/x86/platform/efi/efi_64.c                |   4 +-
 arch/xtensa/include/asm/pgtable.h             |   1 +
 fs/proc/task_mmu.c                            |   4 +-
 include/asm-generic/4level-fixup.h            |   1 +
 include/asm-generic/5level-fixup.h            |   1 +
 include/asm-generic/pgtable-nop4d-hack.h      |   1 +
 include/asm-generic/pgtable-nop4d.h           |   1 +
 include/asm-generic/pgtable-nopmd.h           |   1 +
 include/asm-generic/pgtable-nopud.h           |   1 +
 include/linux/mm.h                            |  26 +-
 mm/hmm.c                                      |   2 +-
 mm/migrate.c                                  |   1 +
 mm/mincore.c                                  |   1 +
 mm/pagewalk.c                                 | 107 ++++--
 56 files changed, 489 insertions(+), 291 deletions(-)

-- 
2.20.1

