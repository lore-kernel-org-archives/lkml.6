Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C20EC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1335E2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bdd8fJe7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1335E2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbeJATZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:25:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45008 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbeJATZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VnOjUxDtVHfOPJ3vIHFRq8kSlm4sSv32rFSlCnl0cQY=; b=bdd8fJe7btu3eWHQb0J250P5r
        Z7mkH7Dub8JYJKv6r5DUL2UQvXW0opZZCjuw4gTAa9ZtEwJQjGWQc6cB/eU+E/azhLHgzzJ5zL91P
        Quvb8W0dc/b01Sv8SM9M8rz8+eUAMbygB3xDDabmA9wCkXQAYwajJbbENlHc7W2lLXMnDOnfDUuDC
        pWauct35pU/ceXYQobAOCIQ1K7G2cT26etMhVKdDU+rropxCBlEz2lbz2FHjWVVSIFn5YOPH4r/8t
        qTFewCChPzz4FgdGh/ViY8zU/qnwteult9QQkMX9bT4Vdtfm72q42BG79O5EtWL8gvRBXBTHDthYh
        kOVAkaHEg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g6xcE-0001ab-78; Mon, 01 Oct 2018 12:47:58 +0000
Date:   Mon, 1 Oct 2018 05:47:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, john.hubbard@gmail.com,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>
Subject: Re: [PATCH 0/4] get_user_pages*() and RDMA: first steps
Message-ID: <20181001124757.GA26218@infradead.org>
References: <20180928053949.5381-1-jhubbard@nvidia.com>
 <20180928152958.GA3321@redhat.com>
 <4c884529-e2ff-3808-9763-eb0e71f5a616@nvidia.com>
 <20180928214934.GA3265@redhat.com>
 <dfa6aaef-b97e-ebd4-6cc8-c907a7b3f9bb@nvidia.com>
 <20180929084608.GA3188@redhat.com>
 <20181001061127.GQ31060@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001061127.GQ31060@dastard>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 04:11:27PM +1000, Dave Chinner wrote:
> This reminds me so much of Linux mmap() in the mid-2000s - mmap()
> worked for ext3 without being aware of page faults,

And "worked" still is a bit of a stretch, as soon as you'd get
ENOSPC it would still blow up badly.  Which probably makes it an
even better analogy to the current case.

> RDMA does not call ->page_mkwrite on clean file backed pages before it
> writes to them and calls set_page_dirty(), and hence RDMA to file
> backed pages is completely unreliable. I'm not sure this can be
> solved without having page fault capable RDMA hardware....

We can always software prefault at gup time.  And also remember that
while RDMA might be the case at least some people care about here it
really isn't different from any of the other gup + I/O cases, including
doing direct I/O to a mmap area.  The only difference in the various
cases is how long the area should be pinned down - some users like RDMA
want a long term mapping, while others like direct I/O just need a short
transient one.

> We could address these use-after-free situations via forcing RDMA to
> use file layout leases and revoke the lease when we need to modify
> the backing store on leased files. However, this doesn't solve the
> need for filesystems to receive write fault notifications via
> ->page_mkwrite.

Exactly.   We need three things here:

 - notification to the filesystem that a page is (possibly) beeing
   written to
 - a way to to block fs operations while the pages are pinned
 - a way to distinguish between short and long term mappings,
   and only allow long terms mappings if they can be broken
   using something like leases

I'm also pretty sure we already explained this a long time ago when the
issue came up last year, so I'm not sure why this is even still
contentious.
