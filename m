Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034C7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 03:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE9D2148E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 03:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbeLZDv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 22:51:58 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:37869 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725996AbeLZDv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 22:51:58 -0500
X-UUID: 7be3f90981fd4e21bc98b7bc71a0e870-20181226
X-UUID: 7be3f90981fd4e21bc98b7bc71a0e870-20181226
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1128872739; Wed, 26 Dec 2018 11:51:47 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 26 Dec 2018 11:51:45 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 26 Dec 2018 11:51:45 +0800
Message-ID: <1545796305.14496.23.camel@mtksdaap41>
Subject: Re: [PATCH 04/18] drm/mediatek: move rdma sout from mtk_ddp_mout_en
 into mtk_ddp_sout_sel
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
Date:   Wed, 26 Dec 2018 11:51:45 +0800
In-Reply-To: <1545638931-24938-5-git-send-email-yongqiang.niu@mediatek.com>
References: <1545638931-24938-1-git-send-email-yongqiang.niu@mediatek.com>
         <1545638931-24938-5-git-send-email-yongqiang.niu@mediatek.com>
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
> This patch move rdma sout from mtk_ddp_mout_en into mtk_ddp_sout_sel

This patch looks good to me, but you should describe why do you do this.

Regards,
CK

> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 90 +++++++++++++++++-----------------
>  1 file changed, 45 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index 592f852..60cfde7 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -295,51 +295,6 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
>  	} else if (cur == DDP_COMPONENT_OD1 && next == DDP_COMPONENT_RDMA1) {
>  		*addr = DISP_REG_CONFIG_DISP_OD_MOUT_EN;
>  		value = OD1_MOUT_EN_RDMA1;
> -	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DPI0) {
> -		*addr = DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
> -		value = RDMA0_SOUT_DPI0;
> -	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DPI1) {
> -		*addr = DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
> -		value = RDMA0_SOUT_DPI1;
> -	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DSI1) {
> -		*addr = DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
> -		value = RDMA0_SOUT_DSI1;
> -	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DSI2) {
> -		*addr = DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
> -		value = RDMA0_SOUT_DSI2;
> -	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DSI3) {
> -		*addr = DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
> -		value = RDMA0_SOUT_DSI3;
> -	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI1) {
> -		*addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
> -		value = RDMA1_SOUT_DSI1;
> -	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI2) {
> -		*addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
> -		value = RDMA1_SOUT_DSI2;
> -	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI3) {
> -		*addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
> -		value = RDMA1_SOUT_DSI3;
> -	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI0) {
> -		*addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
> -		value = RDMA1_SOUT_DPI0;
> -	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI1) {
> -		*addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
> -		value = RDMA1_SOUT_DPI1;
> -	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DPI0) {
> -		*addr = DISP_REG_CONFIG_DISP_RDMA2_SOUT;
> -		value = RDMA2_SOUT_DPI0;
> -	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DPI1) {
> -		*addr = DISP_REG_CONFIG_DISP_RDMA2_SOUT;
> -		value = RDMA2_SOUT_DPI1;
> -	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DSI1) {
> -		*addr = DISP_REG_CONFIG_DISP_RDMA2_SOUT;
> -		value = RDMA2_SOUT_DSI1;
> -	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DSI2) {
> -		*addr = DISP_REG_CONFIG_DISP_RDMA2_SOUT;
> -		value = RDMA2_SOUT_DSI2;
> -	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DSI3) {
> -		*addr = DISP_REG_CONFIG_DISP_RDMA2_SOUT;
> -		value = RDMA2_SOUT_DSI3;
>  	} else {
>  		value = 0;
>  	}
> @@ -421,6 +376,51 @@ static unsigned int mtk_ddp_sout_sel(void __iomem *config_regs,
>  	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI0) {
>  		*addr = DISP_REG_CONFIG_DSI_SEL;
>  		value = DSI_SEL_IN_RDMA;
> +	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DPI0) {
> +		*addr = DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
> +		value = RDMA0_SOUT_DPI0;
> +	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DPI1) {
> +		*addr = DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
> +		value = RDMA0_SOUT_DPI1;
> +	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DSI1) {
> +		*addr = DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
> +		value = RDMA0_SOUT_DSI1;
> +	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DSI2) {
> +		*addr = DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
> +		value = RDMA0_SOUT_DSI2;
> +	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DSI3) {
> +		*addr = DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
> +		value = RDMA0_SOUT_DSI3;
> +	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI1) {
> +		*addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
> +		value = RDMA1_SOUT_DSI1;
> +	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI2) {
> +		*addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
> +		value = RDMA1_SOUT_DSI2;
> +	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI3) {
> +		*addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
> +		value = RDMA1_SOUT_DSI3;
> +	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI0) {
> +		*addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
> +		value = RDMA1_SOUT_DPI0;
> +	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI1) {
> +		*addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
> +		value = RDMA1_SOUT_DPI1;
> +	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DPI0) {
> +		*addr = DISP_REG_CONFIG_DISP_RDMA2_SOUT;
> +		value = RDMA2_SOUT_DPI0;
> +	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DPI1) {
> +		*addr = DISP_REG_CONFIG_DISP_RDMA2_SOUT;
> +		value = RDMA2_SOUT_DPI1;
> +	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DSI1) {
> +		*addr = DISP_REG_CONFIG_DISP_RDMA2_SOUT;
> +		value = RDMA2_SOUT_DSI1;
> +	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DSI2) {
> +		*addr = DISP_REG_CONFIG_DISP_RDMA2_SOUT;
> +		value = RDMA2_SOUT_DSI2;
> +	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DSI3) {
> +		*addr = DISP_REG_CONFIG_DISP_RDMA2_SOUT;
> +		value = RDMA2_SOUT_DSI3;
>  	} else {
>  		value = 0;
>  	}


