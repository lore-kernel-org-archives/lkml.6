Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751848AbeBZFSz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 00:18:55 -0500
Received: from mga02.intel.com ([134.134.136.20]:63908 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750793AbeBZFSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 00:18:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,396,1515484800";
   d="scan'208";a="21050134"
From: "Huang\, Ying" <ying.huang@intel.com>
To: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH RESEND 1/2] mm: swap: clean up swap readahead
References: <20180220085249.151400-1-minchan@kernel.org>
        <20180220085249.151400-2-minchan@kernel.org>
        <874lm83zho.fsf@yhuang-dev.intel.com>
        <20180226045617.GA112402@rodete-desktop-imager.corp.google.com>
Date: Mon, 26 Feb 2018 13:18:50 +0800
In-Reply-To: <20180226045617.GA112402@rodete-desktop-imager.corp.google.com>
        (Minchan Kim's message of "Mon, 26 Feb 2018 13:56:17 +0900")
Message-ID: <87d10stjk5.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minchan Kim <minchan@kernel.org> writes:

> On Fri, Feb 23, 2018 at 04:02:27PM +0800, Huang, Ying wrote:
>> <minchan@kernel.org> writes:
>> [snip]
>> 
>> > diff --git a/mm/swap_state.c b/mm/swap_state.c
>> > index 39ae7cfad90f..c56cce64b2c3 100644
>> > --- a/mm/swap_state.c
>> > +++ b/mm/swap_state.c
>> > @@ -332,32 +332,38 @@ struct page *lookup_swap_cache(swp_entry_t entry, struct vm_area_struct *vma,
>> >  			       unsigned long addr)
>> >  {
>> >  	struct page *page;
>> > -	unsigned long ra_info;
>> > -	int win, hits, readahead;
>> >  
>> >  	page = find_get_page(swap_address_space(entry), swp_offset(entry));
>> >  
>> >  	INC_CACHE_INFO(find_total);
>> >  	if (page) {
>> > +		bool vma_ra = swap_use_vma_readahead();
>> > +		bool readahead = TestClearPageReadahead(page);
>> > +
>> 
>> TestClearPageReadahead() cannot be called for compound page.  As in
>> 
>> PAGEFLAG(Readahead, reclaim, PF_NO_COMPOUND)
>> 	TESTCLEARFLAG(Readahead, reclaim, PF_NO_COMPOUND)
>> 
>> >  		INC_CACHE_INFO(find_success);
>> >  		if (unlikely(PageTransCompound(page)))
>> >  			return page;
>> > -		readahead = TestClearPageReadahead(page);
>> 
>> So we can only call it here after checking whether page is compound.
>
> Hi Huang,
>
> Thanks for cathing this.
> However, I don't see the reason we should rule out THP page for
> readahead marker. Could't we relax the rule?
>
> I hope we can do so that we could remove PageTransCompound check
> for readahead marker, which makes code ugly.
>
> From 748b084d5c3960ec2418d8c51a678aada30f1072 Mon Sep 17 00:00:00 2001
> From: Minchan Kim <minchan@kernel.org>
> Date: Mon, 26 Feb 2018 13:46:43 +0900
> Subject: [PATCH] mm: relax policy for PG_readahead
>
> This flag is in use for anon THP page so let's relax it.
>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  include/linux/page-flags.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index e34a27727b9a..f12d4dfae580 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -318,8 +318,8 @@ PAGEFLAG(MappedToDisk, mappedtodisk, PF_NO_TAIL)
>  /* PG_readahead is only used for reads; PG_reclaim is only for writes */
>  PAGEFLAG(Reclaim, reclaim, PF_NO_TAIL)
>  	TESTCLEARFLAG(Reclaim, reclaim, PF_NO_TAIL)
> -PAGEFLAG(Readahead, reclaim, PF_NO_COMPOUND)
> -	TESTCLEARFLAG(Readahead, reclaim, PF_NO_COMPOUND)
> +PAGEFLAG(Readahead, reclaim, PF_NO_TAIL)
> +	TESTCLEARFLAG(Readahead, reclaim, PF_NO_TAIL)
>  
>  #ifdef CONFIG_HIGHMEM
>  /*

We never set Readahead bit for THP in reality.  The original code acts
as document for this.  I don't think it is a good idea to change this
without a good reason.

Best Regards,
Huang, Ying
