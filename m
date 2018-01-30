Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753688AbeA3T0o (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 14:26:44 -0500
Received: from foss.arm.com ([217.140.101.70]:57770 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753392AbeA3T0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 14:26:42 -0500
Date: Tue, 30 Jan 2018 19:26:39 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 updates for 4.16
Message-ID: <20180130192636.sctfdnedffxv7vmv@armageddon.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The main theme of this pull request is security covering variants 2 and
3 for arm64. I expect to send additional patches next week covering an
improved firmware interface (requires firmware changes) for variant 2
and way for KPTI to be disabled on unaffected CPUs (Cavium's ThunderX
doesn't work properly with KPTI enabled because of a hardware erratum).

This pull request touches KVM (for variant 2), drivers/* (it introduces
an arm64 firmware interface, drivers/irqchip/irq-gic-v3.c (some ARM perf
refactoring) and kernel/events/core.c (one line to export a symbol).
Acks are in place.

Thank you.


The following changes since commit 50c4c4e268a2d7a3e58ebb698ac74da0de40ae36:

  Linux 4.15-rc3 (2017-12-10 17:56:26 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

for you to fetch changes up to ec89ab50a03a33a4a648869e868b1964354fb2d1:

  arm64: Fix TTBR + PAN + 52-bit PA logic in cpu_do_switch_mm (2018-01-26 18:23:17 +0000)

----------------------------------------------------------------
arm64 updates for 4.16:

- Security mitigations:
  - variant 2: invalidating the branch predictor with a call to secure firmware
  - variant 3: implementing KPTI for arm64

- 52-bit physical address support for arm64 (ARMv8.2)

- arm64 support for RAS (firmware first only) and SDEI (software
  delegated exception interface; allows firmware to inject a RAS error
  into the OS)

- Perf support for the ARM DynamIQ Shared Unit PMU

- CPUID and HWCAP bits updated for new floating point multiplication
  instructions in ARMv8.4

- Removing some virtual memory layout printks during boot

- Fix initial page table creation to cope with larger than 32M kernel
  images when 16K pages are enabled

----------------------------------------------------------------
Catalin Marinas (5):
      Merge branch 'kpti' of git://git.kernel.org/.../arm64/linux
      Merge branch 'for-next/52-bit-pa' into for-next/core
      arm64: asid: Do not replace active_asids if already 0
      Merge branch 'for-next/perf' of git://git.kernel.org/.../will/linux
      arm64: kpti: Fix the interaction between ASID switching and software PAN

Dave Martin (1):
      arm64: fpsimd: Fix state leakage when migrating after sigreturn

Dongjiu Geng (2):
      arm64: v8.4: Support for new floating point multiplication instructions
      KVM: arm64: Emulate RAS error registers and set HCR_EL2's TERR & TEA

James Morse (27):
      KVM: arm64: Store vcpu on the stack during __guest_enter()
      KVM: arm/arm64: Convert kvm_host_cpu_state to a static per-cpu allocation
      KVM: arm64: Change hyp_panic()s dependency on tpidr_el2
      arm64: alternatives: use tpidr_el2 on VHE hosts
      KVM: arm64: Stop save/restoring host tpidr_el1 on VHE
      Docs: dt: add devicetree binding for describing arm64 SDEI firmware
      firmware: arm_sdei: Add driver for Software Delegated Exceptions
      arm64: Add vmap_stack header file
      arm64: uaccess: Add PAN helper
      arm64: kernel: Add arch-specific SDEI entry code and CPU masking
      firmware: arm_sdei: Add support for CPU and system power states
      firmware: arm_sdei: add support for CPU private events
      arm64: acpi: Remove __init from acpi_psci_use_hvc() for use by SDEI
      firmware: arm_sdei: Discover SDEI support via ACPI
      arm64: mmu: add the entry trampolines start/end section markers into sections.h
      arm64: sdei: Add trampoline code for remapping the kernel
      arm64: cpufeature: __this_cpu_has_cap() shouldn't stop early
      arm64: sysreg: Move to use definitions for all the SCTLR bits
      arm64: kernel: Survive corrected RAS errors notified by SError
      arm64: Unconditionally enable IESB on exception entry/return for firmware-first
      arm64: kernel: Prepare for a DISR user
      KVM: arm/arm64: mask/unmask daif around VHE guests
      KVM: arm64: Set an impdef ESR for Virtual-SError using VSESR_EL2.
      KVM: arm64: Save/Restore guest DISR_EL1
      KVM: arm64: Save ESR_EL2 on guest SError
      KVM: arm64: Handle RAS SErrors from EL1 on guest exit
      KVM: arm64: Handle RAS SErrors from EL2 on guest exit

Jason A. Donenfeld (1):
      arm64: make label allocation style consistent in tishift

Jayachandran C (3):
      arm64: cputype: Add MIDR values for Cavium ThunderX2 CPUs
      arm64: Branch predictor hardening for Cavium ThunderX2
      arm64: Turn on KPTI only on CPUs that need it

Kristina Martsenko (12):
      arm64: add kconfig symbol to configure physical address size
      arm64: limit PA size to supported range
      arm64: handle 52-bit addresses in TTBR
      arm64: head.S: handle 52-bit PAs in PTEs in early page table setup
      arm64: don't open code page table entry creation
      arm64: handle 52-bit physical addresses in page table entries
      arm64: allow ID map to be extended to 52 bits
      arm64: enable 52-bit physical address support
      arm64: fix ID map extension to 52 bits
      KVM: arm/arm64: fix HYP ID map extension to 52 bits
      arm64: fix comment above tcr_compute_pa_size
      arm64: mm: ignore memory above supported physical address size

Laura Abbott (1):
      arm64: Stop printing the virtual memory layout

Marc Zyngier (4):
      arm64: Move post_ttbr_update_workaround to C code
      arm64: KVM: Use per-CPU vector when BP hardening is enabled
      arm64: KVM: Make PSCI_VERSION a fast path
      arm64: Move BP hardening to check_and_switch_context

Prashanth Prakash (2):
      cpuidle: Add new macro to enter a retention idle state
      ARM64 / cpuidle: Use new cpuidle macro for entering retention state

Punit Agrawal (1):
      arm64: Correct type for PUD macros

Shanker Donthineni (1):
      arm64: Implement branch predictor hardening for Falkor

Stephen Boyd (2):
      arm64: cpu_errata: Add Kryo to Falkor 1003 errata
      arm64: Inform user if software PAN is in use

Steve Capper (4):
      arm64: Re-order reserved_ttbr0 in linker script
      arm64: entry: Move the trampoline to be before PAN
      arm64: Extend early page table code to allow for larger kernels
      arm64: Fix TTBR + PAN + 52-bit PA logic in cpu_do_switch_mm

Suzuki K Poulose (11):
      perf: Export perf_event_update_userpage
      of: Add helper for mapping device node to logical CPU number
      coresight: of: Use of_cpu_node_to_id helper
      irqchip: gic-v3: Use of_cpu_node_to_id helper
      arm64: Use of_cpu_node_to_id helper for CPU topology parsing
      arm_pmu: Use of_cpu_node_to_id helper
      dt-bindings: Document devicetree binding for ARM DSU PMU
      perf: ARM DynamIQ Shared Unit PMU support
      arm64: capabilities: Handle duplicate entries for a capability
      perf: dsu: Use signed field for dsu_pmu->num_counters
      arm64: Run enable method for errata work arounds on late CPUs

Wei Yongjun (1):
      firmware: arm_sdei: Fix return value check in sdei_present_dt()

Will Deacon (28):
      arm64: mm: Use non-global mappings for kernel space
      arm64: mm: Temporarily disable ARM64_SW_TTBR0_PAN
      arm64: mm: Move ASID from TTBR0 to TTBR1
      arm64: mm: Remove pre_ttbr0_update_workaround for Falkor erratum #E1003
      arm64: mm: Rename post_ttbr0_update_workaround
      arm64: mm: Fix and re-enable ARM64_SW_TTBR0_PAN
      arm64: mm: Allocate ASIDs in pairs
      arm64: mm: Add arm64_kernel_unmapped_at_el0 helper
      arm64: mm: Invalidate both kernel and user ASIDs when performing TLBI
      arm64: entry: Add exception trampoline page for exceptions from EL0
      arm64: mm: Map entry trampoline into trampoline and kernel page tables
      arm64: entry: Explicitly pass exception level to kernel_ventry macro
      arm64: entry: Hook up entry trampoline to exception vectors
      arm64: erratum: Work around Falkor erratum #E1003 in trampoline code
      arm64: tls: Avoid unconditional zeroing of tpidrro_el0 for native tasks
      arm64: entry: Add fake CPU feature for unmapping the kernel at EL0
      arm64: Kconfig: Add CONFIG_UNMAP_KERNEL_AT_EL0
      perf: arm_spe: Fail device probe when arm64_kernel_unmapped_at_el0()
      arm64: mm: Introduce TTBR_ASID_MASK for getting at the ASID in the TTBR
      arm64: kaslr: Put kernel vectors address in separate data page
      arm64: use RET instruction for exiting the trampoline
      arm64: Kconfig: Reword UNMAP_KERNEL_AT_EL0 kconfig entry
      arm64: Take into account ID_AA64PFR0_EL1.CSV3
      arm64: cpufeature: Pass capability structure to ->enable callback
      drivers/firmware: Expose psci_get_version through psci_ops structure
      arm64: Add skeleton to harden the branch predictor against aliasing attacks
      arm64: cputype: Add missing MIDR values for Cortex-A72 and Cortex-A75
      arm64: Implement branch predictor hardening for affected Cortex-A CPUs

Xie XiuQi (1):
      arm64: cpufeature: Detect CPU RAS Extentions

 Documentation/arm64/cpu-feature-registers.txt      |    4 +-
 Documentation/arm64/elf_hwcaps.txt                 |    4 +
 Documentation/arm64/silicon-errata.txt             |    2 +-
 .../devicetree/bindings/arm/arm-dsu-pmu.txt        |   27 +
 .../devicetree/bindings/arm/firmware/sdei.txt      |   42 +
 Documentation/perf/arm_dsu_pmu.txt                 |   28 +
 MAINTAINERS                                        |    9 +
 arch/arm/include/asm/kvm_host.h                    |    5 +
 arch/arm/include/asm/kvm_mmu.h                     |   17 +
 arch/arm64/Kconfig                                 |   91 +-
 arch/arm64/include/asm/alternative.h               |    2 +
 arch/arm64/include/asm/arm_dsu_pmu.h               |  129 +++
 arch/arm64/include/asm/asm-uaccess.h               |   42 +-
 arch/arm64/include/asm/assembler.h                 |   75 +-
 arch/arm64/include/asm/cpucaps.h                   |    6 +-
 arch/arm64/include/asm/cputype.h                   |    9 +
 arch/arm64/include/asm/efi.h                       |   12 +-
 arch/arm64/include/asm/esr.h                       |   20 +
 arch/arm64/include/asm/exception.h                 |   14 +
 arch/arm64/include/asm/fixmap.h                    |    5 +
 arch/arm64/include/asm/fpsimd.h                    |    2 +-
 arch/arm64/include/asm/kernel-pgtable.h            |   59 +-
 arch/arm64/include/asm/kvm_arm.h                   |    2 +
 arch/arm64/include/asm/kvm_asm.h                   |    2 +
 arch/arm64/include/asm/kvm_emulate.h               |   17 +
 arch/arm64/include/asm/kvm_host.h                  |   19 +
 arch/arm64/include/asm/kvm_mmu.h                   |   59 +-
 arch/arm64/include/asm/mmu.h                       |   49 +
 arch/arm64/include/asm/mmu_context.h               |   27 +-
 arch/arm64/include/asm/percpu.h                    |   11 +-
 arch/arm64/include/asm/pgalloc.h                   |    6 +-
 arch/arm64/include/asm/pgtable-hwdef.h             |   32 +-
 arch/arm64/include/asm/pgtable-prot.h              |   21 +-
 arch/arm64/include/asm/pgtable.h                   |   57 +-
 arch/arm64/include/asm/proc-fns.h                  |    6 -
 arch/arm64/include/asm/processor.h                 |    1 +
 arch/arm64/include/asm/sdei.h                      |   57 +
 arch/arm64/include/asm/sections.h                  |    1 +
 arch/arm64/include/asm/sparsemem.h                 |    2 +-
 arch/arm64/include/asm/stacktrace.h                |    3 +
 arch/arm64/include/asm/sysreg.h                    |   92 +-
 arch/arm64/include/asm/tlbflush.h                  |   16 +-
 arch/arm64/include/asm/traps.h                     |   54 +
 arch/arm64/include/asm/uaccess.h                   |   40 +-
 arch/arm64/include/asm/vmap_stack.h                |   28 +
 arch/arm64/include/uapi/asm/hwcap.h                |    1 +
 arch/arm64/kernel/Makefile                         |    5 +
 arch/arm64/kernel/acpi.c                           |    2 +-
 arch/arm64/kernel/alternative.c                    |    9 +-
 arch/arm64/kernel/asm-offsets.c                    |   12 +-
 arch/arm64/kernel/bpi.S                            |   87 ++
 arch/arm64/kernel/cpu_errata.c                     |  192 +++-
 arch/arm64/kernel/cpufeature.c                     |  146 ++-
 arch/arm64/kernel/cpuidle.c                        |    8 +-
 arch/arm64/kernel/cpuinfo.c                        |    1 +
 arch/arm64/kernel/entry.S                          |  396 ++++++-
 arch/arm64/kernel/fpsimd.c                         |    4 +-
 arch/arm64/kernel/head.S                           |  245 +++--
 arch/arm64/kernel/hibernate-asm.S                  |   12 +-
 arch/arm64/kernel/hibernate.c                      |    5 +-
 arch/arm64/kernel/irq.c                            |   13 +-
 arch/arm64/kernel/process.c                        |   12 +-
 arch/arm64/kernel/sdei.c                           |  235 +++++
 arch/arm64/kernel/signal.c                         |    7 +-
 arch/arm64/kernel/signal32.c                       |    5 +-
 arch/arm64/kernel/smp.c                            |   11 +-
 arch/arm64/kernel/suspend.c                        |    4 +-
 arch/arm64/kernel/topology.c                       |   16 +-
 arch/arm64/kernel/traps.c                          |   51 +-
 arch/arm64/kernel/vmlinux.lds.S                    |   27 +-
 arch/arm64/kvm/handle_exit.c                       |   32 +-
 arch/arm64/kvm/hyp-init.S                          |   30 +-
 arch/arm64/kvm/hyp/entry.S                         |   35 +-
 arch/arm64/kvm/hyp/hyp-entry.S                     |   18 +-
 arch/arm64/kvm/hyp/s2-setup.c                      |    2 +
 arch/arm64/kvm/hyp/switch.c                        |   60 +-
 arch/arm64/kvm/hyp/sysreg-sr.c                     |   22 +-
 arch/arm64/kvm/inject_fault.c                      |   13 +-
 arch/arm64/kvm/sys_regs.c                          |   11 +
 arch/arm64/lib/clear_user.S                        |    4 +-
 arch/arm64/lib/copy_from_user.S                    |    4 +-
 arch/arm64/lib/copy_in_user.S                      |    4 +-
 arch/arm64/lib/copy_to_user.S                      |    4 +-
 arch/arm64/lib/tishift.S                           |    8 +-
 arch/arm64/mm/cache.S                              |    4 +-
 arch/arm64/mm/context.c                            |   67 +-
 arch/arm64/mm/fault.c                              |   17 +
 arch/arm64/mm/init.c                               |   46 +-
 arch/arm64/mm/mmu.c                                |   47 +-
 arch/arm64/mm/pgd.c                                |    8 +
 arch/arm64/mm/proc.S                               |   66 +-
 arch/arm64/xen/hypercall.S                         |    4 +-
 drivers/firmware/Kconfig                           |    8 +
 drivers/firmware/Makefile                          |    1 +
 drivers/firmware/arm_sdei.c                        | 1092 ++++++++++++++++++++
 drivers/firmware/psci.c                            |    2 +
 drivers/hwtracing/coresight/of_coresight.c         |   15 +-
 drivers/irqchip/irq-gic-v3.c                       |   29 +-
 drivers/of/base.c                                  |   26 +
 drivers/perf/Kconfig                               |    9 +
 drivers/perf/Makefile                              |    1 +
 drivers/perf/arm_dsu_pmu.c                         |  843 +++++++++++++++
 drivers/perf/arm_pmu_platform.c                    |   15 +-
 drivers/perf/arm_spe_pmu.c                         |    9 +
 include/linux/arm_sdei.h                           |   79 ++
 include/linux/cpuhotplug.h                         |    1 +
 include/linux/cpuidle.h                            |   40 +-
 include/linux/of.h                                 |    7 +
 include/linux/psci.h                               |    4 +-
 include/uapi/linux/arm_sdei.h                      |   73 ++
 kernel/events/core.c                               |    1 +
 virt/kvm/arm/arm.c                                 |   35 +-
 virt/kvm/arm/mmu.c                                 |   12 +-
 113 files changed, 4941 insertions(+), 579 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/arm-dsu-pmu.txt
 create mode 100644 Documentation/devicetree/bindings/arm/firmware/sdei.txt
 create mode 100644 Documentation/perf/arm_dsu_pmu.txt
 create mode 100644 arch/arm64/include/asm/arm_dsu_pmu.h
 create mode 100644 arch/arm64/include/asm/sdei.h
 create mode 100644 arch/arm64/include/asm/vmap_stack.h
 create mode 100644 arch/arm64/kernel/bpi.S
 create mode 100644 arch/arm64/kernel/sdei.c
 create mode 100644 drivers/firmware/arm_sdei.c
 create mode 100644 drivers/perf/arm_dsu_pmu.c
 create mode 100644 include/linux/arm_sdei.h
 create mode 100644 include/uapi/linux/arm_sdei.h

-- 
Catalin
