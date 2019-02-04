Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E59EC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C822080A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FGUGQXDg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbfBDTJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 14:09:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36736 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfBDTJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 14:09:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MtMB9MTpgmr1BCRNMWDvA5NXWtOVSM9dan7iTMIlXJQ=; b=FGUGQXDgOr8ZcEZwwE4Ok29No
        isAsaok6MHTNDkHfzs+oKLY+BVx4RxoDnK2NdDOUUlXrq0Dp0wpCbo+mFCPoGsI7Ht3QfesusXvSd
        Gb1R2G80avdRDh4s8V71Ge1MGJ7Y+G5JYyvNP7/4UKiEoTAS243rvxCxl24o4639/aisINDjmQH/8
        3IPLiJ+8dM5eUIHJ21yBvcUI8lmF6Sc13jjKROMJz8vBZ3ZVMjlUG4RnP1ft7CP8X9niJG2iCE6aj
        C3E+Gr341sVnU6Awoyea9ahuSMzyPFV0p8gMMJSFTN3ZuVwWlwW3QX3kpfqkH3T3NenVu9AsyFgJq
        SAPhH+2XA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqjcc-0008F9-Bv; Mon, 04 Feb 2019 19:09:34 +0000
Date:   Mon, 4 Feb 2019 11:09:34 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, john.hubbard@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>, Jan Kara <jack@suse.cz>,
        Jerome Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 0/6] RFC v2: mm: gup/dma tracking
Message-ID: <20190204190934.GE21860@bombadil.infradead.org>
References: <20190204052135.25784-1-jhubbard@nvidia.com>
 <01000168b980e880-a7d8e0db-84fb-4398-8269-149c66b701b4-000000@email.amazonses.com>
 <20190204175110.GA10237@ziepe.ca>
 <01000168b9be8b5a-3b4f8036-50c8-4180-b39f-9ef28cb60cce-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01000168b9be8b5a-3b4f8036-50c8-4180-b39f-9ef28cb60cce-000000@email.amazonses.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 06:21:39PM +0000, Christopher Lameter wrote:
> On Mon, 4 Feb 2019, Jason Gunthorpe wrote:
> 
> > On Mon, Feb 04, 2019 at 05:14:19PM +0000, Christopher Lameter wrote:
> > > Frankly I still think this does not solve anything.
> > >
> > > Concurrent write access from two sources to a single page is simply wrong.
> > > You cannot make this right by allowing long term RDMA pins in a filesystem
> > > and thus the filesystem can never update part of its files on disk.
> >
> > Fundamentally this patch series is fixing O_DIRECT to not crash the
> > kernel in extreme cases.. RDMA has the same problem, but it is much
> > easier to hit.
> 
> O_DIRECT is the same issue. O_DIRECT addresses always have been in
> anonymous memory or special file systems.

That's never been a constraint that's existed.
