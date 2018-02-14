Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967390AbeBNLRN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 06:17:13 -0500
Received: from mga11.intel.com ([192.55.52.93]:37976 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967252AbeBNLRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 06:17:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,512,1511856000";
   d="scan'208";a="201054937"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>, Borislav Petkov <bp@suse.de>,
        Andi Kleen <ak@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 0/9] x86/mm: Dynamic memory layout
Date: Wed, 14 Feb 2018 14:16:47 +0300
Message-Id: <20180214111656.88514-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the next batch of patches required to bring boot-time switching
between 4- and 5-level paging. Please review and consider applying.

Patches in this patchset makes memory layout dynamic enough to be able to
switch between paging modes at boot-time.

Ingo, it worth noticing that we discussed some parts of the patchset
before (back in October) and had disagrement on how to handle situation.
You can read my position on the matter by the link[1].

Some changes made in this patchset can be replaced by patching constants
in code once we have infrastructure for this.

[1] http://lkml.kernel.org/r/20171031120429.ehaqy2iciewcij35@node.shutemov.name

Kirill A. Shutemov (9):
  x86/mm/64: Make __PHYSICAL_MASK_SHIFT always 52
  mm/zsmalloc: Prepare to variable MAX_PHYSMEM_BITS
  x86/mm: Make virtual memory layout movable for CONFIG_X86_5LEVEL
  x86: Introduce pgtable_l5_enabled
  x86/mm: Make LDT_BASE_ADDR dynamic
  x86/mm: Make PGDIR_SHIFT and PTRS_PER_P4D variable
  x86/mm: Make MAX_PHYSADDR_BITS and MAX_PHYSMEM_BITS dynamic
  x86/mm: Make __VIRTUAL_MASK_SHIFT dynamic
  x86/mm: Adjust virtual address space layout in early boot

 arch/x86/Kconfig                            |  9 ++++
 arch/x86/boot/compressed/kaslr.c            | 14 ++++++
 arch/x86/entry/entry_64.S                   | 12 ++++++
 arch/x86/include/asm/kaslr.h                |  4 --
 arch/x86/include/asm/page_64.h              |  4 ++
 arch/x86/include/asm/page_64_types.h        | 20 ++++-----
 arch/x86/include/asm/pgtable-3level_types.h |  1 +
 arch/x86/include/asm/pgtable_32.h           |  2 +
 arch/x86/include/asm/pgtable_32_types.h     |  2 +
 arch/x86/include/asm/pgtable_64_types.h     | 67 ++++++++++++++++++-----------
 arch/x86/include/asm/sparsemem.h            |  9 +---
 arch/x86/kernel/cpu/mcheck/mce.c            | 18 +++-----
 arch/x86/kernel/head64.c                    | 57 ++++++++++++++++++++++--
 arch/x86/kernel/head_64.S                   |  2 +-
 arch/x86/kernel/setup.c                     |  5 +--
 arch/x86/mm/dump_pagetables.c               | 32 +++++++++-----
 arch/x86/mm/init_64.c                       |  2 +-
 arch/x86/mm/kasan_init_64.c                 |  2 +-
 arch/x86/mm/kaslr.c                         | 23 ++++------
 arch/x86/platform/efi/efi_64.c              |  4 +-
 include/asm-generic/5level-fixup.h          |  1 +
 include/asm-generic/pgtable-nop4d.h         |  9 ++--
 include/linux/kasan.h                       |  2 +-
 mm/kasan/kasan_init.c                       |  2 +-
 mm/zsmalloc.c                               | 13 +++---
 25 files changed, 208 insertions(+), 108 deletions(-)

-- 
2.15.1
