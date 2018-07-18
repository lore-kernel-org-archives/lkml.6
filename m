Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0038ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33092075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A33092075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731624AbeGRDdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 23:33:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:8431 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731252AbeGRDdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 23:33:19 -0400
X-UUID: 5bcd734a26a24ee38475ba3c905cee8e-20180718
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1257413841; Wed, 18 Jul 2018 10:57:38 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 18 Jul 2018 10:57:35 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 18 Jul 2018 10:57:35 +0800
Message-ID: <1531882655.8953.83.camel@mtkswgap22>
Subject: Re: [resend PATCH v4 4/5] drm/mediatek: Add support for mmsys
 through a pdev
From:   Sean Wang <sean.wang@mediatek.com>
To:     <matthias.bgg@kernel.org>
CC:     <ulrich.hecht+renesas@gmail.com>,
        <laurent.pinchart@ideasonboard.com>, <ck.hu@mediatek.com>,
        <p.zabel@pengutronix.de>, <airlied@linux.ie>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <mturquette@baylibre.com>,
        <sboyd@codeaurora.org>, <lee.jones@linaro.org>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <mchehab@kernel.org>, <rdunlap@infradead.org>,
        <pi-cheng.chen@linaro.org>, <linux-clk@vger.kernel.org>,
        <linux@armlinux.org.uk>, <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <mbrugger@suse.com>
Date:   Wed, 18 Jul 2018 10:57:35 +0800
In-Reply-To: <20180717220328.792-5-matthias.bgg@kernel.org>
References: <20180717220328.792-1-matthias.bgg@kernel.org>
         <20180717220328.792-5-matthias.bgg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-18 at 00:03 +0200, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> The MMSYS subsystem includes clocks and drm components.
> This patch adds an initailization path through a platform device
> for the clock part, so that both drivers get probed from the same
> device tree compatible.
> 

Sorry for that I should have a response earlier for the series.

Some points I felt they're not exactly right and should be fixed up
before we're moving on

Currently, drm driver have a wrong reference to the dt-binding,
"mediatek,mt2701-mmsys" or "mediatek,mt8173-mmsys", they should be all
for the subsystem exporting clock and reset line such common resource to
its sub-devices. Every subsystem has a similar shape. I hope mmsys
shouldn't be an exception.

DRM device needs to have its own dt-binding show how connections between
DRM components being made and its node should be put under mmsys node.

In this way, it becomes easy to see how the topology of the subsystem is
and grows, like a tree "device tree", instead of hiding the details in
the implementation.

The similar example we already did for audsys on mt2701 and mt7623 as
below

	audsys: clock-controller@11220000 {
		compatible = "mediatek,mt7623-audsys",
			     "mediatek,mt2701-audsys",
			     "syscon";
			...

		afe: audio-controller {
			compatible = "mediatek,mt7623-audio",
				     "mediatek,mt2701-audio";
			
			...
		};
	};

	
	Sean


> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 18 ++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h |  2 ++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index dd249cf5121e..c946aea722e5 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -173,6 +173,7 @@ static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
>  	.ext_path = mt2701_mtk_ddp_ext,
>  	.ext_len = ARRAY_SIZE(mt2701_mtk_ddp_ext),
>  	.shadow_register = true,
> +	.clk_drv_name = "clk-mt2701-mm",
>  };
>  
>  static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
> @@ -180,6 +181,7 @@ static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
>  	.main_len = ARRAY_SIZE(mt8173_mtk_ddp_main),
>  	.ext_path = mt8173_mtk_ddp_ext,
>  	.ext_len = ARRAY_SIZE(mt8173_mtk_ddp_ext),
> +	.clk_drv_name = "clk-mt8173-mm",
>  };
>  
>  static int mtk_drm_kms_init(struct drm_device *drm)
> @@ -411,6 +413,19 @@ static int mtk_drm_probe(struct platform_device *pdev)
>  	if (IS_ERR(private->config_regs))
>  		return PTR_ERR(private->config_regs);
>  
> +	if (private->data->clk_drv_name) {
> +		private->clk_dev = platform_device_register_data(dev,
> +						private->data->clk_drv_name, -1,
> +						NULL, 0);
> +
> +		if (IS_ERR(private->clk_dev)) {
> +			pr_err("failed to register %s platform device\n",
> +						private->data->clk_drv_name);
> +
> +			return PTR_ERR(private->clk_dev);
> +		}
> +	}
> +
>  	/* Iterate over sibling DISP function blocks */
>  	for_each_child_of_node(dev->of_node->parent, node) {
>  		const struct of_device_id *of_id;
> @@ -515,6 +530,9 @@ static int mtk_drm_remove(struct platform_device *pdev)
>  	for (i = 0; i < DDP_COMPONENT_ID_MAX; i++)
>  		of_node_put(private->comp_node[i]);
>  
> +	if (private->clk_dev)
> +		platform_device_unregister(private->clk_dev);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> index 86cec19193c4..200eee5de419 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> @@ -34,11 +34,13 @@ struct mtk_mmsys_driver_data {
>  	const enum mtk_ddp_comp_id *ext_path;
>  	unsigned int ext_len;
>  	bool shadow_register;
> +	const char *clk_drv_name;
>  };
>  
>  struct mtk_drm_private {
>  	struct drm_device *drm;
>  	struct device *dma_dev;
> +	struct platform_device *clk_dev;
>  
>  	unsigned int num_pipes;
>  


