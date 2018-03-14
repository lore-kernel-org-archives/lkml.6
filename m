Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753403AbeCNGu2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 02:50:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38466 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbeCNGu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 02:50:26 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B0BAA60390
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=architt@codeaurora.org
Subject: Re: [PATCH v5 24/36] drm/bridge: analogix_dp: Reorder
 plat_data->power_off to happen sooner
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
        hshi@chromium.org, "Kristian H . Kristensen" <hoegsberg@chromium.org>
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
 <20180309222327.18689-25-enric.balletbo@collabora.com>
From: Archit Taneja <architt@codeaurora.org>
Message-ID: <6411add8-32ee-a365-9882-061c1383ffd0@codeaurora.org>
Date: Wed, 14 Mar 2018 12:20:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309222327.18689-25-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday 10 March 2018 03:53 AM, Enric Balletbo i Serra wrote:
> From: Douglas Anderson <dianders@chromium.org>
> 
> The current user of the analogix power_off is "analogix_dp-rockchip".
> That driver does this:
> - deactivate PSR
> - turn off a clock
> 
> Both of these things (especially deactive PSR) should be done before
> we turn the PHY power off and turn off analog power.  Let's move the
> callback up.
> 
> Note that without this patch (and with
> https://patchwork.kernel.org/patch/9553349/ [seanpaul: this patch was
> not applied, but it seems like the race can still occur]), I experienced
> an error in reboot testing where one thread was at:
> 
>    rockchip_drm_psr_deactivate
>    rockchip_dp_powerdown
>    analogix_dp_bridge_disable
>    drm_bridge_disable
> 
> ...and the other thread was at:
> 
>    analogix_dp_send_psr_spd
>    analogix_dp_enable_psr
>    analogix_dp_psr_set
>    psr_flush_handler
> 
> The flush handler thread was finding AUX channel errors and eventually
> reported "Failed to apply PSR", where I had a kgdb breakpoint. Presumably
> the device would have eventually given up and shut down anyway, but it
> seems better to fix the order to be more correct.
> 

Reviewed-by: Archit Taneja <architt@codeaurora.org>

Thanks,
Archit

> Cc: Kristian H. Kristensen <hoegsberg@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
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
> index 37b16643f14c..eaf93cbd47a8 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1337,12 +1337,13 @@ static void analogix_dp_bridge_disable(struct drm_bridge *bridge)
>   	}
>   
>   	disable_irq(dp->irq);
> -	analogix_dp_set_analog_power_down(dp, POWER_ALL, 1);
> -	phy_power_off(dp->phy);
>   
>   	if (dp->plat_data->power_off)
>   		dp->plat_data->power_off(dp->plat_data);
>   
> +	analogix_dp_set_analog_power_down(dp, POWER_ALL, 1);
> +	phy_power_off(dp->phy);
> +
>   	clk_disable_unprepare(dp->clock);
>   
>   	pm_runtime_put_sync(dp->dev);
> 
