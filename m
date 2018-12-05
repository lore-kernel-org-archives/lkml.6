Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AF1C07E85
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9037E20879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544030904;
	bh=CJqF/RQAkQe8DyvmUG4i2ze4TJnVlCi4awEbse+57dk=;
	h=To:From:In-Reply-To:Cc:References:Subject:Date:List-ID:From;
	b=128vjkx5UnUVOktadmLqaaijVn5Alb6cdLgyVxrP5WELaBn7FXeBWxSWPFMA8fuGX
	 9Gr3qvq01uq9mr6B6dX20cDgnLqQejKs3OegurRzg29CYadW4Y7hCbevXye1W6KmT0
	 EBeZQPugjIeJmh+r9PeTRasiW3i+PtpNA+3Yf5uY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9037E20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbeLER2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:28:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:51028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727660AbeLER2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:28:23 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDE7D205C9;
        Wed,  5 Dec 2018 17:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544030902;
        bh=CJqF/RQAkQe8DyvmUG4i2ze4TJnVlCi4awEbse+57dk=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=pJIrhNmLsH1Iwo1G/6I/+g1aUjqR902jDDXUT0oxCPOFPR7vfDFFC//P1ke75dI0y
         VpfXSqI/ficJiQwCXaY5C+YqMn1OTC7zAHK7n1Y4uWsQa9dfwkSTstcMOyM5liT1pq
         sq8Ojw2L6rs++9O3yGz6niJ3KI+CJj190GOH3t68=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <b1a7aa06389ccd46f60db3e63bdf1e9ce9781d49.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
Cc:     mturquette@baylibre.com, cw00.choi@samsung.com, krzk@kernel.org,
        b.zolnierkie@samsung.com, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, pavel@ucw.cz,
        andrew.smirnov@gmail.com, pombredanne@nexb.com,
        sjhuang@iluvatar.ai, akshu.agrawal@amd.com, djkurtz@chromium.org,
        rafael.j.wysocki@intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <b1a7aa06389ccd46f60db3e63bdf1e9ce9781d49.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
Message-ID: <154403090130.88331.18352581261422337586@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v6 10/10] clk: bd718x7: Initial support for ROHM bd71837/bd71847
 PMIC clock
Date:   Wed, 05 Dec 2018 09:28:21 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matti Vaittinen (2018-12-04 03:39:38)
> diff --git a/drivers/clk/clk-bd718x7.c b/drivers/clk/clk-bd718x7.c
> new file mode 100644
> index 000000000000..d486859526ed
> --- /dev/null
> +++ b/drivers/clk/clk-bd718x7.c
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 ROHM Semiconductors
> +// bd71837.c  -- ROHM BD71837MWV clock driver

This isn't even the name of the file. Please remove. Also, only the SPDX
tag is supposed to have // on it and the other things should be normal
/* */ comment style.

> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/mfd/rohm-bd718x7.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>
> +#include <linux/regmap.h>
[....]
> +
> +static int bd71837_clk_probe(struct platform_device *pdev)
> +{
> +       struct bd718xx_clk *c;
> +       int rval =3D -ENOMEM;
> +       const char *parent_clk;
> +       struct device *parent =3D pdev->dev.parent;
> +       struct bd718xx *mfd =3D dev_get_drvdata(parent);
> +       struct clk_init_data init =3D {
> +               .name =3D "bd718xx-32k-out",
> +               .ops =3D &bd71837_clk_ops,
> +       };
> +
> +       c =3D devm_kzalloc(&pdev->dev, sizeof(*c), GFP_KERNEL);
> +       if (!c)
> +               return -ENOMEM;
> +
> +       init.num_parents =3D 1;
> +       parent_clk =3D of_clk_get_parent_name(parent->of_node, 0);
> +
> +       init.parent_names =3D &parent_clk;
> +       if (!parent_clk) {
> +               dev_err(&pdev->dev, "No parent clk found\n");
> +               return -EINVAL;
> +       }
> +
> +       c->reg =3D BD718XX_REG_OUT32K;
> +       c->mask =3D BD718XX_OUT32K_EN;
> +       c->mfd =3D mfd;
> +       c->pdev =3D pdev;
> +       c->hw.init =3D &init;
> +
> +       of_property_read_string_index(parent->of_node,
> +                                     "clock-output-names", 0, &init.name=
);
> +
> +       rval =3D devm_clk_hw_register(&pdev->dev, &c->hw);
> +       if (!rval) {
> +               rval =3D devm_clk_hw_register_clkdev(&pdev->dev,
> +                                                  &c->hw, init.name, NUL=
L);

Do you plan to use the clkdev lookup? This driver looks fairly DT
dependent, so I would prefer to remove the clkdev part and only add it
later if anyone needs it.

> +               if (rval)
> +                       dev_warn(&pdev->dev, "Failed to register clkdev\n=
");
> +               if (parent->of_node) {
> +                       rval =3D devm_of_clk_add_hw_provider(&pdev->dev,
> +                                            of_clk_hw_simple_get, &c->hw=
);
> +                       if (rval)
> +                               dev_err(&pdev->dev,
> +                                       "adding clk provider failed\n");
> +               }
