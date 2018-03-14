Return-Path: <mark.rutland@arm.com>
X-Google-Smtp-Source: AG47ELsDcaERQ0zdLMJ1ER638PXJZYDegjP/qjjdojVZKo3AlAvD/ssshSDgBkHRCj23c1Filqck
ARC-Seal: i=1; a=rsa-sha256; t=1521024829; cv=none;
        d=google.com; s=arc-20160816;
        b=WevMOXzhfK1ejOBb8abio0v1VzpmjW2tJ4Q2qEOK/za7CBOhpU+rPIQ1mzlVoz+sRo
         v+TWwx7aBLphrSEo4cMrSHolR4Yx9IIFCJr3k7/seLS1IXlZ0YJaO+Dexzz/UblHVqBO
         u3ogrkrXWxTNkfg6z2yCb2BD7g6Qk5Tco3qV8Q9WtZ8O5i/IPM5cF4QyRyd6RUhbYiJH
         Whhs962O7Q+3FvwN0tiVS2DC5oArS2RLaprrvkYtVzWj9dwyxrGP0UXwtGRkLQpXsiw4
         A+dYkPxXhP9fa1pL3sNuPc0DLFkd1mWVfM8KpfaaTtFx3+a9mhqTW0bFUiXJCJBJOtW2
         mrlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=cteOaz4APZ8DIriCzv1+w1hkaeQcxU7G+LfswOXW6h0=;
        b=v2FrQrJ+/QdKgI16zus9SomStVrEAhSctaRurhZK9LwQ4dRZQ3UWHNaEKb81xIOsom
         mAyfMQzf7JzBeX7JBtXtnQjVc2WQutMXpyGgPj2mFU98CSXpyABsZPMGei6wBF1+oXuf
         PusFPZvhSb7RS9WCjQ98fL+07cOGlQJRDrNIRtJwtaXJSl3g/BbwYbKCQ51cf7oHi2zJ
         ALOQ/YXea8YM4CqDQE9iutLjDP75Gk3HRyqqEcgmogZd+y23bb5iiZixVJGPYFajAIw7
         dJPVP4mPQezBBtIiYjZEDuett38JwczfIicH6bk6OdJKFL7X5i3oo+EKfieUOFCTpk3E
         1b6A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mark.rutland@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=mark.rutland@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mark.rutland@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=mark.rutland@arm.com
Date: Wed, 14 Mar 2018 10:53:43 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Chintan Pandya <cpandya@codeaurora.org>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de,
	ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
	james.morse@arm.com, kristina.martsenko@arm.com,
	takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
	tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	akpm@linux-foundation.org, toshi.kani@hpe.com
Subject: Re: [PATCH v1 3/4] arm64: Fix the page leak in pud/pmd_set_huge
Message-ID: <20180314105343.nxw2mwkm4pao3hur@lakrids.cambridge.arm.com>
References: <1521017305-28518-1-git-send-email-cpandya@codeaurora.org>
 <1521017305-28518-4-git-send-email-cpandya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521017305-28518-4-git-send-email-cpandya@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594902279347636561?=
X-GMAIL-MSGID: =?utf-8?q?1594910131523951123?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 02:18:24PM +0530, Chintan Pandya wrote:
> While setting huge page, we need to take care of
> previously existing next level mapping. Since,
> we are going to overrite previous mapping, the
> only reference to next level page table will get
> lost and the next level page table will be zombie,
> occupying space forever. So, free it before
> overriding.

> @@ -939,6 +940,9 @@ int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
>  		return 0;
>  
>  	BUG_ON(phys & ~PUD_MASK);
> +	if (pud_val(*pud) && !pud_huge(*pud))
> +		free_page((unsigned long)__va(pud_val(*pud)));
> +
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

As Marc noted, (assuming the subsequent revert is applied) in both of
these cases, these tables are still live, and thus it is not safe to
free them.

Consider that immediately after freeing the pages, they may get
re-allocated elsewhere, where they may be modified. If this happens
before TLB invalidation, page table walks may allocate junk into TLBs,
resulting in a number of problems.

It is *never* safe to free a live page table, therefore NAK to this
patch.

Thanks,
Mark.
