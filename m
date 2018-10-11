Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDA8C46463
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52B220835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQbG++3u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52B220835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbeJKO0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 10:26:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbeJKO0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 10:26:42 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F10820835;
        Thu, 11 Oct 2018 07:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539241247;
        bh=kNA2V8giZz46R+w3Wn5SPgU5As8NU4D68YxAD+uuOB8=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=gQbG++3uuHpSpq15cncSN3yx8RUT+KiATQew42HvdD3sx7IYzsg3KQEqZPkuHJ3QY
         vMzeuNl3QsrguZLdIz1cip6SvyS9NPW1uAw4E7hZUAHJzvHJVL4wacXC0aGg+Ql2Y1
         dfS6+SmZqzLGbW5yys1uYb1/KQBMe6C7RvOxh/kk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org,
        lee.jones@linaro.org, linus.walleij@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181008132542.19775-3-ckeepax@opensource.cirrus.com>
Cc:     mark.rutland@arm.com, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20181008132542.19775-1-ckeepax@opensource.cirrus.com>
 <20181008132542.19775-3-ckeepax@opensource.cirrus.com>
Message-ID: <153924124658.207691.10370075148426001371@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 3/5] clk: lochnagar: Add support for the Cirrus Logic Lochnagar
Date:   Thu, 11 Oct 2018 00:00:46 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Charles Keepax (2018-10-08 06:25:40)
> diff --git a/drivers/clk/clk-lochnagar.c b/drivers/clk/clk-lochnagar.c
> new file mode 100644
> index 0000000000000..fa54531dbf501
> --- /dev/null
> +++ b/drivers/clk/clk-lochnagar.c
> @@ -0,0 +1,449 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Lochnagar clock control
> + *
> + * Copyright (c) 2017-2018 Cirrus Logic, Inc. and
> + *                         Cirrus Logic International Semiconductor Ltd.
> + *
> + * Author: Charles Keepax <ckeepax@opensource.cirrus.com>
> + */
> +
> +#include <linux/clk.h>

Is this used?

> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>

Is this used?

> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>

Used?

> +#include <linux/regmap.h>
> +
> +#include <linux/mfd/lochnagar.h>
> +#include <dt-bindings/clk/lochnagar.h>
> +
> +#define LOCHNAGAR_NUM_CLOCKS   (LOCHNAGAR_SPDIF_CLKOUT + 1)
> +
> +enum lochnagar_clk_type {
> +       LOCHNAGAR_CLK_TYPE_UNUSED,
> +       LOCHNAGAR_CLK_TYPE_FIXED,
> +       LOCHNAGAR_CLK_TYPE_REGMAP,
> +};
> +
> +struct lochnagar_regmap_clk {
> +       unsigned int cfg_reg;
> +       unsigned int ena_mask;
> +       unsigned int dir_mask;
> +
> +       unsigned int src_reg;
> +       unsigned int src_mask;

Are these 32 bits or 16 bits or 8 bits? Please use a u32/u16/u8 so we
know the register width.

> +};
> +
> +struct lochnagar_fixed_clk {
> +       unsigned int rate;
> +};
> +
> +struct lochnagar_clk {
> +       struct lochnagar_clk_priv *priv;
> +       struct clk_hw hw;
> +
> +       const char * const name;
> +
> +       enum lochnagar_clk_type type;
> +       union {
> +               struct lochnagar_fixed_clk fixed;
> +               struct lochnagar_regmap_clk regmap;
> +       };
> +};
> +
> +struct lochnagar_clk_priv {
> +       struct device *dev;
> +       struct lochnagar *lochnagar;

Is this used for anything besides getting the regmap? Can you get the
pointer to the parent in probe and use that to get the regmap pointer
from dev_get_remap() and also use the of_node of the parent to register
a clk provider? It would be nice to avoid including the mfd header file
unless it's providing something useful.

> +
> +       const char **parents;
> +       unsigned int nparents;
> +
> +       struct lochnagar_clk lclks[LOCHNAGAR_NUM_CLOCKS];
> +
> +       struct clk *clks[LOCHNAGAR_NUM_CLOCKS];
> +       struct clk_onecell_data of_clks;
> +};
> +
> +static const char * const lochnagar1_clk_parents[] =3D {
> +       "ln-none",
> +       "ln-spdif-mclk",
> +       "ln-psia1-mclk",
> +       "ln-psia2-mclk",
> +       "ln-cdc-clkout",
> +       "ln-dsp-clkout",
> +       "ln-pmic-32k",
> +       "ln-gf-mclk1",
> +       "ln-gf-mclk3",
> +       "ln-gf-mclk2",
> +       "ln-gf-mclk4",
> +};
> +
> +static const char * const lochnagar2_clk_parents[] =3D {
> +       "ln-none",
> +       "ln-cdc-clkout",
> +       "ln-dsp-clkout",
> +       "ln-pmic-32k",
> +       "ln-spdif-mclk",
> +       "ln-clk-12m",
> +       "ln-clk-11m",
> +       "ln-clk-24m",
> +       "ln-clk-22m",
> +       "ln-reserved",
> +       "ln-usb-clk-24m",
> +       "ln-gf-mclk1",
> +       "ln-gf-mclk3",
> +       "ln-gf-mclk2",
> +       "ln-psia1-mclk",
> +       "ln-psia2-mclk",
> +       "ln-spdif-clkout",
> +       "ln-adat-clkout",
> +       "ln-usb-clk-12m",
> +};
> +
> +#define LN_CLK_FIXED(ID, NAME, RATE) \
> +       [LOCHNAGAR_##ID] =3D { \
> +               .name =3D NAME, .type =3D LOCHNAGAR_CLK_TYPE_FIXED, \
> +               { .fixed.rate =3D RATE, }, \
> +       }

Can all these fixed clks come from DT instead of being populated by this
driver? Unless they're being generated by this hardware block and not
actually a crystal or some other on-board clock that goes into this
hardware block and then right out of it?

> +
> +#define LN1_CLK_REGMAP(ID, NAME, REG, ...) \
> +       [LOCHNAGAR_##ID] =3D { \
> +               .name =3D NAME, .type =3D LOCHNAGAR_CLK_TYPE_REGMAP, \
> +               { .regmap =3D { \
> +                       __VA_ARGS__ \
> +                       .cfg_reg =3D LOCHNAGAR1_##REG, \
> +                       .ena_mask =3D LOCHNAGAR1_##ID##_ENA_MASK, \
> +                       .src_reg =3D LOCHNAGAR1_##ID##_SEL, \
> +                       .src_mask =3D LOCHNAGAR1_SRC_MASK, \
> +               }, }, \
> +       }
> +
> +#define LN2_CLK_REGMAP(ID, NAME) \
> +       [LOCHNAGAR_##ID] =3D { \
> +               .name =3D NAME, .type =3D LOCHNAGAR_CLK_TYPE_REGMAP, \
> +               { .regmap =3D { \
> +                       .cfg_reg =3D LOCHNAGAR2_##ID##_CTRL, \
> +                       .src_reg =3D LOCHNAGAR2_##ID##_CTRL, \
> +                       .ena_mask =3D LOCHNAGAR2_CLK_ENA_MASK, \
> +                       .dir_mask =3D LOCHNAGAR2_CLK_DIR_MASK, \
> +                       .src_mask =3D LOCHNAGAR2_CLK_SRC_MASK, \
> +               }, }, \
> +       }
> +
> +static const struct lochnagar_clk lochnagar1_clks[LOCHNAGAR_NUM_CLOCKS] =
=3D {
> +       LN1_CLK_REGMAP(CDC_MCLK1,      "ln-cdc-mclk1",  CDC_AIF_CTRL2),
> +       LN1_CLK_REGMAP(CDC_MCLK2,      "ln-cdc-mclk2",  CDC_AIF_CTRL2),
> +       LN1_CLK_REGMAP(DSP_CLKIN,      "ln-dsp-clkin",  DSP_AIF),
> +       LN1_CLK_REGMAP(GF_CLKOUT1,     "ln-gf-clkout1", GF_AIF1),
> +
> +       LN_CLK_FIXED(PMIC_32K,         "ln-pmic-32k",   32768),
> +};
> +
> +static const struct lochnagar_clk lochnagar2_clks[LOCHNAGAR_NUM_CLOCKS] =
=3D {
> +       LN2_CLK_REGMAP(CDC_MCLK1,      "ln-cdc-mclk1"),
> +       LN2_CLK_REGMAP(CDC_MCLK2,      "ln-cdc-mclk2"),
> +       LN2_CLK_REGMAP(DSP_CLKIN,      "ln-dsp-clkin"),
> +       LN2_CLK_REGMAP(GF_CLKOUT1,     "ln-gf-clkout1"),
> +       LN2_CLK_REGMAP(GF_CLKOUT2,     "ln-gf-clkout2"),
> +       LN2_CLK_REGMAP(PSIA1_MCLK,     "ln-psia1-mclk"),
> +       LN2_CLK_REGMAP(PSIA2_MCLK,     "ln-psia2-mclk"),
> +       LN2_CLK_REGMAP(SPDIF_MCLK,     "ln-spdif-mclk"),
> +       LN2_CLK_REGMAP(ADAT_MCLK,      "ln-adat-mclk"),
> +       LN2_CLK_REGMAP(SOUNDCARD_MCLK, "ln-soundcard-mclk"),
> +
> +       LN_CLK_FIXED(PMIC_32K,         "ln-pmic-32k",    32768),
> +       LN_CLK_FIXED(CLK_12M,          "ln-clk-12m",     12288000),
> +       LN_CLK_FIXED(CLK_11M,          "ln-clk-11m",     11298600),
> +       LN_CLK_FIXED(CLK_24M,          "ln-clk-24m",     24576000),
> +       LN_CLK_FIXED(CLK_22M,          "ln-clk-22m",     22579200),
> +       LN_CLK_FIXED(USB_CLK_24M,      "ln-usb-clk-24m", 24000000),
> +       LN_CLK_FIXED(USB_CLK_12M,      "ln-usb-clk-12m", 12000000),

They sort of look like crystals or dividers on crystals. Let's move them
to DT?

> +};
> +
> +static inline struct lochnagar_clk *lochnagar_hw_to_lclk(struct clk_hw *=
hw)
> +{
> +       return container_of(hw, struct lochnagar_clk, hw);
> +}
> +
> +static int lochnagar_regmap_prepare(struct clk_hw *hw)
> +{
> +       struct lochnagar_clk *lclk =3D lochnagar_hw_to_lclk(hw);
> +       struct lochnagar_clk_priv *priv =3D lclk->priv;
> +       struct regmap *regmap =3D priv->lochnagar->regmap;
> +       int ret;
> +
> +       dev_dbg(priv->dev, "Prepare %s\n", lclk->name);

Nitpick: Can you just rely on the clk tracepoints?

> +
> +       if (!lclk->regmap.ena_mask)

Why did we assign the ops to the clk if it can't be enabled? Please make
different ops for different types of clks so we don't have to check
something else and bail out early when the op is called.

> +               return 0;
> +
> +       ret =3D regmap_update_bits(regmap, lclk->regmap.cfg_reg,
> +                                lclk->regmap.ena_mask,
> +                                lclk->regmap.ena_mask);
> +       if (ret < 0)
> +               dev_err(priv->dev, "Failed to prepare %s: %d\n",
> +                       lclk->name, ret);
> +
> +       return ret;
> +}
> +
> +static void lochnagar_regmap_unprepare(struct clk_hw *hw)
> +{
> +       struct lochnagar_clk *lclk =3D lochnagar_hw_to_lclk(hw);
> +       struct lochnagar_clk_priv *priv =3D lclk->priv;
> +       struct regmap *regmap =3D priv->lochnagar->regmap;
> +       int ret;
> +
> +       dev_dbg(priv->dev, "Unprepare %s\n", lclk->name);
> +
> +       if (!lclk->regmap.ena_mask)
> +               return;
> +
> +       ret =3D regmap_update_bits(regmap, lclk->regmap.cfg_reg,
> +                                lclk->regmap.ena_mask, 0);
> +       if (ret < 0)
> +               dev_err(priv->dev, "Failed to unprepare %s: %d\n",
> +                       lclk->name, ret);
> +}
> +
> +static int lochnagar_regmap_set_parent(struct clk_hw *hw, u8 index)
> +{
> +       struct lochnagar_clk *lclk =3D lochnagar_hw_to_lclk(hw);
> +       struct lochnagar_clk_priv *priv =3D lclk->priv;
> +       struct regmap *regmap =3D priv->lochnagar->regmap;
> +       int ret;
> +
> +       dev_dbg(priv->dev, "Reparent %s to %s\n",
> +               lclk->name, priv->parents[index]);
> +
> +       if (lclk->regmap.dir_mask) {
> +               ret =3D regmap_update_bits(regmap, lclk->regmap.cfg_reg,
> +                                        lclk->regmap.dir_mask,
> +                                        lclk->regmap.dir_mask);
> +               if (ret < 0) {
> +                       dev_err(priv->dev, "Failed to set %s direction: %=
d\n",

What does direction mean?

> +                               lclk->name, ret);
> +                       return ret;
> +               }
> +       }
> +
> +       ret =3D regmap_update_bits(regmap, lclk->regmap.src_reg,
> +                                lclk->regmap.src_mask, index);
> +       if (ret < 0)
> +               dev_err(priv->dev, "Failed to reparent %s: %d\n",
> +                       lclk->name, ret);
> +
> +       return ret;
> +}
> +
> +static u8 lochnagar_regmap_get_parent(struct clk_hw *hw)
> +{
> +       struct lochnagar_clk *lclk =3D lochnagar_hw_to_lclk(hw);
> +       struct lochnagar_clk_priv *priv =3D lclk->priv;
> +       struct regmap *regmap =3D priv->lochnagar->regmap;
> +       unsigned int val;
> +       int ret;
> +
> +       ret =3D regmap_read(regmap, lclk->regmap.src_reg, &val);
> +       if (ret < 0) {
> +               dev_err(priv->dev, "Failed to read parent of %s: %d\n",
> +                       lclk->name, ret);
> +               return 0;

Return a number greater than all possible parents of this clk?

> +       }
> +
> +       val &=3D lclk->regmap.src_mask;
> +
> +       dev_dbg(priv->dev, "Parent of %s is %s\n",
> +               lclk->name, priv->parents[val]);
> +
> +       return val;
> +}
> +
> +static const struct clk_ops lochnagar_clk_regmap_ops =3D {
> +       .prepare =3D lochnagar_regmap_prepare,
> +       .unprepare =3D lochnagar_regmap_unprepare,
> +       .set_parent =3D lochnagar_regmap_set_parent,
> +       .get_parent =3D lochnagar_regmap_get_parent,
> +};
> +
> +static int lochnagar_init_parents(struct lochnagar_clk_priv *priv)
> +{
> +       struct device_node *np =3D priv->lochnagar->dev->of_node;
> +       enum lochnagar_type type =3D priv->lochnagar->type;
> +       int i, j;
> +
> +       switch (type) {
> +       case LOCHNAGAR1:
> +               memcpy(priv->lclks, lochnagar1_clks, sizeof(lochnagar1_cl=
ks));
> +
> +               priv->nparents =3D ARRAY_SIZE(lochnagar1_clk_parents);
> +               priv->parents =3D devm_kmemdup(priv->dev, lochnagar1_clk_=
parents,
> +                                            sizeof(lochnagar1_clk_parent=
s),
> +                                            GFP_KERNEL);
> +               break;
> +       case LOCHNAGAR2:
> +               memcpy(priv->lclks, lochnagar2_clks, sizeof(lochnagar2_cl=
ks));
> +
> +               priv->nparents =3D ARRAY_SIZE(lochnagar2_clk_parents);
> +               priv->parents =3D devm_kmemdup(priv->dev, lochnagar2_clk_=
parents,
> +                                            sizeof(lochnagar2_clk_parent=
s),
> +                                            GFP_KERNEL);
> +               break;
> +       default:
> +               dev_err(priv->dev, "Unknown Lochnagar type: %d\n", type);
> +               return -EINVAL;
> +       }
> +
> +       if (!priv->parents)
> +               return -ENOMEM;
> +
> +       for (i =3D 0; i < priv->nparents; i++) {
> +               j =3D of_property_match_string(np, "clock-names",
> +                                            priv->parents[i]);
> +               if (j >=3D 0) {
> +                       const char * const name =3D of_clk_get_parent_nam=
e(np, j);
> +
> +                       dev_dbg(priv->dev, "Set parent %s to %s\n",
> +                               priv->parents[i], name);
> +
> +                       priv->parents[i] =3D name;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static int lochnagar_init_clks(struct lochnagar_clk_priv *priv)
> +{
> +       struct clk_init_data clk_init =3D {
> +               .ops =3D &lochnagar_clk_regmap_ops,
> +               .parent_names =3D priv->parents,
> +               .num_parents =3D priv->nparents,
> +       };
> +       struct lochnagar_clk *lclk;
> +       struct clk *clk;
> +       int ret, i;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(priv->lclks); i++) {
> +               lclk =3D &priv->lclks[i];
> +
> +               lclk->priv =3D priv;
> +
> +               switch (lclk->type) {
> +               case LOCHNAGAR_CLK_TYPE_FIXED:
> +                       clk =3D clk_register_fixed_rate(priv->dev, lclk->=
name,
> +                                                     NULL, 0,
> +                                                     lclk->fixed.rate);
> +                       break;
> +               case LOCHNAGAR_CLK_TYPE_REGMAP:
> +                       clk_init.name =3D lclk->name;
> +                       lclk->hw.init =3D &clk_init;
> +
> +                       clk =3D devm_clk_register(priv->dev, &lclk->hw);

Please use the clk_hw based registration APIs.

> +                       break;
> +               default:
> +                       continue;
> +               }
> +
> +               if (IS_ERR(clk)) {
> +                       ret =3D PTR_ERR(clk);
> +                       dev_err(priv->dev, "Failed to register %s: %d\n",
> +                               lclk->name, ret);
> +                       return ret;
> +               }
> +
> +               dev_dbg(priv->dev, "Registered %s\n", lclk->name);
> +
> +               priv->clks[i] =3D clk;
> +       }
> +
> +       return 0;
> +}
> +
> +static int lochnagar_init_of_providers(struct lochnagar_clk_priv *priv)
> +{
> +       struct device *dev =3D priv->dev;
> +       int ret;
> +
> +       priv->of_clks.clks =3D priv->clks;
> +       priv->of_clks.clk_num =3D ARRAY_SIZE(priv->clks);
> +
> +       ret =3D of_clk_add_provider(priv->lochnagar->dev->of_node,

Same here, clk_hw based provider APIs.

> +                                 of_clk_src_onecell_get,
> +                                 &priv->of_clks);
> +       if (ret < 0) {
> +               dev_err(dev, "Failed to register clock provider: %d\n", r=
et);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int lochnagar_clk_probe(struct platform_device *pdev)
> +{
> +       struct lochnagar *lochnagar =3D dev_get_drvdata(pdev->dev.parent);
> +       struct device *dev =3D &pdev->dev;
> +       struct lochnagar_clk_priv *priv;
> +       int ret;
> +
> +       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->dev =3D dev;
> +       priv->lochnagar =3D lochnagar;
> +
> +       ret =3D lochnagar_init_parents(priv);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D lochnagar_init_clks(priv);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D lochnagar_init_of_providers(priv);
> +       if (ret)
> +               return ret;
> +
> +       platform_set_drvdata(pdev, priv);
> +
> +       return 0;
> +}
> +
> +static int lochnagar_clk_remove(struct platform_device *pdev)
> +{
> +       struct lochnagar_clk_priv *priv =3D platform_get_drvdata(pdev);
> +       int i;
> +
> +       of_clk_del_provider(priv->lochnagar->dev->of_node);

Use devm variant of clk provider registration?

> +
> +       for (i =3D 0; i < ARRAY_SIZE(priv->lclks); i++) {
> +               switch (priv->lclks[i].type) {
> +               case LOCHNAGAR_CLK_TYPE_FIXED:

Hopefully fixed goes away so we don't need case statements and this code
here.

> +                       clk_unregister_fixed_rate(priv->clks[i]);
> +                       break;
> +               default:
> +                       break;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static struct platform_driver lochnagar_clk_driver =3D {
> +       .driver =3D {
> +               .name =3D "lochnagar-clk",
> +       },

Any id_table?

> +
> +       .probe =3D lochnagar_clk_probe,
> +       .remove =3D lochnagar_clk_remove,
> +};
> +module_platform_driver(lochnagar_clk_driver);
> +
> +MODULE_AUTHOR("Charles Keepax <ckeepax@opensource.cirrus.com>");
> +MODULE_DESCRIPTION("Clock driver for Cirrus Logic Lochnagar Board");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:lochnagar-clk");
