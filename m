Return-Path: <mark.rutland@arm.com>
X-Google-Smtp-Source: AG47ELvrsxHkikUR/dYdRUJU5GR3e7I6/VVBZDJyZZ2eRcXdwdaaN/0bFSbmG8ABH8Ec5qU2IZPB
ARC-Seal: i=1; a=rsa-sha256; t=1521024509; cv=none;
        d=google.com; s=arc-20160816;
        b=Il3coaYBvWuk6t0O4+ccIUQxrBpiNMkRElKbbtWak4sQRzX7/maXMRwWlvPiPm7+v9
         eG0vmlfIlW78mulSFIPveLbjVKWPRa9Q62IOI8RqKuFnEPkvv6QtfXAt0kgtFAM2KdBn
         dQwAGsnlyfgL0/+vj+UY/AB2Xz2iNFBNh/hZHBPj9t5RIpVDGvq60NBmaIJnphDUCgdm
         guASFm/gle0KowvcB2kf6xCn8QdBdWtRmwRsj9kxbW7/sGgvoItnzaHbXZXwaw6wXwuZ
         srdG+22Mf86INGOMBF68lr29UwvWLIlGVuHhiICHrbJpeUWalK2U1/ekjTUC9h8SBEbM
         O02A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=NjCY41x3Dj6qzg1oqlz3OG3/OVNalgSd1DxBGh31w9o=;
        b=uEs4PFsKHiLHrz6dJYU5L00WgHnq5bDJnTc4ZcWHfTszIb8XHqyyaBbymKstjHdH6S
         ipebxnlb18LpZ1gUuvmkqwowf/oytZXItIXYijxHIDFHvRa42J71to+28k49y30CfTOC
         DXLKGT52GcFiS3vB1dC5Z6RsRI4Gw3n5qdIP53htp6jmeLsdNEP0bXqv361VhoL6TA8P
         n8F9wJ/QrxwCxUBzgczov9qzQxRZ9arFyOon/AXvkaBRsYnkVqamw049eTcDiAg4B1LG
         NPkdjO9+Qzsb/Tn49JQl/tPtAwV33PKeExfdlEiRs8tDrVNPBkh1SLIc60de1ksHnWW9
         YBSg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mark.rutland@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=mark.rutland@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mark.rutland@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=mark.rutland@arm.com
Date: Wed, 14 Mar 2018 10:48:23 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Chintan Pandya <cpandya@codeaurora.org>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de,
	ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
	james.morse@arm.com, kristina.martsenko@arm.com,
	takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
	tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	akpm@linux-foundation.org, toshi.kani@hpe.com
Subject: Re: [PATCH v1 2/4] ioremap: Invalidate TLB after huge mappings
Message-ID: <20180314104823.yumqomzmbu3cj442@lakrids.cambridge.arm.com>
References: <1521017305-28518-1-git-send-email-cpandya@codeaurora.org>
 <1521017305-28518-3-git-send-email-cpandya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521017305-28518-3-git-send-email-cpandya@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594902270765090574?=
X-GMAIL-MSGID: =?utf-8?q?1594909795985979657?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 02:18:23PM +0530, Chintan Pandya wrote:
> If huge mappings are enabled, they can override
> valid intermediate previous mappings. Some MMU
> can speculatively pre-fetch these intermediate
> entries even after unmap. That's because unmap
> will clear only last level entries in page table
> keeping intermediate (pud/pmd) entries still valid.
> 
> This can potentially lead to stale TLB entries
> which needs invalidation after map.
> 
> Some more info: https://lkml.org/lkml/2017/12/23/3
> 
> There is one noted case for ARM64 where such stale
> TLB entries causes 3rd level translation fault even
> after correct (huge) mapping is available.

> Hence, invalidate once we override pmd/pud with huge
> mappings.

>  static int __read_mostly ioremap_p4d_capable;
> @@ -92,8 +93,10 @@ static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
>  		if (ioremap_pmd_enabled() &&
>  		    ((next - addr) == PMD_SIZE) &&
>  		    IS_ALIGNED(phys_addr + addr, PMD_SIZE)) {
> -			if (pmd_set_huge(pmd, phys_addr + addr, prot))
> +			if (pmd_set_huge(pmd, phys_addr + addr, prot)) {
> +				flush_tlb_pgtable(&init_mm, addr);
>  				continue;
> +			}
>  		}
>  
>  		if (ioremap_pte_range(pmd, addr, next, phys_addr + addr, prot))
> @@ -118,8 +121,10 @@ static inline int ioremap_pud_range(p4d_t *p4d, unsigned long addr,
>  		if (ioremap_pud_enabled() &&
>  		    ((next - addr) == PUD_SIZE) &&
>  		    IS_ALIGNED(phys_addr + addr, PUD_SIZE)) {
> -			if (pud_set_huge(pud, phys_addr + addr, prot))
> +			if (pud_set_huge(pud, phys_addr + addr, prot)) {
> +				flush_tlb_pgtable(&init_mm, addr);
>  				continue;
> +			}
>  		}

As has been noted in previous threads, the ARM architecture requires a
Break-Before-Make sequence when changing an entry from a table to a
block, as is the case here.

The means the necessary sequence is:

	1. Make the entry invalid
	2. Invalidate relevant TLB entries
	3. Write the new entry

Whereas above, the sequence is

	1. Write the new entry
	2. invalidate relevant TLB entries

Which is insufficient, and will lead to a number of problems.

Therefore, NAK to this patch.

Please read up on the Break-Before-Make requirements in the ARM ARM.

Thanks,
Mark.
