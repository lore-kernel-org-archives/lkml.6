Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753075AbeD3KTm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 06:19:42 -0400
Received: from mga18.intel.com ([134.134.136.126]:51484 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752080AbeD3KTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 06:19:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,346,1520924400";
   d="scan'208";a="51101894"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jingoo Han <jingoohan1@gmail.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 4/6] staging/fbtft: Stop using BL_CORE_DRIVER1
In-Reply-To: <20180425174253.4616-4-daniel.vetter@ffwll.ch>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180425174253.4616-1-daniel.vetter@ffwll.ch> <20180425174253.4616-4-daniel.vetter@ffwll.ch>
Date: Mon, 30 Apr 2018 13:22:20 +0300
Message-ID: <87fu3d9eoz.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2018, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> Leaking driver internal tracking into the already massively confusing
> backlight power tracking is really confusing.
>
> Luckily we have already a drvdata structure, so fixing this is really
> easy.
>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/staging/fbtft/fbtft-core.c | 4 ++--
>  drivers/staging/fbtft/fbtft.h      | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
> index 0e36b66ae5f7..731e47149af8 100644
> --- a/drivers/staging/fbtft/fbtft-core.c
> +++ b/drivers/staging/fbtft/fbtft-core.c
> @@ -246,7 +246,7 @@ static int fbtft_request_gpios_dt(struct fbtft_par *par)
>  static int fbtft_backlight_update_status(struct backlight_device *bd)
>  {
>  	struct fbtft_par *par = bl_get_data(bd);
> -	bool polarity = !!(bd->props.state & BL_CORE_DRIVER1);
> +	bool polarity = par->polarity;
>  
>  	fbtft_par_dbg(DEBUG_BACKLIGHT, par,
>  		"%s: polarity=%d, power=%d, fb_blank=%d\n",
> @@ -296,7 +296,7 @@ void fbtft_register_backlight(struct fbtft_par *par)
>  	/* Assume backlight is off, get polarity from current state of pin */
>  	bl_props.power = FB_BLANK_POWERDOWN;
>  	if (!gpio_get_value(par->gpio.led[0]))
> -		bl_props.state |= BL_CORE_DRIVER1;
> +		par->polarity = true;
>  
>  	bd = backlight_device_register(dev_driver_string(par->info->device),
>  				       par->info->device, par,
> diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
> index e19e64e0d094..c7cb4a7896f4 100644
> --- a/drivers/staging/fbtft/fbtft.h
> +++ b/drivers/staging/fbtft/fbtft.h
> @@ -229,6 +229,7 @@ struct fbtft_par {
>  	ktime_t update_time;
>  	bool bgr;
>  	void *extra;
> +	bool polarity;
>  };
>  
>  #define NUMARGS(...)  (sizeof((int[]){__VA_ARGS__})/sizeof(int))

-- 
Jani Nikula, Intel Open Source Technology Center
