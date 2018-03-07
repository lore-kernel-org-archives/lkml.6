Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934089AbeCGRjR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:39:17 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54746 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932801AbeCGRjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:39:13 -0500
Subject: Re: [PATCH v3 21/22] arm64: Delay enabling hardware DBM feature
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        ckadabi@codeaurora.org, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        robin.murphy@arm.com
References: <20180209175513.17100-1-suzuki.poulose@arm.com>
 <20180209175513.17100-43-suzuki.poulose@arm.com>
 <20180209185840.GJ5862@e103592.cambridge.arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <e8b40320-10d2-6117-ef7f-7bbb46823ffb@arm.com>
Date: Wed, 7 Mar 2018 17:39:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180209185840.GJ5862@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/18 18:58, Dave Martin wrote:
> On Fri, Feb 09, 2018 at 05:55:12PM +0000, Suzuki K Poulose wrote:
>> We enable hardware DBM bit in a capable CPU, very early in the
>> boot via __cpu_setup. This doesn't give us a flexibility of
>> optionally disable the feature, as the clearing the bit
>> is a bit costly as the TLB can cache the settings. Instead,
>> we delay enabling the feature until the CPU is brought up
>> into the kernel. We use the feature capability mechanism
>> to handle it.
>>
>> The hardware DBM is a non-conflicting feature. i.e, the kernel
>> can safely run with a mix of CPUs with some using the feature
>> and the others don't. So, it is safe for a late CPU to have
>> this capability and enable it, even if the active CPUs don't.
>>
>> To get this handled properly by the infrastructure, we
>> unconditionally set the capability and only enable it
>> on CPUs which really have the feature. Also, we print the
>> feature detection from the "matches" call back to make sure
>> we don't mislead the user when none of the CPUs could use the
>> feature.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Dave Martin <dave.martin@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>> Changes since V2
>>   - Print the feature detection message only when at least one CPU
>>     is actually using it.


>> +static bool has_hw_dbm(const struct arm64_cpu_capabilities *cap,
>> +		       int __unused)
>> +{
>> +	static bool detected = false;
>> +	/*
>> +	 * DBM is a non-conflicting feature. i.e, the kernel can safely
>> +	 * run a mix of CPUs with and without the feature. So, we
>> +	 * unconditionally enable the capability to allow any late CPU
>> +	 * to use the feature. We only enable the control bits on the
>> +	 * CPU, if it actually supports.
>> +	 *
>> +	 * We have to make sure we print the "feature" detection only
>> +	 * when at least one CPU actually uses it. So check if this CPU
>> +	 * can actually use it and print the message exactly once.
>> +	 *
>> +	 * This is safe as all CPUs (including secondary CPUs - due to the
>> +	 * LOCAL_CPU scope - and the hotplugged CPUs - via verification)
>> +	 * goes through the "matches" check exactly once. Also if a CPU
>> +	 * matches the criteria, it is guaranteed that the CPU will turn
>> +	 * the DBM on, as the capability is unconditionally enabled.
>> +	 */
>> +	if (!detected && cpu_can_use_dbm(cap)) {
>> +		detected = true;
>> +		pr_info("detected feature: Hardware dirty bit management\n");
>> +	}
> 
> Can we just do
> 
> 	if (cpu_can_use_dbm(cap))
> 		pr_info_once(...);
> 
> Then we can get rid of "detected".

The reason for open coding is the cost of cpu_can_use_dbm() with
addition of black listed CPUs in the next patch in the series.

Cheers
Suzuki
