Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967508AbeBNLkA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 06:40:00 -0500
Received: from foss.arm.com ([217.140.101.70]:41110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967398AbeBNLj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 06:39:59 -0500
Subject: Re: [PATCH] irqchip: mips-gic: Avoid spuriously handling masked
 interrupts
To: Matt Redfearn <matt.redfearn@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org
References: <1517849136-29508-1-git-send-email-matt.redfearn@mips.com>
 <bb76fb4e-5e6c-92eb-d79a-96045f74e91b@arm.com>
 <e7ec98be-5a4b-ef54-797d-7e11cf2b14e5@mips.com>
 <5d6348d6-a87f-d3b7-b758-9a2003d9c50e@arm.com>
 <ad04b18e-c05f-0f07-a9ed-a69e20ad4b58@mips.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <892584b8-c61e-e9da-1bd3-5187b8194d84@arm.com>
Date: Wed, 14 Feb 2018 11:39:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <ad04b18e-c05f-0f07-a9ed-a69e20ad4b58@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/18 11:22, Matt Redfearn wrote:
> 
> 
> On 07/02/18 10:41, Marc Zyngier wrote:
>> On 07/02/18 09:44, Matt Redfearn wrote:
>>> Hi Marc,
>>>
>>> On 07/02/18 09:41, Marc Zyngier wrote:
>>>> On 05/02/18 16:45, Matt Redfearn wrote:
>>>>> Commit 7778c4b27cbe ("irqchip: mips-gic: Use pcpu_masks to avoid reading
>>>>> GIC_SH_MASK*") removed the read of the hardware mask register when
>>>>> handling shared interrupts, instead using the driver's shadow pcpu_masks
>>>>> entry as the effective mask. Unfortunately this did not take account of
>>>>> the write to pcpu_masks during gic_shared_irq_domain_map, which
>>>>> effectively unmasks the interrupt early. If an interrupt is asserted,
>>>>> gic_handle_shared_int decodes and processes the interrupt even though it
>>>>> has not yet been unmasked via gic_unmask_irq, which also sets the
>>>>> appropriate bit in pcpu_masks.
>>>>>
>>>>> On the MIPS Boston board, when a console command line of
>>>>> "console=ttyS0,115200n8r" is passed, the modem status IRQ is enabled in
>>>>> the UART, which is immediately raised to the GIC. The interrupt has been
>>>>> mapped, but no handler has yet been registered, nor is it expected to be
>>>>> unmasked. However, the write to pcpu_masks in gic_shared_irq_domain_map
>>>>> has effectively unmasked it, resulting in endless reports of:
>>>>>
>>>>> [    5.058454] irq 13, desc: ffffffff80a7ad80, depth: 1, count: 0, unhandled: 0
>>>>> [    5.062057] ->handle_irq():  ffffffff801b1838,
>>>>> [    5.062175] handle_bad_irq+0x0/0x2c0
>>>>>
>>>>> Where IRQ 13 is the UART interrupt.
>>>>>
>>>>> To fix this, just remove the write to pcpu_masks in
>>>>> gic_shared_irq_domain_map. The existing write in gic_unmask_irq is the
>>>>> correct place for what is now the effective unmasking.
>>>>>
>>>>> Fixes: 7778c4b27cbe ("irqchip: mips-gic: Use pcpu_masks to avoid reading GIC_SH_MASK*")
>>>>> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
>>>>> Reviewed-by: Paul Burton <paul.burton@mips.com>
>>>>>
>>>>> ---
>>>>>
>>>>>    drivers/irqchip/irq-mips-gic.c | 2 --
>>>>>    1 file changed, 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
>>>>> index b2cfc6d66d74..2c3684ba46e5 100644
>>>>> --- a/drivers/irqchip/irq-mips-gic.c
>>>>> +++ b/drivers/irqchip/irq-mips-gic.c
>>>>> @@ -429,8 +429,6 @@ static int gic_shared_irq_domain_map(struct irq_domain *d, unsigned int virq,
>>>>>    	spin_lock_irqsave(&gic_lock, flags);
>>>>>    	write_gic_map_pin(intr, GIC_MAP_PIN_MAP_TO_PIN | shared_cpu_pin);
>>>>>    	write_gic_map_vp(intr, BIT(mips_cm_vp_id(cpu)));
>>>>> -	gic_clear_pcpu_masks(intr);
>>>>> -	set_bit(intr, per_cpu_ptr(pcpu_masks, cpu));
>>>>>    	irq_data_update_effective_affinity(data, cpumask_of(cpu));
>>>>>    	spin_unlock_irqrestore(&gic_lock, flags);
>>>>>    
>>>>>
>>>>
>>>> Does this need to be Cc to stable (since it fixes something that was
>>>> merged in 4.14)?
>>>
>>> Sorry, missed stable off the CC list. Yes, it does indeed need to be
>>> backported. Should I resubmit?
>> No need, I'll add that to the patch.
> 
> Hi Marc,
> Not seen this turn up in tip, just wanted to check you're going to pick 
> it up?

I haven't sent anything to tglx just yet, might do it tomorrow once I
get a chance.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
