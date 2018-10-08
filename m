Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460F4C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147272075C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 147272075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbeJHVm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:42:56 -0400
Received: from mailoutvs15.siol.net ([185.57.226.206]:33872 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726198AbeJHVm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:42:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 0E34D520AD0;
        Mon,  8 Oct 2018 16:30:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id w5BBwiVej-tr; Mon,  8 Oct 2018 16:30:52 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 89899520A87;
        Mon,  8 Oct 2018 16:30:52 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPA id F084052082F;
        Mon,  8 Oct 2018 16:30:51 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     wens@csie.org, robh+dt@kernel.org, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH v2 25/29] drm: sun4i: add quirks for TCON TOP
Date:   Mon, 08 Oct 2018 16:30:51 +0200
Message-ID: <15704955.mQ5FZSihaB@jernej-laptop>
In-Reply-To: <20181008085112.mejpwvl3dpu7sopy@flea>
References: <20181007093905.11253-1-jernej.skrabec@siol.net> <20181007093905.11253-26-jernej.skrabec@siol.net> <20181008085112.mejpwvl3dpu7sopy@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 08. oktober 2018 ob 10:51:12 CEST je Maxime Ripard napisal(a):
> On Sun, Oct 07, 2018 at 11:39:01AM +0200, Jernej Skrabec wrote:
> > From: Icenowy Zheng <icenowy@aosc.io>
> > 
> > Some SoCs, such as H6, doesn't have a full-featured TCON TOP.
> > 
> > Add quirks support for TCON TOP.
> > 
> > Currently the presence of TCON_TV1 and DSI is controlled via the quirks
> > structure.
> > 
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > ---
> > 
> >  drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 43 ++++++++++++++++++++------
> >  1 file changed, 34 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c index 37158548b447..ed13233cad88
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > @@ -9,11 +9,17 @@
> > 
> >  #include <linux/component.h>
> >  #include <linux/device.h>
> >  #include <linux/module.h>
> > 
> > +#include <linux/of_device.h>
> > 
> >  #include <linux/of_graph.h>
> >  #include <linux/platform_device.h>
> >  
> >  #include "sun8i_tcon_top.h"
> > 
> > +struct sun8i_tcon_top_quirks {
> > +	bool has_tcon_tv1;
> > +	bool has_dsi;
> > +};
> > +
> > 
> >  static bool sun8i_tcon_top_node_is_tcon_top(struct device_node *node)
> >  {
> >  
> >  	return !!of_match_node(sun8i_tcon_top_of_table, node);
> > 
> > @@ -121,10 +127,13 @@ static int sun8i_tcon_top_bind(struct device *dev,
> > struct device *master,> 
> >  	struct platform_device *pdev = to_platform_device(dev);
> >  	struct clk_hw_onecell_data *clk_data;
> >  	struct sun8i_tcon_top *tcon_top;
> > 
> > +	const struct sun8i_tcon_top_quirks *quirks;
> > 
> >  	struct resource *res;
> >  	void __iomem *regs;
> >  	int ret, i;
> > 
> > +	quirks = of_device_get_match_data(&pdev->dev);
> > +
> > 
> >  	tcon_top = devm_kzalloc(dev, sizeof(*tcon_top), GFP_KERNEL);
> >  	if (!tcon_top)
> >  	
> >  		return -ENOMEM;
> > 
> > @@ -187,15 +196,23 @@ static int sun8i_tcon_top_bind(struct device *dev,
> > struct device *master,> 
> >  					     &tcon_top->reg_lock,
> >  					     TCON_TOP_TCON_TV0_GATE, 0);
> > 
> > -	clk_data->hws[CLK_TCON_TOP_TV1] =
> > -		sun8i_tcon_top_register_gate(dev, "tcon-tv1", regs,
> > -					     &tcon_top->reg_lock,
> > -					     TCON_TOP_TCON_TV1_GATE, 1);
> > +	if (quirks->has_tcon_tv1) {
> > +		clk_data->hws[CLK_TCON_TOP_TV1] =
> > +			sun8i_tcon_top_register_gate(dev, "tcon-tv1", regs,
> > +						     &tcon_top->reg_lock,
> > +						     TCON_TOP_TCON_TV1_GATE, 1);
> > +	} else {
> > +		clk_data->hws[CLK_TCON_TOP_TV1] = NULL;
> > +	}
> > 
> > -	clk_data->hws[CLK_TCON_TOP_DSI] =
> > -		sun8i_tcon_top_register_gate(dev, "dsi", regs,
> > -					     &tcon_top->reg_lock,
> > -					     TCON_TOP_TCON_DSI_GATE, 2);
> > +	if (quirks->has_dsi) {
> > +		clk_data->hws[CLK_TCON_TOP_DSI] =
> > +			sun8i_tcon_top_register_gate(dev, "dsi", regs,
> > +						     &tcon_top->reg_lock,
> > +						     TCON_TOP_TCON_DSI_GATE, 2);
> > +	} else {
> > +		clk_data->hws[CLK_TCON_TOP_DSI] = NULL;
> 
> clk_data has been kzalloc'd so its content is already NULL.
> 
> And you shouldn't have brackets for single line blocks.

Ah, yes. I'm not original author so I missed that during a review. I'll fix it 
in new revision.

Best regards,
Jernej

> 
> with that fixed,
> 
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> 
> Maxime




