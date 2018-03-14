Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751983AbeCNF3r (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 01:29:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38846 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750786AbeCNF3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 01:29:44 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2F5FE6016D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=architt@codeaurora.org
Subject: Re: [PATCH v5 01/36] drm/bridge: analogix_dp: detect Sink PSR state
 after configuring the PSR
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        inki.dae@samsung.com, thierry.reding@gmail.com, hjc@rock-chips.com,
        seanpaul@chromium.org, airlied@linux.ie, tfiga@chromium.org,
        heiko@sntech.de
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        ykk@rock-chips.com, kernel@collabora.com, m.szyprowski@samsung.com,
        linux-samsung-soc@vger.kernel.org, jy0922.shim@samsung.com,
        rydberg@bitmath.org, krzk@kernel.org,
        linux-rockchip@lists.infradead.org, kgene@kernel.org,
        linux-input@vger.kernel.org, orjan.eide@arm.com, wxt@rock-chips.com,
        jeffy.chen@rock-chips.com,
        =?UTF-8?Q?St=c3=a9phane_Marchesin?= <marcheu@chromium.org>,
        linux-arm-kernel@lists.infradead.org, mark.yao@rock-chips.com,
        wzz@rock-chips.com, hl@rock-chips.com, jingoohan1@gmail.com,
        sw0312.kim@samsung.com, dianders@chromium.org,
        kyungmin.park@samsung.com, kuankuan.y@gmail.com, hshi@chromium.org
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
 <20180309222327.18689-2-enric.balletbo@collabora.com>
From: Archit Taneja <architt@codeaurora.org>
Message-ID: <c2a7ac1d-5021-508a-18bc-cf61ca676688@codeaurora.org>
Date: Wed, 14 Mar 2018 10:59:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309222327.18689-2-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday 10 March 2018 03:52 AM, Enric Balletbo i Serra wrote:
> From: Yakir Yang <ykk@rock-chips.com>
> 
> Make sure the request PSR state takes effect in analogix_dp_send_psr_spd()
> function, or print the sink PSR error state if we failed to apply the
> requested PSR setting.

Reviewed-by: Archit Taneja <architt@codeaurora.org>

> 
> Cc: 征增 王 <wzz@rock-chips.com>
> Cc: Stéphane Marchesin <marcheu@chromium.org>
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> [seanpaul changed timeout loop to a readx poll]
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> 
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  6 ++--
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |  6 ++--
>   drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c  | 35 +++++++++++++++++++---
>   3 files changed, 37 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index a693ab3078f0..e738aa6de1af 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -122,8 +122,7 @@ int analogix_dp_enable_psr(struct analogix_dp_device *dp)
>   	psr_vsc.DB0 = 0;
>   	psr_vsc.DB1 = EDP_VSC_PSR_STATE_ACTIVE | EDP_VSC_PSR_CRC_VALUES_VALID;
>   
> -	analogix_dp_send_psr_spd(dp, &psr_vsc);
> -	return 0;
> +	return analogix_dp_send_psr_spd(dp, &psr_vsc);
>   }
>   EXPORT_SYMBOL_GPL(analogix_dp_enable_psr);
>   
> @@ -149,8 +148,7 @@ int analogix_dp_disable_psr(struct analogix_dp_device *dp)
>   	if (ret != 1)
>   		dev_err(dp->dev, "Failed to set DP Power0 %d\n", ret);
>   
> -	analogix_dp_send_psr_spd(dp, &psr_vsc);
> -	return 0;
> +	return analogix_dp_send_psr_spd(dp, &psr_vsc);
>   }
>   EXPORT_SYMBOL_GPL(analogix_dp_disable_psr);
>   
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> index 5c6a28806129..b039b28d8fcc 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> @@ -20,6 +20,8 @@
>   #define MAX_CR_LOOP 5
>   #define MAX_EQ_LOOP 5
>   
> +#define DP_TIMEOUT_PSR_LOOP_MS			300
> +
>   /* DP_MAX_LANE_COUNT */
>   #define DPCD_ENHANCED_FRAME_CAP(x)		(((x) >> 7) & 0x1)
>   #define DPCD_MAX_LANE_COUNT(x)			((x) & 0x1f)
> @@ -247,8 +249,8 @@ void analogix_dp_config_video_slave_mode(struct analogix_dp_device *dp);
>   void analogix_dp_enable_scrambling(struct analogix_dp_device *dp);
>   void analogix_dp_disable_scrambling(struct analogix_dp_device *dp);
>   void analogix_dp_enable_psr_crc(struct analogix_dp_device *dp);
> -void analogix_dp_send_psr_spd(struct analogix_dp_device *dp,
> -			      struct edp_vsc_psr *vsc);
> +int analogix_dp_send_psr_spd(struct analogix_dp_device *dp,
> +			     struct edp_vsc_psr *vsc);
>   ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
>   			     struct drm_dp_aux_msg *msg);
>   
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> index 303083ad28e3..005a3f7005d2 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> @@ -10,10 +10,11 @@
>    * option) any later version.
>    */
>   
> -#include <linux/device.h>
> -#include <linux/io.h>
>   #include <linux/delay.h>
> +#include <linux/device.h>
>   #include <linux/gpio.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
>   
>   #include <drm/bridge/analogix_dp.h>
>   
> @@ -992,10 +993,25 @@ void analogix_dp_enable_psr_crc(struct analogix_dp_device *dp)
>   	writel(PSR_VID_CRC_ENABLE, dp->reg_base + ANALOGIX_DP_CRC_CON);
>   }
>   
> -void analogix_dp_send_psr_spd(struct analogix_dp_device *dp,
> -			      struct edp_vsc_psr *vsc)
> +static ssize_t analogix_dp_get_psr_status(struct analogix_dp_device *dp)
> +{
> +	ssize_t val;
> +	u8 status;
> +
> +	val = drm_dp_dpcd_readb(&dp->aux, DP_PSR_STATUS, &status);
> +	if (val < 0) {
> +		dev_err(dp->dev, "PSR_STATUS read failed ret=%zd", val);
> +		return val;
> +	}
> +	return status;
> +}
> +
> +int analogix_dp_send_psr_spd(struct analogix_dp_device *dp,
> +			     struct edp_vsc_psr *vsc)
>   {
>   	unsigned int val;
> +	int ret;
> +	ssize_t psr_status;
>   
>   	/* don't send info frame */
>   	val = readl(dp->reg_base + ANALOGIX_DP_PKT_SEND_CTL);
> @@ -1036,6 +1052,17 @@ void analogix_dp_send_psr_spd(struct analogix_dp_device *dp,
>   	val = readl(dp->reg_base + ANALOGIX_DP_PKT_SEND_CTL);
>   	val |= IF_EN;
>   	writel(val, dp->reg_base + ANALOGIX_DP_PKT_SEND_CTL);
> +
> +	ret = readx_poll_timeout(analogix_dp_get_psr_status, dp, psr_status,
> +		psr_status >= 0 &&
> +		((vsc->DB1 && psr_status == DP_PSR_SINK_ACTIVE_RFB) ||
> +		(!vsc->DB1 && psr_status == DP_PSR_SINK_INACTIVE)), 1500,
> +		DP_TIMEOUT_PSR_LOOP_MS * 1000);
> +	if (ret) {
> +		dev_warn(dp->dev, "Failed to apply PSR %d\n", ret);
> +		return ret;
> +	}
> +	return 0;
>   }
>   
>   ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
> 
