Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46638C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C41920861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbfAUIp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:45:26 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56820 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728991AbfAUIpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:45:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 731E080D;
        Mon, 21 Jan 2019 00:45:25 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E9113F614;
        Mon, 21 Jan 2019 00:45:23 -0800 (PST)
Subject: Re: [PATCH v8 12/26] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     mark.rutland@arm.com, daniel.thompson@linaro.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        marc.zyngier@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, christoffer.dall@arm.com,
        james.morse@arm.com, Oleg Nesterov <oleg@redhat.com>,
        joel@joelfernandes.org, linux-arm-kernel@lists.infradead.org
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
 <1546956464-48825-13-git-send-email-julien.thierry@arm.com>
 <20190118160920.GF118707@arrakis.emea.arm.com>
 <0af2d75e-9a61-e53b-b2df-3d08d3f63d9c@arm.com>
 <20190118173002.GA247921@arrakis.emea.arm.com>
 <20190118173309.GB247921@arrakis.emea.arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <c32da8b4-0c60-c02c-aec3-a122fea8e78f@arm.com>
Date:   Mon, 21 Jan 2019 08:45:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190118173309.GB247921@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/01/2019 17:33, Catalin Marinas wrote:
> On Fri, Jan 18, 2019 at 05:30:02PM +0000, Catalin Marinas wrote:
>> On Fri, Jan 18, 2019 at 04:57:32PM +0000, Julien Thierry wrote:
>>> On 18/01/2019 16:09, Catalin Marinas wrote:
>>>> On Tue, Jan 08, 2019 at 02:07:30PM +0000, Julien Thierry wrote:
>>>>> +	asm volatile(ALTERNATIVE(
>>>>> +			"nop",
>>>>> +			"mrs_s	%0, " __stringify(SYS_ICC_PMR_EL1),
>>>>> +			ARM64_HAS_IRQ_PRIO_MASKING)
>>>>> +		: "=&r" (pmr)
>>>>>  		:
>>>>>  		: "memory");
>>>>> +
>>>>> +	return _get_irqflags(daif_bits, pmr);
>>>>> +}
>>>>
>>>> I find this confusing spread over two inline asm statements. IIUC, you
>>>> want something like below (it could be written as inline asm but I need
>>>> to understand it first):
>>>>
>>>> 	daif_bits = read_sysreg(daif);
>>>>
>>>> 	if (system_uses_irq_prio_masking()) {
>>>> 		pmr = read_gicreg(ICC_PMR_EL1);
>>>> 		flags = pmr & ~(daif_bits & PSR_I_BIT);
>>>> 	} else {
>>>> 		flags = daif_bits;
>>>> 	}
>>>>
>>>> 	return flags;
>>>>
>>>> In the case where the interrupts are disabled at the PSR level, is the
>>>> PMR value still relevant? Could we just return the GIC_PRIO_IRQOFF?
>>>> Something like:
>>>>
>>>> 	flags = read_sysreg(daif);
>>>>
>>>> 	if (system_uses_irq_prio_masking())
>>>> 		flags = flags & PSR_I_BIT ?
>>>> 			GIC_PRIO_IRQOFF : read_gicreg(ICC_PMR_EL1);
>>>>
>>>
>>> You're right, returning GIC_PRIO_IRQOFF should be good enough (it is
>>> actually what happens in this version because GIC_PRIO_IRQOFF ==
>>> GIC_PRIO_IRQON & ~PSR_I_BIT happens to be true).
>>
>> This wasn't entirely clear to me, I got confused by:
>>
>> +       BUILD_BUG_ON(GIC_PRIO_IRQOFF < (GIC_PRIO_IRQON & ~PSR_I_BIT));  \
>>
>> and I thought there isn't necessarily an equality between the two.
>>
>>> Your suggestion would
>>> make things easier to reason about. Maybe something like:
>>>
>>>
>>> static inline unsigned long arch_local_save_flags(void)
>>> {
>>> 	unsigned long daif_bits;
>>> 	unsigned long prio_off = GIC_PRIO_IRQOFF;
>>>
>>> 	daif_bits = read_sysreg(daif);
>>>
>>> 	asm volatile(ALTERNATIVE(
>>> 		"mov	%0, %1\n"
>>> 		"nop\n"
>>> 		"nop",
>>> 		"mrs	%0, SYS_ICC_PMR_EL1\n"
>>> 		"ands	%1, %1, PSR_I_BIT\n"
>>> 		"csel	%0, %0, %2, eq")
>>> 	: "=&r" (flags)
>>> 	: "r" (daif_bits), "r" (prio_off)
>>> 	: "memory");
>>>
>>> 	return flags;
>>> }
>>
>> It looks fine. If you turn the BUILD_BUG_ON into a !=, you could
>> probably simplify the asm a bit (though the number of instructions
>> generated would probably be the same). Untested:
>>
>> static inline unsigned long arch_local_save_flags(void)
>> {
>> 	unsigned long flags;
>>
>> 	flags = read_sysreg(daif);
>>
>> 	asm volatile(ALTERNATIVE(
>> 		"nop",
>> 		"bic	%0, %1, %2")
>> 	: "=&r" (flags)
>> 	: "r" (flags & PSR_I_BIT), "r" (GIC_PRIO_IRQOFF)
>> 	: "memory");
> 
> Ah, I missed a read from SYS_ICC_PMR_EL1 here. Anyway, the idea was that
> you don't need to set prio_off to a variable, just pass "r" (constant)
> here and the compiler does the trick.
> 

I see, thanks. I'll avoid that superfluous variable.

Thanks,

-- 
Julien Thierry
