Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EDDC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24692183F
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfAWI4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 03:56:25 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37626 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbfAWI4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 03:56:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E81F6A78;
        Wed, 23 Jan 2019 00:56:23 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 249EB3F6A8;
        Wed, 23 Jan 2019 00:56:22 -0800 (PST)
Subject: Re: [PATCH v9 09/26] arm64: Unmask PMR before going idle
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoffer Dall <christoffer.dall@arm.com>,
        James Morse <james.morse@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>
References: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
 <1548084825-8803-10-git-send-email-julien.thierry@arm.com>
 <CAKv+Gu8qL1BWE-xXA+X0wrORBpv+tVKKOnN0Dv+FGQFZGWUB-w@mail.gmail.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <6d9cd0ea-d487-bfb0-0461-1e0fcd24a7e1@arm.com>
Date:   Wed, 23 Jan 2019 08:56:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8qL1BWE-xXA+X0wrORBpv+tVKKOnN0Dv+FGQFZGWUB-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/01/2019 20:18, Ard Biesheuvel wrote:
> On Mon, 21 Jan 2019 at 16:36, Julien Thierry <julien.thierry@arm.com> wrote:
>>
>> CPU does not received signals for interrupts with a priority masked by
>> ICC_PMR_EL1. This means the CPU might not come back from a WFI
>> instruction.
>>
>> Make sure ICC_PMR_EL1 does not mask interrupts when doing a WFI.
>>
>> Since the logic of cpu_do_idle is becoming a bit more complex than just
>> two instructions, lets turn it from ASM to C.
>>
>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> ---
>>  arch/arm64/kernel/process.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>  arch/arm64/mm/proc.S        | 11 -----------
>>  2 files changed, 45 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
>> index 6d410fc..f05b63f 100644
>> --- a/arch/arm64/kernel/process.c
>> +++ b/arch/arm64/kernel/process.c
>> @@ -51,6 +51,7 @@
>>  #include <linux/thread_info.h>
>>
>>  #include <asm/alternative.h>
>> +#include <asm/arch_gicv3.h>
>>  #include <asm/compat.h>
>>  #include <asm/cacheflush.h>
>>  #include <asm/exec.h>
>> @@ -74,6 +75,50 @@
>>
>>  void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
>>
>> +static inline void __cpu_do_idle(void)
>> +{
>> +       dsb(sy);
>> +       wfi();
>> +}
>> +
>> +static inline void __cpu_do_idle_irqprio(void)
> 
> Can we drop the 'inline's from all the function definitions in .c
> files? (not just in this patch)
> We tend to leave that to the compiler.
> 

Sure, I guess cpu_do_idle() isn't a performance critical path anyway.

Unless anyone argues against it, I'll drop these inlines for the next
version.

Thanks,

Julien

>> +{
>> +       unsigned long pmr;
>> +       unsigned long daif_bits;
>> +
>> +       daif_bits = read_sysreg(daif);
>> +       write_sysreg(daif_bits | PSR_I_BIT, daif);
>> +
>> +       /*
>> +        * Unmask PMR before going idle to make sure interrupts can
>> +        * be raised.
>> +        */
>> +       pmr = gic_read_pmr();
>> +       gic_write_pmr(GIC_PRIO_IRQON);
>> +
>> +       __cpu_do_idle();
>> +
>> +       gic_write_pmr(pmr);
>> +       write_sysreg(daif_bits, daif);
>> +}
>> +
>> +/*
>> + *     cpu_do_idle()
>> + *
>> + *     Idle the processor (wait for interrupt).
>> + *
>> + *     If the CPU supports priority masking we must do additional work to
>> + *     ensure that interrupts are not masked at the PMR (because the core will
>> + *     not wake up if we block the wake up signal in the interrupt controller).
>> + */
>> +void cpu_do_idle(void)
>> +{
>> +       if (system_uses_irq_prio_masking())
>> +               __cpu_do_idle_irqprio();
>> +       else
>> +               __cpu_do_idle();
>> +}
>> +
>>  /*
>>   * This is our default idle handler.
>>   */
>> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
>> index 73886a5..3ea4f3b 100644
>> --- a/arch/arm64/mm/proc.S
>> +++ b/arch/arm64/mm/proc.S
>> @@ -55,17 +55,6 @@
>>
>>  #define MAIR(attr, mt) ((attr) << ((mt) * 8))
>>
>> -/*
>> - *     cpu_do_idle()
>> - *
>> - *     Idle the processor (wait for interrupt).
>> - */
>> -ENTRY(cpu_do_idle)
>> -       dsb     sy                              // WFI may enter a low-power mode
>> -       wfi
>> -       ret
>> -ENDPROC(cpu_do_idle)
>> -
>>  #ifdef CONFIG_CPU_PM
>>  /**
>>   * cpu_do_suspend - save CPU registers context
>> --
>> 1.9.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Julien Thierry
