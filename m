Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751318AbeDDOc3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 10:32:29 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45232 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751167AbeDDOc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 10:32:27 -0400
Date: Wed, 4 Apr 2018 15:32:40 +0100
From: Will Deacon <will.deacon@arm.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, lorenzo.pieralisi@arm.com,
        ebiederm@xmission.com, marc.zyngier@arm.com
Subject: [GIT PULL] arm64: updates for 4.17
Message-ID: <20180404143239.GA18238@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these arm64 updates for 4.17. Note that I've pulled in a
stable branch from Eric Biederman here to fulfil some siginfo dependencies,
so the diffstat strays slightly out of arm64 due to his changes.

Other than that, there's a summary in the tag. You'll get a handful of
straightforward conflicts with your tree due to some fixes we merged
for 4.16 casting the return value from firmware to an int and a couple of
trivial clashes caused by bumping NSIGFPE due to FPE_FLTUNK. There's also
a trivial conflict with the KVM tree removing hyp_offset_low and clashing
with some context.

I plan to send a second pull request after the KVM tree has gone in, since
we had to drop a spectre-related cleanup from -next last week because of
conflicts.

Cheers,

Will

--->8

The following changes since commit 4a3928c6f8a53fa1aed28ccba227742486e8ddcb:

  Linux 4.16-rc3 (2018-02-25 18:50:41 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

for you to fetch changes up to 65896545b69ffaac947c12e11d3dcc57fd1fb772:

  arm64: uaccess: Fix omissions from usercopy whitelist (2018-03-28 15:25:44 +0100)

----------------------------------------------------------------
arm64 updates for 4.17

Nothing particularly stands out here, probably because people were tied
up with spectre/meltdown stuff last time around. Still, the main pieces
are:

- Rework of our CPU features framework so that we can whitelist CPUs that
  don't require kpti even in a heterogeneous system

- Support for the IDC/DIC architecture extensions, which allow us to elide
  instruction and data cache maintenance when writing out instructions

- Removal of the large memory model which resulted in suboptimal codegen
  by the compiler and increased the use of literal pools, which could
  potentially be used as ROP gadgets since they are mapped as executable

- Rework of forced signal delivery so that the siginfo_t is well-formed
  and handling of show_unhandled_signals is consolidated and made
  consistent between different fault types

- More siginfo cleanup based on the initial patches from Eric Biederman

- Workaround for Cortex-A55 erratum #1024718

- Some small ACPI IORT updates and cleanups from Lorenzo Pieralisi

- Misc cleanups and non-critical fixes

----------------------------------------------------------------
Alexander Monakov (1):
      drivers/perf: arm_pmu_platform: do not warn about affinity on uniprocessor

Andrey Konovalov (1):
      kasan, arm64: clean up KASAN_SHADOW_SCALE_SHIFT usage

Ard Biesheuvel (8):
      arm64/kernel: kaslr: drop special Image placement logic
      scripts/kallsyms: filter arm64's __efistub_ symbols
      arm64: module: don't BUG when exceeding preallocated PLT count
      arm64/kernel: kaslr: reduce module randomization range to 4 GB
      arm64/kernel: don't ban ADRP to work around Cortex-A53 erratum #843419
      arm64/errata: add REVIDR handling to framework
      arm64/kernel: enable A53 erratum #8434319 handling at runtime
      arm64: asm: drop special versions of adr_l/ldr_l/str_l for modules

Arnd Bergmann (2):
      arm64: fix undefined reference to 'printk'
      perf: arm_spe: include linux/vmalloc.h for vmap()

Catalin Marinas (1):
      arm64: Revert L1_CACHE_SHIFT back to 6 (64-byte cache line size)

Dave Martin (7):
      arm64: signal: Ensure si_code is valid for all fault signals
      signal: Add FPE_FLTUNK si_code for undiagnosable fp exceptions
      arm64: fpsimd: Fix bad si_code for undiagnosed SIGFPE
      arm64/sve: Document firmware support requirements in Kconfig
      arm64: capabilities: Update prototype for enable call back
      arm64: fpsimd: Split cpu field out from struct fpsimd_state
      arm64: uaccess: Fix omissions from usercopy whitelist

Douglas Anderson (1):
      arm64/debug: Fix registers on sleeping tasks

Eric W. Biederman (2):
      signal: Correct the offset of si_pkey in struct siginfo
      signal/x86: Include the field offsets in the build time checks

Jia He (1):
      ACPI/IORT: Remove linker section for IORT entries again

Kees Cook (2):
      arm64: cpufeature: Relocate PAN emulation report
      arm64: cpufeature: Remove redundant "feature" in reports

Lorenzo Pieralisi (2):
      ACPI/IORT: Remove temporary iort_get_id_mapping_index() ACPICA guard
      ACPI/IORT: Remove obsolete ACPI_IORT_SMMU_V3_CAVIUM_CN99XX define

Michael Weiser (1):
      arm64: Mirror arm for unimplemented compat syscalls

Philip Elcan (1):
      arm64: tlbflush: avoid writing RES0 bits

Shanker Donthineni (1):
      arm64: Add support for new control bits CTR_EL0.DIC and CTR_EL0.IDC

Suzuki K Poulose (23):
      arm64: Documentation: cpu-feature-registers: Remove RES0 fields
      arm64: Expose Arm v8.4 features
      arm64: capabilities: Move errata work around check on boot CPU
      arm64: capabilities: Move errata processing code
      arm64: capabilities: Prepare for fine grained capabilities
      arm64: capabilities: Add flags to handle the conflicts on late CPU
      arm64: capabilities: Unify the verification
      arm64: capabilities: Filter the entries based on a given mask
      arm64: capabilities: Prepare for grouping features and errata work arounds
      arm64: capabilities: Split the processing of errata work arounds
      arm64: capabilities: Allow features based on local CPU scope
      arm64: capabilities: Group handling of features and errata workarounds
      arm64: capabilities: Introduce weak features based on local CPU
      arm64: capabilities: Restrict KPTI detection to boot-time CPUs
      arm64: capabilities: Add support for features enabled early
      arm64: capabilities: Change scope of VHE to Boot CPU feature
      arm64: capabilities: Clean up midr range helpers
      arm64: Add helpers for checking CPU MIDR against a range
      arm64: capabilities: Add support for checks based on a list of MIDRs
      arm64: capabilities: Handle shared entries
      arm64: Add MIDR encoding for Arm Cortex-A55 and Cortex-A35
      arm64: Delay enabling hardware DBM feature
      arm64: Add work around for Arm Cortex-A55 Erratum 1024718

Will Deacon (20):
      arm64: signal: Make force_signal_inject more robust
      arm64: signal: Force SIGKILL for unknown signals in force_signal_inject
      arm64: Introduce arm64_force_sig_info and hook up in arm64_notify_die
      arm64: signal: Don't print anything directly in force_signal_inject
      arm64: Pass user fault info to arm64_notify_die instead of printing it
      arm64: mm: Rework unhandled user pagefaults to call arm64_force_sig_info
      arm64: signal: Call arm64_notify_segfault when failing to deliver signal
      arm64: Move show_unhandled_signals_ratelimited into traps.c
      arm64: Use arm64_force_sig_info instead of force_sig_info
      arm64: lse: Pass -fomit-frame-pointer to out-of-line ll/sc atomics
      arm64: kaslr: Set TCR_EL1.NFD1 when CONFIG_RANDOMIZE_BASE=y
      Merge tag 'acpi/iort-for-v4.17' of git://git.kernel.org/.../lpieralisi/linux into aarch64/for-next/core
      Merge branch 'siginfo-next' of git://git.kernel.org/.../ebiederm/user-namespace into aarch64/for-next/core
      arm64: cpufeature: Avoid warnings due to unused symbols
      Revert "arm64: Revert L1_CACHE_SHIFT back to 6 (64-byte cache line size)"
      arm64: fpsimd: include <linux/init.h> in fpsimd.h
      arm64: lse: Include compiler_types.h and export.h for out-of-line LL/SC
      arm64: cmpxchg: Include build_bug.h instead of bug.h for BUILD_BUG
      arm64: move percpu cmpxchg implementation from cmpxchg.h to percpu.h
      arm64: cmpxchg: Include linux/compiler.h in asm/cmpxchg.h

 Documentation/arm64/cpu-feature-registers.txt |  18 +-
 Documentation/arm64/elf_hwcaps.txt            |  16 +
 Documentation/arm64/silicon-errata.txt        |   1 +
 arch/arm64/Kconfig                            |  47 ++-
 arch/arm64/Makefile                           |  15 +-
 arch/arm64/include/asm/assembler.h            |  34 +-
 arch/arm64/include/asm/cache.h                |   4 +
 arch/arm64/include/asm/cacheflush.h           |   3 +
 arch/arm64/include/asm/cmpxchg.h              |  29 +-
 arch/arm64/include/asm/cpucaps.h              |   6 +-
 arch/arm64/include/asm/cpufeature.h           | 262 ++++++++++++++-
 arch/arm64/include/asm/cputype.h              |  43 +++
 arch/arm64/include/asm/esr.h                  |   9 +
 arch/arm64/include/asm/fpsimd.h               |  34 +-
 arch/arm64/include/asm/lse.h                  |   3 +
 arch/arm64/include/asm/module.h               |   2 +
 arch/arm64/include/asm/percpu.h               |  29 ++
 arch/arm64/include/asm/pgtable-hwdef.h        |   1 +
 arch/arm64/include/asm/processor.h            |  47 ++-
 arch/arm64/include/asm/sysreg.h               |   3 +
 arch/arm64/include/asm/system_misc.h          |  11 -
 arch/arm64/include/asm/tlbflush.h             |  25 +-
 arch/arm64/include/asm/traps.h                |   8 +-
 arch/arm64/include/asm/virt.h                 |   6 -
 arch/arm64/include/uapi/asm/hwcap.h           |   4 +
 arch/arm64/include/uapi/asm/siginfo.h         |  21 --
 arch/arm64/kernel/armv8_deprecated.c          |   2 +-
 arch/arm64/kernel/cpu_errata.c                | 316 +++++++++++--------
 arch/arm64/kernel/cpufeature.c                | 438 ++++++++++++++++++++------
 arch/arm64/kernel/cpuinfo.c                   |   4 +
 arch/arm64/kernel/debug-monitors.c            |   3 +-
 arch/arm64/kernel/fpsimd.c                    | 105 +++---
 arch/arm64/kernel/kaslr.c                     |  35 +-
 arch/arm64/kernel/kgdb.c                      |  21 +-
 arch/arm64/kernel/module-plts.c               |  90 +++++-
 arch/arm64/kernel/module.c                    |  44 ++-
 arch/arm64/kernel/process.c                   |   6 +-
 arch/arm64/kernel/ptrace.c                    |  32 +-
 arch/arm64/kernel/reloc_test_core.c           |   4 +-
 arch/arm64/kernel/reloc_test_syms.S           |  12 +-
 arch/arm64/kernel/signal.c                    |   9 +-
 arch/arm64/kernel/signal32.c                  |  15 +-
 arch/arm64/kernel/smp.c                       |  44 ---
 arch/arm64/kernel/sys_compat.c                |  23 +-
 arch/arm64/kernel/traps.c                     |  76 +++--
 arch/arm64/lib/Makefile                       |   3 +-
 arch/arm64/mm/cache.S                         |  21 +-
 arch/arm64/mm/fault.c                         | 236 ++++++--------
 arch/arm64/mm/proc.S                          |  22 +-
 arch/x86/kernel/signal_compat.c               |  67 +++-
 drivers/acpi/arm64/iort.c                     |  12 -
 drivers/perf/arm_pmu_platform.c               |   2 +-
 drivers/perf/arm_spe_pmu.c                    |  14 +
 include/asm-generic/vmlinux.lds.h             |   1 -
 include/linux/compat.h                        |   4 +-
 include/linux/sizes.h                         |   4 +
 include/uapi/asm-generic/siginfo.h            |   7 +-
 kernel/signal.c                               |   4 -
 scripts/kallsyms.c                            |   1 +
 59 files changed, 1552 insertions(+), 806 deletions(-)
