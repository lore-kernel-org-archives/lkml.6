Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753347AbeDQMMP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 08:12:15 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37097 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753122AbeDQMMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 08:12:10 -0400
X-Google-Smtp-Source: AIpwx4+Kc3/GSlt/JGKnZCWLbebSyfieb2liv1pDT6+QHPoC8nu3tmICDrdEIvMIoU1cQDuGNZ1EgA==
Subject: Re: [PATCH 07/11] lightnvm: pblk: remove unnecessary indirection
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
References: <1523874332-6272-1-git-send-email-javier@cnexlabs.com>
 <1523874332-6272-8-git-send-email-javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <62002f4f-bfca-03be-c54f-23b15223446b@lightnvm.io>
Date: Tue, 17 Apr 2018 14:11:54 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523874332-6272-8-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/18 12:25 PM, Javier González wrote:
> Remove unnecessary indirection on the read path.
> 

Title and description are the same. Can you elaborate what changed since 
pblk_submit_io now directly can be returned, and doesn't have its return 
value rewritten to NVM_IO_ERR?

> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-read.c | 12 +-----------
>   1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
> index 89aed634333a..2f8224354c62 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -102,16 +102,6 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
>   #endif
>   }
>   
> -static int pblk_submit_read_io(struct pblk *pblk, struct nvm_rq *rqd)
> -{
> -	int err;
> -
> -	err = pblk_submit_io(pblk, rqd);
> -	if (err)
> -		return NVM_IO_ERR;
> -
> -	return NVM_IO_OK;
> -}
>   
>   static void pblk_read_check_seq(struct pblk *pblk, struct nvm_rq *rqd,
>   				sector_t blba)
> @@ -485,7 +475,7 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
>   		rqd->bio = int_bio;
>   		r_ctx->private = bio;
>   
> -		ret = pblk_submit_read_io(pblk, rqd);
> +		ret = pblk_submit_io(pblk, rqd);
>   		if (ret) {
>   			pr_err("pblk: read IO submission failed\n");
>   			if (int_bio)
> 
