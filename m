Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EECC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63DD2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfBGRYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:24:13 -0500
Received: from mga01.intel.com ([192.55.52.88]:34792 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfBGRYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:24:11 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 09:24:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,344,1544515200"; 
   d="scan'208";a="114459707"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga006.jf.intel.com with ESMTP; 07 Feb 2019 09:24:09 -0800
Date:   Thu, 7 Feb 2019 09:23:53 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Chinner <david@fromorbit.com>,
        Christopher Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        lsf-pc@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
Message-ID: <20190207172352.GC29531@iweiny-DESK2.sc.intel.com>
References: <20190206173114.GB12227@ziepe.ca>
 <20190206175233.GN21860@bombadil.infradead.org>
 <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
 <01000168c43d594c-7979fcf8-b9c1-4bda-b29a-500efe001d66-000000@email.amazonses.com>
 <20190206210356.GZ6173@dastard>
 <20190206220828.GJ12227@ziepe.ca>
 <0c868bc615a60c44d618fb0183fcbe0c418c7c83.camel@redhat.com>
 <CAPcyv4hqya1iKCfHJRXQJRD4qXZa3VjkoKGw6tEvtWNkKVbP+A@mail.gmail.com>
 <658363f418a6585a1ffc0038b86c8e95487e8130.camel@redhat.com>
 <CAPcyv4hPmwXv6xGpyWGs-zx3xswAnzF0HGX6Kx3t=LSysDRZog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hPmwXv6xGpyWGs-zx3xswAnzF0HGX6Kx3t=LSysDRZog@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 07:13:16PM -0800, Dan Williams wrote:
> On Wed, Feb 6, 2019 at 6:42 PM Doug Ledford <dledford@redhat.com> wrote:
> >
> > On Wed, 2019-02-06 at 14:44 -0800, Dan Williams wrote:
> > > On Wed, Feb 6, 2019 at 2:25 PM Doug Ledford <dledford@redhat.com> wrote:
> > > > Can someone give me a real world scenario that someone is *actually*
> > > > asking for with this?
> > >
> > > I'll point to this example. At the 6:35 mark Kodi talks about the
> > > Oracle use case for DAX + RDMA.
> > >
> > > https://youtu.be/ywKPPIE8JfQ?t=395
> >
> > I watched this, and I see that Oracle is all sorts of excited that their
> > storage machines can scale out, and they can access the storage and it
> > has basically no CPU load on the storage server while performing
> > millions of queries.  What I didn't hear in there is why DAX has to be
> > in the picture, or why Oracle couldn't do the same thing with a simple
> > memory region exported directly to the RDMA subsystem, or why reflink or
> > any of the other features you talk about are needed.  So, while these
> > things may legitimately be needed, this video did not tell me about
> > how/why they are needed, just that RDMA is really, *really* cool for
> > their use case and gets them 0% CPU utilization on their storage
> > servers.  I didn't watch the whole thing though.  Do they get into that
> > later on?  Do they get to that level of technical discussion, or is this
> > all higher level?
> 
> They don't. The point of sharing that video was illustrating that RDMA
> to persistent memory use case. That 0% cpu utilization is because the
> RDMA target is not page-cache / anonymous on the storage box it's
> directly to a file offset in DAX / persistent memory. A solution to
> truncate lets that use case use more than just Device-DAX or ODP
> capable adapters. That said, I need to let Ira jump in here because
> saying layout leases solves the problem is not true, it's just the
> start of potentially solving the problem. It's not clear to me what
> the long tail of work looks like once the filesystem raises a
> notification to the RDMA target process.

This is exactly the problem which has been touched on by others throughout this
thread.

1) To fully support leases on all hardware we will have to allow for RMDA
   processes to be killed when they don't respond to the lease

   a) If the process has done something bad (like truncate or hole punch) then
      the idea that "they get what they deserve" may be ok.

   b) However, if this is because of some underlying file system maintenance
      this is as Jason says unreasonable.  It would be much better to tell the
      application "you can't do this"

2) To fully respond to a lease revocation involves a number of kernel changes
   in the RDMA stack but more importantly modifying every user space RDMA
   application to respond to a message from a channel they may not even be
   listening to.

I think this is where Jason is getting very concerned.  When you
combine 1b and 2 you end up with a "non production" worthy solution.

NOTE: This is somewhat true of ODP hardware as well since applications register
each individual RDMA memory region as either ODP or not.  So out of the box not
all application would work automatically.

Ira

