Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753462AbeCNGdy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 02:33:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54066 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeCNGdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 02:33:51 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BCEC360FEC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=architt@codeaurora.org
Subject: Re: [PATCH v5 21/36] drm/bridge: analogix_dp: Fix timeout of video
 streamclk config
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
 <20180309222327.18689-22-enric.balletbo@collabora.com>
From: Archit Taneja <architt@codeaurora.org>
Message-ID: <bc8ae3e2-b100-0515-2fa7-e02ba269f559@codeaurora.org>
Date: Wed, 14 Mar 2018 12:03:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309222327.18689-22-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday 10 March 2018 03:53 AM, Enric Balletbo i Serra wrote:
> From: zain wang <wzz@rock-chips.com>
> 
> The STRM_VALID bit in register ANALOGIX_DP_SYS_CTL_3 may be unstable,
> so we may hit the error log "Timeout of video streamclk ok" since
> checked this unstable bit.
> In fact, we can go continue and the streamclk is ok if we wait enough time,
> it does no effect on display.
> Let's change this error to warn.

Reviewed-by: Archit Taneja <architt@codeaurora.org>

Thanks,
Archit

> 
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: zain wang <wzz@rock-chips.com>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> 
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 1f1cb624414d..d76e1652b1fd 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -921,8 +921,9 @@ static int analogix_dp_config_video(struct analogix_dp_device *dp)
>   			done_count = 0;
>   		}
>   		if (timeout_loop > DP_TIMEOUT_LOOP_COUNT) {
> -			dev_err(dp->dev, "Timeout of video streamclk ok\n");
> -			return -ETIMEDOUT;
> +			dev_warn(dp->dev,
> +				 "Ignoring timeout of video streamclk ok\n");
> +			break;
>   		}
>   
>   		usleep_range(1000, 1001);
> 
