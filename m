Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B89C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4E920839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="OYqiF/GK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C4E920839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeIKOkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:40:40 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:34302 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeIKOkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:40:40 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E24AF57;
        Tue, 11 Sep 2018 11:42:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536658928;
        bh=iNO2IvUsHUt6afzZNJ3haf1GP1ZrJiPl8hPupoaKkRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OYqiF/GKuE9dvMz8evIVTH59tsL3T5GAXrIT3gRryHmBUFXAdxbYyiJDMs7cSw8qu
         5ZiNh5RzN1svzqSqua0PqJ064Xa1hn+KHa15qP9k/IcGXDoA7N1Lsr7GL6e5h3iaZy
         ZyIM0PIhHG2LHZFVj+PvqiqHzQjI1cnrHDuBgjxA=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/10] udmabuf: improve udmabuf_create error handling
Date:   Tue, 11 Sep 2018 12:42:20 +0300
Message-ID: <1927005.QJR53qTIv0@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180911065921.23818-9-kraxel@redhat.com>
References: <20180911065921.23818-1-kraxel@redhat.com> <20180911065921.23818-9-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd,

Thank you for the patch.

On Tuesday, 11 September 2018 09:59:19 EEST Gerd Hoffmann wrote:
> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/dma-buf/udmabuf.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index cb99a7886a..ec46513a47 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -126,7 +126,7 @@ static long udmabuf_create(struct const
> udmabuf_create_list *head, struct file *memfd = NULL;
>  	struct udmabuf *ubuf;
>  	struct dma_buf *buf;
> -	pgoff_t pgoff, pgcnt, pgidx, pgbuf, pglimit;
> +	pgoff_t pgoff, pgcnt, pgidx, pgbuf = 0, pglimit;
>  	struct page *page;
>  	int seals, ret = -EINVAL;
>  	u32 i, flags;
> @@ -138,32 +138,32 @@ static long udmabuf_create(struct const
> udmabuf_create_list *head, pglimit = (size_limit_mb * 1024 * 1024) >>
> PAGE_SHIFT;
>  	for (i = 0; i < head->count; i++) {
>  		if (!IS_ALIGNED(list[i].offset, PAGE_SIZE))
> -			goto err_free_ubuf;
> +			goto err;
>  		if (!IS_ALIGNED(list[i].size, PAGE_SIZE))
> -			goto err_free_ubuf;
> +			goto err;
>  		ubuf->pagecount += list[i].size >> PAGE_SHIFT;
>  		if (ubuf->pagecount > pglimit)
> -			goto err_free_ubuf;
> +			goto err;
>  	}
>  	ubuf->pages = kmalloc_array(ubuf->pagecount, sizeof(struct page *),
>  				    GFP_KERNEL);
>  	if (!ubuf->pages) {
>  		ret = -ENOMEM;
> -		goto err_free_ubuf;
> +		goto err;
>  	}
> 
>  	pgbuf = 0;
>  	for (i = 0; i < head->count; i++) {
>  		memfd = fget(list[i].memfd);
>  		if (!memfd)
> -			goto err_put_pages;
> +			goto err;
>  		if (!shmem_mapping(file_inode(memfd)->i_mapping))
> -			goto err_put_pages;
> +			goto err;
>  		seals = memfd_fcntl(memfd, F_GET_SEALS, 0);
>  		if (seals == -EINVAL ||
>  		    (seals & SEALS_WANTED) != SEALS_WANTED ||
>  		    (seals & SEALS_DENIED) != 0)
> -			goto err_put_pages;
> +			goto err;
>  		pgoff = list[i].offset >> PAGE_SHIFT;
>  		pgcnt = list[i].size   >> PAGE_SHIFT;
>  		for (pgidx = 0; pgidx < pgcnt; pgidx++) {
> @@ -171,13 +171,13 @@ static long udmabuf_create(struct const
> udmabuf_create_list *head, file_inode(memfd)->i_mapping, pgoff + pgidx);
>  			if (IS_ERR(page)) {
>  				ret = PTR_ERR(page);
> -				goto err_put_pages;
> +				goto err;
>  			}
>  			ubuf->pages[pgbuf++] = page;
>  		}
>  		fput(memfd);
> +		memfd = NULL;
>  	}
> -	memfd = NULL;
> 
>  	exp_info.ops  = &udmabuf_ops;
>  	exp_info.size = ubuf->pagecount << PAGE_SHIFT;
> @@ -186,7 +186,7 @@ static long udmabuf_create(struct const
> udmabuf_create_list *head, buf = dma_buf_export(&exp_info);
>  	if (IS_ERR(buf)) {
>  		ret = PTR_ERR(buf);
> -		goto err_put_pages;
> +		goto err;
>  	}
> 
>  	flags = 0;
> @@ -194,10 +194,9 @@ static long udmabuf_create(struct const
> udmabuf_create_list *head, flags |= O_CLOEXEC;
>  	return dma_buf_fd(buf, flags);
> 
> -err_put_pages:
> +err:
>  	while (pgbuf > 0)
>  		put_page(ubuf->pages[--pgbuf]);
> -err_free_ubuf:
>  	if (memfd)
>  		fput(memfd);
>  	kfree(ubuf->pages);


-- 
Regards,

Laurent Pinchart



