Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752146AbeCUR3i (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 13:29:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45800 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751641AbeCUR3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 13:29:34 -0400
Date: Wed, 21 Mar 2018 10:29:32 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/8] mm: mmap: unmap large mapping by section
Message-ID: <20180321172932.GE4780@bombadil.infradead.org>
References: <1521581486-99134-1-git-send-email-yang.shi@linux.alibaba.com>
 <1521581486-99134-2-git-send-email-yang.shi@linux.alibaba.com>
 <20180321130833.GM23100@dhcp22.suse.cz>
 <f88deb20-bcce-939f-53a6-1061c39a9f6c@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f88deb20-bcce-939f-53a6-1061c39a9f6c@linux.alibaba.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 09:31:22AM -0700, Yang Shi wrote:
> On 3/21/18 6:08 AM, Michal Hocko wrote:
> > Yes, this definitely sucks. One way to work that around is to split the
> > unmap to two phases. One to drop all the pages. That would only need
> > mmap_sem for read and then tear down the mapping with the mmap_sem for
> > write. This wouldn't help for parallel mmap_sem writers but those really
> > need a different approach (e.g. the range locking).
> 
> page fault might sneak in to map a page which has been unmapped before?
> 
> range locking should help a lot on manipulating small sections of a large
> mapping in parallel or multiple small mappings. It may not achieve too much
> for single large mapping.

I don't think we need range locking.  What if we do munmap this way:

Take the mmap_sem for write
Find the VMA
  If the VMA is large(*)
    Mark the VMA as deleted
    Drop the mmap_sem
    zap all of the entries
    Take the mmap_sem
  Else
    zap all of the entries
Continue finding VMAs
Drop the mmap_sem

Now we need to change everywhere which looks up a VMA to see if it needs
to care the the VMA is deleted (page faults, eg will need to SIGBUS; mmap
does not care; munmap will need to wait for the existing munmap operation
to complete), but it gives us the atomicity, at least on a per-VMA basis.

We could also do:

Take the mmap_sem for write
Mark all VMAs in the range as deleted & modify any partial VMAs
Drop mmap_sem
zap pages from deleted VMAs

That would give us the same atomicity that we have today.

Deleted VMAs would need a pointer to a completion, so operations that
need to wait can queue themselves up.  I'd recommend we use the low bit
of vm_file and treat it as a pointer to a struct completion if set.
