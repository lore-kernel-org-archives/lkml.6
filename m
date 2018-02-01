Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752803AbeBANYM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 08:24:12 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50214 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752463AbeBANYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 08:24:11 -0500
Subject: Re: [PATCH] irqchip/gic-v3: Use wmb() instead of smb_wmb() in
 gic_raise_softirq()
To: shankerd@codeaurora.org, Will Deacon <will.deacon@arm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vikram Sethi <vikrams@codeaurora.org>,
        Sean Campbell <scampbel@codeaurora.org>,
        Thomas Speier <tspeier@codeaurora.org>
References: <1517443422-30693-1-git-send-email-shankerd@codeaurora.org>
 <20180201103337.GA13705@arm.com>
 <88d418ff-db83-c690-618e-69df3e3bb272@codeaurora.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <5cb5eccf-8edd-bdcc-844a-56bd94355747@arm.com>
Date: Thu, 1 Feb 2018 13:24:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <88d418ff-db83-c690-618e-69df3e3bb272@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/18 12:55, Shanker Donthineni wrote:
> Hi Will, Thanks for your quick reply.
> 
> On 02/01/2018 04:33 AM, Will Deacon wrote:
>> Hi Shanker,
>>
>> On Wed, Jan 31, 2018 at 06:03:42PM -0600, Shanker Donthineni wrote:
>>> A DMB instruction can be used to ensure the relative order of only
>>> memory accesses before and after the barrier. Since writes to system
>>> registers are not memory operations, barrier DMB is not sufficient
>>> for observability of memory accesses that occur before ICC_SGI1R_EL1
>>> writes.
>>>
>>> A DSB instruction ensures that no instructions that appear in program
>>> order after the DSB instruction, can execute until the DSB instruction
>>> has completed.
>>>
>>> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
>>> ---
>>>  drivers/irqchip/irq-gic-v3.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>>> index b56c3e2..980ae8e 100644
>>> --- a/drivers/irqchip/irq-gic-v3.c
>>> +++ b/drivers/irqchip/irq-gic-v3.c
>>> @@ -688,7 +688,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>>>  	 * Ensure that stores to Normal memory are visible to the
>>>  	 * other CPUs before issuing the IPI.
>>>  	 */
>>> -	smp_wmb();
>>> +	wmb();
>>
>> I think this is the right thing to do and the smp_wmb() was accidentally
>> pulled in here as a copy-paste from the GICv2 driver where it is sufficient
>> in practice.
>>
>> Did you spot this by code inspection, or did the DMB actually cause
>> observable failures? (trying to figure out whether or not this need to go
>> to -stable).
>>
> 
> We've inspected the code because kernel was causing failures in scheduler/IPI_RESCHDULE.
> After some time of debugging, we landed in GIC driver and found that the issue was due
> to the DMB barrier. 

OK. I've applied this with a cc: stable and Will's Ack.

> Side note, we're also missing synchronization barriers in GIC driver after writing some
> of the ICC_XXX system registers. I'm planning to post those changes for comments.
> 
> e.g: gic_write_sgi1r(val) and gic_write_eoir(irqnr);

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
