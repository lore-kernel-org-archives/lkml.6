Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754150AbeE1JLl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:11:41 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:10666 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753984AbeE1JLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:11:38 -0400
X-UUID: ea6fc0399df94f1e8607371a618208f2-20180528
Message-ID: <1527498688.14913.5.camel@mtksdaap41>
Subject: Re: [PATCH v1 3/7] drm/mediatek: add dpi driver for mt2701 and
 mt7623
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
Date: Mon, 28 May 2018 17:11:28 +0800
In-Reply-To: <20180514075243.5442-4-bibby.hsieh@mediatek.com>
References: <20180514075243.5442-1-bibby.hsieh@mediatek.com>
         <20180514075243.5442-4-bibby.hsieh@mediatek.com>
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
> From: chunhui dai <chunhui.dai@mediatek.com>
> 
> This patch adds dpi driver suppot for both mt2701 and mt7623.
> And also support other (existing or future) chips that use
> the same binding and driver.
> 
> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c     | 24 ++++++++++++++++++++++--
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c |  1 +
>  2 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index 2b8b34c72697..e1af1d0d213d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -640,8 +640,7 @@ static int mtk_dpi_bind(struct device *dev, struct device *master, void *data)
>  	}
>  	drm_encoder_helper_add(&dpi->encoder, &mtk_dpi_encoder_helper_funcs);
>  
> -	/* Currently DPI0 is fixed to be driven by OVL1 */
> -	dpi->encoder.possible_crtcs = BIT(1);
> +	dpi->encoder.possible_crtcs = BIT(0) | BIT(1);

This modification influence not only mt2701, but also mt8173. So move
this to an independent patch.

Regards,
CK

>  	dpi->encoder.bridge->encoder = &dpi->encoder;
>  	ret = drm_bridge_attach(&dpi->encoder, dpi->encoder.bridge, NULL);
>  	if (ret) {
> @@ -690,12 +689,33 @@ static unsigned int mt8173_calculate_factor(int clock)
>  		return 2 * 3;
>  }
>  
> +static unsigned int mt2701_calculate_factor(int clock)
> +{
> +	if (clock <= 64000)
> +		return 16;
> +	else if (clock <= 128000)
> +		return 8;
> +	else if (clock <= 256000)
> +		return 4;
> +	else
> +		return 2;
> +}
> +
>  static const struct mtk_dpi_conf mt8173_conf = {
>  	.cal_factor = mt8173_calculate_factor,
>  	.reg_h_fre_con = 0xe0,
>  };
>  
> +static const struct mtk_dpi_conf mt2701_conf = {
> +	.cal_factor = mt2701_calculate_factor,
> +	.reg_h_fre_con = 0xb0,
> +	.edge_sel_en = true,
> +};
> +
>  static const struct of_device_id mtk_dpi_of_ids[] = {
> +	{ .compatible = "mediatek,mt2701-dpi",
> +	  .data = &mt2701_conf,
> +	},
>  	{ .compatible = "mediatek,mt8173-dpi",
>  	  .data = &mt8173_conf,
>  	},
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index a2ca90fc403c..f4fb86ab7b8d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -372,6 +372,7 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
>  	{ .compatible = "mediatek,mt8173-disp-ufoe",  .data = (void *)MTK_DISP_UFOE },
>  	{ .compatible = "mediatek,mt2701-dsi",	      .data = (void *)MTK_DSI },
>  	{ .compatible = "mediatek,mt8173-dsi",        .data = (void *)MTK_DSI },
> +	{ .compatible = "mediatek,mt2701-dpi",	      .data = (void *)MTK_DPI },
>  	{ .compatible = "mediatek,mt8173-dpi",        .data = (void *)MTK_DPI },
>  	{ .compatible = "mediatek,mt2701-disp-mutex", .data = (void *)MTK_DISP_MUTEX },
>  	{ .compatible = "mediatek,mt8173-disp-mutex", .data = (void *)MTK_DISP_MUTEX },
