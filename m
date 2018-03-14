Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752458AbeCNSKN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 14:10:13 -0400
Received: from relay0.mail.gandi.net ([217.70.178.220]:58987 "EHLO
        relay0-d.mail.gandi.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752301AbeCNSKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 14:10:10 -0400
X-Originating-IP: 2.224.242.101
Date: Wed, 14 Mar 2018 19:04:38 +0100
From: jacopo mondi <jacopo@jmondi.org>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, architt@codeaurora.org,
        a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, horms@verge.net.au, magnus.damm@gmail.com,
        geert@linux-m68k.org, niklas.soderlund@ragnatech.se,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] drm: bridge: Add thc63lvd1024 LVDS decoder driver
Message-ID: <20180314180438.GD16424@w540>
References: <1520951425-13843-1-git-send-email-jacopo+renesas@jmondi.org>
 <1520951425-13843-3-git-send-email-jacopo+renesas@jmondi.org>
 <a893a17c-367d-4f61-f835-4b6b420dc597@cogentembedded.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EY/WZ/HvNxOox07X"
Content-Disposition: inline
In-Reply-To: <a893a17c-367d-4f61-f835-4b6b420dc597@cogentembedded.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EY/WZ/HvNxOox07X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Sergei,
   thanks for review

On Wed, Mar 14, 2018 at 08:09:52PM +0300, Sergei Shtylyov wrote:
> On 03/13/2018 05:30 PM, Jacopo Mondi wrote:
>
> > Add DRM bridge driver for Thine THC63LVD1024 LVDS to digital parallel
> > output decoder.
> >
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> [...]
> > diff --git a/drivers/gpu/drm/bridge/thc63lvd1024.c b/drivers/gpu/drm/bridge/thc63lvd1024.c
> > new file mode 100644
> > index 0000000..4b059c0
> > --- /dev/null
> > +++ b/drivers/gpu/drm/bridge/thc63lvd1024.c
> > @@ -0,0 +1,241 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * THC63LVD1024 LVDS to parallel data DRM bridge driver.
> > + *
> > + * Copyright (C) 2018 Jacopo Mondi <jacopo+renesas@jmondi.org>
> > + */
> > +
> > +#include <drm/drmP.h>
> > +#include <drm/drm_bridge.h>
> > +#include <drm/drm_panel.h>
> > +
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/of_graph.h>
> > +#include <linux/regulator/consumer.h>
> > +
> > +static const char * const thc63_reg_names[] = {
> > +	"vcc", "lvcc", "pvcc", "cvcc", };
>
>    Your bracing style is pretty strange -- neither here nor there. Please place };
> on the next line...

Yeah, I had doubt about this.. The most common style I found around is

static const char * const foo[] = {
        "bar",
        "baz",
        "...",
};

But seems really too many lines for a bunch of 4 character strings...

>
> [...]
> > +static void thc63_enable(struct drm_bridge *bridge)
> > +{
> > +	struct thc63_dev *thc63 = to_thc63(bridge);
> > +	struct regulator *vcc;
> > +	unsigned int i;
> > +	int ret;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(thc63->vccs); i++) {
> > +		vcc = thc63->vccs[i];
> > +		if (vcc) {
> > +			ret = regulator_enable(vcc);
> > +			if (ret)
>
>    You hardly need this variable, could do a call right in this *if*.
>
> [...]
> > +error_vcc_enable:
> > +	dev_err(thc63->dev, "Failed to enable regulator %u\n", i);
> > +}
> > +
>
>    Why not do this instead of *goto* before?

Well, goto breaks the loop, if I only print out the error message, the
enable sequence will go on and enable the other regulators.

I can print out and break, but I don't see that much benefit

One thing I could do instead, is not only print out the error message,
but disable the already enabled regulators if one fails to start.

>
> > +static void thc63_disable(struct drm_bridge *bridge)
> > +{
> > +	struct thc63_dev *thc63 = to_thc63(bridge);
> > +	struct regulator *vcc;
> > +	unsigned int i;
> > +	int ret;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(thc63->vccs); i++) {
> > +		vcc = thc63->vccs[i];
> > +		if (vcc) {
> > +			ret = regulator_disable(vcc);
> > +			if (ret)
>
>    Again, no need for 'ret' whatsoever...
>
> > +				goto error_vcc_disable;
> > +		}
> > +	}
> > +
> > +	if (thc63->pwdn)
> > +		gpiod_set_value(thc63->pwdn, 1);
> > +
> > +	if (thc63->oe)
> > +		gpiod_set_value(thc63->oe, 0);
> > +
> > +	return;
> > +
> > +error_vcc_disable:
> > +	dev_err(thc63->dev, "Failed to disable regulator %u\n", i);
>
>    Again, why not do it instead of *goto*?

ditto

>
> [...]
> > +static int thc63_gpio_init(struct thc63_dev *thc63)
> > +{
> > +	thc63->pwdn = devm_gpiod_get_optional(thc63->dev, "pwdn",
> > +					      GPIOD_OUT_LOW);
> > +	if (IS_ERR(thc63->pwdn)) {
> > +		dev_err(thc63->dev, "Unable to get GPIO \"pwdn\"\n");
>
>    "pwdn-gpios" maybe?
>
> > +		return PTR_ERR(thc63->pwdn);
> > +	}
> > +
> > +	thc63->oe = devm_gpiod_get_optional(thc63->dev, "oe", GPIOD_OUT_LOW);
> > +	if (IS_ERR(thc63->oe)) {
> > +		dev_err(thc63->dev, "Unable to get GPIO \"oe\"\n");
>
>    "oe-gpios" maybe?

Are you referring to the error message? I can change this, but again, I
see no standards around.

Thanks
   j

>
> [...]
>
> MBR, Sergei

--EY/WZ/HvNxOox07X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJaqWQ2AAoJEHI0Bo8WoVY8LpUQAKIyRMcMRnIzIsyHbHxNh2V8
tUIGieL84JcuSgN7hXLFt1sUoW+fQTu69G8LOSZKRV5idnEKMatmkuUnqIatuXXz
IkfqwfTdOHO1YoEWpsNvGUDa5UQBJO5ZK4PnrwNvGLfIddk+pdISmYvkvRzA7MG5
4ETsY/iE0XIhxPIxA+y/aiWwtdJ1fd5AwEPawAwDsKykWbgFTy6ZOdULr/bnQHmJ
1QqvwJV09JxXHUl7eGq9TsLhXBFj/ukWTX5gmbaqI7EBImQtgqf6ShqPBcr/ypLJ
pC7IHosNnVKF8Nk7IM0GVQjc5PIE+arHQAupEt98SpfezJluLkeDBfQmCjihzEAI
XRanoQJJONS5pv2SVFNql1W37p3ofeJDAbSEApdtcCn9r/wXZ0uQKnL6q68md73o
1s2jRXXKSjjePZ8QX/umlKkVjD1GYV4d/L1KJU0ejzaYKtutGHcZhzzkh5PwWQjA
mLsWv+lZu0+apeef9lJ8Ev8dHZTYp1X7JlKWVL6f68bVSd4k235T9ynflIkKfPkp
GOTIuZ90A6Oe7Zr6d67tumLpn0xXr6fEMTl1jl0SVwkGUAtI30TNmoqKQlb9Ezu6
SUUvPY4oEIEg9vTi9N1hPMqqyGkXeyCV2KGH2upNKWDH4gVtr7f3JwvwwUfP0Ip5
q7/f9gha5CKFVewZ/Q42
=Sba9
-----END PGP SIGNATURE-----

--EY/WZ/HvNxOox07X--
