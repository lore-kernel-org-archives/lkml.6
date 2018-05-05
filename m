Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbeEEEaT (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 00:30:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34842 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbeEEEaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 00:30:18 -0400
Date: Fri, 4 May 2018 21:30:15 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Kees Cook <keescook@google.com>
Cc: Matthew Wilcox <mawilcox@microsoft.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: *alloc API changes
Message-ID: <20180505043015.GC20495@bombadil.infradead.org>
References: <CAGXu5j++1TLqGGiTLrU7OvECfBAR6irWNke9u7Rr2i8g6_30QQ@mail.gmail.com>
 <20180505034646.GA20495@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180505034646.GA20495@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 08:46:46PM -0700, Matthew Wilcox wrote:
> On Fri, May 04, 2018 at 06:08:23PM -0700, Kees Cook wrote:
> > The number of permutations for our various allocation function is
> > rather huge. Currently, it is:
> > 
> > system or wrapper:
> > kmem_cache_alloc, kmalloc, vmalloc, kvmalloc, devm_kmalloc,
> > dma_alloc_coherent, pci_alloc_consistent, kmem_alloc, f2fs_kvalloc,
> > and probably others I haven't found yet.
> 
> dma_pool_alloc, page_frag_alloc, gen_pool_alloc, __alloc_bootmem_node,
> cma_alloc, quicklist_alloc (deprecated), mempool_alloc
> 
> > allocation method (not all available in all APIs):
> > regular (kmalloc), zeroed (kzalloc), array (kmalloc_array), zeroed
> > array (kcalloc)
> 
> ... other initialiser (kmem_cache_alloc)

I meant to say that we have a shocking dearth of foo_realloc() functions.
Instead we have drivers and core parts of the kernel implementing their
own stupid slow alloc-a-new-chunk-of-memory-and-memcpy-from-the-old-then-
free when the allocator can probably do a better job (eg vmalloc may
be able to expand the existing are, and if it can't do that, it can
at least remap the underlying pages; the slab allocator may be able to
resize without growing, eg if you krealloc from 1200 bytes to 2000 bytes,
that's going to come out of the same slab).

So, yeah, adding those increases the API permutations even further.
And don't ask about what happens if you allocate with GFP_DMA then
realloc with GFP_HIGHMEM.
