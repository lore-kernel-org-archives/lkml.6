Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA50C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F0920833
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbfAaO7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 09:59:17 -0500
Received: from foss.arm.com ([217.140.101.70]:45446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbfAaO7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 09:59:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0668C80D;
        Thu, 31 Jan 2019 06:59:16 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 38D9A3F59C;
        Thu, 31 Jan 2019 06:59:14 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v10 00/25] arm64: provide pseudo NMI with GICv3
Date:   Thu, 31 Jan 2019 14:58:38 +0000
Message-Id: <1548946743-38979-1-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series is a continuation of the work started by Daniel [1]. The goal
is to use GICv3 interrupt priorities to simulate an NMI.

The patches depend on the core API for NMIs patches [2]. Both series can
be found on this branch:
git clone http://linux-arm.org/linux-jt.git -b v5.0-pseudo-nmi

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
- Select Kernel Feature -> Support for NMI-like interrupts
- Set "irqchip.gicv3_pseudo_nmi" to 1 on the kernel command line


* Patch 1 fixes an existing issue with current NMI contexts in arm64
* Patches 2 and 3 are just a bit of cleanup
* Patch 4 introduces a CPU feature to check if priority masking should be
  used
* Patches 5 and 6 add the support for priority masking in GICv3 driver
* Patches 7 to 13 add the support for priority masking the arch/arm64
  code
* Patches 14 and 15 allow us to apply alternatives earlier in the boot
  process
* Patches 16 to 18 starts the PMR masking on cpu startup and provides
  primitives for arm64 GICv3 driver to perform priority masking
* Patches 19 to 21 Add support for pseudo-NMIs in GICv3 driver
* Patches 22 to 24 Add support for receiving NMIs in arch/arm64
* Patch 25 adds the build config and command line option to enable
  pseudo-NMIs


Changes since v9[4]:
* Add Acked-by and Reviewed-by tags
* Act on various remaks (renames, remove inlines, comments)

[1] http://www.spinics.net/lists/arm-kernel/msg525077.html
[2] https://lkml.org/lkml/2019/1/31/526
[3] https://lkml.org/lkml/2018/7/20/803
[4] https://lkml.org/lkml/2019/1/21/1060

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
  efi: Let architectures decide the flags that should be saved/restored
  arm64: irqflags: Use ICC_PMR_EL1 for interrupt masking
  arm64: daifflags: Include PMR in daifflags restore operations
  arm64: alternative: Allow alternative status checking per cpufeature
  irqchip/gic-v3: Factor group0 detection into functions
  arm64: Switch to PMR masking when starting CPUs
  arm64: gic-v3: Implement arch support for priority masking
  irqchip/gic-v3: Detect if GIC can support pseudo-NMIs
  irqchip/gic-v3: Handle pseudo-NMIs
  irqchip/gic-v3: Allow interrupts to be set as pseudo-NMI
  arm64: Handle serror in NMI context
  arm64: Skip preemption when exiting an NMI
  arm64: Skip irqflags tracing for NMI in IRQs disabled context
  arm64: Enable the support of pseudo-NMIs

 Documentation/admin-guide/kernel-parameters.txt |   5 +
 Documentation/arm64/booting.txt                 |   5 +
 arch/arm/include/asm/arch_gicv3.h               |  33 +++
 arch/arm64/Kconfig                              |  14 ++
 arch/arm64/include/asm/alternative.h            |   4 +-
 arch/arm64/include/asm/arch_gicv3.h             |  32 +++
 arch/arm64/include/asm/assembler.h              |  10 +-
 arch/arm64/include/asm/cpucaps.h                |   3 +-
 arch/arm64/include/asm/cpufeature.h             |  10 +
 arch/arm64/include/asm/daifflags.h              |  60 ++++--
 arch/arm64/include/asm/efi.h                    |  11 +
 arch/arm64/include/asm/hardirq.h                |  31 +++
 arch/arm64/include/asm/irqflags.h               | 100 ++++++---
 arch/arm64/include/asm/kvm_host.h               |  16 ++
 arch/arm64/include/asm/processor.h              |   3 +
 arch/arm64/include/asm/ptrace.h                 |  26 ++-
 arch/arm64/kernel/alternative.c                 |  60 +++++-
 arch/arm64/kernel/asm-offsets.c                 |   1 +
 arch/arm64/kernel/cpufeature.c                  |  41 +++-
 arch/arm64/kernel/entry.S                       |  45 +++-
 arch/arm64/kernel/irq.c                         |   3 +
 arch/arm64/kernel/process.c                     |  51 +++++
 arch/arm64/kernel/smp.c                         |  33 +++
 arch/arm64/kernel/traps.c                       |   8 +-
 arch/arm64/kvm/hyp/switch.c                     |  16 ++
 arch/arm64/mm/proc.S                            |  11 -
 drivers/firmware/efi/runtime-wrappers.c         |  17 +-
 drivers/irqchip/irq-gic-v3.c                    | 265 +++++++++++++++++++++---
 include/linux/efi.h                             |   5 +-
 include/linux/hardirq.h                         |   7 +
 30 files changed, 810 insertions(+), 116 deletions(-)

--
1.9.1
