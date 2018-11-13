Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A4AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A38223AE
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A38223AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387729AbeKNAm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:42:27 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57352 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbeKNAm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:42:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6344A78;
        Tue, 13 Nov 2018 06:44:00 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FD893F5BD;
        Tue, 13 Nov 2018 06:43:58 -0800 (PST)
Subject: Re: [PATCH v6 00/24] arm64: provide pseudo NMI with GICv3
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <65a51cc2-da68-34d8-e0e1-4f037f459d8d@arm.com>
Date:   Tue, 13 Nov 2018 14:43:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series + the core NMI patches can be fetched from:

git clone http://linux-arm.org/linux-jt.git    v4.20-pseudo-nmi

Thanks,

Julien

On 12/11/18 11:56, Julien Thierry wrote:
> Hi,
> 
> This series is a continuation of the work started by Daniel [1]. The goal
> is to use GICv3 interrupt priorities to simulate an NMI.
> 
> The patches depend on the core API for NMIs patches [2].
> 
> To achieve this, set two priorities, one for standard interrupts and
> another, higher priority, for NMIs. Whenever we want to disable interrupts,
> we mask the standard priority instead so NMIs can still be raised. Some
> corner cases though still require to actually mask all interrupts
> effectively disabling the NMI.
> 
> Daniel Thompson ran some benchmarks [3] on a previous version showing a
> small (<1%) performance drop when using interrupt priorities on Cortex-A53
> and GIC-500.
> 
> Currently, only PPIs and SPIs can be set as NMIs. IPIs being currently
> hardcoded IRQ numbers, there isn't a generic interface to set SGIs as NMI
> for now. LPIs being controlled by the ITS cannot be delivered as NMI.
> When an NMI is active on a CPU, no other NMI can be triggered on the CPU.
> 
> Requirements to use this:
> - Have GICv3
> - SCR_EL3.FIQ is set to 1 when linux runs or have single security state
> - Select Kernel Feature -> Use ICC system registers for IRQ masking
> 
> * Patches 1 and 2 are just a bit of cleanup
> 
> * Patch 3 introduces a CPU feature to check if priority masking should be
>    used
> 
> * Patches 4 and 5 add the support for priority masking in GICv3 driver
> 
> * Patches 6 to 11 add the support for priority masking the arch/arm64
>    code
> 
> * Patches 12 and 13 allow us to apply alternatives earlier in the boot
>    process
> 
> * Patches 14 to 16 starts the PMR masking on cpu startup and provides
>    primitives for arm64 GICv3 driver to perform priority masking
> 
> * Patches 17 to 20 Add support for pseudo-NMIs in GICv3 driver
> 
> * Patches 21 to 23 Add support for receiving NMIs in arch/arm64
> 
> * Patch 24 adds the build config and command line option to enable
>    pseudo-NMIs
> 
> Changes since v5[4]:
> * Rebased on v4.20-rc2
> * Reorganized patches again
> * Renamed compile option + PMR values defines
> * Write PMR enablement for cpu startup in C
> * Fix wrong array size passed to __apply_alternatives
> * Do not touch PMR in pt_regs when not using irq masking
> * Remove ISB between PMR and IAR -> turns out it is not needed
> * Simplify irqflags code after introducing PMR in it
> * Use ref count API to track PPIs set as NMI
> * Simplify NMI exit path
> 
> Changes since V4[5]:
> * Rebased to v4.19-rc1
> * Adapted GIC driver to the core NMI API
> * Added option to disable priority masking on command line
> * Added Daniel's Tested-by on patches related replacing PSR.I toggling with
>    PMR masking
> * Fix scope matching for alternative features.
> * Spotted some more places using PSR.I or daif and replaced with generic
>    interrupt functions
> 
> Changes since V3[6]:
> * Big refactoring. As suggested by Marc Z., some of the bigger patches
>    needed to be split into smaller one.
> * Try to reduce the amount of #ifdef for the new feature by introducing
>    an individual cpufeature for priority masking
> * Do not track which alternatives have been applied (was a bit dodgy
>    anyway), and use an alternative for VHE cpu_enable callback
> * Fix a build failure with arm by adding the correct RPR accessors
> * Added Suggested-by tags for changes from comming or inspired by Daniel's
>    series. Do let me know if you feel I missed something and am not giving
>    you due credit.
> 
> Changes since V2[7]:
> * Series rebase to v4.17-rc6
> * Adapt pathces 1 and 2 to the rework of cpufeatures framework
> * Use the group0 detection scheme in the GICv3 driver to identify
>    the priority view, and drop the use of a fake interrupt
> * Add the case for a GIC configured in a single security state
> * Use local_daif_restore instead of local_irq_enable the first time
>    we enable interrupts after a bp hardening in the handling of a kernel
>    entry. Otherwise PRS.I remains set...
> 
> Changes since V1[8]:
> * Series rebased to v4.15-rc8.
> * Check for arm64_early_features in this_cpu_has_cap (spotted by Suzuki).
> * Fix issue where debug exception were not masked when enabling debug in
>    mdscr_el1.
> 
> Changes since RFC[9]:
> * The series was rebased to v4.15-rc2 which implied some changes mainly
>    related to the work on exception entries and daif flags by James Morse.
>    - The first patch in the previous series was dropped because no longer
>      applicable.
>    - With the semantics James introduced of "inheriting" daif flags,
>      handling of PMR on exception entry is simplified as PMR is not altered
>      by taking an exception and already inherited from previous state.
>    - James pointed out that taking a PseudoNMI before reading the FAR_EL1
>      register should not be allowed as per the TRM (D10.2.29):
>      "FAR_EL1 is made UNKNOWN on an exception return from EL1."
>      So in this submission PSR.I bit is cleared only after FAR_EL1 is read.
> * For KVM, only deal with PMR unmasking/restoring in common code, and VHE
>    specific code makes sure PSR.I bit is set when necessary.
> * When detecting the GIC priority view (patch 5), wait for an actual
>    interrupt instead of trying only once.
> 
> 
> [1] http://www.spinics.net/lists/arm-kernel/msg525077.html
> [2] https://lkml.org/lkml/2018/11/12/2113
> [3] https://lkml.org/lkml/2018/7/20/803
> [4] https://lkml.org/lkml/2018/8/28/693
> [5] https://lkml.org/lkml/2018/7/24/321
> [6] https://lkml.org/lkml/2018/5/21/276
> [7] https://lkml.org/lkml/2018/1/17/335
> [8] https://www.spinics.net/lists/arm-kernel/msg620763.html
> [9] https://www.spinics.net/lists/arm-kernel/msg610736.html
> 
> Cheers,
> 
> Julien
> 
> -->
> 
> Daniel Thompson (1):
>    arm64: alternative: Apply alternatives early in boot process
> 
> Julien Thierry (23):
>    arm64: Remove unused daif related functions/macros
>    arm64: cpufeature: Set SYSREG_GIC_CPUIF as a boot system feature
>    arm64: cpufeature: Add cpufeature for IRQ priority masking
>    arm/arm64: gic-v3: Add PMR and RPR accessors
>    irqchip/gic-v3: Switch to PMR masking before calling IRQ handler
>    arm64: ptrace: Provide definitions for PMR values
>    arm64: Make PMR part of task context
>    arm64: Unmask PMR before going idle
>    arm64: kvm: Unmask PMR before entering guest
>    arm64: irqflags: Use ICC_PMR_EL1 for interrupt masking
>    arm64: daifflags: Include PMR in daifflags restore operations
>    arm64: alternative: Allow alternative status checking per cpufeature
>    irqchip/gic-v3: Factor group0 detection into functions
>    arm64: Switch to PMR masking when starting CPUs
>    arm64: gic-v3: Implement arch support for priority masking
>    irqchip/gic-v3: Detect if GIC can support pseudo-NMIs
>    irqchip/gic-v3: Handle pseudo-NMIs
>    irqchip/gic: Add functions to access irq priorities
>    irqchip/gic-v3: Allow interrupts to be set as pseudo-NMI
>    arm64: Handle serror in NMI context
>    arm64: Skip preemption when exiting an NMI
>    arm64: Skip irqflags tracing for NMI in IRQs disabled context
>    arm64: Enable the support of pseudo-NMIs
> 
>   Documentation/admin-guide/kernel-parameters.txt |   6 +
>   Documentation/arm64/booting.txt                 |   5 +
>   arch/arm/include/asm/arch_gicv3.h               |  33 ++++
>   arch/arm64/Kconfig                              |  14 ++
>   arch/arm64/include/asm/alternative.h            |   4 +-
>   arch/arm64/include/asm/arch_gicv3.h             |  32 +++
>   arch/arm64/include/asm/assembler.h              |  10 +-
>   arch/arm64/include/asm/cpucaps.h                |   3 +-
>   arch/arm64/include/asm/cpufeature.h             |  10 +
>   arch/arm64/include/asm/daifflags.h              |  20 +-
>   arch/arm64/include/asm/efi.h                    |   3 +-
>   arch/arm64/include/asm/irqflags.h               | 132 ++++++++++---
>   arch/arm64/include/asm/kvm_host.h               |  12 ++
>   arch/arm64/include/asm/processor.h              |   3 +
>   arch/arm64/include/asm/ptrace.h                 |  20 +-
>   arch/arm64/kernel/alternative.c                 |  60 +++++-
>   arch/arm64/kernel/asm-offsets.c                 |   1 +
>   arch/arm64/kernel/cpufeature.c                  |  42 +++-
>   arch/arm64/kernel/entry.S                       |  40 ++++
>   arch/arm64/kernel/process.c                     |   6 +
>   arch/arm64/kernel/smp.c                         |  34 ++++
>   arch/arm64/kernel/traps.c                       |   8 +-
>   arch/arm64/kvm/hyp/switch.c                     |  16 ++
>   arch/arm64/mm/proc.S                            |  18 ++
>   drivers/irqchip/irq-gic-common.c                |  10 +
>   drivers/irqchip/irq-gic-common.h                |   2 +
>   drivers/irqchip/irq-gic-v3.c                    | 250 +++++++++++++++++++++---
>   include/linux/irqchip/arm-gic-common.h          |   2 +-
>   28 files changed, 695 insertions(+), 101 deletions(-)
> 
> --
> 1.9.1
> 

-- 
Julien Thierry
