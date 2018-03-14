Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753372AbeCNGDX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 02:03:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53582 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbeCNGDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 02:03:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2D9CC60314
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=architt@codeaurora.org
Subject: Re: [PATCH v5 09/36] drm/bridge: analogix_dp: Don't use fast link
 training when panel just powered up
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
        hshi@chromium.org,
        =?UTF-8?Q?St=c3=a9phane_Marchesin?= <marcheu@chromium.org>
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
 <20180309222327.18689-10-enric.balletbo@collabora.com>
From: Archit Taneja <architt@codeaurora.org>
Message-ID: <b8d58bba-ac1d-f9b5-fb7f-70a529c9a918@codeaurora.org>
Date: Wed, 14 Mar 2018 11:33:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309222327.18689-10-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday 10 March 2018 03:53 AM, Enric Balletbo i Serra wrote:
> From: zain wang <wzz@rock-chips.com>
> 
> Panel would reset its setting when it powers down. It would forget the last
> succeeded link training setting. So we can't use the last successful link
> training setting to do fast link training. Let's reset fast_train_enable in
> analogix_dp_bridge_disable();
> 

Reviewed-by: Archit Taneja <architt@codeaurora.org>

Thanks,
Archit

> Cc: Stéphane Marchesin <marcheu@chromium.org>
> Signed-off-by: zain wang <wzz@rock-chips.com>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> 
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 9 +++++----
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.h | 2 +-
>   2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index f9661b410cb9..ea7a80a989c6 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -579,14 +579,14 @@ static int analogix_dp_process_equalizer_training(struct analogix_dp_device *dp)
>   		if (retval != 1) {
>   			dev_err(dp->dev, "failed to read downspread %d\n",
>   				retval);
> -			dp->fast_train_support = false;
> +			dp->fast_train_enable = false;
>   		} else {
> -			dp->fast_train_support =
> +			dp->fast_train_enable =
>   				(spread & DP_NO_AUX_HANDSHAKE_LINK_TRAINING) ?
>   					true : false;
>   		}
>   		dev_dbg(dp->dev, "fast link training %s\n",
> -			dp->fast_train_support ? "supported" : "unsupported");
> +			dp->fast_train_enable ? "supported" : "unsupported");
>   
>   		/* set enhanced mode if available */
>   		analogix_dp_set_enhanced_mode(dp);
> @@ -793,7 +793,7 @@ static int analogix_dp_fast_link_train(struct analogix_dp_device *dp)
>   
>   static int analogix_dp_train_link(struct analogix_dp_device *dp)
>   {
> -	if (dp->fast_train_support)
> +	if (dp->fast_train_enable)
>   		return analogix_dp_fast_link_train(dp);
>   
>   	return analogix_dp_full_link_train(dp, dp->video_info.max_lane_count,
> @@ -1197,6 +1197,7 @@ static void analogix_dp_bridge_disable(struct drm_bridge *bridge)
>   		DRM_ERROR("failed to setup the panel ret = %d\n", ret);
>   
>   	dp->psr_enable = false;
> +	dp->fast_train_enable = false;
>   	dp->dpms_mode = DRM_MODE_DPMS_OFF;
>   }
>   
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> index 6a96ef7e6934..403ff853464b 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> @@ -173,7 +173,7 @@ struct analogix_dp_device {
>   	int			hpd_gpio;
>   	bool                    force_hpd;
>   	bool			psr_enable;
> -	bool			fast_train_support;
> +	bool			fast_train_enable;
>   
>   	struct mutex		panel_lock;
>   	bool			panel_is_modeset;
> 
