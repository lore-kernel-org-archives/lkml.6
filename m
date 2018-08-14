Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39842C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 11:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDEE221738
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 11:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDEE221738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732353AbeHNOXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 10:23:15 -0400
Received: from foss.arm.com ([217.140.101.70]:42062 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730099AbeHNOXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 10:23:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0E827A9;
        Tue, 14 Aug 2018 04:36:27 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7EAB33F73C;
        Tue, 14 Aug 2018 04:36:27 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 197B21AE015E; Tue, 14 Aug 2018 12:36:34 +0100 (BST)
Date:   Tue, 14 Aug 2018 12:36:34 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, marc.zyngier@arm.com, tglx@linutronix.de
Subject: [GIT PULL] arm64: updates for 4.19
Message-ID: <20180814113633.GE28664@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these arm64 updates for 4.19. Details in the tag, but please be
aware that we've pulled in the x86/mm branch from -tip so that we can make
use of the core ioremap changes which allow us to put down huge mappings
in the vmalloc area without screwing up the TLB. Much of the positive
diffstat is because of the rseq selftest for arm64.

There is a trivial conflict in arch/arm64/Makefile with your tree, since
we effectively rewrote a fix that was merged in -rc5 [96f95a17c1cf]. The
correct resolution is therefore to prefer the code using ld-option, which
is what we have here. We also ran into a couple of trivial conflicts that
were resolved in -next with the KVM and EFI trees.

Cheers,

Will

--->8

The following changes since commit 5e0fb5df2ee871b841f96f9cb6a7f2784e96aa4e:

  x86/mm: Add TLB purge to free pmd/pte page interfaces (2018-07-04 21:37:09 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

for you to fetch changes up to 3c4d9137eefecf273a520d392071ffc9df0a9a7a:

  arm64: alternative: Use true and false for boolean values (2018-08-08 11:20:54 +0100)

----------------------------------------------------------------
arm64 updates for 4.19

A bunch of good stuff in here:

- Wire up support for qspinlock, replacing our trusty ticket lock code

- Add an IPI to flush_icache_range() to ensure that stale instructions
  fetched into the pipeline are discarded along with the I-cache lines

- Support for the GCC "stackleak" plugin

- Support for restartable sequences, plus an arm64 port for the selftest

- Kexec/kdump support on systems booting with ACPI

- Rewrite of our syscall entry code in C, which allows us to zero the
  GPRs on entry from userspace

- Support for chained PMU counters, allowing 64-bit event counters to be
  constructed on current CPUs

- Ensure scheduler topology information is kept up-to-date with CPU
  hotplug events

- Re-enable support for huge vmalloc/IO mappings now that the core code
  has the correct hooks to use break-before-make sequences

- Miscellaneous, non-critical fixes and cleanups

----------------------------------------------------------------
AKASHI Takahiro (3):
      drivers: acpi: add dependency of EFI for arm64
      efi/arm: map UEFI memory map even w/o runtime services enabled
      arm64: acpi: fix alignment fault in accessing ACPI

Ard Biesheuvel (2):
      efi/arm: preserve early mapping of UEFI memory map longer for BGRT
      arm64: drop unused kernel_neon_begin_partial() macro

Arnd Bergmann (2):
      arm64: make flatmem depend on !NUMA
      arm64: fix ACPI dependencies

Ben Hutchings (1):
      arm64: mm: Export __sync_icache_dcache() for xen-privcmd

Bhupesh Sharma (1):
      arm64, kaslr: export offset in VMCOREINFO ELF notes

Chintan Pandya (2):
      arm64: tlbflush: Introduce __flush_tlb_kernel_pgtable
      arm64: Implement page table free interfaces

Dave Kleikamp (1):
      arm64: kexec: machine_kexec should call __flush_icache_range

Gustavo A. R. Silva (1):
      arm64: alternative: Use true and false for boolean values

James Morse (1):
      arm64: export memblock_reserve()d regions via /proc/iomem

Kees Cook (1):
      perf/arm-cci: Remove VLA usage

Laura Abbott (3):
      arm64: Add stack information to on_accessible_stack
      arm64: Add support for STACKLEAK gcc plugin
      efi/libstub: Only disable stackleak plugin for arm64

Lorenzo Pieralisi (1):
      arm64: numa: rework ACPI NUMA initialization

Mark Rutland (30):
      arm64: kexec: always reset to EL2 if present
      arm64: add PSR_AA32_* definitions
      arm64: don't zero DIT on signal return
      arm64: compat: map SPSR_ELx<->PSR for signals
      arm64: ptrace: map SPSR_ELx<->PSR for compat tasks
      arm64: use PSR_AA32 definitions
      kvm/arm: use PSR_AA32 definitions
      arm64: remove unused COMPAT_PSR definitions
      arm64: consistently use unsigned long for thread flags
      arm64: move SCTLR_EL{1,2} assertions to <asm/sysreg.h>
      arm64: kill config_sctlr_el1()
      arm64: kill change_cpacr()
      arm64: move sve_user_{enable,disable} to <asm/fpsimd.h>
      arm64: remove sigreturn wrappers
      arm64: introduce syscall_fn_t
      arm64: convert raw syscall invocation to C
      arm64: convert syscall trace logic to C
      arm64: convert native/compat syscall entry to C
      arm64: don't restore GPRs when context tracking
      arm64: don't reload GPRs after apply_ssbd
      arm64: zero GPRs upon entry from EL0
      arm64: drop alignment from syscall tables
      kernel: add ksys_personality()
      kernel: add kcompat_sys_{f,}statfs64()
      arm64: remove in-kernel call to sys_personality()
      arm64: use {COMPAT,}SYSCALL_DEFINE0 for sigreturn
      arm64: use SYSCALL_DEFINE6() for mmap
      arm64: convert compat wrappers to C
      arm64: implement syscall wrappers
      arm64: fix possible spectre-v1 write in ptrace_hbp_set_event()

Michael O'Farrell (1):
      arm64: perf: Add cap_user_time aarch64

Mikulas Patocka (1):
      arm64: fix infinite stacktrace

Nikunj Kela (1):
      arm64: add ARM64-specific support for flatmem

Olof Johansson (1):
      arm64: build with baremetal linker target instead of Linux when available

Peng Donglin (1):
      ARM64: dump: Convert to use DEFINE_SHOW_ATTRIBUTE macro

Shaokun Zhang (1):
      drivers/perf: hisi: update the sccl_id/ccl_id when MT is supported

Stefan Agner (1):
      arm: perf: prevent unbind/bind via sysfs

Sudeep Holla (8):
      arm64: topology: refactor reset_cpu_topology to add support for removing topology
      arm64: numa: separate out updates to percpu nodeid and NUMA node cpumap
      arm64: topology: add support to remove cpu topology sibling masks
      arm64: topology: restrict updating siblings_masks to online cpus only
      arm64: smp: remove cpu and numa topology information when hotplugging out CPU
      arm64: topology: rename llc_siblings to align with other struct members
      arm64: topology: re-introduce numa mask check for scheduler MC selection
      drivers/perf: arm-ccn: Use devm_ioremap_resource() to map memory

Suzuki K Poulose (9):
      arm64: Fix mismatched cache line size detection
      arm64: Handle mismatched cache type
      arm_pmu: Clean up maximum period handling
      arm_pmu: Change API to support 64bit counter values
      arm_pmu: Add support for 64bit event counters
      arm_pmu: Tidy up clear_event_idx call backs
      arm64: perf: Clean up armv8pmu_select_counter
      arm64: perf: Disable PMU while processing counter overflows
      arm64: perf: Add support for chaining event counters

Will Deacon (19):
      drivers/perf: Initialise return value in armpmu_request_irqs()
      arm64: barrier: Implement smp_cond_load_relaxed
      arm64: locking: Replace ticket lock implementation with qspinlock
      arm64: kconfig: Ensure spinlock fastpaths are inlined if !PREEMPT
      arm64: IPI each CPU after invalidating the I-cache for kernel mappings
      arm64: insn: Don't fallback on nosync path for general insn patching
      Merge branch 'x86/mm' of git://git.kernel.org/.../tip/tip into aarch64/for-next/core
      arm64: errata: Don't define type field twice for arm64_errata[] entries
      arm64: mm: Export __flush_icache_range() to modules
      MAINTAINERS: arm64: Remove boot/dts/ directory from arm64 entry
      arm64: rseq: Implement backend rseq calls and select HAVE_RSEQ
      asm-generic: unistd.h: Wire up sys_rseq
      Revert "arm64: fix infinite stacktrace"
      arm64: Drop asmlinkage qualifier from syscall_trace_{enter,exit}
      rseq/selftests: Add support for arm64
      Merge branch 'for-next/perf' of git://git.kernel.org/.../will/linux into aarch64/for-next/core
      arm64: svc: Ensure hardirq tracing is updated before return
      arm64: sdei: Mark sdei stack helper functions as static
      arm64: kexec: Add comment to explain use of __flush_icache_range()

 MAINTAINERS                               |   1 +
 arch/arm/include/asm/kvm_emulate.h        |  14 +-
 arch/arm/kernel/perf_event_v6.c           |  14 +-
 arch/arm/kernel/perf_event_v7.c           |  15 +-
 arch/arm/kernel/perf_event_xscale.c       |  18 +-
 arch/arm64/Kconfig                        |  18 +
 arch/arm64/Makefile                       |   9 +-
 arch/arm64/include/asm/Kbuild             |   1 +
 arch/arm64/include/asm/acpi.h             |  29 +-
 arch/arm64/include/asm/barrier.h          |  13 +
 arch/arm64/include/asm/cache.h            |   4 +
 arch/arm64/include/asm/cacheflush.h       |  27 +-
 arch/arm64/include/asm/cpucaps.h          |   3 +-
 arch/arm64/include/asm/fpsimd.h           |  17 +-
 arch/arm64/include/asm/insn.h             |   2 -
 arch/arm64/include/asm/kvm_emulate.h      |  10 +-
 arch/arm64/include/asm/neon.h             |   7 -
 arch/arm64/include/asm/numa.h             |   4 +
 arch/arm64/include/asm/processor.h        |  21 +-
 arch/arm64/include/asm/ptrace.h           |  79 ++--
 arch/arm64/include/asm/sdei.h             |   9 +-
 arch/arm64/include/asm/spinlock.h         | 117 +-----
 arch/arm64/include/asm/spinlock_types.h   |  17 +-
 arch/arm64/include/asm/stacktrace.h       |  73 +++-
 arch/arm64/include/asm/syscall.h          |   8 +-
 arch/arm64/include/asm/syscall_wrapper.h  |  80 ++++
 arch/arm64/include/asm/sysreg.h           |  30 +-
 arch/arm64/include/asm/tlbflush.h         |   7 +
 arch/arm64/include/asm/topology.h         |   4 +-
 arch/arm64/include/asm/unistd.h           |   2 +-
 arch/arm64/include/asm/unistd32.h         |  28 +-
 arch/arm64/kernel/Makefile                |   5 +-
 arch/arm64/kernel/acpi.c                  |  11 +-
 arch/arm64/kernel/acpi_numa.c             |  88 +++--
 arch/arm64/kernel/alternative.c           |   4 +-
 arch/arm64/kernel/armv8_deprecated.c      |  32 +-
 arch/arm64/kernel/cpu-reset.h             |   9 +-
 arch/arm64/kernel/cpu_errata.c            |  30 +-
 arch/arm64/kernel/cpufeature.c            |   4 +-
 arch/arm64/kernel/entry.S                 | 160 ++------
 arch/arm64/kernel/entry32.S               | 121 ------
 arch/arm64/kernel/fpsimd.c                |  19 -
 arch/arm64/kernel/insn.c                  |  70 +---
 arch/arm64/kernel/machine_kexec.c         |  15 +-
 arch/arm64/kernel/perf_event.c            | 281 +++++++++++---
 arch/arm64/kernel/process.c               |  42 ++-
 arch/arm64/kernel/ptrace.c                |  61 +--
 arch/arm64/kernel/sdei.c                  |  48 ++-
 arch/arm64/kernel/setup.c                 |  38 ++
 arch/arm64/kernel/signal.c                |   8 +-
 arch/arm64/kernel/signal32.c              |  24 +-
 arch/arm64/kernel/smp.c                   |  44 ++-
 arch/arm64/kernel/stacktrace.c            |   2 +-
 arch/arm64/kernel/sys.c                   |  29 +-
 arch/arm64/kernel/sys32.c                 | 135 ++++++-
 arch/arm64/kernel/syscall.c               | 139 +++++++
 arch/arm64/kernel/topology.c              |  58 ++-
 arch/arm64/kernel/traps.c                 |  18 +-
 arch/arm64/kvm/guest.c                    |  14 +-
 arch/arm64/kvm/hyp/Makefile               |   3 +-
 arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c  |   2 +-
 arch/arm64/kvm/regmap.c                   |  22 +-
 arch/arm64/kvm/reset.c                    |   4 +-
 arch/arm64/mm/cache.S                     |   4 +-
 arch/arm64/mm/fault.c                     |   2 +-
 arch/arm64/mm/flush.c                     |   3 +-
 arch/arm64/mm/mmu.c                       |  48 ++-
 arch/arm64/mm/numa.c                      |  29 +-
 arch/arm64/mm/ptdump_debugfs.c            |  13 +-
 arch/ia64/Kconfig                         |   1 +
 arch/x86/Kconfig                          |   1 +
 drivers/acpi/Kconfig                      |   8 +-
 drivers/firmware/efi/arm-init.c           |   1 -
 drivers/firmware/efi/arm-runtime.c        |  18 +-
 drivers/firmware/efi/libstub/Makefile     |   7 +-
 drivers/perf/arm-cci.c                    |  38 +-
 drivers/perf/arm-ccn.c                    |  14 +-
 drivers/perf/arm_pmu.c                    |  38 +-
 drivers/perf/arm_pmu_platform.c           |   2 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.c  |  12 +-
 fs/statfs.c                               |  14 +-
 include/linux/compat.h                    |  11 +
 include/linux/perf/arm_pmu.h              |  11 +-
 include/linux/syscalls.h                  |  11 +
 include/uapi/asm-generic/unistd.h         |   4 +-
 kernel/events/core.c                      |   4 +-
 scripts/Kbuild.include                    |   4 +-
 tools/testing/selftests/rseq/param_test.c |  20 +
 tools/testing/selftests/rseq/rseq-arm64.h | 594 ++++++++++++++++++++++++++++++
 tools/testing/selftests/rseq/rseq.h       |   2 +
 virt/kvm/arm/aarch32.c                    |  20 +-
 91 files changed, 2154 insertions(+), 1001 deletions(-)
 create mode 100644 arch/arm64/include/asm/syscall_wrapper.h
 delete mode 100644 arch/arm64/kernel/entry32.S
 create mode 100644 arch/arm64/kernel/syscall.c
 create mode 100644 tools/testing/selftests/rseq/rseq-arm64.h
