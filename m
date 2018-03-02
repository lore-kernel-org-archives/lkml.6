Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932145AbeCBVsS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 16:48:18 -0500
Received: from galahad.ideasonboard.com ([185.26.127.97]:60099 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750775AbeCBVsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 16:48:17 -0500
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Sandy Huang <hjc@rock-chips.com>,
        Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        linux-rockchip@lists.infradead.org,
        Archit Taneja <architt@codeaurora.org>, linux-kernel@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, Jose Abreu <Jose.Abreu@synopsys.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-arm-kernel@lists.infradead.org, David Airlie <airlied@linux.ie>,
        Jeffy Chen <jeffy.chen@rock-chips.com>, kernel@collabora.com
Subject: Re: [PATCH v9 5/5] drm/bridge/synopsys: dw-hdmi: Add missing bridge detach
Date: Fri, 02 Mar 2018 23:49:06 +0200
Message-ID: <2714218.VptbnhJPkd@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180302175757.28192-6-enric.balletbo@collabora.com>
References: <20180302175757.28192-1-enric.balletbo@collabora.com> <20180302175757.28192-6-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Thank you for the patch.

On Friday, 2 March 2018 19:57:57 EET Enric Balletbo i Serra wrote:
> From: Jeffy Chen <jeffy.chen@rock-chips.com>
> 
> We inited connector in attach(), so need a detach() to cleanup.

Do we ? The dw-hdmi driver already sets drm_connector_cleanup() as the 
connector .destroy() handler, and the .destroy() operation is called by the 
DRM core. None of the other bridge drivers call drm_connector_cleanup() 
directly.

> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v9: None
> 
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c index
> f9802399cc0d..5626922f95f9 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -1985,6 +1985,13 @@ static int dw_hdmi_bridge_attach(struct drm_bridge
> *bridge) return 0;
>  }
> 
> +static void dw_hdmi_bridge_detach(struct drm_bridge *bridge)
> +{
> +	struct dw_hdmi *hdmi = bridge->driver_private;
> +
> +	drm_connector_cleanup(&hdmi->connector);
> +}
> +
>  static enum drm_mode_status
>  dw_hdmi_bridge_mode_valid(struct drm_bridge *bridge,
>  			  const struct drm_display_mode *mode)
> @@ -2041,6 +2048,7 @@ static void dw_hdmi_bridge_enable(struct drm_bridge
> *bridge)
> 
>  static const struct drm_bridge_funcs dw_hdmi_bridge_funcs = {
>  	.attach = dw_hdmi_bridge_attach,
> +	.detach = dw_hdmi_bridge_detach,
>  	.enable = dw_hdmi_bridge_enable,
>  	.disable = dw_hdmi_bridge_disable,
>  	.mode_set = dw_hdmi_bridge_mode_set,

-- 
Regards,

Laurent Pinchart
