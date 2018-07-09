Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879ECC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38618208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ysb4dviD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38618208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933009AbeGIT5G (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 15:57:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41061 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932764AbeGIT5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 15:57:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id j5-v6so5681687wrr.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 12:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Eokygey1pVhQjWXKAwh1ee2+cQo+fN3Vb38kP7diwoE=;
        b=Ysb4dviDQ1OHdA9CUBRkpTBgRErDuxbOC+UBCSs31ZvEUgcBHttJnB1Fa2utuSqbrL
         QpnswF+E595ByHJBEf4glB5Q+qFtvknu8sCEXS9qFgpb+TvV4BCdQ6EaP8cLZft0zZcU
         oxqZxMtdY+x639V1ihv3+1VboJX8Y2p1sHlaOdKXL3fgfOq4p7A+BT8OQGe8hOIj0Voc
         WGwxJJQCAsbdguedFejOV9bhqWGGZptDm5NgEr6gA2DKA/g7OE1GHAGRjkPAKASs0VMI
         FJYZ0qb6WWAT+bLTMlQjHd8BvPh/YH8fwdT5wPmlYs0k6Ipv79ZZ9NEE8fbTmkwKl+7W
         DuMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Eokygey1pVhQjWXKAwh1ee2+cQo+fN3Vb38kP7diwoE=;
        b=tsFJI/qEV4iXNjPMHt3zHfK7C7dRguD81nyJee+yvc6J72iWpvoLwrOrGWMdCmEwD3
         KuIlQ8BlYKLerTztlizv171G2QZZvxe+Qw9/Jt2GBUyPuJEzXr1rm6xjt7IrOV14lmHm
         WLjRuuMgK71SU0bpmdVfAqvilePcbutMWWDgqW+VMOCbTDCWUE/+v+LeEu0td2bqC9sp
         8Uk7RQPSL2dpbXV4CiXHz64g25oL2+lbwKd25nwVrNb+GJx3joD2lanmr3mlZrwNQ/wX
         4m3Y5CsnOc2BgtJwP66S1/7T6A+KnWpifkT+OH7ncA5LkLldy0qZsteIpc2L26TKvcO/
         PvAQ==
X-Gm-Message-State: APt69E0eMkT2JlwfDZHK+tsiZDxqocJcUk1NCnxv+CT8zQVWg8cKaXKY
        l/4HjMwR5EroZHdJOtmmev+QPg==
X-Google-Smtp-Source: AAOMgpc60/gS/aS7fhX5ntzXB+LHM9YQKbdHxTi8Laaj0TDOvScccH2D8n/2DxYy/KNd6kCj9s6C+Q==
X-Received: by 2002:a5d:46c6:: with SMTP id g6-v6mr14624626wrs.76.1531166223282;
        Mon, 09 Jul 2018 12:57:03 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id o4-v6sm19383042wmo.20.2018.07.09.12.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 12:57:02 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fccHJ-0001mr-Q3; Mon, 09 Jul 2018 13:56:57 -0600
Date:   Mon, 9 Jul 2018 13:56:57 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>, john.hubbard@gmail.com,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 0/2] mm/fs: put_user_page() proposal
Message-ID: <20180709195657.GA29026@ziepe.ca>
References: <20180709080554.21931-1-jhubbard@nvidia.com>
 <20180709184937.7a70c3aa@roar.ozlabs.ibm.com>
 <20180709160806.xjt2l2pbmyiutbyi@quack2.suse.cz>
 <20180709171651.GE2662@bombadil.infradead.org>
 <20180709194740.rymbt2fzohbdmpye@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709194740.rymbt2fzohbdmpye@quack2.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 09:47:40PM +0200, Jan Kara wrote:
> On Mon 09-07-18 10:16:51, Matthew Wilcox wrote:
> > On Mon, Jul 09, 2018 at 06:08:06PM +0200, Jan Kara wrote:
> > > On Mon 09-07-18 18:49:37, Nicholas Piggin wrote:
> > > > The problem with blocking in clear_page_dirty_for_io is that the fs is
> > > > holding the page lock (or locks) and possibly others too. If you
> > > > expect to have a bunch of long term references hanging around on the
> > > > page, then there will be hangs and deadlocks everywhere. And if you do
> > > > not have such log term references, then page lock (or some similar lock
> > > > bit) for the duration of the DMA should be about enough?
> > > 
> > > There are two separate questions:
> > > 
> > > 1) How to identify pages pinned for DMA? We have no bit in struct page to
> > > use and we cannot reuse page lock as that immediately creates lock
> > > inversions e.g. in direct IO code (which could be fixed but then good luck
> > > with auditing all the other GUP users). Matthew had an idea and John
> > > implemented it based on removing page from LRU and using that space in
> > > struct page. So we at least have a way to identify pages that are pinned
> > > and can track their pin count.
> > > 
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

I think as a userspace I would expect the 'current content' to be
flushed without waiting..

If you block fsync() then anyone using a RDMA MR with it will just
dead lock. What happens if two processes open the same file and
one makes a MR and the other calls fsync()? Sounds bad.

Jason
