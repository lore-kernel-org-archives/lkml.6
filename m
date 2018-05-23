Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932224AbeEWJ2Y (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:28:24 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:57594 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S932180AbeEWJ2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:28:22 -0400
X-UUID: 247001c7bb1142699cb3c75580720518-20180523
Message-ID: <1527067696.19074.28.camel@mtksdaap41>
Subject: Re: [PATCH v2 2/4] drm/mediatek: Add support for mediatek SOC MT2712
From: Stu Hsieh <stu.hsieh@mediatek.com>
To: CK Hu <ck.hu@mediatek.com>
CC: Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <srv_heupstream@mediatek.com>
Date: Wed, 23 May 2018 17:28:16 +0800
In-Reply-To: <1527053036.10410.18.camel@mtksdaap41>
References: <20180523022517.12103-1-stu.hsieh@mediatek.com>
         <20180523022517.12103-3-stu.hsieh@mediatek.com>
         <1527053036.10410.18.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-23 at 13:23 +0800, CK Hu wrote:
> Hi, Stu:
> 
> I've some inline comment.
> 
> On Wed, 2018-05-23 at 10:25 +0800, Stu Hsieh wrote:
> > This patch add support for the Mediatek MT2712 DISP subsystem.
> > There are two OVL engine and three disp output in MT2712.
> > 
> > Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp.c      | 50 +++++++++++++++++++++++++++--
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |  8 +++--
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  7 ++--
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.c      | 47 +++++++++++++++++++++++++--
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.h      |  7 ++--
> >  5 files changed, 108 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > index 8130f3dab661..e563dedd1999 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > @@ -29,6 +29,8 @@
> >  #define DISP_REG_CONFIG_DISP_COLOR0_SEL_IN	0x084
> >  #define DISP_REG_CONFIG_DISP_COLOR1_SEL_IN	0x088
> >  #define DISP_REG_CONFIG_DPI_SEL_IN		0x0ac
> > +#define DISP_REG_CONFIG_DISP_RDMA2_SOUT		0x0b8
> > +#define DISP_REG_CONFIG_DISP_RDMA0_MOUT_EN	0x0c4
> 
> These two definition are useless, so remove it.
ok


> 
> >  #define DISP_REG_CONFIG_DISP_RDMA1_MOUT_EN	0x0c8
> >  #define DISP_REG_CONFIG_MMSYS_CG_CON0		0x100
> >  
> > @@ -41,6 +43,7 @@
> >  #define DISP_REG_MUTEX_RST(n)	(0x28 + 0x20 * (n))
> >  #define DISP_REG_MUTEX_MOD(n)	(0x2c + 0x20 * (n))
> >  #define DISP_REG_MUTEX_SOF(n)	(0x30 + 0x20 * (n))
> > +#define DISP_REG_MUTEX_MOD2(n)	(0x34 + 0x20 * (n))
> 
> Move this to the patch 'drm/mediatek: support maximum 64 mutex mod' and
> that patch should be applied before this patch.
> 
> >  
> >  #define INT_MUTEX				BIT(1)
> >  
> > @@ -60,6 +63,25 @@
> >  #define MT8173_MUTEX_MOD_DISP_PWM1		BIT(24)
> >  #define MT8173_MUTEX_MOD_DISP_OD		BIT(25)
> >  
> > +#define MT2712_MUTEX_MOD_DISP_OVL0		BIT(11)
> > +#define MT2712_MUTEX_MOD_DISP_OVL1		BIT(12)
> > +#define MT2712_MUTEX_MOD_DISP_RDMA0		BIT(13)
> > +#define MT2712_MUTEX_MOD_DISP_RDMA1		BIT(14)
> > +#define MT2712_MUTEX_MOD_DISP_RDMA2		BIT(15)
> > +#define MT2712_MUTEX_MOD_DISP_WDMA0		BIT(16)
> > +#define MT2712_MUTEX_MOD_DISP_WDMA1		BIT(17)
> > +#define MT2712_MUTEX_MOD_DISP_COLOR0		BIT(18)
> > +#define MT2712_MUTEX_MOD_DISP_COLOR1		BIT(19)
> > +#define MT2712_MUTEX_MOD_DISP_AAL0		BIT(20)
> > +#define MT2712_MUTEX_MOD_DISP_UFOE		BIT(22)
> > +#define MT2712_MUTEX_MOD_DISP_PWM0		BIT(23)
> > +#define MT2712_MUTEX_MOD_DISP_PWM1		BIT(24)
> > +#define MT2712_MUTEX_MOD_DISP_PWM2		BIT(10)
> > +#define MT2712_MUTEX_MOD_DISP_OD0		BIT(25)
> > +/* modules more than 32, add BIT(31) when using DISP_REG_MUTEX_MOD2 bit */
> > +#define MT2712_MUTEX_MOD2_DISP_AAL1		(BIT(1) | BIT(31))
> 
> I think a better definition is
> 
> #define MT2712_MUTEX_MOD2_DISP_AAL1		BIT(33)
> 
> when you need to access this register,
> 
> if (ddp->mutex_mod[id] < BIT(32)) {
> 	offset = DISP_REG_MUTEX_MOD(mutex->id);
> 	reg = readl_relaxed(ddp->regs + offset);
> 	reg |= ddp->mutex_mod[id];
> 	writel_relaxed(reg, ddp->regs + offset);
> } else {
> 	offset = DISP_REG_MUTEX_MOD2(mutex->id);
> 	reg = readl_relaxed(ddp->regs + offset);
> 	reg |= (ddp->mutex_mod[id] >> 32);
> 	writel_relaxed(reg, ddp->regs + offset);
> }
> 
> because DISP_REG_MUTEX_MOD BIT(31) could be used for some module.

This modification is workable, but result some build warning like
following:
1. #define BIT(nr)   (1UL << (nr)) in include/linux/bitops.h
2. [DDP_COMPONENT_AAL1] = MT2712_MUTEX_MOD2_DISP_AAL1,
   => we need to modify the definition about "static const unsigned int
mt2712_mutex_mod"

> > +#define MT2712_MUTEX_MOD2_DISP_OD1		(BIT(2) | BIT(31))
> > +
> >  #define MT2701_MUTEX_MOD_DISP_OVL		BIT(3)
> >  #define MT2701_MUTEX_MOD_DISP_WDMA		BIT(6)
> >  #define MT2701_MUTEX_MOD_DISP_COLOR		BIT(7)
> > @@ -74,6 +96,7 @@
> >  
> >  #define OVL0_MOUT_EN_COLOR0		0x1
> >  #define OD_MOUT_EN_RDMA0		0x1
> > +#define OD1_MOUT_EN_RDMA1		BIT(16)
> >  #define UFOE_MOUT_EN_DSI0		0x1
> >  #define COLOR0_SEL_IN_OVL0		0x1
> >  #define OVL1_MOUT_EN_COLOR1		0x1
> > @@ -108,12 +131,32 @@ static const unsigned int mt2701_mutex_mod[DDP_COMPONENT_ID_MAX] = {
> >  	[DDP_COMPONENT_WDMA0] = MT2701_MUTEX_MOD_DISP_WDMA,
> >  };
> >  
> > +static const unsigned int mt2712_mutex_mod[DDP_COMPONENT_ID_MAX] = {
> > +	[DDP_COMPONENT_AAL0] = MT2712_MUTEX_MOD_DISP_AAL0,
> > +	[DDP_COMPONENT_AAL1] = MT2712_MUTEX_MOD2_DISP_AAL1,
> > +	[DDP_COMPONENT_COLOR0] = MT2712_MUTEX_MOD_DISP_COLOR0,
> > +	[DDP_COMPONENT_COLOR1] = MT2712_MUTEX_MOD_DISP_COLOR1,
> > +	[DDP_COMPONENT_OD0] = MT2712_MUTEX_MOD_DISP_OD0,
> > +	[DDP_COMPONENT_OD1] = MT2712_MUTEX_MOD2_DISP_OD1,
> > +	[DDP_COMPONENT_OVL0] = MT2712_MUTEX_MOD_DISP_OVL0,
> > +	[DDP_COMPONENT_OVL1] = MT2712_MUTEX_MOD_DISP_OVL1,
> > +	[DDP_COMPONENT_PWM0] = MT2712_MUTEX_MOD_DISP_PWM0,
> > +	[DDP_COMPONENT_PWM1] = MT2712_MUTEX_MOD_DISP_PWM1,
> > +	[DDP_COMPONENT_PWM2] = MT2712_MUTEX_MOD_DISP_PWM2,
> > +	[DDP_COMPONENT_RDMA0] = MT2712_MUTEX_MOD_DISP_RDMA0,
> > +	[DDP_COMPONENT_RDMA1] = MT2712_MUTEX_MOD_DISP_RDMA1,
> > +	[DDP_COMPONENT_RDMA2] = MT2712_MUTEX_MOD_DISP_RDMA2,
> > +	[DDP_COMPONENT_UFOE] = MT2712_MUTEX_MOD_DISP_UFOE,
> > +	[DDP_COMPONENT_WDMA0] = MT2712_MUTEX_MOD_DISP_WDMA0,
> > +	[DDP_COMPONENT_WDMA1] = MT2712_MUTEX_MOD_DISP_WDMA1,
> > +};
> > +
> >  static const unsigned int mt8173_mutex_mod[DDP_COMPONENT_ID_MAX] = {
> > -	[DDP_COMPONENT_AAL] = MT8173_MUTEX_MOD_DISP_AAL,
> > +	[DDP_COMPONENT_AAL0] = MT8173_MUTEX_MOD_DISP_AAL,
> >  	[DDP_COMPONENT_COLOR0] = MT8173_MUTEX_MOD_DISP_COLOR0,
> >  	[DDP_COMPONENT_COLOR1] = MT8173_MUTEX_MOD_DISP_COLOR1,
> >  	[DDP_COMPONENT_GAMMA] = MT8173_MUTEX_MOD_DISP_GAMMA,
> > -	[DDP_COMPONENT_OD] = MT8173_MUTEX_MOD_DISP_OD,
> > +	[DDP_COMPONENT_OD0] = MT8173_MUTEX_MOD_DISP_OD,
> >  	[DDP_COMPONENT_OVL0] = MT8173_MUTEX_MOD_DISP_OVL0,
> >  	[DDP_COMPONENT_OVL1] = MT8173_MUTEX_MOD_DISP_OVL1,
> >  	[DDP_COMPONENT_PWM0] = MT8173_MUTEX_MOD_DISP_PWM0,
> > @@ -138,7 +181,7 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
> >  	} else if (cur == DDP_COMPONENT_OVL0 && next == DDP_COMPONENT_RDMA0) {
> >  		*addr = DISP_REG_CONFIG_DISP_OVL_MOUT_EN;
> >  		value = OVL_MOUT_EN_RDMA;
> > -	} else if (cur == DDP_COMPONENT_OD && next == DDP_COMPONENT_RDMA0) {
> > +	} else if (cur == DDP_COMPONENT_OD0 && next == DDP_COMPONENT_RDMA0) {
> >  		*addr = DISP_REG_CONFIG_DISP_OD_MOUT_EN;
> >  		value = OD_MOUT_EN_RDMA0;
> >  	} else if (cur == DDP_COMPONENT_UFOE && next == DDP_COMPONENT_DSI0) {
> > @@ -407,6 +450,7 @@ static int mtk_ddp_remove(struct platform_device *pdev)
> >  
> >  static const struct of_device_id ddp_driver_dt_match[] = {
> >  	{ .compatible = "mediatek,mt2701-disp-mutex", .data = mt2701_mutex_mod},
> > +	{ .compatible = "mediatek,mt2712-disp-mutex", .data = mt2712_mutex_mod},
> >  	{ .compatible = "mediatek,mt8173-disp-mutex", .data = mt8173_mutex_mod},
> >  	{},
> >  };
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > index 4672317e3ad1..86e8c9e5df41 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > @@ -218,7 +218,8 @@ struct mtk_ddp_comp_match {
> >  };
> >  
> >  static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
> > -	[DDP_COMPONENT_AAL]	= { MTK_DISP_AAL,	0, &ddp_aal },
> > +	[DDP_COMPONENT_AAL0]	= { MTK_DISP_AAL,	0, &ddp_aal },
> > +	[DDP_COMPONENT_AAL1]	= { MTK_DISP_AAL,	1, &ddp_aal },
> >  	[DDP_COMPONENT_BLS]	= { MTK_DISP_BLS,	0, NULL },
> >  	[DDP_COMPONENT_COLOR0]	= { MTK_DISP_COLOR,	0, NULL },
> >  	[DDP_COMPONENT_COLOR1]	= { MTK_DISP_COLOR,	1, NULL },
> > @@ -226,10 +227,13 @@ static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
> >  	[DDP_COMPONENT_DSI0]	= { MTK_DSI,		0, NULL },
> >  	[DDP_COMPONENT_DSI1]	= { MTK_DSI,		1, NULL },
> >  	[DDP_COMPONENT_GAMMA]	= { MTK_DISP_GAMMA,	0, &ddp_gamma },
> > -	[DDP_COMPONENT_OD]	= { MTK_DISP_OD,	0, &ddp_od },
> > +	[DDP_COMPONENT_OD0]	= { MTK_DISP_OD,	0, &ddp_od },
> > +	[DDP_COMPONENT_OD1]	= { MTK_DISP_OD,	1, &ddp_od },
> >  	[DDP_COMPONENT_OVL0]	= { MTK_DISP_OVL,	0, NULL },
> >  	[DDP_COMPONENT_OVL1]	= { MTK_DISP_OVL,	1, NULL },
> >  	[DDP_COMPONENT_PWM0]	= { MTK_DISP_PWM,	0, NULL },
> > +	[DDP_COMPONENT_PWM1]	= { MTK_DISP_PWM,	1, NULL },
> > +	[DDP_COMPONENT_PWM2]	= { MTK_DISP_PWM,	2, NULL },
> >  	[DDP_COMPONENT_RDMA0]	= { MTK_DISP_RDMA,	0, NULL },
> >  	[DDP_COMPONENT_RDMA1]	= { MTK_DISP_RDMA,	1, NULL },
> >  	[DDP_COMPONENT_RDMA2]	= { MTK_DISP_RDMA,	2, NULL },
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> > index 0828cf8bf85c..e00c2e798abd 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> > @@ -41,7 +41,8 @@ enum mtk_ddp_comp_type {
> >  };
> >  
> >  enum mtk_ddp_comp_id {
> > -	DDP_COMPONENT_AAL,
> > +	DDP_COMPONENT_AAL0,
> > +	DDP_COMPONENT_AAL1,
> 
> Move this to a patch 'add ddp component AAL1'.
ok

> 
> >  	DDP_COMPONENT_BLS,
> >  	DDP_COMPONENT_COLOR0,
> >  	DDP_COMPONENT_COLOR1,
> > @@ -49,11 +50,13 @@ enum mtk_ddp_comp_id {
> >  	DDP_COMPONENT_DSI0,
> >  	DDP_COMPONENT_DSI1,
> >  	DDP_COMPONENT_GAMMA,
> > -	DDP_COMPONENT_OD,
> > +	DDP_COMPONENT_OD0,
> > +	DDP_COMPONENT_OD1,
> 
> Move this to a patch 'add ddp component OD1'.
ok

> 
> >  	DDP_COMPONENT_OVL0,
> >  	DDP_COMPONENT_OVL1,
> >  	DDP_COMPONENT_PWM0,
> >  	DDP_COMPONENT_PWM1,
> > +	DDP_COMPONENT_PWM2,
> 
> Move this to a patch 'add ddp component PWM2'.
ok

> 
> >  	DDP_COMPONENT_RDMA0,
> >  	DDP_COMPONENT_RDMA1,
> >  	DDP_COMPONENT_RDMA2,
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > index a2ca90fc403c..3a866e1d6af4 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > @@ -146,11 +146,37 @@ static const enum mtk_ddp_comp_id mt2701_mtk_ddp_ext[] = {
> >  	DDP_COMPONENT_DPI0,
> >  };
> >  
> > +static const enum mtk_ddp_comp_id mt2712_mtk_ddp_main[] = {
> > +	DDP_COMPONENT_OVL0,
> > +	DDP_COMPONENT_COLOR0,
> > +	DDP_COMPONENT_AAL0,
> > +	DDP_COMPONENT_OD0,
> > +	DDP_COMPONENT_RDMA0,
> > +	DDP_COMPONENT_DPI0,
> > +	DDP_COMPONENT_PWM0,
> > +};
> > +
> > +static const enum mtk_ddp_comp_id mt2712_mtk_ddp_ext[] = {
> > +	DDP_COMPONENT_OVL1,
> > +	DDP_COMPONENT_COLOR1,
> > +	DDP_COMPONENT_AAL1,
> > +	DDP_COMPONENT_OD1,
> > +	DDP_COMPONENT_RDMA1,
> > +	DDP_COMPONENT_DPI1,
> > +	DDP_COMPONENT_PWM1,
> > +};
> > +
> > +static const enum mtk_ddp_comp_id mt2712_mtk_ddp_third[] = {
> > +	DDP_COMPONENT_RDMA2,
> > +	DDP_COMPONENT_DSI2,
> > +	DDP_COMPONENT_PWM2,
> > +};
> > +
> >  static const enum mtk_ddp_comp_id mt8173_mtk_ddp_main[] = {
> >  	DDP_COMPONENT_OVL0,
> >  	DDP_COMPONENT_COLOR0,
> > -	DDP_COMPONENT_AAL,
> > -	DDP_COMPONENT_OD,
> > +	DDP_COMPONENT_AAL0,
> > +	DDP_COMPONENT_OD0,
> >  	DDP_COMPONENT_RDMA0,
> >  	DDP_COMPONENT_UFOE,
> >  	DDP_COMPONENT_DSI0,
> > @@ -173,6 +199,15 @@ static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
> >  	.shadow_register = true,
> >  };
> >  
> > +static const struct mtk_mmsys_driver_data mt2712_mmsys_driver_data = {
> > +	.main_path = mt2712_mtk_ddp_main,
> > +	.main_len = ARRAY_SIZE(mt2712_mtk_ddp_main),
> > +	.ext_path = mt2712_mtk_ddp_ext,
> > +	.ext_len = ARRAY_SIZE(mt2712_mtk_ddp_ext),
> > +	.third_path = mt2712_mtk_ddp_third,
> > +	.third_len = ARRAY_SIZE(mt2712_mtk_ddp_third),
> > +};
> > +
> >  static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
> >  	.main_path = mt8173_mtk_ddp_main,
> >  	.main_len = ARRAY_SIZE(mt8173_mtk_ddp_main),
> > @@ -232,6 +267,11 @@ static int mtk_drm_kms_init(struct drm_device *drm)
> >  	if (ret < 0)
> >  		goto err_component_unbind;
> >  
> > +	ret = mtk_drm_crtc_create(drm, private->data->third_path,
> > +				  private->data->third_len);
> > +	if (ret < 0)
> > +		goto err_component_unbind;
> > +
> 
> Move this to a patch 'add third ddp path'.
ok

> 
> Regards,
> CK
> 
> >  	/* Use OVL device for all DMA memory allocations */
> >  	np = private->comp_node[private->data->main_path[0]] ?:
> >  	     private->comp_node[private->data->ext_path[0]];
> > @@ -374,6 +414,7 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
> >  	{ .compatible = "mediatek,mt8173-dsi",        .data = (void *)MTK_DSI },
> >  	{ .compatible = "mediatek,mt8173-dpi",        .data = (void *)MTK_DPI },
> >  	{ .compatible = "mediatek,mt2701-disp-mutex", .data = (void *)MTK_DISP_MUTEX },
> > +	{ .compatible = "mediatek,mt2712-disp-mutex", .data = (void *)MTK_DISP_MUTEX },
> >  	{ .compatible = "mediatek,mt8173-disp-mutex", .data = (void *)MTK_DISP_MUTEX },
> >  	{ .compatible = "mediatek,mt2701-disp-pwm",   .data = (void *)MTK_DISP_BLS },
> >  	{ .compatible = "mediatek,mt8173-disp-pwm",   .data = (void *)MTK_DISP_PWM },
> > @@ -552,6 +593,8 @@ static SIMPLE_DEV_PM_OPS(mtk_drm_pm_ops, mtk_drm_sys_suspend,
> >  static const struct of_device_id mtk_drm_of_ids[] = {
> >  	{ .compatible = "mediatek,mt2701-mmsys",
> >  	  .data = &mt2701_mmsys_driver_data},
> > +	{ .compatible = "mediatek,mt2712-mmsys",
> > +	  .data = &mt2712_mmsys_driver_data},
> >  	{ .compatible = "mediatek,mt8173-mmsys",
> >  	  .data = &mt8173_mmsys_driver_data},
> >  	{ }
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> > index c3378c452c0a..e821342bc2d3 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> > @@ -17,8 +17,8 @@
> >  #include <linux/io.h>
> >  #include "mtk_drm_ddp_comp.h"
> >  
> > -#define MAX_CRTC	2
> > -#define MAX_CONNECTOR	2
> > +#define MAX_CRTC	3
> > +#define MAX_CONNECTOR	3
> >  
> >  struct device;
> >  struct device_node;
> > @@ -33,6 +33,9 @@ struct mtk_mmsys_driver_data {
> >  	unsigned int main_len;
> >  	const enum mtk_ddp_comp_id *ext_path;
> >  	unsigned int ext_len;
> > +	enum mtk_ddp_comp_id *third_path;
> > +	unsigned int third_len;
> > +
> >  	bool shadow_register;
> >  };
> >  
> 
> 
