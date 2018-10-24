Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E01C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23FFE20824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23FFE20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeJXTl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:41:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41148 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbeJXTl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:41:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 48B2A30B932B;
        Wed, 24 Oct 2018 11:14:15 +0000 (UTC)
Received: from potion (ovpn-204-156.brq.redhat.com [10.40.204.156])
        by smtp.corp.redhat.com (Postfix) with SMTP id B27545C888;
        Wed, 24 Oct 2018 11:14:12 +0000 (UTC)
Received: by potion (sSMTP sendmail emulation); Wed, 24 Oct 2018 13:14:11 +0200
Date:   Wed, 24 Oct 2018 13:14:11 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: [GIT PULL] KVM updates for Linux 4.20-rc1
Message-ID: <20181024111410.GA2221@potion.hotspot.internet-for-guests.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 24 Oct 2018 11:14:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

there are conflicts with the ARM tree as we didn't have a topic branch and some
with 4.19 fixes.  Future merge of the selftests tree will also have a conflict,
https://lkml.org/lkml/2018/10/18/273.  All should be resolved as in next and
a resolution of the first two is attached at the bottom.

The following changes since commit 7e7126846c95a34f98a1524d5c473af1f0783735:

  kvm: nVMX: fix entry with pending interrupt if APICv is enabled (2018-10-04 17:10:40 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/kvm tags/kvm-4.20-1

for you to fetch changes up to 22a7cdcae6a4a3c8974899e62851d270956f58ce:

  KVM/nVMX: Do not validate that posted_intr_desc_addr is page aligned (2018-10-24 12:47:16 +0200)

----------------------------------------------------------------
KVM updates for v4.20

ARM:
 - Improved guest IPA space support (32 to 52 bits)

 - RAS event delivery for 32bit

 - PMU fixes

 - Guest entry hardening

 - Various cleanups

 - Port of dirty_log_test selftest

PPC:
 - Nested HV KVM support for radix guests on POWER9.  The performance is
   much better than with PR KVM.  Migration and arbitrary level of
   nesting is supported.

 - Disable nested HV-KVM on early POWER9 chips that need a particular hardware
   bug workaround

 - One VM per core mode to prevent potential data leaks

 - PCI pass-through optimization

 - merge ppc-kvm topic branch and kvm-ppc-fixes to get a better base

s390:
 - Initial version of AP crypto virtualization via vfio-mdev

 - Improvement for vfio-ap

 - Set the host program identifier

 - Optimize page table locking

x86:
 - Enable nested virtualization by default

 - Implement Hyper-V IPI hypercalls

 - Improve #PF and #DB handling

 - Allow guests to use Enlightened VMCS

 - Add migration selftests for VMCS and Enlightened VMCS

 - Allow coalesced PIO accesses

 - Add an option to perform nested VMCS host state consistency check
   through hardware

 - Automatic tuning of lapic_timer_advance_ns

 - Many fixes, minor improvements, and cleanups

----------------------------------------------------------------
Alexey Kardashevskiy (6):
      KVM: PPC: Validate all tces before updating tables
      KVM: PPC: Inform the userspace about TCE update failures
      KVM: PPC: Validate TCEs against preregistered memory page sizes
      KVM: PPC: Propagate errors to the guest when failed instead of ignoring
      KVM: PPC: Remove redundand permission bits removal
      KVM: PPC: Optimize clearing TCEs for sparse tables

Anders Roxell (1):
      selftests/kvm: add missing executables to .gitignore

Andrew Jones (13):
      kvm: selftests: vcpu_setup: set cr4.osfxsr
      kvm: selftests: introduce ucall
      kvm: selftests: move arch-specific files to arch-specific locations
      kvm: selftests: add cscope make target
      kvm: selftests: tidy up kvm_util
      kvm: selftests: add vm_phy_pages_alloc
      kvm: selftests: add virt mem support for aarch64
      kvm: selftests: add vcpu support for aarch64
      kvm: selftests: introduce new VM mode for 64K pages
      kvm: selftests: port dirty_log_test to aarch64
      kvm: selftests: dirty_log_test: also test 64K pages on aarch64
      kvm: selftests: stop lying to aarch64 tests about PA-bits
      kvm: selftests: support high GPAs in dirty_log_test

Cameron Kaiser (1):
      KVM: PPC: Book3S PR: Exiting split hack mode needs to fixup both PC and LR

Christian Borntraeger (4):
      Merge branch 'apv11' of git://git.kernel.org/.../kvms390/linux into kernelorgnext
      KVM: s390: fix locking for crypto setting error path
      s390: vfio-ap: make local functions and data static
      Merge branch 'apv11' of git://git.kernel.org/.../kvms390/linux into kernelorgnext

Christoffer Dall (1):
      KVM: arm64: Safety check PSTATE when entering guest and handle IL

Collin Walling (1):
      KVM: s390: set host program identifier

David Hildenbrand (3):
      KVM: s390: vsie: simulate VCPU SIE entry/exit
      KVM: s390: introduce and use KVM_REQ_VSIE_RESTART
      s390/mm: optimize locking without huge pages in gmap_pmd_op_walk()

Dongjiu Geng (2):
      arm/arm64: KVM: Rename function kvm_arch_dev_ioctl_check_extension()
      arm/arm64: KVM: Enable 32 bits kvm vcpu events support

Jim Mattson (9):
      KVM: nVMX: Clear reserved bits of #DB exit qualification
      KVM: nVMX: Always reflect #NM VM-exits to L1
      KVM: Documentation: Fix omission in struct kvm_vcpu_events
      kvm: x86: Add has_payload and payload to kvm_queued_exception
      kvm: x86: Add exception payload fields to kvm_vcpu_events
      kvm: x86: Add payload operands to kvm_multiple_exception
      kvm: x86: Defer setting of CR2 until #PF delivery
      kvm: vmx: Defer setting of DR6 until #DB delivery
      kvm: x86: Introduce KVM_CAP_EXCEPTION_PAYLOAD

KarimAllah Ahmed (1):
      KVM/nVMX: Do not validate that posted_intr_desc_addr is page aligned

Krish Sadhukhan (1):
      nVMX x86: Make nested_vmx_check_pml_controls() concise

Kristina Martsenko (1):
      vgic: Add support for 52bit guest physical address

Ladi Prosek (1):
      KVM: hyperv: define VP assist page helpers

Lan Tianyu (1):
      KVM/VMX: Change hv flush logic when ept tables are mismatched.

Liran Alon (4):
      KVM: nVMX: Flush TLB entries tagged by dest EPTP on L1<->L2 transitions
      KVM: nVMX: Use correct VPID02 when emulating L1 INVVPID
      KVM: nVMX: Flush linear and combined mappings on VPID02 related flushes
      KVM: nVMX: Do not flush TLB on L1<->L2 transitions if L1 uses VPID and EPT

Marc Zyngier (2):
      KVM: arm/arm64: Rename kvm_arm_config_vm to kvm_arm_setup_stage2
      KVM: arm64: Drop __cpu_init_stage2 on the VHE path

Mark Rutland (1):
      KVM: arm64: Fix caching of host MDCR_EL2 value

Michael Ellerman (1):
      Merge branch 'kvm-ppc-fixes' of paulus/powerpc into topic/ppc-kvm

Paolo Bonzini (9):
      Merge tag 'kvm-s390-next-4.20-1' of git://git.kernel.org/.../kvms390/linux into HEAD
      Merge tag 'kvm-ppc-next-4.20-1' of git://git.kernel.org/.../paulus/powerpc into HEAD
      Merge tag 'kvm-s390-next-4.20-2' of git://git.kernel.org/.../kvms390/linux into HEAD
      kvm/x86: return meaningful value from KVM_SIGNAL_MSI
      kvm: x86: optimize dr6 restore
      x86/kvm/mmu: get rid of redundant kvm_mmu_setup()
      KVM: VMX: enable nested virtualization by default
      Merge tag 'kvmarm-for-v4.20' of git://git.kernel.org/.../kvmarm/kvmarm into HEAD
      Merge tag 'kvm-ppc-next-4.20-2' of git://git.kernel.org/.../paulus/powerpc into HEAD

Paul Mackerras (27):
      KVM: PPC: Book3S HV: Provide mode where all vCPUs on a core must be the same VM
      powerpc: Turn off CPU_FTR_P9_TM_HV_ASSIST in non-hypervisor mode
      KVM: PPC: Book3S: Simplify external interrupt handling
      KVM: PPC: Book3S HV: Remove left-over code in XICS-on-XIVE emulation
      KVM: PPC: Book3S HV: Move interrupt delivery on guest entry to C code
      KVM: PPC: Book3S HV: Extract PMU save/restore operations as C-callable functions
      KVM: PPC: Book3S HV: Simplify real-mode interrupt handling
      KVM: PPC: Book3S: Rework TM save/restore code and make it C-callable
      KVM: PPC: Book3S HV: Call kvmppc_handle_exit_hv() with vcore unlocked
      KVM: PPC: Book3S HV: Streamlined guest entry/exit path on P9 for radix guests
      KVM: PPC: Book3S HV: Handle hypervisor instruction faults better
      KVM: PPC: Book3S HV: Add a debugfs file to dump radix mappings
      KVM: PPC: Use ccr field in pt_regs struct embedded in vcpu struct
      KVM: PPC: Book3S HV: Use kvmppc_unmap_pte() in kvm_unmap_radix()
      KVM: PPC: Book3S HV: Framework and hcall stubs for nested virtualization
      KVM: PPC: Book3S HV: Nested guest entry via hypercall
      KVM: PPC: Book3S HV: Use XICS hypercalls when running as a nested hypervisor
      KVM: PPC: Book3S HV: Handle hypercalls correctly when nested
      KVM: PPC: Book3S HV: Use hypercalls for TLB invalidation when nested
      KVM: PPC: Book3S HV: Don't access HFSCR, LPIDR or LPCR when running nested
      KVM: PPC: Book3S HV: Add one-reg interface to virtual PTCR register
      KVM: PPC: Book3S HV: Allow HV module to load without hypervisor mode
      KVM: PPC: Book3S HV: Add nested shadow page tables to debugfs
      Merge remote-tracking branch 'remotes/powerpc/topic/ppc-kvm' into kvm-ppc-next
      KVM: PPC: Book3S HV: Add a VM capability to enable nested virtualization
      KVM: PPC: Book3S HV: Add NO_HASH flag to GET_SMMU_INFO ioctl result
      KVM: PPC: Book3S HV: Don't use streamlined entry path on early POWER9 chips

Peng Hao (3):
      kvm/x86 : fix some typo
      kvm/x86 : add document for coalesced mmio
      kvm/x86 : add coalesced pio support

Pierre Morel (11):
      KVM: s390: Clear Crypto Control Block when using vSIE
      KVM: s390: vsie: Do the CRYCB validation first
      KVM: s390: vsie: Make use of CRYCB FORMAT2 clear
      KVM: s390: vsie: Allow CRYCB FORMAT-2
      KVM: s390: vsie: allow CRYCB FORMAT-1
      KVM: s390: vsie: allow CRYCB FORMAT-0
      KVM: s390: vsie: allow guest FORMAT-0 CRYCB on host FORMAT-1
      KVM: s390: vsie: allow guest FORMAT-1 CRYCB on host FORMAT-2
      KVM: s390: vsie: allow guest FORMAT-0 CRYCB on host FORMAT-2
      KVM: s390: Tracing APCB changes
      s390: vfio-ap: setup APCB mask using KVM dedicated function

Punit Agrawal (1):
      KVM: arm/arm64: Ensure only THP is candidate for adjustment

Radim Krčmář (1):
      Revert "kvm: x86: optimize dr6 restore"

Sean Christopherson (22):
      KVM: vmx: rename KVM_GUEST_CR0_MASK tp KVM_VM_CR0_ALWAYS_OFF
      KVM: nVMX: restore host state in nested_vmx_vmexit for VMFail
      KVM: nVMX: move host EFER consistency checks to VMFail path
      KVM: nVMX: move vmcs12 EPTP consistency check to check_vmentry_prereqs()
      KVM: nVMX: use vm_exit_controls_init() to write exit controls for vmcs02
      KVM: nVMX: reset cache/shadows when switching loaded VMCS
      KVM: vmx: do not unconditionally clear EFER switching
      KVM: nVMX: try to set EFER bits correctly when initializing controls
      KVM: nVMX: rename enter_vmx_non_root_mode to nested_vmx_enter_non_root_mode
      KVM: nVMX: move check_vmentry_postreqs() call to nested_vmx_enter_non_root_mode()
      KVM: nVMX: assimilate nested_vmx_entry_failure() into nested_vmx_enter_non_root_mode()
      KVM: vVMX: rename label for post-enter_guest_mode consistency check
      KVM: VMX: remove ASSERT() on vmx->pml_pg validity
      KVM: nVMX: split pieces of prepare_vmcs02() to prepare_vmcs02_early()
      KVM: nVMX: initialize vmcs02 constant exactly once (per VMCS)
      KVM: nVMX: do early preparation of vmcs02 before check_vmentry_postreqs()
      KVM: nVMX: do not skip VMEnter instruction that succeeds
      KVM: nVMX: do not call nested_vmx_succeed() for consistency check VMExit
      KVM: nVMX: call kvm_skip_emulated_instruction in nested_vmx_{fail,succeed}
      KVM: vmx: write HOST_IA32_EFER in vmx_set_constant_host_state()
      KVM: nVMX: add option to perform early consistency checks via H/W
      KVM: nVMX: WARN if nested run hits VMFail with early consistency checks enabled

Suraj Jitindar Singh (9):
      KVM: PPC: Book3S HV: Clear partition table entry on vm teardown
      KVM: PPC: Book3S HV: Make kvmppc_mmu_radix_xlate process/partition table agnostic
      KVM: PPC: Book3S HV: Refactor radix page fault handler
      KVM: PPC: Book3S HV: Handle page fault for a nested guest
      KVM: PPC: Book3S HV: Introduce rmap to track nested guest mappings
      KVM: PPC: Book3S HV: Implement H_TLB_INVALIDATE hcall
      KVM: PPC: Book3S HV: Invalidate TLB when nested vcpu moves physical cpu
      KVM: PPC: Book3S HV: Sanitise hv_regs on nested guest entry
      KVM: PPC: Book3S HV: Handle differing endianness for H_ENTER_NESTED

Suzuki K Poulose (17):
      kvm: arm/arm64: Fix stage2_flush_memslot for 4 level page table
      kvm: arm/arm64: Remove spurious WARN_ON
      kvm: arm64: Add helper for loading the stage2 setting for a VM
      arm64: Add a helper for PARange to physical shift conversion
      kvm: arm64: Clean up VTCR_EL2 initialisation
      kvm: arm/arm64: Allow arch specific configurations for VM
      kvm: arm64: Configure VTCR_EL2 per VM
      kvm: arm/arm64: Prepare for VM specific stage2 translations
      kvm: arm64: Prepare for dynamic stage2 page table layout
      kvm: arm64: Make stage2 page table layout dynamic
      kvm: arm64: Dynamic configuration of VTTBR mask
      kvm: arm64: Configure VTCR_EL2.SL0 per VM
      kvm: arm64: Switch to per VM IPA limit
      kvm: arm64: Add 52bit support for PAR to HPFAR conversoin
      kvm: arm64: Set a limit on the IPA size
      kvm: arm64: Limit the minimum number of page table levels
      kvm: arm64: Allow tuning the physical address size for VM

Tianyu Lan (1):
      KVM/VMX: Remve unused function is_external_interrupt().

Tony Krowiak (15):
      KVM: s390: refactor crypto initialization
      s390: vfio-ap: base implementation of VFIO AP device driver
      s390: vfio-ap: register matrix device with VFIO mdev framework
      s390: vfio-ap: sysfs interfaces to configure adapters
      s390: vfio-ap: sysfs interfaces to configure domains
      s390: vfio-ap: sysfs interfaces to configure control domains
      s390: vfio-ap: sysfs interface to view matrix mdev matrix
      KVM: s390: interface to clear CRYCB masks
      s390: vfio-ap: implement mediated device open callback
      s390: vfio-ap: implement VFIO_DEVICE_GET_INFO ioctl
      s390: vfio-ap: zeroize the AP queues
      s390: vfio-ap: implement VFIO_DEVICE_RESET ioctl
      KVM: s390: device attrs to enable/disable AP interpretation
      KVM: s390: CPU model support for AP virtualization
      s390: doc: detailed specifications for AP virtualization

Uros Bizjak (4):
      KVM/x86: Fix invvpid and invept register operand size in 64-bit mode
      KVM/x86: Use assembly instruction mnemonics instead of .byte streams
      KVM/x86: Use 32bit xor to clear register
      KVM/x86: Use 32bit xor to clear registers in svm.c

Vitaly Kuznetsov (30):
      KVM: x86: hyperv: enforce vp_index < KVM_MAX_VCPUS
      KVM: x86: hyperv: optimize 'all cpus' case in kvm_hv_flush_tlb()
      KVM: x86: hyperv: consistently use 'hv_vcpu' for 'struct kvm_vcpu_hv' variables
      KVM: x86: hyperv: keep track of mismatched VP indexes
      KVM: x86: hyperv: valid_bank_mask should be 'u64'
      KVM: x86: hyperv: optimize kvm_hv_flush_tlb() for vp_index == vcpu_idx case
      KVM: x86: hyperv: implement PV IPI send hypercalls
      KVM: x86: hyperv: fix 'tlb_lush' typo
      KVM: x86: hyperv: optimize sparse VP set processing
      x86/kvm/mmu: make vcpu->mmu a pointer to the current MMU
      x86/kvm/mmu.c: set get_pdptr hook in kvm_init_shadow_ept_mmu()
      x86/kvm/mmu.c: add kvm_mmu parameter to kvm_mmu_free_roots()
      x86/kvm/mmu: introduce guest_mmu
      x86/kvm/mmu: make space for source data caching in struct kvm_mmu
      x86/kvm/nVMX: introduce source data cache for kvm_init_shadow_ept_mmu()
      x86/kvm/mmu: check if tdp/shadow MMU reconfiguration is needed
      x86/kvm/mmu: check if MMU reconfiguration is needed in init_kvm_nested_mmu()
      KVM: VMX: refactor evmcs_sanitize_exec_ctrls()
      KVM: nVMX: add KVM_CAP_HYPERV_ENLIGHTENED_VMCS capability
      KVM: nVMX: add enlightened VMCS state
      KVM: nVMX: implement enlightened VMPTRLD and VMCLEAR
      KVM: nVMX: optimize prepare_vmcs02{,_full} for Enlightened VMCS case
      x86/kvm/hyperv: don't clear VP assist pages on init
      x86/kvm/lapic: preserve gfn_to_hva_cache len on cache reinit
      x86/kvm/nVMX: allow bare VMXON state migration
      KVM: selftests: state_test: test bare VMXON migration
      x86/kvm/nVMX: nested state migration for Enlightened VMCS
      tools/headers: update kvm.h
      KVM: selftests: add Enlightened VMCS test
      x86/kvm/nVMX: tweak shadow fields

Wanpeng Li (1):
      KVM: LAPIC: Tune lapic_timer_advance_ns automatically

Wei Yang (7):
      KVM: x86: adjust kvm_mmu_page member to save 8 bytes
      KVM: x86: return 0 in case kvm_mmu_memory_cache has min number of objects
      KVM: x86: move definition PT_MAX_HUGEPAGE_LEVEL and KVM_NR_PAGE_SIZES together
      KVM: leverage change to adjust slots->used_slots in update_memslots()
      KVM: x86: rename pte_list_remove to __pte_list_remove
      KVM: x86: reintroduce pte_list_remove, but including mmu_spte_clear_track_bits
      KVM: refine the comment of function gfn_to_hva_memslot_prot()

zhong jiang (1):
      arm64: KVM: Remove some extra semicolon in kvm_target_cpu

 Documentation/s390/vfio-ap.txt                     |  837 +++++++
 Documentation/virtual/kvm/api.txt                  |  135 +-
 MAINTAINERS                                        |   12 +
 arch/arm/include/asm/kvm_arm.h                     |    3 +-
 arch/arm/include/asm/kvm_host.h                    |   13 +-
 arch/arm/include/asm/kvm_mmu.h                     |   15 +-
 arch/arm/include/asm/stage2_pgtable.h              |   50 +-
 arch/arm64/include/asm/cpufeature.h                |   21 +
 arch/arm64/include/asm/kvm_arm.h                   |  157 +-
 arch/arm64/include/asm/kvm_asm.h                   |    3 +-
 arch/arm64/include/asm/kvm_host.h                  |   18 +-
 arch/arm64/include/asm/kvm_hyp.h                   |   10 +
 arch/arm64/include/asm/kvm_mmu.h                   |   42 +-
 arch/arm64/include/asm/ptrace.h                    |    3 +
 arch/arm64/include/asm/stage2_pgtable-nopmd.h      |   42 -
 arch/arm64/include/asm/stage2_pgtable-nopud.h      |   39 -
 arch/arm64/include/asm/stage2_pgtable.h            |  258 ++-
 arch/arm64/kvm/guest.c                             |    6 +-
 arch/arm64/kvm/handle_exit.c                       |    7 +
 arch/arm64/kvm/hyp/Makefile                        |    1 -
 arch/arm64/kvm/hyp/hyp-entry.S                     |   16 +-
 arch/arm64/kvm/hyp/s2-setup.c                      |   90 -
 arch/arm64/kvm/hyp/switch.c                        |    4 +-
 arch/arm64/kvm/hyp/sysreg-sr.c                     |   19 +-
 arch/arm64/kvm/hyp/tlb.c                           |    4 +-
 arch/arm64/kvm/reset.c                             |  108 +-
 arch/powerpc/include/asm/asm-prototypes.h          |   21 +
 arch/powerpc/include/asm/book3s/64/mmu-hash.h      |   12 +
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |    1 +
 arch/powerpc/include/asm/hvcall.h                  |   41 +
 arch/powerpc/include/asm/iommu.h                   |    2 +-
 arch/powerpc/include/asm/kvm_asm.h                 |    4 +-
 arch/powerpc/include/asm/kvm_book3s.h              |   45 +-
 arch/powerpc/include/asm/kvm_book3s_64.h           |  118 +-
 arch/powerpc/include/asm/kvm_book3s_asm.h          |    3 +
 arch/powerpc/include/asm/kvm_booke.h               |    4 +-
 arch/powerpc/include/asm/kvm_host.h                |   16 +-
 arch/powerpc/include/asm/kvm_ppc.h                 |    8 +-
 arch/powerpc/include/asm/ppc-opcode.h              |    1 +
 arch/powerpc/include/asm/reg.h                     |    2 +
 arch/powerpc/include/uapi/asm/kvm.h                |    1 +
 arch/powerpc/kernel/asm-offsets.c                  |    5 +-
 arch/powerpc/kernel/cpu_setup_power.S              |    4 +-
 arch/powerpc/kvm/Makefile                          |    3 +-
 arch/powerpc/kvm/book3s.c                          |   46 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c                |    7 +-
 arch/powerpc/kvm/book3s_64_mmu_radix.c             |  770 +++++--
 arch/powerpc/kvm/book3s_64_vio.c                   |   94 +-
 arch/powerpc/kvm/book3s_64_vio_hv.c                |   87 +-
 arch/powerpc/kvm/book3s_emulate.c                  |   13 +-
 arch/powerpc/kvm/book3s_hv.c                       |  873 +++++++-
 arch/powerpc/kvm/book3s_hv_builtin.c               |   92 +-
 arch/powerpc/kvm/book3s_hv_interrupts.S            |   95 +-
 arch/powerpc/kvm/book3s_hv_nested.c                | 1291 +++++++++++
 arch/powerpc/kvm/book3s_hv_ras.c                   |   10 +
 arch/powerpc/kvm/book3s_hv_rm_xics.c               |   13 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S            |  811 ++++---
 arch/powerpc/kvm/book3s_hv_tm.c                    |    6 +-
 arch/powerpc/kvm/book3s_hv_tm_builtin.c            |    5 +-
 arch/powerpc/kvm/book3s_pr.c                       |    5 +-
 arch/powerpc/kvm/book3s_xics.c                     |   14 +-
 arch/powerpc/kvm/book3s_xive.c                     |   63 +
 arch/powerpc/kvm/book3s_xive_template.c            |    8 -
 arch/powerpc/kvm/bookehv_interrupts.S              |    8 +-
 arch/powerpc/kvm/emulate_loadstore.c               |    1 -
 arch/powerpc/kvm/powerpc.c                         |   15 +-
 arch/powerpc/kvm/tm.S                              |  252 ++-
 arch/powerpc/kvm/trace_book3s.h                    |    1 -
 arch/powerpc/mm/tlb-radix.c                        |    9 +
 arch/s390/Kconfig                                  |   11 +
 arch/s390/include/asm/kvm_host.h                   |   15 +-
 arch/s390/include/uapi/asm/kvm.h                   |    2 +
 arch/s390/kvm/kvm-s390.c                           |  184 +-
 arch/s390/kvm/kvm-s390.h                           |    1 +
 arch/s390/kvm/vsie.c                               |  210 +-
 arch/s390/mm/gmap.c                                |   10 +-
 arch/s390/tools/gen_facilities.c                   |    2 +
 arch/x86/include/asm/kvm_host.h                    |   70 +-
 arch/x86/include/asm/virtext.h                     |    2 +-
 arch/x86/include/asm/vmx.h                         |   13 -
 arch/x86/include/uapi/asm/kvm.h                    |    8 +-
 arch/x86/kvm/hyperv.c                              |  280 ++-
 arch/x86/kvm/hyperv.h                              |    4 +
 arch/x86/kvm/lapic.c                               |   45 +-
 arch/x86/kvm/lapic.h                               |    2 +-
 arch/x86/kvm/mmu.c                                 |  389 ++--
 arch/x86/kvm/mmu.h                                 |   13 +-
 arch/x86/kvm/mmu_audit.c                           |   12 +-
 arch/x86/kvm/paging_tmpl.h                         |   15 +-
 arch/x86/kvm/svm.c                                 |   64 +-
 arch/x86/kvm/trace.h                               |   42 +
 arch/x86/kvm/vmx.c                                 | 2297 ++++++++++++++------
 arch/x86/kvm/vmx_shadow_fields.h                   |    5 +-
 arch/x86/kvm/x86.c                                 |  244 ++-
 arch/x86/kvm/x86.h                                 |    2 +
 drivers/iommu/Kconfig                              |    8 +
 drivers/s390/crypto/Makefile                       |    4 +
 drivers/s390/crypto/vfio_ap_drv.c                  |  157 ++
 drivers/s390/crypto/vfio_ap_ops.c                  |  939 ++++++++
 drivers/s390/crypto/vfio_ap_private.h              |   88 +
 drivers/vfio/vfio_iommu_spapr_tce.c                |   23 +-
 include/linux/irqchip/arm-gic-v3.h                 |    5 +
 include/uapi/linux/kvm.h                           |   26 +-
 include/uapi/linux/vfio.h                          |    2 +
 tools/arch/x86/include/uapi/asm/kvm.h              |   10 +-
 tools/include/uapi/linux/kvm.h                     |    5 +
 tools/perf/arch/powerpc/util/book3s_hv_exits.h     |    1 -
 tools/testing/selftests/kvm/.gitignore             |   14 +-
 tools/testing/selftests/kvm/Makefile               |   37 +-
 tools/testing/selftests/kvm/dirty_log_test.c       |  372 +++-
 .../selftests/kvm/include/aarch64/processor.h      |   55 +
 tools/testing/selftests/kvm/include/evmcs.h        | 1098 ++++++++++
 tools/testing/selftests/kvm/include/kvm_util.h     |  161 +-
 tools/testing/selftests/kvm/include/sparsebit.h    |    6 +-
 tools/testing/selftests/kvm/include/test_util.h    |    6 +-
 .../kvm/include/{x86.h => x86_64/processor.h}      |   28 +-
 .../selftests/kvm/include/{ => x86_64}/vmx.h       |   35 +-
 .../testing/selftests/kvm/lib/aarch64/processor.c  |  311 +++
 tools/testing/selftests/kvm/lib/assert.c           |    2 +-
 tools/testing/selftests/kvm/lib/kvm_util.c         |  564 ++---
 .../testing/selftests/kvm/lib/kvm_util_internal.h  |   33 +-
 tools/testing/selftests/kvm/lib/ucall.c            |  144 ++
 .../kvm/lib/{x86.c => x86_64/processor.c}          |  263 ++-
 tools/testing/selftests/kvm/lib/{ => x86_64}/vmx.c |   53 +-
 .../kvm/{ => x86_64}/cr4_cpuid_sync_test.c         |   14 +-
 tools/testing/selftests/kvm/x86_64/evmcs_test.c    |  160 ++
 .../kvm/{ => x86_64}/platform_info_test.c          |   14 +-
 .../selftests/kvm/{ => x86_64}/set_sregs_test.c    |    2 +-
 .../selftests/kvm/{ => x86_64}/state_test.c        |   47 +-
 .../selftests/kvm/{ => x86_64}/sync_regs_test.c    |    2 +-
 .../kvm/{ => x86_64}/vmx_tsc_adjust_test.c         |   24 +-
 virt/kvm/arm/arm.c                                 |   26 +-
 virt/kvm/arm/mmu.c                                 |  128 +-
 virt/kvm/arm/vgic/vgic-its.c                       |   36 +-
 virt/kvm/arm/vgic/vgic-kvm-device.c                |    2 +-
 virt/kvm/arm/vgic/vgic-mmio-v3.c                   |    2 -
 virt/kvm/coalesced_mmio.c                          |   12 +-
 virt/kvm/kvm_main.c                                |   39 +-
 138 files changed, 12445 insertions(+), 3248 deletions(-)

---8<---
diff --cc arch/arm/include/asm/kvm_mmu.h
index 847f01fa429d,5ad1a54f98dc..f8fc91e17a4f
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@@ -355,11 -358,8 +358,13 @@@ static inline int hyp_map_aux_data(void
  
  #define kvm_phys_to_vttbr(addr)		(addr)
  
 +static inline bool kvm_cpu_has_cnp(void)
 +{
 +	return false;
 +}
 +
+ static inline void kvm_set_ipa_limit(void) {}
+ 
  #endif	/* !__ASSEMBLY__ */
  
  #endif /* __ARM_KVM_MMU_H__ */
diff --cc arch/arm64/include/asm/cpufeature.h
index 6db48d90ad63,072cc1c970c2..7e2ec64aa414
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@@ -536,7 -530,26 +536,28 @@@ void arm64_set_ssbd_mitigation(bool sta
  static inline void arm64_set_ssbd_mitigation(bool state) {}
  #endif
  
 +extern int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
++
+ static inline u32 id_aa64mmfr0_parange_to_phys_shift(int parange)
+ {
+ 	switch (parange) {
+ 	case 0: return 32;
+ 	case 1: return 36;
+ 	case 2: return 40;
+ 	case 3: return 42;
+ 	case 4: return 44;
+ 	case 5: return 48;
+ 	case 6: return 52;
+ 	/*
+ 	 * A future PE could use a value unknown to the kernel.
+ 	 * However, by the "D10.1.4 Principles of the ID scheme
+ 	 * for fields in ID registers", ARM DDI 0487C.a, any new
+ 	 * value is guaranteed to be higher than what we know already.
+ 	 * As a safe limit, we return the limit supported by the kernel.
+ 	 */
+ 	default: return CONFIG_ARM64_PA_BITS;
+ 	}
+ }
  #endif /* __ASSEMBLY__ */
  
  #endif
diff --cc arch/arm64/include/asm/kvm_arm.h
index b476bc46f0ab,6e324d1f1231..6f602af5263c
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@@ -145,38 -143,127 +143,128 @@@
  #define VTCR_EL2_COMMON_BITS	(VTCR_EL2_SH0_INNER | VTCR_EL2_ORGN0_WBWA | \
  				 VTCR_EL2_IRGN0_WBWA | VTCR_EL2_RES1)
  
+ /*
+  * VTCR_EL2:SL0 indicates the entry level for Stage2 translation.
+  * Interestingly, it depends on the page size.
+  * See D.10.2.121, VTCR_EL2, in ARM DDI 0487C.a
+  *
+  *	-----------------------------------------
+  *	| Entry level		|  4K  | 16K/64K |
+  *	------------------------------------------
+  *	| Level: 0		|  2   |   -     |
+  *	------------------------------------------
+  *	| Level: 1		|  1   |   2     |
+  *	------------------------------------------
+  *	| Level: 2		|  0   |   1     |
+  *	------------------------------------------
+  *	| Level: 3		|  -   |   0     |
+  *	------------------------------------------
+  *
+  * The table roughly translates to :
+  *
+  *	SL0(PAGE_SIZE, Entry_level) = TGRAN_SL0_BASE - Entry_Level
+  *
+  * Where TGRAN_SL0_BASE is a magic number depending on the page size:
+  * 	TGRAN_SL0_BASE(4K) = 2
+  *	TGRAN_SL0_BASE(16K) = 3
+  *	TGRAN_SL0_BASE(64K) = 3
+  * provided we take care of ruling out the unsupported cases and
+  * Entry_Level = 4 - Number_of_levels.
+  *
+  */
  #ifdef CONFIG_ARM64_64K_PAGES
- /*
-  * Stage2 translation configuration:
-  * 64kB pages (TG0 = 1)
-  * 2 level page tables (SL = 1)
-  */
- #define VTCR_EL2_TGRAN_FLAGS		(VTCR_EL2_TG0_64K | VTCR_EL2_SL0_LVL1)
- #define VTTBR_X_TGRAN_MAGIC		38
+ 
+ #define VTCR_EL2_TGRAN			VTCR_EL2_TG0_64K
+ #define VTCR_EL2_TGRAN_SL0_BASE		3UL
+ 
  #elif defined(CONFIG_ARM64_16K_PAGES)
- /*
-  * Stage2 translation configuration:
-  * 16kB pages (TG0 = 2)
-  * 2 level page tables (SL = 1)
-  */
- #define VTCR_EL2_TGRAN_FLAGS		(VTCR_EL2_TG0_16K | VTCR_EL2_SL0_LVL1)
- #define VTTBR_X_TGRAN_MAGIC		42
+ 
+ #define VTCR_EL2_TGRAN			VTCR_EL2_TG0_16K
+ #define VTCR_EL2_TGRAN_SL0_BASE		3UL
+ 
  #else	/* 4K */
- /*
-  * Stage2 translation configuration:
-  * 4kB pages (TG0 = 0)
-  * 3 level page tables (SL = 1)
-  */
- #define VTCR_EL2_TGRAN_FLAGS		(VTCR_EL2_TG0_4K | VTCR_EL2_SL0_LVL1)
- #define VTTBR_X_TGRAN_MAGIC		37
+ 
+ #define VTCR_EL2_TGRAN			VTCR_EL2_TG0_4K
+ #define VTCR_EL2_TGRAN_SL0_BASE		2UL
+ 
  #endif
  
- #define VTCR_EL2_FLAGS			(VTCR_EL2_COMMON_BITS | VTCR_EL2_TGRAN_FLAGS)
- #define VTTBR_X				(VTTBR_X_TGRAN_MAGIC - VTCR_EL2_T0SZ_IPA)
+ #define VTCR_EL2_LVLS_TO_SL0(levels)	\
+ 	((VTCR_EL2_TGRAN_SL0_BASE - (4 - (levels))) << VTCR_EL2_SL0_SHIFT)
+ #define VTCR_EL2_SL0_TO_LVLS(sl0)	\
+ 	((sl0) + 4 - VTCR_EL2_TGRAN_SL0_BASE)
+ #define VTCR_EL2_LVLS(vtcr)		\
+ 	VTCR_EL2_SL0_TO_LVLS(((vtcr) & VTCR_EL2_SL0_MASK) >> VTCR_EL2_SL0_SHIFT)
+ 
+ #define VTCR_EL2_FLAGS			(VTCR_EL2_COMMON_BITS | VTCR_EL2_TGRAN)
+ #define VTCR_EL2_IPA(vtcr)		(64 - ((vtcr) & VTCR_EL2_T0SZ_MASK))
+ 
+ /*
+  * ARM VMSAv8-64 defines an algorithm for finding the translation table
+  * descriptors in section D4.2.8 in ARM DDI 0487C.a.
+  *
+  * The algorithm defines the expectations on the translation table
+  * addresses for each level, based on PAGE_SIZE, entry level
+  * and the translation table size (T0SZ). The variable "x" in the
+  * algorithm determines the alignment of a table base address at a given
+  * level and thus determines the alignment of VTTBR:BADDR for stage2
+  * page table entry level.
+  * Since the number of bits resolved at the entry level could vary
+  * depending on the T0SZ, the value of "x" is defined based on a
+  * Magic constant for a given PAGE_SIZE and Entry Level. The
+  * intermediate levels must be always aligned to the PAGE_SIZE (i.e,
+  * x = PAGE_SHIFT).
+  *
+  * The value of "x" for entry level is calculated as :
+  *    x = Magic_N - T0SZ
+  *
+  * where Magic_N is an integer depending on the page size and the entry
+  * level of the page table as below:
+  *
+  *	--------------------------------------------
+  *	| Entry level		|  4K    16K   64K |
+  *	--------------------------------------------
+  *	| Level: 0 (4 levels)	| 28   |  -  |  -  |
+  *	--------------------------------------------
+  *	| Level: 1 (3 levels)	| 37   | 31  | 25  |
+  *	--------------------------------------------
+  *	| Level: 2 (2 levels)	| 46   | 42  | 38  |
+  *	--------------------------------------------
+  *	| Level: 3 (1 level)	| -    | 53  | 51  |
+  *	--------------------------------------------
+  *
+  * We have a magic formula for the Magic_N below:
+  *
+  *  Magic_N(PAGE_SIZE, Level) = 64 - ((PAGE_SHIFT - 3) * Number_of_levels)
+  *
+  * where Number_of_levels = (4 - Level). We are only interested in the
+  * value for Entry_Level for the stage2 page table.
+  *
+  * So, given that T0SZ = (64 - IPA_SHIFT), we can compute 'x' as follows:
+  *
+  *	x = (64 - ((PAGE_SHIFT - 3) * Number_of_levels)) - (64 - IPA_SHIFT)
+  *	  = IPA_SHIFT - ((PAGE_SHIFT - 3) * Number of levels)
+  *
+  * Here is one way to explain the Magic Formula:
+  *
+  *  x = log2(Size_of_Entry_Level_Table)
+  *
+  * Since, we can resolve (PAGE_SHIFT - 3) bits at each level, and another
+  * PAGE_SHIFT bits in the PTE, we have :
+  *
+  *  Bits_Entry_level = IPA_SHIFT - ((PAGE_SHIFT - 3) * (n - 1) + PAGE_SHIFT)
+  *		     = IPA_SHIFT - (PAGE_SHIFT - 3) * n - 3
+  *  where n = number of levels, and since each pointer is 8bytes, we have:
+  *
+  *  x = Bits_Entry_Level + 3
+  *    = IPA_SHIFT - (PAGE_SHIFT - 3) * n
+  *
+  * The only constraint here is that, we have to find the number of page table
+  * levels for a given IPA size (which we do, see stage2_pt_levels())
+  */
+ #define ARM64_VTTBR_X(ipa, levels)	((ipa) - ((levels) * (PAGE_SHIFT - 3)))
  
 +#define VTTBR_CNP_BIT     (UL(1))
- #define VTTBR_BADDR_MASK  (((UL(1) << (PHYS_MASK_SHIFT - VTTBR_X)) - 1) << VTTBR_X)
  #define VTTBR_VMID_SHIFT  (UL(48))
  #define VTTBR_VMID_MASK(size) (_AT(u64, (1 << size) - 1) << VTTBR_VMID_SHIFT)
  
diff --cc arch/arm64/include/asm/kvm_mmu.h
index 64337afbf124,77b1af9e64db..412449c6c984
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@@ -517,10 -519,29 +519,34 @@@ static inline int hyp_map_aux_data(void
  
  #define kvm_phys_to_vttbr(addr)		phys_to_ttbr(addr)
  
 +static inline bool kvm_cpu_has_cnp(void)
 +{
 +	return system_supports_cnp();
 +}
 +
+ /*
+  * Get the magic number 'x' for VTTBR:BADDR of this KVM instance.
+  * With v8.2 LVA extensions, 'x' should be a minimum of 6 with
+  * 52bit IPS.
+  */
+ static inline int arm64_vttbr_x(u32 ipa_shift, u32 levels)
+ {
+ 	int x = ARM64_VTTBR_X(ipa_shift, levels);
+ 
+ 	return (IS_ENABLED(CONFIG_ARM64_PA_BITS_52) && x < 6) ? 6 : x;
+ }
+ 
+ static inline u64 vttbr_baddr_mask(u32 ipa_shift, u32 levels)
+ {
+ 	unsigned int x = arm64_vttbr_x(ipa_shift, levels);
+ 
+ 	return GENMASK_ULL(PHYS_MASK_SHIFT - 1, x);
+ }
+ 
+ static inline u64 kvm_vttbr_baddr_mask(struct kvm *kvm)
+ {
+ 	return vttbr_baddr_mask(kvm_phys_shift(kvm), kvm_stage2_levels(kvm));
+ }
+ 
  #endif /* __ASSEMBLY__ */
  #endif /* __ARM64_KVM_MMU_H__ */
diff --cc arch/x86/kvm/vmx.c
index e665aa7167cf,ccc6a01eb4f4..4555077d69ce
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@@ -1567,19 -1577,15 +1577,19 @@@ static int vmx_hv_remote_flush_tlb(stru
  	if (to_kvm_vmx(kvm)->ept_pointers_match == EPT_POINTERS_CHECK)
  		check_ept_pointer_match(kvm);
  
- 	if (to_kvm_vmx(kvm)->ept_pointers_match != EPT_POINTERS_MATCH) {
- 		ret = -ENOTSUPP;
- 		goto out;
- 	}
- 
 +	/*
 +	 * FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE hypercall needs the address of the
 +	 * base of EPT PML4 table, strip off EPT configuration information.
 +	 */
- 	ret = hyperv_flush_guest_mapping(
- 			to_vmx(kvm_get_vcpu(kvm, 0))->ept_pointer & PAGE_MASK);
+ 	if (to_kvm_vmx(kvm)->ept_pointers_match != EPT_POINTERS_MATCH) {
+ 		kvm_for_each_vcpu(i, vcpu, kvm)
+ 			ret |= hyperv_flush_guest_mapping(
 -				to_vmx(kvm_get_vcpu(kvm, i))->ept_pointer);
++				to_vmx(kvm_get_vcpu(kvm, i))->ept_pointer & PAGE_MASK);
+ 	} else {
+ 		ret = hyperv_flush_guest_mapping(
 -				to_vmx(kvm_get_vcpu(kvm, 0))->ept_pointer);
++				to_vmx(kvm_get_vcpu(kvm, 0))->ept_pointer & PAGE_MASK);
+ 	}
  
- out:
  	spin_unlock(&to_kvm_vmx(kvm)->ept_pointer_lock);
  	return ret;
  }
diff --cc virt/kvm/arm/arm.c
index 150c8a69cdaf,11b98b2b0486..23774970c9df
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@@ -544,9 -546,9 +546,9 @@@ static void update_vttbr(struct kvm *kv
  
  	/* update vttbr to be used with the new vmid */
  	pgd_phys = virt_to_phys(kvm->arch.pgd);
- 	BUG_ON(pgd_phys & ~VTTBR_BADDR_MASK);
+ 	BUG_ON(pgd_phys & ~kvm_vttbr_baddr_mask(kvm));
  	vmid = ((u64)(kvm->arch.vmid) << VTTBR_VMID_SHIFT) & VTTBR_VMID_MASK(kvm_vmid_bits);
 -	kvm->arch.vttbr = kvm_phys_to_vttbr(pgd_phys) | vmid;
 +	kvm->arch.vttbr = kvm_phys_to_vttbr(pgd_phys) | vmid | cnp;
  
  	write_unlock(&kvm_vmid_lock);
  }
