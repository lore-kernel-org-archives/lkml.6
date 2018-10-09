Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE709C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B49D1205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:30:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B49D1205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbeJIPqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 11:46:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:42906 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725892AbeJIPqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 11:46:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7A3D3B03E;
        Tue,  9 Oct 2018 08:30:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 73A4F1E3615; Tue,  9 Oct 2018 10:30:25 +0200 (CEST)
Date:   Tue, 9 Oct 2018 10:30:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     john.hubbard@gmail.com, Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jerome Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH v4 2/3] mm: introduce put_user_page*(), placeholder
 versions
Message-ID: <20181009083025.GE11150@quack2.suse.cz>
References: <20181008211623.30796-1-jhubbard@nvidia.com>
 <20181008211623.30796-3-jhubbard@nvidia.com>
 <20181008171442.d3b3a1ea07d56c26d813a11e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008171442.d3b3a1ea07d56c26d813a11e@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 08-10-18 17:14:42, Andrew Morton wrote:
> On Mon,  8 Oct 2018 14:16:22 -0700 john.hubbard@gmail.com wrote:
> > +		put_user_page(pages[index]);
> > +	}
> > +}
> > +
> > +static inline void put_user_pages(struct page **pages,
> > +				  unsigned long npages)
> > +{
> > +	unsigned long index;
> > +
> > +	for (index = 0; index < npages; index++)
> > +		put_user_page(pages[index]);
> > +}
> > +
> 
> Otherwise looks OK.  Ish.  But it would be nice if that comment were to
> explain *why* get_user_pages() pages must be released with
> put_user_page().

The reason is that eventually we want to track reference from GUP
separately but you're right that it would be good to have a comment about
that somewhere.

> Also, maintainability.  What happens if someone now uses put_page() by
> mistake?  Kernel fails in some mysterious fashion?  How can we prevent
> this from occurring as code evolves?  Is there a cheap way of detecting
> this bug at runtime?

The same will happen as with any other reference counting bug - the special
user reference will leak. It will be pretty hard to debug I agree. I was
thinking about whether we could provide some type safety against such bugs
such as get_user_pages() not returning struct page pointers but rather some
other special type but it would result in a big amount of additional churn
as we'd have to propagate this different type e.g. through the IO path so
that IO completion routines could properly call put_user_pages(). So I'm
not sure it's really worth it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
