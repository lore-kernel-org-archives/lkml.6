Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F512C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C175920989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AhB3TneB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfA2EqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 23:46:10 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33531 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbfA2EqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 23:46:10 -0500
Received: by mail-pl1-f193.google.com with SMTP id z23so8814666plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 20:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eVdQI+bKFnHxHsyrWVjxAl5UcBq6aUXQPMqjgJnSXMU=;
        b=AhB3TneBFy5a0D3ECmn3nW0DFD00d64H7KXVKa2rW5c8hyVHul1zsyPBj53m+pAEn6
         a3VzM3KcH8t2Btm5Qz/EHVh0SVk4D/dz+4lBGsMUPMlsQY7JrJpIoUhRX3JvrLBTtrUF
         hu+ABju5baJzTV6C6u2plaAYJbka1voJWQK4d1xS/t+oGAV5rgNy1Wtb9AmimQz9rDcn
         NK9GIET8z8CNIMWhVivUtsc+vbDm3xHvUKYhE4pCMl18Fbj0RGgcb2b6wstWaTY5SErZ
         eiwjt4GAeq78cF/eTYNjn5r5B/vr9moiRWvzJT1X3iffiFSmAiFT86VT01lQvrj8sZQe
         VY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eVdQI+bKFnHxHsyrWVjxAl5UcBq6aUXQPMqjgJnSXMU=;
        b=XUkn1HM4jlTBxasH3bJgR9QXxnkso+9fAg2pInQuMrsVOHV0s6aRrxJkceTczyThFZ
         EtALK5aTckJ4JRvFN5MB45fDcTZflVs+ackS1/V3JKgG9gjrPVRTQntgLXzVAe91xqK9
         ETBPk1Ks4xt7PDUkXL5QB7lgAQDs6pOfcUU3sonz5g247lWz18mrwo7yJv2o8q0vOKIU
         rmCnfkOfSLuqVpquxCCcXRvUTdDJu++uFTcJ98dJKSQV0gogODvEqI7EhErv7/0DrOwQ
         8iigj0yzD4ve1oV2OKTtztdyAh+jVT59ycpZ462+aWRQyH+vQCOacZJTK1I1Wqu8qOYU
         81yg==
X-Gm-Message-State: AJcUukdtcufo3DcfXvG99RGQLzZeQ2oBnjWgIQuQMRc84jlxxkHV8D81
        ntsoB9qSR4ifI1yYDMmPV4P0sBhWmsg=
X-Google-Smtp-Source: ALg8bN7+HaiY1XsTWvzakNPi7ADMWJt74gu5PpijmJ/RQm9hMIALtHjokkF1/++wIReWRCu9PvwyWQ==
X-Received: by 2002:a17:902:7c05:: with SMTP id x5mr24101332pll.273.1548737169100;
        Mon, 28 Jan 2019 20:46:09 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id h128sm66270847pgc.15.2019.01.28.20.46.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 20:46:08 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1goLHj-00040F-Du; Mon, 28 Jan 2019 21:46:07 -0700
Date:   Mon, 28 Jan 2019 21:46:07 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     akpm@linux-foundation.org, dledford@redhat.com, jack@suse.de,
        ira.weiny@intel.com, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dennis.dalessandro@intel.com, mike.marciniszyn@intel.com,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 3/6] drivers/IB,qib: do not use mmap_sem
Message-ID: <20190129044607.GL25106@ziepe.ca>
References: <20190121174220.10583-1-dave@stgolabs.net>
 <20190121174220.10583-4-dave@stgolabs.net>
 <20190128233140.GA12530@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128233140.GA12530@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 04:31:40PM -0700, Jason Gunthorpe wrote:
> On Mon, Jan 21, 2019 at 09:42:17AM -0800, Davidlohr Bueso wrote:
> > The driver uses mmap_sem for both pinned_vm accounting and
> > get_user_pages(). By using gup_fast() and letting the mm handle
> > the lock if needed, we can no longer rely on the semaphore and
> > simplify the whole thing as the pinning is decoupled from the lock.
> > 
> > This also fixes a bug that __qib_get_user_pages was not taking into
> > account the current value of pinned_vm.
> > 
> > Cc: dennis.dalessandro@intel.com
> > Cc: mike.marciniszyn@intel.com
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> >  drivers/infiniband/hw/qib/qib_user_pages.c | 67 ++++++++++--------------------
> >  1 file changed, 22 insertions(+), 45 deletions(-)
> 
> I need you to respin this patch/series against the latest rdma tree:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
> 
> branch for-next
> 
> > diff --git a/drivers/infiniband/hw/qib/qib_user_pages.c b/drivers/infiniband/hw/qib/qib_user_pages.c
> > -static int __qib_get_user_pages(unsigned long start_page, size_t num_pages,
> > -				struct page **p)
> > -{
> > -	unsigned long lock_limit;
> > -	size_t got;
> > -	int ret;
> > -
> > -	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> > -
> > -	if (num_pages > lock_limit && !capable(CAP_IPC_LOCK)) {
> > -		ret = -ENOMEM;
> > -		goto bail;
> > -	}
> > -
> > -	for (got = 0; got < num_pages; got += ret) {
> > -		ret = get_user_pages(start_page + got * PAGE_SIZE,
> > -				     num_pages - got,
> > -				     FOLL_WRITE | FOLL_FORCE,
> > -				     p + got, NULL);
> 
> As this has been rightly changed to get_user_pages_longterm, and I
> think the right answer to solve the conflict is to discard some of
> this patch?

.. and I'm looking at some of the other conversions here.. *most
likely* any caller that is manipulating rlimit for get_user_pages
should really be calling get_user_pages_longterm, so they should not
be converted to use _fast?

Jason
