Return-Path: <marc.zyngier@arm.com>
X-Google-Smtp-Source: AG47ELtafwgqFCq89HZ0eHP8ITBgQ0NXM+g/t4TBUaLFOVOyGZbb0tRPLSshIiecRzmPgnIyWyhY
ARC-Seal: i=1; a=rsa-sha256; t=1521024370; cv=none;
        d=google.com; s=arc-20160816;
        b=udrm8AWG1ohfykLPe7QBxWQDAwqA+FO2BVZF0nzYOihaPTAzFtkQAVoLlr1MKUHAsY
         Em4t48A6lz8W/PQ5+Lggh8RloAD5EzXJo8JJbD+7ki2ecmu0Mvt/jHuds867rgXAi2Qr
         YhLvBcuqd0OSNP6B+Q/UOx312nVx+tFOZbkiryfGDOnBqOv3hG6UcQZYbhMB02njrq+8
         OxxddZT8jOx9eT0ZOs5zjedYjRUMhAfycus/1O0NW/onlnSzJcqrCs4PE+DJ3e2wKE1C
         oAavfwdmYX5iRu+0abxtM4yk7ohVvFeZ1Nmyd4QEkmfIKAp4sGR/CybhsPu+k+Mx6F6j
         rgkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:arc-authentication-results;
        bh=e5fomi1be7cXJgdycEHCiYlZej4LoEVU1YDThCUkv9k=;
        b=IHq0ALvPAfg+h8aJKuMFXbt2nKmeCEkWL99f3kFTY3nOSiSeeKhGceHrOEenMIrGU6
         S1xADlxwEcm54B1ZqgRDmpzOEkh89Dd7aaglMw+iSRWyBaPSxfHta2IqBFbJlmMOMPdN
         6VPEOzfExg894XNViZjeHsx5NQiYNuyw7Ofhtkt5lJAdpZ+nFOJCjgxdPJRLv7knATg4
         IKUCXZ6FAuNm8fPeF92cQk8mbm0zoloUgql8kJCwYJ0BXILX3bH/6K29PKrH7m2sOioL
         U+R4UE4fwRuSNAGpFOU4alo+erPRVckxtJqH84bem/b+U6WUOg6FIIsb0LX6GuHsMOHu
         S/yw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of marc.zyngier@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=marc.zyngier@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of marc.zyngier@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=marc.zyngier@arm.com
Subject: Re: [PATCH v1 4/4] Revert "arm64: Enforce BBM for huge IO/VMAP
 mappings"
To: Chintan Pandya <cpandya@codeaurora.org>, catalin.marinas@arm.com,
 will.deacon@arm.com, arnd@arndb.de
Cc: mark.rutland@arm.com, ard.biesheuvel@linaro.org, james.morse@arm.com,
 kristina.martsenko@arm.com, takahiro.akashi@linaro.org,
 gregkh@linuxfoundation.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, akpm@linux-foundation.org, toshi.kani@hpe.com
References: <1521017305-28518-1-git-send-email-cpandya@codeaurora.org>
 <1521017305-28518-5-git-send-email-cpandya@codeaurora.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <bdcc02a1-cf1b-4887-06e9-4867415ca214@arm.com>
Date: Wed, 14 Mar 2018 10:46:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521017305-28518-5-git-send-email-cpandya@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594902291066991790?=
X-GMAIL-MSGID: =?utf-8?q?1594909650287600612?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 14/03/18 08:48, Chintan Pandya wrote:
> This commit 15122ee2c515a ("arm64: Enforce BBM for huge
> IO/VMAP mappings") is a temporary work-around until the
> issues with CONFIG_HAVE_ARCH_HUGE_VMAP gets fixed.
> 
> Revert this change as we have fixes for the issue.
> 
> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
> ---
>  arch/arm64/mm/mmu.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index c0df264..19116c6 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -935,10 +935,6 @@ int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
>  	pgprot_t sect_prot = __pgprot(PUD_TYPE_SECT |
>  					pgprot_val(mk_sect_prot(prot)));
>  
> -	/* ioremap_page_range doesn't honour BBM */
> -	if (pud_present(READ_ONCE(*pudp)))
> -		return 0;
> -
>  	BUG_ON(phys & ~PUD_MASK);
>  	if (pud_val(*pud) && !pud_huge(*pud))
>  		free_page((unsigned long)__va(pud_val(*pud)));
> @@ -952,10 +948,6 @@ int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
>  	pgprot_t sect_prot = __pgprot(PMD_TYPE_SECT |
>  					pgprot_val(mk_sect_prot(prot)));
>  
> -	/* ioremap_page_range doesn't honour BBM */
> -	if (pmd_present(READ_ONCE(*pmdp)))
> -		return 0;
> -
>  	BUG_ON(phys & ~PMD_MASK);
>  	if (pmd_val(*pmd) && !pmd_huge(*pmd))
>  		free_page((unsigned long)__va(pmd_val(*pmd)));
> 

But you're still not doing a BBM, right? What prevents a speculative
access from using the (now freed) entry? The TLB invalidation you've
introduce just narrows the window where bad things can happen.

My gut feeling is that this series introduces more bugs than it fixes...
If you're going to fix it, please fix it by correctly implementing BBM
for huge mappings.

Or am I missing something terribly obvious?

	M.
-- 
Jazz is not dead. It just smells funny...
