Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AG47ELsNWF664l5Vk1+dqkzCSw8ZCG6Ke2aN3ZrwkbfHu/TY0cMaVHBLoGWQg+jOIfuTG0zn9xXS
ARC-Seal: i=1; a=rsa-sha256; t=1521123549; cv=none;
        d=google.com; s=arc-20160816;
        b=jIC8jkbceCGotfj0lmi7+xbjoqt4y9PjTiEiD49bsqx4hpd2rYFJNUMhELAVrXgvqr
         9Dp0MB9dJWo59jo6zu5K/GV+ot9jJlk6wlBb5VI19DxJoWaOHUeClAwphnKbBPlr5Uff
         rg1zFH44zfeSsQgMb7JbWnbX9Ev0aPwW0XPWSIxaKrAFD1adSRWnkAtPjn8tQ/XLlsVd
         VWY7x89h5Vp1g31Vui97C1Yix+tQI/2c4pz3H+4G4mrihHiDWGKYQAXMk0p40wq5wa2N
         DBogtt8DJmVs0IO66FDjBUVLhhf0Q9b+r4l0rB0g3hun5F92ix3yOWpCfOlpq1C/YmI4
         cYfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=lTdWX7dJi6KG/Huqs2tjXvi/GzCd1mY2krS1Qcz9F0E=;
        b=twmaa2zB4yrElkBAPG1zfQ1XCsgG7hvm6kpVi8Ofc5tSIcI/qizNZfNW3E9NKg1EaS
         fOlWcaCwmKy6h5mE8VYQoKIIt9NSZeDON3zla5wRGma+8XEzzc1ncgr1BrED0fIUFWG6
         7ILLuz7DHDw86aeYS+eCqEwLfZrRiNQl44uEWhB72Y4hF0fkU3qmb5lgYqNklN2Ubq2/
         OxWvYW9I2LucA5A5kImsk0oTmS8db1v9xiGIfrdIJKfgcqg0T26nMNmn5LQ+OMxmE9p8
         JeLD9/DzYLtYgu6b733XEoi5i+QU9ZNdijiKS7LNl6N7srGkm2FBwk3IfFRzKEvetefm
         XYhQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=dgUY7mmG;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Df6B9ruY;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=dgUY7mmG;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Df6B9ruY;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7F41560452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH v2 2/4] ioremap: Implement TLB_INV before huge mapping
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arch@vger.kernel.org, toshi.kani@hpe.com, arnd@arndb.de,
 ard.biesheuvel@linaro.org, marc.zyngier@arm.com, catalin.marinas@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org,
 kristina.martsenko@arm.com, takahiro.akashi@linaro.org, james.morse@arm.com,
 gregkh@linuxfoundation.org, tglx@linutronix.de, akpm@linux-foundation.org,
 linux-arm-kernel@lists.infradead.org
References: <1521117906-20107-1-git-send-email-cpandya@codeaurora.org>
 <1521117906-20107-3-git-send-email-cpandya@codeaurora.org>
 <20180315133157.ucbdg25jo5ew3t2h@lakrids.cambridge.arm.com>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <b6c7622d-9676-5584-d52b-10ece6a3877c@codeaurora.org>
Date: Thu, 15 Mar 2018 19:49:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315133157.ucbdg25jo5ew3t2h@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595007763353693659?=
X-GMAIL-MSGID: =?utf-8?q?1595013646743229401?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 3/15/2018 7:01 PM, Mark Rutland wrote:
> On Thu, Mar 15, 2018 at 06:15:04PM +0530, Chintan Pandya wrote:
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
>> +			flush_tlb_pgtable(&init_mm, addr);
>> +			if (pmd_set_huge(pmd, phys_addr + addr, prot)) {
>> +				pmd_free_pte_page(&old_pmd);
>>   				continue;
>> +			} else
>> +				set_pmd(pmd, old_pmd);
>>   		}
>>   
> 
> Can we have something like a pmd_can_set_huge() helper? Then we could
> avoid pointless modification and TLB invalidation work when
> pmd_set_huge() will fail.

Actually, pmd_set_huge() will never fail because, if
CONFIG_HAVE_ARCH_HUGE_VMAP is disabled, ioremap_pmd_enabled()
will fail and if enabled (i.e. ARM64 & x86), they don't fail
in their implementation. So, rather we can do the following.

-                       if (pmd_set_huge(pmd, phys_addr + addr, prot)) {
-                               pmd_free_pte_page(&old_pmd);
-                               continue;
-                       } else
-                               set_pmd(pmd, old_pmd);
+                       pmd_set_huge(pmd, phys_addr + addr, prot)
+                       pmd_free_pte_page(&old_pmd);
+                       continue;

> 
> 	if (ioremap_pmd_enabled() &&
> 	    ((next - addr) == PMD_SIZE) &&
> 	    IS_ALIGNED(phys_addr + addr, PMD_SIZE) &&
> 	    pmd_can_set_huge(pmd, phys_addr + addr, prot)) {
> 	    	// clear entries, invalidate TLBs, and free tables
> 		...
> 		continue;
> 
> 	}
> 
> Thanks,
> MArk.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
