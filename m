Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752733AbeBVHph (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 02:45:37 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35857 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751687AbeBVHpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 02:45:34 -0500
X-Google-Smtp-Source: AH8x225qzwXAfVq9Yx00Fxs6GoKgN76xfee6tQSR+skMBI4OV+kJwKWNvW1fJSQsjn9b1FCek+Yl2w==
Subject: Re: [PATCH 08/20] lightnvm: complete geo structure with maxoc*
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
 <1519205218-26994-9-git-send-email-javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <5e2948ed-19a8-7bd5-6c50-df37a1454d16@lightnvm.io>
Date: Thu, 22 Feb 2018 08:45:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1519205218-26994-9-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/2018 10:26 AM, Javier González wrote:
> Complete the generic geometry structure with the maxoc and maxocpu
> felds, present in the 2.0 spec.
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/nvme/host/lightnvm.c | 4 ++++
>   include/linux/lightnvm.h     | 2 ++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
> index cca32da05316..9c1f8225c4e1 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -318,6 +318,8 @@ static int nvme_nvm_setup_12(struct nvme_nvm_id12 *id,
>   	dev_geo->c.ws_min = sec_per_pg;
>   	dev_geo->c.ws_opt = sec_per_pg;
>   	dev_geo->c.mw_cunits = 8;		/* default to MLC safe values */
> +	dev_geo->c.maxoc = dev_geo->all_luns;	/* default to 1 chunk per LUN */
> +	dev_geo->c.maxocpu = 1;			/* default to 1 chunk per LUN */

One can't assume that it is 1 open chunk per lun. If you need this for 
specific hardware, make a quirk for it.

>   
>   	dev_geo->c.mccap = le32_to_cpu(src->mccap);
>   
> @@ -405,6 +407,8 @@ static int nvme_nvm_setup_20(struct nvme_nvm_id20 *id,
>   	dev_geo->c.ws_min = le32_to_cpu(id->ws_min);
>   	dev_geo->c.ws_opt = le32_to_cpu(id->ws_opt);
>   	dev_geo->c.mw_cunits = le32_to_cpu(id->mw_cunits);
> +	dev_geo->c.maxoc = le32_to_cpu(id->maxoc);
> +	dev_geo->c.maxocpu = le32_to_cpu(id->maxocpu);
>   
>   	dev_geo->c.mccap = le32_to_cpu(id->mccap);
>   
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index ccc5faa63cb7..e1c4292ea33d 100644
> --- a/include/linux/lightnvm.h
> +++ b/include/linux/lightnvm.h
> @@ -215,6 +215,8 @@ struct nvm_common_geo {
>   	u32	ws_min;		/* minimum write size */
>   	u32	ws_opt;		/* optimal write size */
>   	u32	mw_cunits;	/* distance required for successful read */
> +	u32	maxoc;		/* maximum open chunks */
> +	u32	maxocpu;	/* maximum open chunks per parallel unit */
>   
>   	/* device capabilities */
>   	u32	mccap;
> 
