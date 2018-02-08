Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbeBHSki (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 13:40:38 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38910 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750847AbeBHSkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 13:40:36 -0500
Date: Thu, 8 Feb 2018 18:40:32 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 updates for 4.16-rc1
Message-ID: <20180208184030.srecn65dhuve3hxv@armageddon.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

As I mentioned in the last pull request, there's a second batch of
security updates for arm64 with mitigations for Spectre/v1 and an
improved one for Spectre/v2 (via a newly defined firmware interface
API).

The patch "arm64: KVM: Fix SMCCC handling of unimplemented SMC/HVC
calls" is already in -rc9 but I included it here since my for-next/core
branch is still based on -rc3.

When merging against your tree, I get conflicts in
arch/arm64/kvm/handle_exit.c and arch/arm64/include/asm/assembler.h but
they should resolve as in tags/arm64-upstream (git diff is empty on my
test merge).

Thanks.


The following changes since commit ec89ab50a03a33a4a648869e868b1964354fb2d1:

  arm64: Fix TTBR + PAN + 52-bit PA logic in cpu_do_switch_mm (2018-01-26 18:23:17 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

for you to fetch changes up to 3a0a397ff5ff8b56ca9f7908b75dee6bf0b5fabb:

  arm64: Kill PSCI_GET_VERSION as a variant-2 workaround (2018-02-06 22:54:18 +0000)

----------------------------------------------------------------
2nd set of arm64 updates for 4.16:

Spectre v1 mitigation:
- back-end version of array_index_mask_nospec()
- masking of the syscall number to restrict speculation through the
  syscall table
- masking of __user pointers prior to deference in uaccess routines

Spectre v2 mitigation update:
- using the new firmware SMC calling convention specification update
- removing the current PSCI GET_VERSION firmware call mitigation as
  vendors are deploying new SMCCC-capable firmware
- additional branch predictor hardening for synchronous exceptions and
  interrupts while in user mode

Meltdown v3 mitigation update for Cavium Thunder X: unaffected but
hardware erratum gets in the way. The kernel now starts with the page
tables mapped as global and switches to non-global if kpti needs to be
enabled.

Other:
- Theoretical trylock bug fixed

----------------------------------------------------------------
Marc Zyngier (18):
      arm64: Force KPTI to be disabled on Cavium ThunderX
      arm64: KVM: Fix SMCCC handling of unimplemented SMC/HVC calls
      arm: KVM: Fix SMCCC handling of unimplemented SMC/HVC calls
      arm64: KVM: Increment PC after handling an SMC trap
      arm/arm64: KVM: Consolidate the PSCI include files
      arm/arm64: KVM: Add PSCI_VERSION helper
      arm/arm64: KVM: Add smccc accessors to PSCI code
      arm/arm64: KVM: Implement PSCI 1.0 support
      arm/arm64: KVM: Advertise SMCCC v1.1
      arm/arm64: KVM: Turn kvm_psci_version into a static inline
      arm64: KVM: Report SMCCC_ARCH_WORKAROUND_1 BP hardening support
      arm64: KVM: Add SMCCC_ARCH_WORKAROUND_1 fast handling
      firmware/psci: Expose PSCI conduit
      firmware/psci: Expose SMCCC version through psci_ops
      arm/arm64: smccc: Make function identifiers an unsigned quantity
      arm/arm64: smccc: Implement SMCCC v1.1 inline primitive
      arm64: Add ARM_SMCCC_ARCH_WORKAROUND_1 BP hardening support
      arm64: Kill PSCI_GET_VERSION as a variant-2 workaround

Robin Murphy (3):
      arm64: Implement array_index_mask_nospec()
      arm64: Make USER_DS an inclusive limit
      arm64: Use pointer masking to limit uaccess speculation

Shanker Donthineni (1):
      arm64: Add software workaround for Falkor erratum 1041

Will Deacon (16):
      arm64: spinlock: Fix theoretical trylock() A-B-A with LSE atomics
      arm64: kpti: Make use of nG dependent on arm64_kernel_unmapped_at_el0()
      arm64: mm: Permit transitioning from Global to Non-Global without BBM
      arm64: kpti: Add ->enable callback to remap swapper using nG mappings
      arm64: assembler: Change order of macro arguments in phys_to_ttbr
      arm64: entry: Reword comment about post_ttbr_update_workaround
      arm64: assembler: Align phys_to_pte with pte_to_phys
      arm64: idmap: Use "awx" flags for .idmap.text .pushsection directives
      arm64: barrier: Add CSDB macros to control data-value prediction
      arm64: entry: Ensure branch through syscall table is bounded under speculation
      arm64: uaccess: Prevent speculative use of the current addr_limit
      arm64: uaccess: Don't bother eliding access_ok checks in __{get, put}_user
      arm64: uaccess: Mask __user pointers for __arch_{clear, copy_*}_user
      arm64: futex: Mask __user pointers prior to dereference
      arm64: entry: Apply BP hardening for high-priority synchronous exceptions
      arm64: entry: Apply BP hardening for suspicious interrupts from EL0

 Documentation/arm64/silicon-errata.txt  |   1 +
 arch/arm/include/asm/kvm_host.h         |   7 ++
 arch/arm/include/asm/kvm_psci.h         |  27 ----
 arch/arm/kvm/handle_exit.c              |  17 ++-
 arch/arm64/Kconfig                      |  12 +-
 arch/arm64/include/asm/assembler.h      |  53 +++++++-
 arch/arm64/include/asm/barrier.h        |  22 ++++
 arch/arm64/include/asm/futex.h          |   9 +-
 arch/arm64/include/asm/kernel-pgtable.h |  12 +-
 arch/arm64/include/asm/kvm_host.h       |   6 +
 arch/arm64/include/asm/kvm_psci.h       |  27 ----
 arch/arm64/include/asm/pgtable-prot.h   |  30 +++--
 arch/arm64/include/asm/processor.h      |   3 +
 arch/arm64/include/asm/spinlock.h       |   4 +-
 arch/arm64/include/asm/uaccess.h        | 155 +++++++++++++++--------
 arch/arm64/kernel/arm64ksyms.c          |   4 +-
 arch/arm64/kernel/bpi.S                 |  44 +++----
 arch/arm64/kernel/cpu-reset.S           |   3 +-
 arch/arm64/kernel/cpu_errata.c          |  77 +++++++++---
 arch/arm64/kernel/cpufeature.c          |  42 ++++++-
 arch/arm64/kernel/efi-entry.S           |   2 +
 arch/arm64/kernel/entry.S               |  29 +++--
 arch/arm64/kernel/head.S                |  31 +----
 arch/arm64/kernel/hibernate-asm.S       |   4 +-
 arch/arm64/kernel/relocate_kernel.S     |   1 +
 arch/arm64/kernel/sleep.S               |   2 +-
 arch/arm64/kvm/handle_exit.c            |  18 ++-
 arch/arm64/kvm/hyp-init.S               |   3 +-
 arch/arm64/kvm/hyp/hyp-entry.S          |  20 ++-
 arch/arm64/kvm/hyp/switch.c             |  14 +--
 arch/arm64/lib/clear_user.S             |   6 +-
 arch/arm64/lib/copy_in_user.S           |   5 +-
 arch/arm64/mm/fault.c                   |  19 ++-
 arch/arm64/mm/mmu.c                     |   4 +
 arch/arm64/mm/proc.S                    | 212 ++++++++++++++++++++++++++++++--
 drivers/firmware/psci.c                 |  55 ++++++++-
 include/kvm/arm_psci.h                  |  51 ++++++++
 include/linux/arm-smccc.h               | 165 ++++++++++++++++++++++++-
 include/linux/psci.h                    |  13 ++
 include/uapi/linux/psci.h               |   3 +
 virt/kvm/arm/arm.c                      |   2 +-
 virt/kvm/arm/psci.c                     | 143 +++++++++++++++++----
 42 files changed, 1062 insertions(+), 295 deletions(-)
 delete mode 100644 arch/arm/include/asm/kvm_psci.h
 delete mode 100644 arch/arm64/include/asm/kvm_psci.h
 create mode 100644 include/kvm/arm_psci.h

-- 
Catalin
