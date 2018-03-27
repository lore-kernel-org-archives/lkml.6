Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeC0Av4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 20:51:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49110 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751776AbeC0Avz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 20:51:55 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2F8F1603AF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pelcan@codeaurora.org
Subject: Re: [PATCH] arm64: tlbflush: avoid writing RES0 bits
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        Thomas Speier <tspeier@codeaurora.org>,
        Shanker Donthineni <shankerd@codeaurora.org>
References: <1521666172-2494-1-git-send-email-pelcan@codeaurora.org>
 <20180326100220.zbu4dfojofmbesp4@lakrids.cambridge.arm.com>
From: Philip Elcan <pelcan@codeaurora.org>
Message-ID: <9624b762-a26e-36da-b0a2-4087f0a2069c@codeaurora.org>
Date: Mon, 26 Mar 2018 20:51:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180326100220.zbu4dfojofmbesp4@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/2018 6:02 AM, Mark Rutland wrote:
> On Wed, Mar 21, 2018 at 05:02:52PM -0400, Philip Elcan wrote:
>> Bits [47:44] of the TLBI register operand are RES0 for instructions that
>> require a VA, per the ARM ARM spec, so TLBI operations should avoid writing
>> non-zero values to these bits.
>>
>> Signed-off-by: Philip Elcan <pelcan@codeaurora.org>
>> ---
>>  arch/arm64/include/asm/tlbflush.h | 16 ++++++++++------
>>  1 file changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
>> index 9e82dd7..dbd22a9 100644
>> --- a/arch/arm64/include/asm/tlbflush.h
>> +++ b/arch/arm64/include/asm/tlbflush.h
>> @@ -60,6 +60,9 @@
>>  		__tlbi(op, (arg) | USER_ASID_FLAG);				\
>>  } while (0)
>>  
>> +/* This macro masks out RES0 bits in the TLBI operand */
>> +#define __TLBI_VADDR(addr) (addr & ~GENMASK_ULL(47, 44))
> 
> If we're going to mask the address bits, it would be simpler to keep the
> valid bits than to clear the invalid bits. i.e.
> 
> #define __TLBI_VADDR(addr) (addr & GENMASK_ULL(43, 0))
> 
> Maybe we want a helper that does all of the addr / asid shifting and
> masking, so we do that in one place rather than spreading it across all
> helpers, e.g.
> 
> #define __tlbi_addr(addr, asid)				\
> ({							\
> 	unsigned long __ta = (addr) >> 12;		\
> 	__ta &= GENMASK_ULL(43, 0);			\
> 	__ta |= (asid) << 48;				\
> 	__ta;						\
> })
> 
> Thanks,
> Mark.
> 

That makes sense and addresses Robin's comment as well. I'll send out a
v2 with your suggestion.

Thanks,
Philip

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
