Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967456AbeCAKdN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 05:33:13 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40843 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966117AbeCAKdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 05:33:09 -0500
X-Google-Smtp-Source: AG47ELvPtvPz0DEH6sQsduWYBCKQuLStF4lVv4w452JAJEHB7ty1MXyg6uZo0ei1WKZjGVB9amm4Sg==
Subject: Re: [PATCH 02/15] lightnvm: add controller capabilities to 2.0
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
References: <1519832975-25432-1-git-send-email-javier@cnexlabs.com>
 <1519832975-25432-3-git-send-email-javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <e435dd71-a83d-1888-0e1b-cd1b62181e4c@lightnvm.io>
Date: Thu, 1 Mar 2018 11:33:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1519832975-25432-3-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/28/2018 04:49 PM, Javier González wrote:
> Assign missing mccap value on 2.0 path
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/nvme/host/lightnvm.c | 4 +++-
>   include/linux/lightnvm.h     | 8 +++++---
>   2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
> index e276ace28c64..5b2024ebac76 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -318,7 +318,7 @@ static int nvme_nvm_setup_12(struct nvme_nvm_id12 *id,
>   	geo->ws_opt = sec_per_pg;
>   	geo->mw_cunits = geo->ws_opt << 3;	/* default to MLC safe values */
>   
> -	geo->mccap = le32_to_cpu(src->mccap);
> +	geo->cap = le32_to_cpu(src->mccap);
>   
>   	geo->trdt = le32_to_cpu(src->trdt);
>   	geo->trdm = le32_to_cpu(src->trdm);
> @@ -396,6 +396,8 @@ static int nvme_nvm_setup_20(struct nvme_nvm_id20 *id,
>   	geo->ws_opt = le32_to_cpu(id->ws_opt);
>   	geo->mw_cunits = le32_to_cpu(id->mw_cunits);
>   
> +	geo->cap = le32_to_cpu(id->mccap);
> +
>   	geo->trdt = le32_to_cpu(id->trdt);
>   	geo->trdm = le32_to_cpu(id->trdm);
>   	geo->tprt = le32_to_cpu(id->twrt);
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index 16255fcd5250..b9f0d2070de9 100644
> --- a/include/linux/lightnvm.h
> +++ b/include/linux/lightnvm.h
> @@ -288,8 +288,10 @@ struct nvm_geo {
>   	u32	ws_opt;		/* optimal write size */
>   	u32	mw_cunits;	/* distance required for successful read */
>   
> -	/* device capabilities */
> -	u32	mccap;
> +	/* device capabilities. Note that this represents capabilities in 1.2
> +	 * and media and controller capabilities in 2.0
> +	 */
> +	u32	cap;

Here is a list of capabilities:

1.2
Bad block mgmt
Hybrid command support

2.0

Vector copy
Double reset

The way I was thinking it would be implemented is to split the upper cap 
bits to 2.0, and let the lower bits be reserved for 1.2.

Such that one would define the following:

enum {
	NVM_CAP_BBM 	1 << 0;
	NVM_CAP_HCS 	1 << 1;

	NVM_CAP_VCPY 	1 << 16;
	NVM_CAP_DRST	1 << 17;
};

That way, the assignment from 2.0 can easily be done with cap = 
le32_to_cpu(id->mccap) << 16;

and targets and other don't need to understand the difference between 
1.2 and 2.0 format.
>   
>   	/* device timings */
>   	u32	trdt;		/* Avg. Tread (ns) */
> @@ -304,7 +306,7 @@ struct nvm_geo {
>   
>   	/* 1.2 compatibility */
>   	u8	vmnt;
> -	u32	cap;
> +	u32	mccap;
>   	u32	dom;
>   
>   	u8	mtype;
> 
