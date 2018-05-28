Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754055AbeE1Iig (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 04:38:36 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:20698 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753986AbeE1Iif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 04:38:35 -0400
X-UUID: ab80871206e04a12902bbc7a042a5bd1-20180528
Message-ID: <1527496710.396.11.camel@mtksdaap41>
Subject: Re: [PATCH v1 7/7] drm/mediatek: config component output by device
 node port
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
        "Sascha Hauer" <kernel@pengutronix.de>
Date: Mon, 28 May 2018 16:38:30 +0800
In-Reply-To: <20180514075243.5442-8-bibby.hsieh@mediatek.com>
References: <20180514075243.5442-1-bibby.hsieh@mediatek.com>
         <20180514075243.5442-8-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bibby:

On Mon, 2018-05-14 at 15:52 +0800, Bibby Hsieh wrote:
> We can select output component by device node port.
> Main path default output component is DSI.
> External path default output component is DPI.

Config the HW routine by device tree is a good idea. But I would like
this to be more general. My idea is:
1. Each component has one or two endpoint in device tree. The first and
the last has one, and the others has two.
2. Remove mtxxxx_mtk_ddp_main[] and mtxxxx_mtk_ddp_ext[], use multiple
link list (One display path has one link list, two display path has two
link list) to generate it by parsing device tree in mtk_drm_probe().

Stu has planed to do this in future. You could wait him or you could do
this first.

Regards,
CK

> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 37 ++++++++++++++++++++++++++++++----
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h |  4 ++--
>  2 files changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index f4fb86ab7b8d..05333769d862 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -24,6 +24,8 @@
>  #include <linux/of_address.h>
>  #include <linux/of_platform.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/of.h>
> +#include <linux/of_graph.h>
>  
>  #include "mtk_drm_crtc.h"
>  #include "mtk_drm_ddp.h"
> @@ -133,7 +135,7 @@ static const struct drm_mode_config_funcs mtk_drm_mode_config_funcs = {
>  	.atomic_commit = mtk_atomic_commit,
>  };
>  
> -static const enum mtk_ddp_comp_id mt2701_mtk_ddp_main[] = {
> +static enum mtk_ddp_comp_id mt2701_mtk_ddp_main[] = {
>  	DDP_COMPONENT_OVL0,
>  	DDP_COMPONENT_RDMA0,
>  	DDP_COMPONENT_COLOR0,
> @@ -141,12 +143,12 @@ static const enum mtk_ddp_comp_id mt2701_mtk_ddp_main[] = {
>  	DDP_COMPONENT_DSI0,
>  };
>  
> -static const enum mtk_ddp_comp_id mt2701_mtk_ddp_ext[] = {
> +static enum mtk_ddp_comp_id mt2701_mtk_ddp_ext[] = {
>  	DDP_COMPONENT_RDMA1,
>  	DDP_COMPONENT_DPI0,
>  };
>  
> -static const enum mtk_ddp_comp_id mt8173_mtk_ddp_main[] = {
> +static enum mtk_ddp_comp_id mt8173_mtk_ddp_main[] = {
>  	DDP_COMPONENT_OVL0,
>  	DDP_COMPONENT_COLOR0,
>  	DDP_COMPONENT_AAL,
> @@ -157,7 +159,7 @@ static const enum mtk_ddp_comp_id mt8173_mtk_ddp_main[] = {
>  	DDP_COMPONENT_PWM0,
>  };
>  
> -static const enum mtk_ddp_comp_id mt8173_mtk_ddp_ext[] = {
> +static enum mtk_ddp_comp_id mt8173_mtk_ddp_ext[] = {
>  	DDP_COMPONENT_OVL1,
>  	DDP_COMPONENT_COLOR1,
>  	DDP_COMPONENT_GAMMA,
> @@ -411,6 +413,7 @@ static int mtk_drm_probe(struct platform_device *pdev)
>  
>  	/* Iterate over sibling DISP function blocks */
>  	for_each_child_of_node(dev->of_node->parent, node) {
> +		struct device_node *port, *ep, *remote;
>  		const struct of_device_id *of_id;
>  		enum mtk_ddp_comp_type comp_type;
>  		int comp_id;
> @@ -470,6 +473,32 @@ static int mtk_drm_probe(struct platform_device *pdev)
>  
>  			private->ddp_comp[comp_id] = comp;
>  		}
> +
> +		if (comp_type != MTK_DSI && comp_type != MTK_DPI) {
> +			port = of_graph_get_port_by_id(node, 0);
> +			if (!port)
> +				continue;
> +			ep = of_get_child_by_name(port, "endpoint");
> +			of_node_put(port);
> +			if (!ep)
> +				continue;
> +			remote = of_graph_get_remote_port_parent(ep);
> +			of_node_put(ep);
> +			if (!remote)
> +				continue;
> +			of_id = of_match_node(mtk_ddp_comp_dt_ids, remote);
> +			if (!of_id)
> +				continue;
> +			comp_type = (enum mtk_ddp_comp_type)of_id->data;
> +			for (i = 0; i < private->data->main_len - 1; i++)
> +				if (private->data->main_path[i] == comp_id)
> +					private->data->main_path[i + 1] =
> +					mtk_ddp_comp_get_id(node, comp_type);
> +			for (i = 0; i < private->data->ext_len - 1; i++)
> +				if (private->data->ext_path[i] == comp_id)
> +					private->data->ext_path[i + 1] =
> +					mtk_ddp_comp_get_id(node, comp_type);
> +		}
>  	}
>  
>  	if (!private->mutex_node) {
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> index c3378c452c0a..2bcba8eb06f4 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> @@ -29,9 +29,9 @@ struct drm_property;
>  struct regmap;
>  
>  struct mtk_mmsys_driver_data {
> -	const enum mtk_ddp_comp_id *main_path;
> +	enum mtk_ddp_comp_id *main_path;
>  	unsigned int main_len;
> -	const enum mtk_ddp_comp_id *ext_path;
> +	enum mtk_ddp_comp_id *ext_path;
>  	unsigned int ext_len;
>  	bool shadow_register;
>  };
