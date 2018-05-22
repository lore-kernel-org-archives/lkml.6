Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751283AbeEVI2m (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 04:28:42 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:42590 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750707AbeEVI2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 04:28:37 -0400
X-UUID: ad220960ba1b40398d9f7fe736fdae57-20180522
Message-ID: <1526977710.19294.9.camel@mtksdaap41>
Subject: Re: [PATCH 1/1] drm/mediatek: Add support for mediatek SOC MT2712
From: CK Hu <ck.hu@mediatek.com>
To: Stu Hsieh <stu.hsieh@mediatek.com>
CC: Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <srv_heupstream@mediatek.com>
Date: Tue, 22 May 2018 16:28:30 +0800
In-Reply-To: <1526975226.19074.16.camel@mtksdaap41>
References: <20180514095910.22618-1-stu.hsieh@mediatek.com>
         <20180514095910.22618-2-stu.hsieh@mediatek.com>
         <1526351429.29995.21.camel@mtksdaap41>
         <1526975226.19074.16.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Stu:

On Tue, 2018-05-22 at 15:47 +0800, Stu Hsieh wrote:
> Hi, CK:
> 
> I've some reply for comment
> 
> On Tue, 2018-05-15 at 10:30 +0800, CK Hu wrote:
> > Hi, Stu:
> > 
> > I've some inline comments.
> > 
> > On Mon, 2018-05-14 at 17:59 +0800, Stu Hsieh wrote:
> > > This patch add support for the Mediatek MT2712 DISP subsystem.
> > > There are two OVL engine and three disp output in MT2712.
> > > 
> > > Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> > > ---
> > >  drivers/gpu/drm/mediatek/mtk_drm_ddp.c      | 77 ++++++++++++++++++++++++++---
> > >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |  4 ++
> > >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  3 ++
> > >  drivers/gpu/drm/mediatek/mtk_drm_drv.c      | 44 +++++++++++++++++
> > >  drivers/gpu/drm/mediatek/mtk_drm_drv.h      |  7 ++-
> > >  5 files changed, 127 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > > index 8130f3dab661..641f4361b006 100644
> > >  
> > >  #define INT_MUTEX				BIT(1)
> > >  
> > > @@ -60,6 +63,25 @@
> > >  #define MT8173_MUTEX_MOD_DISP_PWM1		BIT(24)
> > >  #define MT8173_MUTEX_MOD_DISP_OD		BIT(25)
> > >  
> > > +#define MT2712_MUTEX_MOD_DISP_OVL0		BIT(11)
> > > +#define MT2712_MUTEX_MOD_DISP_OVL1		BIT(12)
> > > +#define MT2712_MUTEX_MOD_DISP_RDMA0		BIT(13)
> > > +#define MT2712_MUTEX_MOD_DISP_RDMA1		BIT(14)
> > > +#define MT2712_MUTEX_MOD_DISP_RDMA2		BIT(15)
> > > +#define MT2712_MUTEX_MOD_DISP_WDMA0		BIT(16)
> > > +#define MT2712_MUTEX_MOD_DISP_WDMA1		BIT(17)
> > > +#define MT2712_MUTEX_MOD_DISP_COLOR0		BIT(18)
> > > +#define MT2712_MUTEX_MOD_DISP_COLOR1		BIT(19)
> > > +#define MT2712_MUTEX_MOD_DISP_AAL		BIT(20)
> > > +#define MT2712_MUTEX_MOD_DISP_UFOE		BIT(22)
> > > +#define MT2712_MUTEX_MOD_DISP_PWM0		BIT(23)
> > > +#define MT2712_MUTEX_MOD_DISP_PWM1		BIT(24)
> > > +#define MT2712_MUTEX_MOD_DISP_PWM2		BIT(10)
> > > +#define MT2712_MUTEX_MOD_DISP_OD		BIT(25)
> > > +/* modules more than 32, add BIT(31) when using DISP_REG_MUTEX_MOD2 bit */
> > > +#define MT2712_MUTEX_MOD2_DISP_AAL1		(BIT(1) | BIT(31))
> > > +#define MT2712_MUTEX_MOD2_DISP_OD1		(BIT(2) | BIT(31))
> > > +
> > 
> > It looks like that MUTEX_MOD definition varies for each SoC. I think
> > such definition should be passed from dts to prevent modify driver for
> > each SoC. For example, the clock definition varies for each SoC, and its
> > definition is placed in [1]. The dts [2] include the header file and
> > pass the clock definition to driver.
> > [1]
> > https://elixir.bootlin.com/linux/v4.17-rc5/source/include/dt-bindings/clock/mt2712-clk.h 
> > [2]
> > https://elixir.bootlin.com/linux/v4.17-rc5/source/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> > 
> This idea is good but weak relation for this MT2712 patch
> In the future, we would commit other patch serial for this issue
> 

If you have a plan to pass these definition from device tree, for me,
it's ok to temporarily write down the definition in driver.

> > >  #define MT2701_MUTEX_MOD_DISP_OVL		BIT(3)
> > >  #define MT2701_MUTEX_MOD_DISP_WDMA		BIT(6)
> > >  #define MT2701_MUTEX_MOD_DISP_COLOR		BIT(7)
> > > @@ -74,6 +96,7 @@
> > >  
> > >  #define OVL0_MOUT_EN_COLOR0		0x1
> > >  #define OD_MOUT_EN_RDMA0		0x1
> > > +#define OD1_MOUT_EN_RDMA1		BIT(16)
> > >  #define UFOE_MOUT_EN_DSI0		0x1
> > >  #define COLOR0_SEL_IN_OVL0		0x1
> > >  #define OVL1_MOUT_EN_COLOR1		0x1
> > > @@ -108,6 +131,26 @@ static const unsigned int mt2701_mutex_mod[DDP_COMPONENT_ID_MAX] = {
> > >  	[DDP_COMPONENT_WDMA0] = MT2701_MUTEX_MOD_DISP_WDMA,
> > >  };
> > >  
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > > index a2ca90fc403c..41baf6653bfc 100644
> > > --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > > +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > > @@ -146,6 +146,32 @@ static const enum mtk_ddp_comp_id mt2701_mtk_ddp_ext[] = {
> > >  	DDP_COMPONENT_DPI0,
> > >  };
> > >  
> > > +static const enum mtk_ddp_comp_id mt2712_mtk_ddp_main[] = {
> > > +	DDP_COMPONENT_OVL0,
> > > +	DDP_COMPONENT_COLOR0,
> > > +	DDP_COMPONENT_AAL,
> > > +	DDP_COMPONENT_OD,
> > > +	DDP_COMPONENT_RDMA0,
> > > +	DDP_COMPONENT_DPI0,
> > > +	DDP_COMPONENT_PWM0,
> > > +};
> > > +
> > > +static const enum mtk_ddp_comp_id mt2712_mtk_ddp_ext[] = {
> > > +	DDP_COMPONENT_OVL1,
> > > +	DDP_COMPONENT_COLOR1,
> > > +	DDP_COMPONENT_AAL1,
> > > +	DDP_COMPONENT_OD1,
> > > +	DDP_COMPONENT_RDMA1,
> > > +	DDP_COMPONENT_DPI1,
> > > +	DDP_COMPONENT_PWM1,
> > > +};
> > > +
> > > +static const enum mtk_ddp_comp_id mt2712_mtk_ddp_third[] = {
> > > +	DDP_COMPONENT_RDMA2,
> > > +	DDP_COMPONENT_DSI2,
> > > +	DDP_COMPONENT_PWM2,
> > > +};
> > > +
> > 
> > It looks like that the path definition varies for each SoC. I think such
> > definition should be passed from dts to prevent modify driver for each
> > SoC. In [3], it define the partial connection in device tree, but I
> > would like this to be more general. My idea is:
> > 
> > 1. Each component has one or two endpoint in device tree. The first and
> > the last has one, and the others has two.
> > 2. Remove mtxxxx_mtk_ddp_main[] and mtxxxx_mtk_ddp_ext[], use multiple
> > link list (One display path has one link list, two display path has two
> > link list) to generate it by parsing device tree in mtk_drm_probe().
> > 
> > [3] https://patchwork.kernel.org/patch/10397337/
> > 
> In the future, we would commit other patch serial for this issue.
> Moreover, in addition to using dts and link list to establish the ddp
> path, we want to design a new mechanism to add/remove the component into
> this ddp path for run time
> 

If you have a plan to pass the routine from device tree, for me, it's ok
to temporarily write down the routine in driver.

Regards,
CK

> > >  static const enum mtk_ddp_comp_id mt8173_mtk_ddp_main[] = {
> > >  	DDP_COMPONENT_OVL0,
> > >  	DDP_COMPONENT_COLOR0,
> > > @@ -173,6 +199,15 @@ static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
> > >  	.shadow_register = true,
> > >  };
> > >  
> > > +static const struct mtk_mmsys_driver_data mt2712_mmsys_driver_data = {
> > > +	.main_path = mt2712_mtk_ddp_main,
> > > +	.main_len = ARRAY_SIZE(mt2712_mtk_ddp_main),
> > > +	.ext_path = mt2712_mtk_ddp_ext,
> > > +	.ext_len = ARRAY_SIZE(mt2712_mtk_ddp_ext),
> > > +	.third_path = mt2712_mtk_ddp_third,
> > > +	.third_len = ARRAY_SIZE(mt2712_mtk_ddp_third),
> > > +};
> > > +
> > >  static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
> > >  	.main_path = mt8173_mtk_ddp_main,
> > >  	.main_len = ARRAY_SIZE(mt8173_mtk_ddp_main),
> > > @@ -232,6 +267,11 @@ static int mtk_drm_kms_init(struct drm_device *drm)
> > >  	if (ret < 0)
> > >  		goto err_component_unbind;
> > >  
> > > +	ret = mtk_drm_crtc_create(drm, private->data->third_path,
> > > +				  private->data->third_len);
> > > +	if (ret < 0)
> > > +		goto err_component_unbind;
> > > +
> > >  	/* Use OVL device for all DMA memory allocations */
> > >  	np = private->comp_node[private->data->main_path[0]] ?:
> > >  	     private->comp_node[private->data->ext_path[0]];
> > > @@ -372,8 +412,10 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
> > >  	{ .compatible = "mediatek,mt8173-disp-ufoe",  .data = (void *)MTK_DISP_UFOE },
> > >  	{ .compatible = "mediatek,mt2701-dsi",	      .data = (void *)MTK_DSI },
> > >  	{ .compatible = "mediatek,mt8173-dsi",        .data = (void *)MTK_DSI },
> > > +	{ .compatible = "mediatek,mt2712-dpi",        .data = (void *)MTK_DPI },
> > 
> > Move this modification to the patch which modify the dpi driver for
> > mt2712.
> ok
> > 
> > >  	{ .compatible = "mediatek,mt8173-dpi",        .data = (void *)MTK_DPI },
> > >  	{ .compatible = "mediatek,mt2701-disp-mutex", .data = (void *)MTK_DISP_MUTEX },
> > > +	{ .compatible = "mediatek,mt2712-disp-mutex", .data = (void *)MTK_DISP_MUTEX },
> > >  	{ .compatible = "mediatek,mt8173-disp-mutex", .data = (void *)MTK_DISP_MUTEX },
> > >  	{ .compatible = "mediatek,mt2701-disp-pwm",   .data = (void *)MTK_DISP_BLS },
> > >  	{ .compatible = "mediatek,mt8173-disp-pwm",   .data = (void *)MTK_DISP_PWM },
> > > @@ -552,6 +594,8 @@ static SIMPLE_DEV_PM_OPS(mtk_drm_pm_ops, mtk_drm_sys_suspend,
> > >  static const struct of_device_id mtk_drm_of_ids[] = {
> > >  	{ .compatible = "mediatek,mt2701-mmsys",
> > >  	  .data = &mt2701_mmsys_driver_data},
> > > +	{ .compatible = "mediatek,mt2712-mmsys",
> > > +	  .data = &mt2712_mmsys_driver_data},
> > >  	{ .compatible = "mediatek,mt8173-mmsys",
> > >  	  .data = &mt8173_mmsys_driver_data},
> > >  	{ }
> > 
> > Regards,
> > CK
> > 
> 
> Regards,
> Stu
> 
