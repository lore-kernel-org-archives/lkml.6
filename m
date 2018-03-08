Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934888AbeCHMQs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 07:16:48 -0500
Received: from foss.arm.com ([217.140.101.70]:36988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751862AbeCHMQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 07:16:46 -0500
Subject: Re: [PATCH v3 19/22] arm64: capabilities: Handle shared entries
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        ckadabi@codeaurora.org, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        robin.murphy@arm.com
References: <20180209175513.17100-1-suzuki.poulose@arm.com>
 <20180209175513.17100-39-suzuki.poulose@arm.com>
 <20180212171736.GM5862@e103592.cambridge.arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <e64cdea0-c10d-ad2d-fcbf-814ad6661949@arm.com>
Date: Thu, 8 Mar 2018 12:16:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180212171736.GM5862@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/18 17:17, Dave Martin wrote:
> On Fri, Feb 09, 2018 at 05:55:08PM +0000, Suzuki K Poulose wrote:
>> Some capabilities have different criteria for detection and associated
>> actions based on the matching criteria, even though they all share the
>> same capability bit. So far we have used multiple entries with the same
>> capability bit to handle this. This is prone to errors, as the
>> cpu_enable is invoked for each entry, irrespective of whether the
>> detection rule applies to the CPU or not. And also this complicates
>> other helpers, e.g, __this_cpu_has_cap.
>>
>> This patch adds a wrapper entry to cover all the possible variations
>> of a capability by maintaining list of matches + cpu_enable callbacks.
>> To avoid complicating the prototypes for the "matches()", we use
>> arm64_cpu_capabilities maintain the list and we ignore all the other
>> fields except the matches & cpu_enable.
>>
>> This ensures :
>>
>>   1) The capabilitiy is set when at least one of the entry detects
>>   2) Action is only taken for the entries that "matches".
>>
>> This avoids explicit checks in the cpu_enable() take some action.
>> The only constraint here is that, all the entries should have the
>> same "type" (i.e, scope and conflict rules).
>>
>> If a cpu_enable() method is associated with multiple matches for a
>> single capability, care should be taken that either the match criteria
>> are mutually exclusive, or that the method is robust against being
>> called multiple times.
>>
>> This also reverts the changes introduced by commit 67948af41f2e6818ed
>> ("arm64: capabilities: Handle duplicate entries for a capability").
>>
>> Cc: Dave Martin <dave.martin@arm.com>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   arch/arm64/include/asm/cpufeature.h | 11 ++++++++
>>   arch/arm64/kernel/cpu_errata.c      | 53 ++++++++++++++++++++++++++++++++-----
>>   arch/arm64/kernel/cpufeature.c      | 10 +++----
>>   3 files changed, 61 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
>> index 3ab1c3422f14..074537acc08b 100644
>> --- a/arch/arm64/include/asm/cpufeature.h
>> +++ b/arch/arm64/include/asm/cpufeature.h
>> @@ -306,6 +306,17 @@ struct arm64_cpu_capabilities {
>>   			bool sign;
>>   			unsigned long hwcap;
>>   		};
>> +		/*
>> +		 * A list of "matches/cpu_enable" pair for the same "capability"
>> +		 * of the same "type" as described by the parent. All the
>> +		 * fields, except "matches"/"cpu_enable" are ignored in the list.
> 
> Nit: This is not quite true: other fields may be needed, for use by the
> matches() method -- for example, if matches == has_cpuid_feature, then
> sys_reg, field_pos etc. will be used.
> 
> To keep things simple, maybe say "Only matches(), cpu_enable() and
> fields relevant to these methods are significant in the list." ?

Will fix it.

> 
>> +		 * The cpu_enable is invoked only if the corresponding entry
>> +		 * "matches()". However, if a cpu_enable() method is associated
>> +		 * with multiple matches, care should be taken that either the
>> +		 * match criteria are mutually exclusive, or that the method is
>> +		 * robust against being called multiple times.
>> +		 */
>> +		const struct arm64_cpu_capabilities *cap_list;
> 
> Nit: this is not really a list of capabilities, as noted above.
> 
> Can we call it something like "match_list"?

Ok.

> 
>>   	};
>>   };
>>   
>> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
>> index a602a3049404..902d281ea26f 100644
>> --- a/arch/arm64/kernel/cpu_errata.c
>> +++ b/arch/arm64/kernel/cpu_errata.c
>> @@ -264,6 +264,36 @@ qcom_enable_link_stack_sanitization(const struct arm64_cpu_capabilities *entry)
>>   	.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,			\
>>   	CAP_MIDR_RANGE_LIST(midr_list)
>>   
>> +/*
>> + * Generic helper for handling capabilties with multiple (match,enable) pairs
>> + * of call backs, sharing the same capability bit.
>> + * Iterate over each entry to see if at least one matches.
>> + */
>> +static bool multi_entry_cap_matches(const struct arm64_cpu_capabilities *entry,
>> +				    int scope)
>> +{
>> +	const struct arm64_cpu_capabilities *caps = entry->cap_list;
>> +
>> +	for (; caps->matches; caps++)
>> +		if (caps->matches(caps, scope))
>> +			return true;
> 
> Nit: add blank line?

  

>> +	return false;
>> +}
>> +
>> +/*
>> + * Take appropriate action for all matching entries in the shared capability
>> + * entry.
>> + */
>> +static void multi_entry_cap_cpu_enable(const struct arm64_cpu_capabilities *entry)
>> +{
>> +	const struct arm64_cpu_capabilities *caps = entry->cap_list;
>> +
>> +	for (; caps->matches; caps++)
> 
> Nit: can we move the initialiser into the for(); so
> 
> 	for (entry->cap_list; caps->matches; [...]


> 
> IMHO it's more readable to avoid empty expressions in for() unless
> there's a good reason.
> 
>> +		if (caps->matches(caps, SCOPE_LOCAL_CPU) &&

	.capability = ARM64_HARDEN_BP_POST_GUEST_EXIT,
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index 9eb9e9570468..d8663822c604 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -1225,9 +1225,8 @@ static bool __this_cpu_has_cap(const struct arm64_cpu_capabilities *cap_array,
>>   		return false;
>>   
>>   	for (caps = cap_array; caps->matches; caps++)
>> -		if (caps->capability == cap &&
>> -		    caps->matches(caps, SCOPE_LOCAL_CPU))
>> -			return true;
>> +		if (caps->capability == cap)
>> +			return caps->matches(caps, SCOPE_LOCAL_CPU);
> 
> Nit: add blank line?
> 
>>   	return false;

> 
> With fair consideration to the nits above,

Will do

> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>

Thanks
Suzuki
> 
