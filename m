Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752908AbeDKNo1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:44:27 -0400
Received: from resqmta-ch2-11v.sys.comcast.net ([69.252.207.43]:50904 "EHLO
        resqmta-ch2-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751541AbeDKNo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:44:26 -0400
Date: Wed, 11 Apr 2018 08:44:23 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Matthew Wilcox <willy@infradead.org>
cc: linux-mm@kvack.org, Matthew Wilcox <mawilcox@microsoft.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH v2 2/2] slab: __GFP_ZERO is incompatible with a
 constructor
In-Reply-To: <20180411060320.14458-3-willy@infradead.org>
Message-ID: <alpine.DEB.2.20.1804110842560.3788@nuc-kabylake>
References: <20180411060320.14458-1-willy@infradead.org> <20180411060320.14458-3-willy@infradead.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfPNKBrFjObshxqS//aSWnjYTjapkjqXPjJHi11+j75mF500KvhT9Dh7rWI7VMzRDuSrdaN0s+qDBlzuzEPEnh1gFWag2tzuBvsUbJ4bcPx0I2PSHcK2V
 58RhoCNt/FJjErAAcX3AK815v6IH8Pfu5dU80elx8VtyRGjHsRBKezBSK1LjcmcPhQiGMvA3az2tERY9pTa7TR9Caxm2PC/+UKb+v3P7d7nvWcN47tCaIaKu
 oUJB2HP80+MGD6ANccv6pThH2PwaSCYX5xJLmxgxLIZCI0NxQP5imtv+m3Sa6Y89ibP8LtuSAD4zHt5qs9kKRoHm4PQZeJ62eP0VDsGAvvkzAvqSMr4sHGyz
 jOOFOtDYn0iaMd24PvWFMl2T7jhaayNOfNRWbmK3PB5tvxPhhqPEjajqHs7NgH0dH5NzYALHTPNAuy6BcA6uNZfKhRXX6nH0W682wUF+GZCsXLY6uD7wk2eh
 77Skf0aQFQVWF1s8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2018, Matthew Wilcox wrote:

> diff --git a/mm/slab.h b/mm/slab.h
> index 3cd4677953c6..896818c7b30a 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -515,6 +515,13 @@ static inline void dump_unreclaimable_slab(void)
>
>  void ___cache_free(struct kmem_cache *cache, void *x, unsigned long addr);
>
> +static inline bool slab_no_ctor(struct kmem_cache *s)
> +{
> +	if (IS_ENABLED(CONFIG_DEBUG_VM))
> +		return !WARN_ON_ONCE(s->ctor);
> +	return true;
> +}
> +
>  #ifdef CONFIG_SLAB_FREELIST_RANDOM
>  int cache_random_seq_create(struct kmem_cache *cachep, unsigned int count,
>  			gfp_t gfp);

Move that to mm/slab.c? Debugging is runtime enabled with SLUB not compile
time as with SLAB.

> +++ b/mm/slub.c
> @@ -2725,7 +2726,7 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
>  		stat(s, ALLOC_FASTPATH);
>  	}
>
> -	if (unlikely(gfpflags & __GFP_ZERO) && object)
> +	if (unlikely(gfpflags & __GFP_ZERO) && object && slab_no_ctor(s))
>  		memset(object, 0, s->object_size);
>
>  	slab_post_alloc_hook(s, gfpflags, 1, &object);

Please put this in a code path that is enabled by specifying

slub_debug

on the kernel command line.
