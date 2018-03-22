Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbeCVSsJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 14:48:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54620 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751609AbeCVSsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 14:48:08 -0400
Date: Thu, 22 Mar 2018 11:48:05 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/8] mm: mmap: unmap large mapping by section
Message-ID: <20180322184805.GJ28468@bombadil.infradead.org>
References: <1521581486-99134-1-git-send-email-yang.shi@linux.alibaba.com>
 <1521581486-99134-2-git-send-email-yang.shi@linux.alibaba.com>
 <20180321130833.GM23100@dhcp22.suse.cz>
 <f88deb20-bcce-939f-53a6-1061c39a9f6c@linux.alibaba.com>
 <20180321172932.GE4780@bombadil.infradead.org>
 <af814bbe-b6b5-12f8-72e5-7935e767bd87@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af814bbe-b6b5-12f8-72e5-7935e767bd87@linux.alibaba.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 10:34:08AM -0700, Yang Shi wrote:
> On 3/21/18 10:29 AM, Matthew Wilcox wrote:
> > Take the mmap_sem for write
> > Find the VMA
> >    If the VMA is large(*)
> >      Mark the VMA as deleted
> >      Drop the mmap_sem
> >      zap all of the entries
> >      Take the mmap_sem
> >    Else
> >      zap all of the entries
> > Continue finding VMAs
> > Drop the mmap_sem
> > 
> > Now we need to change everywhere which looks up a VMA to see if it needs
> > to care the the VMA is deleted (page faults, eg will need to SIGBUS; mmap
> > does not care; munmap will need to wait for the existing munmap operation
> 
> The other question is why munmap need wait? If the other parallel munmap
> finds the vma has been marked as "deleted", it just need return 0 as it
> doesn't find vma.
> 
> Currently do_munmap() does the below logic:
>     vma = find_vma(mm, start);
>     if (!vma)
>         return 0;

At the point a munmap() returns, the area should be available for reuse.
If another thread is still unmapping, it won't actually be available yet.
We should wait for the other thread to finish before returning.

There may be some other corner cases; like what to do if there's a partial
unmap of a VMA, or a MAP_FIXED over part of an existing VMA.  It's going
to be safer to just wait for any conflicts to die down.  It's not like
real programs call munmap() on conflicting areas at the same time.
