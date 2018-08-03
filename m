Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABB8C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 05:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0FD621717
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 05:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0FD621717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbeHCHGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 03:06:10 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50075 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726679AbeHCHGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 03:06:10 -0400
X-UUID: 7374a30539fa43f6876c082d1f178c56-20180803
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1794527711; Fri, 03 Aug 2018 13:11:34 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 3 Aug 2018 13:11:32 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 3 Aug 2018 13:11:32 +0800
Message-ID: <1533273092.31144.7.camel@mtksdaap41>
Subject: Re: [PATCH v2 11/15] drm/mediatek: add callback function to return
 OVL layer number
From:   CK Hu <ck.hu@mediatek.com>
To:     Stu Hsieh <stu.hsieh@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Date:   Fri, 3 Aug 2018 13:11:32 +0800
In-Reply-To: <1533265868-28110-12-git-send-email-stu.hsieh@mediatek.com>
References: <1533265868-28110-1-git-send-email-stu.hsieh@mediatek.com>
         <1533265868-28110-12-git-send-email-stu.hsieh@mediatek.com>
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

On Fri, 2018-08-03 at 11:11 +0800, Stu Hsieh wrote:
> This patch add callback function to return OVL layer number
> 
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> index 978782a77629..a42cfa057f42 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -58,6 +58,7 @@
>  struct mtk_disp_ovl_data {
>  	unsigned int addr;
>  	bool fmt_rgb565_is_0;
> +	unsigned int layer_nr;
>  };
>  
>  /**
> @@ -132,6 +133,13 @@ static void mtk_ovl_config(struct mtk_ddp_comp *comp, unsigned int w,
>  	writel(0x0, comp->regs + DISP_REG_OVL_RST);
>  }
>  
> +static unsigned int mtk_ovl_layer_nr(struct mtk_ddp_comp *comp)
> +{
> +	struct mtk_disp_ovl *ovl = comp_to_ovl(comp);
> +
> +	return ovl->data->layer_nr;

For now, MT8173, MT2712, MT2701 OVL all has 4 layer, so you could return
4 here. Once a SoC OVL has another layer number, then modified the code
to this statement.

Regards,
CK

> +}
> +
>  static void mtk_ovl_layer_on(struct mtk_ddp_comp *comp, unsigned int idx)
>  {
>  	unsigned int reg;
> @@ -221,6 +229,7 @@ static const struct mtk_ddp_comp_funcs mtk_disp_ovl_funcs = {
>  	.stop = mtk_ovl_stop,
>  	.enable_vblank = mtk_ovl_enable_vblank,
>  	.disable_vblank = mtk_ovl_disable_vblank,
> +	.layer_nr = mtk_ovl_layer_nr,
>  	.layer_on = mtk_ovl_layer_on,
>  	.layer_off = mtk_ovl_layer_off,
>  	.layer_config = mtk_ovl_layer_config,
> @@ -319,6 +328,7 @@ static const struct mtk_disp_ovl_data mt2701_ovl_driver_data = {
>  static const struct mtk_disp_ovl_data mt8173_ovl_driver_data = {
>  	.addr = DISP_REG_OVL_ADDR_MT8173,
>  	.fmt_rgb565_is_0 = true,
> +	.layer_nr = 4,
>  };
>  
>  static const struct of_device_id mtk_disp_ovl_driver_dt_match[] = {


