Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795AFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 02:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 408A62171F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 02:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeLZC5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 21:57:03 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:6735 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726948AbeLZC5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 21:57:03 -0500
X-UUID: edf04048d0304c6f8a222e14acd23963-20181226
X-UUID: edf04048d0304c6f8a222e14acd23963-20181226
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 296912647; Wed, 26 Dec 2018 10:56:58 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 26 Dec 2018 10:56:54 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 26 Dec 2018 10:56:54 +0800
Message-ID: <1545793014.14496.21.camel@mtksdaap41>
Subject: Re: [PATCH 02/18] drm/mediatek: add mutex mod and sof into ddp
 private data
From:   CK Hu <ck.hu@mediatek.com>
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 26 Dec 2018 10:56:54 +0800
In-Reply-To: <1545638931-24938-3-git-send-email-yongqiang.niu@mediatek.com>
References: <1545638931-24938-1-git-send-email-yongqiang.niu@mediatek.com>
         <1545638931-24938-3-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

On Mon, 2018-12-24 at 16:08 +0800, Yongqiang Niu wrote:
> This patch add mutex mod and sof into ddp private data

Usually, the commit title shows 'WHAT' does this patch do, commit
message shows 'WHY' does this patch do, and commit body shows 'HOW' does
this patch do. This commit message just show WHAT does this patch do but
does not show WHY. Maybe this is trivial for you but not for everyone.
So describe more about why you do this.

In addition, 'add mutex mode' and 'add sof' are two things, so break
these two modification into two patches.

> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 117 ++++++++++++++++++++++++++-------
>  1 file changed, 94 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index 579ce28..adb37e4 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -41,11 +41,14 @@
>  #define DISP_REG_CONFIG_DSI_SEL			0x050
>  #define DISP_REG_CONFIG_DPI_SEL			0x064
>  
> +#define MT2701_DISP_MUTEX0_MOD0 0x2C

Lower case for hex number.

> +#define MT2701_DISP_MUTEX0_SOF0  0x30

Align 0x2c and 0x30

> +
>  #define DISP_REG_MUTEX_EN(n)	(0x20 + 0x20 * (n))
>  #define DISP_REG_MUTEX(n)	(0x24 + 0x20 * (n))
>  #define DISP_REG_MUTEX_RST(n)	(0x28 + 0x20 * (n))
> -#define DISP_REG_MUTEX_MOD(n)	(0x2c + 0x20 * (n))
> -#define DISP_REG_MUTEX_SOF(n)	(0x30 + 0x20 * (n))
> +#define DISP_REG_MUTEX_MOD(data, n)	((data)->mutex_mod_reg + 0x20 * (n))
> +#define DISP_REG_MUTEX_SOF(data, n)	((data)->mutex_sof_reg + 0x20 * (n))
>  #define DISP_REG_MUTEX_MOD2(n)	(0x34 + 0x20 * (n))
>  
>  #define INT_MUTEX				BIT(1)
> @@ -147,12 +150,30 @@ struct mtk_disp_mutex {
>  	bool claimed;
>  };
>  
> +enum mtk_ddp_mutex_sof_id {
> +	DDP_MUTEX_SOF_SINGLE_MODE,
> +	DDP_MUTEX_SOF_DSI0,
> +	DDP_MUTEX_SOF_DSI1,
> +	DDP_MUTEX_SOF_DPI0,
> +	DDP_MUTEX_SOF_DPI1,
> +	DDP_MUTEX_SOF_DSI2,
> +	DDP_MUTEX_SOF_DSI3,
> +	DDP_MUTEX_SOF_MAX,
> +};
> +
> +struct mtk_ddp_data {
> +	const unsigned int *mutex_mod;
> +	const unsigned int *mutex_sof;
> +	unsigned int mutex_mod_reg;
> +	unsigned int mutex_sof_reg;
> +};
> +
>  struct mtk_ddp {
>  	struct device			*dev;
>  	struct clk			*clk;
>  	void __iomem			*regs;
>  	struct mtk_disp_mutex		mutex[10];
> -	const unsigned int		*mutex_mod;
> +	const struct mtk_ddp_data	*data;
>  };
>  
>  static const unsigned int mt2701_mutex_mod[DDP_COMPONENT_ID_MAX] = {
> @@ -202,6 +223,51 @@ struct mtk_ddp {
>  	[DDP_COMPONENT_WDMA1] = MT8173_MUTEX_MOD_DISP_WDMA1,
>  };
>  
> +static const unsigned int mt2701_mutex_sof[DDP_MUTEX_SOF_MAX] = {
> +	[DDP_MUTEX_SOF_SINGLE_MODE] = MUTEX_SOF_SINGLE_MODE,
> +	[DDP_MUTEX_SOF_DSI0] = MUTEX_SOF_DSI0,
> +	[DDP_MUTEX_SOF_DSI1] = MUTEX_SOF_DSI1,
> +	[DDP_MUTEX_SOF_DPI0] = MUTEX_SOF_DPI0,
> +};
> +
> +static const unsigned int mt2712_mutex_sof[DDP_MUTEX_SOF_MAX] = {
> +	[DDP_MUTEX_SOF_SINGLE_MODE] = MUTEX_SOF_SINGLE_MODE,
> +	[DDP_MUTEX_SOF_DSI0] = MUTEX_SOF_DSI0,
> +	[DDP_MUTEX_SOF_DSI1] = MUTEX_SOF_DSI1,
> +	[DDP_MUTEX_SOF_DPI0] = MUTEX_SOF_DPI0,
> +	[DDP_MUTEX_SOF_DPI1] = MUTEX_SOF_DPI1,
> +	[DDP_MUTEX_SOF_DSI2] = MUTEX_SOF_DSI2,
> +	[DDP_MUTEX_SOF_DSI3] = MUTEX_SOF_DSI3,
> +};
> +
> +static const unsigned int mt8173_mutex_sof[DDP_MUTEX_SOF_MAX] = {
> +	[DDP_MUTEX_SOF_SINGLE_MODE] = MUTEX_SOF_SINGLE_MODE,
> +	[DDP_MUTEX_SOF_DSI0] = MUTEX_SOF_DSI0,
> +	[DDP_MUTEX_SOF_DSI1] = MUTEX_SOF_DSI1,
> +	[DDP_MUTEX_SOF_DPI0] = MUTEX_SOF_DPI0,
> +};

It looks like that both mt8173_mutex_sof and mt2701_mutex_sof are subset
of mt2712_mutex_sof, so I think you could keep only mt2712_mutex_sof and
mt8173 and mt2701 also use this one.

> +
> +static const struct mtk_ddp_data mt2701_ddp_driver_data = {
> +	.mutex_mod = mt2701_mutex_mod,
> +	.mutex_sof = mt2701_mutex_sof,
> +	.mutex_mod_reg = MT2701_DISP_MUTEX0_MOD0,
> +	.mutex_sof_reg = MT2701_DISP_MUTEX0_SOF0,
> +};
> +
> +static const struct mtk_ddp_data mt2712_ddp_driver_data = {
> +	.mutex_mod = mt2712_mutex_mod,
> +	.mutex_sof = mt2712_mutex_sof,
> +	.mutex_mod_reg = MT2701_DISP_MUTEX0_MOD0,
> +	.mutex_sof_reg = MT2701_DISP_MUTEX0_SOF0,
> +};
> +
> +static const struct mtk_ddp_data mt8173_ddp_driver_data = {
> +	.mutex_mod = mt8173_mutex_mod,
> +	.mutex_sof = mt8173_mutex_sof,
> +	.mutex_mod_reg = MT2701_DISP_MUTEX0_MOD0,
> +	.mutex_sof_reg = MT2701_DISP_MUTEX0_SOF0,
> +};
> +
>  static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
>  				    enum mtk_ddp_comp_id next,
>  				    unsigned int *addr)
> @@ -446,39 +512,40 @@ void mtk_disp_mutex_add_comp(struct mtk_disp_mutex *mutex,
>  
>  	switch (id) {
>  	case DDP_COMPONENT_DSI0:
> -		reg = MUTEX_SOF_DSI0;
> +		reg = DDP_MUTEX_SOF_DSI0;

I would like you to change 'reg' to 'id' because you change the usage of
this variable.

Regards,
CK

>  		break;
>  	case DDP_COMPONENT_DSI1:
> -		reg = MUTEX_SOF_DSI0;
> +		reg = DDP_MUTEX_SOF_DSI0;
>  		break;
>  	case DDP_COMPONENT_DSI2:
> -		reg = MUTEX_SOF_DSI2;
> +		reg = DDP_MUTEX_SOF_DSI2;
>  		break;
>  	case DDP_COMPONENT_DSI3:
> -		reg = MUTEX_SOF_DSI3;
> +		reg = DDP_MUTEX_SOF_DSI3;
>  		break;
>  	case DDP_COMPONENT_DPI0:
> -		reg = MUTEX_SOF_DPI0;
> +		reg = DDP_MUTEX_SOF_DPI0;
>  		break;
>  	case DDP_COMPONENT_DPI1:
> -		reg = MUTEX_SOF_DPI1;
> +		reg = DDP_MUTEX_SOF_DPI1;
>  		break;
>  	default:
> -		if (ddp->mutex_mod[id] < 32) {
> -			offset = DISP_REG_MUTEX_MOD(mutex->id);
> +		if (ddp->data->mutex_mod[id] < 32) {
> +			offset = DISP_REG_MUTEX_MOD(ddp->data, mutex->id);
>  			reg = readl_relaxed(ddp->regs + offset);
> -			reg |= 1 << ddp->mutex_mod[id];
> +			reg |= 1 << ddp->data->mutex_mod[id];
>  			writel_relaxed(reg, ddp->regs + offset);
>  		} else {
>  			offset = DISP_REG_MUTEX_MOD2(mutex->id);
>  			reg = readl_relaxed(ddp->regs + offset);
> -			reg |= 1 << (ddp->mutex_mod[id] - 32);
> +			reg |= 1 << (ddp->data->mutex_mod[id] - 32);
>  			writel_relaxed(reg, ddp->regs + offset);
>  		}
>  		return;
>  	}
>  
> -	writel_relaxed(reg, ddp->regs + DISP_REG_MUTEX_SOF(mutex->id));
> +	writel_relaxed(ddp->data->mutex_sof[reg],
> +		       ddp->regs + DISP_REG_MUTEX_SOF(ddp->data, mutex->id));
>  }
>  
>  void mtk_disp_mutex_remove_comp(struct mtk_disp_mutex *mutex,
> @@ -499,18 +566,19 @@ void mtk_disp_mutex_remove_comp(struct mtk_disp_mutex *mutex,
>  	case DDP_COMPONENT_DPI0:
>  	case DDP_COMPONENT_DPI1:
>  		writel_relaxed(MUTEX_SOF_SINGLE_MODE,
> -			       ddp->regs + DISP_REG_MUTEX_SOF(mutex->id));
> +			       ddp->regs +
> +			       DISP_REG_MUTEX_SOF(ddp->data, mutex->id));
>  		break;
>  	default:
> -		if (ddp->mutex_mod[id] < 32) {
> -			offset = DISP_REG_MUTEX_MOD(mutex->id);
> +		if (ddp->data->mutex_mod[id] < 32) {
> +			offset = DISP_REG_MUTEX_MOD(ddp->data, mutex->id);
>  			reg = readl_relaxed(ddp->regs + offset);
> -			reg &= ~(1 << ddp->mutex_mod[id]);
> +			reg &= ~(1 << ddp->data->mutex_mod[id]);
>  			writel_relaxed(reg, ddp->regs + offset);
>  		} else {
>  			offset = DISP_REG_MUTEX_MOD2(mutex->id);
>  			reg = readl_relaxed(ddp->regs + offset);
> -			reg &= ~(1 << (ddp->mutex_mod[id] - 32));
> +			reg &= ~(1 << (ddp->data->mutex_mod[id] - 32));
>  			writel_relaxed(reg, ddp->regs + offset);
>  		}
>  		break;
> @@ -585,7 +653,7 @@ static int mtk_ddp_probe(struct platform_device *pdev)
>  		return PTR_ERR(ddp->regs);
>  	}
>  
> -	ddp->mutex_mod = of_device_get_match_data(dev);
> +	ddp->data = of_device_get_match_data(dev);
>  
>  	platform_set_drvdata(pdev, ddp);
>  
> @@ -598,9 +666,12 @@ static int mtk_ddp_remove(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id ddp_driver_dt_match[] = {
> -	{ .compatible = "mediatek,mt2701-disp-mutex", .data = mt2701_mutex_mod},
> -	{ .compatible = "mediatek,mt2712-disp-mutex", .data = mt2712_mutex_mod},
> -	{ .compatible = "mediatek,mt8173-disp-mutex", .data = mt8173_mutex_mod},
> +	{ .compatible = "mediatek,mt2701-disp-mutex",
> +	  .data = &mt2701_ddp_driver_data},
> +	{ .compatible = "mediatek,mt2712-disp-mutex",
> +	  .data = &mt2712_ddp_driver_data},
> +	{ .compatible = "mediatek,mt8173-disp-mutex",
> +	  .data = &mt8173_ddp_driver_data},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, ddp_driver_dt_match);


