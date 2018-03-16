Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AG47ELs2/3w9e9XFXGxtcVMi10IWfhFGr+vOCJd+Fs1D7QhwY/hOPNRgeFuiDh6nWja/XGk5AkPy
ARC-Seal: i=1; a=rsa-sha256; t=1521186023; cv=none;
        d=google.com; s=arc-20160816;
        b=JGyXMGV86M4bunNU3yK+QdjwRb+yBaD1HI2frFiZuXitnZkas2J1C0+Ezkv2DaYIda
         4v2uvalgcfLO2pY9ULerYnMtU8ymT0x9kZGAlLY7vQh9hvW+1nceIsZ+KJlqa5GYwq6H
         VtDsNT8svt+k/e06VUSUkCVCzZu/ZHuwyUKLg+8FDSSuR6r3dOZhfTGf4QereslhWESW
         XHvLHB6H3Om3eCNK66NskdS0lBTmdSMf/YmSy+wMbTHDmhghI2Hc3fd7rAIFWOL+3Hf0
         jtsYXltnWika7dLuE2D+I5yh0VOv03ADhbz8/ui7znUtAbLfRJ8ZHXSatPfKzHh+kfHk
         1kWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=m6GeFnXC/z0m0O9/Mx1uc12/pfGEiSkjVMAzS0bVgEU=;
        b=rwIPkkgZQPiRgSwhx06orLNrDXBgRyC/4CFDWXJrzlk52SiDL/+4Z6TvwYsMz92g5H
         IBXrt8vVvqepSpJQKQIXvWnbDkocwKxu0tevoieik79m2TIuL5C1xRufpqClsZH1QXeS
         NY7UGwmzTUzJRB6clrHkGy9C3/QhDkt3It8HdfTaQct/TlrbSAg3YF0YuUvqn3i1G1Rt
         cDOrih8bGLii0GGbq5EW8ILEDx1ZebNefbV8abpjjnzan0sOnM72z6aFPg58THcKihpX
         5InntXFm9QIsAfswcbevdKPadYRucaDUHqHSelXWgcgb7FNI1LpsMBujNEE4sXhhyoZ9
         lRFg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=HdIq/fxk;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=MaRRSaxW;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=HdIq/fxk;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=MaRRSaxW;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A620B602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH v2 2/4] ioremap: Implement TLB_INV before huge mapping
To: "Kani, Toshi" <toshi.kani@hpe.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>, "arnd@arndb.de" <arnd@arndb.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "takahiro.akashi@linaro.org" <takahiro.akashi@linaro.org>,
 "james.morse@arm.com" <james.morse@arm.com>,
 "kristina.martsenko@arm.com" <kristina.martsenko@arm.com>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <1521117906-20107-1-git-send-email-cpandya@codeaurora.org>
 <1521117906-20107-3-git-send-email-cpandya@codeaurora.org>
 <1521130368.2693.177.camel@hpe.com>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <0cec2b79-1668-68d1-32db-531f5a8a9db2@codeaurora.org>
Date: Fri, 16 Mar 2018 13:10:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521130368.2693.177.camel@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595007763353693659?=
X-GMAIL-MSGID: =?utf-8?q?1595079155610503100?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 3/15/2018 9:42 PM, Kani, Toshi wrote:
> On Thu, 2018-03-15 at 18:15 +0530, Chintan Pandya wrote:
>> Huge mapping changes PMD/PUD which could have
>> valid previous entries. This requires proper
>> TLB maintanance on some architectures, like
>> ARM64.
>>
>> Implent BBM (break-before-make) safe TLB
>> invalidation.
>>
>> Here, I've used flush_tlb_pgtable() instead
>> of flush_kernel_range() because invalidating
>> intermediate page_table entries could have
>> been optimized for specific arch. That's the
>> case with ARM64 at least.
>>
>> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
>> ---
>>   lib/ioremap.c | 25 +++++++++++++++++++------
>>   1 file changed, 19 insertions(+), 6 deletions(-)
>>
>> diff --git a/lib/ioremap.c b/lib/ioremap.c
>> index 54e5bba..55f8648 100644
>> --- a/lib/ioremap.c
>> +++ b/lib/ioremap.c
>> @@ -13,6 +13,7 @@
>>   #include <linux/export.h>
>>   #include <asm/cacheflush.h>
>>   #include <asm/pgtable.h>
>> +#include <asm-generic/tlb.h>
>>   
>>   #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
>>   static int __read_mostly ioremap_p4d_capable;
>> @@ -80,6 +81,7 @@ static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
>>   		unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
>>   {
>>   	pmd_t *pmd;
>> +	pmd_t old_pmd;
>>   	unsigned long next;
>>   
>>   	phys_addr -= addr;
>> @@ -91,10 +93,15 @@ static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
>>   
>>   		if (ioremap_pmd_enabled() &&
>>   		    ((next - addr) == PMD_SIZE) &&
>> -		    IS_ALIGNED(phys_addr + addr, PMD_SIZE) &&
>> -		    pmd_free_pte_page(pmd)) {
>> -			if (pmd_set_huge(pmd, phys_addr + addr, prot))
>> +		    IS_ALIGNED(phys_addr + addr, PMD_SIZE)) {
>> +			old_pmd = *pmd;
>> +			pmd_clear(pmd);
> 
> pmd_clear() is one of the operations pmd_free_pte_page() needs to do.
> See the x86 version.
> 
>> +			flush_tlb_pgtable(&init_mm, addr);
> 
> You can call it in pmd_free_pte_page() on arm64 as well.
> 
>> +			if (pmd_set_huge(pmd, phys_addr + addr, prot)) {
>> +				pmd_free_pte_page(&old_pmd);
>>   				continue;
>> +			} else
>> +				set_pmd(pmd, old_pmd);
> 
> I do not understand why you needed to make this change.
> pmd_free_pte_page() is defined as an arch-specific function so that you
> can additionally perform TLB purges on arm64.  Please try to make proper
> arm64 implementation of this interface.  And if you find any issue in
> this interface, please let me know.
TLB ops require VA at least. And this interface passes just the PMD/PUD.

Second is, if we clear the previous table entry inside the arch specific
code and then we fail in pmd/pud_set_huge, we can't fallback (x86 case).

So, we can do something like this (following Mark's suggestion),

	if (ioremap_pmd_enabled() &&
         	((next - addr) == PMD_SIZE) &&
		IS_ALIGNED(phys_addr + addr, PMD_SIZE) &&
		pmd_can_set_huge(pmd, phys_addr + addr, prot)) {
			/*
			 * Clear existing table entry,
			 * Invalidate,
			 * Free the page table
			 * inside this code
			 */
			pmd_free_pte_page(pmd, addr, addr + PMD_SIZE);
			pmd_set_huge(...) //without fail
			continue;
	}


> 
> Same for pud.
> 
> Thanks,
> -Toshi
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
