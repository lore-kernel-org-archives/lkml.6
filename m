Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E447C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5B121B1C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fVw7r3Mq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732951AbfBKSkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:40:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58872 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbfBKSkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:40:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ai5ng9siExeClUBgwfnBsfOAh7Ww0UnChKfm7GQwqy8=; b=fVw7r3MqWnUJtTl6mhVkXjfp6
        vM9c0a6AHbh6U4flVQBofzZmFJ7tWik+X7J/bOVW6acd8XxcqJUdUOFxACuHBcP2Xb03joVjDwJup
        yKI/y1HOhLWLkZeMt2EWaoAmg8w6l4Iy3pJpNi6iMlLw1JzPbw2sRi1bZh9vXkw/IH/CFJw+C+Dnh
        X5n1D5T13dh60kkz0g07H3phR8qFcQ8S5TEHS69AJPdUdJ3D1LeyRrw3GwIo+vNXFDGwWYPW4Nmdo
        jYQNctPjbwqrwZpGiOxpmaSQ30wm/1PC8CYlFMU0Sq6ilUE+vxNcAKdN7rd+uKFhyF7Wfe6iibTJd
        rhjUqcf9g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtGVU-0004zX-H5; Mon, 11 Feb 2019 18:40:40 +0000
Date:   Mon, 11 Feb 2019 10:40:40 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Christopher Lameter <cl@linux.com>,
        Doug Ledford <dledford@redhat.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
Message-ID: <20190211184040.GF12668@bombadil.infradead.org>
References: <bfe0fdd5400d41d223d8d30142f56a9c8efc033d.camel@redhat.com>
 <01000168c8e2de6b-9ab820ed-38ad-469c-b210-60fcff8ea81c-000000@email.amazonses.com>
 <20190208044302.GA20493@dastard>
 <20190208111028.GD6353@quack2.suse.cz>
 <CAPcyv4iVtBfO8zWZU3LZXLqv-dha1NSG+2+7MvgNy9TibCy4Cw@mail.gmail.com>
 <20190211102402.GF19029@quack2.suse.cz>
 <CAPcyv4iHso+PqAm-4NfF0svoK4mELJMSWNp+vsG43UaW1S2eew@mail.gmail.com>
 <20190211180654.GB24692@ziepe.ca>
 <20190211181921.GA5526@iweiny-DESK2.sc.intel.com>
 <20190211182649.GD24692@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211182649.GD24692@ziepe.ca>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 11:26:49AM -0700, Jason Gunthorpe wrote:
> On Mon, Feb 11, 2019 at 10:19:22AM -0800, Ira Weiny wrote:
> > What if user space then writes to the end of the file with a regular write?
> > Does that write end up at the point they truncated to or off the end of the
> > mmaped area (old length)?
> 
> IIRC it depends how the user does the write..
> 
> pwrite() with a given offset will write to that offset, re-extending
> the file if needed
> 
> A file opened with O_APPEND and a write done with write() should
> append to the new end
> 
> A normal file with a normal write should write to the FD's current
> seek pointer.
> 
> I'm not sure what happens if you write via mmap/msync.
> 
> RDMA is similar to pwrite() and mmap.

A pertinent point that you didn't mention is that ftruncate() does not change
the file offset.  So there's no user-visible change in behaviour.
