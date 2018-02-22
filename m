Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933260AbeBVQxQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 11:53:16 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45014 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933139AbeBVQxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 11:53:15 -0500
Subject: Re: [PATCH v4] arm64: Add support for new control bits CTR_EL0.DIC
 and CTR_EL0.IDC
To: Mark Rutland <mark.rutland@arm.com>
Cc: Shanker Donthineni <shankerd@codeaurora.org>,
        Philip Elcan <pelcan@codeaurora.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <1519311090-19998-1-git-send-email-shankerd@codeaurora.org>
 <20180222152244.zozx2tlptgnnfu6b@lakrids.cambridge.arm.com>
 <32c8cfd3-2883-177b-7736-1bb6ab679df4@arm.com>
 <20180222163330.o5lqant4fjenapcz@lakrids.cambridge.arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <2d4e89d3-f930-bf99-1cf6-e989bd88fa00@arm.com>
Date: Thu, 22 Feb 2018 16:53:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180222163330.o5lqant4fjenapcz@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/18 16:33, Mark Rutland wrote:
> On Thu, Feb 22, 2018 at 04:28:03PM +0000, Robin Murphy wrote:
>> [Apologies to keep elbowing in, and if I'm being thick here...]
>>
>> On 22/02/18 15:22, Mark Rutland wrote:
>>> On Thu, Feb 22, 2018 at 08:51:30AM -0600, Shanker Donthineni wrote:
>>>> +#define CTR_B31_SHIFT		31
>>>
>>> Since this is just a RES1 bit, I think we don't need a mnemonic for it,
>>> but I'll defer to Will and Catalin on that.
>>>
>>>>    ENTRY(invalidate_icache_range)
>>>> +#ifdef CONFIG_ARM64_SKIP_CACHE_POU
>>>> +alternative_if ARM64_HAS_CACHE_DIC
>>>> +	mov	x0, xzr
>>>> +	dsb	ishst
>>>> +	isb
>>>> +	ret
>>>> +alternative_else_nop_endif
>>>> +#endif
>>>
>>> As commented on v3, I don't believe you need the DSB here. If prior
>>> stores haven't been completed at this point, the existing implementation
>>> would not work correctly here.
>>
>> True in terms of ordering between stores prior to entry and the IC IVAU
>> itself, but what about the DSH ISH currently issued *after* the IC IVAU
>> before returning? Is provably impossible that existing callers might be
>> relying on that ordering *anything*, or would we risk losing something
>> subtle by effectively removing it?
> 
> AFAIK, the only caller of this is KVM, before page table updates occur
> to add execute permissions to the page this is applied to.
> 
> At least in that case, I do not beleive there would be breakage.
> 
> If we're worried about subtleties in callers, then we'd need to stick
> with DSB ISH rather than optimising to DSH ISHST.

Hmm, I probably am just squawking needlessly. It is indeed hard to 
imagine how callers could be relying on the invalidating the I-cache for 
ordering unless doing something unreasonably stupid, and if the current 
caller is clearly OK then there should be nothing to worry about.

This *has* helped me realise that I was indeed being somewhat thick 
before, because the existing barrier is of course not about memory 
ordering per se, but about completing the maintenance operation. Hooray 
for overloaded semantics...

On a different track, I'm now wondering whether the extra complexity of 
these alternatives might justify removing some obvious duplication and 
letting __flush_cache_user_range() branch directly into 
invalidate_icache_range(), or might that adversely affect the user fault 
fixup path?

Robin.
