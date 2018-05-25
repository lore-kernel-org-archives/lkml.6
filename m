Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965841AbeEYJuB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:50:01 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57382 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965455AbeEYJt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:49:56 -0400
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v4 00/26] arm64: provide pseudo NMI with GICv3
Date: Fri, 25 May 2018 10:49:06 +0100
Message-Id: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
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

After the big refactoring I get performances similar to the ones I had
in v3[2], reposting old results here:

- "hackbench 200 process 1000" (average over 20 runs)
+-----------+----------+------------+------------------+
|           | native   | PMR guest  | v4.17-rc6 guest  |
+-----------+----------+------------+------------------+
| PMR host  | 40.0336s |   39.3039s |         39.2044s |
| v4.17-rc6 | 40.4040s |   39.6011s |         39.1147s |
+-----------+----------+------------+------------------+

- Kernel build from defconfig:
PMR host:  13m45.743s
v4.17-rc6: 13m40.400s

I'll try to post more detailed benchmarks later if I find notable
differences with the previous version.


Requirements to use this:
- Have GICv3
- SCR_EL3.FIQ is set to 1 when linux runs or have single security state
- Select Kernel Feature -> Use ICC system registers for IRQ masking


* Patches 1 to 4 aim at applying some alternatives early in the boot
  process, including the feature for priority masking.

* Patches 5 to 7 and 17 lightly refactor bits of GIC driver to make things
  nicer for the rest of the series.

* Patches 8 to 10 and 16 ensure the logic of daifflags remains valid
  after arch_local_irq flags use ICC_PMR_EL1.

* Patches 11 to 14 do some required PMR treatement in order for things to
  work when the system uses priority masking.

* Patches 15, 18, 19, 20 and 21 actually make the changes to use
  ICC_PMR_EL1 for priority masking/unmasking when disabling/enabling
  interrupts.

* Patches 22 to 26 provide support for pseudo-NMI in the GICv3 driver
  when priority masking is enabled.


Changes since V3[2]:
* Big refactoring. As suggested by Marc Z., some of the bigger patches
  needed to be split into smaller one.

* Try to reduce the amount of #ifdef for the new feature by introducing
  an individual cpufeature for priority masking

* Do not track which alternatives have been applied (was a bit dodgy
  anyway), and use an alternative for VHE cpu_enable callback

* Fix a build failure with arm by adding the correct RPR accessors

* Added Suggested-by tags for changes from comming or inspired by Daniel's
  series. Do let me know if you feel I missed something and am not giving
  you due credit.

Changes since V2[3]:
* Series rebase to v4.17-rc6

* Adapt pathces 1 and 2 to the rework of cpufeatures framework

* Use the group0 detection scheme in the GICv3 driver to identify
  the priority view, and drop the use of a fake interrupt

* Add the case for a GIC configured in a single security state

* Use local_daif_restore instead of local_irq_enable the first time
  we enable interrupts after a bp hardening in the handling of a kernel
  entry. Otherwise PRS.I remains set...

Changes since V1[4]:
* Series rebased to v4.15-rc8.

* Check for arm64_early_features in this_cpu_has_cap (spotted by Suzuki).

* Fix issue where debug exception were not masked when enabling debug in
  mdscr_el1.

Changes since RFC[5]:
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
[2] https://lkml.org/lkml/2018/5/21/276
[3] https://lkml.org/lkml/2018/1/17/335
[4] https://www.spinics.net/lists/arm-kernel/msg620763.html
[5] https://www.spinics.net/lists/arm-kernel/msg610736.html

Cheers,

Julien

-->

Daniel Thompson (1):
  arm64: alternative: Apply alternatives early in boot process

Julien Thierry (25):
  arm64: cpufeature: Set SYSREG_GIC_CPUIF as a boot system feature
  arm64: cpufeature: Add cpufeature for IRQ priority masking
  arm64: cpufeature: Use alternatives for VHE cpu_enable
  irqchip/gic: Unify GIC priority definitions
  irqchip/gic: Lower priority of GIC interrupts
  irqchip/gic-v3: Remove acknowledge loop
  arm64: daifflags: Use irqflags functions for daifflags
  arm64: Use daifflag_restore after bp_hardening
  arm64: Delay daif masking for user return
  arm64: Make PMR part of task context
  arm64: Unmask PMR before going idle
  arm/arm64: gic-v3: Add helper functions to manage IRQ priorities
  arm64: kvm: Unmask PMR before entering guest
  arm64: irqflags: Use ICC_PMR_EL1 for interrupt masking
  arm64: daifflags: Include PMR in daifflags restore operations
  irqchip/gic-v3: Factor group0 detection into functions
  irqchip/gic-v3: Do not overwrite PMR value
  irqchip/gic-v3: Switch to PMR masking after IRQ acknowledge
  arm64: Switch to PMR masking when starting CPUs
  arm64: Add build option for IRQ masking via priority
  arm64: Detect current view of GIC priorities
  irqchip/gic: Add functions to access irq priorities
  irqchip/gic-v3: Add base support for pseudo-NMI
  irqchip/gic-v3: Provide NMI handlers
  irqchip/gic-v3: Allow interrupts to be set as pseudo-NMI

 Documentation/arm64/booting.txt        |   5 +
 arch/arm/include/asm/arch_gicv3.h      |  33 ++++
 arch/arm64/Kconfig                     |  15 ++
 arch/arm64/include/asm/alternative.h   |   3 +-
 arch/arm64/include/asm/arch_gicv3.h    |  32 ++++
 arch/arm64/include/asm/assembler.h     |  17 +-
 arch/arm64/include/asm/cpucaps.h       |   3 +-
 arch/arm64/include/asm/cpufeature.h    |   2 +
 arch/arm64/include/asm/daifflags.h     |  32 ++--
 arch/arm64/include/asm/efi.h           |   3 +-
 arch/arm64/include/asm/irqflags.h      | 100 ++++++++---
 arch/arm64/include/asm/kvm_host.h      |  12 ++
 arch/arm64/include/asm/processor.h     |   1 +
 arch/arm64/include/asm/ptrace.h        |  13 +-
 arch/arm64/kernel/alternative.c        |  30 +++-
 arch/arm64/kernel/asm-offsets.c        |   1 +
 arch/arm64/kernel/cpufeature.c         |  35 +++-
 arch/arm64/kernel/entry.S              |  67 ++++++-
 arch/arm64/kernel/head.S               |  35 ++++
 arch/arm64/kernel/process.c            |   2 +
 arch/arm64/kernel/smp.c                |  12 ++
 arch/arm64/kvm/hyp/switch.c            |  17 ++
 arch/arm64/mm/fault.c                  |   5 +-
 arch/arm64/mm/proc.S                   |  18 ++
 drivers/irqchip/irq-gic-common.c       |  10 ++
 drivers/irqchip/irq-gic-common.h       |   2 +
 drivers/irqchip/irq-gic-v3-its.c       |   2 +-
 drivers/irqchip/irq-gic-v3.c           | 318 +++++++++++++++++++++++++++------
 include/linux/interrupt.h              |   1 +
 include/linux/irqchip/arm-gic-common.h |   6 +
 include/linux/irqchip/arm-gic.h        |   5 -
 31 files changed, 719 insertions(+), 118 deletions(-)

--
1.9.1
