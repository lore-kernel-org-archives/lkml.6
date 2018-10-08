Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B07AC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 059B020652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 059B020652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbeJHUyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:54:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:48396 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726056AbeJHUyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:54:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9AACDABE3;
        Mon,  8 Oct 2018 13:42:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1FA4B1E3615; Mon,  8 Oct 2018 15:42:30 +0200 (CEST)
Date:   Mon, 8 Oct 2018 15:42:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Ross Zwisler <zwisler@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: Re: [PATCH v2] filesystem-dax: Fix dax_layout_busy_page() livelock
Message-ID: <20181008134230.GC21682@quack2.suse.cz>
References: <153889193718.3143179.3432479794012686784.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153889193718.3143179.3432479794012686784.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 06-10-18 22:59:56, Dan Williams wrote:
> In the presence of multi-order entries the typical
> pagevec_lookup_entries() pattern may loop forever:
> 
> 	while (index < end && pagevec_lookup_entries(&pvec, mapping, index,
> 				min(end - index, (pgoff_t)PAGEVEC_SIZE),
> 				indices)) {
> 		...
> 		for (i = 0; i < pagevec_count(&pvec); i++) {
> 			index = indices[i];
> 			...
> 		}
> 		index++; /* BUG */
> 	}
> 
> The loop updates 'index' for each index found and then increments to the
> next possible page to continue the lookup. However, if the last entry in
> the pagevec is multi-order then the next possible page index is more
> than 1 page away. Fix this locally for the filesystem-dax case by
> checking for dax-multi-order entries. Going forward new users of
> multi-order entries need to be similarly careful, or we need a generic
> way to report the page increment in the radix iterator.
> 
> Fixes: 5fac7408d828 ("mm, fs, dax: handle layout changes to pinned dax...")
> Cc: <stable@vger.kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Ross Zwisler <zwisler@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Changes in v2:
> * Only update nr_pages if the last entry in the pagevec is multi-order.
> 
>  fs/dax.c |   13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)

Thanks for fixing this up! It is somewhat ugly but nicer fixes would be
more intrusive so I agree with this approach for the ease of backporting
and let's clean up the iteration code later. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 4becbf168b7f..0fb270f0a0ef 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -666,6 +666,8 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
>  	while (index < end && pagevec_lookup_entries(&pvec, mapping, index,
>  				min(end - index, (pgoff_t)PAGEVEC_SIZE),
>  				indices)) {
> +		pgoff_t nr_pages = 1;
> +
>  		for (i = 0; i < pagevec_count(&pvec); i++) {
>  			struct page *pvec_ent = pvec.pages[i];
>  			void *entry;
> @@ -680,8 +682,15 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
>  
>  			xa_lock_irq(&mapping->i_pages);
>  			entry = get_unlocked_mapping_entry(mapping, index, NULL);
> -			if (entry)
> +			if (entry) {
>  				page = dax_busy_page(entry);
> +				/*
> +				 * Account for multi-order entries at
> +				 * the end of the pagevec.
> +				 */
> +				if (i + 1 >= pagevec_count(&pvec))
> +					nr_pages = 1UL << dax_radix_order(entry);
> +			}
>  			put_unlocked_mapping_entry(mapping, index, entry);
>  			xa_unlock_irq(&mapping->i_pages);
>  			if (page)
> @@ -696,7 +705,7 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
>  		 */
>  		pagevec_remove_exceptionals(&pvec);
>  		pagevec_release(&pvec);
> -		index++;
> +		index += nr_pages;
>  
>  		if (page)
>  			break;
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
