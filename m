Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22853C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11EF218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DQuWhkgC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfBKWXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:23:39 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45456 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbfBKWXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:23:38 -0500
Received: by mail-pf1-f195.google.com with SMTP id j3so217357pfi.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 14:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1WLlOJDJcxcIXG3soDmEUGpqQwzaXnBtVm7Uc05eSQI=;
        b=DQuWhkgCDdMgzUqdZrbzehZBo86Fa9rjKbDUIz7mCPq+AD222ZIWTnM6kmQS8oyRpy
         LPubwTMgDAA/bsdjRIsGhu6mgUeQDqpov+bFcgQmHS042fHxaHZL8GY027k2ThHGpw/R
         xmuYJPi9flXgRJriW2XzV8jfEjvJ099LYKBJbFalttj4vPXCtJ34YZuIS+zSuPBmcADJ
         6u4G5QQZLWsjMJfNH5zzzCWXPNfR5vJIuOjm7dpli3cKkEhsmZBMbWALN81TvHrSqn0z
         khWaiTAIdL5o5BJNt/xom8HlwcvrAQ8fawFLrcpdE8HNinN/jRVc7wZAZz5sb9m1sGtT
         FGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1WLlOJDJcxcIXG3soDmEUGpqQwzaXnBtVm7Uc05eSQI=;
        b=I63HoKNPTNVIbgaEpSlR1KZIP0JFairsXTdT8smmMDJ8FpLUC8t1PwxZNEGCeztUcC
         VAEFPONts+ywkI4nLDPXU79kSStLpm/+3R3W5jajawilTcCu2jx0oroA89f15oNhphtL
         TmfK2jDC5IT3agr8OM/YHbIuG+hF5T00ApcER78RJavcJ0G+xIGj8prctPqlUgNldTA0
         d3LDW9WEHT5eqmBIgwtYQ8u33wtCGnFhwadoLESiwed7jQenrZ87arC+2nyZsCezIUyK
         IGCfw/WaodD6ZW7BJBSVzZZYgyLMMCRwYxfaLqbhTAkX/rMc7OQKMdTgyOH7ehiMJL/Z
         pUXQ==
X-Gm-Message-State: AHQUAuav0mymlYhd9veRRdDzt/hwG414J/bfhUZxq1UEu/lCjVvuz1+G
        rD4Sjp/WewxmR3usA1nlxEezRQ==
X-Google-Smtp-Source: AHgI3IY25dSeKcjBLIFYZgY5sGbu3MRMXrBBw6lZ8FEZg89r9SGm32f9SsdhQVc1empO+bBDEtftnA==
X-Received: by 2002:a62:398d:: with SMTP id u13mr580196pfj.32.1549923818304;
        Mon, 11 Feb 2019 14:23:38 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id f67sm15264387pff.29.2019.02.11.14.23.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 14:23:35 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gtJzD-0003XL-8J; Mon, 11 Feb 2019 15:23:35 -0700
Date:   Mon, 11 Feb 2019 15:23:35 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Weiny, Ira" <ira.weiny@intel.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH 0/3] Add gup fast + longterm and use it in HFI1
Message-ID: <20190211222335.GK24692@ziepe.ca>
References: <20190211201643.7599-1-ira.weiny@intel.com>
 <20190211204049.GB2771@ziepe.ca>
 <2807E5FD2F6FDA4886F6618EAC48510E79BCF04C@CRSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2807E5FD2F6FDA4886F6618EAC48510E79BCF04C@CRSMSX101.amr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 09:14:56PM +0000, Weiny, Ira wrote:
> > 
> > On Mon, Feb 11, 2019 at 12:16:40PM -0800, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > >
> > > NOTE: This series depends on my clean up patch to remove the write
> > > parameter from gup_fast_permitted()[1]
> > >
> > > HFI1 uses get_user_pages_fast() due to it performance advantages.
> > > Like RDMA,
> > > HFI1 pages can be held for a significant time.  But
> > > get_user_pages_fast() does not protect against mapping of FS DAX pages.
> > 
> > If HFI1 can use the _fast varient, can't all the general RDMA stuff use it too?
> > 
> > What is the guidance on when fast vs not fast should be use?
> 
> Right now it can't because it holds mmap_sem across the call.  Once
> Shiraz's patches are accepted removing the umem->hugetlb flag I
> think we can change umem.c.

Okay, that make sense, we should change it when Shiraz's patches are
merged
 
> Also, it specifies FOLL_FORCE which can't currently be specified
> with gup fast.  One idea I had was to change get_user_pages_fast()
> to use gup_flags instead of a single write flag.  But that proved to
> be a very big cosmetic change across a lot of callers so I went this
> way.

I think you should do it.. :)

Jason
