Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbeEULfi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 07:35:38 -0400
Received: from foss.arm.com ([217.140.101.70]:47536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752707AbeEULfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 07:35:37 -0400
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, christoffer.dall@arm.com, james.morse@arm.com,
        joelaf@google.com, joel.opensrc@gmail.com, daniel.thompson@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v3 0/6] arm64: provide pseudo NMI with GICv3
Date: Mon, 21 May 2018 12:35:09 +0100
Message-Id: <1526902515-13769-1-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a continuation of the work started by Daniel [1]. The goal
is to use GICv3 interrupt priorities to simulate an NMI.

To achieve this, set two priorities, one for standard interrupts and
another, higher priority, for NMIs. Whenever we want to disable interrupts,
we mask the standard priority instead so NMIs can still be raised. Some
corner cases though still require to actually mask all interrupts
effectively disabling the NMI.


Currently, only PPIs and SPIs can be set as NMIs. IPIs being currently
hardcoded IRQ numbers, there isn't a generic interface to set SGIs as NMI
for now. I don't think there is any reason LPIs should be allowed to be set
as NMI as they do not have an active state.
When an NMI is active on a CPU, no other NMI can be triggered on the CPU.


I did a bit of testing on a board with 8 Cortex-A57 cores:

- "hackbench 200 process 1000" (average over 20 runs)
+-----------+----------+------------+------------------+
|           | native   | PMR guest  | v4.17-rc6 guest  |
+-----------+----------+------------+------------------+
| PMR host  | 40.0336s |   39.3039s |         39.2044s |
| v4.17-rc6 | 40.4040s |   39.6011s |         39.1147s |
+-----------+----------+------------+------------------+

I'm not sure why guests appear to be faster than hosts, maybe
because host have full ubuntu system and guest just have a simple rootfs
with busybox...

It also seems the penalty from using PMR is cushioned by the removal of
the interrupt acknowledge loop in the GICv3 driver.


- Kernel build from defconfig:
PMR host:  13m45.743s
v4.17-rc6: 13m40.400s

The difference is ~0.65%, from different runs, this seems to be within
the noise.


Requirements to use this:
- Have GICv3
- SCR_EL3.FIQ is set to 1 when linux runs or have single security state
- Select Kernel Feature -> Use ICC system registers for IRQ masking

* Patches 1 and 2 allows to detect and enable the use of GICv3 system
  registers during boot time.
* Patch 3 introduces the masking of IRQs using priorities replacing irq
  disabling.
* Patch 4 adds some utility functions
* Patch 5 add detection of the view linux has on GICv3 priorities, without
  this we cannot easily mask specific priorities in an accurate manner
* Patch 6 adds the support for NMIs


Changes since V2[2]:
* Series rebase to v4.17-rc6

* Adapt pathces 1 and 2 to the rework of cpufeatures framework

* Use the group0 detection scheme in the GICv3 driver to identify
  the priority view, and drop the use of a fake interrupt

* Add the case for a GIC configured in a single security state

* Use local_daif_restore instead of local_irq_enable the first time
  we enable interrupts after a bp hardening in the handling of a kernel
  entry. Otherwise PRS.I remains set...


Changes since V1[3]:
* Series rebased to v4.15-rc8.

* Check for arm64_early_features in this_cpu_has_cap (spotted by Suzuki).

* Fix issue where debug exception were not masked when enabling debug in
  mdscr_el1.


Changes since RFC[4]:
* The series was rebased to v4.15-rc2 which implied some changes mainly
  related to the work on exception entries and daif flags by James Morse.

  - The first patch in the previous series was dropped because no longer
    applicable.

  - With the semantics James introduced of "inheriting" daif flags,
    handling of PMR on exception entry is simplified as PMR is not altered
    by taking an exception and already inherited from previous state.

  - James pointed out that taking a PseudoNMI before reading the FAR_EL1
    register should not be allowed as per the TRM (D10.2.29):
    "FAR_EL1 is made UNKNOWN on an exception return from EL1."
    So in this submission PSR.I bit is cleared only after FAR_EL1 is read.

* For KVM, only deal with PMR unmasking/restoring in common code, and VHE
  specific code makes sure PSR.I bit is set when necessary.

* When detecting the GIC priority view (patch 5), wait for an actual
  interrupt instead of trying only once.


[1] http://www.spinics.net/lists/arm-kernel/msg525077.html
[2] https://lkml.org/lkml/2018/1/17/335
[3] https://www.spinics.net/lists/arm-kernel/msg620763.html
[4] https://www.spinics.net/lists/arm-kernel/msg610736.html

Cheers,

Julien


Daniel Thompson (3):
  arm64: cpufeature: Allow early detect of specific features
  arm64: alternative: Apply alternatives early in boot process
  arm64: irqflags: Use ICC sysregs to implement IRQ masking

Julien Thierry (3):
  irqchip/gic: Add functions to access irq priorities
  arm64: Detect current view of GIC priorities
  arm64: Add support for pseudo-NMIs

 Documentation/arm64/booting.txt        |   5 +
 arch/arm64/Kconfig                     |  15 ++
 arch/arm64/include/asm/alternative.h   |   5 +-
 arch/arm64/include/asm/arch_gicv3.h    |  25 +++
 arch/arm64/include/asm/assembler.h     |  25 ++-
 arch/arm64/include/asm/cpufeature.h    |   2 +
 arch/arm64/include/asm/daifflags.h     |  36 ++--
 arch/arm64/include/asm/efi.h           |   5 +
 arch/arm64/include/asm/irqflags.h      | 131 ++++++++++++++
 arch/arm64/include/asm/kvm_host.h      |  14 ++
 arch/arm64/include/asm/processor.h     |   4 +
 arch/arm64/include/asm/ptrace.h        |  14 +-
 arch/arm64/include/asm/sysreg.h        |   1 +
 arch/arm64/kernel/alternative.c        |  39 +++-
 arch/arm64/kernel/asm-offsets.c        |   1 +
 arch/arm64/kernel/cpufeature.c         |   9 +-
 arch/arm64/kernel/entry.S              |  84 ++++++++-
 arch/arm64/kernel/head.S               |  37 ++++
 arch/arm64/kernel/process.c            |   6 +
 arch/arm64/kernel/smp.c                |  15 ++
 arch/arm64/kvm/hyp/switch.c            |  25 +++
 arch/arm64/mm/fault.c                  |   5 +-
 arch/arm64/mm/proc.S                   |  23 +++
 drivers/irqchip/irq-gic-common.c       |  10 ++
 drivers/irqchip/irq-gic-common.h       |   2 +
 drivers/irqchip/irq-gic-v3-its.c       |   2 +-
 drivers/irqchip/irq-gic-v3.c           | 320 ++++++++++++++++++++++++++-------
 include/linux/interrupt.h              |   1 +
 include/linux/irqchip/arm-gic-common.h |   6 +
 include/linux/irqchip/arm-gic.h        |   5 -
 30 files changed, 778 insertions(+), 94 deletions(-)

--
1.9.1
