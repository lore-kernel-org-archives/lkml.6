Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934245AbeB1RpV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:45:21 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55094 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932656AbeB1RpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 12:45:18 -0500
Subject: Re: [PATCH] arm64: kdump: fix interrupt handling done during
 machine_crash_shutdown
To: Mark Rutland <mark.rutland@arm.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        takahiro.akashi@linaro.org, hoeun.ryu@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nadavh@marvell.com, mw@semihalf.com
References: <1519837260-30662-1-git-send-email-jaz@semihalf.com>
 <20180228171647.6t4dabntujcb5kon@lakrids.cambridge.arm.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <ba0c6804-51a3-f36e-a67e-20ce84961451@arm.com>
Date: Wed, 28 Feb 2018 17:45:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228171647.6t4dabntujcb5kon@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/18 17:16, Mark Rutland wrote:
> [Adding MarcZ]
> 
> On Wed, Feb 28, 2018 at 06:01:00PM +0100, Grzegorz Jaszczyk wrote:
>> Hitherto during machine_kexec_mask_interrupts there was an attempt to
>> remove active state using irq_set_irqchip_state() routine and only if it
>> failed, the attempt to EOI the interrupt was made. Nevertheless relaying
>> on return value from irq_set_irqchip_state inside
>> machine_kexec_mask_interrupts is incorrect - it only returns the status
>> of the routine but doesn't provide information if the interrupt was
>> deactivated correctly or not. 
> 
> This doesn't sound right. The return value of irq_set_irqchip_state() is
> certainly supposed to indicate that it did what it was asked to (i.e.
> correctly (de)activated the interrupt).
> 
> IIUC, you're saying that there's a problem whereby:
> 
> (a) irq_set_irqchip_state() returns succesfully, but:
> 
> (b) irq_set_irqchip_state() does not alter the interrupt state to that
>     requested.
> 
> ... which sounds like a bug. 
> 
> When does this happen, exactly?
> 
> Thanks,
> Mark.
> 
>> Therefore the irq_eoi wasn't call even if the interrupt remained
>> active.
>>
>> To determine the sate correctly the irq_get_irqchip_state() could be
>> used but according to the ARM Generic Interrupt Controller Architecture
>> Spec, non-secure reading from GICD_ISACTIVERn/GICD_ICACTIVERn can be not
>> permitted (depending on NS_access setting of Non-secure Access Control
>> Registers, a.k.a. GICD_NSACRn). What is more interesting GICD_NSACRn
>> is optional Secure register.

All the Linux interrupts are either non-secure, or accessible using
non-secure accessors. I'm afraid you're misunderstanding a thing or two
about the architecture.

>>
>> Moreover de-activating the interrupt via GICD_ISACTIVERn register
>> (regardless of the possibility of checking status or not) seems to not
>> do the job, when the GIC Distributor is configured to forward the
>> interrupts to the CPU interfaces.

Then you seem to have really buggy HW.

>>
>> Because of all above the attempt to deactivate interrupts via
>> irq_set_irqchip_state() is removed in this patch. Instead the irq_eoi is
>> called whenever the interrupt is in progress(irqd_irq_inprogress).
>>
>> Before this patch the kdump triggered from interrupt context worked
>> correctly by accident when the GIC was configured with
>> GIC_CPU_CTRL_EOImodeNS == 1 (supports_deactivate == true). In mentioned
>> mode GIC_CPU_EOI has priority drop functionality only and
>> GIC_CPU_DEACTIVATE is used for interrupt deactivation. Also the
>> gic_handle_irq behaviour is a bit different in mentioned mode and
>> performs write to the GIC_CPU_EOI which causes the priority drop to the
>> idle priority. So even if the irq_eoi wasn't called during
>> machine_kexec_mask_interrupts, the interrupts of the crashdump kernel
>> was handled due to interrupt preemption (since the priority of still
>> active interrupt was dropped to idle priority).
>>
>> Nevertheless when the kdump was triggered from interrupt context while
>> the GIC was configured to work in GIC_CPU_CTRL_EOImodeNS == 0, the
>> crashdump kernel hang in early stage due to lack of timer interrupt
>> arrival.
>>
>> After this fix the kdump behaves correctly when triggered from interrupt
>> context independently of GIC_CPU_CTRL_EOImodeNS configuration.
>>
>> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
>> ---
>>  arch/arm64/kernel/machine_kexec.c | 10 +---------
>>  1 file changed, 1 insertion(+), 9 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
>> index f76ea92..30ad183 100644
>> --- a/arch/arm64/kernel/machine_kexec.c
>> +++ b/arch/arm64/kernel/machine_kexec.c
>> @@ -220,20 +220,12 @@ static void machine_kexec_mask_interrupts(void)
>>  
>>  	for_each_irq_desc(i, desc) {
>>  		struct irq_chip *chip;
>> -		int ret;
>>  
>>  		chip = irq_desc_get_chip(desc);
>>  		if (!chip)
>>  			continue;
>>  
>> -		/*
>> -		 * First try to remove the active state. If this
>> -		 * fails, try to EOI the interrupt.
>> -		 */
>> -		ret = irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);
>> -
>> -		if (ret && irqd_irq_inprogress(&desc->irq_data) &&
>> -		    chip->irq_eoi)
>> +		if (irqd_irq_inprogress(&desc->irq_data) && chip->irq_eoi)

This really doesn't make any sense. Either you've successfully
deactivated the interrupt, or you haven't. Doing both is a terrible
violation of the GIC architecture, don't do that. There is also 0
guarantee that the interrupt was active on the CPU you're currently
running. If you activated it on another CPU, good luck.

To echo to Mark's concerns, you don't explain the root cause: Why is
irq_set_irqchip_state silently failing? With what IRQ type? On what GIC
implementation?

>>  			chip->irq_eoi(&desc->irq_data);
>>  
>>  		if (chip->irq_mask)

As it stands, this patch breaks more things than it should. I'd suggest
you start from the beginning and explain the issue you're facing.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
