Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC11C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0817218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Lj+Gx4ur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbfABTHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 14:07:44 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38523 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfABTHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 14:07:43 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so14865054plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 11:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=COFLwH/DyVOWttHdTy9lTL/eU+Mo0gdQrmzzQPbSUa8=;
        b=Lj+Gx4urw46VQAKCF5oVzOrxUTmAJhOUaxNloRUDbnYlSuRx+ptMIxOqE6qhYWoly0
         9Zswr2uVsJLH9EG+OKGBdJNvDyctGMtTJUtSzoCJ9gUxonccgmE2ifN9QXA8ukd6rQCl
         EItALceXCfcrmq0ObP5Te285v2desIf+OlFpJNHIqc+IzJemMI+ppMZo+1ymM0ZdJXI3
         Zn3GD0XCCswSH7RDkTWbtcUrO9lIYe3REAxD5De5cJkP5ndcI5nDOgS4qhfqFVebOn87
         8hW3sgN4Kj0are45AExWhrrNHOPrFBOY/BsK60sGQMfcX8psXaZrGB780RmjD3VjCt15
         KFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=COFLwH/DyVOWttHdTy9lTL/eU+Mo0gdQrmzzQPbSUa8=;
        b=EDMKHkhpQ/ZG0QNb3N0v0WkDbFfTxIjQfJJofAicpRWiuObtCUMkhcjLiQYwKgzo+O
         VT8d66HJhFw/zAZ5Y2088wes8QU26PpbXHMbEHGLBc8hEVg+eUTLENZxf15O/frMi56n
         fVH4WhR/59ySJL8MWsXNuIKR0SXhiCl/NbZ2aOtK47Tg3tQrTKRsw3GwvVfySGQ5FlrZ
         Hno7BotWhkEMZJARzvtq1Lu12k5bqRJ+tIebfplTueKK+gY01TQcMO/aEbi2gaQne0U5
         slGiYpLkDPYXz5hixz2FveUvPBVLuiVSXGGuOW/jqWnzIX1l1NFytRY2vLuWctTGOlz5
         Hs4g==
X-Gm-Message-State: AJcUuke1zGrsHtMgpwnLky/9lyp+zkuJEZoBVRuKDzPGqzuCv/B1Uzq3
        LkPKUAfA5FXLUC14XD7o7deurQ==
X-Google-Smtp-Source: ALg8bN4KgSZbkhC+dE8GwDsHyhKzs38x4WfLKMNLAwTw+S/05wulfX2bcEzlv0sB+TdgmGvCEzwftg==
X-Received: by 2002:a17:902:7896:: with SMTP id q22mr45195871pll.280.1546456062575;
        Wed, 02 Jan 2019 11:07:42 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id x27sm97528849pfe.178.2019.01.02.11.07.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Jan 2019 11:07:41 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gelrg-0004Nj-PO; Wed, 02 Jan 2019 12:07:40 -0700
Date:   Wed, 2 Jan 2019 12:07:40 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     YueHaibing <yuehaibing@huawei.com>, dennis.dalessandro@intel.com,
        mike.marciniszyn@intel.com, dledford@redhat.com,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH -next] IB/qib: Add missing err handle for
 qib_user_sdma_rb_insert
Message-ID: <20190102190740.GH26211@ziepe.ca>
References: <20181221021938.13784-1-yuehaibing@huawei.com>
 <20190102171224.GA26765@ziepe.ca>
 <20190102184050.GI5424@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190102184050.GI5424@mtr-leonro.mtl.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2019 at 08:40:50PM +0200, Leon Romanovsky wrote:
> On Wed, Jan 02, 2019 at 10:12:24AM -0700, Jason Gunthorpe wrote:
> > On Fri, Dec 21, 2018 at 10:19:38AM +0800, YueHaibing wrote:
> > > It should goto err handle if qib_user_sdma_rb_insert fails,
> > > other than success return.
> > >
> > > Fixes: 67810e8c3c01 ("RDMA/qib: Remove all occurrences of BUG_ON()")
> > > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > >  drivers/infiniband/hw/qib/qib_user_sdma.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/infiniband/hw/qib/qib_user_sdma.c b/drivers/infiniband/hw/qib/qib_user_sdma.c
> > > index 31c523b..e87c0a7 100644
> > > +++ b/drivers/infiniband/hw/qib/qib_user_sdma.c
> > > @@ -237,6 +237,8 @@ qib_user_sdma_queue_create(struct device *dev, int unit, int ctxt, int sctxt)
> > >
> > >  		ret = qib_user_sdma_rb_insert(&qib_user_sdma_rb_root,
> > >  					sdma_rb_node);
> > > +		if (ret == 0)
> > > +			goto err_rb;
> > >  	}
> >
> > This doesn't look right, what about undoing the kmalloc directly
> > above?
> 
> Back then, I came to conclusion that qib_user_sdma_rb_insert() never
> returns 0. Otherwise, Dennis would see that BUG_ON() for a long time
> ago.

It fails if the index is in the RB tree, which would indicate a
programming bug.

The way to replace the BUG_ON is something like:

if (WARN_ON(ret == 0)) {
    kfree()
    goto err_rb;
}

Jason
