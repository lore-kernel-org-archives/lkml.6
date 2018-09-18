Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBECC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D51D2150C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D51D2150C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbeIRXUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 19:20:09 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48704 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729928AbeIRXUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 19:20:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F370ED1;
        Tue, 18 Sep 2018 10:46:29 -0700 (PDT)
Received: from [10.119.49.13] (unknown [10.119.49.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC05F3F703;
        Tue, 18 Sep 2018 10:46:27 -0700 (PDT)
Subject: Re: [PATCH v5 02/27] arm64: cpufeature: Use alternatives for VHE
 cpu_enable
To:     Julien Thierry <julien.thierry@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
 <1535471497-38854-3-git-send-email-julien.thierry@arm.com>
 <1d425320-aed3-b949-1ec5-f378248aac4d@arm.com>
 <85d74cec-2290-9e89-b155-f0f7c523b4a4@arm.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <afc7dcf8-7a10-ed8b-3dde-62c4710391c1@arm.com>
Date:   Tue, 18 Sep 2018 18:46:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <85d74cec-2290-9e89-b155-f0f7c523b4a4@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julien,

On 09/12/2018 01:03 PM, Julien Thierry wrote:
> On 12/09/18 11:28, James Morse wrote:
>> On 28/08/18 16:51, Julien Thierry wrote:
>>> The cpu_enable callback for VHE feature requires all alternatives to have
>>> been applied. This prevents applying VHE alternative separately from the
>>> rest.
>>>
>>> Use an alternative depending on VHE feature to know whether VHE
>>> alternatives have already been applied.

>>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>>> index 1e433ac..3bc1c8b 100644
>>> --- a/arch/arm64/kernel/cpufeature.c
>>> +++ b/arch/arm64/kernel/cpufeature.c
>>> @@ -1022,8 +1024,15 @@ static void cpu_copy_el2regs(const struct 
>>> arm64_cpu_capabilities *__unused)
>>>        * that, freshly-onlined CPUs will set tpidr_el2, so we don't need to
>>>        * do anything here.
>>>        */
>>> -    if (!alternatives_applied)
>>> -        write_sysreg(read_sysreg(tpidr_el1), tpidr_el2);
>>> +    asm volatile(ALTERNATIVE(
>>> +        "mrs    %0, tpidr_el1\n"
>>> +        "msr    tpidr_el2, %0",
>>> +        "nop\n"
>>> +        "nop",
>>> +        ARM64_HAS_VIRT_HOST_EXTN)
>>> +        : "+r" (tmp)
>>> +        :
>>> +        : "memory");
>>>   }
>>>   #endif
>>
>> Catalin's preference was to keep this all in C:
>> https://patchwork.kernel.org/patch/10007977/
>> , for which we need to know if 'the' alternative has been applied.
>>
>> I suspect there may be more registers in this list if we have to switch to
>> another EL2 register using alternatives. (but I don't have an example).
>>
>> Could we make 'alternatives_applied' a macro that takes the cap as an argument?

> I wanted to do this initially, the issue was that the alternatives framework works on 
> regions to patch rather than caps to apply. So I found it a bit odd to associate the 
> "code corresponding to cap was applied" with the alternative application.

I agree it looks funny, but for the kernel text, its can only be one region. If we 
ever had two we would still have to apply them at the same time as its not safe to 
run code with alternatives partially applied.

(modules should be fine too as we apply the same alternatives as the kernel has 
before we run any of the code)


I wonder if we can kill-off this function entirely... its only necessary because 
set_my_cpu_offset() sets the 'wrong' tpidr register, and we need to copy them before 
applying the alternatives.
... we only call set_my_cpu_offset() when we bring a cpu online, we could make it set 
both tpidr registers if we're running at EL2.


Thanks,

James
