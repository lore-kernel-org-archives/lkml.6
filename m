Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B48ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E214A2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LY4PdutH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E214A2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbeGRImC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:42:02 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:51636 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbeGRImB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 04:42:01 -0400
Received: from avalon.localnet (unknown [IPv6:2a02:587:8041:9d00:717d:d1d9:bcc8:c702])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C32CBB7F;
        Wed, 18 Jul 2018 10:05:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1531901118;
        bh=dct1ju3xbBcx8BzHtIEJA0VGjWtu0xmfpnNabBz2cY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LY4PdutHFg1nhRCm0WpAyIfIWz/0l/k4+y62LAE6RIRcw1dxnkkBvK2/LWJTsW1DU
         eSCHV6iR/B+Pt0pcXT0HFnSdM8ulCd0tv4CS87Mhvt7kYIvx9oBQhFeXxSv7WMo0vG
         6nt0uiN2To7QzK+PtYd9+azqcqHZji0LbIfHc/bc=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     matthias.bgg@kernel.org, ulrich.hecht+renesas@gmail.com,
        ck.hu@mediatek.com, p.zabel@pengutronix.de, airlied@linux.ie,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@codeaurora.org, lee.jones@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, mchehab@kernel.org,
        rdunlap@infradead.org, pi-cheng.chen@linaro.org,
        linux-clk@vger.kernel.org, linux@armlinux.org.uk,
        matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: Re: [resend PATCH v4 4/5] drm/mediatek: Add support for mmsys through a pdev
Date:   Wed, 18 Jul 2018 11:05:49 +0300
Message-ID: <51066716.k5MkZnrqCl@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1531882655.8953.83.camel@mtkswgap22>
References: <20180717220328.792-1-matthias.bgg@kernel.org> <20180717220328.792-5-matthias.bgg@kernel.org> <1531882655.8953.83.camel@mtkswgap22>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

On Wednesday, 18 July 2018 05:57:35 EEST Sean Wang wrote:
> On Wed, 2018-07-18 at 00:03 +0200, matthias.bgg@kernel.org wrote:
> > From: Matthias Brugger <mbrugger@suse.com>
> > 
> > The MMSYS subsystem includes clocks and drm components.
> > This patch adds an initailization path through a platform device
> > for the clock part, so that both drivers get probed from the same
> > device tree compatible.
> 
> Sorry for that I should have a response earlier for the series.
> 
> Some points I felt they're not exactly right and should be fixed up
> before we're moving on
> 
> Currently, drm driver have a wrong reference to the dt-binding,
> "mediatek,mt2701-mmsys" or "mediatek,mt8173-mmsys", they should be all
> for the subsystem exporting clock and reset line such common resource to
> its sub-devices. Every subsystem has a similar shape. I hope mmsys
> shouldn't be an exception.
> 
> DRM device needs to have its own dt-binding show how connections between
> DRM components being made and its node should be put under mmsys node.
> 
> In this way, it becomes easy to see how the topology of the subsystem is
> and grows, like a tree "device tree", instead of hiding the details in
> the implementation.
> 
> The similar example we already did for audsys on mt2701 and mt7623 as
> below
> 
> 	audsys: clock-controller@11220000 {
> 		
compatible = "mediatek,mt7623-audsys",
> 		
	     "mediatek,mt2701-audsys",
> 		
	     "syscon";
> 		
	...
> 
> 		
afe: audio-controller {
> 		
	compatible = "mediatek,mt7623-audio",
> 		
		
     "mediatek,mt2701-audio";
> 
> 		
	...
> 		
};
> 	};

This looks very strange to me. I'm not familiar with the hardware 
architecture, but a clock controller that includes an audio controller seems 
like a very weird design. It's usually the other way around, you have an audio 
controller, and it also contains hardware that produces clocks, and possibly 
handles miscellaneous audio-related routing tasks. I would thus expect the 
reverse in the device tree:

	afe: audio-controller@11220000 {
		
compatible = "mediatek,mt7623-audio",
		
	     "mediatek,mt2701-audio";
		
..

		
audsys: clock-controller {
		
	compatible = "mediatek,mt7623-audsys",
		
		
     "mediatek,mt2701-audsys",
		
		
     "syscon";
		
	...
		
};
	};

And if audsys only exposes clocks, you don't even need a subnode to represent 
it, the audio controller itself can be a clock provider.

	afe: audio-controller@11220000 {
		
compatible = "mediatek,mt7623-audio",
		
	     "mediatek,mt2701-audio";
		
#clock-cells = <1>;
		
..
	};

> > Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> > ---
> > 
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 18 ++++++++++++++++++
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.h |  2 ++
> >  2 files changed, 20 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > b/drivers/gpu/drm/mediatek/mtk_drm_drv.c index dd249cf5121e..c946aea722e5
> > 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > @@ -173,6 +173,7 @@ static const struct mtk_mmsys_driver_data
> > mt2701_mmsys_driver_data = {> 
> >  	.ext_path = mt2701_mtk_ddp_ext,
> >  	.ext_len = 
ARRAY_SIZE(mt2701_mtk_ddp_ext),
> >  	.shadow_register = true,
> > 
> > +	.clk_drv_name = "clk-mt2701-mm",
> > 
> >  };
> >  
> >  static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
> > 
> > @@ -180,6 +181,7 @@ static const struct mtk_mmsys_driver_data
> > mt8173_mmsys_driver_data = {> 
> >  	.main_len = 
ARRAY_SIZE(mt8173_mtk_ddp_main),
> >  	.ext_path = mt8173_mtk_ddp_ext,
> >  	.ext_len = 
ARRAY_SIZE(mt8173_mtk_ddp_ext),
> > 
> > +	.clk_drv_name = "clk-mt8173-mm",
> > 
> >  };
> >  
> >  static int mtk_drm_kms_init(struct drm_device *drm)
> > 
> > @@ -411,6 +413,19 @@ static int mtk_drm_probe(struct platform_device
> > *pdev)
> > 
> >  	if (IS_ERR(private->config_regs))
> >  	
> >  		
return PTR_ERR(private->config_regs);
> > 
> > +	if (private->data->clk_drv_name) {
> > +		
private->clk_dev = platform_device_register_data(dev,
> > +		
		
		
private->data->clk_drv_name, -1,
> > +		
		
		
NULL, 0);
> > +
> > +		
if (IS_ERR(private->clk_dev)) {
> > +		
	pr_err("failed to register %s platform 
device\n",
> > +		
		
		
private->data->clk_drv_name);
> > +
> > +		
	return PTR_ERR(private->clk_dev);
> > +		
}
> > +	}
> > +
> > 
> >  	/* Iterate over sibling DISP 
function blocks */
> >  	for_each_child_of_node(dev->of_node-
>parent, node) {
> >  	
> >  		
const struct of_device_id *of_id;
> > 
> > @@ -515,6 +530,9 @@ static int mtk_drm_remove(struct platform_device
> > *pdev)
> > 
> >  	for (i = 0; i < 
DDP_COMPONENT_ID_MAX; i++)
> >  	
> >  		
of_node_put(private->comp_node[i]);
> > 
> > +	if (private->clk_dev)
> > +		
platform_device_unregister(private->clk_dev);
> > +
> > 
> >  	return 0;
> >  
> >  }
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> > b/drivers/gpu/drm/mediatek/mtk_drm_drv.h index 86cec19193c4..200eee5de419
> > 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> > @@ -34,11 +34,13 @@ struct mtk_mmsys_driver_data {
> > 
> >  	const enum mtk_ddp_comp_id 
*ext_path;
> >  	unsigned int ext_len;
> >  	bool shadow_register;
> > 
> > +	const char *clk_drv_name;
> > 
> >  };
> >  
> >  struct mtk_drm_private {
> >  
> >  	struct drm_device *drm;
> >  	struct device *dma_dev;
> > 
> > +	struct platform_device *clk_dev;
> > 
> >  	unsigned int num_pipes;


-- 
Regards,

Laurent Pinchart



