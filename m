Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935320AbeEYEvY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 00:51:24 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:15306 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S932557AbeEYEvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 00:51:22 -0400
X-UUID: 4e3bad0bf113424987be1a350a8ab50b-20180525
Message-ID: <1527223874.27165.21.camel@mtksdaap41>
Subject: Re: [PATCH v3 7/8] drm/mediatek: Add support for mediatek SOC MT2712
From: CK Hu <ck.hu@mediatek.com>
To: <stu.hsieh@mediatek.com>
CC: Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Date: Fri, 25 May 2018 12:51:14 +0800
In-Reply-To: <1527215665-11937-8-git-send-email-stu.hsieh@mediatek.com>
References: <1527215665-11937-1-git-send-email-stu.hsieh@mediatek.com>
         <1527215665-11937-8-git-send-email-stu.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Stu:

I've some inline comment.

On Fri, 2018-05-25 at 10:34 +0800, stu.hsieh@mediatek.com wrote:
> From: Stu Hsieh <stu.hsieh@mediatek.com>
> 
> This patch add support for the Mediatek MT2712 DISP subsystem.
> There are two OVL engine and three disp output in MT2712.
> 
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c      | 46 +++++++++++++++++++++++++++--
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |  8 +++--
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c      | 42 ++++++++++++++++++++++++--
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h      |  7 +++--
>  4 files changed, 94 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index 0f568dd853d8..676726249ae0 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -61,6 +61,24 @@
>  #define MT8173_MUTEX_MOD_DISP_PWM1		24
>  #define MT8173_MUTEX_MOD_DISP_OD		25
>  
> +#define MT2712_MUTEX_MOD_DISP_OVL0		11
> +#define MT2712_MUTEX_MOD_DISP_OVL1		12
> +#define MT2712_MUTEX_MOD_DISP_RDMA0		13
> +#define MT2712_MUTEX_MOD_DISP_RDMA1		14
> +#define MT2712_MUTEX_MOD_DISP_RDMA2		15
> +#define MT2712_MUTEX_MOD_DISP_WDMA0		16
> +#define MT2712_MUTEX_MOD_DISP_WDMA1		17
> +#define MT2712_MUTEX_MOD_DISP_COLOR0		18
> +#define MT2712_MUTEX_MOD_DISP_COLOR1		19
> +#define MT2712_MUTEX_MOD_DISP_AAL0		20
> +#define MT2712_MUTEX_MOD_DISP_UFOE		22
> +#define MT2712_MUTEX_MOD_DISP_PWM0		23
> +#define MT2712_MUTEX_MOD_DISP_PWM1		24
> +#define MT2712_MUTEX_MOD_DISP_PWM2		10
> +#define MT2712_MUTEX_MOD_DISP_OD0		25
> +#define MT2712_MUTEX_MOD2_DISP_AAL1		33
> +#define MT2712_MUTEX_MOD2_DISP_OD1		34

I would like this to be in the order by index.

> +
>  #define MT2701_MUTEX_MOD_DISP_OVL		3
>  #define MT2701_MUTEX_MOD_DISP_WDMA		6
>  #define MT2701_MUTEX_MOD_DISP_COLOR		7
> @@ -75,6 +93,7 @@
>  
>  #define OVL0_MOUT_EN_COLOR0		0x1
>  #define OD_MOUT_EN_RDMA0		0x1
> +#define OD1_MOUT_EN_RDMA1		BIT(16)
>  #define UFOE_MOUT_EN_DSI0		0x1
>  #define COLOR0_SEL_IN_OVL0		0x1
>  #define OVL1_MOUT_EN_COLOR1		0x1
> @@ -109,12 +128,32 @@ static const unsigned int mt2701_mutex_mod[DDP_COMPONENT_ID_MAX] = {
>  	[DDP_COMPONENT_WDMA0] = MT2701_MUTEX_MOD_DISP_WDMA,
>  };
>  
> +static const unsigned int mt2712_mutex_mod[DDP_COMPONENT_ID_MAX] = {
> +	[DDP_COMPONENT_AAL0] = MT2712_MUTEX_MOD_DISP_AAL0,
> +	[DDP_COMPONENT_AAL1] = MT2712_MUTEX_MOD2_DISP_AAL1,
> +	[DDP_COMPONENT_COLOR0] = MT2712_MUTEX_MOD_DISP_COLOR0,
> +	[DDP_COMPONENT_COLOR1] = MT2712_MUTEX_MOD_DISP_COLOR1,
> +	[DDP_COMPONENT_OD0] = MT2712_MUTEX_MOD_DISP_OD0,
> +	[DDP_COMPONENT_OD1] = MT2712_MUTEX_MOD2_DISP_OD1,
> +	[DDP_COMPONENT_OVL0] = MT2712_MUTEX_MOD_DISP_OVL0,
> +	[DDP_COMPONENT_OVL1] = MT2712_MUTEX_MOD_DISP_OVL1,
> +	[DDP_COMPONENT_PWM0] = MT2712_MUTEX_MOD_DISP_PWM0,
> +	[DDP_COMPONENT_PWM1] = MT2712_MUTEX_MOD_DISP_PWM1,
> +	[DDP_COMPONENT_PWM2] = MT2712_MUTEX_MOD_DISP_PWM2,
> +	[DDP_COMPONENT_RDMA0] = MT2712_MUTEX_MOD_DISP_RDMA0,
> +	[DDP_COMPONENT_RDMA1] = MT2712_MUTEX_MOD_DISP_RDMA1,
> +	[DDP_COMPONENT_RDMA2] = MT2712_MUTEX_MOD_DISP_RDMA2,
> +	[DDP_COMPONENT_UFOE] = MT2712_MUTEX_MOD_DISP_UFOE,
> +	[DDP_COMPONENT_WDMA0] = MT2712_MUTEX_MOD_DISP_WDMA0,
> +	[DDP_COMPONENT_WDMA1] = MT2712_MUTEX_MOD_DISP_WDMA1,
> +};
> +
>  static const unsigned int mt8173_mutex_mod[DDP_COMPONENT_ID_MAX] = {
> -	[DDP_COMPONENT_AAL] = MT8173_MUTEX_MOD_DISP_AAL,
> +	[DDP_COMPONENT_AAL0] = MT8173_MUTEX_MOD_DISP_AAL,

Move this to the patch 'add ddp component AAL1'.

>  	[DDP_COMPONENT_COLOR0] = MT8173_MUTEX_MOD_DISP_COLOR0,
>  	[DDP_COMPONENT_COLOR1] = MT8173_MUTEX_MOD_DISP_COLOR1,
>  	[DDP_COMPONENT_GAMMA] = MT8173_MUTEX_MOD_DISP_GAMMA,
> -	[DDP_COMPONENT_OD] = MT8173_MUTEX_MOD_DISP_OD,
> +	[DDP_COMPONENT_OD0] = MT8173_MUTEX_MOD_DISP_OD,

Move this to the patch 'add ddp component OD1'.

>  	[DDP_COMPONENT_OVL0] = MT8173_MUTEX_MOD_DISP_OVL0,
>  	[DDP_COMPONENT_OVL1] = MT8173_MUTEX_MOD_DISP_OVL1,
>  	[DDP_COMPONENT_PWM0] = MT8173_MUTEX_MOD_DISP_PWM0,
> @@ -139,7 +178,7 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
>  	} else if (cur == DDP_COMPONENT_OVL0 && next == DDP_COMPONENT_RDMA0) {
>  		*addr = DISP_REG_CONFIG_DISP_OVL_MOUT_EN;
>  		value = OVL_MOUT_EN_RDMA;
> -	} else if (cur == DDP_COMPONENT_OD && next == DDP_COMPONENT_RDMA0) {
> +	} else if (cur == DDP_COMPONENT_OD0 && next == DDP_COMPONENT_RDMA0) {

Move this to the patch 'add ddp component OD1'.

>  		*addr = DISP_REG_CONFIG_DISP_OD_MOUT_EN;
>  		value = OD_MOUT_EN_RDMA0;
>  	} else if (cur == DDP_COMPONENT_UFOE && next == DDP_COMPONENT_DSI0) {
> @@ -429,6 +468,7 @@ static int mtk_ddp_remove(struct platform_device *pdev)
>  
>  static const struct of_device_id ddp_driver_dt_match[] = {
>  	{ .compatible = "mediatek,mt2701-disp-mutex", .data = mt2701_mutex_mod},
> +	{ .compatible = "mediatek,mt2712-disp-mutex", .data = mt2712_mutex_mod},
>  	{ .compatible = "mediatek,mt8173-disp-mutex", .data = mt8173_mutex_mod},
>  	{},
>  };
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> index 4672317e3ad1..86e8c9e5df41 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -218,7 +218,8 @@ struct mtk_ddp_comp_match {
>  };
>  
>  static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
> -	[DDP_COMPONENT_AAL]	= { MTK_DISP_AAL,	0, &ddp_aal },
> +	[DDP_COMPONENT_AAL0]	= { MTK_DISP_AAL,	0, &ddp_aal },
> +	[DDP_COMPONENT_AAL1]	= { MTK_DISP_AAL,	1, &ddp_aal },

Move this to the patch 'add ddp component AAL1'.

>  	[DDP_COMPONENT_BLS]	= { MTK_DISP_BLS,	0, NULL },
>  	[DDP_COMPONENT_COLOR0]	= { MTK_DISP_COLOR,	0, NULL },
>  	[DDP_COMPONENT_COLOR1]	= { MTK_DISP_COLOR,	1, NULL },
> @@ -226,10 +227,13 @@ static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
>  	[DDP_COMPONENT_DSI0]	= { MTK_DSI,		0, NULL },
>  	[DDP_COMPONENT_DSI1]	= { MTK_DSI,		1, NULL },
>  	[DDP_COMPONENT_GAMMA]	= { MTK_DISP_GAMMA,	0, &ddp_gamma },
> -	[DDP_COMPONENT_OD]	= { MTK_DISP_OD,	0, &ddp_od },
> +	[DDP_COMPONENT_OD0]	= { MTK_DISP_OD,	0, &ddp_od },
> +	[DDP_COMPONENT_OD1]	= { MTK_DISP_OD,	1, &ddp_od },

Move this to the patch 'add ddp component OD1'

>  	[DDP_COMPONENT_OVL0]	= { MTK_DISP_OVL,	0, NULL },
>  	[DDP_COMPONENT_OVL1]	= { MTK_DISP_OVL,	1, NULL },
>  	[DDP_COMPONENT_PWM0]	= { MTK_DISP_PWM,	0, NULL },
> +	[DDP_COMPONENT_PWM1]	= { MTK_DISP_PWM,	1, NULL },

Move this to the patch 'add ddp component PWM1'

> +	[DDP_COMPONENT_PWM2]	= { MTK_DISP_PWM,	2, NULL },

Move this to the patch 'add ddp component PWM2'

>  	[DDP_COMPONENT_RDMA0]	= { MTK_DISP_RDMA,	0, NULL },
>  	[DDP_COMPONENT_RDMA1]	= { MTK_DISP_RDMA,	1, NULL },
>  	[DDP_COMPONENT_RDMA2]	= { MTK_DISP_RDMA,	2, NULL },
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index a2ca90fc403c..b32c4cc8d051 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -146,11 +146,37 @@ static const enum mtk_ddp_comp_id mt2701_mtk_ddp_ext[] = {
>  	DDP_COMPONENT_DPI0,
>  };
>  
> +static const enum mtk_ddp_comp_id mt2712_mtk_ddp_main[] = {
> +	DDP_COMPONENT_OVL0,
> +	DDP_COMPONENT_COLOR0,
> +	DDP_COMPONENT_AAL0,
> +	DDP_COMPONENT_OD0,
> +	DDP_COMPONENT_RDMA0,
> +	DDP_COMPONENT_DPI0,
> +	DDP_COMPONENT_PWM0,
> +};
> +
> +static const enum mtk_ddp_comp_id mt2712_mtk_ddp_ext[] = {
> +	DDP_COMPONENT_OVL1,
> +	DDP_COMPONENT_COLOR1,
> +	DDP_COMPONENT_AAL1,
> +	DDP_COMPONENT_OD1,
> +	DDP_COMPONENT_RDMA1,
> +	DDP_COMPONENT_DPI1,
> +	DDP_COMPONENT_PWM1,
> +};
> +
> +static const enum mtk_ddp_comp_id mt2712_mtk_ddp_third[] = {
> +	DDP_COMPONENT_RDMA2,
> +	DDP_COMPONENT_DSI2,
> +	DDP_COMPONENT_PWM2,
> +};
> +
>  static const enum mtk_ddp_comp_id mt8173_mtk_ddp_main[] = {
>  	DDP_COMPONENT_OVL0,
>  	DDP_COMPONENT_COLOR0,
> -	DDP_COMPONENT_AAL,
> -	DDP_COMPONENT_OD,
> +	DDP_COMPONENT_AAL0,

Move this to the patch 'add ddp component AAL1'.

> +	DDP_COMPONENT_OD0,

Move this to the patch 'add ddp component OD1'

>  	DDP_COMPONENT_RDMA0,
>  	DDP_COMPONENT_UFOE,
>  	DDP_COMPONENT_DSI0,
> @@ -173,6 +199,15 @@ static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
>  	.shadow_register = true,
>  };
>  
> +static const struct mtk_mmsys_driver_data mt2712_mmsys_driver_data = {
> +	.main_path = mt2712_mtk_ddp_main,
> +	.main_len = ARRAY_SIZE(mt2712_mtk_ddp_main),
> +	.ext_path = mt2712_mtk_ddp_ext,
> +	.ext_len = ARRAY_SIZE(mt2712_mtk_ddp_ext),
> +	.third_path = mt2712_mtk_ddp_third,
> +	.third_len = ARRAY_SIZE(mt2712_mtk_ddp_third),
> +};
> +
>  static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
>  	.main_path = mt8173_mtk_ddp_main,
>  	.main_len = ARRAY_SIZE(mt8173_mtk_ddp_main),
> @@ -374,6 +409,7 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
>  	{ .compatible = "mediatek,mt8173-dsi",        .data = (void *)MTK_DSI },
>  	{ .compatible = "mediatek,mt8173-dpi",        .data = (void *)MTK_DPI },
>  	{ .compatible = "mediatek,mt2701-disp-mutex", .data = (void *)MTK_DISP_MUTEX },
> +	{ .compatible = "mediatek,mt2712-disp-mutex", .data = (void *)MTK_DISP_MUTEX },
>  	{ .compatible = "mediatek,mt8173-disp-mutex", .data = (void *)MTK_DISP_MUTEX },
>  	{ .compatible = "mediatek,mt2701-disp-pwm",   .data = (void *)MTK_DISP_BLS },
>  	{ .compatible = "mediatek,mt8173-disp-pwm",   .data = (void *)MTK_DISP_PWM },
> @@ -552,6 +588,8 @@ static SIMPLE_DEV_PM_OPS(mtk_drm_pm_ops, mtk_drm_sys_suspend,
>  static const struct of_device_id mtk_drm_of_ids[] = {
>  	{ .compatible = "mediatek,mt2701-mmsys",
>  	  .data = &mt2701_mmsys_driver_data},
> +	{ .compatible = "mediatek,mt2712-mmsys",
> +	  .data = &mt2712_mmsys_driver_data},
>  	{ .compatible = "mediatek,mt8173-mmsys",
>  	  .data = &mt8173_mmsys_driver_data},
>  	{ }
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> index c3378c452c0a..e821342bc2d3 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> @@ -17,8 +17,8 @@
>  #include <linux/io.h>
>  #include "mtk_drm_ddp_comp.h"
>  
> -#define MAX_CRTC	2
> -#define MAX_CONNECTOR	2
> +#define MAX_CRTC	3
> +#define MAX_CONNECTOR	3
>  
>  struct device;
>  struct device_node;
> @@ -33,6 +33,9 @@ struct mtk_mmsys_driver_data {
>  	unsigned int main_len;
>  	const enum mtk_ddp_comp_id *ext_path;
>  	unsigned int ext_len;
> +	enum mtk_ddp_comp_id *third_path;
> +	unsigned int third_len;
> +

Move this to the patch 'add third ddp path'.

>  	bool shadow_register;
>  };
>  

Regards,
CK
