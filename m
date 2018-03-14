Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AG47ELtnLiVbnQsUf9dl4e5hhYK6WhYcOur48wvUsCI+jx2UalrV4HJg4zQlu3vw4lIewafdfG66
ARC-Seal: i=1; a=rsa-sha256; t=1521026443; cv=none;
        d=google.com; s=arc-20160816;
        b=J0Bwn/yqB8F/wxnqyrVvUMSPnk3rpwuvLysFpBLYlCtgMs1afAGRVmS/9z6KjUqSBV
         5vZUxqXnOgE7mzgOKwzW2S76j+7mE1gG16XmOb6beyaoKuz222/nuNErDDaEZ+5szIP/
         d33h0t8sPMdjAotsK877Rsf5UGDwbCAUZiL6sLm3J2MgEuYqqjsbGdiORsXoO/71vH8g
         VxsYMT+HV6UIPDditc3ZwPZHcA5Imy5J8t86ndhwQvuMWAtLFyu2OP8eKr+poW/Hnrh7
         N3rCbUmFTnoNIqt5CYZ+mx9w6u7G86qz/nTT8RphxPtFC0L4Xm2URSXkxZs4mbzERY3t
         lqrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=kqb/T0iGCDxifSIh4ibKuBmndHWNpkrwhpe5yjwH19w=;
        b=JyYr7q5QACrFCT5e3ojjzkUOW3wsRRf4dXgGo+PbNGLwt/zIY8IdmYNRsbjXzo1fqN
         xRvyyg/8Za9w5h2PsCVVw/kw0av+f54KBFykEbOri8d0nF+BzdQaU6vhgUCqm6eRhuWF
         OLHfjhLQnVib2o2gU0elYvQUCFjMK7u8hnVYxAiQ+O8UB6rY8jqWpT/Fo0aLczazGtJ8
         a31h8pmRPtLznD+Sz5qNGkny6HUxRflQbwnGe3A4hG7cvWeHFF7aovFIgcIG3pZM41QH
         yv6ud5EYZ9zL/g0eSbH4Q6L7RI+WcWrlc80g2G2sN6F6OdXfBBWvZbQOjE2IPjY0iwRA
         BLsw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=G9l4/CBd;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=hKYAL/bw;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=G9l4/CBd;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=hKYAL/bw;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4D48860452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH v1 2/4] ioremap: Invalidate TLB after huge mappings
To: Mark Rutland <mark.rutland@arm.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de,
 ard.biesheuvel@linaro.org, marc.zyngier@arm.com, james.morse@arm.com,
 kristina.martsenko@arm.com, takahiro.akashi@linaro.org,
 gregkh@linuxfoundation.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, akpm@linux-foundation.org, toshi.kani@hpe.com
References: <1521017305-28518-1-git-send-email-cpandya@codeaurora.org>
 <1521017305-28518-3-git-send-email-cpandya@codeaurora.org>
 <20180314104823.yumqomzmbu3cj442@lakrids.cambridge.arm.com>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <a278b3ca-b54f-ee5e-5828-b8859eea5cc6@codeaurora.org>
Date: Wed, 14 Mar 2018 16:50:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314104823.yumqomzmbu3cj442@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594902270765090574?=
X-GMAIL-MSGID: =?utf-8?q?1594911823497658238?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 3/14/2018 4:18 PM, Mark Rutland wrote:
> On Wed, Mar 14, 2018 at 02:18:23PM +0530, Chintan Pandya wrote:
>> If huge mappings are enabled, they can override
>> valid intermediate previous mappings. Some MMU
>> can speculatively pre-fetch these intermediate
>> entries even after unmap. That's because unmap
>> will clear only last level entries in page table
>> keeping intermediate (pud/pmd) entries still valid.
>>
>> This can potentially lead to stale TLB entries
>> which needs invalidation after map.
>>
>> Some more info: https://lkml.org/lkml/2017/12/23/3
>>
>> There is one noted case for ARM64 where such stale
>> TLB entries causes 3rd level translation fault even
>> after correct (huge) mapping is available.
> 
>> Hence, invalidate once we override pmd/pud with huge
>> mappings.
> 
>>   static int __read_mostly ioremap_p4d_capable;
>> @@ -92,8 +93,10 @@ static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
>>   		if (ioremap_pmd_enabled() &&
>>   		    ((next - addr) == PMD_SIZE) &&
>>   		    IS_ALIGNED(phys_addr + addr, PMD_SIZE)) {
>> -			if (pmd_set_huge(pmd, phys_addr + addr, prot))
>> +			if (pmd_set_huge(pmd, phys_addr + addr, prot)) {
>> +				flush_tlb_pgtable(&init_mm, addr);
>>   				continue;
>> +			}
>>   		}
>>   
>>   		if (ioremap_pte_range(pmd, addr, next, phys_addr + addr, prot))
>> @@ -118,8 +121,10 @@ static inline int ioremap_pud_range(p4d_t *p4d, unsigned long addr,
>>   		if (ioremap_pud_enabled() &&
>>   		    ((next - addr) == PUD_SIZE) &&
>>   		    IS_ALIGNED(phys_addr + addr, PUD_SIZE)) {
>> -			if (pud_set_huge(pud, phys_addr + addr, prot))
>> +			if (pud_set_huge(pud, phys_addr + addr, prot)) {
>> +				flush_tlb_pgtable(&init_mm, addr);
>>   				continue;
>> +			}
>>   		}
> 
> As has been noted in previous threads, the ARM architecture requires a
> Break-Before-Make sequence when changing an entry from a table to a
> block, as is the case here.
> 
> The means the necessary sequence is:
> 
> 	1. Make the entry invalid
> 	2. Invalidate relevant TLB entries
> 	3. Write the new entry
> 
We do this for PTEs. I don't see this applicable to PMDs. Because,

1) To mark any PMD invalid, we need to be sure that next level page
    table (I mean all the 512 PTEs) should be zero. That requires us
    to scan entire last level page. A big perf hit !
2) We need to perform step 1 for every unmap as we never know which
    unmap will make last level page table empty.

Moreover, problem comes only when 4K mapping was followed by 2M
mapping. In all other cases, retaining valid PMD has obvious perf
gain. That's what walk-cache is supposed to be introduced for.

So, I think to touch only problematic case and fix it with TLB
invalidate.

> Whereas above, the sequence is
> 
> 	1. Write the new entry
> 	2. invalidate relevant TLB entries
> 
> Which is insufficient, and will lead to a number of problems.
I couldn't think of new problems with this approach. Could you share
any problematic scenarios ?

Also, my test-case runs fine with these patches for 10+ hours.

> 
> Therefore, NAK to this patch.
> 
> Please read up on the Break-Before-Make requirements in the ARM ARM.
Sure, will get more from here.

> 
> Thanks,
> Mark.
> 
Thanks for the review Mark.

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
