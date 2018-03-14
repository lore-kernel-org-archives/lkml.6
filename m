Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753420AbeCNGcg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 02:32:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51484 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeCNGce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 02:32:34 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 041F660452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=architt@codeaurora.org
Subject: Re: [PATCH v5 19/36] drm/rockchip: Restore psr->state when
 enable/disable psr failed
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        inki.dae@samsung.com, thierry.reding@gmail.com, hjc@rock-chips.com,
        seanpaul@chromium.org, airlied@linux.ie, tfiga@chromium.org,
        heiko@sntech.de
Cc: dri-devel@lists.freedesktop.org, dianders@chromium.org,
        a.hajda@samsung.com, ykk@rock-chips.com, kernel@collabora.com,
        m.szyprowski@samsung.com, linux-samsung-soc@vger.kernel.org,
        jy0922.shim@samsung.com, rydberg@bitmath.org, krzk@kernel.org,
        linux-rockchip@lists.infradead.org, kgene@kernel.org,
        linux-input@vger.kernel.org, orjan.eide@arm.com, wxt@rock-chips.com,
        jeffy.chen@rock-chips.com, linux-arm-kernel@lists.infradead.org,
        mark.yao@rock-chips.com, wzz@rock-chips.com, hl@rock-chips.com,
        jingoohan1@gmail.com, sw0312.kim@samsung.com,
        linux-kernel@vger.kernel.org, kyungmin.park@samsung.com,
        Laurent.pinchart@ideasonboard.com, kuankuan.y@gmail.com,
        hshi@chromium.org
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
 <20180309222327.18689-20-enric.balletbo@collabora.com>
From: Archit Taneja <architt@codeaurora.org>
Message-ID: <0c9d07eb-a37b-f257-ce72-4b6a13e6d511@codeaurora.org>
Date: Wed, 14 Mar 2018 12:02:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309222327.18689-20-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday 10 March 2018 03:53 AM, Enric Balletbo i Serra wrote:
> From: zain wang <wzz@rock-chips.com>
> 
> If we failed disable psr, it would hang the display until next psr
> cycle coming. So we should restore psr->state when it failed.
> 

For the bridge part,

Reviewed-by: Archit Taneja <architt@codeaurora.org>

Thanks,
Archit

> Cc: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: zain wang <wzz@rock-chips.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> 
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  4 +++-
>   drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    | 10 +++++-----
>   drivers/gpu/drm/rockchip/rockchip_drm_psr.c        | 20 +++++++++++++-------
>   drivers/gpu/drm/rockchip/rockchip_drm_psr.h        |  2 +-
>   4 files changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index be6eddd0d0a7..1f1cb624414d 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -153,8 +153,10 @@ int analogix_dp_disable_psr(struct analogix_dp_device *dp)
>   	psr_vsc.DB1 = 0;
>   
>   	ret = drm_dp_dpcd_writeb(&dp->aux, DP_SET_POWER, DP_SET_POWER_D0);
> -	if (ret != 1)
> +	if (ret != 1) {
>   		dev_err(dp->dev, "Failed to set DP Power0 %d\n", ret);
> +		return ret;
> +	}
>   
>   	return analogix_dp_send_psr_spd(dp, &psr_vsc, false);
>   }
> diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> index 3e8bf79bea58..8c884f9ce713 100644
> --- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> @@ -77,13 +77,13 @@ struct rockchip_dp_device {
>   	struct analogix_dp_plat_data plat_data;
>   };
>   
> -static void analogix_dp_psr_set(struct drm_encoder *encoder, bool enabled)
> +static int analogix_dp_psr_set(struct drm_encoder *encoder, bool enabled)
>   {
>   	struct rockchip_dp_device *dp = to_dp(encoder);
>   	int ret;
>   
>   	if (!analogix_dp_psr_enabled(dp->adp))
> -		return;
> +		return 0;
>   
>   	DRM_DEV_DEBUG(dp->dev, "%s PSR...\n", enabled ? "Entry" : "Exit");
>   
> @@ -91,13 +91,13 @@ static void analogix_dp_psr_set(struct drm_encoder *encoder, bool enabled)
>   					 PSR_WAIT_LINE_FLAG_TIMEOUT_MS);
>   	if (ret) {
>   		DRM_DEV_ERROR(dp->dev, "line flag interrupt did not arrive\n");
> -		return;
> +		return -ETIMEDOUT;
>   	}
>   
>   	if (enabled)
> -		analogix_dp_enable_psr(dp->adp);
> +		return analogix_dp_enable_psr(dp->adp);
>   	else
> -		analogix_dp_disable_psr(dp->adp);
> +		return analogix_dp_disable_psr(dp->adp);
>   }
>   
>   static int rockchip_dp_pre_init(struct rockchip_dp_device *dp)
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
> index b339ca943139..9376f4396b6b 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
> @@ -36,7 +36,7 @@ struct psr_drv {
>   
>   	struct delayed_work	flush_work;
>   
> -	void (*set)(struct drm_encoder *encoder, bool enable);
> +	int (*set)(struct drm_encoder *encoder, bool enable);
>   };
>   
>   static struct psr_drv *find_psr_by_crtc(struct drm_crtc *crtc)
> @@ -93,19 +93,25 @@ static void psr_set_state_locked(struct psr_drv *psr, enum psr_state state)
>   		return;
>   	}
>   
> -	psr->state = state;
> -
>   	/* Actually commit the state change to hardware */
> -	switch (psr->state) {
> +	switch (state) {
>   	case PSR_ENABLE:
> -		psr->set(psr->encoder, true);
> +		if (psr->set(psr->encoder, true))
> +			return;
>   		break;
>   
>   	case PSR_DISABLE:
>   	case PSR_FLUSH:
> -		psr->set(psr->encoder, false);
> +		if (psr->set(psr->encoder, false))
> +			return;
>   		break;
> +
> +	default:
> +		pr_err("%s: Unknown state %d\n", __func__, state);
> +		return;
>   	}
> +
> +	psr->state = state;
>   }
>   
>   static void psr_set_state(struct psr_drv *psr, enum psr_state state)
> @@ -229,7 +235,7 @@ EXPORT_SYMBOL(rockchip_drm_psr_flush_all);
>    * Zero on success, negative errno on failure.
>    */
>   int rockchip_drm_psr_register(struct drm_encoder *encoder,
> -			void (*psr_set)(struct drm_encoder *, bool enable))
> +			int (*psr_set)(struct drm_encoder *, bool enable))
>   {
>   	struct rockchip_drm_private *drm_drv = encoder->dev->dev_private;
>   	struct psr_drv *psr;
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.h b/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
> index b1ea0155e57c..06537ee27565 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
> @@ -22,7 +22,7 @@ int rockchip_drm_psr_activate(struct drm_encoder *encoder);
>   int rockchip_drm_psr_deactivate(struct drm_encoder *encoder);
>   
>   int rockchip_drm_psr_register(struct drm_encoder *encoder,
> -			void (*psr_set)(struct drm_encoder *, bool enable));
> +			int (*psr_set)(struct drm_encoder *, bool enable));
>   void rockchip_drm_psr_unregister(struct drm_encoder *encoder);
>   
>   #endif /* __ROCKCHIP_DRM_PSR__ */
> 
