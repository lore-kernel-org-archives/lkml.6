Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbeBJOpc (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 09:45:32 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46256 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750835AbeBJOp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 09:45:29 -0500
Date: Sat, 10 Feb 2018 15:45:08 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: [GIT PULL] KVM updates for Linux 4.16-rc1
Message-ID: <20180210144507.GA4191@flask>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

I apologize for complications with this pull request that was delayed
due to a sickness.

While I was bedridden, we've had a conflict with x86/pti that was not
resolved properly in next and it was a tricky one, so I have manually
merged msr-bitmaps topic branch into this pull request to hopefully
simplify the merge.

That merge and the last batch of PPC changes are not in next.   I've
included the PPC changes as they are all fixing bugs that we wouldn't
want in 4.16 anyway.

Features planned for the latter part of this merge window eventually
slipped to 4.17, so merge of x86/hyperv for the stable KVM clock on
Hyper-V is only really bringing conflict resolution with final 4.15.

Other conflict are to be resolved as in next and the expected resolution
can be found below a scissors line,

thanks.


The following changes since commit 904e14fb7cb96401a7dc803ca2863fd5ba32ffe6:

  KVM: VMX: make MSR bitmaps per-VCPU (2018-01-31 12:40:45 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/kvm tags/kvm-4.16-1

for you to fetch changes up to 1ab03c072feb579c9fd116de25be2b211e6bff6a:

  Merge tag 'kvm-ppc-next-4.16-2' of git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc (2018-02-09 22:03:06 +0100)

----------------------------------------------------------------
KVM changes for 4.16

ARM:
- Include icache invalidation optimizations, improving VM startup time

- Support for forwarded level-triggered interrupts, improving
  performance for timers and passthrough platform devices

- A small fix for power-management notifiers, and some cosmetic changes

PPC:
- Add MMIO emulation for vector loads and stores

- Allow HPT guests to run on a radix host on POWER9 v2.2 CPUs without
  requiring the complex thread synchronization of older CPU versions

- Improve the handling of escalation interrupts with the XIVE interrupt
  controller

- Support decrement register migration

- Various cleanups and bugfixes.

s390:
- Cornelia Huck passed maintainership to Janosch Frank

- Exitless interrupts for emulated devices

- Cleanup of cpuflag handling

- kvm_stat counter improvements

- VSIE improvements

- mm cleanup

x86:
- Hypervisor part of SEV

- UMIP, RDPID, and MSR_SMI_COUNT emulation

- Paravirtualized TLB shootdown using the new KVM_VCPU_PREEMPTED bit

- Allow guests to see TOPOEXT, GFNI, VAES, VPCLMULQDQ, and more AVX512
  features

- Show vcpu id in its anonymous inode name

- Many fixes and cleanups

- Per-VCPU MSR bitmaps (already merged through x86/pti branch)

- Stable KVM clock when nesting on Hyper-V (merged through x86/hyperv)

----------------------------------------------------------------
Alexander Graf (3):
      KVM: PPC: Book3S HV: Remove vcpu->arch.dec usage
      KVM: PPC: Book3S PR: Fix svcpu copying with preemption enabled
      KVM: PPC: Book3S HV: Branch inside feature section

Andrew Jones (1):
      arm64: KVM: Hide PMU from guests when disabled

Benjamin Herrenschmidt (6):
      KVM: PPC: Book3S HV: Add more info about XIVE queues in debugfs
      KVM: PPC: Book3S HV: Enable use of the new XIVE "single escalation" feature
      KVM: PPC: Book3S HV: Don't use existing "prodded" flag for XIVE escalations
      KVM: PPC: Book3S HV: Check DR not IR to chose real vs virt mode MMIOs
      KVM: PPC: Book3S HV: Make xive_pushed a byte, not a word
      KVM: PPC: Book3S HV: Keep XIVE escalation interrupt masked unless ceded

Borislav Petkov (2):
      crypto: ccp: Build the AMD secure processor driver only with AMD CPU support
      kvm/vmx: Use local vmx variable in vmx_get_msr()

Brijesh Singh (34):
      Documentation/virtual/kvm: Add AMD Secure Encrypted Virtualization (SEV)
      KVM: SVM: Prepare to reserve asid for SEV guest
      KVM: X86: Extend CPUID range to include new leaf
      KVM: Introduce KVM_MEMORY_ENCRYPT_OP ioctl
      KVM: Introduce KVM_MEMORY_ENCRYPT_{UN,}REG_REGION ioctl
      crypto: ccp: Define SEV userspace ioctl and command id
      crypto: ccp: Define SEV key management command id
      crypto: ccp: Add Platform Security Processor (PSP) device support
      crypto: ccp: Add Secure Encrypted Virtualization (SEV) command support
      crypto: ccp: Implement SEV_FACTORY_RESET ioctl command
      crypto: ccp: Implement SEV_PLATFORM_STATUS ioctl command
      crypto: ccp: Implement SEV_PEK_GEN ioctl command
      crypto: ccp: Implement SEV_PDH_GEN ioctl command
      crypto: ccp: Implement SEV_PEK_CSR ioctl command
      crypto: ccp: Implement SEV_PEK_CERT_IMPORT ioctl command
      crypto: ccp: Implement SEV_PDH_CERT_EXPORT ioctl command
      KVM: X86: Add CONFIG_KVM_AMD_SEV
      KVM: SVM: Reserve ASID range for SEV guest
      KVM: SVM: Add sev module_param
      KVM: Define SEV key management command id
      KVM: SVM: Add KVM_SEV_INIT command
      KVM: SVM: VMRUN should use associated ASID when SEV is enabled
      KVM: SVM: Add support for KVM_SEV_LAUNCH_START command
      KVM: SVM: Add support for KVM_SEV_LAUNCH_UPDATE_DATA command
      KVM: SVM: Add support for KVM_SEV_LAUNCH_MEASURE command
      KVM: SVM: Add support for SEV LAUNCH_FINISH command
      KVM: SVM: Add support for SEV GUEST_STATUS command
      KVM: SVM: Add support for SEV DEBUG_DECRYPT command
      KVM: SVM: Add support for SEV DEBUG_ENCRYPT command
      KVM: SVM: Add support for SEV LAUNCH_SECRET command
      KVM: SVM: Pin guest memory when SEV is active
      KVM: SVM: Clear C-bit from the page fault address
      KVM: SVM: Do not install #UD intercept when SEV is enabled
      KVM: X86: Restart the guest when insn_len is zero and SEV is enabled

Christian Borntraeger (5):
      KVM: s390: use created_vcpus in more places
      KVM: s390: add debug tracing for cpu features of CPU model
      kvm_config: add CONFIG_S390_GUEST
      KVM: s390: diagnoses are instructions as well
      KVM: s390: add vcpu stat counters for many instruction

Christoffer Dall (29):
      KVM: Take vcpu->mutex outside vcpu_load
      KVM: Prepare for moving vcpu_load/vcpu_put into arch specific code
      KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_run
      KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_get_regs
      KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_set_regs
      KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_get_sregs
      KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_set_sregs
      KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_get_mpstate
      KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_set_mpstate
      KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_translate
      KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_set_guest_debug
      KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_get_fpu
      KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_set_fpu
      KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl
      KVM: arm/arm64: Remove redundant preemptible checks
      KVM: arm/arm64: Factor out functionality to get vgic mmio requester_vcpu
      KVM: arm/arm64: Don't cache the timer IRQ level
      KVM: arm/arm64: vgic: Support level-triggered mapped interrupts
      KVM: arm/arm64: Support a vgic interrupt line level sample function
      KVM: arm/arm64: Support VGIC dist pend/active changes for mapped IRQs
      KVM: arm/arm64: Provide a get_input_level for the arch timer
      KVM: arm/arm64: Avoid work when userspace iqchips are not used
      KVM: arm/arm64: Delete outdated forwarded irq documentation
      Revert "arm64: KVM: Hide PMU from guests when disabled"
      arm64: mm: Add additional parameter to uaccess_ttbr0_enable
      arm64: mm: Add additional parameter to uaccess_ttbr0_disable
      KVM: arm/arm64: Fix incorrect timer_is_pending logic
      KVM: arm/arm64: Fix userspace_irqchip_in_use counting
      KVM: arm/arm64: Fixup userspace irqchip static key optimization

Colin Ian King (1):
      KVM: x86: MMU: make array audit_point_name static

Cornelia Huck (3):
      MAINTAINERS: add David as a reviewer for KVM/s390
      MAINTAINERS: add Halil as additional vfio-ccw maintainer
      MAINTAINERS: update KVM/s390 maintainers

David Gibson (1):
      KVM: PPC: Book3S HV: Make HPT resizing work on POWER9

David Hildenbrand (9):
      s390x/mm: cleanup gmap_pte_op_walk()
      KVM: s390: cleanup struct kvm_s390_float_interrupt
      KVM: s390: vsie: use READ_ONCE to access some SCB fields
      KVM: s390: vsie: store guest addresses of satellite blocks in vsie_page
      s390x/mm: simplify gmap_protect_rmap()
      KVM: s390: rename __set_cpuflag() to kvm_s390_set_cpuflags()
      KVM: s390: reuse kvm_s390_set_cpuflags()
      KVM: s390: introduce and use kvm_s390_clear_cpuflags()
      KVM: s390: introduce and use kvm_s390_test_cpuflags()

Eric Biggers (1):
      KVM: x86: don't forget vcpu_put() in kvm_arch_vcpu_ioctl_set_sregs()

Gimcuan Hui (1):
      x86: kvm: mmu: make kvm_mmu_clear_all_pte_masks static

Haozhong Zhang (2):
      x86/mm: add a function to check if a pfn is UC/UC-/WC
      KVM: MMU: consider host cache mode in MMIO page check

James Morse (1):
      KVM: arm/arm64: Handle CPU_PM_ENTER_FAILED

Janosch Frank (1):
      s390/mm: Remove superfluous parameter

Jens Freimann (1):
      s390/bitops: add test_and_clear_bit_inv()

Jim Mattson (4):
      KVM: nVMX: Eliminate vmcs02 pool
      kvm: vmx: Introduce VMCS12_MAX_FIELD_INDEX
      kvm: vmx: Change vmcs_field_type to vmcs_field_width
      kvm: vmx: Reduce size of vmcs_field_to_offset_table

Jose Ricardo Ziviani (1):
      KVM: PPC: Book3S: Add MMIO emulation for VMX instructions

KarimAllah Ahmed (1):
      kvm: Map PFN-type memory regions as writable (if possible)

Liran Alon (7):
      KVM: x86: Add emulation of MSR_SMI_COUNT
      KVM: nVMX: Fix bug of injecting L2 exception into L1
      KVM: x86: Optimization: Create SVM stubs for sync_pir_to_irr()
      KVM: x86: Change __kvm_apic_update_irr() to also return if max IRR updated
      KVM: nVMX: Re-evaluate L1 pending events when running L2 and L1 got posted-interrupt
      KVM: nVMX: Fix injection to L2 when L1 don't intercept external-interrupts
      KVM: nVMX: Fix races when sending nested PI while dest enters/leaves L2

Longpeng(Mike) (1):
      kvm: x86: remove efer_reload entry in kvm_vcpu_stat

Luis de Bethencourt (1):
      KVM: arm/arm64: Fix trailing semicolon

Marc Zyngier (9):
      KVM: arm/arm64: Detangle kvm_mmu.h from kvm_hyp.h
      KVM: arm/arm64: Split dcache/icache flushing
      arm64: KVM: Add invalidate_icache_range helper
      arm: KVM: Add optimized PIPT icache flushing
      arm64: KVM: PTE/PMD S2 XN bit definition
      KVM: arm/arm64: Limit icache invalidation to prefetch aborts
      KVM: arm/arm64: Only clean the dcache on translation fault
      KVM: arm/arm64: Preserve Exec permission across R/W permission faults
      KVM: arm/arm64: Drop vcpu parameter from guest cache maintenance operartions

Mark Kanda (1):
      KVM: nVMX: Add a WARN for freeing a loaded VMCS02

Markus Elfring (2):
      kvm_main: Use common error handling code in kvm_dev_ioctl_create_vm()
      KVM: PPC: Use seq_puts() in kvmppc_exit_timing_show()

Masatake YAMATO (1):
      kvm: embed vcpu id to dentry of vcpu anon inode

Michael Mueller (12):
      KVM: s390: drop use of spin lock in __floating_irq_kick
      KVM: s390: reverse bit ordering of irqs in pending mask
      KVM: s390: define GISA format-0 data structure
      KVM: s390: implement GISA IPM related primitives
      s390/css: indicate the availability of the AIV facility
      KVM: s390: exploit GISA and AIV for emulated interrupts
      KVM: s390: abstract adapter interruption word generation from ISC
      KVM: s390: add GISA interrupts to FLIC ioctl interface
      KVM: s390: make kvm_s390_get_io_int() aware of GISA
      KVM: s390: activate GISA for emulated interrupts
      s390/sclp: expose the GISA format facility
      KVM: s390: introduce the format-1 GISA

Paolo Bonzini (20):
      KVM: x86: add support for UMIP
      KVM: x86: emulate sldt and str
      KVM: x86: add support for emulating UMIP
      KVM: vmx: add support for emulating UMIP
      KVM: x86: emulate RDPID
      KVM: introduce kvm_arch_vcpu_async_ioctl
      KVM: x86: avoid unnecessary XSETBV on guest entry
      Merge branch 'sev-v9-p2' of https://github.com/codomania/kvm
      KVM: x86: prefer "depends on" to "select" for SEV
      Merge branch 'kvm-insert-lfence'
      KVM: vmx: shadow more fields that are read/written on every vmexits
      KVM: VMX: optimize shadow VMCS copying
      KVM: VMX: split list of shadowed VMCS field to a separate file
      KVM: nVMX: track dirty state of non-shadowed VMCS fields
      KVM: nVMX: initialize descriptor cache fields in prepare_vmcs02_full
      KVM: nVMX: initialize more non-shadowed fields in prepare_vmcs02_full
      KVM: nVMX: remove unnecessary vmwrite from L2->L1 vmexit
      KVM: vmx: simplify MSR bitmap setup
      KVM: vmx: speed up MSR bitmap merge
      KVM: VMX: introduce X2APIC_MSR macro

Paul Mackerras (12):
      KVM: PPC: Book3S HV: Avoid shifts by negative amounts
      KVM: PPC: Book3S HV: Fix typo in kvmppc_hv_get_dirty_log_radix()
      KVM: PPC: Book3S HV: Remove useless statement
      KVM: PPC: Book3S HV: Fix conditions for starting vcpu
      KVM: PPC: Book3S: Eliminate some unnecessary checks
      KVM: PPC: Book3S HV: Enable migration of decrementer register
      KVM: PPC: Book3S HV: Make sure we don't re-enter guest without XIVE loaded
      KVM: PPC: Book3S HV: Do SLB load/unload with guest LPCR value loaded
      KVM: PPC: Book3S HV: Allow HPT and radix on the same core for POWER9 v2.2
      Merge remote-tracking branch 'remotes/powerpc/topic/ppc-kvm' into kvm-ppc-next
      KVM: PPC: Book3S HV: Drop locks before reading guest memory
      KVM: PPC: Book3S HV: Fix handling of secondary HPTEG in HPT resizing code

Quan Xu (1):
      KVM: VMX: drop I/O permission bitmaps

Radim Krčmář (11):
      KVM: x86: prevent MWAIT in guest with buggy MONITOR
      KVM: x86: drop bogus MWAIT check
      KVM: x86: simplify kvm_mwait_in_guest()
      Merge tag 'kvm-s390-next-4.16-1' of git://git.kernel.org/.../kvms390/linux
      Merge tag 'kvm-s390-next-4.16-2' of git://git.kernel.org/.../kvms390/linux
      Merge tag 'kvm-s390-next-4.16-3' of git://git.kernel.org/.../kvms390/linux
      Merge tag 'kvm-arm-for-v4.16' of git://git.kernel.org/.../kvmarm/kvmarm
      Merge branch 'x86/hyperv' of git://git.kernel.org/.../tip/tip
      Merge tag 'kvm-ppc-next-4.16-1' of git://git.kernel.org/.../paulus/powerpc
      Merge branch 'msr-bitmaps' of git://git.kernel.org/pub/scm/virt/kvm/kvm
      Merge tag 'kvm-ppc-next-4.16-2' of git://git.kernel.org/.../paulus/powerpc

Stanislav Lanci (1):
      KVM: x86: AMD Processor Topology Information

Thomas Gleixner (1):
      x86/kvm: Make it compile on 32bit and with HYPYERVISOR_GUEST=n

Tom Lendacky (3):
      x86/CPU/AMD: Add the Secure Encrypted Virtualization CPU feature
      kvm: svm: prepare for new bit definition in nested_ctl
      kvm: svm: Add SEV feature definitions to KVM

Ulf Magnusson (1):
      KVM: PPC: Book3S PR: Fix broken select due to misspelling

Vasyl Gomonovych (1):
      KVM: arm: Use PTR_ERR_OR_ZERO()

Vitaly Kuznetsov (8):
      x86/hyperv: Check for required priviliges in hyperv_init()
      x86/hyperv: Add a function to read both TSC and TSC page value simulateneously
      x86/hyperv: Reenlightenment notifications support
      x86/hyperv: Redirect reenlightment notifications on CPU offlining
      x86/irq: Count Hyper-V reenlightenment interrupts
      x86/kvm: Pass stable clocksource to guests when running nested on Hyper-V
      x86/kvm: Support Hyper-V reenlightenment
      x86/kvm/vmx: do not use vm-exit instruction length for fast MMIO when running nested

Wanpeng Li (7):
      KVM: VMX: Cache IA32_DEBUGCTL in memory
      KVM: X86: Reduce the overhead when lapic_timer_advance is disabled
      KVM: X86: Add KVM_VCPU_PREEMPTED
      KVM: X86: use paravirtualized TLB Shootdown
      KVM: X86: introduce invalidate_gpa argument to tlb flush
      KVM: X86: support paravirtualized help for TLB shootdowns
      KVM: x86: fix escape of guest dr6 to the host

Yang Zhong (1):
      KVM: Expose new cpu features to guest

 Documentation/virtual/kvm/00-INDEX                 |    3 +
 .../virtual/kvm/amd-memory-encryption.rst          |  247 ++++
 Documentation/virtual/kvm/api.txt                  |   54 +-
 Documentation/virtual/kvm/arm/vgic-mapped-irqs.txt |  187 ---
 Documentation/virtual/kvm/cpuid.txt                |    4 +
 MAINTAINERS                                        |    5 +-
 arch/arm/include/asm/kvm_emulate.h                 |    2 +-
 arch/arm/include/asm/kvm_host.h                    |    2 +
 arch/arm/include/asm/kvm_hyp.h                     |    3 +-
 arch/arm/include/asm/kvm_mmu.h                     |   99 +-
 arch/arm/include/asm/pgtable.h                     |    4 +-
 arch/arm/kvm/hyp/switch.c                          |    1 +
 arch/arm/kvm/hyp/tlb.c                             |    1 +
 arch/arm64/include/asm/assembler.h                 |   21 +
 arch/arm64/include/asm/cacheflush.h                |    7 +
 arch/arm64/include/asm/kvm_host.h                  |    2 +
 arch/arm64/include/asm/kvm_hyp.h                   |    1 -
 arch/arm64/include/asm/kvm_mmu.h                   |   36 +-
 arch/arm64/include/asm/pgtable-hwdef.h             |    2 +
 arch/arm64/include/asm/pgtable-prot.h              |    4 +-
 arch/arm64/kvm/guest.c                             |   15 +-
 arch/arm64/kvm/hyp/debug-sr.c                      |    1 +
 arch/arm64/kvm/hyp/switch.c                        |    1 +
 arch/arm64/kvm/hyp/tlb.c                           |    1 +
 arch/arm64/mm/cache.S                              |   32 +-
 arch/mips/kvm/Kconfig                              |    1 +
 arch/mips/kvm/mips.c                               |   67 +-
 arch/powerpc/include/asm/kvm_book3s.h              |    6 +-
 arch/powerpc/include/asm/kvm_book3s_64.h           |   14 +-
 arch/powerpc/include/asm/kvm_host.h                |    8 +-
 arch/powerpc/include/asm/kvm_ppc.h                 |    4 +
 arch/powerpc/include/asm/opal-api.h                |    1 +
 arch/powerpc/include/asm/ppc-opcode.h              |    6 +
 arch/powerpc/include/asm/xive.h                    |    3 +-
 arch/powerpc/include/uapi/asm/kvm.h                |    2 +
 arch/powerpc/kernel/asm-offsets.c                  |    4 +
 arch/powerpc/kvm/Kconfig                           |    3 +-
 arch/powerpc/kvm/book3s.c                          |   24 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c                |   38 +-
 arch/powerpc/kvm/book3s_64_mmu_radix.c             |    2 +-
 arch/powerpc/kvm/book3s_hv.c                       |   70 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S            |  231 ++--
 arch/powerpc/kvm/book3s_interrupts.S               |    4 +-
 arch/powerpc/kvm/book3s_pr.c                       |   20 +-
 arch/powerpc/kvm/book3s_xive.c                     |  109 +-
 arch/powerpc/kvm/book3s_xive.h                     |   15 +-
 arch/powerpc/kvm/booke.c                           |   51 +-
 arch/powerpc/kvm/emulate_loadstore.c               |   36 +
 arch/powerpc/kvm/powerpc.c                         |  200 +++-
 arch/powerpc/kvm/timing.c                          |    3 +-
 arch/powerpc/sysdev/xive/native.c                  |   18 +-
 arch/s390/include/asm/bitops.h                     |    5 +
 arch/s390/include/asm/css_chars.h                  |    4 +-
 arch/s390/include/asm/kvm_host.h                   |  126 +-
 arch/s390/include/asm/sclp.h                       |    1 +
 arch/s390/kvm/Kconfig                              |    1 +
 arch/s390/kvm/diag.c                               |    1 +
 arch/s390/kvm/interrupt.c                          |  288 ++++-
 arch/s390/kvm/kvm-s390.c                           |  209 +++-
 arch/s390/kvm/kvm-s390.h                           |   22 +-
 arch/s390/kvm/priv.c                               |   38 +-
 arch/s390/kvm/sigp.c                               |   18 +-
 arch/s390/kvm/vsie.c                               |   91 +-
 arch/s390/mm/gmap.c                                |   44 +-
 arch/x86/entry/entry_32.S                          |    3 +
 arch/x86/entry/entry_64.S                          |    3 +
 arch/x86/hyperv/hv_init.c                          |  123 +-
 arch/x86/include/asm/cpufeatures.h                 |    1 +
 arch/x86/include/asm/hardirq.h                     |    3 +
 arch/x86/include/asm/irq_vectors.h                 |    7 +-
 arch/x86/include/asm/kvm_host.h                    |   22 +-
 arch/x86/include/asm/mshyperv.h                    |   32 +-
 arch/x86/include/asm/msr-index.h                   |    2 +
 arch/x86/include/asm/pat.h                         |    2 +
 arch/x86/include/asm/svm.h                         |    3 +
 arch/x86/include/uapi/asm/hyperv.h                 |   27 +
 arch/x86/include/uapi/asm/kvm_para.h               |    4 +
 arch/x86/kernel/cpu/amd.c                          |   66 +-
 arch/x86/kernel/cpu/mshyperv.c                     |    6 +
 arch/x86/kernel/cpu/scattered.c                    |    1 +
 arch/x86/kernel/irq.c                              |    9 +
 arch/x86/kernel/kvm.c                              |   49 +-
 arch/x86/kvm/Kconfig                               |    8 +
 arch/x86/kvm/cpuid.c                               |   22 +-
 arch/x86/kvm/emulate.c                             |   62 +-
 arch/x86/kvm/irq.c                                 |    2 +-
 arch/x86/kvm/lapic.c                               |   25 +-
 arch/x86/kvm/lapic.h                               |    4 +-
 arch/x86/kvm/mmu.c                                 |   26 +-
 arch/x86/kvm/mmu_audit.c                           |    2 +-
 arch/x86/kvm/svm.c                                 | 1199 +++++++++++++++++++-
 arch/x86/kvm/vmx.c                                 |  758 +++++++------
 arch/x86/kvm/vmx_shadow_fields.h                   |   77 ++
 arch/x86/kvm/x86.c                                 |  338 ++++--
 arch/x86/kvm/x86.h                                 |   33 +-
 arch/x86/mm/pat.c                                  |   19 +
 drivers/crypto/ccp/Kconfig                         |   12 +
 drivers/crypto/ccp/Makefile                        |    1 +
 drivers/crypto/ccp/psp-dev.c                       |  805 +++++++++++++
 drivers/crypto/ccp/psp-dev.h                       |   83 ++
 drivers/crypto/ccp/sp-dev.c                        |   35 +
 drivers/crypto/ccp/sp-dev.h                        |   28 +-
 drivers/crypto/ccp/sp-pci.c                        |   52 +
 drivers/s390/char/sclp_early.c                     |    3 +-
 include/kvm/arm_arch_timer.h                       |    2 +
 include/kvm/arm_vgic.h                             |   13 +-
 include/linux/kvm_host.h                           |   14 +-
 include/linux/psp-sev.h                            |  606 ++++++++++
 include/uapi/linux/kvm.h                           |   90 ++
 include/uapi/linux/psp-sev.h                       |  142 +++
 kernel/configs/kvm_guest.config                    |    1 +
 virt/kvm/Kconfig                                   |    3 +
 virt/kvm/arm/arch_timer.c                          |  138 ++-
 virt/kvm/arm/arm.c                                 |  153 ++-
 virt/kvm/arm/hyp/vgic-v2-sr.c                      |    1 +
 virt/kvm/arm/mmu.c                                 |   64 +-
 virt/kvm/arm/vgic/vgic-its.c                       |    4 +-
 virt/kvm/arm/vgic/vgic-mmio.c                      |  115 +-
 virt/kvm/arm/vgic/vgic-v2.c                        |   29 +
 virt/kvm/arm/vgic/vgic-v3.c                        |   29 +
 virt/kvm/arm/vgic/vgic.c                           |   41 +-
 virt/kvm/arm/vgic/vgic.h                           |    8 +
 virt/kvm/kvm_main.c                                |   62 +-
 123 files changed, 6579 insertions(+), 1416 deletions(-)

---8<---
Sample merge resolution.
---
diff --cc arch/arm64/include/asm/pgtable-prot.h
index 2db84df5eb42,4e12dabd342b..108ecad7acc5
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@@ -53,24 -47,23 +53,24 @@@
  #define PROT_SECT_NORMAL	(PROT_SECT_DEFAULT | PMD_SECT_PXN | PMD_SECT_UXN | PMD_ATTRINDX(MT_NORMAL))
  #define PROT_SECT_NORMAL_EXEC	(PROT_SECT_DEFAULT | PMD_SECT_UXN | PMD_ATTRINDX(MT_NORMAL))
  
 -#define _PAGE_DEFAULT		(PROT_DEFAULT | PTE_ATTRINDX(MT_NORMAL))
 +#define _PAGE_DEFAULT		(_PROT_DEFAULT | PTE_ATTRINDX(MT_NORMAL))
 +#define _HYP_PAGE_DEFAULT	_PAGE_DEFAULT
  
 -#define PAGE_KERNEL		__pgprot(_PAGE_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE)
 -#define PAGE_KERNEL_RO		__pgprot(_PAGE_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_RDONLY)
 -#define PAGE_KERNEL_ROX		__pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_RDONLY)
 -#define PAGE_KERNEL_EXEC	__pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_WRITE)
 -#define PAGE_KERNEL_EXEC_CONT	__pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_CONT)
 +#define PAGE_KERNEL		__pgprot(PROT_NORMAL)
 +#define PAGE_KERNEL_RO		__pgprot((PROT_NORMAL & ~PTE_WRITE) | PTE_RDONLY)
 +#define PAGE_KERNEL_ROX		__pgprot((PROT_NORMAL & ~(PTE_WRITE | PTE_PXN)) | PTE_RDONLY)
 +#define PAGE_KERNEL_EXEC	__pgprot(PROT_NORMAL & ~PTE_PXN)
 +#define PAGE_KERNEL_EXEC_CONT	__pgprot((PROT_NORMAL & ~PTE_PXN) | PTE_CONT)
  
 -#define PAGE_HYP		__pgprot(_PAGE_DEFAULT | PTE_HYP | PTE_HYP_XN)
 -#define PAGE_HYP_EXEC		__pgprot(_PAGE_DEFAULT | PTE_HYP | PTE_RDONLY)
 -#define PAGE_HYP_RO		__pgprot(_PAGE_DEFAULT | PTE_HYP | PTE_RDONLY | PTE_HYP_XN)
 +#define PAGE_HYP		__pgprot(_HYP_PAGE_DEFAULT | PTE_HYP | PTE_HYP_XN)
 +#define PAGE_HYP_EXEC		__pgprot(_HYP_PAGE_DEFAULT | PTE_HYP | PTE_RDONLY)
 +#define PAGE_HYP_RO		__pgprot(_HYP_PAGE_DEFAULT | PTE_HYP | PTE_RDONLY | PTE_HYP_XN)
  #define PAGE_HYP_DEVICE		__pgprot(PROT_DEVICE_nGnRE | PTE_HYP)
  
- #define PAGE_S2			__pgprot(_PROT_DEFAULT | PTE_S2_MEMATTR(MT_S2_NORMAL) | PTE_S2_RDONLY)
- #define PAGE_S2_DEVICE		__pgprot(_PROT_DEFAULT | PTE_S2_MEMATTR(MT_S2_DEVICE_nGnRE) | PTE_S2_RDONLY | PTE_UXN)
 -#define PAGE_S2			__pgprot(PROT_DEFAULT | PTE_S2_MEMATTR(MT_S2_NORMAL) | PTE_S2_RDONLY | PTE_S2_XN)
 -#define PAGE_S2_DEVICE		__pgprot(PROT_DEFAULT | PTE_S2_MEMATTR(MT_S2_DEVICE_nGnRE) | PTE_S2_RDONLY | PTE_S2_XN)
++#define PAGE_S2			__pgprot(_PROT_DEFAULT | PTE_S2_MEMATTR(MT_S2_NORMAL) | PTE_S2_RDONLY | PTE_S2_XN)
++#define PAGE_S2_DEVICE		__pgprot(_PROT_DEFAULT | PTE_S2_MEMATTR(MT_S2_DEVICE_nGnRE) | PTE_S2_RDONLY | PTE_S2_XN)
  
 -#define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_PROT_NONE | PTE_RDONLY | PTE_PXN | PTE_UXN)
 +#define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_PROT_NONE | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)
  #define PAGE_SHARED		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_UXN | PTE_WRITE)
  #define PAGE_SHARED_EXEC	__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_WRITE)
  #define PAGE_READONLY		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)
diff --cc arch/x86/include/asm/mshyperv.h
index b52af150cbd8,1790002a2052..25283f7eb299
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@@ -314,13 -315,21 +315,21 @@@ void hyperv_init(void)
  void hyperv_setup_mmu_ops(void);
  void hyper_alloc_mmu(void);
  void hyperv_report_panic(struct pt_regs *regs, long err);
 -bool hv_is_hypercall_page_setup(void);
 +bool hv_is_hyperv_initialized(void);
  void hyperv_cleanup(void);
+ 
+ void hyperv_reenlightenment_intr(struct pt_regs *regs);
+ void set_hv_tscchange_cb(void (*cb)(void));
+ void clear_hv_tscchange_cb(void);
+ void hyperv_stop_tsc_emulation(void);
  #else /* CONFIG_HYPERV */
  static inline void hyperv_init(void) {}
 -static inline bool hv_is_hypercall_page_setup(void) { return false; }
 +static inline bool hv_is_hyperv_initialized(void) { return false; }
  static inline void hyperv_cleanup(void) {}
  static inline void hyperv_setup_mmu_ops(void) {}
+ static inline void set_hv_tscchange_cb(void (*cb)(void)) {}
+ static inline void clear_hv_tscchange_cb(void) {}
+ static inline void hyperv_stop_tsc_emulation(void) {};
  #endif /* CONFIG_HYPERV */
  
  #ifdef CONFIG_HYPERV_TSCPAGE
diff --cc arch/x86/kvm/cpuid.c
index 13f5d4217e4f,20e491b94f44..a0c5a69bc7c4
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@@ -363,12 -371,9 +369,13 @@@ static inline int __do_cpuid_ent(struc
  		F(LAHF_LM) | F(CMP_LEGACY) | 0 /*SVM*/ | 0 /* ExtApicSpace */ |
  		F(CR8_LEGACY) | F(ABM) | F(SSE4A) | F(MISALIGNSSE) |
  		F(3DNOWPREFETCH) | F(OSVW) | 0 /* IBS */ | F(XOP) |
- 		0 /* SKINIT, WDT, LWP */ | F(FMA4) | F(TBM);
+ 		0 /* SKINIT, WDT, LWP */ | F(FMA4) | F(TBM) |
+ 		F(TOPOEXT);
  
 +	/* cpuid 0x80000008.ebx */
 +	const u32 kvm_cpuid_8000_0008_ebx_x86_features =
 +		F(IBPB) | F(IBRS);
 +
  	/* cpuid 0xC0000001.edx */
  	const u32 kvm_cpuid_C000_0001_edx_x86_features =
  		F(XSTORE) | F(XSTORE_EN) | F(XCRYPT) | F(XCRYPT_EN) |
diff --cc arch/x86/kvm/svm.c
index 4e3c79530526,1bf20e9160bd..b3e488a74828
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@@ -533,7 -573,9 +577,10 @@@ struct svm_cpu_data 
  	struct kvm_ldttss_desc *tss_desc;
  
  	struct page *save_area;
 +	struct vmcb *current_vmcb;
+ 
+ 	/* index = sev_asid, value = vmcb pointer */
+ 	struct vmcb **sev_vmcbs;
  };
  
  static DEFINE_PER_CPU(struct svm_cpu_data *, svm_data);
diff --cc arch/x86/kvm/vmx.c
index bee4c49f6dd0,9973a301364e..9d95957be4e8
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@@ -903,18 -864,25 +869,23 @@@ static const unsigned short vmcs_field_
  
  static inline short vmcs_field_to_offset(unsigned long field)
  {
 +	const size_t size = ARRAY_SIZE(vmcs_field_to_offset_table);
 +	unsigned short offset;
+ 	unsigned index;
  
- 	BUILD_BUG_ON(size > SHRT_MAX);
- 	if (field >= size)
+ 	if (field >> 15)
  		return -ENOENT;
  
- 	field = array_index_nospec(field, size);
- 	offset = vmcs_field_to_offset_table[field];
+ 	index = ROL16(field, 6);
 -	if (index >= ARRAY_SIZE(vmcs_field_to_offset_table))
++	if (index >= size)
+ 		return -ENOENT;
+ 
 -	/*
 -	 * FIXME: Mitigation for CVE-2017-5753.  To be replaced with a
 -	 * generic mechanism.
 -	 */
 -	asm("lfence");
 -
 -	if (vmcs_field_to_offset_table[index] == 0)
++	index = array_index_nospec(index, size);
++	offset = vmcs_field_to_offset_table[index];
 +	if (offset == 0)
  		return -ENOENT;
+ 
 -	return vmcs_field_to_offset_table[index];
 +	return offset;
  }
  
  static inline struct vmcs12 *get_vmcs12(struct kvm_vcpu *vcpu)
@@@ -10206,69 -10049,55 +10212,84 @@@ static inline bool nested_vmx_prepare_m
  	struct page *page;
  	unsigned long *msr_bitmap_l1;
  	unsigned long *msr_bitmap_l0 = to_vmx(vcpu)->nested.vmcs02.msr_bitmap;
 +	/*
 +	 * pred_cmd & spec_ctrl are trying to verify two things:
 +	 *
 +	 * 1. L0 gave a permission to L1 to actually passthrough the MSR. This
 +	 *    ensures that we do not accidentally generate an L02 MSR bitmap
 +	 *    from the L12 MSR bitmap that is too permissive.
 +	 * 2. That L1 or L2s have actually used the MSR. This avoids
 +	 *    unnecessarily merging of the bitmap if the MSR is unused. This
 +	 *    works properly because we only update the L01 MSR bitmap lazily.
 +	 *    So even if L0 should pass L1 these MSRs, the L01 bitmap is only
 +	 *    updated to reflect this when L1 (or its L2s) actually write to
 +	 *    the MSR.
 +	 */
 +	bool pred_cmd = msr_write_intercepted_l01(vcpu, MSR_IA32_PRED_CMD);
 +	bool spec_ctrl = msr_write_intercepted_l01(vcpu, MSR_IA32_SPEC_CTRL);
  
+ 	/* Nothing to do if the MSR bitmap is not in use.  */
+ 	if (!cpu_has_vmx_msr_bitmap() ||
+ 	    !nested_cpu_has(vmcs12, CPU_BASED_USE_MSR_BITMAPS))
+ 		return false;
+ 
+ 	/* This shortcut is ok because we support only x2APIC MSRs so far. */
 -	if (!nested_cpu_has_virt_x2apic_mode(vmcs12))
 +	if (!nested_cpu_has_virt_x2apic_mode(vmcs12) &&
 +	    !pred_cmd && !spec_ctrl)
  		return false;
  
  	page = kvm_vcpu_gpa_to_page(vcpu, vmcs12->msr_bitmap);
  	if (is_error_page(page))
  		return false;
+ 
  	msr_bitmap_l1 = (unsigned long *)kmap(page);
- 
- 	memset(msr_bitmap_l0, 0xff, PAGE_SIZE);
- 
- 	if (nested_cpu_has_virt_x2apic_mode(vmcs12)) {
- 		if (nested_cpu_has_apic_reg_virt(vmcs12))
- 			for (msr = 0x800; msr <= 0x8ff; msr++)
- 				nested_vmx_disable_intercept_for_msr(
- 					msr_bitmap_l1, msr_bitmap_l0,
- 					msr, MSR_TYPE_R);
- 
- 		nested_vmx_disable_intercept_for_msr(
- 				msr_bitmap_l1, msr_bitmap_l0,
- 				APIC_BASE_MSR + (APIC_TASKPRI >> 4),
- 				MSR_TYPE_R | MSR_TYPE_W);
- 
- 		if (nested_cpu_has_vid(vmcs12)) {
- 			nested_vmx_disable_intercept_for_msr(
- 				msr_bitmap_l1, msr_bitmap_l0,
- 				APIC_BASE_MSR + (APIC_EOI >> 4),
- 				MSR_TYPE_W);
- 			nested_vmx_disable_intercept_for_msr(
- 				msr_bitmap_l1, msr_bitmap_l0,
- 				APIC_BASE_MSR + (APIC_SELF_IPI >> 4),
- 				MSR_TYPE_W);
+ 	if (nested_cpu_has_apic_reg_virt(vmcs12)) {
+ 		/*
+ 		 * L0 need not intercept reads for MSRs between 0x800 and 0x8ff, it
+ 		 * just lets the processor take the value from the virtual-APIC page;
+ 		 * take those 256 bits directly from the L1 bitmap.
+ 		 */
+ 		for (msr = 0x800; msr <= 0x8ff; msr += BITS_PER_LONG) {
+ 			unsigned word = msr / BITS_PER_LONG;
+ 			msr_bitmap_l0[word] = msr_bitmap_l1[word];
+ 			msr_bitmap_l0[word + (0x800 / sizeof(long))] = ~0;
  		}
+ 	} else {
+ 		for (msr = 0x800; msr <= 0x8ff; msr += BITS_PER_LONG) {
+ 			unsigned word = msr / BITS_PER_LONG;
+ 			msr_bitmap_l0[word] = ~0;
+ 			msr_bitmap_l0[word + (0x800 / sizeof(long))] = ~0;
+ 		}
+ 	}
+ 
+ 	nested_vmx_disable_intercept_for_msr(
+ 		msr_bitmap_l1, msr_bitmap_l0,
+ 		X2APIC_MSR(APIC_TASKPRI),
+ 		MSR_TYPE_W);
+ 
+ 	if (nested_cpu_has_vid(vmcs12)) {
+ 		nested_vmx_disable_intercept_for_msr(
+ 			msr_bitmap_l1, msr_bitmap_l0,
+ 			X2APIC_MSR(APIC_EOI),
+ 			MSR_TYPE_W);
+ 		nested_vmx_disable_intercept_for_msr(
+ 			msr_bitmap_l1, msr_bitmap_l0,
+ 			X2APIC_MSR(APIC_SELF_IPI),
+ 			MSR_TYPE_W);
  	}
 +
 +	if (spec_ctrl)
 +		nested_vmx_disable_intercept_for_msr(
 +					msr_bitmap_l1, msr_bitmap_l0,
 +					MSR_IA32_SPEC_CTRL,
 +					MSR_TYPE_R | MSR_TYPE_W);
 +
 +	if (pred_cmd)
 +		nested_vmx_disable_intercept_for_msr(
 +					msr_bitmap_l1, msr_bitmap_l0,
 +					MSR_IA32_PRED_CMD,
 +					MSR_TYPE_W);
 +
  	kunmap(page);
  	kvm_release_page_clean(page);
  
