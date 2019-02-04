Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0388FC282CC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C937B2080A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="A7FU0101"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbfBDRvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:51:16 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36976 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbfBDRvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 12:51:16 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so266641plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 09:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gxZcmyrTQ7o98rYEkVwMPBb43wOs0dpxU//wAZw+xbw=;
        b=A7FU0101Au69fdbvimqEQXAxTxm4eQHcMqr/DHY+0Xd35XfeXkYU3X3Dj0t4aPpV2+
         rx31+wKEKVo0388YnAAFzU36OpBWu2TfXTwzoMF8wlup8kGSsehMHugVJ/bW1pb2SpAD
         G6J85D8wIIdCalmI7cGyRIsRg/L1uCRkAznDmHsXMHwiaveQq8PC5xE2W5+ZrzpaIcQ+
         W1S32XGZJuuP/+zEuY4rAvZgR8yo3NDxaRMloUtG9zyws78xLr/NPZQvJth5pXJiG6s3
         zHOChaldNMZHgmeF10T17McWCH5NTWmx81B3Q7dDTUsugo+xUB5BCkNM3iqhgMUhBsoM
         CTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gxZcmyrTQ7o98rYEkVwMPBb43wOs0dpxU//wAZw+xbw=;
        b=WkiuA43wkmmL+d11k1/5vfR5s3XW+5v2Vto0OejZY3AnWgrUl3N9nN5+vjCZTRYPKv
         YL0M89rDMcEuAWv1/dpoPZdP4zGbnmY1baQhr9wnYgpRAJ270lOUNf4YOPfYJvS8gu/S
         MzWkCclPsos0upObEL7IPb1MEO+JsYzlBM8R5XqHCi3uFNdi4ok13yIpoMDK8idGvdXu
         UyWdz/9QJSD2tR8Bl5nvJy7J8LNNgrFkopusquQXOV98VAbA/AzNOIYx4EFa9bf1nbVH
         3/6nLlG8kGLLqCW+cPVzCvi/9Nv3ddW2B+ZixKyLJ7OIV65M1YCxjNg0HRmIMA8mapX1
         OoSA==
X-Gm-Message-State: AHQUAuZZtvkv2UEq3ksgw6c3fzYbYQ/nPuoFF1th0NNIx/FhuCY26LMN
        XfbrU/r1WsfoMnhOYPJ9K66GCw==
X-Google-Smtp-Source: AHgI3IYqNbWmq8UYZLwTkZ1W2v6TF+N3keX9gC9JaVu9p6Jyvue8K0UtB8kV2A8jzdpNeHMjlFO+qg==
X-Received: by 2002:a17:902:2c83:: with SMTP id n3mr609436plb.104.1549302675060;
        Mon, 04 Feb 2019 09:51:15 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id 6sm1139978pfv.30.2019.02.04.09.51.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 09:51:11 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gqiOk-0003oc-Or; Mon, 04 Feb 2019 10:51:10 -0700
Date:   Mon, 4 Feb 2019 10:51:10 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christopher Lameter <cl@linux.com>
Cc:     john.hubbard@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>, Jan Kara <jack@suse.cz>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 0/6] RFC v2: mm: gup/dma tracking
Message-ID: <20190204175110.GA10237@ziepe.ca>
References: <20190204052135.25784-1-jhubbard@nvidia.com>
 <01000168b980e880-a7d8e0db-84fb-4398-8269-149c66b701b4-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01000168b980e880-a7d8e0db-84fb-4398-8269-149c66b701b4-000000@email.amazonses.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 05:14:19PM +0000, Christopher Lameter wrote:
> Frankly I still think this does not solve anything.
> 
> Concurrent write access from two sources to a single page is simply wrong.
> You cannot make this right by allowing long term RDMA pins in a filesystem
> and thus the filesystem can never update part of its files on disk.

Fundamentally this patch series is fixing O_DIRECT to not crash the
kernel in extreme cases.. RDMA has the same problem, but it is much
easier to hit.

I think questions related to RDMA are somewhat separate, and maybe it
should be blocked, or not, but either way O_DIRECT has to be fixed.

Jason
