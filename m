Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B495C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CD520851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67CD520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbeLLVqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 16:46:48 -0500
Received: from ipmail01.adl2.internode.on.net ([150.101.137.133]:60505 "EHLO
        ipmail01.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726263AbeLLVqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 16:46:48 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail01.adl2.internode.on.net with ESMTP; 13 Dec 2018 08:16:42 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gXCL3-0000lY-LH; Thu, 13 Dec 2018 08:46:41 +1100
Date:   Thu, 13 Dec 2018 08:46:41 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
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
Message-ID: <20181212214641.GB29416@dastard>
References: <3c91d335-921c-4704-d159-2975ff3a5f20@nvidia.com>
 <20181205011519.GV10377@bombadil.infradead.org>
 <20181205014441.GA3045@redhat.com>
 <59ca5c4b-fd5b-1fc6-f891-c7986d91908e@nvidia.com>
 <7b4733be-13d3-c790-ff1b-ac51b505e9a6@nvidia.com>
 <20181207191620.GD3293@redhat.com>
 <3c4d46c0-aced-f96f-1bf3-725d02f11b60@nvidia.com>
 <20181208022445.GA7024@redhat.com>
 <20181210102846.GC29289@quack2.suse.cz>
 <20181212150319.GA3432@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212150319.GA3432@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 10:03:20AM -0500, Jerome Glisse wrote:
> On Mon, Dec 10, 2018 at 11:28:46AM +0100, Jan Kara wrote:
> > On Fri 07-12-18 21:24:46, Jerome Glisse wrote:
> > So this approach doesn't look like a win to me over using counter in struct
> > page and I'd rather try looking into squeezing HMM public page usage of
> > struct page so that we can fit that gup counter there as well. I know that
> > it may be easier said than done...
> 
> So i want back to the drawing board and first i would like to ascertain
> that we all agree on what the objectives are:
> 
>     [O1] Avoid write back from a page still being written by either a
>          device or some direct I/O or any other existing user of GUP.
>          This would avoid possible file system corruption.
> 
>     [O2] Avoid crash when set_page_dirty() is call on a page that is
>          considered clean by core mm (buffer head have been remove and
>          with some file system this turns into an ugly mess).

I think that's wrong. This isn't an "avoid a crash" case, this is a
"prevent data and/or filesystem corruption" case. The primary goal
we have here is removing our exposure to potential corruption, which
has the secondary effect of avoiding the crash/panics that currently
occur as a result of inconsistent page/filesystem state.

i.e. The goal is to have ->page_mkwrite() called on the clean page
/before/ the file-backed page is marked dirty, and hence we don't
expose ourselves to potential corruption or crashes that are a
result of inappropriately calling set_page_dirty() on clean
file-backed pages.

> For [O1] and [O2] i believe a solution with mapcount would work. So
> no new struct, no fake vma, nothing like that. In GUP for file back
> pages we increment both refcount and mapcount (we also need a special
> put_user_page to decrement mapcount when GUP user are done with the
> page).

I don't see how a mapcount can prevent anyone from calling
set_page_dirty() inappropriately.

> Now for [O1] the write back have to call page_mkclean() to go through
> all reverse mapping of the page and map read only. This means that
> we can count the number of real mapping and see if the mapcount is
> bigger than that. If mapcount is bigger than page is pin and we need
> to use a bounce page to do the writeback.

Doesn't work. Generally filesystems have already mapped the page
into bios before they call clear_page_dirty_for_io(), so it's too
late for the filesystem to bounce the page at that point.

> For [O2] i believe we can handle that case in the put_user_page()
> function to properly dirty the page without causing filesystem
> freak out.

I'm pretty sure you can't call ->page_mkwrite() from
put_user_page(), so I don't think this is workable at all.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
