Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752522AbeESQIS (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 12:08:18 -0400
Received: from gloria.sntech.de ([95.129.55.99]:58232 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752370AbeESQIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 12:08:15 -0400
From: Heiko Stuebner <heiko@sntech.de>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Martin Donnelly <martin.donnelly@ge.com>,
        Martyn Welch <martyn.welch@collabora.co.uk>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sandy Huang <hjc@rock-chips.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v3 01/26] drm/bridge: allow optionally specifying an owner .odev device
Date: Sat, 19 May 2018 18:07:33 +0200
Message-ID: <21812146.Dm3JJO5T5a@phil>
In-Reply-To: <20180516101510.13215-2-peda@axentia.se>
References: <20180516101510.13215-1-peda@axentia.se> <20180516101510.13215-2-peda@axentia.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Am Mittwoch, 16. Mai 2018, 12:14:45 CEST schrieb Peter Rosin:
> Bridge drivers can now (temporarily, in a transition phase) select if
> they want to provide a full owner device or keep just providing an
> of_node.
> 
> By providing a full owner device, the bridge drivers no longer need
> to provide an of_node since that node is available via the owner
> device.
> 
> When all bridge drivers provide an owner device, that will become
> mandatory and the .of_node member will be removed.
> 
> There is an interaction with the rockchip lvds driver, since that
> driver peeks into somewhat private parts of the bridge struct in
> order to find out things about the remote bridge. When there are
> now two ways to get to the remote bridge, the rockchip lvds driver
> has to adapt. That said, the correct thing to do for the rockchip
> lvds driver is to use some other way than DT to find things out
> about the remote bridge, but that is orthogonal to this patch.
> 
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Peter Rosin <peda@axentia.se>

> diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> index 4bd94b167d2c..557e0079c98d 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> @@ -377,8 +377,10 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
>  	}
>  	if (lvds->panel)
>  		remote = lvds->panel->dev->of_node;
> -	else
> +	else if (lvds->bridge->of_node)
>  		remote = lvds->bridge->of_node;
> +	else
> +		remote = lvds->bridge->odev->of_node;
>  	if (of_property_read_string(dev->of_node, "rockchip,output", &name))
>  		/* default set it as output rgb */
>  		lvds->output = DISPLAY_OUTPUT_RGB;

for the Rockchip-part
Acked-by: Heiko Stuebner <heiko@sntech.de>
