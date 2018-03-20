Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AG47ELtAOZKvVgKElipkW0/qBcL7ClKSRLsC/RrHwO8Nb6xDEwlaLdYf2MN3MsdsbyY28P8sMYGQ
ARC-Seal: i=1; a=rsa-sha256; t=1521529581; cv=none;
        d=google.com; s=arc-20160816;
        b=tnO78V4N24ZKwUiXActG9p86o6gkAKjL+tTDAxv5TUp6kM5JaoCqFN6osKk9w72fCP
         bXFnJThb1vRgqQFIXBkLbgt7Kv1ItabONrWWkNFGgZQViW37SuHOW5WvKMF4tLKHiFGl
         TukSfQrm+V7QKKM3cR8JZGh94wuJKs1ETFavC0FLgcJpX8gkUVjSQgJPqMTn7g2atTq/
         OoF3F0AS5QgJHo36ZDB9hnxF26NP9+4Hv8jFx5LWmk2XtTtSgh9aqoigzvRKIDwMQ9MF
         RIdGN07sPva3GcJPHS3lOrwetGe790LdYbUCa3m56lCKj+0507YEuZ/G4RdF4hdm9KAt
         QSiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=2oF289IOF/tqxW3h0H4piUKvRu8YmDjOt7Kt3fM/ejo=;
        b=QUaBmiElRVARIW3fZSM9ce56HTQP0eXKL/MkTdhnPVX4M22Leskbdf1RyVF2bvrI4S
         JamAD8KqBcRiOToDl1vPT2n4sLH9f2yFxsXnGf/a7h5k4DGLpE+NzFnm16jy9NYcQqbu
         3SCWlQCYHJZxUs+xJuTwbh7Rl62JHkOqBeVd126Fu5DQH7zyfJR9DGHK2GYHMkW84vqa
         xQfUCUmpXfeEZSI6GRIO5N7GlIEv+x6YQGeMgrwd5dudG/allHSflqzvS7g61dwTozjg
         l2+cIsUtiX667Th6BLtopmqA5mWcyAtZ5KvlqopsM8utSvuyCDahbtCezqFHSVZAqdMn
         askQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=VVQc3Er0;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ENvVdtCi;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=VVQc3Er0;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ENvVdtCi;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 117DE60128
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH v3 2/3] arm64: Implement page table free interfaces
To: "Kani, Toshi" <toshi.kani@hpe.com>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "takahiro.akashi@linaro.org" <takahiro.akashi@linaro.org>,
 "james.morse@arm.com" <james.morse@arm.com>,
 "kristina.martsenko@arm.com" <kristina.martsenko@arm.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "arnd@arndb.de"
 <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <1521463256-19858-1-git-send-email-cpandya@codeaurora.org>
 <1521463256-19858-3-git-send-email-cpandya@codeaurora.org>
 <1521487759.2693.224.camel@hpe.com>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <be70a3da-be35-cdee-97a4-ca4e867ca7fb@codeaurora.org>
Date: Tue, 20 Mar 2018 12:36:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521487759.2693.224.camel@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595007777008930452?=
X-GMAIL-MSGID: =?utf-8?q?1595439402788338224?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 3/20/2018 12:59 AM, Kani, Toshi wrote:
> On Mon, 2018-03-19 at 18:10 +0530, Chintan Pandya wrote:
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
>>   arch/arm64/mm/mmu.c | 30 ++++++++++++++++++++++++++++--
>>   1 file changed, 28 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index da98828..c70f139 100644
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
>> @@ -975,10 +976,35 @@ int pmd_clear_huge(pmd_t *pmdp)
>>   
>>   int pud_free_pmd_page(pud_t *pud, unsigned long addr)
>>   {
>> -	return pud_none(*pud);
>> +	pmd_t *pmd;
>> +	int i;
>> +
>> +	pmd = __va(pud_val(*pud));
>> +	if (pud_val(*pud)) {
>> +		for (i = 0; i < PTRS_PER_PMD; i++)
>> +			pmd_free_pte_page(&pmd[i], addr + (i * PMD_SIZE));
>> +
>> +		free_page((unsigned long) pmd);
> 
> Why do you want to free this pmd page before clearing the pud entry on
> this arm64 version (as it seems you intentionally changed it from the
> x86 version)?  It can be reused while being pointed by the pud.  Same
> for pmd.
Noted.
> 
>> +		pud_clear(pud);
>> +		flush_tlb_kernel_range(addr, addr + PUD_SIZE);
> 
> Since you purge the entire pud range here, do you still need to call
> pmd_free_pte_page() to purge each pmd range?  This looks very expensive.
> You may want to consider if calling internal __pmd_free_pte_page()
> without the purge operation works.
I completely missed that. Sure, will fix this.

I will upload v4 fixing all 4 comments.
> 
> -Toshi
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
