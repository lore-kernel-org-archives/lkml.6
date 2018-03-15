Return-Path: <mark.rutland@arm.com>
X-Google-Smtp-Source: AG47ELuB+pJXV48Y+mqDclKWd2QuMZDcSAr67TGK9aXS+9+SKcfh4PWboAQYUwRn+hv/3za4mpw7
ARC-Seal: i=1; a=rsa-sha256; t=1521127251; cv=none;
        d=google.com; s=arc-20160816;
        b=JFGpHWO8M4x1m6w2CkmQ30OAUUOHzdhXWO3QGhDEA2AFh1ezguG0f4w7dwHnFR2UpM
         hWrIETbfAuhNT4jk/NoujTsiwzPtxsJVnw4C5A2ltmRsI+mUoSUvUWqZKnpxd60rqw+5
         tvcRw2U8HDFIpAivEPX3nWqUEr93xdr0t5IuvITaVNld+Jug6T5XQJwgyWq/bGlIq6xu
         4PJHYW6Wj+LjEbdUl2r1OveywZcNOBYtz4KOqrz7nDnPEP4KyctgDzGKmL53v3+FvEwD
         RgkdJetSl0EVjtfnIALPrYVUyANAKRGMaCEpc9zki6te1Xzi1JrsvWC/VdNnuF/JI76i
         yUrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=FV0yKjozee9wCfSer6OIZi2DoukV7EIrrTPrD4SEdbA=;
        b=vOvqrIxrgwDBirXlZXau0cp2o2CLztIG/YX6SUEiUKK4qGolN829wculigpEn0KGmO
         Gq0Gkkf/bbp4IIVvvKdRs2EbcVPIomFY/R9zn8zIUEtKrcMYKn7CU1wKUkSdqX9+lwBk
         cNOQEnVfmImF/9IUOc9BbUwWgE2+TZsvDksAZNlWbROV1sW/BkQXs5k4Mi5go4mzGmPO
         KDWWAjgBpEB9L49jB5dTjREInVg6puy9r4n6ogTimImZixsekt74lg/xDTQ9fbJV+myK
         xYENuOOvqdmtS9qGGugF7ZJUHqYlpbkgV1Z1E7Dprb6CEF2xMc+2LFHb6hqC7K/BETBY
         MJgA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mark.rutland@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=mark.rutland@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mark.rutland@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=mark.rutland@arm.com
Date: Thu, 15 Mar 2018 15:20:45 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Chintan Pandya <cpandya@codeaurora.org>
Cc: linux-arch@vger.kernel.org, toshi.kani@hpe.com, arnd@arndb.de,
	ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
	catalin.marinas@arm.com, will.deacon@arm.com,
	linux-kernel@vger.kernel.org, kristina.martsenko@arm.com,
	takahiro.akashi@linaro.org, james.morse@arm.com,
	gregkh@linuxfoundation.org, tglx@linutronix.de,
	akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/4] ioremap: Implement TLB_INV before huge mapping
Message-ID: <20180315152045.uajoedfvdcynhus5@lakrids.cambridge.arm.com>
References: <1521117906-20107-1-git-send-email-cpandya@codeaurora.org>
 <1521117906-20107-3-git-send-email-cpandya@codeaurora.org>
 <20180315133157.ucbdg25jo5ew3t2h@lakrids.cambridge.arm.com>
 <b6c7622d-9676-5584-d52b-10ece6a3877c@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6c7622d-9676-5584-d52b-10ece6a3877c@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595007763353693659?=
X-GMAIL-MSGID: =?utf-8?q?1595017528344916744?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 07:49:01PM +0530, Chintan Pandya wrote:
> On 3/15/2018 7:01 PM, Mark Rutland wrote:
> > On Thu, Mar 15, 2018 at 06:15:04PM +0530, Chintan Pandya wrote:
> > > @@ -91,10 +93,15 @@ static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
> > >   		if (ioremap_pmd_enabled() &&
> > >   		    ((next - addr) == PMD_SIZE) &&
> > > -		    IS_ALIGNED(phys_addr + addr, PMD_SIZE) &&
> > > -		    pmd_free_pte_page(pmd)) {
> > > -			if (pmd_set_huge(pmd, phys_addr + addr, prot))
> > > +		    IS_ALIGNED(phys_addr + addr, PMD_SIZE)) {
> > > +			old_pmd = *pmd;
> > > +			pmd_clear(pmd);
> > > +			flush_tlb_pgtable(&init_mm, addr);
> > > +			if (pmd_set_huge(pmd, phys_addr + addr, prot)) {
> > > +				pmd_free_pte_page(&old_pmd);
> > >   				continue;
> > > +			} else
> > > +				set_pmd(pmd, old_pmd);
> > >   		}
> > 
> > Can we have something like a pmd_can_set_huge() helper? Then we could
> > avoid pointless modification and TLB invalidation work when
> > pmd_set_huge() will fail.
> 
> Actually, pmd_set_huge() will never fail because, if
> CONFIG_HAVE_ARCH_HUGE_VMAP is disabled, ioremap_pmd_enabled()
> will fail and if enabled (i.e. ARM64 & x86), they don't fail
> in their implementation. So, rather we can do the following.

AFAICT, that's not true. The x86 pmd_set_huge() can fail under certain
conditions:

int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
{
	u8 mtrr, uniform;

	mtrr = mtrr_type_lookup(addr, addr + PMD_SIZE, &uniform);
	if ((mtrr != MTRR_TYPE_INVALID) && (!uniform) &&
	    (mtrr != MTRR_TYPE_WRBACK)) {
		pr_warn_once("%s: Cannot satisfy [mem %#010llx-%#010llx] with a huge-page mapping due to MTRR override.\n",
			     __func__, addr, addr + PMD_SIZE);
		return 0;
	}

	prot = pgprot_4k_2_large(prot);

	set_pte((pte_t *)pmd, pfn_pte(
		(u64)addr >> PAGE_SHIFT,
		__pgprot(pgprot_val(prot) | _PAGE_PSE)));

	return 1;
}

... perhaps that can never happen in this particular case, but that's
not clear to me.

Thanks,
Mark.
