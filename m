Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5590AC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1686C2081C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1686C2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbeLEAgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 19:36:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43412 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbeLEAgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 19:36:53 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E6CA5308403D;
        Wed,  5 Dec 2018 00:36:52 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 914896B8EA;
        Wed,  5 Dec 2018 00:36:50 +0000 (UTC)
Date:   Tue, 4 Dec 2018 19:36:48 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>,
        tom@talpey.com, Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>, mike.marciniszyn@intel.com,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
Message-ID: <20181205003648.GT2937@redhat.com>
References: <20181204001720.26138-1-jhubbard@nvidia.com>
 <20181204001720.26138-2-jhubbard@nvidia.com>
 <CAPcyv4h99JVHAS7Q7k3iPPUq+oc1NxHdyBHMjpgyesF1EjVfWA@mail.gmail.com>
 <a0adcf7c-5592-f003-abc5-a2645eb1d5df@nvidia.com>
 <CAPcyv4iNtamDAY9raab=iXhSZByecedBpnGybjLM+PuDMwq7SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPcyv4iNtamDAY9raab=iXhSZByecedBpnGybjLM+PuDMwq7SQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 05 Dec 2018 00:36:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 03:03:02PM -0800, Dan Williams wrote:
> On Tue, Dec 4, 2018 at 1:56 PM John Hubbard <jhubbard@nvidia.com> wrote:
> >
> > On 12/4/18 12:28 PM, Dan Williams wrote:
> > > On Mon, Dec 3, 2018 at 4:17 PM <john.hubbard@gmail.com> wrote:
> > >>
> > >> From: John Hubbard <jhubbard@nvidia.com>
> > >>
> > >> Introduces put_user_page(), which simply calls put_page().
> > >> This provides a way to update all get_user_pages*() callers,
> > >> so that they call put_user_page(), instead of put_page().
> > >>
> > >> Also introduces put_user_pages(), and a few dirty/locked variations,
> > >> as a replacement for release_pages(), and also as a replacement
> > >> for open-coded loops that release multiple pages.
> > >> These may be used for subsequent performance improvements,
> > >> via batching of pages to be released.
> > >>
> > >> This is the first step of fixing the problem described in [1]. The steps
> > >> are:
> > >>
> > >> 1) (This patch): provide put_user_page*() routines, intended to be used
> > >>    for releasing pages that were pinned via get_user_pages*().
> > >>
> > >> 2) Convert all of the call sites for get_user_pages*(), to
> > >>    invoke put_user_page*(), instead of put_page(). This involves dozens of
> > >>    call sites, and will take some time.
> > >>
> > >> 3) After (2) is complete, use get_user_pages*() and put_user_page*() to
> > >>    implement tracking of these pages. This tracking will be separate from
> > >>    the existing struct page refcounting.
> > >>
> > >> 4) Use the tracking and identification of these pages, to implement
> > >>    special handling (especially in writeback paths) when the pages are
> > >>    backed by a filesystem. Again, [1] provides details as to why that is
> > >>    desirable.
> > >
> > > I thought at Plumbers we talked about using a page bit to tag pages
> > > that have had their reference count elevated by get_user_pages()? That
> > > way there is no need to distinguish put_page() from put_user_page() it
> > > just happens internally to put_page(). At the conference Matthew was
> > > offering to free up a page bit for this purpose.
> > >
> >
> > ...but then, upon further discussion in that same session, we realized that
> > that doesn't help. You need a reference count. Otherwise a random put_page
> > could affect your dma-pinned pages, etc, etc.
> 
> Ok, sorry, I mis-remembered. So, you're effectively trying to capture
> the end of the page pin event separate from the final 'put' of the
> page? Makes sense.
> 
> > I was not able to actually find any place where a single additional page
> > bit would help our situation, which is why this still uses LRU fields for
> > both the two bits required (the RFC [1] still applies), and the dma_pinned_count.
> 
> Except the LRU fields are already in use for ZONE_DEVICE pages... how
> does this proposal interact with those?
> 
> > [1] https://lore.kernel.org/r/20181110085041.10071-7-jhubbard@nvidia.com
> >
> > >> [1] https://lwn.net/Articles/753027/ : "The Trouble with get_user_pages()"
> > >>
> > >> Reviewed-by: Jan Kara <jack@suse.cz>
> > >
> > > Wish, you could have been there Jan. I'm missing why it's safe to
> > > assume that a single put_user_page() is paired with a get_user_page()?
> > >
> >
> > A put_user_page() per page, or a put_user_pages() for an array of pages. See
> > patch 0002 for several examples.
> 
> Yes, however I was more concerned about validation and trying to
> locate missed places where put_page() is used instead of
> put_user_page().
> 
> It would be interesting to see if we could have a debug mode where
> get_user_pages() returned dynamically allocated pages from a known
> address range and catch drivers that operate on a user-pinned page
> without using the proper helper to 'put' it. I think we might also
> need a ref_user_page() for drivers that may do their own get_page()
> and expect the dma_pinned_count to also increase.

Total crazy idea for this, but this is the right time of day
for this (for me at least it is beer time :)) What about mapping
all struct page in two different range of kernel virtual address
and when get user space is use it returns a pointer from the second
range of kernel virtual address to the struct page. Then in put_page
you know for sure if the code putting the page got it from GUP or
from somewhere else. page_to_pfn() would need some trickery to
handle that.

Dunno if we are running out of kernel virtual address (outside
32bits that i believe we are trying to shot down quietly behind
the bar).

Cheers,
Jérôme
