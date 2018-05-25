Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753583AbeEYFyh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 01:54:37 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37191 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752360AbeEYFyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 01:54:35 -0400
X-Google-Smtp-Source: AB8JxZrA/r3tPLwsfINRjXagA2s0pIUqI2YQEihhzBVVm64vjeA+Xrop57LYkv3ul1zeP7GwdYl0ZQ==
From: Matti Vaittinen <mazziesaccount@gmail.com>
X-Google-Original-From: Matti Vaittinen <mvaittin@localhost.localdomain>
Date: Fri, 25 May 2018 08:54:30 +0300
To: Mark Brown <broonie@kernel.org>
Cc: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "Haikola, Heikki" <Heikki.Haikola@fi.rohmeurope.com>
Subject: Re: [PATCH 4/9] regulator: bd71837: Devicetree bindings for BD71837
 regulators
Message-ID: <20180525055430.GB16888@localhost.localdomain>
References: <20180524055752.GE4249@localhost.localdomain>
 <20180524140118.GS4828@sirena.org.uk>
 <042F8805D2046347BB8420BEAE397A4016C06B47@WILL-MAIL002.REu.RohmEu.com>
 <20180524175721.GB4828@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524175721.GB4828@sirena.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 06:57:21PM +0100, Mark Brown wrote:
> On Thu, May 24, 2018 at 05:30:57PM +0000, Vaittinen, Matti wrote:
> > > > On Thu, May 24, 2018 at 08:57:52AM +0300, Matti Vaittinen wrote:
> > >
> > > > +Required properties:
> > > > + - compatible: should be "rohm,bd71837-pmic".
> > > > + - regulator-name: should be "buck1", ..., "buck8" and "ldo1", ..., "ldo7"
> > >
> > > The MFD is for a single device, there should be no need for compatibles
> > > on subfunctions.
> > 
> > I will check this. I must admit I am not sure what is the de-facto mechanism
> > for assigning the correct device-tree nodes to sub devices if compatibles
> > are not used? I think I saw device-tree node name being used for regulators
> 
> You can look at the regulators node within the parent device, you know
> that in Linux the parent device will be the MFD.

So I should parse the device-tree in MFD my driver in order to locate
the regulators node? Isn't that somewhat like code dublication? If we
rely on compatibles we can avoid device-tree parsing in MFD driver,
right? An in-tree example of this is:

Documentation/devicetree/bindings/regulator/sprd,sc2731-regulator.txt
>Required properties:
>- compatible: should be "sprd,sc27xx-regulator".
//snip
>Example:
>	regulators {
>		compatible = "sprd,sc27xx-regulator";
>
>		 vddarm0: BUCK_CPU0 {
>			regulator-name = "vddarm0";
>			regulator-min-microvolt = <400000>;

drivers/mfd/sprd-sc27xx-spi.c
> static const struct mfd_cell sprd_pmic_devs[] = {
	//snip
>        }, {
>                .name = "sc27xx-regulator",
>                .of_compatible = "sprd,sc27xx-regulator",
>        }, {
	//snip
> };

and in probe just:
>        ret = devm_mfd_add_devices(&spi->dev, PLATFORM_DEVID_AUTO,
>                                   sprd_pmic_devs, ARRAY_SIZE(sprd_pmic_devs),
>                                   NULL, 0,
>                                   regmap_irq_get_domain(ddata->irq_data));

this looks clean to me and offloads the device-tree parsing completely
to generic code. Wouldn't that be simpler approach that looking up the
regulator node in MFD driver code? (I can do as you suggested but to me
the approach used in sprd-sc27xx-spi.c makes sense)

> > Also, another thing I was wondering is how supply regulators should be
> > handled? In this case the LDO5 is supplied by BUCK6 and LDO6 by
> > BUCK7. 
> 
> > From generic regulator bindings
> > /Documentation/devicetree/bindings/regulator/regulator.txt
> > I found statement:
> 
> > > - <name>-supply: phandle to the parent supply/regulator node
> 
> None of that stuff uses compatible strings, just handle it as covered in
> the bindings.
Sorry. I have not been clear with my question. This part was unrelated
to compatible properties - I should have stated it in my previous mail.

What I meant is that I tried out adding
xxx-supply = <&buck6>;
in LDO5 device tree node and expected that the regulator core code would
take care of parsing this from device-tree and adding the supply
information to LDO5. This was not done and I did not fing parsing for
*-supply from drivers/regulator/of_regulator.c. So I was wondering if I
am missing something? I guess the *-supply properties in device-tree for
BD71837 regulators are now ignored. Should the supply parsing be added
in drivers/regulator/of_regulator.c - or have I simply misunderstood
something?

Anyways, I ended up hard coding:
.supply_name = "buck6"
in LDO5 regulator_desc before passing the desc to regulator_register().
This works but it means the buck6 name must be fixed to "buck6".

Br,
	Matti Vaittinen
