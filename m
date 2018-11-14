Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44463C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE5E21780
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:04:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE5E21780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733084AbeKOBIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:08:09 -0500
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:41506 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728125AbeKOBII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:08:08 -0500
Received: from [IPv6:2001:420:44c1:2579:94da:698d:8319:4499] ([IPv6:2001:420:44c1:2579:94da:698d:8319:4499])
        by smtp-cloud8.xs4all.net with ESMTPA
        id MwiJgl12y9VdZMwiNgNfMS; Wed, 14 Nov 2018 16:04:31 +0100
Subject: Re: [PATCH][staging-next] drivers: staging: cedrus: find ctx before
 dereferencing it ctx
To:     Colin King <colin.king@canonical.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181102190126.5628-1-colin.king@canonical.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <c54b52b2-c0b2-6afc-ad35-bbf396650418@xs4all.nl>
Date:   Wed, 14 Nov 2018 16:04:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181102190126.5628-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCJLZfHhTiKd4QB0LaTp/CK7JZN7cYHok1JuL1h0vDbrjPHji9bR9z4ZxpcPff7iueTgL2NbdQsVCuvhiWQBff6YMGzZw6gQe+3jcu5yURmOopwvDmCQ
 +MCP2boET6Mq3SJZeapTpr9GJ4/TE8/2Hixvw+577eldVMATUueQqwjCDiIz8uSUvaEKYlYURRKogdU7VaUP5yJ5BtOXB5Uj8P9rKZY/XxqQZHD+ZYPLM3ps
 pj3fOF5zO3wBo65lyp3d7yNlkcVZ9F39Q2RVrpvUnHe4XupMoT6wwCEDd3a+x/LeyLFGiCrH41jFIFvotiR6KIsM0p2MNfaM+eMgS4iLLC14ViWSg5KL+zVt
 MUMq3krlNNXJEq8RiKgbfo8n9onPjIZJVrj/koge8QvCZEX1g2Sg4/L7YRaVOxgkz1VB+IKlyU9KMCb885Q4CKJ7d2+Lg99jFg/rR50sDdAKAqG76rpPlgcf
 mEOi2GWRlhqliSnLkflQzd990s1xaUebwA+Uga3Kx7WrA/EcvXJbpIqcxthw+d0Xp4zO19i1yuV6CVCkYFy2q0l9DGw4TOH/oYHcZYSN19IChTAPPxehN3Ky
 NSQ+j7/mcjpG3NgUraeQCcpauuUv2tbHYWUygRFz5W5tLBYLissO7clhhsAsRi4ukNkvajNdNLYDJRZcVrmELtYf
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/18 20:01, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently if count is an invalid value the v4l2_info message will
> dereference a null ctx pointer to get the dev information. Fix
> this by finding ctx first and then checking for an invalid count,
> this way ctxt will be non-null hence avoiding the null pointer
> dereference.
> 
> Detected by CoverityScan, CID#1475337 ("Explicit null dereferenced")
> 
> Fixes: 50e761516f2b ("media: platform: Add Cedrus VPU decoder driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/staging/media/sunxi/cedrus/cedrus.c | 22 ++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
> index 82558455384a..699d62dceb6c 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
> @@ -108,17 +108,6 @@ static int cedrus_request_validate(struct media_request *req)
>  	unsigned int count;
>  	unsigned int i;
>  
> -	count = vb2_request_buffer_cnt(req);
> -	if (!count) {
> -		v4l2_info(&ctx->dev->v4l2_dev,
> -			  "No buffer was provided with the request\n");
> -		return -ENOENT;
> -	} else if (count > 1) {
> -		v4l2_info(&ctx->dev->v4l2_dev,
> -			  "More than one buffer was provided with the request\n");
> -		return -EINVAL;
> -	}
> -
>  	list_for_each_entry(obj, &req->objects, list) {
>  		struct vb2_buffer *vb;
>  
> @@ -133,6 +122,17 @@ static int cedrus_request_validate(struct media_request *req)
>  	if (!ctx)
>  		return -ENOENT;
>  
> +	count = vb2_request_buffer_cnt(req);
> +	if (!count) {
> +		v4l2_info(&ctx->dev->v4l2_dev,
> +			  "No buffer was provided with the request\n");
> +		return -ENOENT;
> +	} else if (count > 1) {
> +		v4l2_info(&ctx->dev->v4l2_dev,
> +			  "More than one buffer was provided with the request\n");
> +		return -EINVAL;
> +	}
> +

Is this right? If there are no buffers in the request, then the list_for_each_entry()
loop won't find a ctx either. This needs to be done differently: for these initial
v4l2_info() statements you can get the cedrus_dev struct from req->mdev since the
media_device is embedded in the cedrus_dev struct. In other words, some
container_of magic is needed here.

Regards,

	Hans

>  	parent_hdl = &ctx->hdl;
>  
>  	hdl = v4l2_ctrl_request_hdl_find(req, parent_hdl);
> 

