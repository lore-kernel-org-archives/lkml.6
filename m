Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751780AbeDXRHn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 13:07:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34946 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751216AbeDXRHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 13:07:41 -0400
Date: Tue, 24 Apr 2018 18:07:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, Ondrej Jirman <megous@megous.com>
Subject: Re: [PATCH v3 2/3] regulator: add support for SY8106A regulator
Message-ID: <20180424170733.GD22073@sirena.org.uk>
References: <20180423144657.63264-1-icenowy@aosc.io>
 <20180423144657.63264-3-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Content-Disposition: inline
In-Reply-To: <20180423144657.63264-3-icenowy@aosc.io>
X-Cookie: Take your Senator to lunch this week.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 23, 2018 at 10:46:56PM +0800, Icenowy Zheng wrote:

> --- /dev/null
> +++ b/drivers/regulator/sy8106a-regulator.c
> @@ -0,0 +1,176 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * sy8106a-regulator.c - Regulator device driver for SY8106A

Just make the entire thing a C++ comment so it looks consistent and
joined up.

> +static int sy8106a_set_voltage_sel(struct regulator_dev *rdev, unsigned int sel)
> +{
> +	/* We use our set_voltage_sel in order to avoid unnecessary I2C
> +	 * chatter, because the regulator_get_voltage_sel_regmap using
> +	 * apply_bit would perform 4 unnecessary transfers instead of one,
> +	 * increasing the chance of error.
> +	 */
> +	return regmap_write(rdev->regmap, rdev->desc->vsel_reg,
> +			    sel | SY8106A_GO_BIT);

Why would it do these extra transfers?  Is this just the fact that you
didn't set up a register cache (though the r/m/w cycle should only add
the read)?  We could put some logic in the core regmap code to detect
that an _update_bits() call is going to write to the whole register,
though it'd be even easier to just let this register be cached.

Generally if we can usefully optimize things we should do it at the
framework level.

> +	if (reg & SY8106A_GO_BIT)
> +		return reg & rdev->desc->vsel_mask;
> +	else
> +		return (chip->fixed_voltage - rdev->desc->min_uV) /
> +		       rdev->desc->uV_step;

You could use the standard get_voltage_sel() if you provide a mapping
operation that set everything with _GO_BIT set to return the fixed
voltage.  Though looking at this it seems that the fixed voltage will
always be one that could be set via the register anyway so I'm wondering
if the easiest thing here isn't to just have the driver turn off _GO_BIT
during probe() and not worry about the special case at runtime.

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrfZFQACgkQJNaLcl1U
h9ABoAf+MAY7wh6RxX+JxRaaZqaKm1sBzEsUizDdO0bmeMGUmy2XVE3nmGRUC5g9
5iEh9QeWock1uMhygZwIWNAudOUbzU2vj519R7fIDMSL/gSMs1pMGBOrQo/EYmpe
2yXh6dfVu1o3GJixqnwLlIEawT91IOqU7CzHq7LYLIn15FECsF9HqEI2+rEZokI4
zU5kqZTGwN6SAXCOTIgc/Rp7ZbwrL4vqyO9+lqNnG3sJKGmiwu/UzD1Ip6vU5Cuf
nr9KJUX80xuINjo32OpZoMfw9CmL5Py6MU+GptiozCDnNDdRo+rBv8phvaUX+dly
sFkRGlum9ixStWgoHz47moUxcOerxA==
=Q4GJ
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--
