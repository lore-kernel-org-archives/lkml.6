Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBA4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AF82080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P0E8pHAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbeLNTsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 14:48:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52172 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730123AbeLNTsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 14:48:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GOFeIogLWodk44VJVfXiQHdoFwjtMW1R85VpJJ8G9ls=; b=P0E8pHAEFlB29Cy3DD/00io64
        gjdyTEJQBGM72v8ID9GWMpKJYsDN0Llk2YstpDtxt+2QLmE3iNcpQS6cVu11BGQtPQz1hQ1jWt52b
        oUn1bHOv3vZVeQt/0DYRnfb1IqpCt371g+ByJ/P/oGVD1hKnGl3PyJ/oeUou+UVR5ODjB62WLpJFP
        86tfkCfYuhV/1CTm2eelQg37cTdBZ83tkbH2C7/FDCM9hba5/7rhcUHEN/fIKUf4aOTI7Xx3rf5DN
        jd2RcarBPr7QGEFZRoK9TpplKThhgmSHDVjFhIgOs/qENTUAa1Zvb8FDo9QWaaSff0Oa3vhE3yl6P
        EuDKZvebg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXtRz-0000ZF-OF; Fri, 14 Dec 2018 19:48:43 +0000
Date:   Fri, 14 Dec 2018 11:48:43 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, david <david@fromorbit.com>,
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
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
Message-ID: <20181214194843.GG10600@bombadil.infradead.org>
References: <20181208022445.GA7024@redhat.com>
 <20181210102846.GC29289@quack2.suse.cz>
 <20181212150319.GA3432@redhat.com>
 <20181212214641.GB29416@dastard>
 <20181212215931.GG5037@redhat.com>
 <20181213005119.GD29416@dastard>
 <05a68829-6e6d-b766-11b4-99e1ba4bc87b@nvidia.com>
 <CAPcyv4jyG3YTtghyr04wws_hcSBAmPBpnCm0tFcKgz9VwrV=ow@mail.gmail.com>
 <01cf4e0c-b2d6-225a-3ee9-ef0f7e53684d@nvidia.com>
 <CAPcyv4hrbA9H20bi+QMpKNi7r=egstt61MdQSD5Fb293W1btaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hrbA9H20bi+QMpKNi7r=egstt61MdQSD5Fb293W1btaw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 11:38:59AM -0800, Dan Williams wrote:
> On Thu, Dec 13, 2018 at 10:11 PM John Hubbard <jhubbard@nvidia.com> wrote:
> > I don't have an answer for that, so maybe the page->mapping idea is dead already.
> >
> > So in that case, there is still one more way to do all of this, which is to
> > combine ZONE_DEVICE, HMM, and gup/dma information in a per-page struct, and get
> > there via basically page->private, more or less like this:
> 
> If we're going to allocate something new out-of-line then maybe we
> should go even further to allow for a page "proxy" object to front a
> real struct page. This idea arose from Dave Hansen as I explained to
> him the dax-reflink problem, and dovetails with Dave Chinner's
> suggestion earlier in this thread for dax-reflink.
> 
> Have get_user_pages() allocate a proxy object that gets passed around
> to drivers. Something like a struct page pointer with bit 0 set. This
> would add a conditional branch and pointer chase to many page
> operations, like page_to_pfn(), I thought something like it would be
> unacceptable a few years ago, but then HMM went and added similar
> overhead to put_page() and nobody balked.
> 
> This has the additional benefit of catching cases that might be doing
> a get_page() on a get_user_pages() result and should instead switch to
> a "ref_user_page()" (opposite of put_user_page()) as the API to take
> additional references on a get_user_pages() result.
> 
> page->index and page->mapping could be overridden by similar
> attributes in the proxy, and allow an N:1 relationship of proxy
> instances to actual pages. Filesystems could generate dynamic proxies
> as well.
> 
> The auxiliary information (dev_pagemap, hmm_data, etc...) moves to the
> proxy and stops polluting the base struct page which remains the
> canonical location for dirty-tracking and dma operations.
> 
> The difficulties are reconciling the source of the proxies as both
> get_user_pages() and filesystem may want to be the source of the
> allocation. In the get_user_pages_fast() path we may not be able to
> ask the filesystem for the proxy, at least not without destroying the
> performance expectations of get_user_pages_fast().

I think we can do better than a proxy object with bit 0 set.  I'd go
for allocating something like this:

struct dynamic_page {
	struct page;
	unsigned long vaddr;
	unsigned long pfn;
	...
};

and use a bit in struct page to indicate that this is a dynamic page.
