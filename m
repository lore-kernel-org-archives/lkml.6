Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753411AbeCNGRe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 02:17:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42050 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753270AbeCNGRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 02:17:32 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 59D7E60314
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=architt@codeaurora.org
Subject: Re: [PATCH v5 15/36] drm/bridge: analogix_dp: Fix incorrect usage of
 enhanced mode
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
 <20180309222327.18689-16-enric.balletbo@collabora.com>
From: Archit Taneja <architt@codeaurora.org>
Message-ID: <4e001e69-576d-c284-fcfc-aad1bc60e28e@codeaurora.org>
Date: Wed, 14 Mar 2018 11:47:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309222327.18689-16-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday 10 March 2018 03:53 AM, Enric Balletbo i Serra wrote:
> From: zain wang <wzz@rock-chips.com>
> 
> Enhanced mode is required by the eDP 1.2 specification, and not doing it
> early could result in a period of time where we have a link transmitting
> idle packets without it. Since there is no reason to disable it, we just
> enable it at the beginning of link training and then keep it on all the
> time.

Reviewed-by: Archit Taneja <architt@codeaurora.org>

Thanks,
Archit

> 
> Cc: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: zain wang <wzz@rock-chips.com>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> 
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 6cbde8473f58..1eed35f9eb8d 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -281,6 +281,8 @@ static int analogix_dp_link_start(struct analogix_dp_device *dp)
>   	retval = drm_dp_dpcd_write(&dp->aux, DP_LINK_BW_SET, buf, 2);
>   	if (retval < 0)
>   		return retval;
> +	/* set enhanced mode if available */
> +	analogix_dp_set_enhanced_mode(dp);
>   
>   	/* Set TX pre-emphasis to minimum */
>   	for (lane = 0; lane < lane_count; lane++)
> @@ -593,8 +595,6 @@ static int analogix_dp_process_equalizer_training(struct analogix_dp_device *dp)
>   		dev_dbg(dp->dev, "fast link training %s\n",
>   			dp->fast_train_enable ? "supported" : "unsupported");
>   
> -		/* set enhanced mode if available */
> -		analogix_dp_set_enhanced_mode(dp);
>   		dp->link_train.lt_state = FINISHED;
>   
>   		return 0;
> @@ -940,8 +940,6 @@ static int analogix_dp_commit(struct analogix_dp_device *dp)
>   	}
>   
>   	analogix_dp_enable_scramble(dp, 1);
> -	analogix_dp_enable_rx_to_enhanced_mode(dp, 1);
> -	analogix_dp_enable_enhanced_mode(dp, 1);
>   
>   	analogix_dp_init_video(dp);
>   	ret = analogix_dp_config_video(dp);
> 
