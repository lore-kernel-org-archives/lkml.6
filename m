Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AG47ELtnsnjz5XdMX5n3RXWCNwg9QAYA3D84X9aOaG/hKfeMmCnJktzJXr7Uk+tNF8qCL4FtuBP8
ARC-Seal: i=1; a=rsa-sha256; t=1521433763; cv=none;
        d=google.com; s=arc-20160816;
        b=rtWj9w7YJXxGgYZ5UJZbVsMM6mMXDKCu9JQTxOai3zAMCksHc68w9G1PMe9bfuWuNC
         iTDD3tRYhs4GelgL44cucqOMXA13LjOr/nPIibRxmH+LJcNyn/hX/ti2dfcn0ixWS48v
         jt44xSj8ET8YDvdkiRKxYoQPwDnUvVaUId0Q1xcN/suu1lflvKAVkoaw81o6QrKOhuyt
         Rzg9tdzRyyf6428tfm1m6QjG2Ke8z9H7kDtE3aIWqt68aAY3GGsQOVralTOB8JdF90dB
         cEOOpo37ZuCIy2qYKb2nIaKpGPg1elTlf8XXOWvoTHk/OMA0q4PYXzc4EVK5oSSvmz/O
         G2vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=BLbqFzeK8gG7x764LxLMazvvriubanubCVrlSE8z0Ks=;
        b=FG4BNePU1uuR3D51xomOnTjwXUt75c8HrLEpXdRRlkeo81BzvCTbJenMzsEVfFLSmP
         Yckq5UdSe8opIXQQCo/s51IiN9BzNWo9XF/kAoSvIk8wciL37tIY/U+gRKrwX7AtNTJI
         SNkREsgZjaUvzUETGYDeOtfJ0y/3ocAEQTbELh7coduAQiuuTEePbeUQ6YzIZtRra8zU
         CuWXRLcr7UQBYoX/vtKYea28tHu+zI2qP4qIKpAXm9rUlw2yNJLNfZlAshmJiH4HsRmf
         a4FdkPlOcOYhQfC55x62X1sRIFxm1IrDe2A/Hdv/7fJZidbv80lJhLefzc2sXpHDXWgf
         JSZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=UMvHXL3+;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Fm+2jpmn;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=UMvHXL3+;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Fm+2jpmn;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F8FD6055B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH v2 3/4] arm64: Implement page table free interfaces
To: Mark Rutland <mark.rutland@arm.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de,
 ard.biesheuvel@linaro.org, marc.zyngier@arm.com, james.morse@arm.com,
 kristina.martsenko@arm.com, takahiro.akashi@linaro.org,
 gregkh@linuxfoundation.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, akpm@linux-foundation.org, toshi.kani@hpe.com
References: <1521117906-20107-1-git-send-email-cpandya@codeaurora.org>
 <1521117906-20107-4-git-send-email-cpandya@codeaurora.org>
 <20180315131846.sfpxg3xlpjii3nju@lakrids.cambridge.arm.com>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <cada7499-acb1-dc99-bec3-f7dba00a80cc@codeaurora.org>
Date: Mon, 19 Mar 2018 09:59:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315131846.sfpxg3xlpjii3nju@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595007777008930452?=
X-GMAIL-MSGID: =?utf-8?q?1595338930463113194?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 3/15/2018 6:48 PM, Mark Rutland wrote:
> On Thu, Mar 15, 2018 at 06:15:05PM +0530, Chintan Pandya wrote:
>> Implement pud_free_pmd_page() and pmd_free_pte_page().
>>
>> Make sure, that they are indeed a page table before
>> taking them to free.
> 
> As mentioned on the prior patch, if the tables we're freeing contain
> valid entries, then we need additional TLB maintenance to ensure that
> all of these entries have been removed from TLBs.
> 
> Either, we always invalidate the entire range, or we walk the tables
> and invalidate as we remove them.

Right. I'll send v3 and ensure this. Thinking like, we can
invalidate page table in PMD case and invalidate range if it's pud.
Will see if that also can be optimized.

> 
> Thanks,
> Mark.
> 
>>
>> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
>> ---
>>   arch/arm64/mm/mmu.c | 20 ++++++++++++++++++--
>>   1 file changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 2dbb2c9..6f21a65 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -32,6 +32,7 @@
>>   #include <linux/io.h>
>>   #include <linux/mm.h>
>>   #include <linux/vmalloc.h>
>> +#include <linux/hugetlb.h>
>>   
>>   #include <asm/barrier.h>
>>   #include <asm/cputype.h>
>> @@ -45,6 +46,7 @@
>>   #include <asm/memblock.h>
>>   #include <asm/mmu_context.h>
>>   #include <asm/ptdump.h>
>> +#include <asm/page.h>
>>   
>>   #define NO_BLOCK_MAPPINGS	BIT(0)
>>   #define NO_CONT_MAPPINGS	BIT(1)
>> @@ -975,10 +977,24 @@ int pmd_clear_huge(pmd_t *pmdp)
>>   
>>   int pud_free_pmd_page(pud_t *pud)
>>   {
>> -	return pud_none(*pud);
>> +	pmd_t *pmd;
>> +	int i;
>> +
>> +	pmd = __va(pud_val(*pud));
>> +	if (pud_val(*pud) && !pud_huge(*pud)) {
>> +		for (i = 0; i < PTRS_PER_PMD; i++)
>> +			pmd_free_pte_page(&pmd[i]);
>> +
>> +		free_page((unsigned long)pmd);
>> +	}
>> +
>> +	return 1;
>>   }
>>   
>>   int pmd_free_pte_page(pmd_t *pmd)
>>   {
>> -	return pmd_none(*pmd);
>> +	if (pmd_val(*pmd) && !pmd_huge(*pmd))
>> +		free_page((unsigned long)__va(pmd_val(*pmd)));
>> +
>> +	return 1;
>>   }
>> -- 
>> Qualcomm India Private Limited, on behalf of Qualcomm Innovation
>> Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
>> Collaborative Project
>>

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
