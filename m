Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752352AbeCVGsI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 02:48:08 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39903 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752213AbeCVGsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 02:48:07 -0400
X-Google-Smtp-Source: AG47ELukvY4zMx8bCBy6Ib4iNtQ83k+kWbk8QRWZpWah3RvBItE3daGiNStZR9NePHhjJA3cAdNoyg==
MIME-Version: 1.0
In-Reply-To: <20180321152904.22411-4-paul.kocialkowski@bootlin.com>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com> <20180321152904.22411-4-paul.kocialkowski@bootlin.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 22 Mar 2018 14:47:44 +0800
X-Gmail-Original-Message-ID: <CAGb2v65JqT2go2kX+yEWeWiQX6U5PFoXEbbatBXRyLyujxyouw@mail.gmail.com>
Message-ID: <CAGb2v65JqT2go2kX+yEWeWiQX6U5PFoXEbbatBXRyLyujxyouw@mail.gmail.com>
Subject: Re: [PATCH 03/10] drm/sun4i: Don't pretend to handle ARGB8888 with
 the frontend
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 11:28 PM, Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
> It turns out that the frontend is not capable of preserving the alpha
> component (that is always set to 0xff), so only support XRGB8888
> instead.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_backend.c  | 4 ++++
>  drivers/gpu/drm/sun4i/sun4i_frontend.c | 3 +--
>  drivers/gpu/drm/sun4i/sun4i_layer.c    | 4 ++--
>  3 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
> index b98dafda52f8..274a1db6fa8e 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> @@ -440,6 +440,10 @@ static bool sun4i_backend_plane_uses_frontend(struct drm_plane_state *state)
>         if (IS_ERR(backend->frontend))
>                 return false;
>
> +       /*
> +        * TODO: Don't use the frontend for x2/x4 scaling and allow RGB formats
> +        * with an alpha component then.

This and the commit log are kind of conflicting. Is it just the scalar
that doesn't
work with an alpha component, or the whole frontend?

Thanks
ChenYu

> +        */
>         return sun4i_backend_plane_uses_scaler(state);
>  }
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
> index ddf6cfa6dd23..3ea925584891 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
> @@ -107,7 +107,7 @@ EXPORT_SYMBOL(sun4i_frontend_update_buffer);
>  static int sun4i_frontend_drm_format_to_input_fmt(uint32_t fmt, u32 *val)
>  {
>         switch (fmt) {
> -       case DRM_FORMAT_ARGB8888:
> +       case DRM_FORMAT_XRGB8888:
>                 *val = 5;
>                 return 0;
>
> @@ -120,7 +120,6 @@ static int sun4i_frontend_drm_format_to_output_fmt(uint32_t fmt, u32 *val)
>  {
>         switch (fmt) {
>         case DRM_FORMAT_XRGB8888:
> -       case DRM_FORMAT_ARGB8888:
>                 *val = 2;
>                 return 0;
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
> index eb93df445a10..15238211a61a 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
> @@ -100,9 +100,9 @@ static void sun4i_backend_layer_atomic_update(struct drm_plane *plane,
>                 sun4i_frontend_update_coord(frontend, plane);
>                 sun4i_frontend_update_buffer(frontend, plane);
>                 sun4i_frontend_update_formats(frontend, plane,
> -                                             DRM_FORMAT_ARGB8888);
> +                                             DRM_FORMAT_XRGB8888);
>                 sun4i_backend_update_layer_frontend(backend, layer->id, plane,
> -                                                   DRM_FORMAT_ARGB8888);
> +                                                   DRM_FORMAT_XRGB8888);
>                 sun4i_frontend_enable(frontend);
>         } else {
>                 sun4i_backend_update_layer_formats(backend, layer->id, plane);
> --
> 2.16.2
>
