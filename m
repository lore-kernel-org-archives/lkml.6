Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965489AbeEXIkk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:40:40 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:21832 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S965296AbeEXIkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:40:36 -0400
X-UUID: 92c81f2ec1a64da9b98fd20dc9356f1c-20180524
Message-ID: <1527151228.12697.3.camel@mtksdaap41>
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
Date: Thu, 24 May 2018 16:40:28 +0800
In-Reply-To: <1527125197.6406.10.camel@mtksdaap41>
References: <20180523022517.12103-1-stu.hsieh@mediatek.com>
         <20180523022517.12103-3-stu.hsieh@mediatek.com>
         <1527053036.10410.18.camel@mtksdaap41>
         <1527067696.19074.28.camel@mtksdaap41>
         <1527125197.6406.10.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi CK,

On Thu, 2018-05-24 at 09:26 +0800, CK Hu wrote:
> Hi, Stu:
> 
> On Wed, 2018-05-23 at 17:28 +0800, Stu Hsieh wrote:
> > On Wed, 2018-05-23 at 13:23 +0800, CK Hu wrote:
> > > Hi, Stu:
> > > 
> > > I've some inline comment.
> > > 
> > > On Wed, 2018-05-23 at 10:25 +0800, Stu Hsieh wrote:
> > > > This patch add support for the Mediatek MT2712 DISP subsystem.
> > > > There are two OVL engine and three disp output in MT2712.
> > > > 
> > > > Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> > > > ---
> > > >  drivers/gpu/drm/mediatek/mtk_drm_ddp.c      | 50 +++++++++++++++++++++++++++--
> > > >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |  8 +++--
> > > >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  7 ++--
> > > >  drivers/gpu/drm/mediatek/mtk_drm_drv.c      | 47 +++++++++++++++++++++++++--
> > > >  drivers/gpu/drm/mediatek/mtk_drm_drv.h      |  7 ++--
> > > >  5 files changed, 108 insertions(+), 11 deletions(-)
> > > > 
> > > > +#define MT2712_MUTEX_MOD_DISP_AAL0		BIT(20)
> > > > +#define MT2712_MUTEX_MOD_DISP_UFOE		BIT(22)
> > > > +#define MT2712_MUTEX_MOD_DISP_PWM0		BIT(23)
> > > > +#define MT2712_MUTEX_MOD_DISP_PWM1		BIT(24)
> > > > +#define MT2712_MUTEX_MOD_DISP_PWM2		BIT(10)
> > > > +#define MT2712_MUTEX_MOD_DISP_OD0		BIT(25)
> > > > +/* modules more than 32, add BIT(31) when using DISP_REG_MUTEX_MOD2 bit */
> > > > +#define MT2712_MUTEX_MOD2_DISP_AAL1		(BIT(1) | BIT(31))
> > > 
> > > I think a better definition is
> > > 
> > > #define MT2712_MUTEX_MOD2_DISP_AAL1		BIT(33)
> > > 
> > > when you need to access this register,
> > > 
> > > if (ddp->mutex_mod[id] < BIT(32)) {
> > > 	offset = DISP_REG_MUTEX_MOD(mutex->id);
> > > 	reg = readl_relaxed(ddp->regs + offset);
> > > 	reg |= ddp->mutex_mod[id];
> > > 	writel_relaxed(reg, ddp->regs + offset);
> > > } else {
> > > 	offset = DISP_REG_MUTEX_MOD2(mutex->id);
> > > 	reg = readl_relaxed(ddp->regs + offset);
> > > 	reg |= (ddp->mutex_mod[id] >> 32);
> > > 	writel_relaxed(reg, ddp->regs + offset);
> > > }
> > > 
> > > because DISP_REG_MUTEX_MOD BIT(31) could be used for some module.
> > 
> > This modification is workable, but result some build warning like
> > following:
> > 1. #define BIT(nr)   (1UL << (nr)) in include/linux/bitops.h
> > 2. [DDP_COMPONENT_AAL1] = MT2712_MUTEX_MOD2_DISP_AAL1,
> >    => we need to modify the definition about "static const unsigned int
> > mt2712_mutex_mod"
> > 
> 
> Currently, mutex_mod is a bitwise definition. I think it could be
> changed to index definition such as
> 
> 
> #define MT2712_MUTEX_MOD_DISP_PWM2		10
> #define MT2712_MUTEX_MOD_DISP_OD0		25
> #define MT2712_MUTEX_MOD2_DISP_AAL1		33
> 
> when you need to access this register,
> 
> if (ddp->mutex_mod[id] < 32) {
> 	offset = DISP_REG_MUTEX_MOD(mutex->id);
> 	reg = readl_relaxed(ddp->regs + offset);
> 	reg |= 1 << ddp->mutex_mod[id];
> 	writel_relaxed(reg, ddp->regs + offset);
> } else {
> 	offset = DISP_REG_MUTEX_MOD2(mutex->id);
> 	reg = readl_relaxed(ddp->regs + offset);
> 	reg |= 1 << (ddp->mutex_mod[id] - 32);
> 	writel_relaxed(reg, ddp->regs + offset);
> }
> 
> Regards,
> CK

This modification has no build warning.
I would also change the definition about 2701 and 8173 from bitwise to
index.

Regards,
Stu

> 
> > > > +#define MT2712_MUTEX_MOD2_DISP_OD1		(BIT(2) | BIT(31))
> > > > +
> > > >  #define MT2701_MUTEX_MOD_DISP_OVL		BIT(3)
> > > >  #define MT2701_MUTEX_MOD_DISP_WDMA		BIT(6)
> > > >  #define MT2701_MUTEX_MOD_DISP_COLOR		BIT(7)
> > > > @@ -74,6 +96,7 @@
> > > >  
> > > >  
> > > 
> > > 
> > 
> > 
> 
> 
