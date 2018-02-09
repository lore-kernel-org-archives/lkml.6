Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751424AbeBIMTG convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 07:19:06 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:62288 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751005AbeBIMTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 07:19:04 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Shreeya Patel <shreeya.patel23498@gmail.com>, daniel@ffwll.ch,
        airlied@redhat.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, seanpaul@chromium.org
From: Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <1518178256-17157-1-git-send-email-shreeya.patel23498@gmail.com>
Cc: "Shreeya Patel" <shreeya.patel23498@gmail.com>
References: <1518178256-17157-1-git-send-email-shreeya.patel23498@gmail.com>
Message-ID: <151817873639.28809.8475696517820926336@mail.alporthouse.com>
User-Agent: alot/0.3.6
Subject: Re: [PATCH] gpu/drm/udl: Replace struct_mutex with driver private lock
Date: Fri, 09 Feb 2018 12:18:56 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Shreeya Patel (2018-02-09 12:10:56)
> dev->struct_mutex is the Big DRM Lock and the only bit where
> it’s mandatory is serializing GEM buffer object destruction.
> Which unfortunately means drivers have to keep track of that
> lock and either call unreference or unreference_locked
> depending upon context. Core GEM doesn’t have a need for
> struct_mutex any more since kernel 4.8.
> 
> For drivers that need struct_mutex it should be replaced by a driver
> private lock.

In that regard, dev->struct_mutex is already a driver private lock. The
impetus is to reduce a big lock into lots of little locks where
contention deems prudent.

> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> ---
>  drivers/gpu/drm/udl/udl_dmabuf.c | 5 +++--
>  drivers/gpu/drm/udl/udl_drv.h    | 1 +
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/udl/udl_dmabuf.c b/drivers/gpu/drm/udl/udl_dmabuf.c
> index 2867ed1..120d2d9 100644
> --- a/drivers/gpu/drm/udl/udl_dmabuf.c
> +++ b/drivers/gpu/drm/udl/udl_dmabuf.c
> @@ -76,6 +76,7 @@ static struct sg_table *udl_map_dma_buf(struct dma_buf_attachment *attach,
>         struct udl_drm_dmabuf_attachment *udl_attach = attach->priv;
>         struct udl_gem_object *obj = to_udl_bo(attach->dmabuf->priv);
>         struct drm_device *dev = obj->base.dev;
> +       struct udl_device *udl = dev->dev_private;
>         struct scatterlist *rd, *wr;
>         struct sg_table *sgt = NULL;
>         unsigned int i;
> @@ -112,7 +113,7 @@ static struct sg_table *udl_map_dma_buf(struct dma_buf_attachment *attach,
>                 return ERR_PTR(-ENOMEM);
>         }
>  
> -       mutex_lock(&dev->struct_mutex);
> +       mutex_lock(&udl->urbs.plock);
>  
>         rd = obj->sg->sgl;
>         wr = sgt->sgl;
> @@ -137,7 +138,7 @@ static struct sg_table *udl_map_dma_buf(struct dma_buf_attachment *attach,
>         attach->priv = udl_attach;
>  
>  err_unlock:
> -       mutex_unlock(&dev->struct_mutex);
> +       mutex_unlock(&udl->urbs.plock);
>         return sgt;
>  }
>  
> diff --git a/drivers/gpu/drm/udl/udl_drv.h b/drivers/gpu/drm/udl/udl_drv.h
> index 2a75ab8..24cca17 100644
> --- a/drivers/gpu/drm/udl/udl_drv.h
> +++ b/drivers/gpu/drm/udl/udl_drv.h
> @@ -39,6 +39,7 @@ struct urb_node {
>  
>  struct urb_list {
>         struct list_head list;
> +       struct mutex plock;
>         spinlock_t lock;
>         struct semaphore limit_sem;
>         int available;

This hasn't seen much testing as it lacks a mutex_init, and one would
wish for a description of what it is guarding.
-Chris
