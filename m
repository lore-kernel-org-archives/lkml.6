Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753441AbeCNGdS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 02:33:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52738 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeCNGdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 02:33:16 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 12C77607A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=architt@codeaurora.org
Subject: Re: [PATCH v5 20/36] drm/bridge: analogix_dp: Don't use
 ANALOGIX_DP_PLL_CTL to control pll
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
 <20180309222327.18689-21-enric.balletbo@collabora.com>
From: Archit Taneja <architt@codeaurora.org>
Message-ID: <d6e35524-3eb6-8fa6-21c3-9f9463365236@codeaurora.org>
Date: Wed, 14 Mar 2018 12:03:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309222327.18689-21-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday 10 March 2018 03:53 AM, Enric Balletbo i Serra wrote:
> From: zain wang <wzz@rock-chips.com>
> 
> There is no register named ANALOGIX_DP_PLL_CTL in Rockchip edp phy reg
> list.  We should use BIT_4 in ANALOGIX_DP_PD to control the pll power
> instead of ANALOGIX_DP_PLL_CTL.
> 

Reviewed-by: Archit Taneja <architt@codeaurora.org>

Thanks,
Archit

> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: zain wang <wzz@rock-chips.com>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> 
>   drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> index 7b7fd227e1f9..02ab1aaa9993 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> @@ -230,16 +230,20 @@ enum pll_status analogix_dp_get_pll_lock_status(struct analogix_dp_device *dp)
>   void analogix_dp_set_pll_power_down(struct analogix_dp_device *dp, bool enable)
>   {
>   	u32 reg;
> +	u32 mask = DP_PLL_PD;
> +	u32 pd_addr = ANALOGIX_DP_PLL_CTL;
>   
> -	if (enable) {
> -		reg = readl(dp->reg_base + ANALOGIX_DP_PLL_CTL);
> -		reg |= DP_PLL_PD;
> -		writel(reg, dp->reg_base + ANALOGIX_DP_PLL_CTL);
> -	} else {
> -		reg = readl(dp->reg_base + ANALOGIX_DP_PLL_CTL);
> -		reg &= ~DP_PLL_PD;
> -		writel(reg, dp->reg_base + ANALOGIX_DP_PLL_CTL);
> +	if (dp->plat_data && is_rockchip(dp->plat_data->dev_type)) {
> +		pd_addr = ANALOGIX_DP_PD;
> +		mask = RK_PLL_PD;
>   	}
> +
> +	reg = readl(dp->reg_base + pd_addr);
> +	if (enable)
> +		reg |= mask;
> +	else
> +		reg &= ~mask;
> +	writel(reg, dp->reg_base + pd_addr);
>   }
>   
>   void analogix_dp_set_analog_power_down(struct analogix_dp_device *dp,
> 
