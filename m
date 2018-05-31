Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755361AbeEaOIQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 10:08:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50442 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755093AbeEaOIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 10:08:13 -0400
Date: Thu, 31 May 2018 07:08:08 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Can kfree() sleep at runtime?
Message-ID: <20180531140808.GA30221@bombadil.infradead.org>
References: <30ecafd7-ed61-907b-f924-77fc37dcc753@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30ecafd7-ed61-907b-f924-77fc37dcc753@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 09:10:07PM +0800, Jia-Ju Bai wrote:
> I write a static analysis tool (DSAC), and it finds that kfree() can sleep.
> 
> Here is the call path for kfree().
> Please look at it *from the bottom up*.
> 
> [FUNC] alloc_pages(GFP_KERNEL)
> arch/x86/mm/pageattr.c, 756: alloc_pages in split_large_page
> arch/x86/mm/pageattr.c, 1283: split_large_page in __change_page_attr

Here's your bug.  Coming from kfree(), we can't end up in the
split_large_page() path.  __change_page_attr may be called in several
different circumstances in which it would have to split a large page,
but the path from kfree() is not one of them.

I think the path from kfree() will lead to the 'level == PG_LEVEL_4K'
path, but I'm not really familiar with this x86 code.

> arch/x86/mm/pageattr.c, 1391: __change_page_attr in
> __change_page_attr_set_clr
> arch/x86/mm/pageattr.c, 2014: __change_page_attr_set_clr in __set_pages_np
> arch/x86/mm/pageattr.c, 2034: __set_pages_np in __kernel_map_pages
> ./include/linux/mm.h, 2488: __kernel_map_pages in kernel_map_pages
> mm/page_alloc.c, 1074: kernel_map_pages in free_pages_prepare
> mm/page_alloc.c, 1264: free_pages_prepare in __free_pages_ok
> mm/page_alloc.c, 4312: __free_pages_ok in __free_pages
> mm/slub.c, 3914: __free_pages in kfree
> 
> I always have an impression that kfree() never sleeps, so I feel confused
> here.
> So could someone please help me to find the mistake?
> Thanks in advance :)
> 
> Best wishes,
> Jia-Ju Bai
