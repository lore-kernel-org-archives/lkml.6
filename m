Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751343AbeBHMTX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 07:19:23 -0500
Received: from foss.arm.com ([217.140.101.70]:34268 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750853AbeBHMTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 07:19:21 -0500
Subject: Re: [PATCH v2 17/20] arm64: bp hardening: Allow late CPUs to enable
 work around
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        ckadabi@codeaurora.org, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
 <20180131182807.32134-18-suzuki.poulose@arm.com>
 <20180207103942.GH5862@e103592.cambridge.arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <b4705fa2-39aa-9fea-78c4-03ac5eb48a49@arm.com>
Date: Thu, 8 Feb 2018 12:19:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180207103942.GH5862@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/18 10:39, Dave Martin wrote:
> On Wed, Jan 31, 2018 at 06:28:04PM +0000, Suzuki K Poulose wrote:
>> We defend against branch predictor training based exploits by
>> taking specific actions (based on the CPU model) to invalidate
>> the Branch predictor buffer (BPB). This is implemented by per-CPU
>> ptr, which installs the specific actions for the CPU model.
>>
>> The core code can handle the following cases where:
>>   1) some CPUs doesn't need any work around
>>   2) a CPU can install the work around, when it is brought up,
>>      irrespective of how late that happens.

With the recent patches from Marc to expose this information to KVM
guests, it looks like allowing a late CPU to turn this on is not going
to be a good idea. We unconditionally set the capability even
when we don't need the mitigation. So I am not really sure if
we should go ahead with this patch. I am open to suggestions

Marc,

What do you think ?

>>
>> This concludes that it is safe to bring up a CPU which requires
>> bp hardening defense. However, with the current settings, we
>> reject a late CPU, if none of the active CPUs didn't need it.
> 
> Should this be "[...] reject a late CPU that needs the defense, if none
> of the active CPUs needed it." ?

Thats right. Will fix it.

> 
>>
>> This patch solves issue by changing the flags for the capability
>> to indicate that it is safe for a late CPU to turn up with the
>> capability. This is not sufficient to get things working, as
>> we cannot change the system wide state of the capability established
>> at the kernel boot. So, we "set" the capability unconditionally
>> and make sure that the call backs are only installed for those
>> CPUs which actually needs them. This is done by adding a dummy
>> entry at the end of the list of shared entries, which :
>>   a) Always returns true for matches, to ensure we turn this on.
>>   b) has an empty "cpu_enable" call back, so that we don't take
>>      any action on the CPUs which weren't matched with the real
>>      entries.
>>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Dave Martin <dave.martin@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>


>> +
>>   static const struct arm64_cpu_capabilities arm64_bp_harden_list[] = {
>>   	{
>>   		CAP_MIDR_RANGE_LIST(arm64_bp_harden_psci_cpus),
>> @@ -268,6 +274,17 @@ static const struct arm64_cpu_capabilities arm64_bp_harden_list[] = {
>>   		CAP_MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR_V1),
>>   		.cpu_enable = qcom_enable_link_stack_sanitization,
>>   	},
>> +	/*
>> +	 * Always enable the capability to make sure a late CPU can
>> +	 * safely use the BP hardening call backs. Since we use per-CPU
>> +	 * pointers for the call backs, the work around only affects the
>> +	 * CPUs which have some methods installed by any real matching entries
>> +	 * above. As such we don't have any specific cpu_enable() callback
>> +	 * for this entry, as it is just to make sure we always "detect" it.
>> +	 */
>> +	{
>> +		.matches = bp_hardening_always_on,
> 
> This function could simply be called "always_on", since it expresses
> something entirely generic and is static.

Sure, if we still go ahead with this.

> 
>> +	},
> 
> This feels like a bit of a hack: really there is no global on/off
> state for a cap like this: it's truly independent for each cpu.

Yea, I kind of didn't like it, but that does the job ;-).

> 
> OTOH, your code does achieve that, and the comment gives a good
> explanation.
> 
> The alternative would be to add a cap type flag to indicate that
> this cap is purely CPU-local, but it may not be worth it at this
> stage.

Agree. Thats going to make the code a bit more complex than it is already.

Cheers
Suzuki
