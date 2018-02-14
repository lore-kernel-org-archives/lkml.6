Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161928AbeBNSZw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 13:25:52 -0500
Received: from mga01.intel.com ([192.55.52.88]:54320 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161763AbeBNSZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 13:25:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,513,1511856000";
   d="scan'208";a="17712521"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>, Borislav Petkov <bp@suse.de>,
        Andi Kleen <ak@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 0/9] x86: enable boot-time switching between paging modes
Date: Wed, 14 Feb 2018 21:25:33 +0300
Message-Id: <20180214182542.69302-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset finally brings support of switching between 4- and 5-level
paging modes!

There will be few patches after this to optimize switching and support
mode Xen modes, but this makes the same kernel image to run on both 4- and
5-level machines.

Please review and consider applying.

First 5 patches is split up of the last patch from the previous patchset.
The rest is pretty trivial too.

Kirill A. Shutemov (9):
  x86/mm: Initialize pgtable_l5_enabled at boot-time
  x86/mm: Initialize pgdir_shift and ptrs_per_p4d at boot-time
  x86/mm: Initialize page_offset_base at boot-time
  x86/mm: Adjust vmalloc base and size at boot-time
  x86/mm: Initialize vmemmap_base at boot-time
  x86/mm: Make early boot code support boot-time switching of paging
    modes
  x86/mm: Fold p4d page table layer at runtime
  x86/mm: Replace compile-time checks for 5-level with runtime-time
  x86/mm: Allow to boot without la57 if CONFIG_X86_5LEVEL=y

 Documentation/x86/x86_64/5level-paging.txt |  9 ++--
 arch/x86/Kconfig                           |  4 +-
 arch/x86/boot/compressed/kaslr.c           | 14 ++++--
 arch/x86/boot/compressed/misc.c            | 16 -------
 arch/x86/include/asm/page_64_types.h       |  9 ++--
 arch/x86/include/asm/paravirt.h            | 10 +++--
 arch/x86/include/asm/pgalloc.h             |  5 ++-
 arch/x86/include/asm/pgtable.h             | 11 ++++-
 arch/x86/include/asm/pgtable_64.h          | 23 +++++-----
 arch/x86/include/asm/pgtable_64_types.h    | 25 +++++------
 arch/x86/include/asm/required-features.h   |  8 +---
 arch/x86/kernel/head64.c                   | 68 ++++++++++++++++++++++++------
 arch/x86/kernel/head_64.S                  | 12 +++---
 arch/x86/mm/dump_pagetables.c              |  4 +-
 arch/x86/mm/fault.c                        |  4 +-
 arch/x86/mm/ident_map.c                    |  2 +-
 arch/x86/mm/init_64.c                      | 30 +++++++------
 arch/x86/mm/kasan_init_64.c                | 12 +++---
 arch/x86/mm/kaslr.c                        | 17 ++++----
 arch/x86/mm/tlb.c                          |  2 +-
 arch/x86/platform/efi/efi_64.c             |  2 +-
 arch/x86/power/hibernate_64.c              |  6 +--
 22 files changed, 165 insertions(+), 128 deletions(-)

-- 
2.15.1
