Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13F2C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 19:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D3E20672
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 19:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BPCn1eup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D3E20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbeJWEDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 00:03:24 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:38040 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbeJWEDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 00:03:24 -0400
Received: by mail-it1-f193.google.com with SMTP id i76-v6so14107174ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 12:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ng8XJRjDLo4T9LQsxwyGWYLTrEX5ScPLIw/PST11mFo=;
        b=BPCn1eupFN9NutuXdmEI1Td77GX1f/wLwQ3a8A2M2Zh4/pNW7X6tjh5xSX7/QiOAMO
         GWHNWSLMNjHO9RsQ02YFThuwhFJy9k5fel5JdeHx7ut+bjWfkpKKHrxlK+IjyGwsvXvX
         HUIgxx3LOvs+HwB8dbJgluRJPgdOYPrTqLstOy/MWodciWAoPQU1kEdYruFoHyFBNoEF
         olGZkib2KSN8p7MV4oCv5NjRw7Izx1bGA9/j8Q56zTYlS5EVP3PUCJt+dOm7JbeYyEIs
         BFIrsl4Z9uhzda8lhxYVQXfdXPtoTS8+CtDqFqPwawVjcG49m7JOH0v87Y3XL+lY3S+W
         1VgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ng8XJRjDLo4T9LQsxwyGWYLTrEX5ScPLIw/PST11mFo=;
        b=BEuRrf61wSFWs6YrA8AxiRS6vQOP3dzsV13t2/AHcwOUcmkm5dRDUP1RhC2KRvC5Vr
         7azhkNak7K10wcww1JXiDsT6gxNQvpsB96zQM3BILKID6qzWBEtbu5kG7modrx/M8VgG
         pCwW4tm62j/tirJmO54TUp/PvhFIcfmQZV5uda51FrSNCJwnEc9zWnpy2hwcAsIdHO+Y
         p452qfseOAjyoAVfc5EukAdGOFK9FM08N0TR0s6/qXSd16edcqkZ8veb/lrEu2KsODWD
         bXcAGvh97FWO4n6CHblpYQLR/ymu8Bq6W9nFUs86D0b9PFnpBpTl1rDGguhmV7/N5ycZ
         uleA==
X-Gm-Message-State: ABuFfojuJphj+bv32opyDTQxxxsvygQ6B3hCjeir4VgK0TQBJxh3cYG2
        MJuHRLASvzqVW+1lHyKIVeDPYQ==
X-Google-Smtp-Source: AJdET5cHVRdSz2/8Vg+VGCdFD+Ef5mVtuyvMLNjaWri407Z/VyDqf8gWBkHIjxmCW+GInf8JF9Pc/A==
X-Received: by 2002:a24:8e41:: with SMTP id h62-v6mr1015709ite.126.1540237412079;
        Mon, 22 Oct 2018 12:43:32 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id d124-v6sm11084751iof.57.2018.10.22.12.43.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 12:43:30 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gEg6r-0002Uo-OO; Mon, 22 Oct 2018 13:43:29 -0600
Date:   Mon, 22 Oct 2018 13:43:29 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        john.hubbard@gmail.com, Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Jerome Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH v4 2/3] mm: introduce put_user_page*(), placeholder
 versions
Message-ID: <20181022194329.GG30059@ziepe.ca>
References: <20181008211623.30796-1-jhubbard@nvidia.com>
 <20181008211623.30796-3-jhubbard@nvidia.com>
 <20181008171442.d3b3a1ea07d56c26d813a11e@linux-foundation.org>
 <5198a797-fa34-c859-ff9d-568834a85a83@nvidia.com>
 <20181010164541.ec4bf53f5a9e4ba6e5b52a21@linux-foundation.org>
 <20181011084929.GB8418@quack2.suse.cz>
 <20181011132013.GA5968@ziepe.ca>
 <97e89e08-5b94-240a-56e9-ece2b91f6dbc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97e89e08-5b94-240a-56e9-ece2b91f6dbc@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 06:23:24PM -0700, John Hubbard wrote:
> On 10/11/18 6:20 AM, Jason Gunthorpe wrote:
> > On Thu, Oct 11, 2018 at 10:49:29AM +0200, Jan Kara wrote:
> > 
> >>> This is a real worry.  If someone uses a mistaken put_page() then how
> >>> will that bug manifest at runtime?  Under what set of circumstances
> >>> will the kernel trigger the bug?
> >>
> >> At runtime such bug will manifest as a page that can never be evicted from
> >> memory. We could warn in put_page() if page reference count drops below
> >> bare minimum for given user pin count which would be able to catch some
> >> issues but it won't be 100% reliable. So at this point I'm more leaning
> >> towards making get_user_pages() return a different type than just
> >> struct page * to make it much harder for refcount to go wrong...
> > 
> > At least for the infiniband code being used as an example here we take
> > the struct page from get_user_pages, then stick it in a sgl, and at
> > put_page time we get the page back out of the sgl via sg_page()
> > 
> > So type safety will not help this case... I wonder how many other
> > users are similar? I think this is a pretty reasonable flow for DMA
> > with user pages.
> > 
> 
> That is true. The infiniband code, fortunately, never mixes the two page
> types into the same pool (or sg list), so it's actually an easier example
> than some other subsystems. But, yes, type safety doesn't help there. I can 
> take a moment to look around at the other areas, to quantify how much a type
> safety change might help.

Are most (all?) of the places working with SGLs?

Maybe we could just have a 'get_user_pages_to_sgl' and 'put_pages_sgl'
sort of interface that handled all this instead of trying to make
something that is struct page based?

It seems easier to get an extra bit for user/!user in the SGL
datastructure?

Jason
