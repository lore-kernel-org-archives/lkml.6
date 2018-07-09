Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80083C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C4A20871
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cb+PKYnA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37C4A20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933692AbeGIRRB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:17:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52416 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933360AbeGIRQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:16:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Vtl3Y9imDZmQ7+6XdYG00VazHoTvtH5RQr2hn6d4imY=; b=Cb+PKYnAgMYYwZo8dDaMNOpqb
        tIm5lwTQEYAu/nz7O/FFVIDN08vHZmLfzV5/Qm4OmN7p/itbkWC7Ytfd3MyBGxprk0twIgzjHbDB0
        jtSiqhnJeIgW6WYnJ29EQS4WJe5RlNIQSDNdX41hyQqFSsmqs1titXJm4giB60bKiyT/mTPITgURB
        o+bsIGefgYP+fIjrq+vE6CuWmnpxsR3hTWMoxjWJA4mXVBE1H/9iAQOSyxgtBTQgmpOPeHzCNWTQI
        BA583gSswYh5y1+QEmLNiJWErMYGp4WE5J4H4A1PtZhXCqmAzoWiM5397SuOpuDj/kQbkL00mv3Xu
        BaabcpjxQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcZmP-0000aa-2m; Mon, 09 Jul 2018 17:16:53 +0000
Date:   Mon, 9 Jul 2018 10:16:51 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Nicholas Piggin <npiggin@gmail.com>, john.hubbard@gmail.com,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 0/2] mm/fs: put_user_page() proposal
Message-ID: <20180709171651.GE2662@bombadil.infradead.org>
References: <20180709080554.21931-1-jhubbard@nvidia.com>
 <20180709184937.7a70c3aa@roar.ozlabs.ibm.com>
 <20180709160806.xjt2l2pbmyiutbyi@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709160806.xjt2l2pbmyiutbyi@quack2.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 06:08:06PM +0200, Jan Kara wrote:
> On Mon 09-07-18 18:49:37, Nicholas Piggin wrote:
> > The problem with blocking in clear_page_dirty_for_io is that the fs is
> > holding the page lock (or locks) and possibly others too. If you
> > expect to have a bunch of long term references hanging around on the
> > page, then there will be hangs and deadlocks everywhere. And if you do
> > not have such log term references, then page lock (or some similar lock
> > bit) for the duration of the DMA should be about enough?
> 
> There are two separate questions:
> 
> 1) How to identify pages pinned for DMA? We have no bit in struct page to
> use and we cannot reuse page lock as that immediately creates lock
> inversions e.g. in direct IO code (which could be fixed but then good luck
> with auditing all the other GUP users). Matthew had an idea and John
> implemented it based on removing page from LRU and using that space in
> struct page. So we at least have a way to identify pages that are pinned
> and can track their pin count.
> 
> 2) What to do when some page is pinned but we need to do e.g.
> clear_page_dirty_for_io(). After some more thinking I agree with you that
> just blocking waiting for page to unpin will create deadlocks like:

Why are we trying to writeback a page that is pinned?  It's presumed to
be continuously redirtied by its pinner.  We can't evict it.

> ext4_writepages()				ext4_direct_IO_write()
> 						  __blockdev_direct_IO()
> 						    iov_iter_get_pages()
> 						      - pins page
>   handle = ext4_journal_start_with_reserve(inode, ...)
>     - starts transaction
>   ...
>     lock_page(page)
>     mpage_submit_page()
>       clear_page_dirty_for_io(page) -> blocks on pin

I don't think it should block.  It should fail.

