Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F19C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BDF522503
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BDF522503
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbeKLXvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 18:51:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:57024 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727842AbeKLXvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 18:51:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7CF0FB11D;
        Mon, 12 Nov 2018 13:58:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6F0121E07E6; Mon, 12 Nov 2018 14:58:11 +0100 (CET)
Date:   Mon, 12 Nov 2018 14:58:11 +0100
From:   Jan Kara <jack@suse.cz>
To:     john.hubbard@gmail.com
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 6/6] mm: track gup pages with page->dma_pinned_* fields
Message-ID: <20181112135811.GF7175@quack2.suse.cz>
References: <20181110085041.10071-1-jhubbard@nvidia.com>
 <20181110085041.10071-7-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181110085041.10071-7-jhubbard@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Just as a side note, can you please CC me on the whole series next time?
Because this time I had to look up e.g. the introductory email in the
mailing list... Thanks!

On Sat 10-11-18 00:50:41, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> This patch sets and restores the new page->dma_pinned_flags and
> page->dma_pinned_count fields, but does not actually use them for
> anything yet.
> 
> In order to use these fields at all, the page must be removed from
> any LRU list that it's on. The patch also adds some precautions that
> prevent the page from getting moved back onto an LRU, once it is
> in this state.
> 
> This is in preparation to fix some problems that came up when using
> devices (NICs, GPUs, for example) that set up direct access to a chunk
> of system (CPU) memory, so that they can DMA to/from that memory.
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Christopher Lameter <cl@linux.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  include/linux/mm.h | 19 +++++----------
>  mm/gup.c           | 55 +++++++++++++++++++++++++++++++++++++++++--
>  mm/memcontrol.c    |  8 +++++++
>  mm/swap.c          | 58 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 125 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 09fbb2c81aba..6c64b1e0b777 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -950,6 +950,10 @@ static inline void put_page(struct page *page)
>  {
>  	page = compound_head(page);
>  
> +	VM_BUG_ON_PAGE(PageDmaPinned(page) &&
> +		       page_ref_count(page) <
> +				atomic_read(&page->dma_pinned_count),
> +		       page);
>  	/*
>  	 * For devmap managed pages we need to catch refcount transition from
>  	 * 2 to 1, when refcount reach one it means the page is free and we
> @@ -964,21 +968,10 @@ static inline void put_page(struct page *page)
>  }
>  
>  /*
> - * put_user_page() - release a page that had previously been acquired via
> - * a call to one of the get_user_pages*() functions.
> - *
>   * Pages that were pinned via get_user_pages*() must be released via
> - * either put_user_page(), or one of the put_user_pages*() routines
> - * below. This is so that eventually, pages that are pinned via
> - * get_user_pages*() can be separately tracked and uniquely handled. In
> - * particular, interactions with RDMA and filesystems need special
> - * handling.
> + * one of these put_user_pages*() routines:
>   */
> -static inline void put_user_page(struct page *page)
> -{
> -	put_page(page);
> -}
> -
> +void put_user_page(struct page *page);
>  void put_user_pages_dirty(struct page **pages, unsigned long npages);
>  void put_user_pages_dirty_lock(struct page **pages, unsigned long npages);
>  void put_user_pages(struct page **pages, unsigned long npages);
> diff --git a/mm/gup.c b/mm/gup.c
> index 55a41dee0340..ec1b26591532 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -25,6 +25,50 @@ struct follow_page_context {
>  	unsigned int page_mask;
>  };
>  
> +static void pin_page_for_dma(struct page *page)
> +{
> +	int ret = 0;
> +	struct zone *zone;
> +
> +	page = compound_head(page);
> +	zone = page_zone(page);
> +
> +	spin_lock(zone_gup_lock(zone));

A think you'll need irqsafe lock here as get_user_pages_fast() can get
called from interrupt context in some cases. And so can put_user_page()...

<snip>

> +/*
> + * put_user_page() - release a page that had previously been acquired via
> + * a call to one of the get_user_pages*() functions.
> + *
> + * Usage: Pages that were pinned via get_user_pages*() must be released via
> + * either put_user_page(), or one of the put_user_pages*() routines
> + * below. This is so that eventually, pages that are pinned via
> + * get_user_pages*() can be separately tracked and uniquely handled. In
> + * particular, interactions with RDMA and filesystems need special
> + * handling.
> + */
> +void put_user_page(struct page *page)
> +{
> +	struct zone *zone = page_zone(page);
> +
> +	page = compound_head(page);
> +
> +	if (atomic_dec_and_test(&page->dma_pinned_count)) {
> +		spin_lock(zone_gup_lock(zone));
> +		/* Re-check while holding the lock, because
> +		 * pin_page_for_dma() or get_page() may have snuck in right
> +		 * after the atomic_dec_and_test, and raised the count
> +		 * above zero again. If so, just leave the flag set. And
> +		 * because the atomic_dec_and_test above already got the
> +		 * accounting correct, no other action is required.
> +		 */
> +		VM_BUG_ON_PAGE(PageLRU(page), page);
> +		VM_BUG_ON_PAGE(!PageDmaPinned(page), page);
> +
> +		if (atomic_read(&page->dma_pinned_count) == 0) {

We have atomic_dec_and_lock[_irqsave]() exactly for constructs like this.

> +			ClearPageDmaPinned(page);
> +
> +			if (PageDmaPinnedWasLru(page)) {
> +				ClearPageDmaPinnedWasLru(page);
> +				putback_lru_page(page);
> +			}
> +		}
> +
> +		spin_unlock(zone_gup_lock(zone));
> +	}
> +
> +	put_page(page);
> +}
> +EXPORT_SYMBOL(put_user_page);
> +

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
