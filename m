Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753355AbeCNGAS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 02:00:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49954 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751461AbeCNGAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 02:00:15 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 96C3360314
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=architt@codeaurora.org
Subject: Re: [PATCH v5 07/36] drm/bridge: analogix_dp: Move enable video into
 config_video()
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
 <20180309222327.18689-8-enric.balletbo@collabora.com>
From: Archit Taneja <architt@codeaurora.org>
Message-ID: <79009f48-d677-ccc0-4d61-3b379d8448a8@codeaurora.org>
Date: Wed, 14 Mar 2018 11:29:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309222327.18689-8-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday 10 March 2018 03:52 AM, Enric Balletbo i Serra wrote:
> From: Lin Huang <hl@rock-chips.com>
> 
> We need to enable video before analogix_dp_is_video_stream_on(), so
> we can get the right video stream status.
> 
> Cc: 征增 王 <wzz@rock-chips.com>
> Cc: Stéphane Marchesin <marcheu@chromium.org>
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> 
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 5a2e35dc41e3..f9661b410cb9 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -819,11 +819,10 @@ static int analogix_dp_config_video(struct analogix_dp_device *dp)
>   		if (analogix_dp_is_slave_video_stream_clock_on(dp) == 0)
>   			break;
>   		if (timeout_loop > DP_TIMEOUT_LOOP_COUNT) {
> -			dev_err(dp->dev, "Timeout of video streamclk ok\n");
> +			dev_err(dp->dev, "Timeout of slave video streamclk ok\n");
>   			return -ETIMEDOUT;
>   		}
> -
> -		usleep_range(1, 2);
> +		usleep_range(1000, 1001);

Could we briefly explain in the commit message why we need to increase
the delay in the timeout loop? Is it a consequence of calling
analogix_dp_start_video() earlier, or is this the preferred time
mentioned in the specs?

Thanks,
Archit

>   	}
>   
>   	/* Set to use the register calculated M/N video */
> @@ -838,6 +837,9 @@ static int analogix_dp_config_video(struct analogix_dp_device *dp)
>   	/* Configure video slave mode */
>   	analogix_dp_enable_video_master(dp, 0);
>   
> +	/* Enable video */
> +	analogix_dp_start_video(dp);
> +
>   	timeout_loop = 0;
>   
>   	for (;;) {
> @@ -948,9 +950,6 @@ static void analogix_dp_commit(struct analogix_dp_device *dp)
>   			DRM_ERROR("failed to enable the panel\n");
>   	}
>   
> -	/* Enable video */
> -	analogix_dp_start_video(dp);
> -
>   	dp->psr_enable = analogix_dp_detect_sink_psr(dp);
>   	if (dp->psr_enable)
>   		analogix_dp_enable_sink_psr(dp);
> 
