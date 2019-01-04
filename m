Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819D2C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 22:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3401D21872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 22:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VYBUMhS7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfADWiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 17:38:08 -0500
Received: from mail-pg1-f175.google.com ([209.85.215.175]:39771 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfADWiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 17:38:07 -0500
Received: by mail-pg1-f175.google.com with SMTP id w6so18048643pgl.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 14:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d7XGLgTv6bVwRjca0g0RRNVY/+V2FxcWF0DAtrcoGn4=;
        b=VYBUMhS7GE2TKcSSwEnfd0j/nEin5TtbnhdSO/9m0QZ7dVsdLTleqNRW0sPc82B45R
         w67f2zcscc/ThkVswZLama8A3PJyQxs1xKmPXAHjK8SSyKlU3+jmk4M1+6TIwrH0cm4T
         1YEvvhyAW9J0kPkbYCjhWkX7Vc1QiKA7RfzX7xUc/Zpn+TtPlZYwHVjlWN8Nyefnzu3r
         /sk/ECtaG60FgGE7l7eqqcTEM48O7ElXiTU3t9GPLqxT3b6HBJENKLKUMz16tS7C9kCB
         Djz6NDWb6eLV4e0Ewnsel6nbiCGchhqiFvGB4zv2CSytgvig5LLBJ+isdGhRDkvM7NGd
         5NWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d7XGLgTv6bVwRjca0g0RRNVY/+V2FxcWF0DAtrcoGn4=;
        b=kVc1S4Ct6YCUUAG+WSkbdSg65F84/IOjpW269pak/Uf9eu+QY2flbhP9kQRCDgaWlE
         rs3djAeOYWqUVEQZN9lzCifBKjC19ZwrXNs0SjmV1FxyMvzaBrdxQtnJQl/4MvC5k2bN
         WM/0BE0UXYbt7MdMUi6CiAaAFH0dM3236w2cTL7OQ5EKDQdA0UjEe7mOlY95/AXYCvA1
         qM9VToK7vuCAGZhPtEpa8IVaYuTuKJ8EDQ8zMHg2yxx5SFxVKBCdeBX6S3ze1L3sB+hE
         VEl4jIRm4Qm6YVAewXdd9XqbScQTBiNfCNYRTXdnPMKxqFJ4NyJdYkac0EICfxevGHMw
         bdXg==
X-Gm-Message-State: AJcUukcztPwQVx+YC4lKWdcBRNpZULdukVglnbm2qQnW/KfxR3oNtiuJ
        PDo7Jp1CWEqwt8tCdTQwf4GuPg==
X-Google-Smtp-Source: ALg8bN6R7A4pzzl/PxyGswMRo6PtCZWZKqLVw/x8h0wcmo16K66jS/E4NHcoUPoEuvfAkmC6utIV/w==
X-Received: by 2002:a63:e84c:: with SMTP id a12mr3092732pgk.241.1546641486749;
        Fri, 04 Jan 2019 14:38:06 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id f13sm83894610pfa.132.2019.01.04.14.38.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 14:38:06 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gfY6P-0000Vu-33; Fri, 04 Jan 2019 15:38:05 -0700
Date:   Fri, 4 Jan 2019 15:38:05 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: Re: [PATCH -next] IB/qib: Add missing err handle for
 qib_user_sdma_rb_insert
Message-ID: <20190104223805.GG28190@ziepe.ca>
References: <20181221021938.13784-1-yuehaibing@huawei.com>
 <32E1700B9017364D9B60AED9960492BC70C11891@fmsmsx120.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32E1700B9017364D9B60AED9960492BC70C11891@fmsmsx120.amr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 06:39:50PM +0000, Marciniszyn, Mike wrote:
> > diff --git a/drivers/infiniband/hw/qib/qib_user_sdma.c
> > b/drivers/infiniband/hw/qib/qib_user_sdma.c
> > index 31c523b..e87c0a7 100644
> > +++ b/drivers/infiniband/hw/qib/qib_user_sdma.c
> > @@ -237,6 +237,8 @@ qib_user_sdma_queue_create(struct device *dev,
> > int unit, int ctxt, int sctxt)
> > 
> >  		ret = qib_user_sdma_rb_insert(&qib_user_sdma_rb_root,
> >  					sdma_rb_node);
> > +		if (ret == 0)
> > +			goto err_rb;
> >  	}
> >  	pq->sdma_rb_node = sdma_rb_node;
> > 
> 
> Thanks!
> 
> This patch is ok.

> The NULL returned from this routine will result in an error return up to PSM which will fail.
> 
> The bail branch will do the necessary cleanup, including freeing the
> node that couldn't be added.

How? sdma_rb_node is a stack variable that is not accessed during
cleanup?

Jason
