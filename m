Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752939AbeEKJTz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 05:19:55 -0400
Received: from foss.arm.com ([217.140.101.70]:38524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752688AbeEKJTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 05:19:54 -0400
Subject: Re: [PATCH v2 2/6] arm64: alternative: Apply alternatives early in
 boot process
To: Julien Thierry <julien.thierry@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: mark.rutland@arm.com, marc.zyngier@arm.com, james.morse@arm.com,
        daniel.thompson@linaro.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
References: <1516190084-18978-1-git-send-email-julien.thierry@arm.com>
 <1516190084-18978-3-git-send-email-julien.thierry@arm.com>
 <c935a9e6-94a0-03cb-eb64-7e2eef8f8d86@arm.com>
 <7a3afa42-821a-3d4a-3af8-00ba18653a4a@arm.com>
 <d170336d-8af0-893a-acb2-51900c28ade5@arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <8a8b80f8-d393-cb2e-fa7d-8d8800c4eae7@arm.com>
Date: Fri, 11 May 2018 10:19:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <d170336d-8af0-893a-acb2-51900c28ade5@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/18 09:12, Julien Thierry wrote:
> 
> 
> On 09/05/18 22:52, Suzuki K Poulose wrote:
>> On 05/04/2018 11:06 AM, Julien Thierry wrote:
>>> Hi,
>>>
>>> In order to prepare the v3 of this patchset, I'd like people's opinion on what this patch does. More below.
>>>
>>> On 17/01/18 11:54, Julien Thierry wrote:
>>>> From: Daniel Thompson <daniel.thompson@linaro.org>
>>>>
>>>> Currently alternatives are applied very late in the boot process (and
>>>> a long time after we enable scheduling). Some alternative sequences,
>>>> such as those that alter the way CPU context is stored, must be applied
>>>> much earlier in the boot sequence.
>>
>>>> +/*
>>>> + * early-apply features are detected using only the boot CPU and checked on
>>>> + * secondary CPUs startup, even then,
>>>> + * These early-apply features should only include features where we must
>>>> + * patch the kernel very early in the boot process.
>>>> + *
>>>> + * Note that the cpufeature logic *must* be made aware of early-apply
>>>> + * features to ensure they are reported as enabled without waiting
>>>> + * for other CPUs to boot.
>>>> + */
>>>> +#define EARLY_APPLY_FEATURE_MASK BIT(ARM64_HAS_SYSREG_GIC_CPUIF)
>>>> +
>>>
>>> Following the change in the cpufeature infrastructure, ARM64_HAS_SYSREG_GIC_CPUIF will have the scope ARM64_CPUCAP_SCOPE_BOOT_CPU in order to be checked early in the boot process.
>>
>> Thats correct.
>>
>>>
>>> Now, regarding the early application of alternative, I am wondering whether we can apply all the alternatives associated with SCOPE_BOOT features that *do not* have a cpu_enable callback.
>>>
>>
>> I don't understand why would you skip the ones that have a "cpu_enable" callback. Could you explain this a bit ? Ideally you should be able to
>> apply the alternatives for features with the SCOPE_BOOT, provided the
>> cpu_enable() callback is written properly.
>>
> 
> In my mind the "cpu_enable" callback is the setup a cpu should perform before using the feature (i.e. the code getting patched in by the alternative). So I was worried about the code getting patched by the boot cpu and then have the secondary cpus ending up executing patched code before the cpu_enable for the corresponding feature gets called.
> Or is there a requirement for secondary cpu startup code to be free of alternative code?

There are no imposed restrictions. It is upto the capability to decide
what can be done in cpu_enable() and what can be patched. So, if you
make sure the patched code can be safely executed by secondary it is
fine. May be you could even patch in some code in the early boot up, to
do what you do in "cpu_enable()" for the secondary to safely execute
the patched code.

Anyway, if the secondary CPUs don't have the feature you are going to
panic the system. So I don't think there is a big difference in the
outcome if there is a mismatch, except for a clean message about the
conflict.


Cheers
Suzuki
