Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6FFECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9033214FE
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lssEM/4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9033214FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbeJSBPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 21:15:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbeJSBPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 21:15:37 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F096921480;
        Thu, 18 Oct 2018 17:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539882822;
        bh=nMQ3xiwIUeKMnkEKyXa4E7QE6Kq2TnQer1lcZLOA3WQ=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=lssEM/4Xne62bJePunIdWYVE6rmT+TFPecYtFBy4thahwdFt0OoVGqp4PzvEKbI9B
         AgswKcU0ihFUhtFRfcbN5waCbPWq4xvEK45EPUjuesDHTo22vFda5Iz2LHuP3NkyQe
         IUonUifkFj30V7psP5Di7NZVxKsX2LVxV6wnSYxE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1539839245-13793-4-git-send-email-jianxin.pan@amlogic.com>
Cc:     Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1539839245-13793-1-git-send-email-jianxin.pan@amlogic.com>
 <1539839245-13793-4-git-send-email-jianxin.pan@amlogic.com>
Message-ID: <153988282130.5275.17528969137837015544@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 3/3] clk: meson: add sub MMC clock controller driver
Date:   Thu, 18 Oct 2018 10:13:41 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jianxin Pan (2018-10-17 22:07:25)
> diff --git a/drivers/clk/meson/clk-regmap.c b/drivers/clk/meson/clk-regma=
p.c
> index 305ee30..f96314d 100644
> --- a/drivers/clk/meson/clk-regmap.c
> +++ b/drivers/clk/meson/clk-regmap.c
> @@ -113,8 +113,25 @@ static int clk_regmap_div_set_rate(struct clk_hw *hw=
, unsigned long rate,
>                                   clk_div_mask(div->width) << div->shift,=
 val);
>  };
>  =

> -/* Would prefer clk_regmap_div_ro_ops but clashes with qcom */
> +static void clk_regmap_div_init(struct clk_hw *hw)
> +{
> +       struct clk_regmap *clk =3D to_clk_regmap(hw);
> +       struct clk_regmap_div_data *div =3D clk_get_regmap_div_data(clk);
> +       unsigned int val;
> +       int ret;
> +
> +       ret =3D regmap_read(clk->map, div->offset, &val);
> +       if (ret)
> +               return;
>  =

> +       val &=3D (clk_div_mask(div->width) << div->shift);
> +       if (!val)
> +               regmap_update_bits(clk->map, div->offset,
> +                                  clk_div_mask(div->width) << div->shift,
> +                                  clk_div_mask(div->width));
> +}
> +
> +/* Would prefer clk_regmap_div_ro_ops but clashes with qcom */

We should add a patch to rename the symbol for qcom, i.e.
qcom_clk_regmap_div_ro_ops, and then any symbols in this directory
should be meson_clk_regmap_div_ro_ops.

Or we should just give up and squash the regmap implementations together
into a new clk_regmap set of ops.

>  const struct clk_ops clk_regmap_divider_ops =3D {
>         .recalc_rate =3D clk_regmap_div_recalc_rate,
>         .round_rate =3D clk_regmap_div_round_rate,
> diff --git a/drivers/clk/meson/mmc-clkc.c b/drivers/clk/meson/mmc-clkc.c
> new file mode 100644
> index 0000000..5555e3f
> --- /dev/null
> +++ b/drivers/clk/meson/mmc-clkc.c
> @@ -0,0 +1,296 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Amlogic Meson MMC Sub Clock Controller Driver
> + *
> + * Copyright (c) 2017 Baylibre SAS.
> + * Author: Jerome Brunet <jbrunet@baylibre.com>
> + *
> + * Copyright (c) 2018 Amlogic, inc.
> + * Author: Yixun Lan <yixun.lan@amlogic.com>
> + */
> +
> +#include <linux/clk.h>

clk-provider.h instead of clk.h?

> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/of_device.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/platform_device.h>
> +#include <dt-bindings/clock/amlogic,mmc-clkc.h>
> +
> +
[...]
> +
> +static struct clk_regmap *
> +mmc_clkc_register_clk_with_parent(struct device *dev, struct regmap *map,
> +                                 char *suffix, const char *parent,
> +                                 unsigned long flags,
> +                                 const struct clk_ops *ops, void *data)
> +{
> +       struct clk_init_data init;
> +       struct clk_regmap *clk;
> +
> +       init.ops =3D ops;
> +       init.flags =3D flags;
> +       init.parent_names =3D (const char* const []){ parent, };

Can't we just assign &parent here?

> +       init.num_parents =3D 1;
> +
> +       clk =3D mmc_clkc_register_clk(dev, map, &init, suffix, data);
> +       if (IS_ERR(clk))
> +               dev_err(dev, "Core %s clock registration failed\n", suffi=
x);
> +
> +       return clk;
> +}
> +
> +static int mmc_clkc_probe(struct platform_device *pdev)
> +{
> +       struct clk_hw_onecell_data *onecell_data;
> +       struct device *dev =3D &pdev->dev;
> +       struct mmc_clkc_data *data;
> +       struct regmap *map;
> +       struct clk_regmap *mux, *div, *core, *rx, *tx;
> +
> +       data =3D (struct mmc_clkc_data *)of_device_get_match_data(dev);

Nitpick: Drop the cast.

> +       if (!data)
> +               return -ENODEV;
> +
> +       map =3D syscon_node_to_regmap(dev->of_node);
