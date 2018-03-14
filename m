Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753500AbeCNGyH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 02:54:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44362 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753320AbeCNGyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 02:54:05 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B283D60452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=architt@codeaurora.org
Subject: Re: [PATCH v5 26/36] drm/bridge: analogix_dp: Properly disable aux
 chan retries on rockchip
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
 <20180309222327.18689-27-enric.balletbo@collabora.com>
From: Archit Taneja <architt@codeaurora.org>
Message-ID: <4044e328-09e4-a0d1-61d4-164fed221c8f@codeaurora.org>
Date: Wed, 14 Mar 2018 12:23:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309222327.18689-27-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday 10 March 2018 03:53 AM, Enric Balletbo i Serra wrote:
> From: Douglas Anderson <dianders@chromium.org>
> 
> The comments in analogix_dp_init_aux() claim that we're disabling aux
> channel retries, but then right below it for Rockchip it sets them to
> 3.  If we actually need 3 retries for Rockchip then we could adjust
> the comment, but it seems more likely that we want the same retry
> behavior across all platforms.

Reviewed-by: Archit Taneja <architt@codeaurora.org>

Thanks,
Archit

> 
> Cc: Stéphane Marchesin <marcheu@chromium.org>
> Cc: 征增 王 <wzz@rock-chips.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> 
>   drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> index 58e8a28e99aa..a5f2763d72e4 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> @@ -481,15 +481,16 @@ void analogix_dp_init_aux(struct analogix_dp_device *dp)
>   
>   	analogix_dp_reset_aux(dp);
>   
> -	/* Disable AUX transaction H/W retry */
> +	/* AUX_BIT_PERIOD_EXPECTED_DELAY doesn't apply to Rockchip IP */
>   	if (dp->plat_data && is_rockchip(dp->plat_data->dev_type))
> -		reg = AUX_BIT_PERIOD_EXPECTED_DELAY(0) |
> -		      AUX_HW_RETRY_COUNT_SEL(3) |
> -		      AUX_HW_RETRY_INTERVAL_600_MICROSECONDS;
> +		reg = 0;
>   	else
> -		reg = AUX_BIT_PERIOD_EXPECTED_DELAY(3) |
> -		      AUX_HW_RETRY_COUNT_SEL(0) |
> -		      AUX_HW_RETRY_INTERVAL_600_MICROSECONDS;
> +		reg = AUX_BIT_PERIOD_EXPECTED_DELAY(3);
> +
> +	/* Disable AUX transaction H/W retry */
> +	reg |= AUX_HW_RETRY_COUNT_SEL(0) |
> +	       AUX_HW_RETRY_INTERVAL_600_MICROSECONDS;
> +
>   	writel(reg, dp->reg_base + ANALOGIX_DP_AUX_HW_RETRY_CTL);
>   
>   	/* Receive AUX Channel DEFER commands equal to DEFFER_COUNT*64 */
> 
