Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751548AbeCVPlA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 11:41:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44656 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbeCVPk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 11:40:59 -0400
Date: Thu, 22 Mar 2018 08:40:55 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/8] mm: mmap: unmap large mapping by section
Message-ID: <20180322154055.GB28468@bombadil.infradead.org>
References: <1521581486-99134-1-git-send-email-yang.shi@linux.alibaba.com>
 <1521581486-99134-2-git-send-email-yang.shi@linux.alibaba.com>
 <20180321130833.GM23100@dhcp22.suse.cz>
 <f88deb20-bcce-939f-53a6-1061c39a9f6c@linux.alibaba.com>
 <20180321172932.GE4780@bombadil.infradead.org>
 <f057a634-7e0a-1b51-eede-dcb6f128b18e@linux.alibaba.com>
 <20180321224631.GB3969@bombadil.infradead.org>
 <18a727fd-f006-9fae-d9ca-74b9004f0a8b@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18a727fd-f006-9fae-d9ca-74b9004f0a8b@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 04:32:00PM +0100, Laurent Dufour wrote:
> On 21/03/2018 23:46, Matthew Wilcox wrote:
> > On Wed, Mar 21, 2018 at 02:45:44PM -0700, Yang Shi wrote:
> >> Marking vma as deleted sounds good. The problem for my current approach is
> >> the concurrent page fault may succeed if it access the not yet unmapped
> >> section. Marking deleted vma could tell page fault the vma is not valid
> >> anymore, then return SIGSEGV.
> >>
> >>> does not care; munmap will need to wait for the existing munmap operation
> >>
> >> Why mmap doesn't care? How about MAP_FIXED? It may fail unexpectedly, right?
> > 
> > The other thing about MAP_FIXED that we'll need to handle is unmapping
> > conflicts atomically.  Say a program has a 200GB mapping and then
> > mmap(MAP_FIXED) another 200GB region on top of it.  So I think page faults
> > are also going to have to wait for deleted vmas (then retry the fault)
> > rather than immediately raising SIGSEGV.
> 
> Regarding the page fault, why not relying on the PTE locking ?
> 
> When munmap() will unset the PTE it will have to held the PTE lock, so this
> will serialize the access.
> If the page fault occurs before the mmap(MAP_FIXED), the page mapped will be
> removed when mmap(MAP_FIXED) would do the cleanup. Fair enough.

The page fault handler will walk the VMA tree to find the correct
VMA and then find that the VMA is marked as deleted.  If it assumes
that the VMA has been deleted because of munmap(), then it can raise
SIGSEGV immediately.  But if the VMA is marked as deleted because of
mmap(MAP_FIXED), it must wait until the new VMA is in place.

I think I was wrong to describe VMAs as being *deleted*.  I think we
instead need the concept of a *locked* VMA that page faults will block on.
Conceptually, it's a per-VMA rwsem, but I'd use a completion instead of
an rwsem since the only reason to write-lock the VMA is because it is
being deleted.
