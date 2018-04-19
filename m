Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752854AbeDSLA6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 07:00:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:43564 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752085AbeDSLA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 07:00:56 -0400
Date: Thu, 19 Apr 2018 13:00:51 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Christopher Lameter <cl@linux.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org,
        dm-devel@redhat.com, David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SLUB: Do not fallback to mininum order if __GFP_NORETRY
 is set
Message-ID: <20180419110051.GB16083@dhcp22.suse.cz>
References: <alpine.DEB.2.20.1804180944180.1062@nuc-kabylake>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1804180944180.1062@nuc-kabylake>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 18-04-18 09:45:39, Cristopher Lameter wrote:
> Mikulas Patoka wants to ensure that no fallback to lower order happens. I
> think __GFP_NORETRY should work correctly in that case too and not fall
> back.

Overriding __GFP_NORETRY is just a bad idea. It will make the semantic
of the flag just more confusing. Note there are users who use
__GFP_NORETRY as a way to suppress heavy memory pressure and/or the OOM
killer. You do not want to change the semantic for them.

Besides that the changelog is less than optimal. What is the actual
problem? Why somebody doesn't want a fallback? Is there a configuration
that could prevent the same?

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

-- 
Michal Hocko
SUSE Labs
