Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D90C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D7720851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7D7720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbeLLQrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:47:47 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44442 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbeLLQrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 11:47:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74C1D80D;
        Wed, 12 Dec 2018 08:47:46 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 83EE53F575;
        Wed, 12 Dec 2018 08:47:44 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v7 00/25] arm64: provide pseudo NMI with GICv3
Date:   Wed, 12 Dec 2018 16:47:00 +0000
Message-Id: <1544633245-6036-1-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series is a continuation of the work started by Daniel [1]. The goal
is to use GICv3 interrupt priorities to simulate an NMI.

The patches depend on the core API for NMIs patches [2].

To achieve this, set two priorities, one for standard interrupts and
another, higher priority, for NMIs. Whenever we want to disable interrupts,
we mask the standard priority instead so NMIs can still be raised. Some
corner cases though still require to actually mask all interrupts
effectively disabling the NMI.

Daniel Thompson ran some benchmarks [3] on a previous version showing a
small (<1%) performance drop when using interrupt priorities on Cortex-A53
and GIC-500.

Currently, only PPIs and SPIs can be set as NMIs. IPIs being currently
hardcoded IRQ numbers, there isn't a generic interface to set SGIs as NMI
for now. LPIs being controlled by the ITS cannot be delivered as NMI.
When an NMI is active on a CPU, no other NMI can be triggered on the CPU.

Requirements to use this:
- Have GICv3
- SCR_EL3.FIQ is set to 1 when linux runs or have single security state
- Select Kernel Feature -> Use ICC system registers for IRQ masking

* Patch 1 fixes an existing issue with current NMI contexts in arm64
* Patches 2 and 3 are just a bit of cleanup
* Patch 4 introduces a CPU feature to check if priority masking should be
  used
* Patches 5 and 6 add the support for priority masking in GICv3 driver
* Patches 7 to 12 add the support for priority masking the arch/arm64
  code
* Patches 13 and 14 allow us to apply alternatives earlier in the boot
  process
* Patches 15 to 17 starts the PMR masking on cpu startup and provides
  primitives for arm64 GICv3 driver to perform priority masking
* Patches 18 to 21 Add support for pseudo-NMIs in GICv3 driver
* Patches 22 to 24 Add support for receiving NMIs in arch/arm64
* Patch 25 adds the build config and command line option to enable
  pseudo-NMIs


Changes since v6[4]:
* Rebased on v4.20-rc6
* Added Acked-by and Reviewed-by tags
* Added fix for NMI contexts (patch 1)
* Renamed system_supports_irq_prio_masking() to
  system_uses_irq_prio_masking()
* Added some comments about PMR and the fact we need dsb
* Use higher priority bit of PMR to disable IRQs, set NMI priority
  accordingly
* Stop mixing daif and PMR for irqflags, irqflags now only
  touch PMR
* Get rid of PMR defines for GIC_PRIO_STATUS bit as single bit encoding
  of PMR status is no longer relyed upon
* Mask priorities in a single place in GICv3 handler code, this
  ensures we use PMR when we receive spurious interrupts
* Write cpu_do_idle() in C

Changes since v5[5]:
* Rebased on v4.20-rc2
* Reorganized patches again
* Renamed compile option + PMR values defines
* Write PMR enablement for cpu startup in C
* Fix wrong array size passed to __apply_alternatives
* Do not touch PMR in pt_regs when not using irq masking
* Remove ISB between PMR and IAR -> turns out it is not needed
* Simplify irqflags code after introducing PMR in it
* Use ref count API to track PPIs set as NMI
* Simplify NMI exit path

Changes since V4[6]:
* Rebased to v4.19-rc1
* Adapted GIC driver to the core NMI API
* Added option to disable priority masking on command line
* Added Daniel's Tested-by on patches related replacing PSR.I toggling with
  PMR masking
* Fix scope matching for alternative features.
* Spotted some more places using PSR.I or daif and replaced with generic
  interrupt functions

Changes since V3[7]:
* Big refactoring. As suggested by Marc Z., some of the bigger patches
  needed to be split into smaller one.
* Try to reduce the amount of #ifdef for the new feature by introducing
  an individual cpufeature for priority masking
* Do not track which alternatives have been applied (was a bit dodgy
  anyway), and use an alternative for VHE cpu_enable callback
* Fix a build failure with arm by adding the correct RPR accessors
* Added Suggested-by tags for changes from coming or inspired by Daniel's
  series. Do let me know if you feel I missed something and am not giving
  you due credit.

Changes since V2[8]:
* Series rebase to v4.17-rc6
* Adapt pathces 1 and 2 to the rework of cpufeatures framework
* Use the group0 detection scheme in the GICv3 driver to identify
  the priority view, and drop the use of a fake interrupt
* Add the case for a GIC configured in a single security state
* Use local_daif_restore instead of local_irq_enable the first time
  we enable interrupts after a bp hardening in the handling of a kernel
  entry. Otherwise PRS.I remains set...

Changes since V1[9]:
* Series rebased to v4.15-rc8.
* Check for arm64_early_features in this_cpu_has_cap (spotted by Suzuki).
* Fix issue where debug exception were not masked when enabling debug in
  mdscr_el1.

Changes since RFC[10]:
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
[2] https://lkml.org/lkml/2018/11/12/2113
[3] https://lkml.org/lkml/2018/7/20/803
[4] https://www.spinics.net/lists/arm-kernel/msg686670.html
[5] https://lkml.org/lkml/2018/8/28/693
[6] https://lkml.org/lkml/2018/7/24/321
[7] https://lkml.org/lkml/2018/5/21/276
[8] https://lkml.org/lkml/2018/1/17/335
[9] https://www.spinics.net/lists/arm-kernel/msg620763.html
[10] https://www.spinics.net/lists/arm-kernel/msg610736.html

Cheers,

Julien

-->

Daniel Thompson (1):
  arm64: alternative: Apply alternatives early in boot process

Julien Thierry (24):
  arm64: Fix HCR.TGE status for NMI contexts
  arm64: Remove unused daif related functions/macros
  arm64: cpufeature: Set SYSREG_GIC_CPUIF as a boot system feature
  arm64: cpufeature: Add cpufeature for IRQ priority masking
  arm/arm64: gic-v3: Add PMR and RPR accessors
  irqchip/gic-v3: Switch to PMR masking before calling IRQ handler
  arm64: ptrace: Provide definitions for PMR values
  arm64: Make PMR part of task context
  arm64: Unmask PMR before going idle
  arm64: kvm: Unmask PMR before entering guest
  arm64: irqflags: Use ICC_PMR_EL1 for interrupt masking
  arm64: daifflags: Include PMR in daifflags restore operations
  arm64: alternative: Allow alternative status checking per cpufeature
  irqchip/gic-v3: Factor group0 detection into functions
  arm64: Switch to PMR masking when starting CPUs
  arm64: gic-v3: Implement arch support for priority masking
  irqchip/gic-v3: Detect if GIC can support pseudo-NMIs
  irqchip/gic-v3: Handle pseudo-NMIs
  irqchip/gic: Add functions to access irq priorities
  irqchip/gic-v3: Allow interrupts to be set as pseudo-NMI
  arm64: Handle serror in NMI context
  arm64: Skip preemption when exiting an NMI
  arm64: Skip irqflags tracing for NMI in IRQs disabled context
  arm64: Enable the support of pseudo-NMIs

 Documentation/admin-guide/kernel-parameters.txt |   6 +
 Documentation/arm64/booting.txt                 |   5 +
 arch/arm/include/asm/arch_gicv3.h               |  33 ++++
 arch/arm64/Kconfig                              |  14 ++
 arch/arm64/include/asm/alternative.h            |   4 +-
 arch/arm64/include/asm/arch_gicv3.h             |  32 +++
 arch/arm64/include/asm/assembler.h              |  10 +-
 arch/arm64/include/asm/cpucaps.h                |   3 +-
 arch/arm64/include/asm/cpufeature.h             |  10 +
 arch/arm64/include/asm/daifflags.h              |  41 ++--
 arch/arm64/include/asm/efi.h                    |   5 +-
 arch/arm64/include/asm/hardirq.h                |  28 +++
 arch/arm64/include/asm/irqflags.h               | 123 +++++++++---
 arch/arm64/include/asm/kvm_host.h               |  12 ++
 arch/arm64/include/asm/processor.h              |   3 +
 arch/arm64/include/asm/ptrace.h                 |  26 ++-
 arch/arm64/kernel/alternative.c                 |  60 +++++-
 arch/arm64/kernel/asm-offsets.c                 |   1 +
 arch/arm64/kernel/cpufeature.c                  |  42 +++-
 arch/arm64/kernel/entry.S                       |  43 ++++
 arch/arm64/kernel/irq.c                         |   3 +
 arch/arm64/kernel/process.c                     |  51 +++++
 arch/arm64/kernel/smp.c                         |  33 ++++
 arch/arm64/kernel/traps.c                       |   8 +-
 arch/arm64/kvm/hyp/switch.c                     |  16 ++
 arch/arm64/mm/proc.S                            |  11 --
 drivers/irqchip/irq-gic-common.c                |  10 +
 drivers/irqchip/irq-gic-common.h                |   2 +
 drivers/irqchip/irq-gic-v3.c                    | 252 +++++++++++++++++++++---
 include/asm-generic/hardirq.h                   |   3 +
 include/linux/hardirq.h                         |   2 +
 31 files changed, 780 insertions(+), 112 deletions(-)

--
1.9.1
