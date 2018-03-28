Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AIpwx4998/4ShHM+KMevNP8bb2T4gkRhWrJ99zEb1GDRbBqNHCgAqdN4xkOLH+wJpoaw/x0NcPfh
ARC-Seal: i=1; a=rsa-sha256; t=1522220377; cv=none;
        d=google.com; s=arc-20160816;
        b=oG1S19pU4wdYurkXH4AjqDk4gTrNC5htqRcHJ2lbayVLhJ7EJhzSNWwIRE1AoCFWUA
         LExVsoBRpUT9uF0pupOwYqzrKXwMdOdguyIZSC7DBuPlzBgdFByj614pJvnBihC7SU69
         zKmydOfYXbeo2XCWvqlEcuVOCPt6N76hcJCxTIag9B++bjOY0lz0NLkMbqK9/ytvjqY3
         XQuA96lvvDe1+LcBdazeywfB2TtA01tx0SEjdyVN5wGJRV9XjxG2uDnjE7DY0HJIvcBz
         iLQ+4/npQLXn5Xb4YXOFGedQsjhZne/MuEIHGXf1sDes9CM8M6B5Dg2HopyUx7qOMZal
         RGaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=kc4Mg7cFL08kN7wL67ohQiMKdJLsH6tumkURH4eykPU=;
        b=WbW3Q5xHfgpRX0rNxO1SqRNel7iYsjbGUn+vBsMvRKBpjiNzYc4o/0GN2fJxTI5ALB
         nQQyZQ10ogf5CodKiGrg1tl/OJ9dVwxplE4z3mOUvJ+zmC1gSFbpgE1I83gcrEaLqg+O
         SYqFI0gK+hWRRuBKAQDLkLJQCp+T981kMmyQDePe9C/MZLZDbhpUoeeHUhFhKlBUWSda
         M3jU6IIxauweUn0oli0eSK+dhTP9Xe+lqhOV7wCrfS/i3v5NGIngvSvtm4HDW+7ZxlxP
         4U20FVBh/ABpABYNHVcw43JCUJnJczTc4yThpp5UgLrKYQ3UOij8+XT20oYunUX2TApq
         eghA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Rr5htpRk;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=lEO9zHg7;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Rr5htpRk;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=lEO9zHg7;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3013260588
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH v5 3/4] arm64: Implement page table free interfaces
To: Will Deacon <will.deacon@arm.com>
Cc: catalin.marinas@arm.com, mark.rutland@arm.com, toshi.kani@hpe.com,
 arnd@arndb.de, ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
 james.morse@arm.com, kristina.martsenko@arm.com, takahiro.akashi@linaro.org,
 gregkh@linuxfoundation.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, akpm@linux-foundation.org
References: <1522157100-16879-1-git-send-email-cpandya@codeaurora.org>
 <1522157100-16879-4-git-send-email-cpandya@codeaurora.org>
 <20180327180048.GJ18435@arm.com>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <3a9610af-c35d-2624-87a6-71f893740fa4@codeaurora.org>
Date: Wed, 28 Mar 2018 12:29:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327180048.GJ18435@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595007777008930452?=
X-GMAIL-MSGID: =?utf-8?q?1596163754937492001?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 3/27/2018 11:30 PM, Will Deacon wrote:
> Hi Chintan,
Hi Will,

> 
> On Tue, Mar 27, 2018 at 06:54:59PM +0530, Chintan Pandya wrote:
>> Implement pud_free_pmd_page() and pmd_free_pte_page().
>>
>> Implementation requires,
>>   1) Freeing of the un-used next level page tables
>>   2) Clearing off the current pud/pmd entry
>>   3) Invalidate TLB which could have previously
>>      valid but not stale entry
>>
>> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
>> ---
>> V4->V5:
>>   - Using __flush_tlb_kernel_pgtable instead of
>>     flush_tlb_kernel_range
>>
>>
>>   arch/arm64/mm/mmu.c | 33 +++++++++++++++++++++++++++++++--
>>   1 file changed, 31 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index da98828..3552c7a 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -45,6 +45,7 @@
>>   #include <asm/memblock.h>
>>   #include <asm/mmu_context.h>
>>   #include <asm/ptdump.h>
>> +#include <asm/tlbflush.h>
>>   
>>   #define NO_BLOCK_MAPPINGS	BIT(0)
>>   #define NO_CONT_MAPPINGS	BIT(1)
>> @@ -973,12 +974,40 @@ int pmd_clear_huge(pmd_t *pmdp)
>>   	return 1;
>>   }
>>   
>> +static int __pmd_free_pte_page(pmd_t *pmd, unsigned long addr, bool tlb_inv)
>> +{
>> +	pmd_t *table;
>> +
>> +	if (pmd_val(*pmd)) {
> 
> Please can you follow what I did in 20a004e7b017 ("arm64: mm: Use
> READ_ONCE/WRITE_ONCE when accessing page tables") and:
> 
>    1. Use consistent naming, so pmd_t * pmdp.
>    2. Use READ_ONCE to dereference the entry once into a local.
> 
> Similarly for the pud code below.

Sure. I'll fix this in v6.

> 
>> +		table = __va(pmd_val(*pmd));
>> +		pmd_clear(pmd);
>> +		if (tlb_inv)
>> +			__flush_tlb_kernel_pgtable(addr);
>> +
>> +		free_page((unsigned long) table);
> 
> Hmm. Surely it's only safe to call free_page if !tlb_inv in situations when
> the page table is already disconnected at a higher level? That doesn't
> appear to be the case with the function below, which still has the pud
> installed. What am I missing?
> 

Point ! Without the invalidation, free'ing a page is not safe. Better, I
do __flush_tlb_kernel_pgtable() every time. This might not be as costly
as flush_tlb_kernel_range().

>> +	}
>> +	return 1;
>> +}
>> +
>>   int pud_free_pmd_page(pud_t *pud, unsigned long addr)
>>   {
>> -	return pud_none(*pud);
>> +	pmd_t *table;
>> +	int i;
>> +
>> +	if (pud_val(*pud)) {
>> +		table = __va(pud_val(*pud));
>> +		for (i = 0; i < PTRS_PER_PMD; i++)
>> +			__pmd_free_pte_page(&table[i], addr + (i * PMD_SIZE),
>> +						false);
>> +
>> +		pud_clear(pud);
>> +		flush_tlb_kernel_range(addr, addr + PUD_SIZE);
> 
> Why aren't you using __flush_tlb_kernel_pgtable here?
> 

Now that I will call __flush_tlb_kernel_pgtable() for every  PMD, I can
use __flush_tlb_kernel_pgtable() here as well.

Previously, the thought was, while invalidating PUD by VA would not work
always because PUD may have next level of valid mapping still present in
the table (valid next PMD but invalid next-to-next PTE). In this case
doing just __flush_tlb_kernel_pgtable() for PUD might not be enough. We
need to invalidate subsequent tables as well which I was skipping for 
optimization. So, I used flush_tlb_kernel_range().

I will upload v6.

> Will
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
