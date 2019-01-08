Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEECEC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 803E3206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbfAHR7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:59:09 -0500
Received: from foss.arm.com ([217.140.101.70]:57370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729420AbfAHR7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:59:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CD16A78;
        Tue,  8 Jan 2019 09:59:03 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DCD33F5AF;
        Tue,  8 Jan 2019 09:59:01 -0800 (PST)
Subject: Re: [PATCH v8 12/26] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
To:     Dave Martin <Dave.Martin@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     mark.rutland@arm.com, daniel.thompson@linaro.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, christoffer.dall@arm.com,
        james.morse@arm.com, Oleg Nesterov <oleg@redhat.com>,
        joel@joelfernandes.org, linux-arm-kernel@lists.infradead.org
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
 <1546956464-48825-13-git-send-email-julien.thierry@arm.com>
 <20190108153957.GA5840@e103592.cambridge.arm.com>
 <8cae8016-d2c7-3c86-9832-f4278d42ea21@arm.com>
 <20190108164510.GB5840@e103592.cambridge.arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <699ebbc0-fff9-0a1c-9dfa-4b7da078904c@arm.com>
Date:   Tue, 8 Jan 2019 17:58:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190108164510.GB5840@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/01/2019 16:45, Dave Martin wrote:
> On Tue, Jan 08, 2019 at 03:51:18PM +0000, Marc Zyngier wrote:
>> On 08/01/2019 15:40, Dave Martin wrote:
>>> On Tue, Jan 08, 2019 at 02:07:30PM +0000, Julien Thierry wrote:
>>>> Instead disabling interrupts by setting the PSR.I bit, use a priority
>>>> higher than the one used for interrupts to mask them via PMR.
>>>>
>>>> When using PMR to disable interrupts, the value of PMR will be used
>>>> instead of PSR.[DAIF] for the irqflags.
>>>>
>>>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>>>> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>> Cc: Will Deacon <will.deacon@arm.com>
>>>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>>> Cc: Oleg Nesterov <oleg@redhat.com>
>>>> ---
>>>>  arch/arm64/include/asm/efi.h      |  11 ++++
>>>>  arch/arm64/include/asm/irqflags.h | 123 +++++++++++++++++++++++++++++---------
>>>>  2 files changed, 106 insertions(+), 28 deletions(-)
>>>
>>> [...]
>>>
>>>> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
>>>> index 24692ed..fa3b06f 100644
>>>> --- a/arch/arm64/include/asm/irqflags.h
>>>> +++ b/arch/arm64/include/asm/irqflags.h
>>>> @@ -18,7 +18,9 @@
>>>
>>> [...]
>>>
>>>>  static inline void arch_local_irq_enable(void)
>>>>  {
>>>> -	asm volatile(
>>>> -		"msr	daifclr, #2		// arch_local_irq_enable"
>>>> -		:
>>>> +	unsigned long unmasked = GIC_PRIO_IRQON;
>>>> +
>>>> +	asm volatile(ALTERNATIVE(
>>>> +		"msr	daifclr, #2		// arch_local_irq_enable\n"
>>>> +		"nop",
>>>> +		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
>>>> +		"dsb	sy",
>>>
>>> I'm still not convinced these dsbs are needed.
>>>
>>> Without the dsb, we are probably not guaranteed to take a pending
>>> interrupt _immediately_ on unmasking, but I'm not sure that's a
>>> problem.
>>>
>>> What goes wrong if we omit them?
>>
>> Then the GIC doesn't know it can now deliver interrupts of a lower
>> priority. Only a dsb can guarantee that the GIC's view of PMR will get
>> updated.
>>
>> See 9.1.6 (Observability of the effects of accesses to the GIC
>> registers), which states:
>>
>> <quote>
>> Architectural execution of a DSB instruction guarantees that
>> — The last value written to ICC_PMR_EL1 or GICC_PMR is observed by the
>> associated Redistributor.
>> </quote>
>>
>> So yes, DSB is required.
> 
> But it says neither what is means for the PMR write to be "observed by
> the redistributor", nor whether the DSB is required for the
> redistributor to observe the write at all.  (So, is an implementation
> allowed to cached in the CPU interface indefinitely until forcibly
> flushed to the redistributor by a DSB, and in any case can the write's
> reaching the distributor in finite time or not have any effect that we
> care about in this case?).
> 
> 
> My reason for querying this is that temporary local masking of classes
> of interrupts seems an obvious use case for the PMR, and the DSB
> requirement flies rather in the face of this.
> 
> 
> Have we seen hardware where interrupts may stall forever upstream of the
> CPU interface after a PMR write, until a dsb is executed by the CPU?
> 

I don't have too much GICv3 hardware at hand but the one I tested
*seems* to work without the DSB. But of course this does not mean it is
correct even on that hardware.

As you said it is not clear what is meant by "observed by the
redistributor", it can mean that the redistributor is allowed to stop
forwarding interrupts of lower priority or it can mean that it always
forwards them as the CPU interface is required to prevent masked
priority interrupts to be signaled to the CPU. The hardware I'm using
might be in the latter case... or not...



> If so that is sad, but I guess we have to live with it.
> 
> Also, is it ever important in Linux that a pending interrupt be taken
> immediately upon unmasking (and how do we know that said interrupt is
> pending)?  If not, we don't care precisely when such interrupts are
> pended to the PE, just that such an interrupt cannot be taken before
> the PMR write that unmasks it.  It would be insane for the self-
> synchronization of PMR writes to lack this guarantee (and a DSB after
> the PMR write would do no good anyway in that case).
> 

The first thing that comes to mind for this would be the RT world, I'm
not sure it would it would be nice to have interrupts "actually
unmasked" at some random time in the future.

Otherwise, aren't there some parts of the kernel that expect being able
to take interrupts? (memory allocation comes to mind). What happens if
the interrupt might not happen?

Also, code that does:

while (!poll_update_from_irq()) {
	local_irq_disable();

	// do stuff

	local_irq_enable();
}

Might never see interrupts. It is not clear to me whether that is the
case for the loop in do_idle() and the check for need_resched().

I don't know if drivers might have such code patterns.

Cheers,

-- 
Julien Thierry
