Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752706AbeDRStZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 14:49:25 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45928 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751866AbeDRStY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 14:49:24 -0400
X-Google-Smtp-Source: AIpwx48IbzhCuGSB6AiqZ+mdSR0a22gMXh07ihmXHJDRlxulXfx8YOkJ8TAxmaqTEHkYqsk/2ZmS/w==
Date: Wed, 18 Apr 2018 11:49:22 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Mikulas Patocka <mpatocka@redhat.com>
cc: Christopher Lameter <cl@linux.com>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Snitzer <snitzer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org,
        dm-devel@redhat.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SLUB: Do not fallback to mininum order if __GFP_NORETRY
 is set
In-Reply-To: <alpine.LRH.2.02.1804181102490.13213@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.DEB.2.21.1804181147100.227784@chino.kir.corp.google.com>
References: <alpine.DEB.2.20.1804180944180.1062@nuc-kabylake> <alpine.LRH.2.02.1804181102490.13213@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Apr 2018, Mikulas Patocka wrote:

> > Mikulas Patoka wants to ensure that no fallback to lower order happens. I
> > think __GFP_NORETRY should work correctly in that case too and not fall
> > back.
> > 
> > 
> > 
> > Allocating at a smaller order is a retry operation and should not
> > be attempted.
> > 
> > If the caller does not want retries then respect that.
> > 
> > GFP_NORETRY allows callers to ensure that only maximum order
> > allocations are attempted.
> > 
> > Signed-off-by: Christoph Lameter <cl@linux.com>
> > 
> > Index: linux/mm/slub.c
> > ===================================================================
> > --- linux.orig/mm/slub.c
> > +++ linux/mm/slub.c
> > @@ -1598,7 +1598,7 @@ static struct page *allocate_slab(struct
> >  		alloc_gfp = (alloc_gfp | __GFP_NOMEMALLOC) & ~(__GFP_RECLAIM|__GFP_NOFAIL);
> > 
> >  	page = alloc_slab_page(s, alloc_gfp, node, oo);
> > -	if (unlikely(!page)) {
> > +	if (unlikely(!page) && !(flags & __GFP_NORETRY)) {
> >  		oo = s->min;
> >  		alloc_gfp = flags;
> >  		/*
> 
> No, this would hit NULL pointer dereference if page is NULL and 
> __GFP_NORETRY is set. You want this:
> 
> ---
>  mm/slub.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> Index: linux-2.6/mm/slub.c
> ===================================================================
> --- linux-2.6.orig/mm/slub.c	2018-04-17 20:58:23.000000000 +0200
> +++ linux-2.6/mm/slub.c	2018-04-18 17:04:01.000000000 +0200
> @@ -1599,6 +1599,8 @@ static struct page *allocate_slab(struct
>  
>  	page = alloc_slab_page(s, alloc_gfp, node, oo);
>  	if (unlikely(!page)) {
> +		if (flags & __GFP_NORETRY)
> +			goto out;
>  		oo = s->min;
>  		alloc_gfp = flags;
>  		/*
> 

I don't see the connection between the max order, which can be influenced 
by userspace with slub_min_objects, slub_min_order, etc, and specifying 
__GFP_NORETRY which means try to reclaim and free memory but don't loop.

If I force a slab cache to try a max order of 9 for hugepages as a best 
effort, why does __GFP_NORETRY suddenly mean I won't fallback to 
oo_order(s->min)?
