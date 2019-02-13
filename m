Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE37C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4809020835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392371AbfBMOlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:41:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:56780 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390248AbfBMOlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:41:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 641C7ABCE;
        Wed, 13 Feb 2019 14:41:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D94551E09C5; Wed, 13 Feb 2019 15:41:02 +0100 (CET)
Date:   Wed, 13 Feb 2019 15:41:02 +0100
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Kirill A . Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v2] page cache: Store only head pages in i_pages
Message-ID: <20190213144102.GA18351@quack2.suse.cz>
References: <20190212183454.26062-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212183454.26062-1-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12-02-19 10:34:54, Matthew Wilcox wrote:
> Transparent Huge Pages are currently stored in i_pages as pointers to
> consecutive subpages.  This patch changes that to storing consecutive
> pointers to the head page in preparation for storing huge pages more
> efficiently in i_pages.
> 
> Large parts of this are "inspired" by Kirill's patch
> https://lore.kernel.org/lkml/20170126115819.58875-2-kirill.shutemov@linux.intel.com/
> 
> Signed-off-by: Matthew Wilcox <willy@infradead.org>

I like the idea!

> @@ -1778,33 +1767,27 @@ unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
>  
>  	rcu_read_lock();
>  	xas_for_each(&xas, page, end) {
> -		struct page *head;
>  		if (xas_retry(&xas, page))
>  			continue;
>  		/* Skip over shadow, swap and DAX entries */
>  		if (xa_is_value(page))
>  			continue;
>  
> -		head = compound_head(page);
> -		if (!page_cache_get_speculative(head))
> +		if (!page_cache_get_speculative(page))
>  			goto retry;
>  
> -		/* The page was split under us? */
> -		if (compound_head(page) != head)
> -			goto put_page;
> -
> -		/* Has the page moved? */
> +		/* Has the page moved or been split? */
>  		if (unlikely(page != xas_reload(&xas)))
>  			goto put_page;
>  
> -		pages[ret] = page;
> +		pages[ret] = find_subpage(page, xas.xa_index);
>  		if (++ret == nr_pages) {
>  			*start = page->index + 1;
>  			goto out;
>  		}

So this subtly changes the behavior because now we will be returning in
'*start' a different index. So you should rather use 'pages[ret]->index'
instead.

> @@ -1923,26 +1899,21 @@ unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
>  		if (xa_is_value(page))
>  			continue;
>  
> -		head = compound_head(page);
> -		if (!page_cache_get_speculative(head))
> +		if (!page_cache_get_speculative(page))
>  			goto retry;
>  
> -		/* The page was split under us? */
> -		if (compound_head(page) != head)
> -			goto put_page;
> -
> -		/* Has the page moved? */
> +		/* Has the page moved or been split? */
>  		if (unlikely(page != xas_reload(&xas)))
>  			goto put_page;
>  
> -		pages[ret] = page;
> +		pages[ret] = find_subpage(page, xas.xa_index);
>  		if (++ret == nr_pages) {
>  			*index = page->index + 1;
>  			goto out;
>  		}

Ditto here.

Otherwise the patch looks good to me so feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

after fixing these two.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
