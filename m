Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753417AbeCNGLF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 02:11:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36428 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbeCNGLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 02:11:02 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0B636607A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=architt@codeaurora.org
Subject: Re: [PATCH v5 12/36] drm/bridge: analogix_dp: Set PD_INC_BG first
 when powering up edp phy
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
 <20180309222327.18689-13-enric.balletbo@collabora.com>
From: Archit Taneja <architt@codeaurora.org>
Message-ID: <c43cba93-6068-6a2d-3d0a-85057d5f8b10@codeaurora.org>
Date: Wed, 14 Mar 2018 11:40:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309222327.18689-13-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday 10 March 2018 03:53 AM, Enric Balletbo i Serra wrote:
> From: zain wang <wzz@rock-chips.com>
> 
> Following the correct power up sequence:
> dp_pd=ff => dp_pd=7f => wait 10us => dp_pd=00
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
>   drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c | 10 ++++++++--
>   drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h |  3 +++
>   2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> index b47c5af43560..bb72f8b0e603 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> @@ -321,10 +321,16 @@ void analogix_dp_set_analog_power_down(struct analogix_dp_device *dp,
>   		break;
>   	case POWER_ALL:
>   		if (enable) {
> -			reg = DP_PHY_PD | AUX_PD | CH3_PD | CH2_PD |
> -				CH1_PD | CH0_PD;
> +			reg = DP_ALL_PD;
>   			writel(reg, dp->reg_base + phy_pd_addr);
>   		} else {
> +			reg = DP_ALL_PD;
> +			writel(reg, dp->reg_base + phy_pd_addr);
> +			usleep_range(10, 15);
> +			reg &= ~DP_INC_BG;
> +			writel(reg, dp->reg_base + phy_pd_addr);
> +			usleep_range(10, 15);
> +
>   			writel(0x00, dp->reg_base + phy_pd_addr);
>   		}
>   		break;
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h
> index 40200c652533..9602668669f4 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h
> @@ -342,12 +342,15 @@
>   #define DP_PLL_REF_BIT_1_2500V			(0x7 << 0)
>   
>   /* ANALOGIX_DP_PHY_PD */
> +#define DP_INC_BG				(0x1 << 7)
> +#define DP_EXP_BG				(0x1 << 6)
>   #define DP_PHY_PD				(0x1 << 5)
>   #define AUX_PD					(0x1 << 4)
>   #define CH3_PD					(0x1 << 3)
>   #define CH2_PD					(0x1 << 2)
>   #define CH1_PD					(0x1 << 1)
>   #define CH0_PD					(0x1 << 0)
> +#define DP_ALL_PD				(0xff)
>   
>   /* ANALOGIX_DP_PHY_TEST */
>   #define MACRO_RST				(0x1 << 5)
> 
