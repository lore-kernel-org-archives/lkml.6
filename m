Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C1FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 400462075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 400462075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbeIEOTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:19:37 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:19359 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727951AbeIEOTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:19:37 -0400
X-UUID: 151aa46253274d2a8f0fdd037cb6e61c-20180905
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 761797851; Wed, 05 Sep 2018 17:50:05 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 5 Sep 2018 17:50:03 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 5 Sep 2018 17:50:03 +0800
Message-ID: <1536141003.11913.6.camel@mtksdaap41>
Subject: Re: [PATCH v2 02/13] drm/mediatek: move hardware register to node
 data
From:   CK Hu <ck.hu@mediatek.com>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
CC:     David Airlie <airlied@linux.ie>,
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
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Sascha Hauer" <kernel@pengutronix.de>,
        chunhui dai <chunhui.dai@mediatek.com>
Date:   Wed, 5 Sep 2018 17:50:03 +0800
In-Reply-To: <20180905083146.14727-3-bibby.hsieh@mediatek.com>
References: <20180905083146.14727-1-bibby.hsieh@mediatek.com>
         <20180905083146.14727-3-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bibby:

One inline comment.

On Wed, 2018-09-05 at 16:31 +0800, Bibby Hsieh wrote:
> From: chunhui dai <chunhui.dai@mediatek.com>
> 
> The address of register DPI_H_FRE_CON is different in different IC.
> Using of_node data to find this address.
> 
> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c      | 29 +++++++++++++++++++++++------
>  drivers/gpu/drm/mediatek/mtk_dpi_regs.h |  1 -
>  2 files changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index d9373e67d328..3db959fed493 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -72,6 +72,7 @@ struct mtk_dpi {
>  	struct clk *tvd_clk;
>  	int irq;
>  	struct drm_display_mode mode;
> +	const struct mtk_dpi_conf *conf;
>  	enum mtk_dpi_out_color_format color_format;
>  	enum mtk_dpi_out_yc_map yc_map;
>  	enum mtk_dpi_out_bit_num bit_num;
> @@ -117,6 +118,10 @@ struct mtk_dpi_yc_limit {
>  	u16 c_bottom;
>  };
>  
> +struct mtk_dpi_conf {
> +	const u32 reg_h_fre_con;
> +};
> +
>  static void mtk_dpi_mask(struct mtk_dpi *dpi, u32 offset, u32 val, u32 mask)
>  {
>  	u32 tmp = readl(dpi->regs + offset) & ~mask;
> @@ -342,7 +347,7 @@ static void mtk_dpi_config_swap_input(struct mtk_dpi *dpi, bool enable)
>  
>  static void mtk_dpi_config_2n_h_fre(struct mtk_dpi *dpi)
>  {
> -	mtk_dpi_mask(dpi, DPI_H_FRE_CON, H_FRE_2N, H_FRE_2N);
> +	mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, H_FRE_2N, H_FRE_2N);
>  }
>  
>  static void mtk_dpi_config_color_format(struct mtk_dpi *dpi,
> @@ -668,6 +673,18 @@ static const struct component_ops mtk_dpi_component_ops = {
>  	.unbind = mtk_dpi_unbind,
>  };
>  
> +static const struct mtk_dpi_conf mt8173_conf = {
> +	.reg_h_fre_con = 0xe0,
> +};
> +
> +static const struct of_device_id mtk_dpi_of_ids[] = {
> +	{ .compatible = "mediatek,mt8173-dpi",
> +	  .data = &mt8173_conf,
> +	},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, mtk_dpi_of_ids);
> +
>  static int mtk_dpi_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -675,13 +692,18 @@ static int mtk_dpi_probe(struct platform_device *pdev)
>  	struct resource *mem;
>  	struct device_node *bridge_node;
>  	int comp_id;
> +	const struct of_device_id *match;
>  	int ret;
>  
> +	match = of_match_node(mtk_dpi_of_ids, dev->of_node);
> +	if (!match)
> +		return -ENODEV;

One more blank line.

Regards,
CK

>  	dpi = devm_kzalloc(dev, sizeof(*dpi), GFP_KERNEL);
>  	if (!dpi)
>  		return -ENOMEM;
>  
>  	dpi->dev = dev;
> +	dpi->conf = (struct mtk_dpi_conf *)match->data;
>  
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	dpi->regs = devm_ioremap_resource(dev, mem);
> @@ -760,11 +782,6 @@ static int mtk_dpi_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static const struct of_device_id mtk_dpi_of_ids[] = {
> -	{ .compatible = "mediatek,mt8173-dpi", },
> -	{}
> -};
> -
>  struct platform_driver mtk_dpi_driver = {
>  	.probe = mtk_dpi_probe,
>  	.remove = mtk_dpi_remove,
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi_regs.h b/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
> index 4b6ad4751a31..040444d7718d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
> @@ -223,6 +223,5 @@
>  #define ESAV_CODE2			(0xFFF << 0)
>  #define ESAV_CODE3_MSB			BIT(16)
>  
> -#define DPI_H_FRE_CON		0xE0
>  #define H_FRE_2N			BIT(25)
>  #endif /* __MTK_DPI_REGS_H */


