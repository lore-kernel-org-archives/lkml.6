Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752067AbeA3PBP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 10:01:15 -0500
Received: from galahad.ideasonboard.com ([185.26.127.97]:45511 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751429AbeA3PBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 10:01:13 -0500
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Philippe Cornu <philippe.cornu@st.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Mickael Reulier <mickael.reulier@st.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH v2] drm/stm: drv: Improve data transfers
Date: Tue, 30 Jan 2018 17:01:30 +0200
Message-ID: <9032382.xZ397EfsLU@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <CA+M3ks7ao2ZUefn5VZ1POC45rq1dTmZr4v8Gy+zXue=gRx6=pg@mail.gmail.com>
References: <20180130104200.21602-1-philippe.cornu@st.com> <CA+M3ks7ao2ZUefn5VZ1POC45rq1dTmZr4v8Gy+zXue=gRx6=pg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On Tuesday, 30 January 2018 12:51:25 EET Benjamin Gaignard wrote:
> 2018-01-30 11:42 GMT+01:00 Philippe Cornu <philippe.cornu@st.com>:
> > To optimize data transfers, align pitch on 128 bytes & height
> > on 4 bytes. This optimization is not applicable on hw without MMU.
> > 
> > Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
> > Signed-off-by: Vincent Abriou <vincent.abriou@st.com>
> > Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> 
> Applied on drm-misc-next.

A 9 minutes review window is pretty small... I've been told before that I 
should then review v1 instead of complaining about short review times for v2, 
but in this case v2 introduces a bug that wasn't present in v1.

> > ---
> > Changes in v2: Rename stm_dumb_create() to stm_gem_cma_dumb_create() and
> > 
> >   move CONFIG_MMU inside the function following comments from Benjamin
> >   Gaignard.
> >  
> >  drivers/gpu/drm/stm/drv.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
> > index 8fe954c27fba..8bc7e8418b8d 100644
> > --- a/drivers/gpu/drm/stm/drv.c
> > +++ b/drivers/gpu/drm/stm/drv.c
> > @@ -31,6 +31,24 @@ static const struct drm_mode_config_funcs
> > drv_mode_config_funcs = {> 
> >         .atomic_commit = drm_atomic_helper_commit,
> >  
> >  };
> > 
> > +static int stm_gem_cma_dumb_create(struct drm_file *file,
> > +                                  struct drm_device *dev,
> > +                                  struct drm_mode_create_dumb *args)
> > +{
> > +#ifdef CONFIG_MMU
> > +       unsigned int min_pitch = DIV_ROUND_UP(args->width * args->bpp, 8);
> > +
> > +       /*
> > +        * in order to optimize data transfer, pitch is aligned on
> > +        * 128 bytes, height is aligned on 4 bytes
> > +        */
> > +       args->pitch = roundup(min_pitch, 128);
> > +       args->height = roundup(args->height, 4);
> > +#endif
> > +
> > +       return drm_gem_cma_dumb_create_internal(file, dev, args);
> > +}
> > +
> > 
> >  DEFINE_DRM_GEM_CMA_FOPS(drv_driver_fops);
> >  
> >  static struct drm_driver drv_driver = {
> > 
> > @@ -44,7 +62,7 @@ static struct drm_driver drv_driver = {
> > 
> >         .minor = 0,
> >         .patchlevel = 0,
> >         .fops = &drv_driver_fops,
> > 
> > -       .dumb_create = drm_gem_cma_dumb_create,
> > +       .dumb_create = stm_gem_cma_dumb_create,
> > 
> >         .prime_handle_to_fd = drm_gem_prime_handle_to_fd,
> >         .prime_fd_to_handle = drm_gem_prime_fd_to_handle,
> >         .gem_free_object_unlocked = drm_gem_cma_free_object,
> > 
> > --
> > 2.15.1

-- 
Regards,

Laurent Pinchart
