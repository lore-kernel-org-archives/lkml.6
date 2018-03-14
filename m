Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AG47ELvMz1szErqUYZ01kBoUUlYTigR7/EYwjrPFA6EamPhl8anBdLlQMkYZsUWpdYqpxQy1H1cb
ARC-Seal: i=1; a=rsa-sha256; t=1521026857; cv=none;
        d=google.com; s=arc-20160816;
        b=ZT5iVfO7b++cieB0aG3wotkdq/lEeQAds0QHyRp6q7QjokSVdH34O8XFc23JKQYDg1
         97PXWF5YvNbAotvoXaWTByIusG1dqeWcSA44pyjSFjtdx94AOMBtMjPkOZyPbvPzUkY6
         RWN3MHvfqkOS1nVJQv0uDhj2bSeo8SndFwqmqcTOZ3/jzNI2YaCLlCvjrUq66cLHRN3m
         BYgMYZ/jf0HCfJsEe4i8kjHYP6V1K+W1qvLlzfW37DlkVTR0Y87ttj/hoq7+3Ws74nrJ
         LRIn4ypoVPSNzkpLGPBYYHAajGOOUEuMAcNcARRhbelDUdpyT0Pa6ytiBU3eH77gVmSg
         jpIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=dJ+CaBsHy7yIpc6EyR12SbpkF4nw4MLq2jIEeX2tlkc=;
        b=Dj9UUYpOz3SSHOKz1HTzaR7r4FhhnomTdpXP5Aq+hCNS7qlsX29YgBhG6CAflhDpUG
         Niy55VUYVT0gIN2gvTuTfleV/nDUHYmhzM4CkUzNbuuDBpMOR2hivYBkedDQUL2O5w8/
         n/puFNBoD1npMhND8NHF3Ud6tLZFjXPtur1S7sLbB6oR8d9eSyz+OBU9VW4NmwI9YDAl
         NTO39Lv7TIOvu7zNfug8b3S0/1pvwWs/gG0hT7/L3CRCXJ8hvSX6XFIwSR06oNSE3o90
         fQG+TTuUl4qcQwi5w9xp61Kzi6iR9ARM4wLVKZbPrlZeXd9K0Xmg5XHMUzXbWkFtVnRF
         2j7w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Oo8VJ9NJ;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=KlMBPYHb;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Oo8VJ9NJ;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=KlMBPYHb;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 06D4D60390
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH v1 3/4] arm64: Fix the page leak in pud/pmd_set_huge
To: Mark Rutland <mark.rutland@arm.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de,
 ard.biesheuvel@linaro.org, marc.zyngier@arm.com, james.morse@arm.com,
 kristina.martsenko@arm.com, takahiro.akashi@linaro.org,
 gregkh@linuxfoundation.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, akpm@linux-foundation.org, toshi.kani@hpe.com
References: <1521017305-28518-1-git-send-email-cpandya@codeaurora.org>
 <1521017305-28518-4-git-send-email-cpandya@codeaurora.org>
 <20180314105343.nxw2mwkm4pao3hur@lakrids.cambridge.arm.com>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <a3d0adc4-293a-328b-a8ea-ea410baa6849@codeaurora.org>
Date: Wed, 14 Mar 2018 16:57:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314105343.nxw2mwkm4pao3hur@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594902279347636561?=
X-GMAIL-MSGID: =?utf-8?q?1594912258115874863?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 3/14/2018 4:23 PM, Mark Rutland wrote:
> On Wed, Mar 14, 2018 at 02:18:24PM +0530, Chintan Pandya wrote:
>> While setting huge page, we need to take care of
>> previously existing next level mapping. Since,
>> we are going to overrite previous mapping, the
>> only reference to next level page table will get
>> lost and the next level page table will be zombie,
>> occupying space forever. So, free it before
>> overriding.
> 
>> @@ -939,6 +940,9 @@ int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
>>   		return 0;
>>   
>>   	BUG_ON(phys & ~PUD_MASK);
>> +	if (pud_val(*pud) && !pud_huge(*pud))
>> +		free_page((unsigned long)__va(pud_val(*pud)));
>> +
>>   	set_pud(pudp, pfn_pud(__phys_to_pfn(phys), sect_prot));
>>   	return 1;
>>   }
>> @@ -953,6 +957,9 @@ int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
>>   		return 0;
>>   
>>   	BUG_ON(phys & ~PMD_MASK);
>> +	if (pmd_val(*pmd) && !pmd_huge(*pmd))
>> +		free_page((unsigned long)__va(pmd_val(*pmd)));
>> +
> 
> As Marc noted, (assuming the subsequent revert is applied) in both of
> these cases, these tables are still live, and thus it is not safe to
> free them.
> 
> Consider that immediately after freeing the pages, they may get
> re-allocated elsewhere, where they may be modified. If this happens
> before TLB invalidation, page table walks may allocate junk into TLBs,
> resulting in a number of problems.
Ah okay. What about this sequence,
1) I store old PMD/PUD values
2) Update the PMD/PUD with section mapping
3) Invalidate TLB
4) Then free the *leaked* page

> 
> It is *never* safe to free a live page table, therefore NAK to this
> patch.
> 
> Thanks,
> Mark.
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
