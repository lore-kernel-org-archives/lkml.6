Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D277C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F7F21A07
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F7F21A07
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731139AbeHFODY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:03:24 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44077 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729693AbeHFODY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:03:24 -0400
X-UUID: 86e6196695074503a452ecb429117d48-20180806
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 596062384; Mon, 06 Aug 2018 19:54:34 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Mon, 6 Aug 2018 19:54:32 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 6 Aug 2018 19:54:32 +0800
Message-ID: <1533556472.11190.71.camel@mtksdccf07>
Subject: Re: [PATCH v2 11/15] drm/mediatek: add callback function to return
 OVL layer number
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Date:   Mon, 6 Aug 2018 19:54:32 +0800
In-Reply-To: <1533273092.31144.7.camel@mtksdaap41>
References: <1533265868-28110-1-git-send-email-stu.hsieh@mediatek.com>
         <1533265868-28110-12-git-send-email-stu.hsieh@mediatek.com>
         <1533273092.31144.7.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, CK:
On Fri, 2018-08-03 at 13:11 +0800, CK Hu wrote:
> Hi, Stu:
> 
> On Fri, 2018-08-03 at 11:11 +0800, Stu Hsieh wrote:
> > This patch add callback function to return OVL layer number
> > 
> > Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> > index 978782a77629..a42cfa057f42 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> > @@ -58,6 +58,7 @@
> >  struct mtk_disp_ovl_data {
> >  	unsigned int addr;
> >  	bool fmt_rgb565_is_0;
> > +	unsigned int layer_nr;
> >  };
> >  
> >  /**
> > @@ -132,6 +133,13 @@ static void mtk_ovl_config(struct mtk_ddp_comp *comp, unsigned int w,
> >  	writel(0x0, comp->regs + DISP_REG_OVL_RST);
> >  }
> >  
> > +static unsigned int mtk_ovl_layer_nr(struct mtk_ddp_comp *comp)
> > +{
> > +	struct mtk_disp_ovl *ovl = comp_to_ovl(comp);
> > +
> > +	return ovl->data->layer_nr;
> 
> For now, MT8173, MT2712, MT2701 OVL all has 4 layer, so you could return
> 4 here. Once a SoC OVL has another layer number, then modified the code
> to this statement.
> 
> Regards,
> CK
> 
OK

Regards,
Stu

> > +}
> > +
> >  static void mtk_ovl_layer_on(struct mtk_ddp_comp *comp, unsigned int idx)
> >  {
> >  	unsigned int reg;
> > @@ -221,6 +229,7 @@ static const struct mtk_ddp_comp_funcs mtk_disp_ovl_funcs = {
> >  	.stop = mtk_ovl_stop,
> >  	.enable_vblank = mtk_ovl_enable_vblank,
> >  	.disable_vblank = mtk_ovl_disable_vblank,
> > +	.layer_nr = mtk_ovl_layer_nr,
> >  	.layer_on = mtk_ovl_layer_on,
> >  	.layer_off = mtk_ovl_layer_off,
> >  	.layer_config = mtk_ovl_layer_config,
> > @@ -319,6 +328,7 @@ static const struct mtk_disp_ovl_data mt2701_ovl_driver_data = {
> >  static const struct mtk_disp_ovl_data mt8173_ovl_driver_data = {
> >  	.addr = DISP_REG_OVL_ADDR_MT8173,
> >  	.fmt_rgb565_is_0 = true,
> > +	.layer_nr = 4,
> >  };
> >  
> >  static const struct of_device_id mtk_disp_ovl_driver_dt_match[] = {
> 
> 


