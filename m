Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757870AbeDXNNQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:13:16 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54269 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757531AbeDXNNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:13:13 -0400
X-Google-Smtp-Source: AIpwx4/IbfC3JkB1kw6XiGosu3dhN0EVG/AHo+pdixLqQRn6cmo824qUCTSxwdmpQ6AQP33jIGudgg==
Date: Tue, 24 Apr 2018 15:13:09 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Eric Anholt <eric@anholt.net>
Cc: dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] drm: Make the prime vmap/vunmap hooks optional.
Message-ID: <20180424131309.GE31310@phenom.ffwll.local>
Mail-Followup-To: Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180424004610.4637-1-eric@anholt.net>
 <20180424004610.4637-2-eric@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424004610.4637-2-eric@anholt.net>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 05:46:08PM -0700, Eric Anholt wrote:
> Some drivers leave these unimplemented, so don't make them have
> unimplemented stubs.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/drm_prime.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index caf675e3e692..397b46b33739 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -409,7 +409,10 @@ void *drm_gem_dmabuf_vmap(struct dma_buf *dma_buf)
>  	struct drm_gem_object *obj = dma_buf->priv;
>  	struct drm_device *dev = obj->dev;
>  
> -	return dev->driver->gem_prime_vmap(obj);
> +	if (dev->driver->gem_prime_vmap)
> +		return dev->driver->gem_prime_vmap(obj);
> +	else
> +		return NULL;
>  }
>  EXPORT_SYMBOL(drm_gem_dmabuf_vmap);
>  
> @@ -426,7 +429,8 @@ void drm_gem_dmabuf_vunmap(struct dma_buf *dma_buf, void *vaddr)
>  	struct drm_gem_object *obj = dma_buf->priv;
>  	struct drm_device *dev = obj->dev;
>  
> -	dev->driver->gem_prime_vunmap(obj, vaddr);
> +	if (dev->driver->gem_prime_vunmap)
> +		dev->driver->gem_prime_vunmap(obj, vaddr);
>  }
>  EXPORT_SYMBOL(drm_gem_dmabuf_vunmap);
>  
> -- 
> 2.17.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
