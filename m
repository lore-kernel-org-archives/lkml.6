Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37195C46462
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 06:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D808021470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 06:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uriUVABQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D808021470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeJKOFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 10:05:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbeJKOFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 10:05:50 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE1AF2077C;
        Thu, 11 Oct 2018 06:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539239999;
        bh=8kprc6bBHXf0VMIa1XIYlTJfnPaVM1UrLCcAA5l1Tzk=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=uriUVABQbYg/a+5e2M/FdH9ABQnRb8pZs5AnwNFnvs7w+1AOMW3VK6syqnVFkYFro
         iHn8kImprEFFAfCEcqJFL7SMIkaCuVVs/BevroHoSkArzCH0CfG3sUMOA+S7AkI6B6
         yP4eszYduOr+toO7e66sv08VpVjDvWkde51cCA2U=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <87bm821rkf.wl-kuninori.morimoto.gx@renesas.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <87efcy1rm4.wl-kuninori.morimoto.gx@renesas.com>
 <87bm821rkf.wl-kuninori.morimoto.gx@renesas.com>
Message-ID: <153923999820.207691.114282732524143268@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] clk: add 74aup1g157gw 2-input multiplexer as clock driver
Date:   Wed, 10 Oct 2018 23:39:58 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuninori Morimoto (2018-10-09 19:16:48)
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 292056b..9cfeb0e 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -299,5 +299,6 @@ source "drivers/clk/sunxi-ng/Kconfig"
>  source "drivers/clk/tegra/Kconfig"
>  source "drivers/clk/ti/Kconfig"
>  source "drivers/clk/uniphier/Kconfig"
> +source "drivers/clk/nxp/Kconfig"

Please sort this alphabetically.

>  =

>  endmenu
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index ed344eb..fcfd42a 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -84,7 +84,7 @@ obj-$(CONFIG_ARCH_MMP)                        +=3D mmp/
>  endif
>  obj-y                                  +=3D mvebu/
>  obj-$(CONFIG_ARCH_MXS)                 +=3D mxs/
> -obj-$(CONFIG_COMMON_CLK_NXP)           +=3D nxp/
> +obj-y                                  +=3D nxp/

There's the CONFIG_COMMON_CLK_NXP config symbol that could go into the
drivers/clk/nxp/Kconfig file then and also wrap the Makefile contents in
the nxp subdirectory too? We don't want to lose that config option and
start enabling this driver all the time.

>  obj-$(CONFIG_MACH_PISTACHIO)           +=3D pistachio/
>  obj-$(CONFIG_COMMON_CLK_PXA)           +=3D pxa/
>  obj-$(CONFIG_COMMON_CLK_QCOM)          +=3D qcom/
> diff --git a/drivers/clk/nxp/clk-74aup1g157gw.c b/drivers/clk/nxp/clk-74a=
up1g157gw.c
> new file mode 100644
> index 0000000..78199bb
> --- /dev/null
> +++ b/drivers/clk/nxp/clk-74aup1g157gw.c
> @@ -0,0 +1,213 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2018 Renesas Solutions Corp.
> +// Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> +//
> +#include <linux/module.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/slab.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#define CLK_I_NUM 2
> +struct clk_priv {
> +       struct clk_hw hw;
> +       struct device *dev;
> +       struct clk *i[CLK_I_NUM];
> +       struct gpio_desc *sel;
> +       long (*round_rate)(struct clk_hw *hw, unsigned long rate,
> +                          unsigned long *parent_rate);
> +};
> +#define hw_to_priv(_hw) container_of(_hw, struct clk_priv, hw)
> +#define priv_to_dev(priv) priv->dev

Nitpick: This macro is just obfuscating, there isn't any container_of()
usage going on so please remove it.

> +#define for_each_iclk(i)                       \
> +       for ((i) =3D 0; (i) < CLK_I_NUM; (i)++)

Nitpick: This macros isn't making things any shorter, so please remove
it.

> +
> +static int clk74_set_rate(struct clk_hw *hw, unsigned long rate,
> +                         unsigned long parent_rate)
> +{
> +       struct clk_priv *priv =3D hw_to_priv(hw);
> +       struct device *dev =3D priv_to_dev(priv);
> +       int i;
> +
> +       for_each_iclk(i) {
> +               if (rate =3D=3D clk_get_rate(priv->i[i])) {
> +                       dev_dbg(dev, "set rate %lu as i%d\n", rate, i);
> +                       gpiod_set_value_cansleep(priv->sel, i);
> +                       return 0;
> +               }
> +       }
> +
> +       dev_err(dev, "unsupported rate %lu\n", rate);
> +       return -EIO;
> +}
> +
> +static long clk74_round_rate_close(struct clk_hw *hw, unsigned long rate,
> +                            unsigned long *parent_rate)
> +{
> +       struct clk_priv *priv =3D hw_to_priv(hw);
> +       struct device *dev =3D priv_to_dev(priv);
> +       unsigned long min =3D ~0;
> +       unsigned long ret =3D 0;
> +       int i;
> +
> +       /*
> +        * select closest rate
> +        */
> +       for_each_iclk(i) {
> +               unsigned long irate =3D clk_get_rate(priv->i[i]);
> +               unsigned long diff =3D abs(rate - irate);
> +
> +               if (min > diff) {
> +                       min =3D diff;
> +                       ret =3D irate;
> +               }
> +       }
> +
> +       dev_dbg(dev, "(close)round rate %lu\n", ret);
> +
> +       return ret;
> +}
> +
> +static long clk74_round_rate_audio(struct clk_hw *hw, unsigned long rate,
> +                            unsigned long *parent_rate)
> +{
> +       struct clk_priv *priv =3D hw_to_priv(hw);
> +       struct device *dev =3D priv_to_dev(priv);
> +       unsigned long ret =3D 0;
> +       int is_8k =3D 0;
> +       int i;
> +
> +       /*
> +        * select 48kHz or 44.1kHz category rate
> +        */
> +       if (!(rate % 8000))
> +               is_8k =3D 1;
> +
> +       for_each_iclk(i) {
> +               unsigned long irate =3D clk_get_rate(priv->i[i]);
> +
> +               if (( is_8k && !(irate % 8000)) ||
> +                   (!is_8k &&  (irate % 8000))) {
> +                       ret =3D irate;
> +               }
> +       }
> +
> +       dev_dbg(dev, "(audio)round rate %lu\n", ret);
> +
> +       return ret;
> +}
> +
> +static long clk74_round_rate(struct clk_hw *hw, unsigned long rate,
> +                            unsigned long *parent_rate)
> +{
> +       struct clk_priv *priv =3D hw_to_priv(hw);
> +
> +       return priv->round_rate(hw, rate, parent_rate);
> +}
> +
> +static unsigned long clk74_recalc_rate(struct clk_hw *hw,
> +                                    unsigned long parent_rate)
> +{
> +       struct clk_priv *priv =3D hw_to_priv(hw);
> +       struct device *dev =3D priv_to_dev(priv);
> +       unsigned long rate;
> +       int i =3D gpiod_get_raw_value_cansleep(priv->sel);
> +
> +       rate =3D clk_get_rate(priv->i[i]);
> +
> +       dev_dbg(dev, "recalc rate %lu as i%d\n", rate, i);
> +
> +       return rate;
> +}
> +
> +static u8 clk74_get_parent(struct clk_hw *hw)
> +{
> +       struct clk_priv *priv =3D hw_to_priv(hw);
> +
> +       return gpiod_get_raw_value_cansleep(priv->sel);
> +}
> +
> +static const struct clk_ops clk74_ops =3D {
> +       .set_rate       =3D clk74_set_rate,
> +       .round_rate     =3D clk74_round_rate,
> +       .recalc_rate    =3D clk74_recalc_rate,
> +       .get_parent     =3D clk74_get_parent,
> +};

Can this all be handled by the 'gpio-mux-clock' compatible/driver? I
suppose it may need an update to add the rounding policy that you want
via some sort of DT property, but otherwise it would be fine?

> +
> +static const char * const clk74_in_name[CLK_I_NUM] =3D {
> +       "i0",
> +       "i1",
> +};
> +
> +static int clk74_probe(struct platform_device *pdev)
> +{
> +       struct clk *clk;
> +       struct clk_init_data init;
> +       struct clk_priv *priv;
> +       struct device *dev =3D &pdev->dev;
> +       const char *parent_names[CLK_I_NUM];
> +       int i, ret;
> +
> +       priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENODEV;

You mean -ENOMEM?

> +
> +       for_each_iclk(i) {
> +               clk =3D devm_clk_get(dev, clk74_in_name[i]);
> +               if (IS_ERR(clk))
> +                       return -EPROBE_DEFER;

Please return actual error code instead of overriding and returning
probe defer.

> +               priv->i[i] =3D clk;
> +               parent_names[i] =3D __clk_get_name(clk);
> +       }
> +
> +       memset(&init, 0, sizeof(init));
> +       init.name               =3D "74aup1g157gw";
> +       init.ops                =3D &clk74_ops;
> +       init.parent_names       =3D parent_names;
> +       init.num_parents        =3D CLK_I_NUM;
> +
> +       priv->hw.init           =3D &init;
> +       priv->dev               =3D dev;
> +       priv->round_rate        =3D of_device_get_match_data(dev);
> +       priv->sel               =3D devm_gpiod_get(dev, "sel", 0);
> +       if (IS_ERR(priv->sel))
> +               return -EPROBE_DEFER;

Please return the actual error.

> +
> +       gpiod_direction_output(priv->sel, 0);
> +
> +       ret =3D devm_clk_hw_register(dev, &priv->hw);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret =3D devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, &p=
riv->hw);
> +       if (ret < 0)
> +               return ret;
> +
> +       platform_set_drvdata(pdev, priv);
> +
> +       dev_info(dev, "probed\n");

Please remove noise like this.

> +
> +       return 0;
> +}
> +
> +#define OF_ID(name, func) { .compatible =3D name, .data =3D func }
> +static const struct of_device_id clk74_of_match[] =3D {
> +       OF_ID("nxp,74aup1g157gw-clk",           clk74_round_rate_close),
> +       OF_ID("nxp,74aup1g157gw-audio-clk",     clk74_round_rate_audio),

Nitpick: I'd prefer to not have the macro.
