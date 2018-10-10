Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EEAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1AF206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1AF206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbeJJQUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:20:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:48394 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726515AbeJJQUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:20:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3324DB012;
        Wed, 10 Oct 2018 08:59:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 063231E3617; Wed, 10 Oct 2018 10:59:36 +0200 (CEST)
Date:   Wed, 10 Oct 2018 10:59:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, john.hubbard@gmail.com,
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
Message-ID: <20181010085936.GC11507@quack2.suse.cz>
References: <20181008211623.30796-1-jhubbard@nvidia.com>
 <20181008211623.30796-3-jhubbard@nvidia.com>
 <20181008171442.d3b3a1ea07d56c26d813a11e@linux-foundation.org>
 <5198a797-fa34-c859-ff9d-568834a85a83@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5198a797-fa34-c859-ff9d-568834a85a83@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 09-10-18 17:42:09, John Hubbard wrote:
> On 10/8/18 5:14 PM, Andrew Morton wrote:
> > Also, maintainability.  What happens if someone now uses put_page() by
> > mistake?  Kernel fails in some mysterious fashion?  How can we prevent
> > this from occurring as code evolves?  Is there a cheap way of detecting
> > this bug at runtime?
> > 
> 
> It might be possible to do a few run-time checks, such as "does page that came 
> back to put_user_page() have the correct flags?", but it's harder (without 
> having a dedicated page flag) to detect the other direction: "did someone page 
> in a get_user_pages page, to put_page?"
> 
> As Jan said in his reply, converting get_user_pages (and put_user_page) to 
> work with a new data type that wraps struct pages, would solve it, but that's
> an awfully large change. Still...given how much of a mess this can turn into 
> if it's wrong, I wonder if it's worth it--maybe? 

I'm certainly not opposed to looking into it. But after looking into this
for a while it is not clear to me how to convert e.g. fs/direct-io.c or
fs/iomap.c. They pass the reference from gup() via
bio->bi_io_vec[]->bv_page and then release it after IO completion.
Propagating the new type to ->bv_page is not good as lower layer do not
really care how the page is pinned in memory. But we do need to somehow
pass the information to the IO completion functions in a robust manner.

Hmm, what about the following:

1) Make gup() return new type - struct user_page *? In practice that would
be just a struct page pointer with 0 bit set so that people are forced to
use proper helpers and not just force types (and the setting of bit 0 and
masking back would be hidden behind CONFIG_DEBUG_USER_PAGE_REFERENCES for
performance reasons). Also the transition would have to be gradual so we'd
have to name the function differently and use it from converted code.

2) Provide helper bio_add_user_page() that will take user_page, convert it
to struct page, add it to the bio, and flag the bio as having pages with
user references. That code would also make sure the bio is consistent in
having only user-referenced pages in that case. IO completion (like
bio_check_pages_dirty(), bio_release_pages() etc.) will check the flag and
use approprite release function.

3) I have noticed fs/direct-io.c may submit zero page for IO when it needs
to clear stuff so we'll probably need a helper function to acquire 'user pin'
reference given a page pointer so that that code can be kept reasonably
simple and pass user_page references all around.

So this way we could maintain reasonable confidence that refcounts didn't
get mixed up. Thoughts?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
