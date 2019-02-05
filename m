Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCCDC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D91218AD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bsWGEWD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbfBEWgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:36:10 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37558 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbfBEWgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:36:10 -0500
Received: by mail-pf1-f195.google.com with SMTP id y126so2173810pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 14:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YqWUV7e+M52JJzs1PwZF3J3z2/dNFHCiZnzWEZ+6hME=;
        b=bsWGEWD0KZ8FgO4p3iorJ8McflZYLbBt4FVBou0lGELr4mDROXm7lEoLCSZezuGF/L
         D8TQWVHjkVbZmWfRO/yBFRaEUytDfBys1ic51tXgaDlVJ9XPLI4Rr6iwMJkxgWskUQ0l
         6YX8Cq4Msm4qbVjpYookWJD2/6M0Ryio46ITodIz3444gN9DEfMSC9YUiDHbRVEr2wVZ
         ndCqIE7SYhnjKgn+55dZi6m7JaQ2Z2gGPKo5E38uZe+LHz4jfMoFgyd8Fp25s10ZO1pb
         NIKKunn0ri1Umlb4EvfamyJCuwJQURnhCDNWbJ06KKQFyEb1kGSokcBrec1CheJ1VEn6
         pj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YqWUV7e+M52JJzs1PwZF3J3z2/dNFHCiZnzWEZ+6hME=;
        b=YNqAoRfZB6j38xWxRyUOBnSu8Rkon24y5iRiNxwOZBDY1IT9bWfGLGt/2JVfJcxTst
         K/TPl9+QkkLLu0ZTjURxUVcRnRAY0edmddhxlVel1CFAhVULjPPxD96nkGTTRHT9GnmE
         VRTZ48m3tPUg89kD9M+UU7M6Na68hB1I5piDeIF6Z/UWBXnpbpgVNCbGti6Ra1/4tnE4
         nGrMqtq8eBIxO4E9LO33jua6CHvWU4VF6lR2kdlz15XHTEUSH3JmlH3/wSSTB/bTzXWC
         Wi1pBM7ZfCiHQHKtIoAu2YLVNWCWlLYE5I6k9CliTsfSDtu3HjKn4Yd+eygPWINqBSIl
         7IyA==
X-Gm-Message-State: AHQUAua4gGq4oqCF3cGdTIN2kEP+1twd0NSSaOFrDPeZmJIEGGJy5Clq
        rQrYDf7SuKFV3gG9dpMw9UXiKg==
X-Google-Smtp-Source: AHgI3Iaj71FskjLIinbNIO1CYfl1S09wOGbEor4isEI/M+0BIeA2W3TzrGTE7bpMPLMA8zvBJqratw==
X-Received: by 2002:a62:28c9:: with SMTP id o192mr7477569pfo.57.1549406169252;
        Tue, 05 Feb 2019 14:36:09 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id f6sm190708pfc.88.2019.02.05.14.36.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 14:36:08 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gr9K4-00061t-5l; Tue, 05 Feb 2019 15:36:08 -0700
Date:   Tue, 5 Feb 2019 15:36:08 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org,
        Jack Morgenstein <jackm@dev.mellanox.co.il>
Subject: Re: [PATCH] mlx4_ib: Increase the timeout for CM cache
Message-ID: <20190205223608.GA23110@ziepe.ca>
References: <20190131170951.178676-1-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190131170951.178676-1-haakon.bugge@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 06:09:51PM +0100, Håkon Bugge wrote:
> Using CX-3 virtual functions, either from a bare-metal machine or
> pass-through from a VM, MAD packets are proxied through the PF driver.
> 
> Since the VMs have separate name spaces for MAD Transaction Ids
> (TIDs), the PF driver has to re-map the TIDs and keep the book keeping
> in a cache.
> 
> Following the RDMA CM protocol, it is clear when an entry has to
> evicted form the cache. But life is not perfect, remote peers may die
> or be rebooted. Hence, it's a timeout to wipe out a cache entry, when
> the PF driver assumes the remote peer has gone.
> 
> We have experienced excessive amount of DREQ retries during fail-over
> testing, when running with eight VMs per database server.
> 
> The problem has been reproduced in a bare-metal system using one VM
> per physical node. In this environment, running 256 processes in each
> VM, each process uses RDMA CM to create an RC QP between himself and
> all (256) remote processes. All in all 16K QPs.
> 
> When tearing down these 16K QPs, excessive DREQ retries (and
> duplicates) are observed. With some cat/paste/awk wizardry on the
> infiniband_cm sysfs, we observe:
> 
>       dreq:       5007
> cm_rx_msgs:
>       drep:       3838
>       dreq:      13018
>        rep:       8128
>        req:       8256
>        rtu:       8256
> cm_tx_msgs:
>       drep:       8011
>       dreq:      68856
>        rep:       8256
>        req:       8128
>        rtu:       8128
> cm_tx_retries:
>       dreq:      60483
> 
> Note that the active/passive side is distributed.
> 
> Enabling pr_debug in cm.c gives tons of:
> 
> [171778.814239] <mlx4_ib> mlx4_ib_multiplex_cm_handler: id{slave:
> 1,sl_cm_id: 0xd393089f} is NULL!
> 
> By increasing the CM_CLEANUP_CACHE_TIMEOUT from 5 to 30 seconds, the
> tear-down phase of the application is reduced from 113 to 67
> seconds. Retries/duplicates are also significantly reduced:
> 
> cm_rx_duplicates:
>       dreq:       7726
> []
> cm_tx_retries:
>       drep:          1
>       dreq:       7779
> 
> Increasing the timeout further didn't help, as these duplicates and
> retries stem from a too short CMA timeout, which was 20 (~4 seconds)
> on the systems. By increasing the CMA timeout to 22 (~17 seconds), the
> numbers fell down to about one hundred for both of them.
> 
> Adjustment of the CMA timeout is _not_ part of this commit.
> 
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> ---
>  drivers/infiniband/hw/mlx4/cm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Jack? What do you think?

> diff --git a/drivers/infiniband/hw/mlx4/cm.c b/drivers/infiniband/hw/mlx4/cm.c
> index fedaf8260105..8c79a480f2b7 100644
> --- a/drivers/infiniband/hw/mlx4/cm.c
> +++ b/drivers/infiniband/hw/mlx4/cm.c
> @@ -39,7 +39,7 @@
>  
>  #include "mlx4_ib.h"
>  
> -#define CM_CLEANUP_CACHE_TIMEOUT  (5 * HZ)
> +#define CM_CLEANUP_CACHE_TIMEOUT  (30 * HZ)
>  
>  struct id_map_entry {
>  	struct rb_node node;
> -- 
> 2.20.1
> 
