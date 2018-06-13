Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 57993C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BACC208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BACC208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934412AbeFMHsI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 03:48:08 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:31099 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S933704AbeFMHsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 03:48:07 -0400
X-UUID: 7b897cff282d4fa0bd4f0c8fb70443c1-20180613
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 674066135; Wed, 13 Jun 2018 15:48:05 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 13 Jun 2018 15:48:03 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 13 Jun 2018 15:48:03 +0800
Message-ID: <1528876083.30263.16.camel@mtksdaap41>
Subject: Re: [PATCH 28/28] drm/mediatek: Add support for mediatek SOC MT2712
From:   CK Hu <ck.hu@mediatek.com>
To:     Stu Hsieh <stu.hsieh@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Date:   Wed, 13 Jun 2018 15:48:03 +0800
In-Reply-To: <1528687580-549-29-git-send-email-stu.hsieh@mediatek.com>
References: <1528687580-549-1-git-send-email-stu.hsieh@mediatek.com>
         <1528687580-549-29-git-send-email-stu.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Stu:

On Mon, 2018-06-11 at 11:26 +0800, Stu Hsieh wrote:
> This patch add support for the Mediatek MT2712 DISP subsystem.
> There are two OVL engine and three disp output in MT2712.
> 
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>

Reviewed-by: CK Hu <ck.hu at mediatek.com>

> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 39 ++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 38 +++++++++++++++++++++++++++++++++
>  2 files changed, 77 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index 28dd8531a7de..c3fa5591bfc8 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -65,6 +65,24 @@
>  #define MT8173_MUTEX_MOD_DISP_PWM1		24
>  #define MT8173_MUTEX_MOD_DISP_OD		25
>  
> +#define MT2712_MUTEX_MOD_DISP_PWM2		10
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
> +#define MT2712_MUTEX_MOD_DISP_OD0		25
> +#define MT2712_MUTEX_MOD2_DISP_AAL1		33
> +#define MT2712_MUTEX_MOD2_DISP_OD1		34
> +
>  #define MT2701_MUTEX_MOD_DISP_OVL		3
>  #define MT2701_MUTEX_MOD_DISP_WDMA		6
>  #define MT2701_MUTEX_MOD_DISP_COLOR		7
> @@ -138,6 +156,26 @@ static const unsigned int mt2701_mutex_mod[DDP_COMPONENT_ID_MAX] = {
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
>  	[DDP_COMPONENT_AAL0] = MT8173_MUTEX_MOD_DISP_AAL,
>  	[DDP_COMPONENT_COLOR0] = MT8173_MUTEX_MOD_DISP_COLOR0,
> @@ -533,6 +571,7 @@ static int mtk_ddp_remove(struct platform_device *pdev)
>  
>  static const struct of_device_id ddp_driver_dt_match[] = {
>  	{ .compatible = "mediatek,mt2701-disp-mutex", .data = mt2701_mutex_mod},
> +	{ .compatible = "mediatek,mt2712-disp-mutex", .data = mt2712_mutex_mod},
>  	{ .compatible = "mediatek,mt8173-disp-mutex", .data = mt8173_mutex_mod},
>  	{},
>  };
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index 3d279a299383..3a866e1d6af4 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -146,6 +146,32 @@ static const enum mtk_ddp_comp_id mt2701_mtk_ddp_ext[] = {
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
> +	DDP_COMPONENT_DSI3,
> +	DDP_COMPONENT_PWM2,
> +};
> +
>  static const enum mtk_ddp_comp_id mt8173_mtk_ddp_main[] = {
>  	DDP_COMPONENT_OVL0,
>  	DDP_COMPONENT_COLOR0,
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
> @@ -379,6 +414,7 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
>  	{ .compatible = "mediatek,mt8173-dsi",        .data = (void *)MTK_DSI },
>  	{ .compatible = "mediatek,mt8173-dpi",        .data = (void *)MTK_DPI },
>  	{ .compatible = "mediatek,mt2701-disp-mutex", .data = (void *)MTK_DISP_MUTEX },
> +	{ .compatible = "mediatek,mt2712-disp-mutex", .data = (void *)MTK_DISP_MUTEX },
>  	{ .compatible = "mediatek,mt8173-disp-mutex", .data = (void *)MTK_DISP_MUTEX },
>  	{ .compatible = "mediatek,mt2701-disp-pwm",   .data = (void *)MTK_DISP_BLS },
>  	{ .compatible = "mediatek,mt8173-disp-pwm",   .data = (void *)MTK_DISP_PWM },
> @@ -557,6 +593,8 @@ static SIMPLE_DEV_PM_OPS(mtk_drm_pm_ops, mtk_drm_sys_suspend,
>  static const struct of_device_id mtk_drm_of_ids[] = {
>  	{ .compatible = "mediatek,mt2701-mmsys",
>  	  .data = &mt2701_mmsys_driver_data},
> +	{ .compatible = "mediatek,mt2712-mmsys",
> +	  .data = &mt2712_mmsys_driver_data},
>  	{ .compatible = "mediatek,mt8173-mmsys",
>  	  .data = &mt8173_mmsys_driver_data},
>  	{ }


