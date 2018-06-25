Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9124FC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B673262D3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIu5/dB2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B673262D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755778AbeFYXpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 19:45:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753205AbeFYXo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 19:44:59 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D184262D2;
        Mon, 25 Jun 2018 23:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529970298;
        bh=FcfjZZzQEErX7Catida5eBx0yUYZFgdR2E+yjuA7nTo=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=pIu5/dB2ydmNkXg8csCHpm+Usi8ENszuMx5eCX2iQX43nVkEUxkvsfc02Doob9UiT
         AKSwBrPz3d2GoC6IsrSiIDU2OoVA+z1NaiKcfgxoEJmZwQW8LaKJFsx83Lf8x/g/fm
         6nmank71B71EdmKa+TF2yE8nNImyr2ys/qQTuIVY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Matti Vaittinen <mazziesaccount@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180612082354.GG20078@localhost.localdomain>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        broonie@kernel.org, lee.jones@linaro.org, lgirdwood@gmail.com,
        mark.rutland@arm.com, mazziesaccount@gmail.com,
        mturquette@baylibre.com, robh+dt@kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
References: <cover.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
 <d99c8762b0fbbcb18ec4f4d104191364c0ea798c.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
 <152878945117.16708.12422348324182290971@swboyd.mtv.corp.google.com>
 <20180612082354.GG20078@localhost.localdomain>
Message-ID: <152997029783.143105.16692843405899913246@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 4/4] clk: bd71837: Add driver for BD71837 PMIC clock
Date:   Mon, 25 Jun 2018 16:44:57 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matti Vaittinen (2018-06-12 01:23:54)
> On Tue, Jun 12, 2018 at 12:44:11AM -0700, Stephen Boyd wrote:
> > Quoting Matti Vaittinen (2018-06-04 06:19:13)
> =

> > =

> > > +struct bd71837_clk {
> > > +       struct clk_hw hw;
> > > +       uint8_t reg;
> > > +       uint8_t mask;
> > =

> > Use u8 instead of uint8_t.
> I can do that but I am afraid I have missed the reason for this. Why u8
> is preferred? I would have assumed the standard uint8_t would be
> preferred - can you please educate me as to what is this reason?

This is kernel style to prefer the shorter types within the kernel code.
Outside of the kernel proper, uint*_t types are used in the UAPI
headers. You can look through the mailing list about this, but this is
how I've known it to be for a while now.

> =

> > > +       unsigned long rate;
> > > +       struct platform_device *pdev;
> > > +       struct bd71837 *mfd;
> > > +};
> > > +
> > > +static int bd71837_clk_set(struct clk_hw *hw, int status)
> > > +{
> > > +       struct bd71837_clk *c =3D container_of(hw, struct bd71837_clk=
, hw);
> > > +
> > > +       return bd71837_update_bits(c->mfd, c->reg, c->mask, status);
> > =

> > Any reason we can't use a regmap?
> =

> Not really. These wrappers might become handy if the next chip in series
> requires some quirks for access but at the moment I see no reason for
> the wrappers. I could switch to direct regmap calls but that change
> should then be done to all subdevices and not just for clk one. This
> means I should rework also the already applied regulator part. I have
> some other changes pending for regulators (adding support for next chip,
> renaming bd71837 to bd718x7 or bd718xx, and few comments from  Andy
> Shevchenko and Rob Herring). I would rather switch to direct regmap usage
> for all subdevices at the same time. So if it is acceptable to keep the
> wrappers for now (and then create own patch set to remove them from all
> subdevices and the header) I would like to do so.

Ok. Sounds fine.

> =

> > =

> > > +}
> > > +
> > > +static void bd71837_clk_disable(struct clk_hw *hw)
> > > +{
> > > +       int rv;
> > > +       struct bd71837_clk *c =3D container_of(hw, struct bd71837_clk=
, hw);
> > > +
> > > +       rv =3D bd71837_clk_set(hw, 0);
> > > +       if (rv)
> > > +               dev_dbg(&c->pdev->dev, "Failed to disable 32K clk (%d=
)\n", rv);
> > > +}
> > > +
> > > +static int bd71837_clk_enable(struct clk_hw *hw)
> > > +{
> > > +       return bd71837_clk_set(hw, 1);
> > > +}
> > > +
> > > +static int bd71837_clk_is_enabled(struct clk_hw *hw)
> > > +{
> > > +       struct bd71837_clk *c =3D container_of(hw, struct bd71837_clk=
, hw);
> > > +
> > > +       return c->mask & bd71837_reg_read(c->mfd, c->reg);
> > =

> > Didn't I ask for local variable for reg_read result?
> =

> Yes! Sorry! And thanks for pointing this out again. It seems I missed
> this one.

Ok no worries.

> =

> > =

> > > +}
> > > +
> > > +static unsigned long bd71837_clk_recalc_rate(struct clk_hw *hw,
> > > +                                            unsigned long parent_rat=
e)
> > > +{
> > > +       struct bd71837_clk *c =3D container_of(hw, struct bd71837_clk=
, hw);
> > > +
> > > +       return c->rate;
> > > +}
> > > +
> > > +static const struct clk_ops bd71837_clk_ops =3D {
> > > +       .recalc_rate =3D &bd71837_clk_recalc_rate,
> > > +       .prepare =3D &bd71837_clk_enable,
> > > +       .unprepare =3D &bd71837_clk_disable,
> > > +       .is_prepared =3D &bd71837_clk_is_enabled,
> > > +};
> > > +
> > > +static int bd71837_clk_probe(struct platform_device *pdev)
> > > +{
> > > +       struct bd71837_clk *c;
> > > +       int rval =3D -ENOMEM;
> > > +       struct bd71837 *mfd =3D dev_get_drvdata(pdev->dev.parent);
> > > +       struct clk_init_data init =3D {
> > > +               .name =3D "bd71837-32k-out",
> > > +               .ops =3D &bd71837_clk_ops,
> > > +       };
> > > +
> > > +       c =3D devm_kzalloc(&pdev->dev, sizeof(*c), GFP_KERNEL);
> > > +       if (!c)
> > > +               goto err_out;
> > > +
> > > +       c->reg =3D BD71837_REG_OUT32K;
> > > +       c->mask =3D BD71837_OUT32K_EN;
> > > +       c->rate =3D BD71837_CLK_RATE;
> > =

> > The PMIC has an 'XIN' pin that would be the clk input for this chip, and
> > the output clk, this driver, would specify that xin clock as the parent.
> > The 'xin' clock would then be listed in DT as a fixed-rate clock. That
> > way this driver doesn't hardcode the frequency.
> =

> I see. This makes sense. I need to verify from HW colleagues whether
> this chip has internal oscillator or not. I originally thought we have
> on-chip oscillator - but as you say, we do have XIN pin in documentation.
> So now I am not sure if the test board I have contains oscillator driving
> the clk on PMIC - or if the PMIC has internal oscillator. I'll clarify th=
is.

Alright.

> =

> > > +       c->mfd =3D mfd;
> > > +       c->pdev =3D pdev;
> > > +
> > > +       of_property_read_string_index(pdev->dev.parent->of_node,
> > > +                                             "clock-output-names", 0,
> > > +                                             &init.name);
> > > +
> > > +       c->hw.init =3D &init;
> > =

> > Do this next to all the other c-> things?
> =

> I can do so. I just like the idea of assigning pointers to objects only
> after the objects have been initialized. Eg, in this case I add pointer
> to init only after I have filled the init.name (if it is given).

Alright, sure.

> =

> > =

> > > +
> > > +       rval =3D devm_clk_hw_register(&pdev->dev, &c->hw);
> > > +       if (rval) {
> > > +               dev_err(&pdev->dev, "failed to register 32K clk");
> > > +               goto err_out;
> > > +       }
> > > +
> > > +       if (pdev->dev.parent->of_node) {
> > > +               rval =3D of_clk_add_hw_provider(pdev->dev.parent->of_=
node,
> > > +                                            of_clk_hw_simple_get,
> > > +                                            &c->hw);
> > > +               if (rval) {
> > > +                       dev_err(&pdev->dev, "adding clk provider fail=
ed\n");
> > > +                       goto err_out;
> > =

> > Just return rval instead of goto and then remove err_out label.
> =

> Is this 'hard requirement'? I prefer single point of exit from functions
> (when easily doable) because I have done so many errors with locks /
> resources being reserved when exiting from some error branch. For my
> personal taste maintaining the one nice cleanup sequence is easier. But
> if this is 'hard requirement' this can of course be changed.

There are no locks though. And this uses devm. So please remove the goto
so my style alarms don't go off. Thanks!

> =

> > =

> > > +               }
> > > +       }
> > > +
> > > +       rval =3D clk_hw_register_clkdev(&c->hw, init.name, NULL);
> > =

> > This leaks a clkdev lookup. Sad we don't have a devm version. Maybe it
> > should be added. But I really doubt this chip will be used with clkdev
> > lookups so please remove clkdev until you have a user who needs it.
> =

> Yep. It leaks. I tried to look for an example where the clkdev was
> nicely freed at remove - but I didn't find any. Every example I spotted
> did leak the clkdev in same way as this does :( And I agree, devm
> variant for freeing would be nice - or freeing routines based on hw.
> =

> As the leaked clkdev can cause oops at module unload/reload/use your
> suggestion about removing it for now makes sense. I'll drop it.

Ok! Sometimes drivers don't free them because they're lazy and don't
expect to be unloaded or to fail. I guess you ran into those. I'm happy
to apply patches to clean those up.

> =

> > =

> > > +       if (rval) {
> > > +               dev_err(&pdev->dev, "failed to register clkdev for bd=
71837");
> > > +               goto err_clean_provider;
> > > +       }
> > > +
> > > +       platform_set_drvdata(pdev, c);
> > > +
> > > +       return 0;
> > > +
> > > +err_clean_provider:
> > > +       of_clk_del_provider(pdev->dev.parent->of_node);
> > > +err_out:
> > > +       return rval;
> > > +}
> > > +
> > > +static int bd71837_clk_remove(struct platform_device *pdev)
> > > +{
> > > +       if (pdev->dev.parent->of_node)
> > > +               of_clk_del_provider(pdev->dev.parent->of_node);
> > =

> > Use devm so this can go away. Or is devm not used because the parent
> > of_node is the provider? That's annoying.
> =

> What would be the correct workaround for this?

Smash the clk driver into the overall PMIC node. That should work. Or
possibly assign the same of_node to the child device when creating it?
I'm not sure if that causes some sort of problem with DT code though, so
it would be good to check with Rob H if that's a bad idea or not.

