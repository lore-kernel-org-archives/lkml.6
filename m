Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753191AbeDJMrT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:47:19 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:50908 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753147AbeDJMrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:47:18 -0400
Date: Tue, 10 Apr 2018 08:48:44 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Minchan Kim <minchan@kernel.org>, Christopher Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Chris Fries <cfries@google.com>
Subject: Re: [PATCH] mm: workingset: fix NULL ptr dereference
Message-ID: <20180410124844.GC6334@cmpxchg.org>
References: <20180409015815.235943-1-minchan@kernel.org>
 <20180409024925.GA21889@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409024925.GA21889@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 08, 2018 at 07:49:25PM -0700, Matthew Wilcox wrote:
> @@ -2714,8 +2714,10 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
>  		stat(s, ALLOC_FASTPATH);
>  	}
>  
> -	if (unlikely(gfpflags & __GFP_ZERO) && object)
> -		memset(object, 0, s->object_size);
> +	if (unlikely(gfpflags & __GFP_ZERO) && object) {
> +		if (!WARN_ON_ONCE(s->ctor))
> +			memset(object, 0, s->object_size);
> +	}
>  
>  	slab_post_alloc_hook(s, gfpflags, 1, &object);

This looks like a useful check to have. But maybe behind DEBUG_VM?
