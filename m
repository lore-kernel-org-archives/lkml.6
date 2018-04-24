Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932722AbeDXB3M (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 21:29:12 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:43331 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932633AbeDXB3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 21:29:07 -0400
X-Google-Smtp-Source: AB8JxZo9hWvdzgkg0ymgcOvBqUaLuWUG9Jz82sg3zlkkqUkxLYS0jqhQuDZRb8xqH4f0Ddwz/S2t1Q==
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Enric Balletbo i Serra'" <enric.balletbo@collabora.com>,
        <architt@codeaurora.org>, <inki.dae@samsung.com>,
        <thierry.reding@gmail.com>, <hjc@rock-chips.com>,
        <seanpaul@chromium.org>, <airlied@linux.ie>, <tfiga@chromium.org>,
        <heiko@sntech.de>
Cc: <dri-devel@lists.freedesktop.org>, <dianders@chromium.org>,
        <a.hajda@samsung.com>, <kernel@collabora.com>,
        <m.szyprowski@samsung.com>, <linux-samsung-soc@vger.kernel.org>,
        <jy0922.shim@samsung.com>, <rydberg@bitmath.org>, <krzk@kernel.org>,
        <linux-rockchip@lists.infradead.org>, <kgene@kernel.org>,
        <orjan.eide@arm.com>, <wxt@rock-chips.com>,
        <jeffy.chen@rock-chips.com>, <linux-arm-kernel@lists.infradead.org>,
        <wzz@rock-chips.com>, <hl@rock-chips.com>, <sw0312.kim@samsung.com>,
        <linux-kernel@vger.kernel.org>, <kyungmin.park@samsung.com>,
        <Laurent.pinchart@ideasonboard.com>, <kuankuan.y@gmail.com>,
        <hshi@chromium.org>
References: <20180423105003.9004-1-enric.balletbo@collabora.com> <20180423105003.9004-17-enric.balletbo@collabora.com>
In-Reply-To: <20180423105003.9004-17-enric.balletbo@collabora.com>
Subject: Re: [RESEND PATCH v6 16/27] drm/bridge: analogix_dp: Fix incorrect operations with register ANALOGIX_DP_FUNC_EN_1
Date: Mon, 23 Apr 2018 21:29:04 -0400
Message-ID: <000101d3db6b$a2a14d20$e7e3e760$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJsKqzGdLQ3B8H319FIYPcigFOt/AGIBhyXotJBg1A=
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 23, 2018 6:50 AM, Enric Balletbo i Serra wrote:
> 
> From: zain wang <wzz@rock-chips.com>
> 
> Register ANALOGIX_DP_FUNC_EN_1(offset 0x18), Rockchip is different to
> Exynos:
> 
> on Exynos edp phy,
> BIT 7		MASTER_VID_FUNC_EN_N
> BIT 6		reserved
> BIT 5		SLAVE_VID_FUNC_EN_N
> 
> on Rockchip edp phy,
> BIT 7		reserved
> BIT 6		RK_VID_CAP_FUNC_EN_N
> BIT 5		RK_VID_FIFO_FUNC_EN_N
> 
> So, we should do some private operations to Rockchip.
> 
> Cc: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: zain wang <wzz@rock-chips.com>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Archit Taneja <architt@codeaurora.org>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> ---
> 
>  .../gpu/drm/bridge/analogix/analogix_dp_reg.c | 19 ++++++++++++++-----
>  .../gpu/drm/bridge/analogix/analogix_dp_reg.h |  2 ++
>  2 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> index 02ab1aaa9993..4eae206ec31b 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> @@ -126,9 +126,14 @@ void analogix_dp_reset(struct analogix_dp_device *dp)
>  	analogix_dp_stop_video(dp);
>  	analogix_dp_enable_video_mute(dp, 0);
> 
> -	reg = MASTER_VID_FUNC_EN_N | SLAVE_VID_FUNC_EN_N |
> -		AUD_FIFO_FUNC_EN_N | AUD_FUNC_EN_N |
> -		HDCP_FUNC_EN_N | SW_FUNC_EN_N;
> +	if (dp->plat_data && is_rockchip(dp->plat_data->dev_type))
> +		reg = RK_VID_CAP_FUNC_EN_N | RK_VID_FIFO_FUNC_EN_N |
> +			SW_FUNC_EN_N;
> +	else
> +		reg = MASTER_VID_FUNC_EN_N | SLAVE_VID_FUNC_EN_N |
> +			AUD_FIFO_FUNC_EN_N | AUD_FUNC_EN_N |
> +			HDCP_FUNC_EN_N | SW_FUNC_EN_N;
> +
>  	writel(reg, dp->reg_base + ANALOGIX_DP_FUNC_EN_1);
> 
>  	reg = SSC_FUNC_EN_N | AUX_FUNC_EN_N |
> @@ -971,8 +976,12 @@ void analogix_dp_config_video_slave_mode(struct
> analogix_dp_device *dp)
>  	u32 reg;
> 
>  	reg = readl(dp->reg_base + ANALOGIX_DP_FUNC_EN_1);
> -	reg &= ~(MASTER_VID_FUNC_EN_N | SLAVE_VID_FUNC_EN_N);
> -	reg |= MASTER_VID_FUNC_EN_N;
> +	if (dp->plat_data && is_rockchip(dp->plat_data->dev_type)) {
> +		reg &= ~(RK_VID_CAP_FUNC_EN_N | RK_VID_FIFO_FUNC_EN_N);
> +	} else {
> +		reg &= ~(MASTER_VID_FUNC_EN_N | SLAVE_VID_FUNC_EN_N);
> +		reg |= MASTER_VID_FUNC_EN_N;
> +	}
>  	writel(reg, dp->reg_base + ANALOGIX_DP_FUNC_EN_1);
> 
>  	reg = readl(dp->reg_base + ANALOGIX_DP_VIDEO_CTL_10);
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h
> b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h
> index b633a4a5082a..0cf27c731727 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h
> @@ -127,7 +127,9 @@
> 
>  /* ANALOGIX_DP_FUNC_EN_1 */
>  #define MASTER_VID_FUNC_EN_N			(0x1 << 7)
> +#define RK_VID_CAP_FUNC_EN_N			(0x1 << 6)
>  #define SLAVE_VID_FUNC_EN_N			(0x1 << 5)
> +#define RK_VID_FIFO_FUNC_EN_N			(0x1 << 5)
>  #define AUD_FIFO_FUNC_EN_N			(0x1 << 4)
>  #define AUD_FUNC_EN_N				(0x1 << 3)
>  #define HDCP_FUNC_EN_N				(0x1 << 2)
> --
> 2.17.0
