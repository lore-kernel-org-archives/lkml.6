Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751537AbeE3Ka5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 06:30:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51039 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbeE3Kaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 06:30:55 -0400
X-Google-Smtp-Source: ADUXVKKn8UqvQ16fD+Jzekm4dHiGccaVnmGc4PGvwkfogPXlchunv2GNNbQrTuI/M1oI6WPUEVU3GQ==
Date: Wed, 30 May 2018 12:30:51 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK"
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK"
        <linaro-mm-sig@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma-buf: make map_atomic and map function pointers
 optional
Message-ID: <20180530103051.GK3438@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20180529135918.19729-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529135918.19729-1-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.15.0-3-amd64 
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 03:59:18PM +0200, Gerd Hoffmann wrote:
> So drivers don't need dummy functions just returning NULL.
> 
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Please push to drm-misc-next (maybe after a few more days of waiting for
feedback).
-Daniel

> ---
>  include/linux/dma-buf.h   | 4 ++--
>  drivers/dma-buf/dma-buf.c | 4 ++++
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index 085db2fee2..88917fa796 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -39,12 +39,12 @@ struct dma_buf_attachment;
>  
>  /**
>   * struct dma_buf_ops - operations possible on struct dma_buf
> - * @map_atomic: maps a page from the buffer into kernel address
> + * @map_atomic: [optional] maps a page from the buffer into kernel address
>   *		space, users may not block until the subsequent unmap call.
>   *		This callback must not sleep.
>   * @unmap_atomic: [optional] unmaps a atomically mapped page from the buffer.
>   *		  This Callback must not sleep.
> - * @map: maps a page from the buffer into kernel address space.
> + * @map: [optional] maps a page from the buffer into kernel address space.
>   * @unmap: [optional] unmaps a page from the buffer.
>   * @vmap: [optional] creates a virtual mapping for the buffer into kernel
>   *	  address space. Same restrictions as for vmap and friends apply.
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index d78d5fc173..4c45e31258 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -872,6 +872,8 @@ void *dma_buf_kmap_atomic(struct dma_buf *dmabuf, unsigned long page_num)
>  {
>  	WARN_ON(!dmabuf);
>  
> +	if (!dmabuf->ops->map_atomic)
> +		return NULL;
>  	return dmabuf->ops->map_atomic(dmabuf, page_num);
>  }
>  EXPORT_SYMBOL_GPL(dma_buf_kmap_atomic);
> @@ -907,6 +909,8 @@ void *dma_buf_kmap(struct dma_buf *dmabuf, unsigned long page_num)
>  {
>  	WARN_ON(!dmabuf);
>  
> +	if (!dmabuf->ops->map)
> +		return NULL;
>  	return dmabuf->ops->map(dmabuf, page_num);
>  }
>  EXPORT_SYMBOL_GPL(dma_buf_kmap);
> -- 
> 2.9.3
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
