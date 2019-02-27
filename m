Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D96C10F16
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 02:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E105218D0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 02:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbfB0Cvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 21:51:45 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:40319 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729409AbfB0Cvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 21:51:45 -0500
X-UUID: fd4c391035854900935be50a1503b2eb-20190227
X-UUID: fd4c391035854900935be50a1503b2eb-20190227
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 516935137; Wed, 27 Feb 2019 10:51:38 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Feb 2019 10:51:37 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Feb 2019 10:51:37 +0800
Message-ID: <1551235897.1047.11.camel@mtksdaap41>
Subject: Re: [PATCH v4 08/12] clk: mediatek: Add MT8183 clock support
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, Fan Chen <fan.chen@mediatek.com>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 27 Feb 2019 10:51:37 +0800
In-Reply-To: <155120345816.260864.13433355004684800350@swboyd.mtv.corp.google.com>
References: <20190201083016.25856-1-weiyi.lu@mediatek.com>
         <20190201083016.25856-10-weiyi.lu@mediatek.com>
         <155120345816.260864.13433355004684800350@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-02-26 at 09:50 -0800, Stephen Boyd wrote:
> Quoting Weiyi Lu (2019-02-01 00:30:12)
> > diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
> > new file mode 100644
> > index 000000000000..e9de9fe774ca
> > --- /dev/null
> > +++ b/drivers/clk/mediatek/clk-mt8183.c
> > @@ -0,0 +1,1285 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//
> > +// Copyright (c) 2018 MediaTek Inc.
> > +// Author: Weiyi Lu <weiyi.lu@mediatek.com>
> > +
> > +#include <linux/delay.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +
> [....]
> > +
> > +static int clk_mt8183_top_probe(struct platform_device *pdev)
> > +{
> > +       struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       void __iomem *base;
> > +       struct clk_onecell_data *clk_data;
> > +       struct device_node *node = pdev->dev.of_node;
> > +
> > +       base = devm_ioremap_resource(&pdev->dev, res);
> > +       if (IS_ERR(base)) {
> > +               pr_err("%s(): ioremap failed\n", __func__);
> 
> This API already prints an error so please remove this duplicate error
> message
> 

ok, I'll remove those duplicate error message in next version.

> > +               return PTR_ERR(base);
> > +       }
> > +
> > +       clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
> > +
> > +       mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
> > +               clk_data);
> > +
> > +       mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
> > +
> > +       mtk_clk_register_muxes(top_muxes, ARRAY_SIZE(top_muxes),
> > +               node, &mt8183_clk_lock, clk_data);
> > +
> > +       mtk_clk_register_composites(top_aud_muxes, ARRAY_SIZE(top_aud_muxes),
> > +               base, &mt8183_clk_lock, clk_data);
> > +
> > +       mtk_clk_register_composites(top_aud_divs, ARRAY_SIZE(top_aud_divs),
> > +               base, &mt8183_clk_lock, clk_data);
> > +
> > +       mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
> > +               clk_data);
> > +
> > +       return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> > +}
> > +
> > +static int clk_mt8183_infra_probe(struct platform_device *pdev)
> > +{
> > +       struct clk_onecell_data *clk_data;
> > +       struct device_node *node = pdev->dev.of_node;
> > +
> > +       clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
> > +
> > +       mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
> > +               clk_data);
> > +
> > +       return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> > +}
> > +
> > +static int clk_mt8183_mcu_probe(struct platform_device *pdev)
> > +{
> > +       struct clk_onecell_data *clk_data;
> > +       struct device_node *node = pdev->dev.of_node;
> > +       void __iomem *base;
> > +       struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +
> > +       base = devm_ioremap_resource(&pdev->dev, res);
> > +       if (IS_ERR(base)) {
> > +               pr_err("%s(): ioremap failed\n", __func__);
> > +               return PTR_ERR(base);
> > +       }
> > +
> > +       clk_data = mtk_alloc_clk_data(CLK_MCU_NR_CLK);
> 
> Can this fail? It doesn't seem to be checked for failure so I guess we
> don't care?
> 

It might fail but we have data validity checks in all the
mtk_clk_register APIs.

> > +
> > +       mtk_clk_register_composites(mcu_muxes, ARRAY_SIZE(mcu_muxes), base,
> > +                       &mt8183_clk_lock, clk_data);
> > +
> > +       return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> > +}
> > +
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


