Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755330AbeEaOJd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 10:09:33 -0400
Received: from a9-99.smtp-out.amazonses.com ([54.240.9.99]:43768 "EHLO
        a9-99.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755093AbeEaOJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 10:09:32 -0400
Date: Thu, 31 May 2018 14:09:30 +0000
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Jia-Ju Bai <baijiaju1990@gmail.com>
cc: Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, Mel Gorman <mgorman@techsingularity.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Can kfree() sleep at runtime?
In-Reply-To: <30ecafd7-ed61-907b-f924-77fc37dcc753@gmail.com>
Message-ID: <01000163b6883743-79e003fa-71c2-4e9d-aa4a-35fcd08bb0d8-000000@email.amazonses.com>
References: <30ecafd7-ed61-907b-f924-77fc37dcc753@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.05.31-54.240.9.99
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 May 2018, Jia-Ju Bai wrote:

> I write a static analysis tool (DSAC), and it finds that kfree() can sleep.

That should not happen.

> Here is the call path for kfree().
> Please look at it *from the bottom up*.
>
> [FUNC] alloc_pages(GFP_KERNEL)
> arch/x86/mm/pageattr.c, 756: alloc_pages in split_large_page
> arch/x86/mm/pageattr.c, 1283: split_large_page in __change_page_attr
> arch/x86/mm/pageattr.c, 1391: __change_page_attr in __change_page_attr_set_clr
> arch/x86/mm/pageattr.c, 2014: __change_page_attr_set_clr in __set_pages_np
> arch/x86/mm/pageattr.c, 2034: __set_pages_np in __kernel_map_pages
> ./include/linux/mm.h, 2488: __kernel_map_pages in kernel_map_pages
> mm/page_alloc.c, 1074: kernel_map_pages in free_pages_prepare

mapping pages in the page allocator can cause allocations?? How did that
get in there?

> mm/page_alloc.c, 1264: free_pages_prepare in __free_pages_ok
> mm/page_alloc.c, 4312: __free_pages_ok in __free_pages
> mm/slub.c, 3914: __free_pages in kfree
>
> I always have an impression that kfree() never sleeps, so I feel confused
> here.

Correct.
