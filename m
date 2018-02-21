Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754571AbeBUQvs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:51:48 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58210 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754327AbeBUQvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:51:43 -0500
Subject: Re: [PATCH v3] arm64: Add support for new control bits CTR_EL0.DIC
 and CTR_EL0.IDC
To: shankerd@codeaurora.org, Mark Rutland <mark.rutland@arm.com>
Cc: Philip Elcan <pelcan@codeaurora.org>,
        Vikram Sethi <vikrams@codeaurora.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <1519220946-13901-1-git-send-email-shankerd@codeaurora.org>
 <20180221150929.hkvtwu4fgfeis5cy@salmiak>
 <5be4684b-e2d8-1b3b-4c96-03c7dae0b619@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <0eb2d23b-cf96-c7ff-9820-16ed113f4862@arm.com>
Date: Wed, 21 Feb 2018 16:51:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5be4684b-e2d8-1b3b-4c96-03c7dae0b619@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/18 16:14, Shanker Donthineni wrote:
[...]
>>> @@ -1100,6 +1114,20 @@ static int cpu_copy_el2regs(void *__unused)
>>>   		.enable = cpu_clear_disr,
>>>   	},
>>>   #endif /* CONFIG_ARM64_RAS_EXTN */
>>> +#ifdef CONFIG_ARM64_SKIP_CACHE_POU
>>> +	{
>>> +		.desc = "DCache clean to POU",
>>
>> This description is confusing, and sounds like it's describing DC CVAU, rather
>> than the ability to ellide it. How about:
>>
> 
> Sure, I'll take your suggestion.

Can we at least spell "elision" correctly please? ;)

Personally I read DIC and IDC as "D-cache to I-cache coherency" and 
"I-cache to D-cache coherency" respectively (just my interpretation, 
I've not looked into the spec work for any hints of rationale), but out 
loud those do sound so poorly-defined that keeping things in terms of 
the required maintenance probably is better.

>> 		.desc = "D-cache maintenance ellision (IDC)"
>>
>>> +		.capability = ARM64_HAS_CACHE_IDC,
>>> +		.def_scope = SCOPE_SYSTEM,
>>> +		.matches = has_cache_idc,
>>> +	},
>>> +	{
>>> +		.desc = "ICache invalidation to POU",
>>
>> ... and correspondingly:
>>
>> 		.desc = "I-cache maintenance ellision (DIC)"
>>
>>> +		.capability = ARM64_HAS_CACHE_DIC,
>>> +		.def_scope = SCOPE_SYSTEM,
>>> +		.matches = has_cache_dic,
>>> +	},
>>> +#endif /* CONFIG_ARM64_CACHE_DIC */
>>>   	{},
>>>   };
[...]
>>> +alternative_if ARM64_HAS_CACHE_DIC
>>> +	isb
>>
>> Why have we gained an ISB here if DIC is set?
>>
> 
> I believe synchronization barrier (ISB) is required here to support self-modifying/jump-labels
> code.
>    
>> This is for a user address, and I can't see why DIC would imply we need an
>> extra ISB kernel-side.
>>
> 
> This is for user and kernel addresses, alternatives and jumplabel patching logic
> calls flush_icache_range().

There's an ISB hidden in invalidate_icache_by_line(), so it probably 
would be unsafe to start implicitly skipping that.

>>> +	b	8f
>>> +alternative_else_nop_endif
>>>   	invalidate_icache_by_line x0, x1, x2, x3, 9f
>>> -	mov	x0, #0
>>> +8:	mov	x0, #0
>>>   1:
>>>   	uaccess_ttbr0_disable x1, x2
>>>   	ret
>>> @@ -80,6 +87,12 @@ ENDPROC(__flush_cache_user_range)
>>>    *	- end     - virtual end address of region
>>>    */
>>>   ENTRY(invalidate_icache_range)
>>> +alternative_if ARM64_HAS_CACHE_DIC
>>> +	mov	x0, xzr
>>> +	dsb	ish
>>
>> Do we actually need a DSB in this case?
>>
> 
> I'll remove if everyone agree.
> 
> Will, Can you comment on this?
> 
>> As-is, this function *only* invalidates the I-cache, so we already assume that
>> the data is visible at the PoU at this point. I don't see what extra gaurantee
>> we'd need the DSB for.

If so, then ditto for the existing invalidate_icache_by_line() code 
presumably.

Robin.
