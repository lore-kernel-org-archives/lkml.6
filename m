Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753330AbeCNFas (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 01:30:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40386 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbeCNFaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 01:30:46 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4C3956016D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=architt@codeaurora.org
Subject: Re: [PATCH v5 03/36] drm/bridge: analogix_dp: Don't change psr while
 bridge is disabled
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
        hshi@chromium.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
 <20180309222327.18689-4-enric.balletbo@collabora.com>
From: Archit Taneja <architt@codeaurora.org>
Message-ID: <8e68b2ae-21f8-ed3f-1804-f3d1978f8ce2@codeaurora.org>
Date: Wed, 14 Mar 2018 11:00:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309222327.18689-4-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday 10 March 2018 03:52 AM, Enric Balletbo i Serra wrote:
> From: zain wang <wzz@rock-chips.com>
> 
> There is a race between AUX CH bring-up and enabling bridge which will
> cause link training to fail. To avoid hitting it, don't change psr state
> while enabling the bridge.

Reviewed-by: Archit Taneja <architt@codeaurora.org>
> 
> Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Cc: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: zain wang <wzz@rock-chips.com>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> [seanpaul fixed up the commit message a bit and renamed *_supported to *_enabled]
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> 
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 15 ++++++++-------
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |  2 +-
>   drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |  2 +-
>   include/drm/bridge/analogix_dp.h                   |  2 +-
>   4 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index e738aa6de1af..ee00d3d920e0 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -98,18 +98,18 @@ static int analogix_dp_detect_hpd(struct analogix_dp_device *dp)
>   	return 0;
>   }
>   
> -int analogix_dp_psr_supported(struct analogix_dp_device *dp)
> +int analogix_dp_psr_enabled(struct analogix_dp_device *dp)
>   {
>   
> -	return dp->psr_support;
> +	return dp->psr_enable;
>   }
> -EXPORT_SYMBOL_GPL(analogix_dp_psr_supported);
> +EXPORT_SYMBOL_GPL(analogix_dp_psr_enabled);
>   
>   int analogix_dp_enable_psr(struct analogix_dp_device *dp)
>   {
>   	struct edp_vsc_psr psr_vsc;
>   
> -	if (!dp->psr_support)
> +	if (!dp->psr_enable)
>   		return 0;
>   
>   	/* Prepare VSC packet as per EDP 1.4 spec, Table 6.9 */
> @@ -131,7 +131,7 @@ int analogix_dp_disable_psr(struct analogix_dp_device *dp)
>   	struct edp_vsc_psr psr_vsc;
>   	int ret;
>   
> -	if (!dp->psr_support)
> +	if (!dp->psr_enable)
>   		return 0;
>   
>   	/* Prepare VSC packet as per EDP 1.4 spec, Table 6.9 */
> @@ -871,8 +871,8 @@ static void analogix_dp_commit(struct analogix_dp_device *dp)
>   	/* Enable video */
>   	analogix_dp_start_video(dp);
>   
> -	dp->psr_support = analogix_dp_detect_sink_psr(dp);
> -	if (dp->psr_support)
> +	dp->psr_enable = analogix_dp_detect_sink_psr(dp);
> +	if (dp->psr_enable)
>   		analogix_dp_enable_sink_psr(dp);
>   }
>   
> @@ -1117,6 +1117,7 @@ static void analogix_dp_bridge_disable(struct drm_bridge *bridge)
>   	if (ret)
>   		DRM_ERROR("failed to setup the panel ret = %d\n", ret);
>   
> +	dp->psr_enable = false;
>   	dp->dpms_mode = DRM_MODE_DPMS_OFF;
>   }
>   
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> index b039b28d8fcc..e135a42cb19e 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> @@ -170,7 +170,7 @@ struct analogix_dp_device {
>   	int			dpms_mode;
>   	int			hpd_gpio;
>   	bool                    force_hpd;
> -	bool			psr_support;
> +	bool			psr_enable;
>   
>   	struct mutex		panel_lock;
>   	bool			panel_is_modeset;
> diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> index 36334839a3f8..3e8bf79bea58 100644
> --- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> @@ -82,7 +82,7 @@ static void analogix_dp_psr_set(struct drm_encoder *encoder, bool enabled)
>   	struct rockchip_dp_device *dp = to_dp(encoder);
>   	int ret;
>   
> -	if (!analogix_dp_psr_supported(dp->adp))
> +	if (!analogix_dp_psr_enabled(dp->adp))
>   		return;
>   
>   	DRM_DEV_DEBUG(dp->dev, "%s PSR...\n", enabled ? "Entry" : "Exit");
> diff --git a/include/drm/bridge/analogix_dp.h b/include/drm/bridge/analogix_dp.h
> index 711fff9b6803..e9a1116d2f8e 100644
> --- a/include/drm/bridge/analogix_dp.h
> +++ b/include/drm/bridge/analogix_dp.h
> @@ -41,7 +41,7 @@ struct analogix_dp_plat_data {
>   			 struct drm_connector *);
>   };
>   
> -int analogix_dp_psr_supported(struct analogix_dp_device *dp);
> +int analogix_dp_psr_enabled(struct analogix_dp_device *dp);
>   int analogix_dp_enable_psr(struct analogix_dp_device *dp);
>   int analogix_dp_disable_psr(struct analogix_dp_device *dp);
>   
> 
