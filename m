Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751611AbeA3LRn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 06:17:43 -0500
Received: from foss.arm.com ([217.140.101.70]:52324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751219AbeA3LRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 06:17:42 -0500
Subject: Re: [PATCH 05/16] arm64: Add flags to check the safety of a
 capability for late CPU
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        ckadabi@codeaurora.org, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com
References: <20180123122809.16269-1-suzuki.poulose@arm.com>
 <20180123122809.16269-6-suzuki.poulose@arm.com>
 <20180126101020.GM5862@e103592.cambridge.arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <6313a0f1-ed3c-b5b3-7bbd-5f98862a74c6@arm.com>
Date: Tue, 30 Jan 2018 11:17:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180126101020.GM5862@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/18 10:10, Dave Martin wrote:
> On Tue, Jan 23, 2018 at 12:27:58PM +0000, Suzuki K Poulose wrote:
>> Add two different flags to indicate if the conflict of a capability
>> on a late CPU with the current system state
>>
>>   1) Can a CPU have a capability when the system doesn't have it ?
>>
>>      Most arm64 features could have this set. While erratum work arounds
>>      cannot have this, as we may miss work arounds.
>>
>>   2) Can a CPU miss a capability when the system has it ?
>>      This could be set for arm64 erratum work arounds as we don't
>>      care if a CPU doesn't need the work around. However it should
>>      be clear for features.
>>
>> These flags could be added to certain entries based on their nature.
>>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   arch/arm64/include/asm/cpufeature.h | 35 +++++++++++++++++++++++++++++++----
>>   1 file changed, 31 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
>> index 4fd5de8ef33e..27d037bb0451 100644
>> --- a/arch/arm64/include/asm/cpufeature.h
>> +++ b/arch/arm64/include/asm/cpufeature.h
>> @@ -94,10 +94,25 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
>>   #define SCOPE_SYSTEM				ARM64_CPUCAP_SCOPE_SYSTEM
>>   #define SCOPE_LOCAL_CPU				ARM64_CPUCAP_SCOPE_LOCAL_CPU
>>   
>> -/* CPU errata detected at boot time based on feature of one or more CPUs */
>> -#define ARM64_CPUCAP_STRICT_CPU_LOCAL_ERRATUM	(ARM64_CPUCAP_SCOPE_LOCAL_CPU)
>> -/* CPU feature detected at boot time based on system-wide value of a feature */
>> -#define ARM64_CPUCAP_BOOT_SYSTEM_FEATURE	(ARM64_CPUCAP_SCOPE_SYSTEM)
>> +/* Is it safe for a late CPU to have this capability when system doesn't already have */
>> +#define ARM64_CPUCAP_LATE_CPU_SAFE_TO_HAVE	BIT(2)
>> +/* Is it safe for a late CPU to miss this capability when system has it */
>> +#define ARM64_CPUCAP_LATE_CPU_SAFE_TO_MISS	BIT(3)
> 
> Maybe _OPTIONAL and _PERMITTED would be a bit less verbose?
> 
> Alternatively,
> 	ARM64_CPUCAP_PERMITTED_FOR_LATE_CPU
> 	ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU

Sounds better than what I have. I have picked them up.

Cheers
Suzuki
