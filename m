Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1EDC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A45820685
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfAHPUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:20:14 -0500
Received: from foss.arm.com ([217.140.101.70]:54250 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbfAHPUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 10:20:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4824380D;
        Tue,  8 Jan 2019 07:20:13 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D5793F5AF;
        Tue,  8 Jan 2019 07:20:11 -0800 (PST)
Subject: Re: [PATCH v8 15/26] arm64: alternative: Apply alternatives early in
 boot process
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
 <1546956464-48825-16-git-send-email-julien.thierry@arm.com>
 <cec17e88-d199-abb4-4919-deff7182a26f@arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <31a93d8b-9036-aef7-1b96-4de910a8d10b@arm.com>
Date:   Tue, 8 Jan 2019 15:20:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <cec17e88-d199-abb4-4919-deff7182a26f@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 08/01/2019 14:51, Suzuki K Poulose wrote:
> Hi Julien,
> 
> On 08/01/2019 14:07, Julien Thierry wrote:
>> From: Daniel Thompson <daniel.thompson@linaro.org>
>>
>> Currently alternatives are applied very late in the boot process (and
>> a long time after we enable scheduling). Some alternative sequences,
>> such as those that alter the way CPU context is stored, must be applied
>> much earlier in the boot sequence.
>>
>> Introduce apply_boot_alternatives() to allow some alternatives to be
>> applied immediately after we detect the CPU features of the boot CPU.
>>
>> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
>> [julien.thierry@arm.com: rename to fit new cpufeature framework better,
>>              apply BOOT_SCOPE feature early in boot]
>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   arch/arm64/include/asm/alternative.h |  1 +
>>   arch/arm64/include/asm/cpufeature.h  |  4 ++++
>>   arch/arm64/kernel/alternative.c      | 43
>> +++++++++++++++++++++++++++++++-----
>>   arch/arm64/kernel/cpufeature.c       |  6 +++++
>>   arch/arm64/kernel/smp.c              |  7 ++++++
>>   5 files changed, 56 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/alternative.h
>> b/arch/arm64/include/asm/alternative.h
>> index 9806a23..b9f8d78 100644
>> --- a/arch/arm64/include/asm/alternative.h
>> +++ b/arch/arm64/include/asm/alternative.h
>> @@ -25,6 +25,7 @@ struct alt_instr {
>>   typedef void (*alternative_cb_t)(struct alt_instr *alt,
>>                    __le32 *origptr, __le32 *updptr, int nr_inst);
>>   +void __init apply_boot_alternatives(void);
>>   void __init apply_alternatives_all(void);
>>   bool alternative_is_applied(u16 cpufeature);
>>   diff --git a/arch/arm64/include/asm/cpufeature.h
>> b/arch/arm64/include/asm/cpufeature.h
>> index 89c3f31..e505e1f 100644
>> --- a/arch/arm64/include/asm/cpufeature.h
>> +++ b/arch/arm64/include/asm/cpufeature.h
>> @@ -391,6 +391,10 @@ static inline int cpucap_default_scope(const
>> struct arm64_cpu_capabilities *cap)
>>   extern struct static_key_false cpu_hwcap_keys[ARM64_NCAPS];
>>   extern struct static_key_false arm64_const_caps_ready;
>>   +/* ARM64 CAPS + alternative_cb */
>> +#define ARM64_NPATCHABLE (ARM64_NCAPS + 1)
>> +extern DECLARE_BITMAP(boot_capabilities, ARM64_NPATCHABLE);
>> +
>>   #define for_each_available_cap(cap)        \
>>       for_each_set_bit(cap, cpu_hwcaps, ARM64_NCAPS)
>>   diff --git a/arch/arm64/kernel/alternative.c
>> b/arch/arm64/kernel/alternative.c
>> index c947d22..a9b4677 100644
>> --- a/arch/arm64/kernel/alternative.c
>> +++ b/arch/arm64/kernel/alternative.c
>> @@ -155,7 +155,8 @@ static void clean_dcache_range_nopatch(u64 start,
>> u64 end)
>>       } while (cur += d_size, cur < end);
>>   }
>>   -static void __apply_alternatives(void *alt_region, bool is_module)
>> +static void __apply_alternatives(void *alt_region,  bool is_module,
>> +                 unsigned long *feature_mask)
>>   {
>>       struct alt_instr *alt;
>>       struct alt_region *region = alt_region;
>> @@ -165,6 +166,9 @@ static void __apply_alternatives(void *alt_region,
>> bool is_module)
>>       for (alt = region->begin; alt < region->end; alt++) {
>>           int nr_inst;
>>   +        if (!test_bit(alt->cpufeature, feature_mask))
>> +            continue;
>> +
>>           /* Use ARM64_CB_PATCH as an unconditional patch */
>>           if (alt->cpufeature < ARM64_CB_PATCH &&
>>               !cpus_have_cap(alt->cpufeature))
>> @@ -203,8 +207,11 @@ static void __apply_alternatives(void
>> *alt_region, bool is_module)
>>           __flush_icache_all();
>>           isb();
>>   -        /* We applied all that was available */
>> -        bitmap_copy(applied_alternatives, cpu_hwcaps, ARM64_NCAPS);
>> +        /* Ignore ARM64_CB bit from feature mask */
>> +        bitmap_or(applied_alternatives, applied_alternatives,
>> +              feature_mask, ARM64_NCAPS);
>> +        bitmap_and(applied_alternatives, applied_alternatives,
>> +               cpu_hwcaps, ARM64_NCAPS);
>>       }
>>   }
>>   @@ -225,8 +232,13 @@ static int __apply_alternatives_multi_stop(void
>> *unused)
>>               cpu_relax();
>>           isb();
>>       } else {
>> +        DECLARE_BITMAP(remaining_capabilities, ARM64_NPATCHABLE);
>> +
>> +        bitmap_complement(remaining_capabilities, boot_capabilities,
>> +                  ARM64_NPATCHABLE);
>> +
>>           BUG_ON(all_alternatives_applied);
>> -        __apply_alternatives(&region, false);
>> +        __apply_alternatives(&region, false, remaining_capabilities);
>>           /* Barriers provided by the cache flushing */
>>           WRITE_ONCE(all_alternatives_applied, 1);
>>       }
>> @@ -240,6 +252,24 @@ void __init apply_alternatives_all(void)
>>       stop_machine(__apply_alternatives_multi_stop, NULL,
>> cpu_online_mask);
>>   }
>>   +/*
>> + * This is called very early in the boot process (directly after we run
>> + * a feature detect on the boot CPU). No need to worry about other CPUs
>> + * here.
>> + */
>> +void __init apply_boot_alternatives(void)
>> +{
>> +    struct alt_region region = {
>> +        .begin    = (struct alt_instr *)__alt_instructions,
>> +        .end    = (struct alt_instr *)__alt_instructions_end,
>> +    };
>> +
>> +    /* If called on non-boot cpu things could go wrong */
>> +    WARN_ON(smp_processor_id() != 0);
>> +
>> +    __apply_alternatives(&region, false, &boot_capabilities[0]);
>> +}
>> +
>>   #ifdef CONFIG_MODULES
>>   void apply_alternatives_module(void *start, size_t length)
>>   {
>> @@ -247,7 +277,10 @@ void apply_alternatives_module(void *start,
>> size_t length)
>>           .begin    = start,
>>           .end    = start + length,
>>       };
>> +    DECLARE_BITMAP(all_capabilities, ARM64_NPATCHABLE);
>> +
>> +    bitmap_fill(all_capabilities, ARM64_NPATCHABLE);
>>   -    __apply_alternatives(&region, true);
>> +    __apply_alternatives(&region, true, &all_capabilities[0]);
>>   }
>>   #endif
>> diff --git a/arch/arm64/kernel/cpufeature.c
>> b/arch/arm64/kernel/cpufeature.c
>> index 84fa5be..71c8d4f 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -54,6 +54,9 @@
>>   EXPORT_SYMBOL(cpu_hwcaps);
>>   static struct arm64_cpu_capabilities const __ro_after_init
>> *cpu_hwcaps_ptrs[ARM64_NCAPS];
>>   +/* Need also bit for ARM64_CB_PATCH */
>> +DECLARE_BITMAP(boot_capabilities, ARM64_NPATCHABLE);
>> +
>>   /*
>>    * Flag to indicate if we have computed the system wide
>>    * capabilities based on the boot time active CPUs. This
>> @@ -1672,6 +1675,9 @@ static void update_cpu_capabilities(u16 scope_mask)
>>           if (caps->desc)
>>               pr_info("detected: %s\n", caps->desc);
>>           cpus_set_cap(caps->capability);
>> +
>> +        if (caps->type & SCOPE_BOOT_CPU)
> 
> You may want to do :
>         if (scope_mask & SCOPE_BOOT_CPU)
> 
> for a tighter check to ensure this doesn't update the boot_capabilities
> after we have applied the boot_scope alternatives and miss applying the
> alternatives for those, should someone add a multi-scope (i.e
> SCOPE_BOOT_CPU and
> something else) capability (even by mistake).
> 

But a multi-scope capability containing SCOPE_BOOT_CPU should already
get updated for setup_boot_cpu_capabilities. Capabilities marked with
SCOPE_BOOT_CPU need to be enabled on the boot CPU or not at all.

Shouldn't the call to caps->matches() fail for a boot feature that was
not found on the boot cpu?

Also, you made the opposite suggestion 4 version ago with a more
worrying scenario :) :
https://lkml.org/lkml/2018/5/25/208

Otherwise, if my assumption above is wrong, it means the check should
probably be:
	if (caps->type & SCOPE_BOOT_CPU && scope_mask & SCOPE_BOOT_CPU)

But my current understanding is that we don't need that.

> With that:
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Let me know if I can keep your tag or if I indeed need to change the
condition.

Thanks,

-- 
Julien Thierry
