Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B79C00449
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 667FE21473
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 667FE21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeJBHzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:55:40 -0400
Received: from ipmail02.adl2.internode.on.net ([150.101.137.139]:44486 "EHLO
        ipmail02.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726710AbeJBHzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:55:40 -0400
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail02.adl2.internode.on.net with ESMTP; 02 Oct 2018 10:44:47 +0930
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1g79Gx-0006rr-8X; Tue, 02 Oct 2018 11:14:47 +1000
Date:   Tue, 2 Oct 2018 11:14:47 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, john.hubbard@gmail.com,
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
Message-ID: <20181002011447.GT31060@dastard>
References: <20180928053949.5381-1-jhubbard@nvidia.com>
 <20180928152958.GA3321@redhat.com>
 <4c884529-e2ff-3808-9763-eb0e71f5a616@nvidia.com>
 <20180928214934.GA3265@redhat.com>
 <dfa6aaef-b97e-ebd4-6cc8-c907a7b3f9bb@nvidia.com>
 <20180929084608.GA3188@redhat.com>
 <20181001061127.GQ31060@dastard>
 <20181001124757.GA26218@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001124757.GA26218@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 05:47:57AM -0700, Christoph Hellwig wrote:
> On Mon, Oct 01, 2018 at 04:11:27PM +1000, Dave Chinner wrote:
> > This reminds me so much of Linux mmap() in the mid-2000s - mmap()
> > worked for ext3 without being aware of page faults,
> 
> And "worked" still is a bit of a stretch, as soon as you'd get
> ENOSPC it would still blow up badly.  Which probably makes it an
> even better analogy to the current case.
> 
> > RDMA does not call ->page_mkwrite on clean file backed pages before it
> > writes to them and calls set_page_dirty(), and hence RDMA to file
> > backed pages is completely unreliable. I'm not sure this can be
> > solved without having page fault capable RDMA hardware....
> 
> We can always software prefault at gup time.

I'm not sure that's sufficient - we've got a series of panics from
machines running ext4+RDMA where there are no bufferheads on dirty
pages at writeback time. This was also reproducable on versions of
XFS that used bufferheads.

We suspect that memory reclaim has tripped the bufferhead stripping
threshold (yeah, that old ext3 hack to avoid writeback deadlocks
under memory pressure), hence removed the bufferheads from clean
mapped pages while RDMA has them pinned. And then some time later
after set_page_dirty() was called on them the filesystem's page
writeback code crashes and burns....

i.e. just because the page was in a known state at when it was
pinned, it doesn't mean it will remain in that state until it is
unpinned....

> And also remember that
> while RDMA might be the case at least some people care about here it
> really isn't different from any of the other gup + I/O cases, including
> doing direct I/O to a mmap area.  The only difference in the various
> cases is how long the area should be pinned down - some users like RDMA
> want a long term mapping, while others like direct I/O just need a short
> transient one.

Yup, now that I'm aware of all those little intricacies with gup I
always try to consider what impact they have...

> > We could address these use-after-free situations via forcing RDMA to
> > use file layout leases and revoke the lease when we need to modify
> > the backing store on leased files. However, this doesn't solve the
> > need for filesystems to receive write fault notifications via
> > ->page_mkwrite.
> 
> Exactly.   We need three things here:
> 
>  - notification to the filesystem that a page is (possibly) beeing
>    written to
>  - a way to to block fs operations while the pages are pinned
>  - a way to distinguish between short and long term mappings,
>    and only allow long terms mappings if they can be broken
>    using something like leases
> 
> I'm also pretty sure we already explained this a long time ago when the
> issue came up last year, so I'm not sure why this is even still
> contentious.

I suspect that it's simply because these discussions have been
spread across different groups and not everyone is aware of what the
other groups are discussing...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
