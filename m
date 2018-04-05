Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751353AbeDEMvM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 08:51:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37054 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbeDEMvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 08:51:11 -0400
Date: Thu, 5 Apr 2018 05:50:54 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Jia He <hejianet@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Wei Yang <richard.weiyang@gmail.com>,
        Kees Cook <keescook@chromium.org>, Laura Abbott <labbott@redhat.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Philip Derrin <philip@cog.systems>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>, Steve Capper <steve.capper@arm.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>, Kemi Wang <kemi.wang@intel.com>,
        Petr Tesarik <ptesarik@suse.com>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Daniel Vacek <neelx@redhat.com>, Eugeniu Rosca <erosca@de.adit-jv.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jia He <jia.he@hxt-semitech.com>
Subject: Re: [PATCH v7 2/5] arm: arm64: page_alloc: reduce unnecessary binary
 search in memblock_next_valid_pfn()
Message-ID: <20180405125054.GC2647@bombadil.infradead.org>
References: <1522915478-5044-1-git-send-email-hejianet@gmail.com>
 <1522915478-5044-3-git-send-email-hejianet@gmail.com>
 <20180405113444.GB2647@bombadil.infradead.org>
 <1f809296-e88d-1090-0027-890782b91d6e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f809296-e88d-1090-0027-890782b91d6e@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 08:44:12PM +0800, Jia He wrote:
> 
> 
> On 4/5/2018 7:34 PM, Matthew Wilcox Wrote:
> > On Thu, Apr 05, 2018 at 01:04:35AM -0700, Jia He wrote:
> > > Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
> > > where possible") optimized the loop in memmap_init_zone(). But there is
> > > still some room for improvement. E.g. if pfn and pfn+1 are in the same
> > > memblock region, we can simply pfn++ instead of doing the binary search
> > > in memblock_next_valid_pfn.
> > Sure, but I bet if we are >end_pfn, we're almost certainly going to the
> > start_pfn of the next block, so why not test that as well?
> > 
> > > +	/* fast path, return pfn+1 if next pfn is in the same region */
> > > +	if (early_region_idx != -1) {
> > > +		start_pfn = PFN_DOWN(regions[early_region_idx].base);
> > > +		end_pfn = PFN_DOWN(regions[early_region_idx].base +
> > > +				regions[early_region_idx].size);
> > > +
> > > +		if (pfn >= start_pfn && pfn < end_pfn)
> > > +			return pfn;
> > 		early_region_idx++;
> > 		start_pfn = PFN_DOWN(regions[early_region_idx].base);
> > 		if (pfn >= end_pfn && pfn <= start_pfn)
> > 			return start_pfn;
> Thanks, thus the binary search in next step can be discarded?

I don't know all the circumstances in which this is called.  Maybe a linear
search with memo is more appropriate than a binary search.
