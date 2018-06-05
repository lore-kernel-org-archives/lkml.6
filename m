Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752480AbeFETMt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:12:49 -0400
Received: from outbound-smtp11.blacknight.com ([46.22.139.106]:44487 "EHLO
        outbound-smtp11.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752449AbeFETMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:12:48 -0400
Date: Tue, 5 Jun 2018 20:12:46 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, mhocko@kernel.org,
        vbabka@suse.cz, Aaron Lu <aaron.lu@intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mremap: Avoid TLB flushing anonymous pages that are not
 in swap cache
Message-ID: <20180605191245.3owve7gfut22tyob@techsingularity.net>
References: <20180605171319.uc5jxdkxopio6kg3@techsingularity.net>
 <bfc2e579-915f-24db-0ff0-29bd9148b8c0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <bfc2e579-915f-24db-0ff0-29bd9148b8c0@intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 11:18:18AM -0700, Dave Hansen wrote:
> On 06/05/2018 10:13 AM, Mel Gorman wrote:
> > The anonymous page race fix is overkill for two reasons. Pages that are not
> > in the swap cache are not going to be issued for IO and if a stale TLB entry
> > is used, the write still occurs on the same physical page. Any race with
> > mmap replacing the address space is handled by mmap_sem. As anonymous pages
> > are often dirty, it can mean that mremap always has to flush even when it is
> > not necessary.
> 
> This looks fine to me.  One nit on the description: I found myself
> wondering if we skip the flush under the ptl where the flush is
> eventually done.  That code is a bit out of the context, so we don't see
> it in the patch.
> 

That's fair enough. I updated part of the changelog to read

This patch special cases anonymous pages to only flush ranges under the
page table lock if the page is in swap cache and can be potentially queued
for IO. Note that the full flush of the range being mremapped is still
flushed so TLB flushes are not eliminated entirely.

Does that work for you?

> We have two modes of flushing during move_ptes():
> 1. The flush_tlb_range() while holding the ptl in move_ptes().
> 2. A flush_tlb_range() at the end of move_table_tables(), driven by
>   'need_flush' which will be set any time move_ptes() does *not* flush.
> 
> This patch broadens the scope where move_ptes() does not flush and
> shifts the burden to the flush inside move_table_tables().
> 
> Right?
> 

Yes. While this does not eliminate TLB flushes, it reduces the number
considerably as we potentially are replacing one-flush-per-LATENCY_LIMIT
with one flush.

> Other minor nits:
> 
> > +/* Returns true if a TLB must be flushed before PTL is dropped */
> > +static bool should_force_flush(pte_t *pte)
> > +{
> 
> I usually try to make the non-pte-modifying functions take a pte_t
> instead of 'pte_t *' to make it obvious that there no modification going
> on.  Any reason not to do that here?
> 

No, it was just a minor saving on stack usage.

> > +	if (!trylock_page(page))
> > +		return true;
> > +	is_swapcache = PageSwapCache(page);
> > +	unlock_page(page);
> > +
> > +	return is_swapcache;
> > +}
> 
> I was hoping we didn't have to go as far as taking the page lock, but I
> guess the proof is in the pudding that this tradeoff is worth it.
> 

In the interest of full disclosure, the feedback I have from the customer is
based on a patch that modifies the LATENCY_LIMIT. This helped but did not
eliminate the problem. This was potentially a better solution but I wanted
review first. I'm waiting on confirmation this definitely behaves better.

> BTW, do you want to add a tiny comment about why we do the
> trylock_page()?  I assume it's because we don't want to wait on finding
> an exact answer: we just assume it is in the swap cache if the page is
> locked and flush regardless.

It's really because calling lock_page while holding a spinlock is
eventually going to ruin your day.

Thanks.

-- 
Mel Gorman
SUSE Labs
