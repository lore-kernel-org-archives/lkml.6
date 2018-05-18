Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752728AbeERKgv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 06:36:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:33946 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752564AbeERKfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 06:35:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,414,1520924400";
   d="scan'208";a="225307574"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv5 0/7] 5-level paging changes for v4.18
Date: Fri, 18 May 2018 13:35:21 +0300
Message-Id: <20180518103528.59260-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's several patches that I would like to queue for v4.18. Please review
and consider applying.

In this version I've addressed Thomas' feedback.

Changing __pgtable_l5_enabled to __initdata is not as trivial as I hoped.
It requires few tricks to avoid section mismatch. I'm not sure if it worth
the gain. We can keep it __ro_after_init.

If you feel it's too invasive, just drop last three patches.

Kirill A. Shutemov (7):
  x86/boot/compressed/64: Fix trampoline page table address calculation
  x86/mm: Unify pgtable_l5_enabled usage in early boot code
  x86/mm: Stop pretending pgtable_l5_enabled is a variable
  x86/mm: Introduce 'no5lvl' kernel parameter
  x86/cpu: Move early cpu initialization into a separate translation
    unit
  x86/mm: Mark p4d_offset() __always_inline
  x86/mm: Mark __pgtable_l5_enabled __initdata

 .../admin-guide/kernel-parameters.txt         |   3 +
 arch/x86/boot/compressed/cmdline.c            |   2 +-
 arch/x86/boot/compressed/head_64.S            |   1 +
 arch/x86/boot/compressed/kaslr.c              |   4 +-
 arch/x86/boot/compressed/misc.h               |   6 +-
 arch/x86/boot/compressed/pgtable_64.c         |  14 +-
 arch/x86/include/asm/page_64_types.h          |   2 +-
 arch/x86/include/asm/paravirt.h               |   4 +-
 arch/x86/include/asm/pgalloc.h                |   4 +-
 arch/x86/include/asm/pgtable.h                |  12 +-
 arch/x86/include/asm/pgtable_32_types.h       |   2 +-
 arch/x86/include/asm/pgtable_64.h             |   2 +-
 arch/x86/include/asm/pgtable_64_types.h       |  25 ++-
 arch/x86/include/asm/sparsemem.h              |   4 +-
 arch/x86/kernel/cpu/Makefile                  |   1 +
 arch/x86/kernel/cpu/common.c                  | 179 +++---------------
 arch/x86/kernel/cpu/cpu.h                     |   7 +
 arch/x86/kernel/cpu/early.c                   | 159 ++++++++++++++++
 arch/x86/kernel/head64.c                      |  25 ++-
 arch/x86/kernel/machine_kexec_64.c            |   3 +-
 arch/x86/mm/dump_pagetables.c                 |   6 +-
 arch/x86/mm/fault.c                           |   4 +-
 arch/x86/mm/ident_map.c                       |   2 +-
 arch/x86/mm/init_64.c                         |   8 +-
 arch/x86/mm/kasan_init_64.c                   |  14 +-
 arch/x86/mm/kaslr.c                           |   8 +-
 arch/x86/mm/tlb.c                             |   2 +-
 arch/x86/platform/efi/efi_64.c                |   2 +-
 arch/x86/power/hibernate_64.c                 |   2 +-
 29 files changed, 279 insertions(+), 228 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/early.c

-- 
2.17.0
