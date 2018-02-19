Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752486AbeBSJ7u (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 04:59:50 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35196 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752142AbeBSJ7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 04:59:49 -0500
X-Google-Smtp-Source: AH8x227Wbu7Q7MANQFvloM33l7oSFRFcBNCxNUIWX7yuAf4r/zEGLAjrkdYqJPuFoJSbjmojRrmtDQ==
Date: Mon, 19 Feb 2018 10:59:45 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>, daniel@ffwll.ch,
        airlied@redhat.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, seanpaul@chromium.org
Subject: Re: [PATCH] gpu/drm/udl: Replace struct_mutex with driver private
 lock
Message-ID: <20180219095945.GQ22199@phenom.ffwll.local>
Mail-Followup-To: Shreeya Patel <shreeya.patel23498@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>, airlied@redhat.com,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, seanpaul@chromium.org
References: <1518178256-17157-1-git-send-email-shreeya.patel23498@gmail.com>
 <151817873639.28809.8475696517820926336@mail.alporthouse.com>
 <1518268651.3820.4.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1518268651.3820.4.camel@gmail.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 10, 2018 at 06:47:31PM +0530, Shreeya Patel wrote:
> On Fri, 2018-02-09 at 12:18 +0000, Chris Wilson wrote:
> > Quoting Shreeya Patel (2018-02-09 12:10:56)
> > > 
> > > dev->struct_mutex is the Big DRM Lock and the only bit where
> > > it’s mandatory is serializing GEM buffer object destruction.
> > > Which unfortunately means drivers have to keep track of that
> > > lock and either call unreference or unreference_locked
> > > depending upon context. Core GEM doesn’t have a need for
> > > struct_mutex any more since kernel 4.8.
> > > 
> > > For drivers that need struct_mutex it should be replaced by a
> > > driver
> > > private lock.
> > In that regard, dev->struct_mutex is already a driver private lock.
> > The
> > impetus is to reduce a big lock into lots of little locks where
> > contention deems prudent.
> 
> Ok. I'll make the changes in the commit message.

udl_driver_load would be a good place. Also, running with
CONFIG_PROVE_LOCKING enabled will catch this stuff. On that note, do you
have the hardware to test your changes? If not we need to find someone who
can do that.

Also please switch udl from the gem_free_object to the
gem_free_object_unlocked hook.
-Daniel

> > 
> > > 
> > > Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> > > ---
> > >  drivers/gpu/drm/udl/udl_dmabuf.c | 5 +++--
> > >  drivers/gpu/drm/udl/udl_drv.h    | 1 +
> > >  2 files changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/udl/udl_dmabuf.c
> > > b/drivers/gpu/drm/udl/udl_dmabuf.c
> > > index 2867ed1..120d2d9 100644
> > > --- a/drivers/gpu/drm/udl/udl_dmabuf.c
> > > +++ b/drivers/gpu/drm/udl/udl_dmabuf.c
> > > @@ -76,6 +76,7 @@ static struct sg_table *udl_map_dma_buf(struct
> > > dma_buf_attachment *attach,
> > >         struct udl_drm_dmabuf_attachment *udl_attach = attach-
> > > >priv;
> > >         struct udl_gem_object *obj = to_udl_bo(attach->dmabuf-
> > > >priv);
> > >         struct drm_device *dev = obj->base.dev;
> > > +       struct udl_device *udl = dev->dev_private;
> > >         struct scatterlist *rd, *wr;
> > >         struct sg_table *sgt = NULL;
> > >         unsigned int i;
> > > @@ -112,7 +113,7 @@ static struct sg_table *udl_map_dma_buf(struct
> > > dma_buf_attachment *attach,
> > >                 return ERR_PTR(-ENOMEM);
> > >         }
> > >  
> > > -       mutex_lock(&dev->struct_mutex);
> > > +       mutex_lock(&udl->urbs.plock);
> > >  
> > >         rd = obj->sg->sgl;
> > >         wr = sgt->sgl;
> > > @@ -137,7 +138,7 @@ static struct sg_table *udl_map_dma_buf(struct
> > > dma_buf_attachment *attach,
> > >         attach->priv = udl_attach;
> > >  
> > >  err_unlock:
> > > -       mutex_unlock(&dev->struct_mutex);
> > > +       mutex_unlock(&udl->urbs.plock);
> > >         return sgt;
> > >  }
> > >  
> > > diff --git a/drivers/gpu/drm/udl/udl_drv.h
> > > b/drivers/gpu/drm/udl/udl_drv.h
> > > index 2a75ab8..24cca17 100644
> > > --- a/drivers/gpu/drm/udl/udl_drv.h
> > > +++ b/drivers/gpu/drm/udl/udl_drv.h
> > > @@ -39,6 +39,7 @@ struct urb_node {
> > >  
> > >  struct urb_list {
> > >         struct list_head list;
> > > +       struct mutex plock;
> > >         spinlock_t lock;
> > >         struct semaphore limit_sem;
> > >         int available;
> > This hasn't seen much testing as it lacks a mutex_init, and one would
> > wish for a description of what it is guarding.
> 
> Yes, I'll add mutex_init but I am not sure that in which function I
> should add it as there is no probe or init function.
> 
> Also I will add the description for the lock.
> 
> Thanks 
> > -Chris

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
