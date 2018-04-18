Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753057AbeDRPFj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 11:05:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47116 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752871AbeDRPFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 11:05:37 -0400
Date: Wed, 18 Apr 2018 11:05:31 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Christopher Lameter <cl@linux.com>
cc: Vlastimil Babka <vbabka@suse.cz>, Mike Snitzer <snitzer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org,
        dm-devel@redhat.com, David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SLUB: Do not fallback to mininum order if __GFP_NORETRY
 is set
In-Reply-To: <alpine.DEB.2.20.1804180944180.1062@nuc-kabylake>
Message-ID: <alpine.LRH.2.02.1804181102490.13213@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.DEB.2.20.1804180944180.1062@nuc-kabylake>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Apr 2018, Christopher Lameter wrote:

> Mikulas Patoka wants to ensure that no fallback to lower order happens. I
> think __GFP_NORETRY should work correctly in that case too and not fall
> back.
> 
> 
> 
> Allocating at a smaller order is a retry operation and should not
> be attempted.
> 
> If the caller does not want retries then respect that.
> 
> GFP_NORETRY allows callers to ensure that only maximum order
> allocations are attempted.
> 
> Signed-off-by: Christoph Lameter <cl@linux.com>
> 
> Index: linux/mm/slub.c
> ===================================================================
> --- linux.orig/mm/slub.c
> +++ linux/mm/slub.c
> @@ -1598,7 +1598,7 @@ static struct page *allocate_slab(struct
>  		alloc_gfp = (alloc_gfp | __GFP_NOMEMALLOC) & ~(__GFP_RECLAIM|__GFP_NOFAIL);
> 
>  	page = alloc_slab_page(s, alloc_gfp, node, oo);
> -	if (unlikely(!page)) {
> +	if (unlikely(!page) && !(flags & __GFP_NORETRY)) {
>  		oo = s->min;
>  		alloc_gfp = flags;
>  		/*

No, this would hit NULL pointer dereference if page is NULL and 
__GFP_NORETRY is set. You want this:

---
 mm/slub.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6/mm/slub.c
===================================================================
--- linux-2.6.orig/mm/slub.c	2018-04-17 20:58:23.000000000 +0200
+++ linux-2.6/mm/slub.c	2018-04-18 17:04:01.000000000 +0200
@@ -1599,6 +1599,8 @@ static struct page *allocate_slab(struct
 
 	page = alloc_slab_page(s, alloc_gfp, node, oo);
 	if (unlikely(!page)) {
+		if (flags & __GFP_NORETRY)
+			goto out;
 		oo = s->min;
 		alloc_gfp = flags;
 		/*
