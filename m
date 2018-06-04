Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753198AbeFDNnD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 09:43:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48708 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752774AbeFDNnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 09:43:02 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5E70B60224
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH v12 5/5] arm64: Allow huge io mappings again
To: Will Deacon <will.deacon@arm.com>
Cc: catalin.marinas@arm.com, mark.rutland@arm.com,
        akpm@linux-foundation.org, toshi.kani@hpe.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1527856758-27169-1-git-send-email-cpandya@codeaurora.org>
 <1527856758-27169-6-git-send-email-cpandya@codeaurora.org>
 <20180604121452.GK9482@arm.com>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <d7118026-2f37-85e0-9f4e-854b34b23e57@codeaurora.org>
Date: Mon, 4 Jun 2018 19:12:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180604121452.GK9482@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/4/2018 5:44 PM, Will Deacon wrote:
> On Fri, Jun 01, 2018 at 06:09:18PM +0530, Chintan Pandya wrote:
>> Huge mappings have had stability issues due to stale
>> TLB entry and memory leak issues. Since, those are
>> addressed in this series of patches, it is now safe
>> to allow huge mappings.
>>
>> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
>> ---
>>   arch/arm64/mm/mmu.c | 18 ++----------------
>>   1 file changed, 2 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 6e7e16c..c65abc4 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -934,15 +934,8 @@ int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
>>   {
>>   	pgprot_t sect_prot = __pgprot(PUD_TYPE_SECT |
>>   					pgprot_val(mk_sect_prot(prot)));
>> -	pud_t new_pud = pfn_pud(__phys_to_pfn(phys), sect_prot);
>> -
>> -	/* Only allow permission changes for now */
>> -	if (!pgattr_change_is_safe(READ_ONCE(pud_val(*pudp)),
>> -				   pud_val(new_pud)))
>> -		return 0;
> 
> Do you actually need to remove these checks? If we're doing
> break-before-make properly, then the check won't fire but it would be
> good to keep it there so we can catch misuse of these in future.
> 
> In other words, can we drop this patch?

Yes, we don't need this patch as BBM is happening before this. I missed
that. I'll remove this patch in v13.

> 
> Will
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
