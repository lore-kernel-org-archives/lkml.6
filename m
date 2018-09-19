Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBD3C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7A020858
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hJ2KP+tw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB7A020858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732150AbeISVxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:53:05 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36468 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731230AbeISVxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 17:53:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id b11-v6so2945898pfo.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 09:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cv0Kg9WgYq9n09CHdPKiz3S4O2/4qhSX9t+ATdi+8As=;
        b=hJ2KP+tw+0h6i61qBNbhdbnOm812/oAxaCaj5U0yicpZf5QOE0adGoVY0nli7Zquhk
         MGCjrpivAz0oojzifyPjOEFyFOhaQHPemXxoZgqn45YCI6isMTctjXEQzScTrbKO8+zm
         JjVXXoFoeWhwMZA7vMHOp715ba235K1Yf7O0PweU4xrZ2Aoox180NAXaRHs7BOVr+fzn
         YcvDXqdmRU3Uhha7ZVQPe/Xa9CDiFOo+q4WUJYRYZcayCyql5fRtKI7dVotDhH9omnGL
         ylNiEOw1MJUXO2a2iEfe3uwibIhkzvyZ5+KFFFkibxZ/ZBIEq9De1JYlXfBxvCSOG0bk
         rWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cv0Kg9WgYq9n09CHdPKiz3S4O2/4qhSX9t+ATdi+8As=;
        b=pK4wIaNBsblhMB3qBLkIcTydoc0PM9F2seXNvXIS/DKmWedXcFeqiNEj2iBmjHMm87
         MCkU1LDBJqPJRgBABUMiiZkoW7hPU1/nDoPOtBOg6vJZEnMfASMPGKxbZMEtJza5+xmW
         iNgy9tPOCo54p7WyGOUH1PPwuP/BS/+SvN9T8Io6cy7KIuTAVRHQlT85BPi416Icoiha
         4MTcw01qsrG64cZkP1/d9A3FvtQSQuzVcp+aPowwMMRk0Tmnp1UuZfWfwjdb4WwmKR3i
         +WMe3NturszGCz6lGdVWB2tC+HJXSbtX2Cgsz1ue1jqi6l3YeRZNBuLqKpy0Ds9Qoo9N
         Pw/w==
X-Gm-Message-State: APzg51APDhqoLwArqSPK5J0RORyOEoWBN4cgCcglmK8Enx6BMq6cYnTs
        Ha/fYUaYmUiwNxtfYvgy3rAdJg==
X-Google-Smtp-Source: ANB0VdYXiWyUb+qVKW4AT9Qf76zubnWVUuYqt5JDh+HmyWjhMeJKP9h9+TZqto7Fp+4XTiTiF+ZRcw==
X-Received: by 2002:a62:858c:: with SMTP id m12-v6mr37083764pfk.173.1537373667984;
        Wed, 19 Sep 2018 09:14:27 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id a15-v6sm37893931pfe.32.2018.09.19.09.14.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 09:14:27 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g2f7S-0002aW-Tp; Wed, 19 Sep 2018 10:14:26 -0600
Date:   Wed, 19 Sep 2018 10:14:26 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, parav@mellanox.com,
        danielj@mellanox.com, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH -next] RDMA/core: Properly return the error code of
 rdma_set_src_addr_rcu
Message-ID: <20180919161426.GC9867@ziepe.ca>
References: <20180919122838.28184-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919122838.28184-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 08:28:38PM +0800, YueHaibing wrote:
> rdma_set_src_addr_rcu should check copy_src_l2_addr fails,
> rather than always return 0. Also copy_src_l2_addr should return
> 'ret' as its return value while rdma_translate_ip fails.
> 
> Fixes: c31d4b2ddf07 ("RDMA/core: Protect against changing dst->dev during destination resolve")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Reviewed-by: Parav Pandit <parav@mellanox.com>
> ---
>  drivers/infiniband/core/addr.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Applied to for-next, thanks

> diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
> index 7a0356c..8a31b11 100644
> --- a/drivers/infiniband/core/addr.c
> +++ b/drivers/infiniband/core/addr.c
> @@ -468,7 +468,7 @@ static int addr_resolve_neigh(const struct dst_entry *dst,
>  	return ret;
>  }
>  
> -static void copy_src_l2_addr(struct rdma_dev_addr *dev_addr,
> +static int copy_src_l2_addr(struct rdma_dev_addr *dev_addr,
>  			     const struct sockaddr *dst_in,
>  			     const struct dst_entry *dst,
>  			     const struct net_device *ndev)

I fixed the indenting as Parav pointed out

> @@ -492,6 +492,8 @@ static void copy_src_l2_addr(struct rdma_dev_addr *dev_addr,
>  						RDMA_NETWORK_IPV6;
>  	else
>  		dev_addr->network = RDMA_NETWORK_IB;
> +
> +	return ret;
>  }
>  
>  static int rdma_set_src_addr_rcu(struct rdma_dev_addr *dev_addr,
> @@ -499,6 +501,7 @@ static int rdma_set_src_addr_rcu(struct rdma_dev_addr *dev_addr,
>  				 const struct sockaddr *dst_in,
>  				 const struct dst_entry *dst)
>  {
> +	int ret;
>  	struct net_device *ndev = READ_ONCE(dst->dev);
>  
>  	*ndev_flags = ndev->flags;
> @@ -515,8 +518,8 @@ static int rdma_set_src_addr_rcu(struct rdma_dev_addr *dev_addr,
>  			return -ENODEV;
>  	}
>  
> -	copy_src_l2_addr(dev_addr, dst_in, dst, ndev);
> -	return 0;
> +	ret = copy_src_l2_addr(dev_addr, dst_in, dst, ndev);
> +	return ret;
>  }

And made this just 'return copy_src_l2_addr' without the ret.

Jason
