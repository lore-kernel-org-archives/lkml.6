Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751639AbeA3LZ5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 06:25:57 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52414 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751219AbeA3LZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 06:25:55 -0500
Subject: Re: [PATCH 09/16] arm64: capabilities: Introduce strict features
 based on local CPU
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        ckadabi@codeaurora.org, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com
References: <20180123122809.16269-1-suzuki.poulose@arm.com>
 <20180123122809.16269-10-suzuki.poulose@arm.com>
 <20180126121219.GQ5862@e103592.cambridge.arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <d12c2c77-8813-75ed-1011-7ba42bff663e@arm.com>
Date: Tue, 30 Jan 2018 11:25:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180126121219.GQ5862@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/18 12:12, Dave Martin wrote:
> On Tue, Jan 23, 2018 at 12:28:02PM +0000, Suzuki K Poulose wrote:
>> Add type for features that are detected on individual CPUs,
>> rather than on a system wide safe features. This behavior
> 
> feature
> 
>> is similar to that of a strict cpu erratum, where a later
>> CPU is not allowed to boot if the system doesn't posses it.
>>
>> Use this for software prefetching capability.
>>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   arch/arm64/include/asm/cpufeature.h | 7 +++++++
>>   arch/arm64/kernel/cpufeature.c      | 2 +-
>>   2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
>> index a621d2184227..4c3d6987acfc 100644
>> --- a/arch/arm64/include/asm/cpufeature.h
>> +++ b/arch/arm64/include/asm/cpufeature.h
>> @@ -118,6 +118,13 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
>>    */
>>   #define ARM64_CPUCAP_BOOT_SYSTEM_FEATURE	\
>>   	(ARM64_CPUCAP_SCOPE_SYSTEM | ARM64_CPUCAP_LATE_CPU_SAFE_TO_HAVE)
>> +/*
>> + * CPU feature detected at boot time based on feature of one or more CPUs.
>> + * It is not safe for a late CPU to have this feature, when the system doesn't
>> + * have it. But it is safe to miss the feature if the system has it.
>> + */
>> +#define ARM64_CPUCAP_STRICT_CPU_LOCAL_FEATURE	\
>> +	(ARM64_CPUCAP_SCOPE_LOCAL_CPU | ARM64_CPUCAP_LATE_CPU_SAFE_TO_MISS)
> 
> "STRICT" seem quite odd here, since we never require all CPUs to have
> the feature.  The case we forbid is when the boot-time decision is that
> the system doesn't tolerate this feature.  So this feels erratum-like.
> 
>>   struct arm64_cpu_capabilities {
>>   	const char *desc;
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index 7ae5cf9092d0..111f6c4b4cd7 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -951,7 +951,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>>   	{
>>   		.desc = "Software prefetching using PRFM",
>>   		.capability = ARM64_HAS_NO_HW_PREFETCH,
>> -		.type = ARM64_CPUCAP_BOOT_SYSTEM_FEATURE,
>> +		.type = ARM64_CPUCAP_STRICT_CPU_LOCAL_FEATURE,
>>   		.matches = has_no_hw_prefetch,
> 
> For ARM64_HAS_NO_HW_PREFETCH this is more describing an implementation
> option that only affects performance -- in that case it's not obvious
> that we should be strict at all.
> 
> This suggests ARM64_CPUCAP_SCOPE_LOCAL_CPU |
> 	ARM64_CPUCAP_LATE_CPU_SAFE_TO_HAVE |
> 	ARM64_CPUCAP_LATE_CPU_SAFE_TO_MISS.

You're right. This is more like a WEAK feature we add for DBM. I will switch it.

Cheers
Suzuki
