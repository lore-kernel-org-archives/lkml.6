Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753338AbeCNFyg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 01:54:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46534 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750934AbeCNFye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 01:54:34 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5273360314
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=architt@codeaurora.org
Subject: Re: [PATCH v5 06/36] drm/rockchip: Only wait for panel ACK on PSR
 entry
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
        Sonny Rao <sonnyrao@chromium.org>,
        linux-arm-kernel@lists.infradead.org, mark.yao@rock-chips.com,
        wzz@rock-chips.com, hl@rock-chips.com, jingoohan1@gmail.com,
        sw0312.kim@samsung.com, dianders@chromium.org,
        kyungmin.park@samsung.com, kuankuan.y@gmail.com, hshi@chromium.org
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
 <20180309222327.18689-7-enric.balletbo@collabora.com>
From: Archit Taneja <architt@codeaurora.org>
Message-ID: <5738638a-08d6-6be0-51fd-e573cb0f793a@codeaurora.org>
Date: Wed, 14 Mar 2018 11:24:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309222327.18689-7-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday 10 March 2018 03:52 AM, Enric Balletbo i Serra wrote:
> From: zain wang <wzz@rock-chips.com>
> 
> We currently wait for the panel to mirror our intended PSR state
> before continuing on both PSR enter and PSR exit. This is really
> only important to do when we're entering PSR, since we want to
> be sure the last frame we pushed is being served from the panel's
> internal fb before shutting down the soc blocks (vop/analogix).
> 
> This patch changes the behavior such that we only wait for the
> panel to complete the PSR transition when we're entering PSR, and
> to skip verification when we're exiting.
> 

With the subject fix:

Reviewed-by: Archit Taneja <architt@codeaurora.org>

Thanks,
Archit

> Cc: Stéphane Marchesin <marcheu@chromium.org>
> Cc: Sonny Rao <sonnyrao@chromium.org>
> Signed-off-by: zain wang <wzz@rock-chips.com>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> 
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 4 ++--
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.h | 2 +-
>   drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c  | 5 ++++-
>   3 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 806c3878b3d6..5a2e35dc41e3 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -125,7 +125,7 @@ int analogix_dp_enable_psr(struct analogix_dp_device *dp)
>   	psr_vsc.DB0 = 0;
>   	psr_vsc.DB1 = EDP_VSC_PSR_STATE_ACTIVE | EDP_VSC_PSR_CRC_VALUES_VALID;
>   
> -	return analogix_dp_send_psr_spd(dp, &psr_vsc);
> +	return analogix_dp_send_psr_spd(dp, &psr_vsc, true);
>   }
>   EXPORT_SYMBOL_GPL(analogix_dp_enable_psr);
>   
> @@ -151,7 +151,7 @@ int analogix_dp_disable_psr(struct analogix_dp_device *dp)
>   	if (ret != 1)
>   		dev_err(dp->dev, "Failed to set DP Power0 %d\n", ret);
>   
> -	return analogix_dp_send_psr_spd(dp, &psr_vsc);
> +	return analogix_dp_send_psr_spd(dp, &psr_vsc, false);
>   }
>   EXPORT_SYMBOL_GPL(analogix_dp_disable_psr);
>   
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> index 920607d7eb3e..6a96ef7e6934 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> @@ -253,7 +253,7 @@ void analogix_dp_enable_scrambling(struct analogix_dp_device *dp);
>   void analogix_dp_disable_scrambling(struct analogix_dp_device *dp);
>   void analogix_dp_enable_psr_crc(struct analogix_dp_device *dp);
>   int analogix_dp_send_psr_spd(struct analogix_dp_device *dp,
> -			     struct edp_vsc_psr *vsc);
> +			     struct edp_vsc_psr *vsc, bool blocking);
>   ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
>   			     struct drm_dp_aux_msg *msg);
>   
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> index 005a3f7005d2..9df2f3ef000c 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> @@ -1007,7 +1007,7 @@ static ssize_t analogix_dp_get_psr_status(struct analogix_dp_device *dp)
>   }
>   
>   int analogix_dp_send_psr_spd(struct analogix_dp_device *dp,
> -			     struct edp_vsc_psr *vsc)
> +			     struct edp_vsc_psr *vsc, bool blocking)
>   {
>   	unsigned int val;
>   	int ret;
> @@ -1053,6 +1053,9 @@ int analogix_dp_send_psr_spd(struct analogix_dp_device *dp,
>   	val |= IF_EN;
>   	writel(val, dp->reg_base + ANALOGIX_DP_PKT_SEND_CTL);
>   
> +	if (!blocking)
> +		return 0;
> +
>   	ret = readx_poll_timeout(analogix_dp_get_psr_status, dp, psr_status,
>   		psr_status >= 0 &&
>   		((vsc->DB1 && psr_status == DP_PSR_SINK_ACTIVE_RFB) ||
> 
