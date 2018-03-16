Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753125AbeCPIgO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 04:36:14 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55679 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751448AbeCPIgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 04:36:09 -0400
X-Google-Smtp-Source: AG47ELuYBCx2EcNXECYLzSYHgwMwxwMesfplb8UTg1fXUmYD8xZb364h181tjq7mOFX5nAyNaLTCtg==
Date: Fri, 16 Mar 2018 09:36:04 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Alexandru M Stan <amstan@chromium.org>
Cc: David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Sean Paul <seanpaul@chromium.org>, devicetree@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>, briannorris@chromium.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        dianders@chromium.org, linux-rockchip@lists.infradead.org,
        marcheu@chromium.org, hoegsberg@chromium.org,
        Thierry Escande <thierry.escande@collabora.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Yakir Yang <kuankuan.y@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        zain wang <wzz@rock-chips.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH 2/2] drm/bridge: analogix: Enable
 EDP_BACKLIGHT_FREQ_PWM_PIN_PASSTHRU
Message-ID: <20180316083604.GG25297@phenom.ffwll.local>
Mail-Followup-To: Alexandru M Stan <amstan@chromium.org>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Sean Paul <seanpaul@chromium.org>, devicetree@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>, briannorris@chromium.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        dianders@chromium.org, linux-rockchip@lists.infradead.org,
        marcheu@chromium.org, hoegsberg@chromium.org,
        Thierry Escande <thierry.escande@collabora.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Yakir Yang <kuankuan.y@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        zain wang <wzz@rock-chips.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
References: <20180316025659.217423-1-amstan@chromium.org>
 <20180316025659.217423-3-amstan@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316025659.217423-3-amstan@chromium.org>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 07:56:59PM -0700, Alexandru M Stan wrote:
> Configure the DPCD registers for the backlight to respect the pwm frequency
> of the input. We sometimes don't want it to generate its own.
> 
> Signed-off-by: Alexandru M Stan <amstan@chromium.org>

I wonder a bit whether we should have some generic infrastructure in the
dp helpers itself to apply quirks like this. It's more-or-less what we
have for EDID quirking.

But then I guess for panels a lot of it is specific to the
bridge/encoder/panel combo and given platform, so probably not much use
for reuse across boards/platforms. External displays would be a different
story. I guess you can count that as an

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

on the overall thing, but pls get bridge folks to review this too.
-Daniel

> ---
> 
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 48 ++++++++++++++++++++++
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |  1 +
>  2 files changed, 49 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 5c52307146c7..b830403be8eb 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -916,6 +916,46 @@ static irqreturn_t analogix_dp_irq_thread(int irq, void *arg)
>  	return IRQ_HANDLED;
>  }
>  
> +static int analogix_dp_backlight_pwm_passthru(struct analogix_dp_device *dp)
> +{
> +	u8 value;
> +	const u8 expected_cap = DP_EDP_BACKLIGHT_BRIGHTNESS_PWM_PIN_CAP |
> +				DP_EDP_BACKLIGHT_FREQ_PWM_PIN_PASSTHRU_CAP;
> +	int ret = 0;
> +
> +	ret = drm_dp_dpcd_readb(&dp->aux, DP_EDP_BACKLIGHT_ADJUSTMENT_CAP,
> +				&value);
> +	if (ret != 1) {
> +		DRM_DEV_ERROR(dp->dev,
> +			"backlight PWM passthru: Can't read BACKLIGHT_ADJUSTMENT_CAP\n");
> +		return ret;
> +	}
> +
> +	if ((value & expected_cap) != expected_cap) {
> +		DRM_DEV_ERROR(dp->dev,
> +			"panel doesn't support backlight PWM passthru, BACKLIGHT_ADJUSTMENT_CAP=0x%02x\n",
> +			value);
> +		return -1;
> +	}
> +
> +	ret = drm_dp_dpcd_readb(&dp->aux, DP_EDP_BACKLIGHT_MODE_SET_REGISTER,
> +				&value);
> +	if (ret != 1) {
> +		DRM_DEV_ERROR(dp->dev,
> +			"backlight PWM passthru: Can't read BACKLIGHT_MODE_SET_REGISTER\n");
> +		return ret;
> +	}
> +
> +	value |= DP_EDP_BACKLIGHT_FREQ_PWM_PIN_PASSTHRU_ENABLE;
> +	ret = drm_dp_dpcd_writeb(&dp->aux, DP_EDP_BACKLIGHT_MODE_SET_REGISTER,
> +				 value);
> +	if (ret != 1) {
> +		DRM_DEV_ERROR(dp->dev,
> +			"backlight PWM passthru: Can't write BACKLIGHT_MODE_SET_REGISTER\n");
> +	}
> +	return ret;
> +}
> +
>  static void analogix_dp_commit(struct analogix_dp_device *dp)
>  {
>  	int ret;
> @@ -954,6 +994,12 @@ static void analogix_dp_commit(struct analogix_dp_device *dp)
>  	dp->psr_enable = analogix_dp_detect_sink_psr(dp);
>  	if (dp->psr_enable)
>  		analogix_dp_enable_sink_psr(dp);
> +
> +	if (dp->backlight_pwm_passthru) {
> +		if (analogix_dp_backlight_pwm_passthru(dp) != 1)
> +			DRM_DEV_ERROR(dp->dev,
> +				 "Could not enable backlight pwm pin passthru.\n");
> +	}
>  }
>  
>  /*
> @@ -1424,6 +1470,8 @@ analogix_dp_bind(struct device *dev, struct drm_device *drm_dev,
>  	if (IS_ERR(dp->reg_base))
>  		return ERR_CAST(dp->reg_base);
>  
> +	dp->backlight_pwm_passthru =
> +	       of_property_read_bool(dev->of_node, "backlight-pwm-passthru");
>  	dp->force_hpd = of_property_read_bool(dev->of_node, "force-hpd");
>  
>  	dp->hpd_gpio = of_get_named_gpio(dev->of_node, "hpd-gpios", 0);
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> index 6a96ef7e6934..aea51413e78e 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> @@ -171,6 +171,7 @@ struct analogix_dp_device {
>  	struct phy		*phy;
>  	int			dpms_mode;
>  	int			hpd_gpio;
> +	bool			backlight_pwm_passthru;
>  	bool                    force_hpd;
>  	bool			psr_enable;
>  	bool			fast_train_support;
> -- 
> 2.13.5
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
