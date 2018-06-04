Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752649AbeFDMSA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 08:18:00 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40857 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751933AbeFDMR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 08:17:59 -0400
X-Google-Smtp-Source: ADUXVKLVv5QDI+IRHL1QBpSiOm/zQ3BjkJ7MAhNx3fp8JlyHa/xnUT9KgxQXCGtRKr+7iPfqt4j7pw==
Date: Mon, 4 Jun 2018 14:17:55 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/boot changes for v4.18
Message-ID: <20180604121755.GA32695@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-boot-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-for-linus

   # HEAD: e4e961e36f063484c48bed919013c106d178995d x86/mm: Mark __pgtable_l5_enabled __initdata

The main changes in this cycle were:

 - Centaur CPU updates (David Wang)

 - AMD and other CPU topology enumeration improvements and fixes
   (Borislav Petkov, Thomas Gleixner, Suravee Suthikulpanit)

 - Continued 5-level paging work (Kirill A. Shutemov)

 Thanks,

	Ingo

------------------>

Borislav Petkov (2):
      x86/CPU/AMD: Have smp_num_siblings and cpu_llc_id always be present
      x86/CPU: Rename intel_cacheinfo.c to cacheinfo.c

David Wang (4):
      x86/Centaur: Initialize supported CPU features properly
      x86/CPU: Make intel_num_cpu_cores() generic
      x86/CPU: Move cpu_detect_cache_sizes() into init_intel_cacheinfo()
      x86/Centaur: Report correct CPU/cache topology

Kirill A. Shutemov (6):
      x86/boot/compressed/64: Fix trampoline page table address calculation
      x86/mm: Unify pgtable_l5_enabled usage in early boot code
      x86/mm: Stop pretending pgtable_l5_enabled is a variable
      x86/mm: Introduce the 'no5lvl' kernel parameter
      x86/mm: Mark p4d_offset() __always_inline
      x86/mm: Mark __pgtable_l5_enabled __initdata

Suravee Suthikulpanit (4):
      perf/events/amd/uncore: Fix amd_uncore_llc ID to use pre-defined cpu_llc_id
      x86/CPU/AMD: Calculate last level cache ID from number of sharing threads
      x86/CPU: Modify detect_extended_topology() to return result
      x86/CPU/AMD: Derive CPU topology from CPUID function 0xB when available

Thomas Gleixner (2):
      x86/CPU: Move cpu local function declarations to local header
      x86/CPU: Move x86_cpuinfo::x86_max_cores assignment to detect_num_cpu_cores()

 Documentation/admin-guide/kernel-parameters.txt        |  3 +++
 arch/x86/boot/compressed/cmdline.c                     |  2 +-
 arch/x86/boot/compressed/head_64.S                     |  1 +
 arch/x86/boot/compressed/kaslr.c                       |  4 ++--
 arch/x86/boot/compressed/misc.h                        |  6 ++----
 arch/x86/boot/compressed/pgtable_64.c                  | 14 +++++++++++---
 arch/x86/events/amd/uncore.c                           | 21 ++-------------------
 arch/x86/include/asm/cacheinfo.h                       |  7 +++++++
 arch/x86/include/asm/page_64_types.h                   |  2 +-
 arch/x86/include/asm/paravirt.h                        |  4 ++--
 arch/x86/include/asm/pgalloc.h                         |  4 ++--
 arch/x86/include/asm/pgtable.h                         | 12 ++++++------
 arch/x86/include/asm/pgtable_32_types.h                |  2 +-
 arch/x86/include/asm/pgtable_64.h                      |  2 +-
 arch/x86/include/asm/pgtable_64_types.h                | 25 ++++++++++++++++++-------
 arch/x86/include/asm/processor.h                       |  9 ---------
 arch/x86/include/asm/smp.h                             |  1 -
 arch/x86/include/asm/sparsemem.h                       |  4 ++--
 arch/x86/kernel/cpu/Makefile                           |  2 +-
 arch/x86/kernel/cpu/amd.c                              | 36 ++++++++++++------------------------
 arch/x86/kernel/cpu/{intel_cacheinfo.c => cacheinfo.c} | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 arch/x86/kernel/cpu/centaur.c                          | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/common.c                           | 35 +++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/cpu.h                              | 10 ++++++++++
 arch/x86/kernel/cpu/intel.c                            | 34 +++++-----------------------------
 arch/x86/kernel/cpu/topology.c                         |  8 ++++----
 arch/x86/kernel/head64.c                               | 25 ++++++++++++-------------
 arch/x86/kernel/machine_kexec_64.c                     |  3 ++-
 arch/x86/kernel/smpboot.c                              |  7 -------
 arch/x86/mm/dump_pagetables.c                          |  6 +++---
 arch/x86/mm/fault.c                                    |  4 ++--
 arch/x86/mm/ident_map.c                                |  2 +-
 arch/x86/mm/init_64.c                                  |  8 ++++----
 arch/x86/mm/kasan_init_64.c                            | 14 ++++++--------
 arch/x86/mm/kaslr.c                                    |  8 ++++----
 arch/x86/mm/tlb.c                                      |  2 +-
 arch/x86/platform/efi/efi_64.c                         |  2 +-
 arch/x86/power/hibernate_64.c                          |  2 +-
 38 files changed, 263 insertions(+), 167 deletions(-)
 create mode 100644 arch/x86/include/asm/cacheinfo.h
 rename arch/x86/kernel/cpu/{intel_cacheinfo.c => cacheinfo.c} (95%)
