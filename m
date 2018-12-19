Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB58EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789BC20873
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbeLSWdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:33:18 -0500
Received: from ipmailnode02.adl6.internode.on.net ([150.101.137.148]:14128
        "EHLO ipmailnode02.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728355AbeLSWdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 17:33:17 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail02.adl6.internode.on.net with ESMTP; 20 Dec 2018 09:03:13 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gZkOu-0002Ha-CF; Thu, 20 Dec 2018 09:33:12 +1100
Date:   Thu, 20 Dec 2018 09:33:12 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Jerome Glisse <jglisse@redhat.com>,
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
        Michal Hocko <mhocko@kernel.org>, mike.marciniszyn@intel.com,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
Message-ID: <20181219223312.GP6311@dastard>
References: <20181210102846.GC29289@quack2.suse.cz>
 <20181212150319.GA3432@redhat.com>
 <20181212214641.GB29416@dastard>
 <20181214154321.GF8896@quack2.suse.cz>
 <20181216215819.GC10644@dastard>
 <20181218103306.GC18032@quack2.suse.cz>
 <20181218234254.GC31274@dastard>
 <20181219030329.GI21992@ziepe.ca>
 <20181219102825.GN6311@dastard>
 <20181219113540.GC18345@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219113540.GC18345@quack2.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 12:35:40PM +0100, Jan Kara wrote:
> On Wed 19-12-18 21:28:25, Dave Chinner wrote:
> > On Tue, Dec 18, 2018 at 08:03:29PM -0700, Jason Gunthorpe wrote:
> > > On Wed, Dec 19, 2018 at 10:42:54AM +1100, Dave Chinner wrote:
> > > 
> > > > Essentially, what we are talking about is how to handle broken
> > > > hardware. I say we should just brun it with napalm and thermite
> > > > (i.e. taint the kernel with "unsupportable hardware") and force
> > > > wait_for_stable_page() to trigger when there are GUP mappings if
> > > > the underlying storage doesn't already require it.
> > > 
> > > If you want to ban O_DIRECT/etc from writing to file backed pages,
> > > then just do it.
> > 
> > O_DIRECT IO *isn't the problem*.
> 
> That is not true. O_DIRECT IO is a problem. In some aspects it is easier
> than the problem with RDMA but currently O_DIRECT IO can crash your machine
> or corrupt data the same way RDMA can.

It's not O_DIRECT - it's a ""transient page pin". Yes, there are
problems with that right now, but as we've discussed the issues can
be avoided by:

	a) stable pages always blocking in ->page_mkwrite;
	b) blocking in write_cache_pages() on an elevated map count
	when WB_SYNC_ALL is set; and
	c) blocking in truncate_pagecache() on an elevated map
	count.

That prevents:
	a) gup pinning a page that is currently under writeback and
	modifying it while IO is in flight;
	b) a dirty page being written back while it is pinned by
	GUP, thereby turning it clean before the gup reference calls
	set_page_dirty() on DMA completion; and
	c) truncate/hole punch for pulling the page out from under
	the gup operation that is ongoing.

This is an adequate solution for a short term transient pins. It
doesn't break fsync(), it doesn't change how truncate works and it
fixes the problem where a mapped file is the buffer for an O_DIRECT
IO rather than the open fd and that buffer file gets truncated.
IOWs, transient pins (and hence O_DIRECT) is not really the problem
here.

The problem with this is that blocking on elevated map count does
not work for long term pins (i.e. gup_longterm()) which are defined
as:

 * "longterm" == userspace controlled elevated page count lifetime.
 * Contrast this to iov_iter_get_pages() usages which are transient.

It's the "userspace controlled" part of the long term gup pin that
is the problem we need to solve. If we treat them the same as a
transient pin, then this leads to fsync() and truncate either
blocking for a long time waiting for userspace to drop it's gup
reference, or having to be failed with something like EBUSY or
EAGAIN.

This is the problem revokable file layout leases solve. The NFS
server is already using this for revoking delegations from remote
clients. Userspace holding long term GUP references is essentially
the same thing - it's a delegation of file ownership to userspace
that the filesystem must be able to revoke when it needs to run
internal and/or 3rd-party requested operations on that delegated
file.

If the hardware supports page faults, then we can further optimise
the long term pin case to relax stable page requirements and allow
page cleaning to occur while there are long term pins. In this case,
the hardware will write-fault the clean pages appropriately before
DMA is initiated, and hence avoid the need for data integrity
operations like fsync() to trigger lease revocation. However,
truncate/hole punch still requires lease revocation to work sanely,
especially when we consider DAX *must* ensure there are no remaining
references to the physical pmem page after the space has been freed.

i.e. conflating the transient and long term gup pins as the same
problem doesn't help anyone. If we fix the short term pin problems,
then the long term pin problem become tractable by adding a layer
over the top (i.e.  hardware page fault capability and/or file lease
requirements).  Existing apps and hardware will continue to work -
external operations on the pinned file will simply hang rather than
causing corruption or kernel crashes.  New (or updated) applications
will play nicely with lease revocation and at that point the "long
term pin" basically becomes a transient pin where the unpin latency
is determined by how quickly the app responds to the lease
revocation. And page fault capable hardware will reduce the
occurrence of lease revocations due to data writeback/integrity
operations and behave almost identically to cpu-based mmap accesses
to file backed pages.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
