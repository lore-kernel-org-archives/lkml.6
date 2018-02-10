Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751512AbeBJNRk (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 08:17:40 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:45068 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750942AbeBJNRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 08:17:39 -0500
X-Google-Smtp-Source: AH8x227EHpRogxgWY44MLO9sFA7lxKmxMfkKWlnxHKLz7D6tFQKLhpc94PQzzh+npC+p/b6/+Q/1tA==
Message-ID: <1518268651.3820.4.camel@gmail.com>
Subject: Re: [PATCH] gpu/drm/udl: Replace struct_mutex with driver private
 lock
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: Chris Wilson <chris@chris-wilson.co.uk>, daniel@ffwll.ch,
        airlied@redhat.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, seanpaul@chromium.org
Date: Sat, 10 Feb 2018 18:47:31 +0530
In-Reply-To: <151817873639.28809.8475696517820926336@mail.alporthouse.com>
References: <1518178256-17157-1-git-send-email-shreeya.patel23498@gmail.com>
         <151817873639.28809.8475696517820926336@mail.alporthouse.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-02-09 at 12:18 +0000, Chris Wilson wrote:
> Quoting Shreeya Patel (2018-02-09 12:10:56)
> > 
> > dev->struct_mutex is the Big DRM Lock and the only bit where
> > it’s mandatory is serializing GEM buffer object destruction.
> > Which unfortunately means drivers have to keep track of that
> > lock and either call unreference or unreference_locked
> > depending upon context. Core GEM doesn’t have a need for
> > struct_mutex any more since kernel 4.8.
> > 
> > For drivers that need struct_mutex it should be replaced by a
> > driver
> > private lock.
> In that regard, dev->struct_mutex is already a driver private lock.
> The
> impetus is to reduce a big lock into lots of little locks where
> contention deems prudent.

Ok. I'll make the changes in the commit message.
> 
> > 
> > Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> > ---
> >  drivers/gpu/drm/udl/udl_dmabuf.c | 5 +++--
> >  drivers/gpu/drm/udl/udl_drv.h    | 1 +
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/udl/udl_dmabuf.c
> > b/drivers/gpu/drm/udl/udl_dmabuf.c
> > index 2867ed1..120d2d9 100644
> > --- a/drivers/gpu/drm/udl/udl_dmabuf.c
> > +++ b/drivers/gpu/drm/udl/udl_dmabuf.c
> > @@ -76,6 +76,7 @@ static struct sg_table *udl_map_dma_buf(struct
> > dma_buf_attachment *attach,
> >         struct udl_drm_dmabuf_attachment *udl_attach = attach-
> > >priv;
> >         struct udl_gem_object *obj = to_udl_bo(attach->dmabuf-
> > >priv);
> >         struct drm_device *dev = obj->base.dev;
> > +       struct udl_device *udl = dev->dev_private;
> >         struct scatterlist *rd, *wr;
> >         struct sg_table *sgt = NULL;
> >         unsigned int i;
> > @@ -112,7 +113,7 @@ static struct sg_table *udl_map_dma_buf(struct
> > dma_buf_attachment *attach,
> >                 return ERR_PTR(-ENOMEM);
> >         }
> >  
> > -       mutex_lock(&dev->struct_mutex);
> > +       mutex_lock(&udl->urbs.plock);
> >  
> >         rd = obj->sg->sgl;
> >         wr = sgt->sgl;
> > @@ -137,7 +138,7 @@ static struct sg_table *udl_map_dma_buf(struct
> > dma_buf_attachment *attach,
> >         attach->priv = udl_attach;
> >  
> >  err_unlock:
> > -       mutex_unlock(&dev->struct_mutex);
> > +       mutex_unlock(&udl->urbs.plock);
> >         return sgt;
> >  }
> >  
> > diff --git a/drivers/gpu/drm/udl/udl_drv.h
> > b/drivers/gpu/drm/udl/udl_drv.h
> > index 2a75ab8..24cca17 100644
> > --- a/drivers/gpu/drm/udl/udl_drv.h
> > +++ b/drivers/gpu/drm/udl/udl_drv.h
> > @@ -39,6 +39,7 @@ struct urb_node {
> >  
> >  struct urb_list {
> >         struct list_head list;
> > +       struct mutex plock;
> >         spinlock_t lock;
> >         struct semaphore limit_sem;
> >         int available;
> This hasn't seen much testing as it lacks a mutex_init, and one would
> wish for a description of what it is guarding.

Yes, I'll add mutex_init but I am not sure that in which function I
should add it as there is no probe or init function.

Also I will add the description for the lock.

Thanks 
> -Chris
