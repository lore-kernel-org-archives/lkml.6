Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966258AbeEYKjV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:39:21 -0400
Received: from foss.arm.com ([217.140.101.70]:59226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965255AbeEYKjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:39:19 -0400
Subject: Re: [PATCH v4 02/26] arm64: cpufeature: Add cpufeature for IRQ
 priority masking
To: Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
 <1527241772-48007-3-git-send-email-julien.thierry@arm.com>
 <e44df12f-9868-ae94-4623-ec221d72d783@arm.com>
 <b0673d7e-9a1e-7dcb-5322-c05fe0821349@arm.com>
 <c4e5f8ff-ecde-7b88-8a37-39e47ef22917@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <54ff6127-928d-99a3-a6e9-59799628ca87@arm.com>
Date: Fri, 25 May 2018 11:39:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <c4e5f8ff-ecde-7b88-8a37-39e47ef22917@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/05/18 11:36, Suzuki K Poulose wrote:
> On 25/05/18 11:17, Julien Thierry wrote:
>>
>>
>> On 25/05/18 11:04, Suzuki K Poulose wrote:
>>> On 25/05/18 10:49, Julien Thierry wrote:
>>>> Add a cpufeature indicating whether a cpu supports masking interrupts
>>>> by priority.
>>>
>>> How is this different from the SYSREG_GIC_CPUIF cap ? Is it just
>>> the description ?
>>
>> More or less.
>>
>> It is just to have an easier condition in the rest of the series. 
>> Basically the PRIO masking feature is enabled if we have a GICv3 CPUIF 
>> working *and* the option was selected at build time. Before this meant 
>> that I was checking for the GIC_CPUIF cap inside #ifdefs (and putting 
>> alternatives depending on that inside #ifdefs as well).
>>
>> Having this as a separate feature feels easier to manage in the code. 
>> It also makes it clearer at boot time that the kernel will be using 
>> irq priorities (although I admit it was not the initial intention):
>>
>> [    0.000000] CPU features: detected: IRQ priority masking
>>
>>
>> But yes that new feature will be detected only if SYSREG_GIC_CPUIF 
>> gets detected as well.
> 
> Well, you could always wrap the check like :
> 
> static inline bool system_has_irq_priority_masking(void)
> {
>      return (IS_ENABLED(CONFIG_YOUR_CONFIG) && 
> cpus_have_const_cap(HWCAP_SYSREG_GIC_CPUIF));
> }
> 
> and use it everywhere.
> 

Yes, but I can't use that in the asm parts that use alternatives and 
would need to surround them in #ifdef... :\

> The description could be statically changed to reflect based on the #ifdef.
> 
> 
> static const struct arm64_cpu_capabilities arm64_features[] = {
>          {
> #ifdef CONFIG_YOUR_CONFIG
>          .desc = "GIC System register CPU interface with IRQ priority 
> masking"
> #else
>                  .desc = "GIC system register CPU interface",
> #endif
>                  .capability = ARM64_HAS_SYSREG_GIC_CPUIF,
>                  .type = ARM64_CPUCAP_SYSTEM_FEATURE,
>                  .matches = has_useable_gicv3_cpuif,
>                  .sys_reg = SYS_ID_AA64PFR0_EL1,
>                  .field_pos = ID_AA64PFR0_GIC_SHIFT,
>                  .sign = FTR_UNSIGNED,
>                  .min_field_value = 1,
> 
> Cheers
> Suzuki

-- 
Julien Thierry
