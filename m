Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCE5C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8347420870
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8347420870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbeKERz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 12:55:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:47792 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726086AbeKERz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 12:55:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8153FACE7;
        Mon,  5 Nov 2018 08:37:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AF1DE1E07AB; Mon,  5 Nov 2018 09:37:19 +0100 (CET)
Date:   Mon, 5 Nov 2018 09:37:19 +0100
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        john.hubbard@gmail.com, Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Jerome Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH v4 2/3] mm: introduce put_user_page*(), placeholder
 versions
Message-ID: <20181105083719.GA6953@quack2.suse.cz>
References: <20181008211623.30796-1-jhubbard@nvidia.com>
 <20181008211623.30796-3-jhubbard@nvidia.com>
 <20181008171442.d3b3a1ea07d56c26d813a11e@linux-foundation.org>
 <5198a797-fa34-c859-ff9d-568834a85a83@nvidia.com>
 <20181010164541.ec4bf53f5a9e4ba6e5b52a21@linux-foundation.org>
 <20181011084929.GB8418@quack2.suse.cz>
 <20181011132013.GA5968@ziepe.ca>
 <97e89e08-5b94-240a-56e9-ece2b91f6dbc@nvidia.com>
 <20181022194329.GG30059@ziepe.ca>
 <532c7ae5-7277-74a7-93f2-afe8b7dc13fc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <532c7ae5-7277-74a7-93f2-afe8b7dc13fc@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 04-11-18 23:17:58, John Hubbard wrote:
> On 10/22/18 12:43 PM, Jason Gunthorpe wrote:
> > On Thu, Oct 11, 2018 at 06:23:24PM -0700, John Hubbard wrote:
> >> On 10/11/18 6:20 AM, Jason Gunthorpe wrote:
> >>> On Thu, Oct 11, 2018 at 10:49:29AM +0200, Jan Kara wrote:
> >>>
> >>>>> This is a real worry.  If someone uses a mistaken put_page() then how
> >>>>> will that bug manifest at runtime?  Under what set of circumstances
> >>>>> will the kernel trigger the bug?
> >>>>
> >>>> At runtime such bug will manifest as a page that can never be evicted from
> >>>> memory. We could warn in put_page() if page reference count drops below
> >>>> bare minimum for given user pin count which would be able to catch some
> >>>> issues but it won't be 100% reliable. So at this point I'm more leaning
> >>>> towards making get_user_pages() return a different type than just
> >>>> struct page * to make it much harder for refcount to go wrong...
> >>>
> >>> At least for the infiniband code being used as an example here we take
> >>> the struct page from get_user_pages, then stick it in a sgl, and at
> >>> put_page time we get the page back out of the sgl via sg_page()
> >>>
> >>> So type safety will not help this case... I wonder how many other
> >>> users are similar? I think this is a pretty reasonable flow for DMA
> >>> with user pages.
> >>>
> >>
> >> That is true. The infiniband code, fortunately, never mixes the two page
> >> types into the same pool (or sg list), so it's actually an easier example
> >> than some other subsystems. But, yes, type safety doesn't help there. I can 
> >> take a moment to look around at the other areas, to quantify how much a type
> >> safety change might help.
> > 
> > Are most (all?) of the places working with SGLs?
> 
> I finally put together a spreadsheet, in order to answer this sort of thing.
> Some notes:
> 
> a) There are around 100 call sites of either get_user_pages*(), or indirect
> calls via iov_iter_get_pages*().

Quite a bit...

> b) There are only a few SGL users. Most are ad-hoc, instead: some loop that
> either can be collapsed nicely into the new put_user_pages*() APIs, or...
> cannot.
> 
> c) The real problem is: around 20+ iov_iter_get_pages*() call sites. I need
> to change both the  iov_iter system a little bit, and also change the callers
> so that they don't pile all the gup-pinned pages into the same page** array
> that also contains other allocation types. This can be done, it just takes
> time, that's the good news.

Yes, but looking into iov_iter_get_pages() users, lot of them then end up
feeding the result either in SGL, SKB (which is basically the same thing,
just for networking), or BVEC (which is again a very similar thing, just for
generic block layer). I'm not saying that we must have _sgl() interface as
untangling all those users might be just too complex but there is certainly
some space for unification and common interfaces ;)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
