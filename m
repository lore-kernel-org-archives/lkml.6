Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAF9C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5042087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB5042087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeILWUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:20:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:12102 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbeILWUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:20:14 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2018 10:14:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,365,1531810800"; 
   d="scan'208";a="91077724"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.20])
  by orsmga002.jf.intel.com with ESMTP; 12 Sep 2018 10:14:34 -0700
Date:   Wed, 12 Sep 2018 10:14:34 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cpandya@codeaurora.org, toshi.kani@hpe.com, tglx@linutronix.de,
        mhocko@suse.com, akpm@linux-foundation.org
Subject: Re: [PATCH 4/5] lib/ioremap: Ensure phys_addr actually corresponds
 to a physical address
Message-ID: <20180912171434.GA31712@linux.intel.com>
References: <1536747974-25875-1-git-send-email-will.deacon@arm.com>
 <1536747974-25875-5-git-send-email-will.deacon@arm.com>
 <20180912150939.GA30274@linux.intel.com>
 <20180912163914.GA16071@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912163914.GA16071@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 05:39:14PM +0100, Will Deacon wrote:
> Hi Sean,
> 
> Thanks for looking at the patch.
> 
> On Wed, Sep 12, 2018 at 08:09:39AM -0700, Sean Christopherson wrote:
> > On Wed, Sep 12, 2018 at 11:26:13AM +0100, Will Deacon wrote:
> > > The current ioremap() code uses a phys_addr variable at each level of
> > > page table, which is confusingly offset by subtracting the base virtual
> > > address being mapped so that adding the current virtual address back on
> > > when iterating through the page table entries gives back the corresponding
> > > physical address.
> > > 
> > > This is fairly confusing and results in all users of phys_addr having to
> > > add the current virtual address back on. Instead, this patch just updates
> > > phys_addr when iterating over the page table entries, ensuring that it's
> > > always up-to-date and doesn't require explicit offsetting.
> > > 
> > > Cc: Chintan Pandya <cpandya@codeaurora.org>
> > > Cc: Toshi Kani <toshi.kani@hpe.com>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Michal Hocko <mhocko@suse.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > > ---
> > >  lib/ioremap.c | 28 ++++++++++++----------------
> > >  1 file changed, 12 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/lib/ioremap.c b/lib/ioremap.c
> > > index 6c72764af19c..fc834a59c90c 100644
> > > --- a/lib/ioremap.c
> > > +++ b/lib/ioremap.c
> > > @@ -101,19 +101,18 @@ static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
> > >  	pmd_t *pmd;
> > >  	unsigned long next;
> > >  
> > > -	phys_addr -= addr;
> > >  	pmd = pmd_alloc(&init_mm, pud, addr);
> > >  	if (!pmd)
> > >  		return -ENOMEM;
> > >  	do {
> > >  		next = pmd_addr_end(addr, end);
> > >  
> > > -		if (ioremap_try_huge_pmd(pmd, addr, next, phys_addr + addr, prot))
> > > +		if (ioremap_try_huge_pmd(pmd, addr, next, phys_addr, prot))
> > >  			continue;
> > >  
> > > -		if (ioremap_pte_range(pmd, addr, next, phys_addr + addr, prot))
> > > +		if (ioremap_pte_range(pmd, addr, next, phys_addr, prot))
> > >  			return -ENOMEM;
> > > -	} while (pmd++, addr = next, addr != end);
> > > +	} while (pmd++, addr = next, phys_addr += PMD_SIZE, addr != end);
> > 
> > I think bumping phys_addr by PXX_SIZE is wrong if phys_addr and addr
> > start unaligned with respect to PXX_SIZE.  The addresses must be
> > PAGE_ALIGNED, which lets ioremap_pte_range() do a simple calculation,
> > but that doesn't hold true for the upper levels, i.e. phys_addr needs
> > to be adjusted using an algorithm similar to pxx_addr_end().
> > 
> > Using a 2mb page as an example (lower 32 bits only): 
> > 
> > pxx_size  = 0x00020000
> > pxx_mask  = 0xfffe0000
> > addr      = 0x1000
> > end       = 0x00040000
> > phys_addr = 0x1000
> > 
> > Loop 1:
> >    addr = 0x1000
> >    phys = 0x1000
> > 
> > Loop 2:
> >    addr = 0x20000
> >    phys = 0x21000
> 
> Yes, I think you're completely right, however I also don't think this
> can happen with the current code (and I've failed to trigger it in my
> testing). The virtual addresses allocated for VM_IOREMAP allocations
> are aligned to the order of the allocation, which means that the virtual
> address at the start of the mapping is aligned such that when we hit the
> end of a pXd, we know we've mapped the previous PXD_SIZE bytes.
> 
> Having said that, this is clearly a change from the current code and I
> haven't audited architectures other than arm64 (where IOREMAP_MAX_ORDER
> corresponds to the maximum size of our huge mappings), so it would be
> much better not to introduce this funny behaviour in a patch that aims
> to reduce confusion in the first place!
> 
> Fixing this using the pxx_addr_end() macros is a bit strange, since we
> don't have a physical end variable (nor do we need one), so perhaps
> something like changing the while condition to be:
> 
> 	do {
> 		...
> 	} while (pmd++, phys_addr += (next - addr), addr = next, addr != end);
> 
> would do the trick. What do you reckon?

LGTM.  I like that there isn't a separate calculation for phys_addr's offset.
