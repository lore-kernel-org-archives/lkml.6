Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E3BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8B920870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfAVHD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 02:03:27 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:28904 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725862AbfAVHD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 02:03:26 -0500
X-UUID: ad779792603f4bf59f9a30947b10b8f4-20190122
X-UUID: ad779792603f4bf59f9a30947b10b8f4-20190122
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1123729437; Tue, 22 Jan 2019 15:03:21 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs01n1.mediatek.inc
 (172.21.101.68) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 22 Jan
 2019 15:03:19 +0800
Received: from [10.16.6.141] (10.16.6.141) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 22 Jan 2019 15:03:18 +0800
Message-ID: <1548140598.5648.1.camel@mszsdaap41>
Subject: Re: [PATCH 9/9] drm/mediatek: add dpi dual edge support
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     chunhui dai <chunhui.dai@mediatek.com>,
        --to=Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <dri-devel@lists.freedesktop.org>, <srv_heupstream@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <jamesjj.liao@mediatek.com>
Date:   Tue, 22 Jan 2019 15:03:18 +0800
In-Reply-To: <ae8eeb33-43cd-f4b8-a564-95eeecea7d31@gmail.com>
References: <1546585439-30455-1-git-send-email-chunhui.dai@mediatek.com>
         <1546585439-30455-10-git-send-email-chunhui.dai@mediatek.com>
         <ae8eeb33-43cd-f4b8-a564-95eeecea7d31@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-09 at 17:58 +0100, Matthias Brugger wrote:
> 
> On 04/01/2019 08:03, chunhui dai wrote:
> > DPI sample on rising and falling edge. It can reduce half data io.
> > 
> > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> > Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dpi.c | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > index 4a2f4a6..acb4f47 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > @@ -117,6 +117,7 @@ struct mtk_dpi_conf {
> >  	unsigned int (*cal_factor)(int clock);
> >  	u32 reg_h_fre_con;
> >  	bool edge_sel_en;
> > +	bool dual_edge;
> >  };
> >  
> >  static void mtk_dpi_mask(struct mtk_dpi *dpi, u32 offset, u32 val, u32 mask)
> > @@ -353,6 +354,15 @@ static void mtk_dpi_config_disable_edge(struct mtk_dpi *dpi)
> >  		mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, 0, EDGE_SEL_EN);
> >  }
> >  
> > +static void mtk_dpi_config_dual_edge(struct mtk_dpi *dpi)
> 
> I think it is clearer if you rename the function to something like:
> mtk_dpi_enable_dual_edge and call it in mtk_dpi_set_display_mode if
> dpi->conf->dual_edge is true.
> 
> Regards,
> Matthias
> 

I'll fix it in next patch.

Best Regards
Jitao

> > +{
> > +	if (dpi->conf->dual_edge) {
> > +		mtk_dpi_mask(dpi, DPI_DDR_SETTING, DDR_EN |
> > +				DDR_4PHASE, DDR_EN | DDR_4PHASE);
> > +		mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING, EDGE_SEL, EDGE_SEL);
> > +	}
> > +}
> > +
> >  static void mtk_dpi_config_color_format(struct mtk_dpi *dpi,
> >  					enum mtk_dpi_out_color_format format)
> >  {
> > @@ -509,6 +519,7 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
> >  	mtk_dpi_config_color_format(dpi, dpi->color_format);
> >  	mtk_dpi_config_2n_h_fre(dpi);
> >  	mtk_dpi_config_disable_edge(dpi);
> > +	mtk_dpi_config_dual_edge(dpi);
> >  	mtk_dpi_sw_reset(dpi, false);
> >  
> >  	return 0;
> > @@ -669,6 +680,16 @@ static unsigned int mt2701_calculate_factor(int clock)
> >  		return 1;
> >  }
> >  
> > +static unsigned int mt8183_calculate_factor(int clock)
> > +{
> > +	if (clock <= 27000)
> > +		return 8;
> > +	else if (clock <= 167000)
> > +		return 4;
> > +	else
> > +		return 2;
> > +}
> > +
> >  static const struct mtk_dpi_conf mt8173_conf = {
> >  	.cal_factor = mt8173_calculate_factor,
> >  	.reg_h_fre_con = 0xe0,
> > @@ -680,6 +701,12 @@ static unsigned int mt2701_calculate_factor(int clock)
> >  	.edge_sel_en = true,
> >  };
> >  
> > +static const struct mtk_dpi_conf mt8183_conf = {
> > +	.cal_factor = mt8183_calculate_factor,
> > +	.reg_h_fre_con = 0xe0,
> > +	.dual_edge = true,
> > +};
> > +
> >  static int mtk_dpi_probe(struct platform_device *pdev)
> >  {
> >  	struct device *dev = &pdev->dev;
> > @@ -775,6 +802,9 @@ static int mtk_dpi_remove(struct platform_device *pdev)
> >  	{ .compatible = "mediatek,mt8173-dpi",
> >  	  .data = &mt8173_conf,
> >  	},
> > +	{ .compatible = "mediatek,mt8183-dpi",
> > +	  .data = &mt8183_conf,
> > +	},
> >  	{ },
> >  };
> >  
> > 


