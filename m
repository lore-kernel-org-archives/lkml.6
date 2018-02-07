Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754139AbeBGNYY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 08:24:24 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50846 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753720AbeBGNYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 08:24:23 -0500
Subject: Re: [PATCH 1/2] arm64: Relax constraints on ID feature bits
To: Dave Martin <Dave.Martin@arm.com>
Cc: mark.rutland@arm.com, Marc Zyngier <Marc.Zyngier@arm.com>,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20180201103838.14702-1-suzuki.poulose@arm.com>
 <20180207104048.GL5862@e103592.cambridge.arm.com>
 <88c4ae47-60d3-3980-7271-6f4795360563@arm.com>
 <20180207123419.GP5862@e103592.cambridge.arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <df31e61b-d3c1-70f3-d31c-df5fc034e188@arm.com>
Date: Wed, 7 Feb 2018 13:24:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180207123419.GP5862@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/18 12:34, Dave Martin wrote:
> On Wed, Feb 07, 2018 at 11:41:17AM +0000, Suzuki K Poulose wrote:
>> On 07/02/18 10:40, Dave Martin wrote:

...

>> To summarise, I can add LOR/HPD changes. But the others requires a bit more
>> work and can be done as a separate series.
>>
>>> I've wondered in the past whether there is redundancy between the strict
>>> and type fields, but when adding entries I just copy-pasted similar ones
>>> rather than fully understanding what was going on...
>>
>> I agree. These were defined before we started using the system wide safe
>> values and enforcing the capabilities on late/secondary CPUs. Now that
>> we have an infrastructure which makes sure that conflicts are handled,
>> we could relax the definitions a bit.
> 
> OK, I this sounds reasonable and I think it all falls under "potential
> future cleanups".
> 
> A few nits below.
> 
> [...]
> 
>>>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> 
> [...]
> 
>>>> -	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_ASID_SHIFT, 4, 0),
>>>> +	/* We handle differing ASID widths by explicit checks to make sure the system is safe */
> 
> Where is this checked?  Because of the risk of breaking this
> relationship during maintenance, perhaps we should have a comment in
> both places.

This is checked via verify_cpu_asid_bits() from check_early_cpu_features(), on all
secondary CPUs. I will mention it in the comment.

>>>> -	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_VHE_SHIFT, 4, 0),
>>>> +	/* When CONFIG_ARM64_VHE is enabled, we ensure that there is no conflict */
> 
> Similarly to _ASID, where/how?
> 

This is done via verify_cpu_run_el() from check_early_cpu_features(). But with the rewrite
of the capabilities frame work, we move it to the capabilities infrastructure BOOT_CPU features.

>>>>   static const struct arm64_ftr_bits ftr_id_aa64mmfr2[] = {
>>>>   	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_LVA_SHIFT, 4, 0),
>>>> -	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_IESB_SHIFT, 4, 0),
>>>> +	/* While IESB is good to have, it is not fatal if we miss this on some CPUs */
> 
> Maybe this deserves slightly more explanation.  We could say that
> lacking implicit IESB on exception boundary on a subset of CPUs is no
> worse than lacking it on all of them.

OK.

Cheers
Suzuki
