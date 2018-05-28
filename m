Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754052AbeE1IaW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 04:30:22 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:13575 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753849AbeE1IaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 04:30:21 -0400
X-UUID: b2fb65dc70194e7aa017d1a174b83b2e-20180528
Message-ID: <1527496214.396.6.camel@mtksdaap41>
Subject: Re: [PATCH v1 2/7] drm/mediatek: fix to get right bridge for dpi
 encoder
From: CK Hu <ck.hu@mediatek.com>
To: Bibby Hsieh <bibby.hsieh@mediatek.com>
CC: David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Cawa Cheng <cawa.cheng@mediatek.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        YT Shen <yt.shen@mediatek.com>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        Mao Huang <littlecvr@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Sascha Hauer" <kernel@pengutronix.de>,
        chunhui dai <chunhui.dai@mediatek.com>
Date: Mon, 28 May 2018 16:30:14 +0800
In-Reply-To: <20180514075243.5442-3-bibby.hsieh@mediatek.com>
References: <20180514075243.5442-1-bibby.hsieh@mediatek.com>
         <20180514075243.5442-3-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bibby:

Some inline comment.

On Mon, 2018-05-14 at 15:52 +0800, Bibby Hsieh wrote:
> From: chunhui dai <chunhui.dai@mediatek.com>
> 
> 1, dpi is an encoder, there is an bridge in the struct
> of decoder, we could use it.

The encoder.bridge is assigned in drm_bridge_attach(), so I think the
design is to assign this member in drm_bridge_attach().
Any assignment outside this function may conflict with this design.

> 2, using of_graph_get_remote_port_parent to get right
> bridge in device tree.
> 
> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index 0a44ab175422..2b8b34c72697 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -63,7 +63,6 @@ enum mtk_dpi_out_color_format {
>  struct mtk_dpi {
>  	struct mtk_ddp_comp ddp_comp;
>  	struct drm_encoder encoder;
> -	struct drm_bridge *bridge;
>  	void __iomem *regs;
>  	struct device *dev;
>  	struct clk *engine_clk;
> @@ -643,8 +642,8 @@ static int mtk_dpi_bind(struct device *dev, struct device *master, void *data)
>  
>  	/* Currently DPI0 is fixed to be driven by OVL1 */
>  	dpi->encoder.possible_crtcs = BIT(1);
> -
> -	ret = drm_bridge_attach(&dpi->encoder, dpi->bridge, NULL);
> +	dpi->encoder.bridge->encoder = &dpi->encoder;

This is done inside drm_bridge_attach().

> +	ret = drm_bridge_attach(&dpi->encoder, dpi->encoder.bridge, NULL);
>  	if (ret) {
>  		dev_err(dev, "Failed to attach bridge: %d\n", ret);
>  		goto err_cleanup;
> @@ -709,7 +708,7 @@ static int mtk_dpi_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct mtk_dpi *dpi;
>  	struct resource *mem;
> -	struct device_node *bridge_node;
> +	struct device_node *ep, *bridge_node;
>  	int comp_id;
>  	const struct of_device_id *match;
>  	int ret;
> @@ -759,15 +758,21 @@ static int mtk_dpi_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	bridge_node = of_graph_get_remote_node(dev->of_node, 0, 0);
> -	if (!bridge_node)
> +	ep = of_graph_get_next_endpoint(dev->of_node, NULL);
> +	if (ep) {
> +		bridge_node = of_graph_get_remote_port_parent(ep);
> +		of_node_put(ep);
> +	}
> +	if (!bridge_node) {
> +		dev_err(dev, "Failed to find bridge node\n");
>  		return -ENODEV;
> +	}

This looks like mt8173 has the same bug, so send this patch
independently and it would be more quick to merge.
For mtk_dsi, it use drm_of_find_panel_or_bridge(), so I think you could
use the same function to get bridge.

Regards,
CK

>  
>  	dev_info(dev, "Found bridge node: %pOF\n", bridge_node);
>  
> -	dpi->bridge = of_drm_find_bridge(bridge_node);
> +	dpi->encoder.bridge = of_drm_find_bridge(bridge_node);
>  	of_node_put(bridge_node);
> -	if (!dpi->bridge)
> +	if (!dpi->encoder.bridge)
>  		return -EPROBE_DEFER;
>  
>  	comp_id = mtk_ddp_comp_get_id(dev->of_node, MTK_DPI);
