Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A4EC6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 805BC20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 805BC20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbeILUSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:18:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:33077 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbeILUSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:18:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2018 08:13:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,365,1531810800"; 
   d="scan'208";a="88146928"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.20])
  by fmsmga004.fm.intel.com with ESMTP; 12 Sep 2018 08:09:39 -0700
Date:   Wed, 12 Sep 2018 08:09:39 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cpandya@codeaurora.org, toshi.kani@hpe.com, tglx@linutronix.de,
        mhocko@suse.com, akpm@linux-foundation.org
Subject: Re: [PATCH 4/5] lib/ioremap: Ensure phys_addr actually corresponds
 to a physical address
Message-ID: <20180912150939.GA30274@linux.intel.com>
References: <1536747974-25875-1-git-send-email-will.deacon@arm.com>
 <1536747974-25875-5-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536747974-25875-5-git-send-email-will.deacon@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 11:26:13AM +0100, Will Deacon wrote:
> The current ioremap() code uses a phys_addr variable at each level of
> page table, which is confusingly offset by subtracting the base virtual
> address being mapped so that adding the current virtual address back on
> when iterating through the page table entries gives back the corresponding
> physical address.
> 
> This is fairly confusing and results in all users of phys_addr having to
> add the current virtual address back on. Instead, this patch just updates
> phys_addr when iterating over the page table entries, ensuring that it's
> always up-to-date and doesn't require explicit offsetting.
> 
> Cc: Chintan Pandya <cpandya@codeaurora.org>
> Cc: Toshi Kani <toshi.kani@hpe.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  lib/ioremap.c | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
> 
> diff --git a/lib/ioremap.c b/lib/ioremap.c
> index 6c72764af19c..fc834a59c90c 100644
> --- a/lib/ioremap.c
> +++ b/lib/ioremap.c
> @@ -101,19 +101,18 @@ static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
>  	pmd_t *pmd;
>  	unsigned long next;
>  
> -	phys_addr -= addr;
>  	pmd = pmd_alloc(&init_mm, pud, addr);
>  	if (!pmd)
>  		return -ENOMEM;
>  	do {
>  		next = pmd_addr_end(addr, end);
>  
> -		if (ioremap_try_huge_pmd(pmd, addr, next, phys_addr + addr, prot))
> +		if (ioremap_try_huge_pmd(pmd, addr, next, phys_addr, prot))
>  			continue;
>  
> -		if (ioremap_pte_range(pmd, addr, next, phys_addr + addr, prot))
> +		if (ioremap_pte_range(pmd, addr, next, phys_addr, prot))
>  			return -ENOMEM;
> -	} while (pmd++, addr = next, addr != end);
> +	} while (pmd++, addr = next, phys_addr += PMD_SIZE, addr != end);

I think bumping phys_addr by PXX_SIZE is wrong if phys_addr and addr
start unaligned with respect to PXX_SIZE.  The addresses must be
PAGE_ALIGNED, which lets ioremap_pte_range() do a simple calculation,
but that doesn't hold true for the upper levels, i.e. phys_addr needs
to be adjusted using an algorithm similar to pxx_addr_end().

Using a 2mb page as an example (lower 32 bits only): 

pxx_size  = 0x00020000
pxx_mask  = 0xfffe0000
addr      = 0x1000
end       = 0x00040000
phys_addr = 0x1000

Loop 1:
   addr = 0x1000
   phys = 0x1000

Loop 2:
   addr = 0x20000
   phys = 0x21000


>  	return 0;
>  }
>  
> @@ -142,19 +141,18 @@ static inline int ioremap_pud_range(p4d_t *p4d, unsigned long addr,
>  	pud_t *pud;
>  	unsigned long next;
>  
> -	phys_addr -= addr;
>  	pud = pud_alloc(&init_mm, p4d, addr);
>  	if (!pud)
>  		return -ENOMEM;
>  	do {
>  		next = pud_addr_end(addr, end);
>  
> -		if (ioremap_try_huge_pud(pud, addr, next, phys_addr + addr, prot))
> +		if (ioremap_try_huge_pud(pud, addr, next, phys_addr, prot))
>  			continue;
>  
> -		if (ioremap_pmd_range(pud, addr, next, phys_addr + addr, prot))
> +		if (ioremap_pmd_range(pud, addr, next, phys_addr, prot))
>  			return -ENOMEM;
> -	} while (pud++, addr = next, addr != end);
> +	} while (pud++, addr = next, phys_addr += PUD_SIZE, addr != end);
>  	return 0;
>  }
>  
> @@ -164,7 +162,6 @@ static inline int ioremap_p4d_range(pgd_t *pgd, unsigned long addr,
>  	p4d_t *p4d;
>  	unsigned long next;
>  
> -	phys_addr -= addr;
>  	p4d = p4d_alloc(&init_mm, pgd, addr);
>  	if (!p4d)
>  		return -ENOMEM;
> @@ -173,14 +170,14 @@ static inline int ioremap_p4d_range(pgd_t *pgd, unsigned long addr,
>  
>  		if (ioremap_p4d_enabled() &&
>  		    ((next - addr) == P4D_SIZE) &&
> -		    IS_ALIGNED(phys_addr + addr, P4D_SIZE)) {
> -			if (p4d_set_huge(p4d, phys_addr + addr, prot))
> +		    IS_ALIGNED(phys_addr, P4D_SIZE)) {
> +			if (p4d_set_huge(p4d, phys_addr, prot))
>  				continue;
>  		}
>  
> -		if (ioremap_pud_range(p4d, addr, next, phys_addr + addr, prot))
> +		if (ioremap_pud_range(p4d, addr, next, phys_addr, prot))
>  			return -ENOMEM;
> -	} while (p4d++, addr = next, addr != end);
> +	} while (p4d++, addr = next, phys_addr += P4D_SIZE, addr != end);
>  	return 0;
>  }
>  
> @@ -196,14 +193,13 @@ int ioremap_page_range(unsigned long addr,
>  	BUG_ON(addr >= end);
>  
>  	start = addr;
> -	phys_addr -= addr;
>  	pgd = pgd_offset_k(addr);
>  	do {
>  		next = pgd_addr_end(addr, end);
> -		err = ioremap_p4d_range(pgd, addr, next, phys_addr+addr, prot);
> +		err = ioremap_p4d_range(pgd, addr, next, phys_addr, prot);
>  		if (err)
>  			break;
> -	} while (pgd++, addr = next, addr != end);
> +	} while (pgd++, addr = next, phys_addr += PGDIR_SIZE, addr != end);
>  
>  	flush_cache_vmap(start, end);
>  
> -- 
> 2.1.4
> 
