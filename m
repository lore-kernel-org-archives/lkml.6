Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752723AbeB1PVN convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 10:21:13 -0500
Received: from gloria.sntech.de ([95.129.55.99]:57456 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932104AbeB1PVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:21:12 -0500
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Thierry Escande <thierry.escande@collabora.com>,
        Archit Taneja <architt@codeaurora.org>,
        Inki Dae <inki.dae@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandy Huang <hjc@rock-chips.com>, Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>, Tomasz Figa <tfiga@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Zain Wang <wzz@rock-chips.com>, Lin Huang <hl@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yakir Yang <ykk@rock-chips.com>,
        =?ISO-8859-1?Q?=D8rjan?= Eide <orjan.eide@arm.com>,
        Mark Yao <mark.yao@rock-chips.com>, Haixia Shi <hshi@chromium.org>
Subject: Re: [PATCH v3 05/43] drm/bridge: analogix_dp: Don't power bridge in analogix_dp_bind
Date: Wed, 28 Feb 2018 16:20:57 +0100
Message-ID: <19741148.ZWsFISTM5I@diego>
In-Reply-To: <20180130202913.28724-6-thierry.escande@collabora.com>
References: <20180130202913.28724-1-thierry.escande@collabora.com> <20180130202913.28724-6-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 30. Januar 2018, 21:28:35 CET schrieb Thierry Escande:
> From: zain wang <wzz@rock-chips.com>
> 
> The bridge does not need to be powered in analogix_dp_bind(), so
> remove the calls to pm_runtime_get()/phy_power_on()/analogix_dp_init_dp()
> as well as their power-off counterparts.
> 
> Cc: Stéphane Marchesin <marcheu@chromium.org>
> Signed-off-by: zain wang <wzz@rock-chips.com>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> [the patch originally just removed the power_on portion, seanpaul removed
> the power off code as well as improved the commit message]
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> ---
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c index
> cb5e18d6ba04..1477ea9ba85d 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1382,11 +1382,6 @@ analogix_dp_bind(struct device *dev, struct
> drm_device *drm_dev,
> 
>  	pm_runtime_enable(dev);
> 
> -	pm_runtime_get_sync(dev);
> -	phy_power_on(dp->phy);
> -
> -	analogix_dp_init_dp(dp);
> -
>  	ret = devm_request_threaded_irq(&pdev->dev, dp->irq,
>  					analogix_dp_hardirq,
>  					analogix_dp_irq_thread,
> @@ -1414,15 +1409,10 @@ analogix_dp_bind(struct device *dev, struct
> drm_device *drm_dev, goto err_disable_pm_runtime;
>  	}
> 
> -	phy_power_off(dp->phy);
> -	pm_runtime_put(dev);
> -
>  	return dp;
> 
>  err_disable_pm_runtime:
> 
> -	phy_power_off(dp->phy);
> -	pm_runtime_put(dev);
>  	pm_runtime_disable(dev);
> 
>  	return ERR_PTR(ret);

In general, this patch seems to also create the opposite than
"drm/bridge: analogix_dp: Keep PHY powered between driver bind/unbind" [0]

posted on monday?

[0] https://patchwork.kernel.org/patch/10242493/
