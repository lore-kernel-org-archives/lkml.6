Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0D1C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3E52083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F3E52083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965994AbeFSKlq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 06:41:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:54077 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965898AbeFSKlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 06:41:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3D5C8ABF4;
        Tue, 19 Jun 2018 10:41:43 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BD0721E0AAF; Tue, 19 Jun 2018 12:41:42 +0200 (CEST)
Date:   Tue, 19 Jun 2018 12:41:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <john.hubbard@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm: set PG_dma_pinned on get_user_pages*()
Message-ID: <20180619104142.lpilc6esz7w3a54i@quack2.suse.cz>
References: <CAPcyv4gayKk_zHDYAvntware12qMXWjnnL_FDJNUQsJS_zNfDw@mail.gmail.com>
 <311eba48-60f1-b6cc-d001-5cc3ed4d76a9@nvidia.com>
 <20180618081258.GB16991@lst.de>
 <d4817192-6db0-2f3f-7c67-6078b69686d3@nvidia.com>
 <CAPcyv4iacHYxGmyWokFrVsmxvLj7=phqp2i0tv8z6AT-mYuEEA@mail.gmail.com>
 <3898ef6b-2fa0-e852-a9ac-d904b47320d5@nvidia.com>
 <CAPcyv4iRBzmwWn_9zDvqdfVmTZL_Gn7uA_26A1T-kJib=84tvA@mail.gmail.com>
 <0e6053b3-b78c-c8be-4fab-e8555810c732@nvidia.com>
 <20180619082949.wzoe42wpxsahuitu@quack2.suse.cz>
 <20180619090255.GA25522@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619090255.GA25522@bombadil.infradead.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19-06-18 02:02:55, Matthew Wilcox wrote:
> On Tue, Jun 19, 2018 at 10:29:49AM +0200, Jan Kara wrote:
> > And for record, the problem with page cache pages is not only that
> > try_to_unmap() may unmap them. It is also that page_mkclean() can
> > write-protect them. And once PTEs are write-protected filesystems may end
> > up doing bad things if DMA then modifies the page contents (DIF/DIX
> > failures, data corruption, oopses). As such I don't think that solutions
> > based on page reference count have a big chance of dealing with the
> > problem.
> > 
> > And your page flag approach would also need to take page_mkclean() into
> > account. And there the issue is that until the flag is cleared (i.e., we
> > are sure there are no writers using references from GUP) you cannot
> > writeback the page safely which does not work well with your idea of
> > clearing the flag only once the page is evicted from page cache (hint, page
> > cache page cannot get evicted until it is written back).
> > 
> > So as sad as it is, I don't see an easy solution here.
> 
> Pages which are "got" don't need to be on the LRU list.  They'll be
> marked dirty when they're put, so we can use page->lru for fun things
> like a "got" refcount.  If we use bit 1 of page->lru for PageGot, we've
> got 30/62 bits in the first word and a full 64 bits in the second word.

Interesting idea! It would destroy the aging information for the page but
for pages accessed through GUP references that is very much vague concept
anyway. It might be a bit tricky as pulling a page out of LRU requires page
lock but I don't think that's a huge problem. And page cache pages not on
LRU exist even currently when they are under reclaim so hopefully there
won't be too many places in MM that would need fixing up for such pages.

I'm also still pondering the idea of inserting a "virtual" VMA into vma
interval tree in the inode - as the GUP references are IMHO closest to an
mlocked mapping - and that would achieve all the functionality we need as
well. I just didn't have time to experiment with it.

And then there's the aspect that both these approaches are a bit too
heavyweight for some get_user_pages_fast() users (e.g. direct IO) - Al Viro
had an idea to use page lock for that path but e.g. fs/direct-io.c would have
problems due to lock ordering constraints (filesystem ->get_block would
suddently get called with the page lock held). But we can probably leave
performance optimizations for phase two.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
