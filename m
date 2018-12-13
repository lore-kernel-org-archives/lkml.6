Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6D0C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B112086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B112086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbeLMMCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:02:46 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60312 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728733AbeLMMCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:02:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9D2BA78;
        Thu, 13 Dec 2018 04:02:45 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AD643F575;
        Thu, 13 Dec 2018 04:02:43 -0800 (PST)
Subject: Re: [PATCH v7 11/25] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        joel@joelfernandes.org, Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, oleg@redhat.com
References: <1544633245-6036-1-git-send-email-julien.thierry@arm.com>
 <1544633245-6036-12-git-send-email-julien.thierry@arm.com>
 <CAKv+Gu8E9g=J78a-2HAdcijaHyVFL1KA3civwfoVHQ=mp7yJJA@mail.gmail.com>
 <19500d6b-62a3-21cb-9ac0-a4e5d4714a63@arm.com>
 <CAKv+Gu8+1JNzM4AUujiEfkYujpgakLXcUwTDG4eHwvQ7pKAzFA@mail.gmail.com>
 <31e41461-763f-aa7d-91ea-b493ede81eed@arm.com>
 <CAKv+Gu9PaeGbfB-9r0Gv1oYn+jORJDk9ozajEwKbse3KjkSmbQ@mail.gmail.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <bc27fb6d-1adf-d7e9-ded2-2cbed81b6e03@arm.com>
Date:   Thu, 13 Dec 2018 12:02:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu9PaeGbfB-9r0Gv1oYn+jORJDk9ozajEwKbse3KjkSmbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/12/2018 11:35, Ard Biesheuvel wrote:
> On Thu, 13 Dec 2018 at 09:54, Julien Thierry <julien.thierry@arm.com> wrote:
>>
>>
>>
>> On 12/12/2018 18:10, Ard Biesheuvel wrote:
>>> On Wed, 12 Dec 2018 at 18:59, Julien Thierry <julien.thierry@arm.com> wrote:
>>>>
>>>>
>>>>
>>>> On 12/12/2018 17:27, Ard Biesheuvel wrote:
>>>>> On Wed, 12 Dec 2018 at 17:48, Julien Thierry <julien.thierry@arm.com> wrote:
>>>>>>
>>>>>> Instead disabling interrupts by setting the PSR.I bit, use a priority
>>>>>> higher than the one used for interrupts to mask them via PMR.
>>>>>>
>>>>>> When using PMR to disable interrupts, the value of PMR will be used
>>>>>> instead of PSR.[DAIF] for the irqflags.
>>>>>>
>>>>>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>>>>>> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
>>>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>>>> Cc: Will Deacon <will.deacon@arm.com>
>>>>>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>>>>> Cc: Oleg Nesterov <oleg@redhat.com>
>>>>>> ---
>>>>>>  arch/arm64/include/asm/efi.h      |   5 +-
>>>>>>  arch/arm64/include/asm/irqflags.h | 123 +++++++++++++++++++++++++++++---------
>>>>>>  2 files changed, 99 insertions(+), 29 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
>>>>>> index 7ed3208..a9d3ebc 100644
>>>>>> --- a/arch/arm64/include/asm/efi.h
>>>>>> +++ b/arch/arm64/include/asm/efi.h
>>>>>> @@ -42,7 +42,10 @@
>>>>>>
>>>>>>  efi_status_t __efi_rt_asm_wrapper(void *, const char *, ...);
>>>>>>
>>>>>> -#define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
>>>>>> +#define ARCH_EFI_IRQ_FLAGS_MASK                                                \
>>>>>> +       (system_uses_irq_prio_masking() ?                               \
>>>>>> +               GIC_PRIO_IRQON :                                        \
>>>>>> +               (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT))
>>>>>>
>>>>>
>>>>> This mask is used to determine whether we return from a firmware call
>>>>> with a different value for the I flag than we entered it with. So
>>>>> instead of changing the mask, we should change the way we record DAIF,
>>>>> given that the firmware is still going to poke the I bit if it
>>>>> misbehaves, regardless of whether the OS happens to use priorities for
>>>>> interrupt masking.
>>>>>
>>>>
>>>> Thanks for pointing that out, so this change makes little sense...
>>>>
>>>> The annoying part is that the flag checking takes place in the arch
>>>> agnostic code.
>>>>
>>>> Would introducing some overriddable efi_get_flags() or efi_save_flags()
>>>> that default to local_save_flags() seem like an acceptable solution?
>>>>
>>>> This way I could override it for arm64 and still return the DAIF bits.
>>>>
>>>
>>> I don't follow the reasoning below about irqflags exactly, but is
>>> there any way we could simply but both PMR and DAIF in flags? We could
>>> even update the mask here to ensure that the firmware doesn't corrupt
>>> the PMR.
>>>
>>
>> So, that was the case in my previous versions of the series, and as you
>> said, that covered checking both DAIF bits and PMR on return from EFI
>> services. But Catalin suggested that irqflags could just use PMR when we
>> enable the priority masking feature. Catalin's suggestion does simplify
>> things, except for this part.
>>
>> However, it doesn't seem to far-fetched to me that the architecture
>> could have a more generic way to tell the EFI driver "this is the set of
>> stuff that I care about and you should return from runtime services with
>> this stuff in the same state as before" without the "set of stuff" being
>> limited to irqflags.
>>
>> But maybe this would be over-engineering just to deal with my use-case...
>>
> 
> No, that makes sense. As you said, you can just create a
> efi_get_irqflags() helper that defaults to what we are using now, and
> can be overridden to just return DAIF in our case.
> 

Good, thanks for the confirmation. I'll do that for the next version of
the series.

Thanks,

-- 
Julien Thierry
