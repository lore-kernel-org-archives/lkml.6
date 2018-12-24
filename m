Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035D3C64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0CC7214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mR/g9a2F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbeLXWIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 17:08:13 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44978 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeLXWIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 17:08:13 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so6169005pfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 14:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RRno2yox+6tkTcLW2dCaHtqwdXbvPwIY/4Jy9ivOec8=;
        b=mR/g9a2F0TOVxCjZZ8TzzBBuipRD7ku0hT70UvKqPThlwo8xWmudJX21Wh+qnL9OeS
         FuLs9gcwJqTeYwir0Y3oUq6/jIqeV+b6mlZr/mcXlI/+URVGt3WKSi4WQJCkAIUBBx50
         2CcwEdnV9nFjKHhCanC/S+ZupAiXhSMZ6zHgeeTRZ0XYPWkgDrLpR76YtRddGJEXM84r
         O2OxmEY/7WXvBaU843LimqPg0Df8rZGJ30sCSJ4LIPZ2IeudoiG6zq+IfdhdMA2Vt8Gh
         35IxHjFtdGwcsN5ylRv9MarepPzIskgEfr4LLAq7TdLkmmJ0K4YP+C+kNeRFDRVWVjbp
         0BSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RRno2yox+6tkTcLW2dCaHtqwdXbvPwIY/4Jy9ivOec8=;
        b=Mgnn9UpZ9V+zNsT1HjdhlH2XWgZtYJzxzVL+lWkp08uoK0/gu9EtybRPZKyVguYmbA
         dRoXfP4igax5zJO394Rs05r9brX1KS4UmJ19AtSpkaCx+13HmatEVB1k/NgqII6QmTrt
         O9QT0L7sBox8IKI1LmrKStyTiaPpfVaUM2x4VWtQEO3g6Zc2HnWQb5CDLqeVx3BLT/A4
         V7CW7mZQCU90PuRARmESYBy50mLpxK86g8B6TwuJJLC1O+A08+/lFSEbvmNQDfxkwiXC
         GrEWxgXmYnzTElbs3Cgc+rjjivJ0ylmV8oQbOe7/JFpcw4dnEo9oiFT5tS41C+Eip/RH
         zsyw==
X-Gm-Message-State: AA+aEWbDKU8ZjL98V/NoFe5YgRas9L7875FJOkPWSg7X+rUTgijKypTu
        6oCmVzOZx1lTljpivvxgGrP+pg==
X-Google-Smtp-Source: AFSGD/VgCLYSsxar2Ei1M8Z6dZbcUnJzcph+AVTBz0rnV7X3udpZc2WlEAunDX35j0SAxKMPVwAgWw==
X-Received: by 2002:aa7:87ce:: with SMTP id i14mr14523083pfo.20.1545689292335;
        Mon, 24 Dec 2018 14:08:12 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id p77sm67895220pfi.85.2018.12.24.14.08.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Dec 2018 14:08:11 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gbYOQ-0000Py-LC; Mon, 24 Dec 2018 15:08:10 -0700
Date:   Mon, 24 Dec 2018 15:08:10 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Gal Pressman <galpress@amazon.com>, Joe Perches <joe@perches.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Tariq Toukan <tariqt@mellanox.com>, xavier.huwei@huawei.com,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Stephen Warren <swarren@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: rfc: bool structure members (was Re: [PATCH V3] net/mlx4: Get
 rid of page operation after dma_alloc_coherent)
Message-ID: <20181224220810.GA17036@ziepe.ca>
References: <20181219182031.8675-1-swarren@wwwdotorg.org>
 <20181220174318.GA21404@ziepe.ca>
 <20181220174448.GA21149@lst.de>
 <1545328145.185366.500.camel@acm.org>
 <072c2d9d187daf0672bf54ab035e47a05fd1cd1d.camel@perches.com>
 <20181221033159.GF23877@ziepe.ca>
 <b906bec0fd12d25474561263087a26b8b0519fe4.camel@perches.com>
 <20181221235230.GC13168@ziepe.ca>
 <dc6d4923-63bd-e133-310b-7b164b0c92f5@amazon.com>
 <20181223165312.GE2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181223165312.GE2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2018 at 04:53:12PM +0000, Al Viro wrote:
> On Sun, Dec 23, 2018 at 06:42:20PM +0200, Gal Pressman wrote:
> > > -17) Don't re-invent the kernel macros
> > > +17) Using bool
> > > +--------------
> > > +
> > > +The Linux kernel uses the C11 standard for the bool type. bool values can only
> 
> C99, surely?

Oops, yes, that is right

Jason
