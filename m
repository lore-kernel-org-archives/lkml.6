Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755739AbeDYQEZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 12:04:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48418 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754954AbeDYQER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 12:04:17 -0400
Date: Wed, 25 Apr 2018 09:04:13 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Soheil Hassas Yeganeh <soheil@google.com>
Subject: Re: [PATCH net-next 1/2] tcp: add TCP_ZEROCOPY_RECEIVE support for
 zerocopy receive
Message-ID: <20180425160413.GC8546@bombadil.infradead.org>
References: <20180425052722.73022-1-edumazet@google.com>
 <20180425052722.73022-2-edumazet@google.com>
 <20180425062859.GA23914@infradead.org>
 <5cd31eba-63b5-9160-0a2e-f441340df0d3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cd31eba-63b5-9160-0a2e-f441340df0d3@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 06:01:02AM -0700, Eric Dumazet wrote:
> On 04/24/2018 11:28 PM, Christoph Hellwig wrote:
> > On Tue, Apr 24, 2018 at 10:27:21PM -0700, Eric Dumazet wrote:
> >> When adding tcp mmap() implementation, I forgot that socket lock
> >> had to be taken before current->mm->mmap_sem. syzbot eventually caught
> >> the bug.
> >>
> >> Since we can not lock the socket in tcp mmap() handler we have to
> >> split the operation in two phases.
> >>
> >> 1) mmap() on a tcp socket simply reserves VMA space, and nothing else.
> >>   This operation does not involve any TCP locking.
> >>
> >> 2) setsockopt(fd, IPPROTO_TCP, TCP_ZEROCOPY_RECEIVE, ...) implements
> >>  the transfert of pages from skbs to one VMA.
> >>   This operation only uses down_read(&current->mm->mmap_sem) after
> >>   holding TCP lock, thus solving the lockdep issue.
> >>
> >> This new implementation was suggested by Andy Lutomirski with great details.
> > 
> > Thanks, this looks much more sensible to me.
> > 
> 
> Thanks Christoph
> 
> Note the high cost of zap_page_range(), needed to avoid -EBUSY being returned
> from vm_insert_page() the second time TCP_ZEROCOPY_RECEIVE is used on one VMA.
> 
> Ideally a vm_replace_page() would avoid this cost ?

If you don't zap the page range, any of the CPUs in the system where
any thread in this task have ever run may have a TLB entry pointing to
this page ... if the page is being recycled into the page allocator,
then that page might end up as a slab page or page table or page cache
while the other CPU still have access to it.

You could hang onto the page until you've built up a sufficiently large
batch, then bulk-invalidate all of the TLB entries, but we start to get
into weirdnesses on different CPU architectures.
