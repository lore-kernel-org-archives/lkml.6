Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752908AbeD3KT3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 06:19:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:49617 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752545AbeD3KT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 06:19:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,346,1520924400";
   d="scan'208";a="51101871"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH 3/6] backlight/pandora: Stop using BL_CORE_DRIVER1
In-Reply-To: <20180425174253.4616-3-daniel.vetter@ffwll.ch>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180425174253.4616-1-daniel.vetter@ffwll.ch> <20180425174253.4616-3-daniel.vetter@ffwll.ch>
Date: Mon, 30 Apr 2018 13:22:07 +0300
Message-ID: <87in899epc.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2018, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> Leaking driver internal tracking into the already massively confusing
> backlight power tracking is really confusing.
>
> Stop that by allocating a tiny driver private data structure instead.
>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
> v2:
> - Consistently treating PANDORA_WAS_OFF as a non-bitfield
> - Drop the kfree that I left behind after switching to devm_kmalloc
> ---
>  drivers/video/backlight/pandora_bl.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/video/backlight/pandora_bl.c b/drivers/video/backlight/pandora_bl.c
> index a186bc677c7d..9618766e3866 100644
> --- a/drivers/video/backlight/pandora_bl.c
> +++ b/drivers/video/backlight/pandora_bl.c
> @@ -35,11 +35,15 @@
>  #define MAX_VALUE 63
>  #define MAX_USER_VALUE (MAX_VALUE - MIN_VALUE)
>  
> -#define PANDORABL_WAS_OFF BL_CORE_DRIVER1
> +struct pandora_private {
> +	unsigned old_state;
> +#define PANDORABL_WAS_OFF 1
> +};
>  
>  static int pandora_backlight_update_status(struct backlight_device *bl)
>  {
>  	int brightness = bl->props.brightness;
> +	struct pandora_private *priv = bl_get_data(bl);
>  	u8 r;
>  
>  	if (bl->props.power != FB_BLANK_UNBLANK)
> @@ -53,7 +57,7 @@ static int pandora_backlight_update_status(struct backlight_device *bl)
>  		brightness = MAX_USER_VALUE;
>  
>  	if (brightness == 0) {
> -		if (bl->props.state & PANDORABL_WAS_OFF)
> +		if (priv->old_state == PANDORABL_WAS_OFF)
>  			goto done;
>  
>  		/* first disable PWM0 output, then clock */
> @@ -66,7 +70,7 @@ static int pandora_backlight_update_status(struct backlight_device *bl)
>  		goto done;
>  	}
>  
> -	if (bl->props.state & PANDORABL_WAS_OFF) {
> +	if (priv->old_state == PANDORABL_WAS_OFF) {
>  		/*
>  		 * set PWM duty cycle to max. TPS61161 seems to use this
>  		 * to calibrate it's PWM sensitivity when it starts.
> @@ -93,9 +97,9 @@ static int pandora_backlight_update_status(struct backlight_device *bl)
>  
>  done:
>  	if (brightness != 0)
> -		bl->props.state &= ~PANDORABL_WAS_OFF;
> +		priv->old_state = 0;
>  	else
> -		bl->props.state |= PANDORABL_WAS_OFF;
> +		priv->old_state = PANDORABL_WAS_OFF;
>  
>  	return 0;
>  }
> @@ -109,13 +113,20 @@ static int pandora_backlight_probe(struct platform_device *pdev)
>  {
>  	struct backlight_properties props;
>  	struct backlight_device *bl;
> +	struct pandora_private *priv;
>  	u8 r;
>  
> +	priv = devm_kmalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv) {
> +		dev_err(&pdev->dev, "failed to allocate driver private data\n");
> +		return -ENOMEM;
> +	}
> +
>  	memset(&props, 0, sizeof(props));
>  	props.max_brightness = MAX_USER_VALUE;
>  	props.type = BACKLIGHT_RAW;
>  	bl = devm_backlight_device_register(&pdev->dev, pdev->name, &pdev->dev,
> -					NULL, &pandora_backlight_ops, &props);
> +					priv, &pandora_backlight_ops, &props);
>  	if (IS_ERR(bl)) {
>  		dev_err(&pdev->dev, "failed to register backlight\n");
>  		return PTR_ERR(bl);
> @@ -126,7 +137,7 @@ static int pandora_backlight_probe(struct platform_device *pdev)
>  	/* 64 cycle period, ON position 0 */
>  	twl_i2c_write_u8(TWL_MODULE_PWM, 0x80, TWL_PWM0_ON);
>  
> -	bl->props.state |= PANDORABL_WAS_OFF;
> +	priv->old_state = PANDORABL_WAS_OFF;
>  	bl->props.brightness = MAX_USER_VALUE;
>  	backlight_update_status(bl);

-- 
Jani Nikula, Intel Open Source Technology Center
