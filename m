Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeA3IcR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 03:32:17 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:45192 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751707AbeA3IcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 03:32:16 -0500
X-Google-Smtp-Source: AH8x2255iTUfS7XZF8T3cVmEvOBezTcBVZ2z9qmAsqR8EzLNHdfqgEzonesnGbQU79LpAXFVzfkqiyedIqgy+nf9uU4=
MIME-Version: 1.0
In-Reply-To: <20180122103335.12820-1-philippe.cornu@st.com>
References: <20180122103335.12820-1-philippe.cornu@st.com>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Tue, 30 Jan 2018 09:32:15 +0100
Message-ID: <CA+M3ks7PZU9gbJ7zcYGV9LFJ+pAH38BrCX-dWNioSvdHJNU9rg@mail.gmail.com>
Subject: Re: [PATCH] drm/stm: drv: Improve data transfers
To: Philippe Cornu <philippe.cornu@st.com>
Cc: Yannick Fertre <yannick.fertre@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Mickael Reulier <mickael.reulier@st.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-01-22 11:33 GMT+01:00 Philippe Cornu <philippe.cornu@st.com>:
> To optimize data transfers, align pitch on 128 bytes & height
> on 4 bytes. This optimization is not applicable without MMU.
>
> Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
> Signed-off-by: Vincent Abriou <vincent.abriou@st.com>
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
>  drivers/gpu/drm/stm/drv.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
> index 8fe954c27fba..c2bd9d882b93 100644
> --- a/drivers/gpu/drm/stm/drv.c
> +++ b/drivers/gpu/drm/stm/drv.c
> @@ -31,6 +31,23 @@ static const struct drm_mode_config_funcs drv_mode_config_funcs = {
>         .atomic_commit = drm_atomic_helper_commit,
>  };
>
> +#ifdef CONFIG_MMU
> +static int stm_dumb_create(struct drm_file *file, struct drm_device *dev,
> +                          struct drm_mode_create_dumb *args)
> +{
> +       unsigned int min_pitch = DIV_ROUND_UP(args->width * args->bpp, 8);
> +
> +       /*
> +        * in order to optimize data transfer, pitch is aligned on
> +        * 128 bytes, height is aligned on 4 bytes
> +        */
> +       args->pitch = roundup(min_pitch, 128);
> +       args->height = roundup(args->height, 4);
> +
> +       return drm_gem_cma_dumb_create_internal(file, dev, args);
> +}
> +#endif

I would prefer to always call stm_dumb_create (maybe renamed
stm_gem_cma_dumb_create)
and change the parameters inside if the we have MMU.

> +
>  DEFINE_DRM_GEM_CMA_FOPS(drv_driver_fops);
>
>  static struct drm_driver drv_driver = {
> @@ -44,7 +61,11 @@ static struct drm_driver drv_driver = {
>         .minor = 0,
>         .patchlevel = 0,
>         .fops = &drv_driver_fops,
> +#ifdef CONFIG_MMU
> +       .dumb_create = stm_dumb_create,
> +#else
>         .dumb_create = drm_gem_cma_dumb_create,
> +#endif
>         .prime_handle_to_fd = drm_gem_prime_handle_to_fd,
>         .prime_fd_to_handle = drm_gem_prime_fd_to_handle,
>         .gem_free_object_unlocked = drm_gem_cma_free_object,
> --
> 2.15.1
>
