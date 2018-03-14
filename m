Return-Path: <marc.zyngier@arm.com>
X-Google-Smtp-Source: AG47ELu8cNJp7N/Bj9vEbbbC5AhPPCBSIN54jH1QqX2faO70ZXL+Ck5Q57woE0FFaQ2tQ3RgPY1r
ARC-Seal: i=1; a=rsa-sha256; t=1521023761; cv=none;
        d=google.com; s=arc-20160816;
        b=WpBbzIHOD2x6c8d+qnQDxnv57Suw5I2k7M25N80QDpShVsfEMz3YAvmFAlZuq6rN+X
         dGybXYNPwGbw7hjOKmi2BAD1R0Zb33Hypee2OIjGNX9cxwwC40sJ25e5x2khcaAX2E6m
         UzF4VtZqZL0avGzJeTsjW2oVLrkdlnpSJre+RuSk4Pa8VlUKKFh8cUy7nxCp1IDNKhZb
         87iT4vZRpC1tRku2vLunMF+TeCzgPpr1rBKpUD0JmEjS2ZnANlebJZPjSaF33ihtUzxi
         uVgH3hJlS3Tuk91F7jKkX83M/l3C+i9r8RyYs+YgG02+1MIqB8y6gehytBMXZRZX7wVM
         CPkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:arc-authentication-results;
        bh=J6ZPbNYhP0Bj0QCepzeXHvUHlCTbRPpxQ+qt1pBvbQg=;
        b=YiTY4cu7HSlPq3drroKscC2f+J9dnMQhUOMMOeG/ivZIiGTkHqiPfsAElnX3E/VzkY
         zGG8xXw3xz8ilZ7E65PDzJsNkkj+u+EhM6COV+bprfNRZVDcX0s+XLjGKidOCNEzmGdy
         4HvPgevDKljU5rLuB4lXc8eLI+WDjAXbNhuLApRs+zqgV3PWtIlMSLhpdlf1hiLCIGqj
         +bMNdQS5mm5+otdawqM3pUJoPTtFrtTCrrc3/eMSfXXsovAFFcSmre6rdYdIrGRddtif
         RbTCjwfDhIyDi0FLxmklvSBdmdy9LFQtXw7mWhDBF17AZij1CRskDh2aTR4traUGvawv
         UYcw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of marc.zyngier@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=marc.zyngier@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of marc.zyngier@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=marc.zyngier@arm.com
Subject: Re: [PATCH v1 3/4] arm64: Fix the page leak in pud/pmd_set_huge
To: Chintan Pandya <cpandya@codeaurora.org>, catalin.marinas@arm.com,
 will.deacon@arm.com, arnd@arndb.de
Cc: mark.rutland@arm.com, ard.biesheuvel@linaro.org, james.morse@arm.com,
 kristina.martsenko@arm.com, takahiro.akashi@linaro.org,
 gregkh@linuxfoundation.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, akpm@linux-foundation.org, toshi.kani@hpe.com
References: <1521017305-28518-1-git-send-email-cpandya@codeaurora.org>
 <1521017305-28518-4-git-send-email-cpandya@codeaurora.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <4b955357-23a0-c0ac-4407-79a1198e1913@arm.com>
Date: Wed, 14 Mar 2018 10:35:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521017305-28518-4-git-send-email-cpandya@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594902279347636561?=
X-GMAIL-MSGID: =?utf-8?q?1594909011649378401?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 14/03/18 08:48, Chintan Pandya wrote:
> While setting huge page, we need to take care of
> previously existing next level mapping. Since,
> we are going to overrite previous mapping, the
> only reference to next level page table will get
> lost and the next level page table will be zombie,
> occupying space forever. So, free it before
> overriding.
> 
> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
> ---
>  arch/arm64/mm/mmu.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 8c704f1..c0df264 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -32,7 +32,7 @@
>  #include <linux/io.h>
>  #include <linux/mm.h>
>  #include <linux/vmalloc.h>
> -
> +#include <linux/hugetlb.h>
>  #include <asm/barrier.h>
>  #include <asm/cputype.h>
>  #include <asm/fixmap.h>
> @@ -45,6 +45,7 @@
>  #include <asm/memblock.h>
>  #include <asm/mmu_context.h>
>  #include <asm/ptdump.h>
> +#include <asm/page.h>
>  
>  #define NO_BLOCK_MAPPINGS	BIT(0)
>  #define NO_CONT_MAPPINGS	BIT(1)
> @@ -939,6 +940,9 @@ int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
>  		return 0;
>  
>  	BUG_ON(phys & ~PUD_MASK);
> +	if (pud_val(*pud) && !pud_huge(*pud))
> +		free_page((unsigned long)__va(pud_val(*pud)));
> +

This is absolutely scary. Isn't this page still referenced in the page
tables (assuming patch 4 has been applied too)?

>  	set_pud(pudp, pfn_pud(__phys_to_pfn(phys), sect_prot));
>  	return 1;
>  }
> @@ -953,6 +957,9 @@ int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
>  		return 0;
>  
>  	BUG_ON(phys & ~PMD_MASK);
> +	if (pmd_val(*pmd) && !pmd_huge(*pmd))
> +		free_page((unsigned long)__va(pmd_val(*pmd)));
> +
>  	set_pmd(pmdp, pfn_pmd(__phys_to_pfn(phys), sect_prot));
>  	return 1;
>  }
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
