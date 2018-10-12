Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F786C67877
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2173320868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATxnBobN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2173320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbeJLXdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:33:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728527AbeJLXdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:33:06 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9645120835;
        Fri, 12 Oct 2018 15:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539359997;
        bh=at/cpLo5dEEY8Xek4FE4ujwTOYqHXr4jIG8SeF0q6mA=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=ATxnBobNcUr11KpSyfcDoAtq43wGBaEQKeEwzYVFhJZOSM0agdS2UwepWwt8QTnv+
         tAreidkVDn+SumA8QTolN34TnagF4YeAhZCraOrxc8nCycD9c4rIytws3u1vwiQulD
         ASUdf6kKv+0H94v1S0fDO+uMixmkjyKQ6WXc3ato=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181011132602.GD1653@imbe.wolfsonmicro.main>
Cc:     broonie@kernel.org, lee.jones@linaro.org, linus.walleij@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20181008132542.19775-1-ckeepax@opensource.cirrus.com>
 <20181008132542.19775-3-ckeepax@opensource.cirrus.com>
 <153924124658.207691.10370075148426001371@swboyd.mtv.corp.google.com>
 <20181011132602.GD1653@imbe.wolfsonmicro.main>
Message-ID: <153935999691.5275.1587207165396958375@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 3/5] clk: lochnagar: Add support for the Cirrus Logic Lochnagar
Date:   Fri, 12 Oct 2018 08:59:56 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Charles Keepax (2018-10-11 06:26:02)
> On Thu, Oct 11, 2018 at 12:00:46AM -0700, Stephen Boyd wrote:
> > Quoting Charles Keepax (2018-10-08 06:25:40)
> =

> > > +struct lochnagar_regmap_clk {
> > > +       unsigned int cfg_reg;
> > > +       unsigned int ena_mask;
> > > +       unsigned int dir_mask;
> > > +
> > > +       unsigned int src_reg;
> > > +       unsigned int src_mask;
> > =

> > Are these 32 bits or 16 bits or 8 bits? Please use a u32/u16/u8 so we
> > know the register width.
> > =

> =

> Can do.

Well Mark may be opposed so it doesn't really matter to me. Just
would be nice to have some more code documentation on the expected
register width.

> =

> > > +struct lochnagar_clk_priv {
> > > +       struct device *dev;
> > > +       struct lochnagar *lochnagar;
> > =

> > Is this used for anything besides getting the regmap? Can you get the
> > pointer to the parent in probe and use that to get the regmap pointer
> > from dev_get_remap() and also use the of_node of the parent to register
> > a clk provider? It would be nice to avoid including the mfd header file
> > unless it's providing something useful.
> > =

> =

> It is also used to find out which type of Lochnagar we have
> connected, which determines which clocks we should register. I

Can that be done through some device ID? So the driver can be untangled
from the MFD part.

> could perhaps pass that using another mechanism but we would
> still want to include the MFD stuff to get the register
> definitions. So this approach seems simplest.

Can the register definitions be moved to this clk driver?

Maybe you now get the hint, but I'd really like to be able to merge and
compile the clk driver all by itself without relying on the parent MFD
device to provide anything at compile time.

> =

> > > +#define LN_CLK_FIXED(ID, NAME, RATE) \
> > > +       [LOCHNAGAR_##ID] =3D { \
> > > +               .name =3D NAME, .type =3D LOCHNAGAR_CLK_TYPE_FIXED, \
> > > +               { .fixed.rate =3D RATE, }, \
> > > +       }
> > =

> > Can all these fixed clks come from DT instead of being populated by this
> > driver? Unless they're being generated by this hardware block and not
> > actually a crystal or some other on-board clock that goes into this
> > hardware block and then right out of it?
> > =

> =

> Technically they are supplied by a clock generator chip (bunch of
> PLLs) which is controlled by the board controller chip. That said
> I don't really ever see them changing so will move them in DT.
> =

> > > +static int lochnagar_regmap_prepare(struct clk_hw *hw)
> > > +{
> > > +       struct lochnagar_clk *lclk =3D lochnagar_hw_to_lclk(hw);
> > > +       struct lochnagar_clk_priv *priv =3D lclk->priv;
> > > +       struct regmap *regmap =3D priv->lochnagar->regmap;
> > > +       int ret;
> > > +
> > > +       dev_dbg(priv->dev, "Prepare %s\n", lclk->name);
> > =

> > Nitpick: Can you just rely on the clk tracepoints?
> > =

> =

> Can do they are hardly essential.
> =

> > > +
> > > +       if (!lclk->regmap.ena_mask)
> > =

> > Why did we assign the ops to the clk if it can't be enabled? Please make
> > different ops for different types of clks so we don't have to check
> > something else and bail out early when the op is called.
> > =

> =

> This is a bit of a leak from earlier versions of the code I
> can just remove them.
> =

> > > +static int lochnagar_regmap_set_parent(struct clk_hw *hw, u8 index)
> > > +{
> > > +       struct lochnagar_clk *lclk =3D lochnagar_hw_to_lclk(hw);
> > > +       struct lochnagar_clk_priv *priv =3D lclk->priv;
> > > +       struct regmap *regmap =3D priv->lochnagar->regmap;
> > > +       int ret;
> > > +
> > > +       dev_dbg(priv->dev, "Reparent %s to %s\n",
> > > +               lclk->name, priv->parents[index]);
> > > +
> > > +       if (lclk->regmap.dir_mask) {
> > > +               ret =3D regmap_update_bits(regmap, lclk->regmap.cfg_r=
eg,
> > > +                                        lclk->regmap.dir_mask,
> > > +                                        lclk->regmap.dir_mask);
> > > +               if (ret < 0) {
> > > +                       dev_err(priv->dev, "Failed to set %s directio=
n: %d\n",
> > =

> > What does direction mean?
> > =

> =

> Some of the clocks can both generate and receive a clock. For
> example the PSIA (external audio interface) MCLKs, the attached
> device could be expecting or providing a master audio clock. If
> the user assigns a parent to the clock we assume the attached
> device is providing a clock to us, otherwise we assume we are
> providing the clock.

And this directionality is determined by dir_mask? It would be great if
this sort of information was in the commit text or in a comment in the
driver so we know what's going on here.

> =

> > > +static int lochnagar_clk_remove(struct platform_device *pdev)
> > > +{
> > > +       struct lochnagar_clk_priv *priv =3D platform_get_drvdata(pdev=
);
> > > +       int i;
> > > +
> > > +       of_clk_del_provider(priv->lochnagar->dev->of_node);
> > =

> > Use devm variant of clk provider registration?
> > =

> =

> This isn't using the devm version as it makes the assumption
> that the device that contains the DT is the same one we want
> to devm against which isn't the case here.
> =

> I could update probe to copy the of_node over from the parent, if
> you prefer? I think that would also work.

I don't really mind either way. When we get these subdevice drivers of a
larger OF node for the whole MFD it becomes sort of awkward to make devm
work.

