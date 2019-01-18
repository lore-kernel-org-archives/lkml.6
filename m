Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A1CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 00:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9ED92086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 00:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfARAQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 19:16:15 -0500
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:41927 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725938AbfARAQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 19:16:14 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail06.adl2.internode.on.net with ESMTP; 18 Jan 2019 10:46:10 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gkHpQ-0004hn-T9; Fri, 18 Jan 2019 11:16:09 +1100
Date:   Fri, 18 Jan 2019 11:16:08 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
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
Message-ID: <20190118001608.GX4205@dastard>
References: <294bdcfa-5bf9-9c09-9d43-875e8375e264@nvidia.com>
 <20190112024625.GB5059@redhat.com>
 <b6f4ed36-fc8d-1f9b-8c74-b12f61d496ae@nvidia.com>
 <20190114145447.GJ13316@quack2.suse.cz>
 <20190114172124.GA3702@redhat.com>
 <20190115080759.GC29524@quack2.suse.cz>
 <20190116113819.GD26069@quack2.suse.cz>
 <20190116130813.GA3617@redhat.com>
 <5c6dc6ed-4c8d-bce7-df02-ee8b7785b265@nvidia.com>
 <20190117152108.GB3550@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117152108.GB3550@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 10:21:08AM -0500, Jerome Glisse wrote:
> On Wed, Jan 16, 2019 at 09:42:25PM -0800, John Hubbard wrote:
> > On 1/16/19 5:08 AM, Jerome Glisse wrote:
> > > On Wed, Jan 16, 2019 at 12:38:19PM +0100, Jan Kara wrote:
> > >> That actually touches on another question I wanted to get opinions on. GUP
> > >> can be for read and GUP can be for write (that is one of GUP flags).
> > >> Filesystems with page cache generally have issues only with GUP for write
> > >> as it can currently corrupt data, unexpectedly dirty page etc.. DAX & memory
> > >> hotplug have issues with both (DAX cannot truncate page pinned in any way,
> > >> memory hotplug will just loop in kernel until the page gets unpinned). So
> > >> we probably want to track both types of GUP pins and page-cache based
> > >> filesystems will take the hit even if they don't have to for read-pins?
> > > 
> > > Yes the distinction between read and write would be nice. With the map
> > > count solution you can only increment the mapcount for GUP(write=true).
> > > With pin bias the issue is that a big number of read pin can trigger
> > > false positive ie you would do:
> > >     GUP(vaddr, write)
> > >         ...
> > >         if (write)
> > >             atomic_add(page->refcount, PAGE_PIN_BIAS)
> > >         else
> > >             atomic_inc(page->refcount)
> > > 
> > >     PUP(page, write)
> > >         if (write)
> > >             atomic_add(page->refcount, -PAGE_PIN_BIAS)
> > >         else
> > >             atomic_dec(page->refcount)
> > > 
> > > I am guessing false positive because of too many read GUP is ok as
> > > it should be unlikely and when it happens then we take the hit.
> > > 
> > 
> > I'm also intrigued by the point that read-only GUP is harmless, and we 
> > could just focus on the writeable case.
> 
> For filesystem anybody that just look at the page is fine, as it would
> not change its content thus the page would stay stable.

Other processes can access and dirty the page cache page while there
is a GUP reference.  It's unclear to me whether that changes what
GUP needs to do here, but we can't assume a page referenced for
read-only GUP will be clean and unchanging for the duration of the
GUP reference. It may even be dirty at the time of the read-only
GUP pin...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
