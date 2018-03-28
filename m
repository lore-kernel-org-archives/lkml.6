Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbeC1BJF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 21:09:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47396 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752704AbeC1BJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 21:09:03 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7A52F601D3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pelcan@codeaurora.org
Subject: Re: [PATCH V2] arm64: tlbflush: avoid writing RES0 bits
To: shankerd@codeaurora.org, Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, Thomas Speier <tspeier@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <1522120877-9136-1-git-send-email-pelcan@codeaurora.org>
 <985a0edd-e388-dade-8824-30cc58a236f3@arm.com>
 <56b560a5-6e57-8e01-32ca-9d3c95ccd2e5@codeaurora.org>
 <20180327173613.GI18435@arm.com>
 <96f894bb-4855-a77f-3fd1-c8a2878faabb@codeaurora.org>
From: Philip Elcan <pelcan@codeaurora.org>
Message-ID: <d141573d-aa93-20a5-3982-abc70db088b6@codeaurora.org>
Date: Tue, 27 Mar 2018 21:08:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <96f894bb-4855-a77f-3fd1-c8a2878faabb@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/2018 9:03 PM, Shanker Donthineni wrote:
> Hi Will,
> 
> On 03/27/2018 12:36 PM, Will Deacon wrote:
>> Hi Shanker,
>>
>> On Tue, Mar 27, 2018 at 09:53:16AM -0500, Shanker Donthineni wrote:
>>> On 03/27/2018 06:34 AM, Robin Murphy wrote:
>>>> On 27/03/18 04:21, Philip Elcan wrote:
>>>>> Several of the bits of the TLBI register operand are RES0 per the ARM
>>>>> ARM, so TLBI operations should avoid writing non-zero values to these
>>>>> bits.
>>>>>
>>>>> This patch adds a macro __TLBI_VADDR(addr, asid) that creates the
>>>>> operand register in the correct format and honors the RES0 bits.
>>>>>
>>>>> Signed-off-by: Philip Elcan <pelcan@codeaurora.org>
>>>>> ---
>>>>>   arch/arm64/include/asm/tlbflush.h | 23 ++++++++++++++++-------
>>>>>   1 file changed, 16 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
>>>>> index 9e82dd7..b1205e9 100644
>>>>> --- a/arch/arm64/include/asm/tlbflush.h
>>>>> +++ b/arch/arm64/include/asm/tlbflush.h
>>>>> @@ -60,6 +60,15 @@
>>>>>           __tlbi(op, (arg) | USER_ASID_FLAG);                \
>>>>>   } while (0)
>>>>>   +/* This macro creates a properly formatted VA operand for the TLBI */
>>>>> +#define __TLBI_VADDR(addr, asid)                \
>>>>> +    ({                            \
>>>>> +        unsigned long __ta = (addr) >> 12;        \
>>>>> +        __ta &= GENMASK_ULL(43, 0);            \
>>>>> +        __ta |= (unsigned long)(asid) << 48;        \
>>>>> +        __ta;                        \
>>>>> +    })
>>>>
>>>> I'd be inclined to make this a static inline function rather than a
>>>> macro, since it doesn't need to do any wacky type-dodging, but either
>>>> way the overall change now looks appropriate;
>>>>
>>>> Acked-by: Robin Murphy <robin.murphy@arm.com>
>>>>
>>>
>>> Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
>>
>> [...]
>>
>>>>> @@ -154,8 +163,8 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
>>>>>           return;
>>>>>       }
>>>>>   -    start = asid | (start >> 12);
>>>>> -    end = asid | (end >> 12);
>>>>> +    start = __TLBI_VADDR(start, asid);
>>>>> +    end = __TLBI_VADDR(end, asid);
>>
>> Can you test this bit too, please? ;)
>>
> 
> I've verified the basic boot functionality on QDF2400 platform. But I can see now
> after your comments, it leads to TLB conflicts because of ASID is truncated to zero
> due to two times 48bit shift.     
> 
> Thanks for catching this one.
> 
> @@ -146,7 +155,7 @@ static inline void __flush_tlb_range(structvm_area_struct *
>                                      unsigned long start, unsigned long end,
>                                      bool last_level)
> {
> -       unsigned long asid = ASID(vma->vm_mm) << 48;
> +       unsigned long asid = ASID(vma->vm_mm);
>         unsigned long addr;
>  
>         if ((end - start) > MAX_TLB_RANGE) {
> @@ -154,8 +163,8 @@ static inline void __flush_tlb_range(struct
> vm_area_struct *
>                 return;
>         }
> 
> -       start = asid | (start >> 12);
> -       end = asid | (end >> 12);
> +       start = __TLBI_VADDR(start, asid);
> +       end = __TLBI_VADDR(end, asid);
> 
> 
>> Will
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
> 

Thanks for catching that.  I'll address with a v3 patch.

Philip

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
