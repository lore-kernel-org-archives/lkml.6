Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04960C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 16:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2BFF2073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 16:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UBW2jjaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2BFF2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbeI2Wu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 18:50:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48894 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbeI2Wu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 18:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yGnfntiwPmkgio20ndFB4H/cD3o8VkBmIPFP56KX+A0=; b=UBW2jjaDjceelrkLQ55ezP/Yb
        Gkf2s6sz6swBU1m6WKG7fQrBneboc2jpiAdrqx9AkXkop61IPmhjoNzsBix1is+e/gzBqf/AuvdZT
        PZrQolwzF7dLkZ8n0ei6KZGOMMXmVh6GNU5Ylabk6xcbRhzQiVgOxlyUkdB8V4kwM+icWc5sSEJZk
        YC+/t6f6vWpbd5cIskuuHfs0pB0VCAxsOFs6oObLdzwzR3eRbmeNcXRtwiqScnhwOVAar2jGzpE4H
        zFIC6t3wjN9CVmNrGshCm/mk68SXk3ORXrayVnaTAiguMTuC9miwsw1rCd0ivQbXVBfMy2opj4GDm
        Kn2RdCzNw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g6HzZ-0002bu-CA; Sat, 29 Sep 2018 16:21:17 +0000
Date:   Sat, 29 Sep 2018 09:21:17 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, john.hubbard@gmail.com,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Christian Benvenuti <benve@cisco.com>
Subject: Re: [PATCH 3/4] infiniband/mm: convert to the new put_user_page()
 call
Message-ID: <20180929162117.GA31216@bombadil.infradead.org>
References: <20180928053949.5381-1-jhubbard@nvidia.com>
 <20180928053949.5381-3-jhubbard@nvidia.com>
 <20180928153922.GA17076@ziepe.ca>
 <36bc65a3-8c2a-87df-44fc-89a1891b86db@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36bc65a3-8c2a-87df-44fc-89a1891b86db@nvidia.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 08:12:33PM -0700, John Hubbard wrote:
> >> +++ b/drivers/infiniband/core/umem.c
> >> @@ -60,7 +60,7 @@ static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int d
> >>  		page = sg_page(sg);
> >>  		if (!PageDirty(page) && umem->writable && dirty)
> >>  			set_page_dirty_lock(page);
> >> -		put_page(page);
> >> +		put_user_page(page);
> > 
> > Would it make sense to have a release/put_user_pages_dirtied to absorb
> > the set_page_dity pattern too? I notice in this patch there is some
> > variety here, I wonder what is the right way?
> > 
> > Also, I'm told this code here is a big performance bottleneck when the
> > number of pages becomes very long (think >> GB of memory), so having a
> > future path to use some kind of batching/threading sound great.
> 
> Yes. And you asked for this the first time, too. Consistent! :) Sorry for
> being slow to pick it up. It looks like there are several patterns, and
> we have to support both set_page_dirty() and set_page_dirty_lock(). So
> the best combination looks to be adding a few variations of
> release_user_pages*(), but leaving put_user_page() alone, because it's
> the "do it yourself" basic one. Scatter-gather will be stuck with that.

I think our current interfaces are wrong.  We should really have a
get_user_sg() / put_user_sg() function that will set up / destroy an
SG list appropriate for that range of user memory.  This is almost
orthogonal to the original intent here, so please don't see this as a
"must do first" kind of argument that might derail the whole thing.
