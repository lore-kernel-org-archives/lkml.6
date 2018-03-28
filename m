Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753355AbeC1HfI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 03:35:08 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49181 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751932AbeC1HfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 03:35:06 -0400
Date: Wed, 28 Mar 2018 09:34:54 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Takashi Iwai <tiwai@suse.com>, Egbert Eich <eich@suse.de>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm/atmel-hlcdc: add command line option to specify
 preferred depth
Message-ID: <20180328093454.4149fa3b@bbrezillon>
In-Reply-To: <20180326073502.19259-1-peda@axentia.se>
References: <20180326073502.19259-1-peda@axentia.se>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Mon, 26 Mar 2018 09:35:02 +0200
Peter Rosin <peda@axentia.se> wrote:

> I have an sama5d31-based system with 64MB of memory and a 1920x1080
> LVDS display wired for 16-bpp. When I enable legacy fbdev support,
> the contiguous memory allocator invariably fails with the order-11
> allocation for a 1920x1080@24-bpp buffer (~6MB). But this HW can never
> make any good use of RGB888, so that is a wasted attempt anyway that
> would also waste precious memory should it succeed.
> 
> Sure, I could rewrite user-space to go directly to KMS etc, and that
> makes the (attempted) order-11 allocation go away, replacing it with
> one order-10 allocation per application restart for a 1920x1080@16-bpp
> buffer (<4MB). But after a few restarts, order-10 allocations start to
> fail as well, which is only to be expected AFAIU.
> 
> So, I'd rather not change user-space (which was originally written
> to target a smaller display) so that I at the same time get the
> benefit of an early pre-allocated fbdev frame-buffer that can be
> reused over and over. But to do that I need to tell the driver that
> 16-bpp is the preferred depth. Add a module parameter to do just that.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> I found some inspiration regarding naming and implementation here:
> https://patchwork.kernel.org/patch/9848631/
> 
> I have found no feedback on that patch though, which makes me wonder if
> I'm perhaps barking up the wronig tree?

Hm, isn't that something you can already overload with the video=
parameter?

	video=<output>:<resolution>[-<bpp>]

AFAIR, <bpp> encodes the color depth, so what is the benefit of adding
this new property to overload the default depth?

Maybe I'm wrong and the default depth param is actually useful, but in
this case we should probably make it generic since other drivers seems
to need it too, and we might want to attach it to a specific display
engine instance.

Thanks,

Boris

> 
> Cheers,
> Peter
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> index c1ea5c36b006..f0148627c221 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> @@ -29,6 +29,11 @@
>  
>  #define ATMEL_HLCDC_LAYER_IRQS_OFFSET		8
>  
> +static int atmel_hlcdc_preferred_depth __read_mostly;
> +
> +MODULE_PARM_DESC(preferreddepth, "Set preferred bpp");
> +module_param_named(preferreddepth, atmel_hlcdc_preferred_depth, int, 0400);
> +
>  static const struct atmel_hlcdc_layer_desc atmel_hlcdc_at91sam9n12_layers[] = {
>  	{
>  		.name = "base",
> @@ -590,6 +595,7 @@ static int atmel_hlcdc_dc_modeset_init(struct drm_device *dev)
>  	dev->mode_config.min_height = dc->desc->min_height;
>  	dev->mode_config.max_width = dc->desc->max_width;
>  	dev->mode_config.max_height = dc->desc->max_height;
> +	dev->mode_config.preferred_depth = 24;
>  	dev->mode_config.funcs = &mode_config_funcs;
>  
>  	return 0;
> @@ -658,7 +664,7 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
>  
>  	platform_set_drvdata(pdev, dev);
>  
> -	drm_fb_cma_fbdev_init(dev, 24, 0);
> +	drm_fb_cma_fbdev_init(dev, atmel_hlcdc_preferred_depth, 0);
>  
>  	drm_kms_helper_poll_init(dev);
>  
> @@ -756,6 +762,16 @@ static int atmel_hlcdc_dc_drm_probe(struct platform_device *pdev)
>  	struct drm_device *ddev;
>  	int ret;
>  
> +	switch (atmel_hlcdc_preferred_depth) {
> +	case 0: /* driver default */
> +	case 8:
> +	case 16:
> +	case 24:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
>  	ddev = drm_dev_alloc(&atmel_hlcdc_dc_driver, &pdev->dev);
>  	if (IS_ERR(ddev))
>  		return PTR_ERR(ddev);



-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
