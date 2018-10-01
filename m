Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5B6C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06AFA2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06AFA2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbeJAMrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 08:47:39 -0400
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:42913 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727693AbeJAMrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 08:47:39 -0400
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail06.adl2.internode.on.net with ESMTP; 01 Oct 2018 15:41:28 +0930
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1g6rQV-0005c7-EH; Mon, 01 Oct 2018 16:11:27 +1000
Date:   Mon, 1 Oct 2018 16:11:27 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, john.hubbard@gmail.com,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>
Subject: Re: [PATCH 0/4] get_user_pages*() and RDMA: first steps
Message-ID: <20181001061127.GQ31060@dastard>
References: <20180928053949.5381-1-jhubbard@nvidia.com>
 <20180928152958.GA3321@redhat.com>
 <4c884529-e2ff-3808-9763-eb0e71f5a616@nvidia.com>
 <20180928214934.GA3265@redhat.com>
 <dfa6aaef-b97e-ebd4-6cc8-c907a7b3f9bb@nvidia.com>
 <20180929084608.GA3188@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180929084608.GA3188@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 04:46:09AM -0400, Jerome Glisse wrote:
> On Fri, Sep 28, 2018 at 07:28:16PM -0700, John Hubbard wrote:
> > On 9/28/18 2:49 PM, Jerome Glisse wrote:
> > > On Fri, Sep 28, 2018 at 12:06:12PM -0700, John Hubbard wrote:
> > >> use a non-CPU device to read and write to "pinned" memory, especially when
> > >> that memory is backed by a file system.

"backed by a filesystem" is the biggest problem here.

> > >> I recall there were objections to just narrowly fixing the set_page_dirty()
> > >> bug, because the underlying problem is large and serious. So here we are.
> > > 
> > > Except that you can not solve that issue without proper hardware. GPU are
> > > fine. RDMA are broken except the mellanox5 hardware which can invalidate
> > > at anytime its page table thus allowing to write protect the page at any
> > > time.
> > 
> > Today, people are out there using RDMA without page-fault-capable hardware.
> > And they are hitting problems, as we've seen. From the discussions so far,
> > I don't think it's impossible to solve the problems, even for "lesser", 
> > non-fault-capable hardware.

This reminds me so much of Linux mmap() in the mid-2000s - mmap()
worked for ext3 without being aware of page faults, so most mm/
developers at the time were of the opinion that all the other
filesystems should work just fine without being aware of page
faults.

But some loud-mouthed idiot at SGI kept complaining that mmap()
could never be fixed for XFS without write fault notification
because of delayed allocation, unwritten extents and ENOSPC had to
be handled before mapped writes could be posted.  Eventually
Christoph Lameter got ->page_mkwrite into the page fault path and
the loud mouthed idiot finally got mmap() to work correctly on XFS:

commit 4f57dbc6b5bae5a3978d429f45ac597ca7a3b8c6
Author: David Chinner <dgc@sgi.com>
Date:   Thu Jul 19 16:28:17 2007 +1000

    [XFS] Implement ->page_mkwrite in XFS.
    
    Hook XFS up to ->page_mkwrite to ensure that we know about mmap pages
    being written to. This allows use to do correct delayed allocation and
    ENOSPC checking as well as remap unwritten extents so that they get
    converted correctly during writeback. This is done via the generic
    block_page_mkwrite code.
    
    SGI-PV: 940392
    SGI-Modid: xfs-linux-melb:xfs-kern:29149a
    
    Signed-off-by: David Chinner <dgc@sgi.com>
    Signed-off-by: Christoph Hellwig <hch@infradead.org>
    Signed-off-by: Tim Shimmin <tes@sgi.com>

Nowdays, ->page_mkwrite is fundamental filesystem functionality -
copy-on-write filesystems like btrfs simply don't work if they can't
trigger COW on mapped write accesses. These days all the main linux
filesystems depend on write fault notifications in some way or
another for correct operation.

The way RDMA uses GUP to take references to file backed pages to
'stop them going away' is reminiscent of mmap() back before
->page_mkwrite(). i.e. it assumes that an initial read of the page
will populate the page state correctly for all future operations,
including set_page_dirty() after write accesses.

This is not a valid assumption - filesystems can have different
private clean vs dirty page state, and may need to perform
operations to take a page from clean to dirty.  Hence calling
set_page_dirty() on a file backed mapped page without first having
called ->page_mkwrite() is a bug.

RDMA does not call ->page_mkwrite on clean file backed pages before it
writes to them and calls set_page_dirty(), and hence RDMA to file
backed pages is completely unreliable. I'm not sure this can be
solved without having page fault capable RDMA hardware....

> > > With the solution put forward here you can potentialy wait _forever_ for
> > > the driver that holds a pin to drop it. This was the point i was trying to
> > > get accross during LSF/MM. 

Right, but pinning via GUP is not an option for file backed pages
because the filesystem is completely unaware of these references.
i.e. waiting forever isn't an issue here because the filesystem
never waits on them. Instead, they are a filesystem corruption
vector because the filesystem can invalidate those mappings and free
the backing store while they are still in use by RDMA.

Hence for DAX filesystems, this leaves the RDMA app with direct
access to the physical storage even though the filesystem has freed
the space it is accessing. This is a use after free of the physical
storage that the filesystem cannot control, and why DAX+RDMA is
disabled right now.

We could address these use-after-free situations via forcing RDMA to
use file layout leases and revoke the lease when we need to modify
the backing store on leased files. However, this doesn't solve the
need for filesystems to receive write fault notifications via
->page_mkwrite.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
