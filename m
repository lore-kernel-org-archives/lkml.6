Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757073AbeDKTY5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 15:24:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38574 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753537AbeDKTYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 15:24:53 -0400
Date: Wed, 11 Apr 2018 12:24:48 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Christopher Lameter <cl@linux.com>
Cc: linux-mm@kvack.org, Matthew Wilcox <mawilcox@microsoft.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH v2 2/2] slab: __GFP_ZERO is incompatible with a
 constructor
Message-ID: <20180411192448.GD22494@bombadil.infradead.org>
References: <20180411060320.14458-1-willy@infradead.org>
 <20180411060320.14458-3-willy@infradead.org>
 <alpine.DEB.2.20.1804110842560.3788@nuc-kabylake>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1804110842560.3788@nuc-kabylake>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 08:44:23AM -0500, Christopher Lameter wrote:
> > +++ b/mm/slub.c
> > @@ -2725,7 +2726,7 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
> >  		stat(s, ALLOC_FASTPATH);
> >  	}
> >
> > -	if (unlikely(gfpflags & __GFP_ZERO) && object)
> > +	if (unlikely(gfpflags & __GFP_ZERO) && object && slab_no_ctor(s))
> >  		memset(object, 0, s->object_size);
> >
> >  	slab_post_alloc_hook(s, gfpflags, 1, &object);
> 
> Please put this in a code path that is enabled by specifying
> 
> slub_debug
> 
> on the kernel command line.

I don't understand.  First, I had:

	if (unlikely(gfpflags & __GFP_ZERO) && object && !WARN_ON_ONCE(s->ctor))

and you didn't like that because it was putting checking into a (semi)fast
path.  Now you want me to add a check for slub_debug somewhere?  I dont
see an existing one I can leverage that will hit on every allocation.
Perhaps I'm missing something.
