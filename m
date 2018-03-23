Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752278AbeCWQPS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 12:15:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41762 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752237AbeCWQPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 12:15:16 -0400
Date: Fri, 23 Mar 2018 09:15:12 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: linux-mm@kvack.org, Matthew Wilcox <mawilcox@microsoft.com>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/4] mm: Add free()
Message-ID: <20180323161512.GD5624@bombadil.infradead.org>
References: <20180322195819.24271-1-willy@infradead.org>
 <20180322195819.24271-4-willy@infradead.org>
 <6fd1bba1-e60c-e5b3-58be-52e991cda74f@virtuozzo.com>
 <20180323151421.GC5624@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323151421.GC5624@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 08:14:21AM -0700, Matthew Wilcox wrote:
> > One more thing, there is
> > some kasan checks on the main way of kfree(), and there is no guarantee they
> > reflected in kmem_cache_free() identical.
> 
> Which function are you talking about here?
> 
> slub calls slab_free() for both kfree() and kmem_cache_free().
> slab calls __cache_free() for both kfree() and kmem_cache_free().
> Each of them do their kasan handling in the called function.

... except for where slub can free large objects without calling slab_free():

        if (unlikely(!PageSlab(page))) {
                BUG_ON(!PageCompound(page));
                kfree_hook(object);
                __free_pages(page, compound_order(page));
                return;
        }
        slab_free(page->slab_cache, page, object, NULL, 1, _RET_IP_);

If you call kmalloc(16384, GFP_KERNEL), slub will hand back an order-2
page without setting PageSlab on it.  So if that gets passed to free(),
it'll call __put_page() which calls free_compound_page() which calls
__free_pages_ok().  Looks like we want another compound_dtor to be sure
we call the kfree hook.
