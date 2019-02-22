Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF17AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B7E2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dGUqxSP6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfBVQgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 11:36:40 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36788 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfBVQgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 11:36:39 -0500
Received: by mail-pl1-f196.google.com with SMTP id k2so1337269plt.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 08:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VVI9TnTRHi+CNtlEg3vY4NAsyd9DiWZgYXZLx/QwrJs=;
        b=dGUqxSP6kL1/3PenkjRrREV1U7J2k9QUdRpS3GYK+uVuXawwGgn8mIGev7VigZfsPs
         I/vjzAHdHmnksC0SBPwzQM9hfMXytNlqPhCVAbTpUrXG+q+y6kpoZEUI5X73Yvl+WQxO
         RVxD6B4F4MsUB5x+Tyh2kTACKyGW/ZgDnPUlgG2E9N/6WgL0wgJPFoEM8z2tqrQdqgcn
         H6jScX7NwuwZ0KHZPBLe4KUulYE6LDgYJjImd0rhdvv4qAkShDP9YA0K1K2iXYVexdLY
         NtC5MGffmrqqfw/P5LvIs9wg8qQJHtQsJzXI0eVsZ62bgYbRB9w8iJ+a1Zm8euflIQbX
         k2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VVI9TnTRHi+CNtlEg3vY4NAsyd9DiWZgYXZLx/QwrJs=;
        b=UqiAH5WgOoNFyczbsBY9S9w/rZ6HOFowVNHvV7HRYiM8KvtZPSYAoqb/MrtX0T7ysr
         2Ic0q61wpdOvPHDaskFcFzDVe9TqwdN6Lja0meUGU5EPxRgbCbAlb50Pk6dUKWsc6hWs
         oj8FE0Tz454cuVvaE93Ml/zHMKE/+EHZfe/b+gp/Wc1tDG05xRx++QTeb/XJeqKY+aoR
         eE4ZL3/InMCEdx1LFDvVZdI2G2qA78b600CYe22GKZEQWqTYz0c+LLJKgay0H5c4k0vz
         /idgaU6Hb0mUnxDSLtdtnnYYr48rvHB925QU/+6Jr5/dsYZOjkep6+FanborPKwgQ0uC
         BJZw==
X-Gm-Message-State: AHQUAuYX2GLG/0Mm5J5kwFYcnlztJUh0eTyl7thn6x2xN1w7d1gaMj5e
        0yuC4qJS8I7hbxOG7qE104kMww==
X-Google-Smtp-Source: AHgI3IZ8pWP2t2foieBx5rMuWzPBpgfM8+zDTWMvmhX1PLJqFaHMyAHMd9E8KCCuoD+mAovH7Hak9A==
X-Received: by 2002:a17:902:2bc9:: with SMTP id l67mr5052023plb.241.1550853399072;
        Fri, 22 Feb 2019 08:36:39 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id b6sm3276869pfo.27.2019.02.22.08.36.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 08:36:38 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gxDoT-0002Yq-Qa; Fri, 22 Feb 2019 09:36:37 -0700
Date:   Fri, 22 Feb 2019 09:36:37 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/cma: Make CM response timeout and # CM retries
 configurable
Message-ID: <20190222163637.GA9819@ziepe.ca>
References: <20190217170909.1178575-1-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190217170909.1178575-1-haakon.bugge@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2019 at 06:09:09PM +0100, Håkon Bugge wrote:
> During certain workloads, the default CM response timeout is too
> short, leading to excessive retries. Hence, make it configurable
> through sysctl. While at it, also make number of CM retries
> configurable.
> 
> The defaults are not changed.
> 
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
>  drivers/infiniband/core/cma.c | 51 ++++++++++++++++++++++++++++++-----
>  1 file changed, 44 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index c43512752b8a..ce99e1cd1029 100644
> +++ b/drivers/infiniband/core/cma.c
> @@ -43,6 +43,7 @@
>  #include <linux/inetdevice.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> +#include <linux/sysctl.h>
>  #include <net/route.h>
>  
>  #include <net/net_namespace.h>
> @@ -68,13 +69,46 @@ MODULE_AUTHOR("Sean Hefty");
>  MODULE_DESCRIPTION("Generic RDMA CM Agent");
>  MODULE_LICENSE("Dual BSD/GPL");
>  
> -#define CMA_CM_RESPONSE_TIMEOUT 20
>  #define CMA_QUERY_CLASSPORT_INFO_TIMEOUT 3000
> -#define CMA_MAX_CM_RETRIES 15
>  #define CMA_CM_MRA_SETTING (IB_CM_MRA_FLAG_DELAY | 24)
>  #define CMA_IBOE_PACKET_LIFETIME 18
>  #define CMA_PREFERRED_ROCE_GID_TYPE IB_GID_TYPE_ROCE_UDP_ENCAP
>  
> +#define CMA_DFLT_CM_RESPONSE_TIMEOUT 20
> +static int cma_cm_response_timeout = CMA_DFLT_CM_RESPONSE_TIMEOUT;
> +static int cma_cm_response_timeout_min = 8;
> +static int cma_cm_response_timeout_max = 31;
> +#undef CMA_DFLT_CM_RESPONSE_TIMEOUT
> +
> +#define CMA_DFLT_MAX_CM_RETRIES 15
> +static int cma_max_cm_retries = CMA_DFLT_MAX_CM_RETRIES;
> +static int cma_max_cm_retries_min = 1;
> +static int cma_max_cm_retries_max = 100;
> +#undef CMA_DFLT_MAX_CM_RETRIES
> +
> +static struct ctl_table_header *cma_ctl_table_hdr;
> +static struct ctl_table cma_ctl_table[] = {
> +	{
> +		.procname	= "cma_cm_response_timeout",
> +		.data		= &cma_cm_response_timeout,
> +		.maxlen		= sizeof(cma_cm_response_timeout),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= &cma_cm_response_timeout_min,
> +		.extra2		= &cma_cm_response_timeout_max,
> +	},
> +	{
> +		.procname	= "cma_max_cm_retries",
> +		.data		= &cma_max_cm_retries,
> +		.maxlen		= sizeof(cma_max_cm_retries),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= &cma_max_cm_retries_min,
> +		.extra2		= &cma_max_cm_retries_max,
> +	},
> +	{ }
> +};

Is sysctl the right approach here? Should it be rdma tool instead?

Jason
