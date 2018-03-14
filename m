Return-Path: <mark.rutland@arm.com>
X-Google-Smtp-Source: AG47ELvEFR6qc/gO9WXzgr8lRS0r6AKnmp1GkL3rH+lv3A33ifgnB8vVhGfD/GhtwVxRcBrnCN+z
ARC-Seal: i=1; a=rsa-sha256; t=1521028250; cv=none;
        d=google.com; s=arc-20160816;
        b=TlZhRhy3NDMwuEDZ3nncQl0CCRA96uRrJjNzdBB6Gs06nUGJputFfHIhILMLzOmC9+
         f1qpkJnzsPuPyb5WcmkkPUuCyzj/wlhjRaCHLVoayWFdGNy5SmFJrrFIRA0DydtjTPo/
         CkUdxqPLF38T2AZfnnzNzDy/MpkUsjdhbyP2vR+fPpyHGTIWGAcPd1gixLS7f/2+oxji
         +/ac/UkMYZ8ePnrpZwrxxQrAMdRC1ToHto07feIULC1fDmuaHhZT94MzXTIN3guq9CU/
         p0RAsaHKgIieTRUybcZMEppktmFc1HQddRotPpgyZ0L2HyjstWvr5w2lPEUafKLFgJu0
         28AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=AfPk2QRmuAzQ2HjsZYbMW/bb9sY6NOOeoqiTQABuVUs=;
        b=j+UBQL7hxecuLDeBqR+scvU0tZQqtPbsVTXxswTL8EnoMc/zaM8+u9w7CgNaapQsGs
         Aulvem+ErpE2m5N/Gc9EdMY+useyvixKONcc9Rg97udfJxoCYPusTEmgIc00H+1SZBLb
         G0ptLODae89BxCKCoLCbi4xpvgGjPF+zScqBYCzc3SaNL/kFPMoJ6a0QbpJARUEo6TjX
         8Zn/p8AV9fWPv+Ac8kju2l+ja8OmF38PWTb79HFmtUb/G8BBMXQMjrvZjKBhES4mj4zt
         PE++/7RW0YdUK0G3Mv6oF64lZJj3ynrkeF3EBzH+IVKJ0sgBP/Iep1CE6aeBg2jhweVU
         6LbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mark.rutland@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=mark.rutland@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mark.rutland@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=mark.rutland@arm.com
Date: Wed, 14 Mar 2018 11:50:44 +0000
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
Message-ID: <20180314115044.gmmrnbzl5ekbspml@lakrids.cambridge.arm.com>
References: <1521017305-28518-1-git-send-email-cpandya@codeaurora.org>
 <1521017305-28518-4-git-send-email-cpandya@codeaurora.org>
 <20180314105343.nxw2mwkm4pao3hur@lakrids.cambridge.arm.com>
 <a3d0adc4-293a-328b-a8ea-ea410baa6849@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3d0adc4-293a-328b-a8ea-ea410baa6849@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594902279347636561?=
X-GMAIL-MSGID: =?utf-8?q?1594913718578020343?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 04:57:29PM +0530, Chintan Pandya wrote:
> 
> 
> On 3/14/2018 4:23 PM, Mark Rutland wrote:
> > On Wed, Mar 14, 2018 at 02:18:24PM +0530, Chintan Pandya wrote:
> > > While setting huge page, we need to take care of
> > > previously existing next level mapping. Since,
> > > we are going to overrite previous mapping, the
> > > only reference to next level page table will get
> > > lost and the next level page table will be zombie,
> > > occupying space forever. So, free it before
> > > overriding.
> > 
> > > @@ -939,6 +940,9 @@ int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
> > >   		return 0;
> > >   	BUG_ON(phys & ~PUD_MASK);
> > > +	if (pud_val(*pud) && !pud_huge(*pud))
> > > +		free_page((unsigned long)__va(pud_val(*pud)));
> > > +
> > >   	set_pud(pudp, pfn_pud(__phys_to_pfn(phys), sect_prot));
> > >   	return 1;
> > >   }
> > > @@ -953,6 +957,9 @@ int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
> > >   		return 0;
> > >   	BUG_ON(phys & ~PMD_MASK);
> > > +	if (pmd_val(*pmd) && !pmd_huge(*pmd))
> > > +		free_page((unsigned long)__va(pmd_val(*pmd)));
> > > +
> > 
> > As Marc noted, (assuming the subsequent revert is applied) in both of
> > these cases, these tables are still live, and thus it is not safe to
> > free them.
> > 
> > Consider that immediately after freeing the pages, they may get
> > re-allocated elsewhere, where they may be modified. If this happens
> > before TLB invalidation, page table walks may allocate junk into TLBs,
> > resulting in a number of problems.
> Ah okay. What about this sequence,
> 1) I store old PMD/PUD values
> 2) Update the PMD/PUD with section mapping
> 3) Invalidate TLB
> 4) Then free the *leaked* page

You must invalidate the TLB *before* setting the new entry:

1) store the old entry value
2) clear the entry
3) invalidate the TLB

... then you can either:

4) update the entry
5) free the old table

... or:

4) free the old table
5) update the entry

Thanks,
Mark.
