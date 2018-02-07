Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754281AbeBGSem (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 13:34:42 -0500
Received: from foss.arm.com ([217.140.101.70]:54682 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753965AbeBGSel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 13:34:41 -0500
Subject: Re: [PATCH v2 11/20] arm64: capabilities: Add support for features
 enabled early
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        Julien Thierry <julien.thierry@arm.com>, ckadabi@codeaurora.org,
        ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
 <20180131182807.32134-12-suzuki.poulose@arm.com>
 <20180207103855.GB5862@e103592.cambridge.arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <a1275474-fbf0-91b2-befb-cbd59d5ccf1e@arm.com>
Date: Wed, 7 Feb 2018 18:34:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180207103855.GB5862@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/18 10:38, Dave Martin wrote:
> On Wed, Jan 31, 2018 at 06:27:58PM +0000, Suzuki K Poulose wrote:
>> The kernel detects and uses some of the features based on the boot
>> CPU and expects that all the following CPUs conform to it. e.g,
>> with VHE and the boot CPU running at EL2, the kernel decides to
>> keep the kernel running at EL2. If another CPU is brought up without
>> this capability, we use custom hooks (via check_early_cpu_features())
>> to handle it. To handle such capabilities add support for detecting
>> and enabling capabilities based on the boot CPU.
>>
>> A bit is added to indicate if the capability should be detected
>> early on the boot CPU. The infrastructure then ensures that such
>> capabilities are probed and "enabled" early on in the boot CPU
>> and, enabled on the subsequent CPUs.
>>
>> Cc: Julien Thierry <julien.thierry@arm.com>
>> Cc: Dave Martin <dave.martin@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   arch/arm64/include/asm/cpufeature.h | 48 +++++++++++++++++++++++++++++--------
>>   arch/arm64/kernel/cpufeature.c      | 48 +++++++++++++++++++++++++++----------
>>   2 files changed, 74 insertions(+), 22 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
>> index 71993dd4afae..04161aac0f06 100644
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
>>    *    The process of detection is usually denoted by "update" capability state
>>    *    in the code.
>>    *
>> @@ -129,6 +134,10 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
>>    *    EL2 with Virtualisation Host Extensions). The kernel usually disallows
>>    *    any changes to the state of a capability once it finalises the capability
>>    *    and takes any action, as it may be impossible to execute the actions safely.
>> + *    At the moment there are two passes of finalising the capabilities.
>> + *      a) Boot CPU scope capabilities - Finalised by primary boot CPU via
>> + *         setup_boot_cpu_capabilities().
>> + *      b) Everything except (a) - Run via setup_system_capabilities().
>>    *
>>    * 3) Verification: When a CPU is brought online (e.g, by user or by the kernel),
>>    *    the kernel should make sure that it is safe to use the CPU, by verifying
>> @@ -139,11 +148,22 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
>>    *
>>    *    As explained in (2) above, capabilities could be finalised at different
>>    *    points in the execution. Each CPU is verified against the "finalised"
>> - *    capabilities and if there is a conflict, the kernel takes an action, based
>> - *    on the severity (e.g, a CPU could be prevented from booting or cause a
>> - *    kernel panic). The CPU is allowed to "affect" the state of the capability,
>> - *    if it has not been finalised already. See section 5 for more details on
>> - *    conflicts.
>> + *    capabilities.
>> + *
>> + *	x------------------------------------------------------------------- x
>> + *	| Verification:       | Boot CPU | SMP CPUs by kernel | CPUs by user |
>> + *	|--------------------------------------------------------------------|
>> + *	| Primary boot CPU    |          |                    |              |
>> + *	|  capability         |   n      |      y             |       y      |
>> + *	|--------------------------------------------------------------------|
>> + *	| All others          |   n      |      n             |       y      |
>> + *	x--------------------------------------------------------------------x
> 
> Minor clarify nit: it's not obvious that "n" means "no conflict" and "y"
> means "conflict".
> 
> Could we have blank cell versus "X" (with a note saying what that
> means), or "ok" versus "CONFLICT"?

This is not strictly about conflicts, but about what each CPU get verified against.
Since there are multiple stages of "finalisation" for the capabilities, the table
shows how the CPUs get verified.

Would it help if I changed the description above the table to :

  *    As explained in (2) above, capabilities could be finalised at different
  *    points in the execution. Each CPU is verified against the "finalised"
  *    capabilities. The following table shows, the capabilities verified
  *    against each CPU in the system.
  *
  *      x------------------------------------------------------------------- x
  *      | Verified against:   | Boot CPU | SMP CPUs by kernel | CPUs by user |

.....


> 
>> + *
>> + *
>> + *    If there is a conflict, the kernel takes an action, based on the severity
>> + *    (e.g, a CPU could be prevented from booting or cause a kernel panic).
>> + *    The CPU is allowed to "affect" the state of the capability, if it has not
>> + *    been finalised already. See section 5 for more details on conflicts.
>>    *
>>    * 4) Action: As mentioned in (2), the kernel can take an action for each detected
>>    *    capability, on all CPUs on the system. This is always initiated only after
>> @@ -186,20 +206,28 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
>>    */
>>   
>>   
>> -/* Decide how the capability is detected. On a local CPU vs System wide */
>> -#define ARM64_CPUCAP_SCOPE_MASK			0x3
>> +/*
>> + * Decide how the capability is detected.
>> + * On any local CPU vs System wide vs the primary boot CPU
>> + */
>> +#define ARM64_CPUCAP_SCOPE_MASK			0x7
> 
> Minor nit: magic number.  Could we do
> 
> #define ARM64_CPUCAP_SCOPE_MASK		\
> 	(ARM64_CPUCAP_SCOPE_LOCAL_CPU |	\
> 	 ARM64_CPUCAP_SCOPE_SYSTEM |	\
> 	 ARM64_CPUCAP_SCOPE_BOOT_CPU)
> 
> below?

Sure, I will move it.

>>   static void verify_local_cpu_capabilities(void)
>>   {
>> -	if (!verify_local_cpu_caps(ARM64_CPUCAP_SCOPE_ALL))
>> +	if (!verify_local_cpu_caps(~ARM64_CPUCAP_SCOPE_BOOT_CPU))
> 
> [1] This is neat, but would it be clearer to say _ALL & ~_BOOT_CPU?
> 
> Otherwise, this is passing (u16)0xfffb, which feels invalid,
> particularly since it includes _{PERMITTED,OPTIONAL}_FOR_LATE_CPU which
> don't make sense here, even if we know they get masked off.
> 
> There could be future pitfalls here if ~_BOOT_CPU by itself is pasted
> in other places where the *_FOR_LATE_CPU bits are significant.

Sure, I chose it for keeping the lines shorter ;-). I will switch it.

> 
>>   		cpu_die_early();
>>   	verify_local_elf_hwcaps(arm64_elf_hwcaps);
>>   
>> @@ -1415,6 +1430,15 @@ void check_local_cpu_capabilities(void)
>>   		verify_local_cpu_capabilities();
>>   }
>>   
>> +static void __init setup_boot_cpu_capabilities(void)
>> +{
>> +	/* Detect capabilities with either SCOPE_BOOT_CPU or SCOPE_LOCAL_CPU */
>> +	update_cpu_capabilities(ARM64_CPUCAP_SCOPE_BOOT_CPU |
>> +				 ARM64_CPUCAP_SCOPE_LOCAL_CPU);
>> +	/* Enable the SCOPE_BOOT_CPU capabilities alone right away */
>> +	enable_cpu_capabilities(ARM64_CPUCAP_SCOPE_BOOT_CPU);
>> +}
>> +
>>   static void __init setup_system_capabilities(void)
>>   {
>>   	/*
>> @@ -1422,8 +1446,8 @@ static void __init setup_system_capabilities(void)
>>   	 * finalise the capabilities that depend on it.
>>   	 */
>>   	update_system_capabilities();
>> -	/* Enable all the available capabilities */
>> -	enable_cpu_capabilities(ARM64_CPUCAP_SCOPE_ALL);
>> +	/* Enable all the available capabilities, which are not already enabled. */
>> +	enable_cpu_capabilities(~ARM64_CPUCAP_SCOPE_BOOT_CPU);
> 
> As [1] above.
> 

Cheers
Suzuki
