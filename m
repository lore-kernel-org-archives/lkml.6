Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BCBC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068D42084E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 068D42084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbeH2QzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:55:10 -0400
Received: from foss.arm.com ([217.140.101.70]:54364 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728233AbeH2QzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:55:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E37918A;
        Wed, 29 Aug 2018 05:58:19 -0700 (PDT)
Received: from [10.4.13.92] (e112298-lin.Emea.Arm.com [10.4.13.92])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFDD73F5BC;
        Wed, 29 Aug 2018 05:58:17 -0700 (PDT)
Subject: Re: [PATCH v5 00/27] arm64: provide pseudo NMI with GICv3
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
 <20180829113734.evdvs46in6j6xksx@holly.lan>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <4dedbcd1-1919-4643-b152-641ec3367757@arm.com>
Date:   Wed, 29 Aug 2018 13:58:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180829113734.evdvs46in6j6xksx@holly.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/08/18 12:37, Daniel Thompson wrote:
> On Tue, Aug 28, 2018 at 04:51:10PM +0100, Julien Thierry wrote:
>> Hi,
>>
>> This series is a continuation of the work started by Daniel [1]. The goal
>> is to use GICv3 interrupt priorities to simulate an NMI.
>>
>> The patches depend on the core API for NMIs patches [2].
> 
> As before... is there a git tree? With the NMI core API I think I might
> be able to get some of my old pseudo-NMI demos working.
> 

Here is the git:

git://linux-arm.org/linux-jt.git v4.19-nmi-pmu-public

there are also a few patches to make the PMU interrupt into an NMI.

> 
>> To achieve this, set two priorities, one for standard interrupts and
>> another, higher priority, for NMIs. Whenever we want to disable interrupts,
>> we mask the standard priority instead so NMIs can still be raised. Some
>> corner cases though still require to actually mask all interrupts
>> effectively disabling the NMI.
>>
>> Daniel Thompson ran some benchmarks [3] on the previous version showing a
>> small (<1%) performance drop when using interrupt priorities.
> 
> IMHO it is very important to disclose which micro-architecture (in this
> case I think I was using C-A53 and GIC-500) the performance drop is
> observed with.
> 
> We know from both micro- and macro-benchmarks that the performance delta
> is deeply dependant on core implementation. In fact, my own work in this
> area stalled largely because the main device that justified my spending
> working-hours on pseudo-NMI was too badly impacted to see it enabled by
> default.
> 

Yes, you're right, I haven't had many boards to test on, the one I 
tested on had 8 C-A57. Not sure about the GIC (it implemented GICv3 
architecture, that's all I know). I had similar results to yours.

I did not have the opportunity to re-run the benchmarks on real hardware 
for this spin however.

Thanks,

Julien

> 
> Daniel.
> 
> 
>> Currently, only PPIs and SPIs can be set as NMIs. IPIs being currently
>> hardcoded IRQ numbers, there isn't a generic interface to set SGIs as NMI
>> for now. LPIs being controlled by the ITS cannot be delivered as NMI.
>> When an NMI is active on a CPU, no other NMI can be triggered on the CPU.
>>
>> Requirements to use this:
>> - Have GICv3
>> - SCR_EL3.FIQ is set to 1 when linux runs or have single security state
>> - Select Kernel Feature -> Use ICC system registers for IRQ masking
>>
>>
>> * Patches 1 to 3 aim at applying some alternatives early in the boot
>>    process.
>>
>> * Patches 4 to 7 ensure the logic of daifflags remains valid
>>    after arch_local_irq flags use ICC_PMR_EL1.
>>
>> * Patches 8 and 9 clean up GIC current priority definition to make it
>>    easier to introduce a new priority
>>
>> * Patches 10 to 16 prepare arch code for the use of priorities, saving and
>>    restoring ICC_PMR_EL1 appropriately
>>
>> * Patches 17 to 20 add the support to GICv3 driver to use priority masking
>>    if required by the architecture
>>
>> * Patches 21 to 23 make arm64 code use ICC_PMR_EL1 to enable/disable
>>    interrupts, leaving PSR.I as often as possible
>>
>> * Patches 24 to 27 add the support for NMIs to GICv3 driver
>>
>>
>> Changes since V4[4]:
>> * Rebased to v4.19-rc1
>> * Adapted GIC driver to the core NMI API
>> * Added option to disable priority masking on command line
>> * Added Daniel's Tested-by on patches related replacing PSR.I toggling with
>>    PMR masking
>> * Fix scope matching for alternative features.
>> * Spotted some more places using PSR.I or daif and replaced with generic
>>    interrupt functions
>>
>> Changes since V3[5]:
>> * Big refactoring. As suggested by Marc Z., some of the bigger patches
>>    needed to be split into smaller one.
>> * Try to reduce the amount of #ifdef for the new feature by introducing
>>    an individual cpufeature for priority masking
>> * Do not track which alternatives have been applied (was a bit dodgy
>>    anyway), and use an alternative for VHE cpu_enable callback
>> * Fix a build failure with arm by adding the correct RPR accessors
>> * Added Suggested-by tags for changes from comming or inspired by Daniel's
>>    series. Do let me know if you feel I missed something and am not giving
>>    you due credit.
>>
>> Changes since V2[6]:
>> * Series rebase to v4.17-rc6
>> * Adapt pathces 1 and 2 to the rework of cpufeatures framework
>> * Use the group0 detection scheme in the GICv3 driver to identify
>>    the priority view, and drop the use of a fake interrupt
>> * Add the case for a GIC configured in a single security state
>> * Use local_daif_restore instead of local_irq_enable the first time
>>    we enable interrupts after a bp hardening in the handling of a kernel
>>    entry. Otherwise PRS.I remains set...
>>
>> Changes since V1[7]:
>> * Series rebased to v4.15-rc8.
>> * Check for arm64_early_features in this_cpu_has_cap (spotted by Suzuki).
>> * Fix issue where debug exception were not masked when enabling debug in
>>    mdscr_el1.
>>
>> Changes since RFC[8]:
>> * The series was rebased to v4.15-rc2 which implied some changes mainly
>>    related to the work on exception entries and daif flags by James Morse.
>>    - The first patch in the previous series was dropped because no longer
>>      applicable.
>>    - With the semantics James introduced of "inheriting" daif flags,
>>      handling of PMR on exception entry is simplified as PMR is not altered
>>      by taking an exception and already inherited from previous state.
>>    - James pointed out that taking a PseudoNMI before reading the FAR_EL1
>>      register should not be allowed as per the TRM (D10.2.29):
>>      "FAR_EL1 is made UNKNOWN on an exception return from EL1."
>>      So in this submission PSR.I bit is cleared only after FAR_EL1 is read.
>> * For KVM, only deal with PMR unmasking/restoring in common code, and VHE
>>    specific code makes sure PSR.I bit is set when necessary.
>> * When detecting the GIC priority view (patch 5), wait for an actual
>>    interrupt instead of trying only once.
>>
>>
>> [1] http://www.spinics.net/lists/arm-kernel/msg525077.html
>> [2] https://lkml.org/lkml/2018/8/28/661
>> [3] https://lkml.org/lkml/2018/7/20/803
>> [4] https://lkml.org/lkml/2018/7/24/321
>> [5] https://lkml.org/lkml/2018/5/21/276
>> [6] https://lkml.org/lkml/2018/1/17/335
>> [7] https://www.spinics.net/lists/arm-kernel/msg620763.html
>> [8] https://www.spinics.net/lists/arm-kernel/msg610736.html
>>
>> Cheers,
>>
>> Julien
>>
>> -->
>>
>> Daniel Thompson (1):
>>    arm64: alternative: Apply alternatives early in boot process
>>
>> Julien Thierry (26):
>>    arm64: cpufeature: Set SYSREG_GIC_CPUIF as a boot system feature
>>    arm64: cpufeature: Use alternatives for VHE cpu_enable
>>    arm64: daifflags: Use irqflags functions for daifflags
>>    arm64: Use daifflag_restore after bp_hardening
>>    arm64: Delay daif masking for user return
>>    arm64: xen: Use existing helper to check interrupt status
>>    irqchip/gic: Unify GIC priority definitions
>>    irqchip/gic: Lower priority of GIC interrupts
>>    arm64: cpufeature: Add cpufeature for IRQ priority masking
>>    arm64: Make PMR part of task context
>>    arm64: Unmask PMR before going idle
>>    arm/arm64: gic-v3: Add helper functions to manage IRQ priorities
>>    arm64: kvm: Unmask PMR before entering guest
>>    arm64: irqflags: Use ICC_PMR_EL1 for interrupt masking
>>    arm64: daifflags: Include PMR in daifflags restore operations
>>    irqchip/gic-v3: Factor group0 detection into functions
>>    irqchip/gic-v3: Do not overwrite PMR value
>>    irqchip/gic-v3: Remove acknowledge loop
>>    irqchip/gic-v3: Switch to PMR masking after IRQ acknowledge
>>    arm64: Switch to PMR masking when starting CPUs
>>    arm64: Add build option for IRQ masking via priority
>>    arm64: Handle serror in NMI context
>>    irqchip/gic-v3: Detect current view of GIC priorities
>>    irqchip/gic-v3: Add base support for pseudo-NMI
>>    irqchip/gic: Add functions to access irq priorities
>>    irqchip/gic-v3: Allow interrupts to be set as pseudo-NMI
>>
>>   Documentation/admin-guide/kernel-parameters.txt |   3 +
>>   Documentation/arm64/booting.txt                 |   5 +
>>   arch/arm/include/asm/arch_gicv3.h               |  33 +++
>>   arch/arm64/Kconfig                              |  15 ++
>>   arch/arm64/include/asm/alternative.h            |   3 +-
>>   arch/arm64/include/asm/arch_gicv3.h             |  33 +++
>>   arch/arm64/include/asm/assembler.h              |  17 +-
>>   arch/arm64/include/asm/cpucaps.h                |   3 +-
>>   arch/arm64/include/asm/cpufeature.h             |   2 +
>>   arch/arm64/include/asm/daifflags.h              |  29 ++-
>>   arch/arm64/include/asm/efi.h                    |   3 +-
>>   arch/arm64/include/asm/irqflags.h               | 100 +++++++--
>>   arch/arm64/include/asm/kvm_host.h               |  12 +
>>   arch/arm64/include/asm/processor.h              |   1 +
>>   arch/arm64/include/asm/ptrace.h                 |  13 +-
>>   arch/arm64/include/asm/xen/events.h             |   2 +-
>>   arch/arm64/kernel/alternative.c                 |  28 ++-
>>   arch/arm64/kernel/asm-offsets.c                 |   1 +
>>   arch/arm64/kernel/cpufeature.c                  |  51 ++++-
>>   arch/arm64/kernel/entry.S                       |  63 +++++-
>>   arch/arm64/kernel/head.S                        |  35 +++
>>   arch/arm64/kernel/process.c                     |   2 +
>>   arch/arm64/kernel/smp.c                         |  12 +
>>   arch/arm64/kernel/traps.c                       |   8 +-
>>   arch/arm64/kvm/hyp/switch.c                     |  17 ++
>>   arch/arm64/mm/fault.c                           |   5 +-
>>   arch/arm64/mm/proc.S                            |  18 ++
>>   drivers/irqchip/irq-gic-common.c                |  10 +
>>   drivers/irqchip/irq-gic-common.h                |   2 +
>>   drivers/irqchip/irq-gic-v3-its.c                |   2 +-
>>   drivers/irqchip/irq-gic-v3.c                    | 279 +++++++++++++++++++-----
>>   include/linux/irqchip/arm-gic-common.h          |   6 +
>>   include/linux/irqchip/arm-gic.h                 |   5 -
>>   33 files changed, 699 insertions(+), 119 deletions(-)
>>
>> --
>> 1.9.1

-- 
Julien Thierry
