Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EE9C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E6520839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ss0yHK29"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E6520839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeIKUHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:07:24 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:39886 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbeIKUHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:07:23 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B3966992;
        Tue, 11 Sep 2018 17:07:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536678460;
        bh=ElOR03VVahj/1SMYwOHmmor0N7QxRzJEU3IYjuGvhUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ss0yHK29R6HeWtwkdQHNXMM8VHrSY8MvOkvZcIRij0pLJs8+ZfQ5178SokeMdPAY6
         szOq8udEoc5JOygTE+x101Zpa0xXHKwGDOOzhV2rYi/eMBeOLXvLcsEBDvhiwUFO6I
         WmRppXdqTOk0j272V67P6Znxm2oNKQsfqbQuJNPo=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 12/13] udmabuf: use sizeof(variable) instead of sizeof(type)
Date:   Tue, 11 Sep 2018 18:07:52 +0300
Message-ID: <12710794.bZoXGNj3NF@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180911134216.9760-13-kraxel@redhat.com>
References: <20180911134216.9760-1-kraxel@redhat.com> <20180911134216.9760-13-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd,

Thank you for the patch.

On Tuesday, 11 September 2018 16:42:15 EEST Gerd Hoffmann wrote:
> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/dma-buf/udmabuf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index 7a4fd2194d..92af9b5300 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -128,7 +128,7 @@ static long udmabuf_create(const struct
> udmabuf_create_list *head, int seals, ret = -EINVAL;
>  	u32 i, flags;
> 
> -	ubuf = kzalloc(sizeof(struct udmabuf), GFP_KERNEL);
> +	ubuf = kzalloc(sizeof(*ubuf), GFP_KERNEL);
>  	if (!ubuf)
>  		return -ENOMEM;
> 
> @@ -142,7 +142,7 @@ static long udmabuf_create(const struct
> udmabuf_create_list *head, if (ubuf->pagecount > pglimit)
>  			goto err;
>  	}
> -	ubuf->pages = kmalloc_array(ubuf->pagecount, sizeof(struct page *),
> +	ubuf->pages = kmalloc_array(ubuf->pagecount, sizeof(*ubuf->pages),
>  				    GFP_KERNEL);
>  	if (!ubuf->pages) {
>  		ret = -ENOMEM;
> @@ -211,7 +211,7 @@ static long udmabuf_ioctl_create(struct file *filp,
> unsigned long arg) struct udmabuf_create_item list;
> 
>  	if (copy_from_user(&create, (void __user *)arg,
> -			   sizeof(struct udmabuf_create)))
> +			   sizeof(create)))
>  		return -EFAULT;
> 
>  	head.flags  = create.flags;

-- 
Regards,

Laurent Pinchart



