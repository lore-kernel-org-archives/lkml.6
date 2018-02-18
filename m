Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751343AbeBRKMW (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 05:12:22 -0500
Received: from gloria.sntech.de ([95.129.55.99]:36942 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750820AbeBRKMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 05:12:21 -0500
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Sandy Huang <hjc@rock-chips.com>, David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>, dmitry.torokhov@gmail.com,
        briannorris@chromium.org, rjw@rjwysocki.net, dianders@chromium.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, tfiga@chromium.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5] drm/rockchip: Add device links for master and components
Date: Sun, 18 Feb 2018 11:12:07 +0100
Message-ID: <7759612.uKiIP4CCLT@phil>
In-Reply-To: <20180207175309.21095-1-enric.balletbo@collabora.com>
References: <20180207175309.21095-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Mittwoch, 7. Februar 2018, 18:53:09 CET schrieb Enric Balletbo i Serra:
> From: Jeffy Chen <jeffy.chen@rock-chips.com>
> 
> Since we are trying to access components' resources in the master's
> suspend/resume PM callbacks(e.g. panel), add device links to correct
> the suspend/resume and shutdown ordering.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

looks good to me right now. So if anybody else wants to apply it,
Reviewed-by: Heiko Stuebner <heiko@sntech.de>

@Sean: does this address the issue you saw with the previous version?
It looks like it, but I'd like to make sure before I apply it to drm-misc
myself :-)


Thanks
Heiko

> ---
> Hi,
> 
> This is an attempt to revive a patch [1] that was sent last October. Sean
> Paul requested some changes but I think that never was send a v5 version.
> The patch fixes and issue where backlight panel is not correctly recoved
> after a resume. This was tested on top of current linux-next plus the
> latest series of Thierry's patches [2]
> 
> [1] https://patchwork.kernel.org/patch/10011595/
> [2] https://lkml.org/lkml/2018/1/30/621
> 
> Changes in v5:
> Address the comments from Sean.
> - Create a helper to do the cleanup.
> - Call the helper in rockchip_drm_match_add and where needed.
> Changes in v4: None
> Changes in v3: None
> Changes in v2:
> Use device link to correct the suspend/resume and shutdown ordering,
> instead of converting rockchip spi's suspend/resume PM callbacks to
> late suspend/resume PM callbacks.
> 
> Thanks,
>  Enric
> 
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> index 0609113d6a71..f814d37b1db2 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> @@ -314,6 +314,14 @@ static int compare_dev(struct device *dev, void *data)
>  	return dev == (struct device *)data;
>  }
>  
> +static void rockchip_drm_match_remove(struct device *dev)
> +{
> +	struct device_link *link;
> +
> +	list_for_each_entry(link, &dev->links.consumers, s_node)
> +		device_link_del(link);
> +}
> +
>  static struct component_match *rockchip_drm_match_add(struct device *dev)
>  {
>  	struct component_match *match = NULL;
> @@ -331,10 +339,15 @@ static struct component_match *rockchip_drm_match_add(struct device *dev)
>  
>  			if (!d)
>  				break;
> +
> +			device_link_add(dev, d, DL_FLAG_STATELESS);
>  			component_match_add(dev, &match, compare_dev, d);
>  		} while (true);
>  	}
>  
> +	if (IS_ERR(match))
> +		rockchip_drm_match_remove(dev);
> +
>  	return match ?: ERR_PTR(-ENODEV);
>  }
>  
> @@ -411,13 +424,21 @@ static int rockchip_drm_platform_probe(struct platform_device *pdev)
>  	if (IS_ERR(match))
>  		return PTR_ERR(match);
>  
> -	return component_master_add_with_match(dev, &rockchip_drm_ops, match);
> +	ret = component_master_add_with_match(dev, &rockchip_drm_ops, match);
> +	if (ret < 0) {
> +		rockchip_drm_match_remove(dev);
> +		return ret;
> +	}
> +
> +	return 0;
>  }
>  
>  static int rockchip_drm_platform_remove(struct platform_device *pdev)
>  {
>  	component_master_del(&pdev->dev, &rockchip_drm_ops);
>  
> +	rockchip_drm_match_remove(&pdev->dev);
> +
>  	return 0;
>  }
>  
> 
