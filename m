Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AD4C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D10C2147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WL/hQ+wP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfAGWji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 17:39:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53032 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfAGWji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 17:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DfEwCobDdPragWkQfeqclBCviPibI3tZKDDD0q1KQpU=; b=WL/hQ+wPM4VjJgmcsRyT5NTIp
        CbDkQuQed2oVyvw2wnUUT2ANCd9gSBGdR3QUVzhVoUajsIkUSUOtRbrsIImyNLQYlRaGzsdQQ/gAr
        9P5ZaOHhTclVTFi6mlrdfxtif9NDGmQteb2o99trYwZ5rRXZW2eApsgyG7tDUW1JghDhJKqbwLq4J
        y0NMCxF3n+iUwaFMNBumgunKiCtnrKkhN8Oyey34N2mnsROW9g8CS3mRzhCmhXJR62yqbd2x15k0R
        z4SmAToGzFB5fQXF3+3VczYgIdrSGquupkArZgtY8iNzylONRKsQFMVjziisnBOYbs9rSqNo/cxda
        FJuO2RaCw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ggdYV-0004p7-BJ; Mon, 07 Jan 2019 22:39:35 +0000
Date:   Mon, 7 Jan 2019 14:39:35 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Remove redundant test from find_get_pages_contig
Message-ID: <20190107223935.GC6310@bombadil.infradead.org>
References: <20190107200224.13260-1-willy@infradead.org>
 <20190107143319.c74593a70c86441b80e7cccc@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107143319.c74593a70c86441b80e7cccc@linux-foundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 02:33:19PM -0800, Andrew Morton wrote:
> On Mon,  7 Jan 2019 12:02:24 -0800 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > After we establish a reference on the page, we check the pointer continues
> > to be in the correct position in i_pages.  There's no need to check the
> > page->mapping or page->index afterwards; if those can change after we've
> > got the reference, they can change after we return the page to the caller.
> 
> But that isn't what the comment says.

Right.  That patch from Nick moved the check from before taking the
ref to after taking the ref.  It was racy to have it before.  But it's
unnecessary to have it afterwards -- pages can't move once there's a
ref on them.  Or if they can move, they can move after the ref is taken.

> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -1837,16 +1837,6 @@ unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t index,
> >  		if (unlikely(page != xas_reload(&xas)))
> >  			goto put_page;
> >  
> > -		/*
> > -		 * must check mapping and index after taking the ref.
> > -		 * otherwise we can get both false positives and false
> > -		 * negatives, which is just confusing to the caller.
> > -		 */
> > -		if (!page->mapping || page_to_pgoff(page) != xas.xa_index) {
> > -			put_page(page);
> > -			break;
> > -		}
> 
> The assertion here is that the page's state can alter before we take
> the ref but not afterwards.  Which is contrary to your assertion that
> "they can change after we return the page to the caller".
> 
> This:
> 
> commit 9cbb4cb21b19fff46cf1174d0ed699ef710e641c
> Author:     Nick Piggin <npiggin@kernel.dk>
> AuthorDate: Thu Jan 13 15:45:51 2011 -0800
> Commit:     Linus Torvalds <torvalds@linux-foundation.org>
> CommitDate: Thu Jan 13 17:32:32 2011 -0800
> 
>     mm: find_get_pages_contig fixlet
>     
>     Testing ->mapping and ->index without a ref is not stable as the page
>     may have been reused at this point.
>     
>     Signed-off-by: Nick Piggin <npiggin@kernel.dk>
>     Reviewed-by: Wu Fengguang <fengguang.wu@intel.com>
>     Reviewed-by: Minchan Kim <minchan.kim@gmail.com>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index ca389394fa2a..1a3dd5914726 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -837,9 +837,6 @@ unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t index,
>  		if (radix_tree_deref_retry(page))
>  			goto restart;
>  
> -		if (page->mapping == NULL || page->index != index)
> -			break;
> -
>  		if (!page_cache_get_speculative(page))
>  			goto repeat;
>  
> @@ -849,6 +846,16 @@ unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t index,
>  			goto repeat;
>  		}
>  
> +		/*
> +		 * must check mapping and index after taking the ref.
> +		 * otherwise we can get both false positives and false
> +		 * negatives, which is just confusing to the caller.
> +		 */
> +		if (page->mapping == NULL || page->index != index) {
> +			page_cache_release(page);
> +			break;
> +		}
> +
>  		pages[ret] = page;
>  		ret++;
>  		index++;
> 
> 
