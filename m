Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DF9C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A33217D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfBHVUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 16:20:33 -0500
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:2430 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727083AbfBHVUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 16:20:32 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail07.adl2.internode.on.net with ESMTP; 09 Feb 2019 07:50:28 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gsDZS-0006P0-Be; Sat, 09 Feb 2019 08:20:26 +1100
Date:   Sat, 9 Feb 2019 08:20:26 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Christopher Lameter <cl@linux.com>,
        Doug Ledford <dledford@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
Message-ID: <20190208212026.GB20493@dastard>
References: <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
 <01000168c43d594c-7979fcf8-b9c1-4bda-b29a-500efe001d66-000000@email.amazonses.com>
 <20190206210356.GZ6173@dastard>
 <20190206220828.GJ12227@ziepe.ca>
 <0c868bc615a60c44d618fb0183fcbe0c418c7c83.camel@redhat.com>
 <CAPcyv4hqya1iKCfHJRXQJRD4qXZa3VjkoKGw6tEvtWNkKVbP+A@mail.gmail.com>
 <bfe0fdd5400d41d223d8d30142f56a9c8efc033d.camel@redhat.com>
 <01000168c8e2de6b-9ab820ed-38ad-469c-b210-60fcff8ea81c-000000@email.amazonses.com>
 <20190208044302.GA20493@dastard>
 <20190208111028.GD6353@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208111028.GD6353@quack2.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 12:10:28PM +0100, Jan Kara wrote:
> On Fri 08-02-19 15:43:02, Dave Chinner wrote:
> > On Thu, Feb 07, 2019 at 04:55:37PM +0000, Christopher Lameter wrote:
> > > One approach that may be a clean way to solve this:
> > > 3. Filesystems that allow bypass of the page cache (like XFS / DAX) will
> > >    provide the virtual mapping when the PIN is done and DO NO OPERATIONS
> > >    on the longterm pinned range until the long term pin is removed.
> > 
> > So, ummm, how do we do block allocation then, which is done on
> > demand during writes?
> > 
> > IOWs, this requires the application to set up the file in the
> > correct state for the filesystem to lock it down so somebody else
> > can write to it.  That means the file can't be sparse, it can't be
> > preallocated (i.e. can't contain unwritten extents), it must have zeroes
> > written to it's full size before being shared because otherwise it
> > exposes stale data to the remote client (secure sites are going to
> > love that!), they can't be extended, etc.
> > 
> > IOWs, once the file is prepped and leased out for RDMA, it becomes
> > an immutable for the purposes of local access.
> > 
> > Which, essentially we can already do. Prep the file, map it
> > read/write, mark it immutable, then pin it via the longterm gup
> > interface which can do the necessary checks.
> 
> Hum, and what will you do if the immutable file that is target for RDMA
> will be a source of reflink?

I think we'd have to disallow it. reflink does actually change the
source inode on XFS (adds an inode flag to say it has shared
extents)...

Similarly, we'd have to make sure the inode is pinned in memory
but the gup_longterm operation, not jus thave it's pages pinned...

> That seems to be currently allowed for
> immutable files but RDMA store would be effectively corrupting the data of
> the target inode. But we could treat it similarly as swapfiles - those also
> have to deal with writes to blocks beyond filesystem control. In fact the
> similarity seems to be quite large there. What do you think?

Yes, swapfiles are probably a better analogy as the mm subsystem
pins them, maps them checking the layout is appropriate (i.e. no
holes) and then writes straight through them without the filesystem
being aware of the IO....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
