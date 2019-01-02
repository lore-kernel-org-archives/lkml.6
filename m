Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0DFC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 17:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90BD218EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 17:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="h1C325sN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbfABRM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 12:12:26 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40134 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727424AbfABRM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 12:12:26 -0500
Received: by mail-pl1-f195.google.com with SMTP id u18so14737057plq.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 09:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/DPEzOhz3olurpXgL+EBj40L6QAhXP31qzfLT3vhkv4=;
        b=h1C325sNhRq88CYrpG21eh9jJXDydBCZTsZ7pO9U7bIERHc0KNDfMoZMUsWFz2Kcpw
         Oouo+foLr0iF9V9b5PjJ+SUZRaeUvi7ikZ9i/+f6cJY0+BOLCtP6meFl6wUZw6Px8k3J
         VNfIE23yoeHJ2BKvEG+Q4Uaz7tyuT92GQTOEEyJZYKHpFY8QETN8qD49S0NqDa2WVlwz
         KvndJLHgDaI1ZDRy+sJJVgl/hylVIXK82sw2NxDOsBlpH95yN9O7pZyDrDobt5VaQi/a
         9xvUDMCWbtHGdnDccTnljN2OyT0DCjYeMyW5HBq5ii2q3uJvgrY+0Ajq7crZORd0BqoH
         EWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/DPEzOhz3olurpXgL+EBj40L6QAhXP31qzfLT3vhkv4=;
        b=WM3RXpAsDPAQLgXDd4iVhfD0wPTS2pisy2mjveNAhihOmCsK/mTmVQ2m7FIJ68oNRT
         NKtEsAt8k02aVSZC44fjhSuHqp7t1D8/dYjsN4WTMit9iVotWHacY6Jtdnom08k/7ITX
         PVwWQAycc6KpHEifRmhiL8ywxpzSF48FYVCGLzqbp9B+d8NJeyCcJ7mbh+v7MEp7680/
         /waMCDRV6u8QAh2lZP8RnYFzN0II2pjQ0Rmp2psUaYLZM3RNXIj7Zpjrn4wxHRzxgNW5
         VXNN5haRYoo/wbBhqXGZbSnqNLS/sE0XgDp0BypsYYuEhb2OsKLcvxspSflpaTgK8k5b
         VOdA==
X-Gm-Message-State: AJcUukfSpKWQtLaYKRVRFyovcmb3DriF6xZjMexPWs2bgm9bvm1QkXGe
        ycpwNzUcLMShc+IoEiXYPvZSGQ==
X-Google-Smtp-Source: ALg8bN7a8yQE/sj6QgxXjvFd7uM8egaVxPjYxR3wQkKvuDpvPtrl9meIy/mBnwOYpJ8P6pWvZlffYw==
X-Received: by 2002:a17:902:a50a:: with SMTP id s10mr41999470plq.278.1546449145811;
        Wed, 02 Jan 2019 09:12:25 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id 84sm100305230pfk.134.2019.01.02.09.12.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Jan 2019 09:12:25 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gek48-0006yi-8m; Wed, 02 Jan 2019 10:12:24 -0700
Date:   Wed, 2 Jan 2019 10:12:24 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     dennis.dalessandro@intel.com, mike.marciniszyn@intel.com,
        dledford@redhat.com, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH -next] IB/qib: Add missing err handle for
 qib_user_sdma_rb_insert
Message-ID: <20190102171224.GA26765@ziepe.ca>
References: <20181221021938.13784-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221021938.13784-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 10:19:38AM +0800, YueHaibing wrote:
> It should goto err handle if qib_user_sdma_rb_insert fails,
> other than success return.
> 
> Fixes: 67810e8c3c01 ("RDMA/qib: Remove all occurrences of BUG_ON()")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/infiniband/hw/qib/qib_user_sdma.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/qib/qib_user_sdma.c b/drivers/infiniband/hw/qib/qib_user_sdma.c
> index 31c523b..e87c0a7 100644
> --- a/drivers/infiniband/hw/qib/qib_user_sdma.c
> +++ b/drivers/infiniband/hw/qib/qib_user_sdma.c
> @@ -237,6 +237,8 @@ qib_user_sdma_queue_create(struct device *dev, int unit, int ctxt, int sctxt)
>  
>  		ret = qib_user_sdma_rb_insert(&qib_user_sdma_rb_root,
>  					sdma_rb_node);
> +		if (ret == 0)
> +			goto err_rb;
>  	}

This doesn't look right, what about undoing the kmalloc directly
above?

Jason
