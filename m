Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933388AbeE1JGK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:06:10 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:43965 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754101AbeE1JGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:06:05 -0400
X-UUID: cbed03bcc298499dbb757b49e6048650-20180528
Message-ID: <1527498359.14913.2.camel@mtksdaap41>
Subject: Re: [PATCH v1 5/7] drm/mediatek: implement connection from BLS to
 DPI0
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
Date: Mon, 28 May 2018 17:05:59 +0800
In-Reply-To: <20180514075243.5442-6-bibby.hsieh@mediatek.com>
References: <20180514075243.5442-1-bibby.hsieh@mediatek.com>
         <20180514075243.5442-6-bibby.hsieh@mediatek.com>
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
> Modify display driver to support connection from BLS to DPI.
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index 8130f3dab661..289a68c6731f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -35,6 +35,7 @@
>  #define DISP_REG_CONFIG_DISP_OVL_MOUT_EN	0x030
>  #define DISP_REG_CONFIG_OUT_SEL			0x04c
>  #define DISP_REG_CONFIG_DSI_SEL			0x050
> +#define DISP_REG_CONFIG_DPI_SEL			0x064
>  
>  #define DISP_REG_MUTEX_EN(n)	(0x20 + 0x20 * (n))
>  #define DISP_REG_MUTEX(n)	(0x24 + 0x20 * (n))
> @@ -84,7 +85,10 @@
>  
>  #define OVL_MOUT_EN_RDMA		0x1
>  #define BLS_TO_DSI_RDMA1_TO_DPI1	0x8
> +#define BLS_TO_DPI_RDMA1_TO_DSI		0x2
>  #define DSI_SEL_IN_BLS			0x0
> +#define DPI_SEL_IN_BLS			0x0
> +#define DSI_SEL_IN_RDMA			0x1
>  
>  struct mtk_disp_mutex {
>  	int id;
> @@ -189,9 +193,17 @@ static void mtk_ddp_sout_sel(void __iomem *config_regs,
>  			     enum mtk_ddp_comp_id cur,
>  			     enum mtk_ddp_comp_id next)
>  {
> -	if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DSI0)
> +	if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DSI0) {
>  		writel_relaxed(BLS_TO_DSI_RDMA1_TO_DPI1,
>  			       config_regs + DISP_REG_CONFIG_OUT_SEL);

When BLS->DIP0, DISP_REG_CONFIG_DSI_SEL and DISP_REG_CONFIG_DPI_SEL are
configured. I think these two register should be configured when
BLS->DSI0.

Regards,
CK

> +	} else if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DPI0) {
> +		writel_relaxed(BLS_TO_DPI_RDMA1_TO_DSI,
> +			       config_regs + DISP_REG_CONFIG_OUT_SEL);
> +		writel_relaxed(DSI_SEL_IN_RDMA,
> +			       config_regs + DISP_REG_CONFIG_DSI_SEL);
> +		writel_relaxed(DPI_SEL_IN_BLS,
> +			       config_regs + DISP_REG_CONFIG_DPI_SEL);
> +	}
>  }
>  
>  void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
