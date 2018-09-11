Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24375C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B728A2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jYaLz6xs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B728A2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeIKOkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:40:10 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:34276 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbeIKOkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:40:10 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 79E3A57;
        Tue, 11 Sep 2018 11:41:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536658898;
        bh=gr7kutQU4G6xdneXm8vizAHjLSFd0rjug3YQMYxIq4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jYaLz6xswfkYmzbvDLIEOYfHtOGODG3qCNCfiFlzFiIMcLFDaKMOaeFPfpqYvCEgQ
         WcqVUS10iEIyEVbh0ePM2O3KzKY+F5RzeNGqD7gEw24jwvpabz4ovaFzScsjbWPpRr
         OFy6PLdF6be9acwfKEYv4Rogqnq7y0n1I/nO54Ck=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/10] udmabuf: rework limits
Date:   Tue, 11 Sep 2018 12:41:51 +0300
Message-ID: <17673718.7xXiEhCCr5@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180911065921.23818-8-kraxel@redhat.com>
References: <20180911065921.23818-1-kraxel@redhat.com> <20180911065921.23818-8-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd,

Thank you for the patch.

On Tuesday, 11 September 2018 09:59:18 EEST Gerd Hoffmann wrote:
> Create variable for the list length limit.  Serves as documentation,
> also allows to make it a module parameter if needed.
> 
> Also add a total size limit.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/dma-buf/udmabuf.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index 0cf7e85585..cb99a7886a 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -12,6 +12,9 @@
>  #include <linux/shmem_fs.h>
>  #include <linux/udmabuf.h>
> 
> +static int list_limit = 1024;  /* udmabuf_create_list->count limit */
> +static int size_limit_mb = 64; /* total dmabuf size, in megabytes  */

static const int maybe ? Or size_t for the size limit and unsigned int for the 
limit on the number of entries, as they can't be negative ?

Why those specific values ?

>  struct udmabuf {
>  	pgoff_t pagecount;
>  	struct page **pages;
> @@ -123,7 +126,7 @@ static long udmabuf_create(struct const
> udmabuf_create_list *head, struct file *memfd = NULL;
>  	struct udmabuf *ubuf;
>  	struct dma_buf *buf;
> -	pgoff_t pgoff, pgcnt, pgidx, pgbuf;
> +	pgoff_t pgoff, pgcnt, pgidx, pgbuf, pglimit;
>  	struct page *page;
>  	int seals, ret = -EINVAL;
>  	u32 i, flags;
> @@ -132,12 +135,15 @@ static long udmabuf_create(struct const
> udmabuf_create_list *head, if (!ubuf)
>  		return -ENOMEM;
> 
> +	pglimit = (size_limit_mb * 1024 * 1024) >> PAGE_SHIFT;
>  	for (i = 0; i < head->count; i++) {
>  		if (!IS_ALIGNED(list[i].offset, PAGE_SIZE))
>  			goto err_free_ubuf;
>  		if (!IS_ALIGNED(list[i].size, PAGE_SIZE))
>  			goto err_free_ubuf;
>  		ubuf->pagecount += list[i].size >> PAGE_SHIFT;
> +		if (ubuf->pagecount > pglimit)
> +			goto err_free_ubuf;
>  	}
>  	ubuf->pages = kmalloc_array(ubuf->pagecount, sizeof(struct page *),
>  				    GFP_KERNEL);
> @@ -227,7 +233,7 @@ static long udmabuf_ioctl_create_list(struct file *filp,
> unsigned long arg)
> 
>  	if (copy_from_user(&head, (void __user *)arg, sizeof(head)))
>  		return -EFAULT;
> -	if (head.count > 1024)
> +	if (head.count > list_limit)
>  		return -EINVAL;
>  	lsize = sizeof(struct udmabuf_create_item) * head.count;
>  	list = memdup_user((void __user *)(arg + sizeof(head)), lsize);


-- 
Regards,

Laurent Pinchart



