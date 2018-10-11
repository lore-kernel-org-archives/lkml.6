Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB39C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAAA12087A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAAA12087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbeJKQPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 12:15:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:35198 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726223AbeJKQPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 12:15:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0231EB14B;
        Thu, 11 Oct 2018 08:49:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 68E741E3616; Thu, 11 Oct 2018 10:49:29 +0200 (CEST)
Date:   Thu, 11 Oct 2018 10:49:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     John Hubbard <jhubbard@nvidia.com>, john.hubbard@gmail.com,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Jerome Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH v4 2/3] mm: introduce put_user_page*(), placeholder
 versions
Message-ID: <20181011084929.GB8418@quack2.suse.cz>
References: <20181008211623.30796-1-jhubbard@nvidia.com>
 <20181008211623.30796-3-jhubbard@nvidia.com>
 <20181008171442.d3b3a1ea07d56c26d813a11e@linux-foundation.org>
 <5198a797-fa34-c859-ff9d-568834a85a83@nvidia.com>
 <20181010164541.ec4bf53f5a9e4ba6e5b52a21@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010164541.ec4bf53f5a9e4ba6e5b52a21@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 10-10-18 16:45:41, Andrew Morton wrote:
> On Tue, 9 Oct 2018 17:42:09 -0700 John Hubbard <jhubbard@nvidia.com> wrote:
> 
> > > Also, maintainability.  What happens if someone now uses put_page() by
> > > mistake?  Kernel fails in some mysterious fashion?  How can we prevent
> > > this from occurring as code evolves?  Is there a cheap way of detecting
> > > this bug at runtime?
> > > 
> > 
> > It might be possible to do a few run-time checks, such as "does page that came 
> > back to put_user_page() have the correct flags?", but it's harder (without 
> > having a dedicated page flag) to detect the other direction: "did someone page 
> > in a get_user_pages page, to put_page?"
> > 
> > As Jan said in his reply, converting get_user_pages (and put_user_page) to 
> > work with a new data type that wraps struct pages, would solve it, but that's
> > an awfully large change. Still...given how much of a mess this can turn into 
> > if it's wrong, I wonder if it's worth it--maybe? 
> 
> This is a real worry.  If someone uses a mistaken put_page() then how
> will that bug manifest at runtime?  Under what set of circumstances
> will the kernel trigger the bug?

At runtime such bug will manifest as a page that can never be evicted from
memory. We could warn in put_page() if page reference count drops below
bare minimum for given user pin count which would be able to catch some
issues but it won't be 100% reliable. So at this point I'm more leaning
towards making get_user_pages() return a different type than just
struct page * to make it much harder for refcount to go wrong...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
