Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755279AbeDKVLW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 17:11:22 -0400
Received: from resqmta-ch2-11v.sys.comcast.net ([69.252.207.43]:39452 "EHLO
        resqmta-ch2-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753258AbeDKVLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 17:11:19 -0400
Date: Wed, 11 Apr 2018 16:11:17 -0500 (CDT)
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
In-Reply-To: <20180411192448.GD22494@bombadil.infradead.org>
Message-ID: <alpine.DEB.2.20.1804111601090.7458@nuc-kabylake>
References: <20180411060320.14458-1-willy@infradead.org> <20180411060320.14458-3-willy@infradead.org> <alpine.DEB.2.20.1804110842560.3788@nuc-kabylake> <20180411192448.GD22494@bombadil.infradead.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfN+nXFTaL/GCaQdMvox7DUkk+vaan1S5or1M12BuWnrlQvyrKGl69Q1kZKrGMvhBcAf6eY0TdUVciLw8dflpHdZKrQMsxLqBjjAxj/bH0NNwWx2zgpxD
 ppa3f+TVaR0lNid1q4zbxM0ImlsxqPMbd3EfeNvGlajW0v4F9kpp9PVP6/8uA9be9RJ50WYGkVVfHGgWvN+5/+hZbz0hMv5BYuYAdlJiWfkIrk0z2z9vYqG5
 NraJI0Li/bgb9BmVukRm7Z/KeZnFIpQsAbKdnQocnTRQsUyORN3YgoHzrnb2o7x1bSjtPL2GemTdijH0pCG5wNsHxjtmTAh7U2N4nSkn1PpfpgB49hAExhzK
 V9pDXpSRYhNzrGjX+z1rA1HkpQ5hfnJvEyJ4VQ0u6IQNxAuuYrOybuJOb4g42WOYBgNi5G2AUk7HwDo3Yg1vmciMcC/YjCstHeDgzL2qKRbmIUL6OQEY03HE
 +HbhEtU8T+DAq99u
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Apr 2018, Matthew Wilcox wrote:

> > >  	slab_post_alloc_hook(s, gfpflags, 1, &object);
> >
> > Please put this in a code path that is enabled by specifying
> >
> > slub_debug
> >
> > on the kernel command line.
>
> I don't understand.  First, I had:
>
> 	if (unlikely(gfpflags & __GFP_ZERO) && object && !WARN_ON_ONCE(s->ctor))
>
> and you didn't like that because it was putting checking into a (semi)fast
> path.  Now you want me to add a check for slub_debug somewhere?  I dont
> see an existing one I can leverage that will hit on every allocation.
> Perhaps I'm missing something.

The WARN_ON is only enabled when you configure and build the kernel with
debugging enabled (CONFIG_VM_DEBUG). That is a compile time debugging
feature like supported by SLAB.

SLUB debugging is different because we had problems isolating memory
corruption bugs in the production kernels for years. The debug code is
always included in the build but kept out of the hotpaths.


The debug can be enabled when needed to find memory corruption errors
without the need to rebuild a kernel for a prod environment (which may
change race conditions etc) because we only then need to add a kernel
parameter.

"slub_debug" enables kmem_cache->flags & SLAB_DEBUG and that forces all
fastpath processing to be disabled. Thus you can check reliably in the
slow path only for the GFP_ZERO problem.

Add the check to the other debug stuff already there. F.e. in
alloc_debug_processing() or after

if (kmem_cache_debug(s) ...

in ____slab_alloc()
