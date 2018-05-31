Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755376AbeEaOO5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 10:14:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51320 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755093AbeEaOO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 10:14:56 -0400
Date: Thu, 31 May 2018 07:14:52 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Christopher Lameter <cl@linux.com>
Cc: Jia-Ju Bai <baijiaju1990@gmail.com>, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Can kfree() sleep at runtime?
Message-ID: <20180531141452.GC30221@bombadil.infradead.org>
References: <30ecafd7-ed61-907b-f924-77fc37dcc753@gmail.com>
 <20180531140808.GA30221@bombadil.infradead.org>
 <01000163b68a8026-56fb6a35-040b-4af9-8b73-eb3b4a41c595-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01000163b68a8026-56fb6a35-040b-4af9-8b73-eb3b4a41c595-000000@email.amazonses.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 02:12:00PM +0000, Christopher Lameter wrote:
> On Thu, 31 May 2018, Matthew Wilcox wrote:
> 
> > On Thu, May 31, 2018 at 09:10:07PM +0800, Jia-Ju Bai wrote:
> > > I write a static analysis tool (DSAC), and it finds that kfree() can sleep.
> > >
> > > Here is the call path for kfree().
> > > Please look at it *from the bottom up*.
> > >
> > > [FUNC] alloc_pages(GFP_KERNEL)
> > > arch/x86/mm/pageattr.c, 756: alloc_pages in split_large_page
> > > arch/x86/mm/pageattr.c, 1283: split_large_page in __change_page_attr
> >
> > Here's your bug.  Coming from kfree(), we can't end up in the
> > split_large_page() path.  __change_page_attr may be called in several
> > different circumstances in which it would have to split a large page,
> > but the path from kfree() is not one of them.
> 
> Freeing a page in the page allocator also was traditionally not sleeping.
> That has changed?

No.  "Your bug" being "The bug in your static analysis tool".  It probably
isn't following the data flow correctly (or deeply enough).
