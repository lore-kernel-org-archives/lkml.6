Return-Path: <mark.rutland@arm.com>
X-Google-Smtp-Source: AG47ELsADJut4G4aKd2Q0BmUvcZAE2gZupob5g7iF5zEe4crM1+SrbhM3tv8p8nfexup0lDNB4IE
ARC-Seal: i=1; a=rsa-sha256; t=1521120723; cv=none;
        d=google.com; s=arc-20160816;
        b=XSCOr+qWGJ33PlHhQQWNIu3n8ZxlLuS072X9xY/rtORlup7eYRU6WOxgTCupnpeh58
         pGkbDX+WIc0m7YdKeDSv6I7oGFjjyIqQXYwoUjJE/jFq59pzKTa2xU0eRDN0x9NzajsP
         T53h8/YPjz8IMqeyqqFBrnIDeJ/K5Xa9lHHFZRHCO2EagsHl7cuFlDAhqOd+3jJZj1yu
         hR+BjHEjfu8FkI9QtvunJGHSqVOPkquYKAwYlv3dmA0bVFurhZPpbhPG3EDmK0fu6ph0
         +5inRSm9xEmD+HXCI35d76K0f5YbDCGR+iKHKh2+rpHqr14Q3Q3/MEmmF8ftVGDoGtvq
         wLbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=O5rWxrO4LKpgeKr94tt5HY0UsDhdyMRN5u3KCoWRxK4=;
        b=uEyJc6FbGDxnfrutAgefbefWL+CSfYo0QQp+k2DzbsUYqOnOlhJObJB/HragfUSVqy
         thekVfmwz8CaYDzIj/uUUZYUvurQEV+hSRCFM6QfU0GwS/TWajEfBlYiruTrMk7EgRix
         KVRG2QgbBpDagdC/TusWPqFk+lC1WuRV6dBjDH8ssDmvZjIqb6tDyR1H0A8hvTGvfbYy
         OOEW8mmk2LQMWMYyzaJsgUW7FpLcvgkjL04G2ULTGTivuzm0nWKCNoYfTmxUlVrG+442
         /egk7LkQvFNtRkHnFApx7USETkIFDsadApBuxgdn2TCab2x92+jqweFoORn5bK09//eE
         9viQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mark.rutland@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=mark.rutland@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mark.rutland@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=mark.rutland@arm.com
Date: Thu, 15 Mar 2018 13:31:58 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Chintan Pandya <cpandya@codeaurora.org>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de,
	ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
	james.morse@arm.com, kristina.martsenko@arm.com,
	takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
	tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	akpm@linux-foundation.org, toshi.kani@hpe.com
Subject: Re: [PATCH v2 2/4] ioremap: Implement TLB_INV before huge mapping
Message-ID: <20180315133157.ucbdg25jo5ew3t2h@lakrids.cambridge.arm.com>
References: <1521117906-20107-1-git-send-email-cpandya@codeaurora.org>
 <1521117906-20107-3-git-send-email-cpandya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521117906-20107-3-git-send-email-cpandya@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595007763353693659?=
X-GMAIL-MSGID: =?utf-8?q?1595010683947435403?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 06:15:04PM +0530, Chintan Pandya wrote:
> @@ -91,10 +93,15 @@ static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
>  
>  		if (ioremap_pmd_enabled() &&
>  		    ((next - addr) == PMD_SIZE) &&
> -		    IS_ALIGNED(phys_addr + addr, PMD_SIZE) &&
> -		    pmd_free_pte_page(pmd)) {
> -			if (pmd_set_huge(pmd, phys_addr + addr, prot))
> +		    IS_ALIGNED(phys_addr + addr, PMD_SIZE)) {
> +			old_pmd = *pmd;
> +			pmd_clear(pmd);
> +			flush_tlb_pgtable(&init_mm, addr);
> +			if (pmd_set_huge(pmd, phys_addr + addr, prot)) {
> +				pmd_free_pte_page(&old_pmd);
>  				continue;
> +			} else
> +				set_pmd(pmd, old_pmd);
>  		}
>  

Can we have something like a pmd_can_set_huge() helper? Then we could
avoid pointless modification and TLB invalidation work when
pmd_set_huge() will fail.

	if (ioremap_pmd_enabled() &&
	    ((next - addr) == PMD_SIZE) &&
	    IS_ALIGNED(phys_addr + addr, PMD_SIZE) &&
	    pmd_can_set_huge(pmd, phys_addr + addr, prot)) {
	    	// clear entries, invalidate TLBs, and free tables
		...
		continue;

	}

Thanks,
MArk.
