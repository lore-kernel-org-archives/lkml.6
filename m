Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB6CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666CC2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbeLNPn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:43:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:45132 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726298AbeLNPn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:43:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8C57FAF70;
        Fri, 14 Dec 2018 15:43:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 39BCB1E1430; Fri, 14 Dec 2018 16:43:21 +0100 (CET)
Date:   Fri, 14 Dec 2018 16:43:21 +0100
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jerome Glisse <jglisse@redhat.com>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, tom@talpey.com,
        Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Hocko <mhocko@kernel.org>, mike.marciniszyn@intel.com,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
Message-ID: <20181214154321.GF8896@quack2.suse.cz>
References: <20181205011519.GV10377@bombadil.infradead.org>
 <20181205014441.GA3045@redhat.com>
 <59ca5c4b-fd5b-1fc6-f891-c7986d91908e@nvidia.com>
 <7b4733be-13d3-c790-ff1b-ac51b505e9a6@nvidia.com>
 <20181207191620.GD3293@redhat.com>
 <3c4d46c0-aced-f96f-1bf3-725d02f11b60@nvidia.com>
 <20181208022445.GA7024@redhat.com>
 <20181210102846.GC29289@quack2.suse.cz>
 <20181212150319.GA3432@redhat.com>
 <20181212214641.GB29416@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212214641.GB29416@dastard>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Thu 13-12-18 08:46:41, Dave Chinner wrote:
> On Wed, Dec 12, 2018 at 10:03:20AM -0500, Jerome Glisse wrote:
> > On Mon, Dec 10, 2018 at 11:28:46AM +0100, Jan Kara wrote:
> > > On Fri 07-12-18 21:24:46, Jerome Glisse wrote:
> > > So this approach doesn't look like a win to me over using counter in struct
> > > page and I'd rather try looking into squeezing HMM public page usage of
> > > struct page so that we can fit that gup counter there as well. I know that
> > > it may be easier said than done...
> > 
> > So i want back to the drawing board and first i would like to ascertain
> > that we all agree on what the objectives are:
> > 
> >     [O1] Avoid write back from a page still being written by either a
> >          device or some direct I/O or any other existing user of GUP.
> >          This would avoid possible file system corruption.
> > 
> >     [O2] Avoid crash when set_page_dirty() is call on a page that is
> >          considered clean by core mm (buffer head have been remove and
> >          with some file system this turns into an ugly mess).
> 
> I think that's wrong. This isn't an "avoid a crash" case, this is a
> "prevent data and/or filesystem corruption" case. The primary goal
> we have here is removing our exposure to potential corruption, which
> has the secondary effect of avoiding the crash/panics that currently
> occur as a result of inconsistent page/filesystem state.
> 
> i.e. The goal is to have ->page_mkwrite() called on the clean page
> /before/ the file-backed page is marked dirty, and hence we don't
> expose ourselves to potential corruption or crashes that are a
> result of inappropriately calling set_page_dirty() on clean
> file-backed pages.

I agree that [O1] - i.e., avoid corrupting fs data - is more important and
[O2] is just one consequence of [O1].

> > For [O1] and [O2] i believe a solution with mapcount would work. So
> > no new struct, no fake vma, nothing like that. In GUP for file back
> > pages we increment both refcount and mapcount (we also need a special
> > put_user_page to decrement mapcount when GUP user are done with the
> > page).
> 
> I don't see how a mapcount can prevent anyone from calling
> set_page_dirty() inappropriately.
> 
> > Now for [O1] the write back have to call page_mkclean() to go through
> > all reverse mapping of the page and map read only. This means that
> > we can count the number of real mapping and see if the mapcount is
> > bigger than that. If mapcount is bigger than page is pin and we need
> > to use a bounce page to do the writeback.
> 
> Doesn't work. Generally filesystems have already mapped the page
> into bios before they call clear_page_dirty_for_io(), so it's too
> late for the filesystem to bounce the page at that point.

Yes, for filesystem it is too late. But the plan we figured back in October
was to do the bouncing in the block layer. I.e., mark the bio (or just the
particular page) as needing bouncing and then use the existing page
bouncing mechanism in the block layer to do the bouncing for us. Ext3 (when
it was still a separate fs driver) has been using a mechanism like this to
make DIF/DIX work with its metadata.

> > For [O2] i believe we can handle that case in the put_user_page()
> > function to properly dirty the page without causing filesystem
> > freak out.
> 
> I'm pretty sure you can't call ->page_mkwrite() from
> put_user_page(), so I don't think this is workable at all.

Yes, calling ->page_mkwrite() in put_user_page() is not only technically
complicated but also too late - DMA has already modified page contents.
What we planned to do (again discussed back in October) was to never allow
the pinned page to become clean. I.e., clear_page_dirty_for_io() would
leave pinned pages dirty. Also we would skip pinned pages for WB_SYNC_NONE
writeback as there's no point in that really. That way MM and filesystems
would be aware of the real page state - i.e., what's in memory is not in
sync (potentially) with what's on disk. I was thinking whether this
permanently-dirty state couldn't confuse filesystem in some way but I
didn't find anything serious - the worst I could think of are places that
do filemap_write_and_wait() and then invalidate page cache e.g. before hole
punching or extent shifting. But these should work fine as is (page cache
invalidation will just happily truncate dirty pages). DIO might get
confused by the inability to invalidate dirty pages but then user combining
RDMA with DIO on the same file at one moment gets what he deserves...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
