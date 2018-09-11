Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5ECC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF9820839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Y2tFOjwR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF9820839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeIKOgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:36:06 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:34166 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeIKOgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:36:06 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 991DF57;
        Tue, 11 Sep 2018 11:37:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536658655;
        bh=/UBCdpGLbMGSIDo/6Piw+bBcZ3lAVdT5+LbrkiUzrG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y2tFOjwRk69uENpuY15K798vwezIxCArLWhwoni1lYxHlZjcX1ZpZBo9D3q02+vtg
         qU8j8eRd3jD2WmZMYlTuJ3AjKavYC8jwMr8X2ooAL0T5487Rd+MbnRncCRFUEfxRyB
         57mEUdTiOKDcdtkdugc94NoN/IZ4uD/1+/MQuKL8=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/10] udmabuf: improve map_udmabuf error handling
Date:   Tue, 11 Sep 2018 12:37:48 +0300
Message-ID: <2321736.6fDm34KxGD@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180911065921.23818-3-kraxel@redhat.com>
References: <20180911065921.23818-1-kraxel@redhat.com> <20180911065921.23818-3-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd,

Thank you for the patch.

On Tuesday, 11 September 2018 09:59:13 EEST Gerd Hoffmann wrote:

A commit message would be nice, for all patches in this series.

> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/dma-buf/udmabuf.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index e63d301bcb..19bd918209 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -51,25 +51,24 @@ static struct sg_table *map_udmabuf(struct
> dma_buf_attachment *at, {
>  	struct udmabuf *ubuf = at->dmabuf->priv;
>  	struct sg_table *sg;
> +	int ret;
> 
>  	sg = kzalloc(sizeof(*sg), GFP_KERNEL);
>  	if (!sg)
> -		goto err1;
> -	if (sg_alloc_table_from_pages(sg, ubuf->pages, ubuf->pagecount,
> -				      0, ubuf->pagecount << PAGE_SHIFT,
> -				      GFP_KERNEL) < 0)
> -		goto err2;
> +		return ERR_PTR(-ENOMEM);
> +	ret = sg_alloc_table_from_pages(sg, ubuf->pages, ubuf->pagecount,
> +					0, ubuf->pagecount << PAGE_SHIFT,
> +					GFP_KERNEL);
> +	if (ret < 0)
> +		goto err;
>  	if (!dma_map_sg(at->dev, sg->sgl, sg->nents, direction))
> -		goto err3;
> -
> +		goto err;
>  	return sg;
> 
> -err3:
> +err:
>  	sg_free_table(sg);
> -err2:
>  	kfree(sg);
> -err1:
> -	return ERR_PTR(-ENOMEM);
> +	return ERR_PTR(ret);
>  }
> 
>  static void unmap_udmabuf(struct dma_buf_attachment *at,

-- 
Regards,

Laurent Pinchart



