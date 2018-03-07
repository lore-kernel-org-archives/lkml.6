Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933700AbeCGRmg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:42:36 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54842 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932801AbeCGRmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:42:31 -0500
Subject: Re: [PATCH v3 14/22] arm64: capabilities: Add support for features
 enabled early
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        Julien Thierry <julien.thierry@arm.com>, ckadabi@codeaurora.org,
        ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        robin.murphy@arm.com
References: <20180209175513.17100-1-suzuki.poulose@arm.com>
 <20180209175513.17100-28-suzuki.poulose@arm.com>
 <20180212171712.GK5862@e103592.cambridge.arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <986f7445-8f67-96e9-21f7-6eb1ff5a23c1@arm.com>
Date: Wed, 7 Mar 2018 17:42:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180212171712.GK5862@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/18 17:17, Dave Martin wrote:
> On Fri, Feb 09, 2018 at 05:54:57PM +0000, Suzuki K Poulose wrote:
>> The kernel detects and uses some of the features based on the boot
>> CPU and expects that all the following CPUs conform to it. e.g,
>> with VHE and the boot CPU running at EL2, the kernel decides to
>> keep the kernel running at EL2. If another CPU is brought up without
>> this capability, we use custom hooks (via check_early_cpu_features())
>> to handle it. To handle such capabilities add support for detecting
>> and enabling capabilities based on the boot CPU.
>>

>> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
>> index 383c69c95f23..5f56a8342065 100644
>> --- a/arch/arm64/include/asm/cpufeature.h
>> +++ b/arch/arm64/include/asm/cpufeature.h
>> @@ -104,7 +104,7 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
>>    *    some checks at runtime. This could be, e.g, checking the value of a field
>>    *    in CPU ID feature register or checking the cpu model. The capability
>>    *    provides a call back ( @matches() ) to perform the check.
>> - *    Scope defines how the checks should be performed. There are two cases:
>> + *    Scope defines how the checks should be performed. There are three cases:
>>    *
>>    *     a) SCOPE_LOCAL_CPU: check all the CPUs and "detect" if at least one
>>    *        matches. This implies, we have to run the check on all the booting
>> @@ -117,6 +117,11 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
>>    *        field in one of the CPU ID feature registers, we use the sanitised
>>    *        value of the register from the CPU feature infrastructure to make
>>    *        the decision.
>> + *		Or
>> + *     c) SCOPE_BOOT_CPU: Check only on the primary boot CPU to detect the feature.
>> + *        This category is for features that are "finalised" (or used) by the kernel
>> + *        very early even before the SMP cpus are brought up.
>> + *
> 
> Nit: the overlong lines bring no benefit here.  Please wrap them if
> possible -- but to avoid patch churn only bother for lines actually
> changed/added by this patch.

Sure

>>   static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
>> @@ -1277,12 +1277,21 @@ __enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps, u16 scope_m
>>   
>>   		if (caps->cpu_enable) {
>>   			/*
>> -			 * Use stop_machine() as it schedules the work allowing
>> -			 * us to modify PSTATE, instead of on_each_cpu() which
>> -			 * uses an IPI, giving us a PSTATE that disappears when
>> -			 * we return.
>> +			 * If we are dealing with a boot CPU capability, we
>> +			 * have to enable this only on the Boot CPU, where it
>> +			 * is detected. All the secondaries enable it via
>> +			 * check_local_cpu_capabilities().
> 
> I found this confusing to read, because it's not 100% clear whether the
> "If we are dealing with a boot CPU capability" applies to the second
> sentence as well.
> 
> Maybe this would be clearer as:
> 
> "Capabilities with SCOPE_BOOT_CPU are finalised before any secondary
> CPU boots.  Thus, each secondary will enable the capability as
> appropriate via check_local_cpu_capabilities().  The only exception is
> the boot CPU, for which the capability must be enabled here.  This
> approach avoids costly stop_machine() calls for this case."
> 
> Thoughts?

Definitely better, will change it.


>> @@ -1362,6 +1371,12 @@ static void check_early_cpu_features(void)
>>   {
>>   	verify_cpu_run_el();
>>   	verify_cpu_asid_bits();
>> +	/*
>> +	 * Early features are used by the kernel already. If there
>> +	 * is a conflict, we cannot proceed further.
>> +	 */
>> +	if (!verify_local_cpu_caps(SCOPE_BOOT_CPU))
>> +		cpu_panic_kernel();
>>   }
>>   
>>   static void
>> @@ -1403,9 +1418,8 @@ static void verify_sve_features(void)
>>    */
>>   static void verify_local_cpu_capabilities(void)
>>   {
> 
> Nit: Maybe add a comment saying where SCOPE_BOOT_CPU capabilities are
> checked.

Ok

> 
>> -	if (!verify_local_cpu_caps(SCOPE_ALL))
>> +	if (!verify_local_cpu_caps(SCOPE_ALL & ~SCOPE_BOOT_CPU))
>>   		cpu_die_early();
>> -
> 
> Nit: keep blank line?
> 
> Otherwise it looks like the if() falls through, where really
> cpu_die_early() does not return.
> 

ok

>>   void __init setup_cpu_features(void)
>> -- 
>> 2.14.3
> 
> With fair consideration given to the nits above:
> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>

Cheers
Suzuki
