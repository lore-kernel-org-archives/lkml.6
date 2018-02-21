Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935662AbeBUNcH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 08:32:07 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57190 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933525AbeBUNKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 08:10:38 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EB4D260590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=shankerd@codeaurora.org
Reply-To: shankerd@codeaurora.org
Subject: Re: [PATCH v2] arm64: Add support for new control bits CTR_EL0.DIC
 and CTR_EL0.IDC
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Thomas Speier <tspeier@codeaurora.org>,
        Vikram Sethi <vikrams@codeaurora.org>,
        Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Philip Elcan <pelcan@codeaurora.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <1519095546-24420-1-git-send-email-shankerd@codeaurora.org>
 <20180221111233.gylb6v4yxqnn6gyj@localhost>
From: Shanker Donthineni <shankerd@codeaurora.org>
Message-ID: <23d70753-a628-f2e4-84df-39e4021337f5@codeaurora.org>
Date: Wed, 21 Feb 2018 07:10:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180221111233.gylb6v4yxqnn6gyj@localhost>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On 02/21/2018 05:12 AM, Catalin Marinas wrote:
> On Mon, Feb 19, 2018 at 08:59:06PM -0600, Shanker Donthineni wrote:
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index f55fe5b..4061210 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -1095,6 +1095,27 @@ config ARM64_RAS_EXTN
>>  	  and access the new registers if the system supports the extension.
>>  	  Platform RAS features may additionally depend on firmware support.
>>  
>> +config ARM64_CACHE_IDC
>> +	bool "Enable support for DCache clean PoU optimization"
>> +	default y
>> +	help
>> +	  The data cache clean to the point of unification is not required
>> +	  for instruction to be data coherence if CTR_EL0.IDC has value 1.
>> +
>> +	  Selecting this feature will allow the kernel to optimize the POU
>> +	  cache maintaince operations where it requires 'DC CVAU'.
>> +
>> +config ARM64_CACHE_DIC
>> +	bool "Enable support for ICache invalidation PoU optimization"
>> +	default y
>> +	help
>> +	  Instruction cache invalidation to the point of unification is not
>> +	  required for instruction to be data coherence if CTR_EL0.DIC has
>> +	  value 1.
>> +
>> +	  Selecting this feature will allow the kernel to optimize the POU
>> +	  cache maintaince operations where it requires 'IC IVAU'.
> 
> A single Kconfig entry is sufficient for both features.
> 

I'll do in v3 patch.

>> @@ -864,6 +864,22 @@ static bool has_no_fpsimd(const struct arm64_cpu_capabilities *entry, int __unus
>>  					ID_AA64PFR0_FP_SHIFT) < 0;
>>  }
>>  
>> +#ifdef CONFIG_ARM64_CACHE_IDC
>> +static bool has_cache_idc(const struct arm64_cpu_capabilities *entry,
>> +			  int __unused)
>> +{
>> +	return !!(read_sanitised_ftr_reg(SYS_CTR_EL0) & (1UL << CTR_IDC_SHIFT));
>> +}
>> +#endif
>> +
>> +#ifdef CONFIG_ARM64_CACHE_DIC
>> +static bool has_cache_dic(const struct arm64_cpu_capabilities *entry,
>> +			  int __unused)
>> +{
>> +	return !!(read_sanitised_ftr_reg(SYS_CTR_EL0) & (1UL << CTR_DIC_SHIFT));
>> +}
>> +#endif
> 
> Nitpick: no need for !! since the function type is bool already.
> 

Sure, I'll remove '!!'.

>> diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
>> index 758bde7..7d37d71 100644
>> --- a/arch/arm64/mm/cache.S
>> +++ b/arch/arm64/mm/cache.S
>> @@ -50,6 +50,9 @@ ENTRY(flush_icache_range)
>>   */
>>  ENTRY(__flush_cache_user_range)
>>  	uaccess_ttbr0_enable x2, x3, x4
>> +alternative_if ARM64_HAS_CACHE_IDC
>> +	b	8f
>> +alternative_else_nop_endif
>>  	dcache_line_size x2, x3
>>  	sub	x3, x2, #1
>>  	bic	x4, x0, x3
>> @@ -60,6 +63,11 @@ user_alt 9f, "dc cvau, x4",  "dc civac, x4",  ARM64_WORKAROUND_CLEAN_CACHE
>>  	b.lo	1b
>>  	dsb	ish
>>  
>> +8:
>> +alternative_if ARM64_HAS_CACHE_DIC
>> +	mov	x0, #0
>> +	b	1f
>> +alternative_else_nop_endif
>> 	invalidate_icache_by_line x0, x1, x2, x3, 9f
>> 	mov	x0, #0
>>  1:
> 
> You can add another label at mov x0, #0 below this hunk and keep a
> single instruction in the alternative path.
> 
> However, my worry is that in an implementation with DIC set, we also
> skip the DSB/ISB sequence in the invalidate_icache_by_line macro. For
> example, in an implementation with transparent PoU, we could have:
> 
> 	str	<some instr>, [addr]
> 	// no cache maintenance or barrier
> 	br	<addr>
> 

Thanks for pointing out the missing barriers. I think it make sense to follow
the existing barrier semantics in order to avoid the unknown things.
 
> Is an ISB required between the instruction store and execution? I would
> say yes but maybe Will has a better opinion here.
> 
Agree, an ISB is required especially for self-modifying code. I'll include in v3 patch. 

-- 
Shanker Donthineni
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
