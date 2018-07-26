Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1634DC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4112083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTomFv3t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC4112083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731513AbeGZQhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 12:37:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729801AbeGZQhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 12:37:23 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADAD52064D;
        Thu, 26 Jul 2018 15:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532618403;
        bh=HY1O496iqHIl19/nXjgQbEAnRufG84YZKXnnEp9nMNI=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=OTomFv3t/81eZKza9YvimAwmwNUP+VjSyWdImmDsQjXRHBK664ED0IPZbBW4u0kkd
         mZ5oj0289I7nDomCHYYcOv361kJEPe74irspgbmk0pUIU8aQ9mKN7qBJuZA0KRawle
         M3YMl+gUVXlCH/3lNLPGwLyLijL+Eb75uIGKp2QQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Yixun Lan <yixun.lan@amlogic.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180712211244.11428-3-yixun.lan@amlogic.com>
Cc:     Yixun Lan <yixun.lan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180712211244.11428-1-yixun.lan@amlogic.com>
 <20180712211244.11428-3-yixun.lan@amlogic.com>
Message-ID: <153261840298.48062.2497103873681297587@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 2/2] clk: meson: add sub MMC clock controller driver
Date:   Thu, 26 Jul 2018 08:20:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yixun Lan (2018-07-12 14:12:44)
> diff --git a/drivers/clk/meson/mmc-clkc.c b/drivers/clk/meson/mmc-clkc.c
> new file mode 100644
> index 000000000000..36c4c7cd69a6
> --- /dev/null
> +++ b/drivers/clk/meson/mmc-clkc.c
> @@ -0,0 +1,367 @@
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

Is this include used?

> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/of_device.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/platform_device.h>
> +#include <dt-bindings/clock/amlogic,meson-mmc-clkc.h>
> +
> +#include "clkc.h"
> +
> +
> +static struct clk_regmap *
> +mmc_clkc_register_other_clk(struct device *dev, struct regmap *map,
> +                           char *suffix, char *parent_suffix,
> +                           unsigned long flags,
> +                           const struct clk_ops *ops, void *data)
> +{
> +       struct clk_init_data init;
> +       struct clk_regmap *clk;
> +       char *parent;
> +
> +       parent =3D kasprintf(GFP_KERNEL, "%s#%s", dev_name(dev), parent_s=
uffix);
> +       if (!parent)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.ops =3D ops;
> +       init.flags =3D flags;
> +       init.parent_names =3D (const char* const []){ parent, };

Can't this just be &parent?

> +       init.num_parents =3D 1;
> +
> +       clk =3D mmc_clkc_register_clk(dev, map, &init, suffix, data);
> +       if (IS_ERR(clk))
> +               dev_err(dev, "Core %s clock registration failed\n", suffi=
x);
> +
> +       kfree(parent);
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

This cast is unnecessary. Pleas remove.
