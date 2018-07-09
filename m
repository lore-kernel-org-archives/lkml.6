Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22138C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1FC520779
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1FC520779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754590AbeGIQL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:11:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:51788 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754556AbeGIQL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:11:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A6093AC8A;
        Mon,  9 Jul 2018 16:11:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 32E431E0DD5; Mon,  9 Jul 2018 18:11:54 +0200 (CEST)
Date:   Mon, 9 Jul 2018 18:11:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     john.hubbard@gmail.com, Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page(), placeholder version
Message-ID: <20180709161154.46chzohwnzzbrtis@quack2.suse.cz>
References: <20180709080554.21931-1-jhubbard@nvidia.com>
 <20180709080554.21931-2-jhubbard@nvidia.com>
 <20180709155357.GA13496@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709155357.GA13496@ziepe.ca>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09-07-18 09:53:57, Jason Gunthorpe wrote:
> On Mon, Jul 09, 2018 at 01:05:53AM -0700, john.hubbard@gmail.com wrote:
> > From: John Hubbard <jhubbard@nvidia.com>
> > 
> > Introduces put_user_page(), which simply calls put_page().
> > This provides a safe way to update all get_user_pages*() callers,
> > so that they call put_user_page(), instead of put_page().
> > 
> > Also adds release_user_pages(), a drop-in replacement for
> > release_pages(). This is intended to be easily grep-able,
> > for later performance improvements, since release_user_pages
> > is not batched like release_pages is, and is significantly
> > slower.
> > 
> > Subsequent patches will add functionality to put_user_page().
> > 
> > Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> >  include/linux/mm.h | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index a0fbb9ffe380..db4a211aad79 100644
> > +++ b/include/linux/mm.h
> > @@ -923,6 +923,20 @@ static inline void put_page(struct page *page)
> >  		__put_page(page);
> >  }
> >  
> > +/* Placeholder version, until all get_user_pages*() callers are updated. */
> > +static inline void put_user_page(struct page *page)
> > +{
> > +	put_page(page);
> > +}
> > +
> > +/* A drop-in replacement for release_pages(): */
> > +static inline void release_user_pages(struct page **pages,
> > +				      unsigned long npages)
> > +{
> > +	while (npages)
> > +		put_user_page(pages[--npages]);
> > +}
> > +
> >  #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
> >  #define SECTION_IN_PAGE_FLAGS
> >  #endif
> 
> Just as question: Do you think it is worthwhile to have a
> release_user_page_dirtied() helper as well?
> 
> Ie to indicate that a pages that were grabbed under GUP FOLL_WRITE
> were actually written too?
> 
> Keeps more of these unimportant details out of the drivers..

Yeah, I think that would be nice as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
