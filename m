Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032706AbeCAPu3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 10:50:29 -0500
Received: from gloria.sntech.de ([95.129.55.99]:49232 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031899AbeCAPu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 10:50:28 -0500
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: dri-devel@lists.freedesktop.org
Cc: Thierry Escande <thierry.escande@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sandy Huang <hjc@rock-chips.com>, linux-rockchip@lists.infradead.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org,
        enric.balletbo@collabora.com
Subject: Re: [PATCH v8 4/8] drm/rockchip: dw-mipi-dsi: Fix error handling path
Date: Thu, 01 Mar 2018 16:50:18 +0100
Message-ID: <13219770.NOTAg9tncx@diego>
In-Reply-To: <20180110162348.22765-5-thierry.escande@collabora.com>
References: <20180110162348.22765-1-thierry.escande@collabora.com> <20180110162348.22765-5-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeffy, Thierry, Enric,

Am Mittwoch, 10. Januar 2018, 17:23:44 CET schrieb Thierry Escande:
> From: Jeffy Chen <jeffy.chen@rock-chips.com>
> 
> Add missing pm_runtime_disable() in bind()'s error handling path.
> 
> Also cleanup encoder & connector in unbind().

Can you please split all these surprise "Also" sections into separate
patches?

It looks like this is true for all following patch to some degree and
the inno-hdmi patch even has a unbind reordering-change without
mentioning it in the commit message.


Thanks
Heiko

> Fixes: 80a9a059d4e4 ("drm/rockchip/dsi: add dw-mipi power domain support")
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> ---
>  drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c index b1fe0639227e..78e6b7919bf7
> 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> @@ -1282,7 +1282,7 @@ static int dw_mipi_dsi_bind(struct device *dev, struct
> device *master, ret = dw_mipi_dsi_register(drm, dsi);
>  	if (ret) {
>  		DRM_DEV_ERROR(dev, "Failed to register mipi_dsi: %d\n", ret);
> -		goto err_pllref;
> +		goto err_disable_pllref;
>  	}
> 
>  	dsi->dsi_host.ops = &dw_mipi_dsi_host_ops;
> @@ -1290,24 +1290,25 @@ static int dw_mipi_dsi_bind(struct device *dev,
> struct device *master, ret = mipi_dsi_host_register(&dsi->dsi_host);
>  	if (ret) {
>  		DRM_DEV_ERROR(dev, "Failed to register MIPI host: %d\n", ret);
> -		goto err_cleanup;
> +		goto err_disable_pm_runtime;
>  	}
> 
>  	if (!dsi->panel) {
>  		ret = -EPROBE_DEFER;
> -		goto err_mipi_dsi_host;
> +		goto err_unreg_mipi_dsi_host;
>  	}
> 
>  	dev_set_drvdata(dev, dsi);
>  	pm_runtime_enable(dev);
>  	return 0;
> 
> -err_mipi_dsi_host:
> +err_unreg_mipi_dsi_host:
>  	mipi_dsi_host_unregister(&dsi->dsi_host);
> -err_cleanup:
> -	drm_encoder_cleanup(&dsi->encoder);
> -	drm_connector_cleanup(&dsi->connector);
> -err_pllref:
> +err_disable_pm_runtime:
> +	pm_runtime_disable(dev);
> +	dsi->connector.funcs->destroy(&dsi->connector);
> +	dsi->encoder.funcs->destroy(&dsi->encoder);
> +err_disable_pllref:
>  	clk_disable_unprepare(dsi->pllref_clk);
>  	return ret;
>  }
> @@ -1319,6 +1320,10 @@ static void dw_mipi_dsi_unbind(struct device *dev,
> struct device *master,
> 
>  	mipi_dsi_host_unregister(&dsi->dsi_host);
>  	pm_runtime_disable(dev);
> +
> +	dsi->connector.funcs->destroy(&dsi->connector);
> +	dsi->encoder.funcs->destroy(&dsi->encoder);
> +
>  	clk_disable_unprepare(dsi->pllref_clk);
>  }
