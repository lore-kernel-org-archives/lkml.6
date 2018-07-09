Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22D1C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B8A208DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rtZ/X/j4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B8A208DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933048AbeGIUA7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 16:00:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34824 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932764AbeGIUA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 16:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vMGm/wys4BkcUB4zf6/saQQAfQ+jl/qW3WA0bhwA02k=; b=rtZ/X/j4j0f8vXbKDNfrgn+rE
        Hh2NwiTFDkleHPKK9/XotoE7Y/iyBx4AGeojlbo9EZY39/ynKjXbzUeR5nRiQUcGFNRyAa9e6HXlW
        Fz9eiTc6czY+s5o+usp/1A5MeG/OfIce7nDxBlLpEjMUZtk1pt6EKe5fQyrkzhgZNFJ4RaXNyodvv
        2yXeHJ0PDjZKjr8mbKx5TSrHAH+69kmSR4JF8gN5RKCqZNgmrphwTSl/lgi8qcVLoWOD9y1gtY1Yd
        cCnkXXEU0HfYvgjdahd9F9vdikWvyr78D8cq2PYVjBZ9KtvTkM/RIik552jrIaGmjN2Myt29LiIlP
        2oB6L/nZA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fccL3-0006BS-T5; Mon, 09 Jul 2018 20:00:49 +0000
Date:   Mon, 9 Jul 2018 13:00:49 -0700
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
Message-ID: <20180709200049.GA5335@bombadil.infradead.org>
References: <20180709080554.21931-1-jhubbard@nvidia.com>
 <20180709184937.7a70c3aa@roar.ozlabs.ibm.com>
 <20180709160806.xjt2l2pbmyiutbyi@quack2.suse.cz>
 <20180709171651.GE2662@bombadil.infradead.org>
 <20180709194740.rymbt2fzohbdmpye@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709194740.rymbt2fzohbdmpye@quack2.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 09:47:40PM +0200, Jan Kara wrote:
> On Mon 09-07-18 10:16:51, Matthew Wilcox wrote:
> > > 2) What to do when some page is pinned but we need to do e.g.
> > > clear_page_dirty_for_io(). After some more thinking I agree with you that
> > > just blocking waiting for page to unpin will create deadlocks like:
> > 
> > Why are we trying to writeback a page that is pinned?  It's presumed to
> > be continuously redirtied by its pinner.  We can't evict it.
> 
> So what should be a result of fsync(file), where some 'file' pages are
> pinned e.g. by running direct IO? If we just skip those pages, we'll lie to
> userspace that data was committed while it was not (and it's not only about
> data that has landed in those pages via DMA, you can have first 1k of a page
> modified by normal IO in parallel to DMA modifying second 1k chunk). If
> fsync(2) returns error, it would be really unexpected by userspace and most
> apps will just not handle that correctly. So what else can you do than
> block?

I was thinking about writeback, and neglected the fsync case.  For fsync,
we could copy the "current" contents of the page to a freshly-allocated
page and write _that_ to disc?  As long as we redirty the real page after
the pin is dropped, I think we're fine.
