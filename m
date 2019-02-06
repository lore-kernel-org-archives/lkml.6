Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62CCC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813822080D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SSgOnHpa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfBFTlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:41:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53928 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfBFTlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 14:41:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KUo1sm11EKAgA+q/x8aFzMhJrSzJBKbg0a/gSVG3nvA=; b=SSgOnHpaimS7ENQea9aMmvnmb
        UZpIO2AVsJQrc6Zftn+jEQn05/bgZWzoCwOKTQmsz8XsUL8gLr/ORIVAODYwuXTyiMsFLdDMDgUpG
        YNZFWk5DvJE1cg8HylhWjkqmP+fLVZkWfycf5r9bMnGXBjhflXjVKfLLgfWgtrxRW1SnE75hYEsQO
        rd6cuZmM1GzWZuRw7ZNPFGs3ZlraxiLL6bDjB414cV2JRDIK20468VPWjGrZ5I/42jJnDc/Zo3R7D
        FcT+Vr29YYYvugS+Sa9QPCwOjCGKoKLF9BSOfJBtCouJXTlizucuv2Fv/XoLy3SMz1X6jum3yXWLh
        6IwRD+ziw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1grT43-00032j-M5; Wed, 06 Feb 2019 19:40:55 +0000
Date:   Wed, 6 Feb 2019 11:40:55 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Jan Kara <jack@suse.cz>, Ira Weiny <ira.weiny@intel.com>,
        lsf-pc@lists.linux-foundation.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
Message-ID: <20190206194055.GP21860@bombadil.infradead.org>
References: <20190205175059.GB21617@iweiny-DESK2.sc.intel.com>
 <20190206095000.GA12006@quack2.suse.cz>
 <20190206173114.GB12227@ziepe.ca>
 <20190206175233.GN21860@bombadil.infradead.org>
 <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
 <01000168c43d594c-7979fcf8-b9c1-4bda-b29a-500efe001d66-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01000168c43d594c-7979fcf8-b9c1-4bda-b29a-500efe001d66-000000@email.amazonses.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 07:16:21PM +0000, Christopher Lameter wrote:
> On Wed, 6 Feb 2019, Doug Ledford wrote:
> > > Most of the cases we want revoke for are things like truncate().
> > > Shouldn't happen with a sane system, but we're trying to avoid users
> > > doing awful things like being able to DMA to pages that are now part of
> > > a different file.
> >
> > Why is the solution revoke then?  Is there something besides truncate
> > that we have to worry about?  I ask because EBUSY is not currently
> > listed as a return value of truncate, so extending the API to include
> > EBUSY to mean "this file has pinned pages that can not be freed" is not
> > (or should not be) totally out of the question.
> >
> > Admittedly, I'm coming in late to this conversation, but did I miss the
> > portion where that alternative was ruled out?
> 
> Coming in late here too but isnt the only DAX case that we are concerned
> about where there was an mmap with the O_DAX option to do direct write

There is no O_DAX option.  There's mount -o dax, but there's nothing that
a program does to say "Use DAX".

> though? If we only allow this use case then we may not have to worry about
> long term GUP because DAX mapped files will stay in the physical location
> regardless.

... except for truncate.  And now that I think about it, there was a
desire to support hot-unplug which also needed revoke.

> Maybe we can solve the long term GUP problem through the requirement that
> user space acquires some sort of means to pin the pages? In the DAX case
> this is given by the filesystem and the hardware will basically take care
> of writeback.

It's not given by the filesystem.

> In case of anonymous memory this can be guaranteed otherwise and is less
> critical since these pages are not part of the pagecache and are not
> subject to writeback.

but are subject to being swapped out?
