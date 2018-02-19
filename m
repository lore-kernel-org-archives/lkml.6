Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753169AbeBSQfh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 11:35:37 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56012 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753064AbeBSQfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 11:35:36 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 622316032D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=shankerd@codeaurora.org
Reply-To: shankerd@codeaurora.org
Subject: Re: [PATCH] arm64: Add support for new control bits CTR_EL0.IDC and
 CTR_EL0.IDC
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Philip Elcan <pelcan@codeaurora.org>,
        Vikram Sethi <vikrams@codeaurora.org>,
        Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <1518829066-3558-1-git-send-email-shankerd@codeaurora.org>
 <20180219143820.5oxc2kendvq4bbtt@armageddon.cambridge.arm.com>
From: Shanker Donthineni <shankerd@codeaurora.org>
Message-ID: <92836754-2ab3-d5db-f0be-7ee3e10f368f@codeaurora.org>
Date: Mon, 19 Feb 2018 10:35:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180219143820.5oxc2kendvq4bbtt@armageddon.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On 02/19/2018 08:38 AM, Catalin Marinas wrote:
> On Fri, Feb 16, 2018 at 06:57:46PM -0600, Shanker Donthineni wrote:
>> Two point of unification cache maintenance operations 'DC CVAU' and
>> 'IC IVAU' are optional for implementors as per ARMv8 specification.
>> This patch parses the updated CTR_EL0 register definition and adds
>> the required changes to skip POU operations if the hardware reports
>> CTR_EL0.IDC and/or CTR_EL0.IDC.
>>
>> CTR_EL0.DIC: Instruction cache invalidation requirements for
>>  instruction to data coherence. The meaning of this bit[29].
>>   0: Instruction cache invalidation to the point of unification
>>      is required for instruction to data coherence.
>>   1: Instruction cache cleaning to the point of unification is
>>       not required for instruction to data coherence.
>>
>> CTR_EL0.IDC: Data cache clean requirements for instruction to data
>>  coherence. The meaning of this bit[28].
>>   0: Data cache clean to the point of unification is required for
>>      instruction to data coherence, unless CLIDR_EL1.LoC == 0b000
>>      or (CLIDR_EL1.LoUIS == 0b000 && CLIDR_EL1.LoUU == 0b000).
>>   1: Data cache clean to the point of unification is not required
>>      for instruction to data coherence.
> 
> There is a difference between cache maintenance to PoU "is not required"
> and the actual instructions being optional (i.e. undef when executed).
> If your caches are transparent and DC CVAU/IC IVAU is not required,
> these instructions should behave as NOPs. So, are you trying to improve
> the performance of the cache maintenance routines in the kernel? If yes,
> please show some (relative) numbers and a better description in the
> commit log.
> 

Yes, I agree with you, POU instructions are NOPs if the caches are transparent.
There was no issue as per correctness point of view. But causing the unnecessary
overhead in ASM routines where code goes thorough VA range incremented
by cache line size. This overhead is noticeable with 64K PAGE, especially with 
sections mappings. I'll reword the commit text to reflect your comments in v2 patch.

e.g. 512M section with 64K PAGE_SIZE kernel, assume 64Bytes cache size.
     flush_icache_range() consumes around 256M cpu cycles
 
Icache loop overhead: 512Mbytes / 64Bytes * 4 instructions per loop
Dcache loop overhead: 512Mbytes / 64Bytes * 4 instructions per loop


With this patch it takes less than ~1K cycles.

 
> On the patch, I'd rather have an alternative framework entry for no VAU
> cache maint required and some ret instruction at the beginning of the
> cache maint function rather than jumping out of the loop somewhere
> inside the cache maintenance code, penalising the CPUs that do require
> it.
> 

Alternative framework might break things in case of CPU hotplug. I need one
more confirmation from you on incorporating alternative framework.     

-- 
Shanker Donthineni
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
