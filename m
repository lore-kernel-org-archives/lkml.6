Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D699DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 04:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64282148E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 04:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbeL0E4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 23:56:34 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:49007 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728126AbeL0E4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 23:56:34 -0500
X-UUID: b979dac3cf9b4b5d997c3e45bff29271-20181227
X-UUID: b979dac3cf9b4b5d997c3e45bff29271-20181227
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1240302082; Thu, 27 Dec 2018 12:56:15 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 27 Dec 2018 12:56:13 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 27 Dec 2018 12:56:13 +0800
Message-ID: <1545886573.31506.13.camel@mtksdaap41>
Subject: Re: [PATCH 14/18] drm/mediatek: add connect function for ovl
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
Date:   Thu, 27 Dec 2018 12:56:13 +0800
In-Reply-To: <1545638931-24938-15-git-send-email-yongqiang.niu@mediatek.com>
References: <1545638931-24938-1-git-send-email-yongqiang.niu@mediatek.com>
         <1545638931-24938-15-git-send-email-yongqiang.niu@mediatek.com>
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
> This patch add connect function for ovl

Could you describe more about how ovl-2l works? I guess that ovl-2l is a
ovl hardware which has 3 layer, the bottom two layer is from DRAM and
the top layer is from another hardware (maybe the ovl). If my guess is
correct, why not just implement this function in mtk_ovl_layer_on()? In
mtk_ovl_layer_on(), you could do as

if (idx == ovl->data->layer_nr) {
	mtk_ddp_write_mask((1 << 2), comp,
			DISP_REG_OVL_DATAPATH_CON, OVL_BGCLR_SEL_IN);

	return;
}

So does mtk_ovl_layer_off().

Regards,
CK

> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> index a0ab760..3b2ce77 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -27,6 +27,8 @@
>  #define DISP_REG_OVL_EN				0x000c
>  #define DISP_REG_OVL_RST			0x0014
>  #define DISP_REG_OVL_ROI_SIZE			0x0020
> +#define DISP_REG_OVL_DATAPATH_CON		0x0024
> +#define OVL_BGCLR_SEL_IN                        BIT(2)
>  #define DISP_REG_OVL_ROI_BGCLR			0x0028
>  #define DISP_REG_OVL_SRC_CON			0x002c
>  #define DISP_REG_OVL_CON(n)			(0x0030 + 0x20 * (n))
> @@ -245,6 +247,19 @@ static void mtk_ovl_layer_config(struct mtk_ddp_comp *comp, unsigned int idx,
>  		mtk_ovl_layer_on(comp, idx);
>  }
>  
> +static void mtk_ovl_connect(struct mtk_ddp_comp *comp,
> +			    enum mtk_ddp_comp_id prev)
> +{
> +	int is_ovl = 0;
> +
> +	if (prev == DDP_COMPONENT_OVL0 || prev == DDP_COMPONENT_OVL1 ||
> +	    prev == DDP_COMPONENT_OVL0_2L || prev == DDP_COMPONENT_OVL1_2L)
> +		is_ovl = 1;
> +
> +	mtk_ddp_write_mask((is_ovl << 2), comp,
> +			   DISP_REG_OVL_DATAPATH_CON, OVL_BGCLR_SEL_IN);
> +}
> +
>  static const struct mtk_ddp_comp_funcs mtk_disp_ovl_funcs = {
>  	.config = mtk_ovl_config,
>  	.start = mtk_ovl_start,
> @@ -255,6 +270,7 @@ static void mtk_ovl_layer_config(struct mtk_ddp_comp *comp, unsigned int idx,
>  	.layer_on = mtk_ovl_layer_on,
>  	.layer_off = mtk_ovl_layer_off,
>  	.layer_config = mtk_ovl_layer_config,
> +	.connect = mtk_ovl_connect,
>  };
>  
>  static int mtk_disp_ovl_bind(struct device *dev, struct device *master,


