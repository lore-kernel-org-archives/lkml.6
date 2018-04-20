Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754786AbeDTMU0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 08:20:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754705AbeDTMUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 08:20:24 -0400
Date: Fri, 20 Apr 2018 08:20:23 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Matthew Wilcox <willy@infradead.org>
cc: David Miller <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        eric.dumazet@gmail.com, edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org, dm-devel@redhat.com,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] kvmalloc: always use vmalloc if CONFIG_DEBUG_VM
In-Reply-To: <20180420114712.GB10788@bombadil.infradead.org>
Message-ID: <alpine.LRH.2.02.1804200817230.22382@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1804181029270.19294@file01.intranet.prod.int.rdu2.redhat.com> <3e65977e-53cd-bf09-bc4b-0ce40e9091fe@gmail.com> <alpine.LRH.2.02.1804181218270.19136@file01.intranet.prod.int.rdu2.redhat.com> <20180418.134651.2225112489265654270.davem@davemloft.net>
 <alpine.LRH.2.02.1804181350050.17942@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.1804191207380.31175@file01.intranet.prod.int.rdu2.redhat.com> <20180420114712.GB10788@bombadil.infradead.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Apr 2018, Matthew Wilcox wrote:

> On Thu, Apr 19, 2018 at 12:12:38PM -0400, Mikulas Patocka wrote:
> > Unfortunatelly, some kernel code has bugs - it uses kvmalloc and then
> > uses DMA-API on the returned memory or frees it with kfree. Such bugs were
> > found in the virtio-net driver, dm-integrity or RHEL7 powerpc-specific
> > code.
> 
> Maybe it's time to have the SG code handle vmalloced pages?  This is
> becoming more and more common with vmapped stacks (and some of our
> workarounds are hideous -- allocate 4 bytes with kmalloc because we can't
> DMA onto the stack any more?).  We already have a few places which do
> handle sgs of vmalloced addresses, such as the nx crypto driver:
> 
>         if (is_vmalloc_addr(start_addr))
>                 sg_addr = page_to_phys(vmalloc_to_page(start_addr))
>                           + offset_in_page(sg_addr);
>         else
>                 sg_addr = __pa(sg_addr);
> 
> and videobuf:
> 
>                 pg = vmalloc_to_page(virt);
>                 if (NULL == pg)
>                         goto err;
>                 BUG_ON(page_to_pfn(pg) >= (1 << (32 - PAGE_SHIFT)));
>                 sg_set_page(&sglist[i], pg, PAGE_SIZE, 0);
> 
> Yes, there's the potential that we have to produce two SG entries for a
> virtually contiguous region if it crosses a page boundary, and our APIs
> aren't set up right to make it happen.  But this is something we should
> consider fixing ... otherwise we'll end up with dozens of driver hacks.
> The videobuf implementation was already copy-and-pasted into the saa7146
> driver, for example.

What if the device requires physically contiguous area and the vmalloc 
area crosses a page? Will you use a bounce buffer? Where do you allocate 
the bounce buffer from? What if you run out of bounce buffers?

Mikulkas
