Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2C3C10F16
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70AA521850
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551203461;
	bh=3nANAhLFyGRirluaGDEeKEuf9286NQe83pDNkn3J9cs=;
	h=To:References:Cc:Subject:From:In-Reply-To:Date:List-ID:From;
	b=uh8027Z/QzZzsON8z0nIhaCVABe57cioAynafdPDNa/bknhtZtczk6HVdUdk2QvA8
	 nB7TyBnwADUwS02mJaiNvhOQ9ikK7DxYEuX4LBq0lMLla4wY8v4Z5ot3glL1PYFQPF
	 BpCZUnw8bOh9fQMhwpXupsHYfaB4ftNAmWjNSWpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbfBZRvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:51:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:52630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbfBZRvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:51:00 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB8352173C;
        Tue, 26 Feb 2019 17:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551203459;
        bh=3nANAhLFyGRirluaGDEeKEuf9286NQe83pDNkn3J9cs=;
        h=To:References:Cc:Subject:From:In-Reply-To:Date:From;
        b=eU7Tu+U4qF5KIUncNyhZSeY/wqfVC2NtvtPhW8Vgp61WDzK1OOnj9df3Ved0morI9
         ADal/JolADUMjFEeDzhztiednhGKX0AR/CaewISTFaZKW4bjvHJcp2P2OmYr500781
         WowW3sDEvrvrRrYeMJAfU6hPJlFn9gmF/CsycrKk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>
References: <20190201083016.25856-1-weiyi.lu@mediatek.com> <20190201083016.25856-10-weiyi.lu@mediatek.com>
Message-ID: <155120345816.260864.13433355004684800350@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Cc:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com, stable@vger.kernel.org,
        Weiyi Lu <weiyi.lu@mediatek.com>
Subject: Re: [PATCH v4 08/12] clk: mediatek: Add MT8183 clock support
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190201083016.25856-10-weiyi.lu@mediatek.com>
Date:   Tue, 26 Feb 2019 09:50:58 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Weiyi Lu (2019-02-01 00:30:12)
> diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk=
-mt8183.c
> new file mode 100644
> index 000000000000..e9de9fe774ca
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8183.c
> @@ -0,0 +1,1285 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (c) 2018 MediaTek Inc.
> +// Author: Weiyi Lu <weiyi.lu@mediatek.com>
> +
> +#include <linux/delay.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
[....]
> +
> +static int clk_mt8183_top_probe(struct platform_device *pdev)
> +{
> +       struct resource *res =3D platform_get_resource(pdev, IORESOURCE_M=
EM, 0);
> +       void __iomem *base;
> +       struct clk_onecell_data *clk_data;
> +       struct device_node *node =3D pdev->dev.of_node;
> +
> +       base =3D devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(base)) {
> +               pr_err("%s(): ioremap failed\n", __func__);

This API already prints an error so please remove this duplicate error
message

> +               return PTR_ERR(base);
> +       }
> +
> +       clk_data =3D mtk_alloc_clk_data(CLK_TOP_NR_CLK);
> +
> +       mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_=
clks),
> +               clk_data);
> +
> +       mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data=
);
> +
> +       mtk_clk_register_muxes(top_muxes, ARRAY_SIZE(top_muxes),
> +               node, &mt8183_clk_lock, clk_data);
> +
> +       mtk_clk_register_composites(top_aud_muxes, ARRAY_SIZE(top_aud_mux=
es),
> +               base, &mt8183_clk_lock, clk_data);
> +
> +       mtk_clk_register_composites(top_aud_divs, ARRAY_SIZE(top_aud_divs=
),
> +               base, &mt8183_clk_lock, clk_data);
> +
> +       mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
> +               clk_data);
> +
> +       return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data=
);
> +}
> +
> +static int clk_mt8183_infra_probe(struct platform_device *pdev)
> +{
> +       struct clk_onecell_data *clk_data;
> +       struct device_node *node =3D pdev->dev.of_node;
> +
> +       clk_data =3D mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
> +
> +       mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
> +               clk_data);
> +
> +       return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data=
);
> +}
> +
> +static int clk_mt8183_mcu_probe(struct platform_device *pdev)
> +{
> +       struct clk_onecell_data *clk_data;
> +       struct device_node *node =3D pdev->dev.of_node;
> +       void __iomem *base;
> +       struct resource *res =3D platform_get_resource(pdev, IORESOURCE_M=
EM, 0);
> +
> +       base =3D devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(base)) {
> +               pr_err("%s(): ioremap failed\n", __func__);
> +               return PTR_ERR(base);
> +       }
> +
> +       clk_data =3D mtk_alloc_clk_data(CLK_MCU_NR_CLK);

Can this fail? It doesn't seem to be checked for failure so I guess we
don't care?

> +
> +       mtk_clk_register_composites(mcu_muxes, ARRAY_SIZE(mcu_muxes), bas=
e,
> +                       &mt8183_clk_lock, clk_data);
> +
> +       return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data=
);
> +}
> +
