Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC998C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FEDA206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nE0Yu5d5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbeLNUDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:03:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56792 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730493AbeLNUDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:03:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cc6EIIF0huP2R1uhLjFS4fNvXY4CUVFcrD+l8LsoEOU=; b=nE0Yu5d5gBnB7c6F5REciXulm
        gNdxh6Pt7FJxo+evRGjclHRXn6Y5Im3wTLY7gu9LA+1I9smZ8GYDI+DRJTmBQyPR0T+x2fzJIkREM
        MAsW5wokdWej+YvAlhujZZNYP36ixCxfcGfnTyKfrWZHre39fcI8/JOi9OjJjRsu/XeoAFVdix+ZJ
        gXpCm2GdmX6qMcX1vYnmHEoHBpA9tw3QFxW0e22XvRsJ524oYT9NeZQvaQoVFYZ5J52fPhfiM57kc
        VGwkDErIRJG3nf2nZTmaRWC0HqPx62xGWKVHPX02DS53q4or+nf+UG/dSH3TealDyjHy8tvScPoCd
        3VQ4Ql9Zg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXtg0-0005W5-22; Fri, 14 Dec 2018 20:03:12 +0000
Date:   Fri, 14 Dec 2018 12:03:11 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        david <david@fromorbit.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>, John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, tom@talpey.com,
        Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
Message-ID: <20181214200311.GH10600@bombadil.infradead.org>
References: <20181212150319.GA3432@redhat.com>
 <20181212214641.GB29416@dastard>
 <20181212215931.GG5037@redhat.com>
 <20181213005119.GD29416@dastard>
 <05a68829-6e6d-b766-11b4-99e1ba4bc87b@nvidia.com>
 <CAPcyv4jyG3YTtghyr04wws_hcSBAmPBpnCm0tFcKgz9VwrV=ow@mail.gmail.com>
 <01cf4e0c-b2d6-225a-3ee9-ef0f7e53684d@nvidia.com>
 <CAPcyv4hrbA9H20bi+QMpKNi7r=egstt61MdQSD5Fb293W1btaw@mail.gmail.com>
 <20181214194843.GG10600@bombadil.infradead.org>
 <ed49a260-ffd5-613d-e48b-dfb4b550e8bb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed49a260-ffd5-613d-e48b-dfb4b550e8bb@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 11:53:31AM -0800, Dave Hansen wrote:
> On 12/14/18 11:48 AM, Matthew Wilcox wrote:
> > I think we can do better than a proxy object with bit 0 set.  I'd go
> > for allocating something like this:
> > 
> > struct dynamic_page {
> > 	struct page;
> > 	unsigned long vaddr;
> > 	unsigned long pfn;
> > 	...
> > };
> > 
> > and use a bit in struct page to indicate that this is a dynamic page.
> 
> That might be fun.  We'd just need a fast/static and slow/dynamic path
> in page_to_pfn()/pfn_to_page().  We'd also need some kind of auxiliary
> pfn-to-page structure since we could not fit that^ structure in vmemmap[].

Yes; working on the pfn-to-page structure right now as it happens ...
in the meantime, an XArray for it probably wouldn't be _too_ bad.
