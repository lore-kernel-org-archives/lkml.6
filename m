Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FD6C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776E0204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776E0204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbeK0Udu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:33:50 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60146 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbeK0Udt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:33:49 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8FD40207BC; Tue, 27 Nov 2018 10:36:29 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5F276207A8;
        Tue, 27 Nov 2018 10:36:19 +0100 (CET)
Date:   Tue, 27 Nov 2018 10:36:19 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Priit Laes <plaes@plaes.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Olliver Schinagl <oliver@schinagl.nl>
Subject: Re: [PATCH 06/14] regulator: axp20x: add software based soft_start
 for AXP209 LDO3
Message-ID: <20181127093619.72ensythkx2mhdf5@flea>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
 <41cb1b4dac3a15595c89fa962b78d3f68f370021.1543245984.git-series.plaes@plaes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xycxlit5uzxdvqgf"
Content-Disposition: inline
In-Reply-To: <41cb1b4dac3a15595c89fa962b78d3f68f370021.1543245984.git-series.plaes@plaes.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xycxlit5uzxdvqgf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 26, 2018 at 05:27:47PM +0200, Priit Laes wrote:
> From: Olliver Schinagl <oliver@schinagl.nl>
>=20
> In the past, there have been words on various lists that if LDO3 is
> disabled in u-boot, but enabled in the DTS, the axp209 driver would
> fail to continue/hang. Several enable/disable patches have been
> issues to devicetree's in both the kernel and u-boot to address
> this issue.
>=20
> What really happened however, was that the AXP209 shuts down without
> a notice and without setting an interrupt. This is caused when LDO3
> gets overloaded, for example with large capacitors on the LDO3 output.
>=20
> Normally, we would expect that AXP209 would source 200 mA as per
> datasheet and set and trigger an interrupt when being overloaded.
> For some reason however, this does not happen.
>=20
> As a work-around, we use the soft-start constraint of the regulator
> node to first bring up the LDO3 to the lowest possible voltage and
> then enable the LDO. After that, we can set the requested voltage
> as usual.
>=20
> Combining this setting with the regulator-ramp-delay allows LDO3 to
> enable voltage slowly and staggered, potentially reducing overall
> inrush current.
>=20
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  drivers/regulator/axp20x-regulator.c | 57 ++++++++++++++++++++++++++++-
>  1 file changed, 56 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp=
20x-regulator.c
> index 1d9fa62..e8a895b 100644
> --- a/drivers/regulator/axp20x-regulator.c
> +++ b/drivers/regulator/axp20x-regulator.c
> @@ -14,6 +14,7 @@
>   */
> =20
>  #include <linux/bitops.h>
> +#include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/init.h>
>  #include <linux/mfd/axp20x.h>
> @@ -23,6 +24,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>
>  #include <linux/regulator/of_regulator.h>
> =20
>  #define AXP20X_GPIO0_FUNC_MASK		GENMASK(3, 0)
> @@ -430,6 +432,59 @@ static int axp20x_set_ramp_delay(struct regulator_de=
v *rdev, int ramp)
>  	return regmap_update_bits(axp20x->regmap, reg, mask, cfg);
>  }
> =20
> +static int axp20x_regulator_enable_regmap(struct regulator_dev *rdev)
> +{
> +	struct axp20x_dev *axp20x =3D rdev_get_drvdata(rdev);
> +	const struct regulator_desc *desc =3D rdev->desc;
> +
> +	if (!rdev)
> +		return -EINVAL;
> +
> +	switch (axp20x->variant) {
> +	case AXP209_ID:
> +		if ((desc->id =3D=3D AXP20X_LDO3) &&
> +		    rdev->constraints && rdev->constraints->soft_start) {
> +			int v_out;
> +			int ret;
> +
> +			/*
> +			 * On some boards, the LDO3 can be overloaded when
> +			 * turning on, causing the entire PMIC to shutdown
> +			 * without warning. Turning it on at the minimal voltage
> +			 * and then setting the voltage to the requested value
> +			 * works reliably.
> +			 */
> +			if (regulator_is_enabled_regmap(rdev))
> +				break;
> +
> +			v_out =3D regulator_get_voltage_sel_regmap(rdev);
> +			if (v_out < 0)
> +				return v_out;
> +
> +			if (v_out =3D=3D 0)
> +				break;
> +
> +			ret =3D regulator_set_voltage_sel_regmap(rdev, 0x00);
> +			/*
> +			 * A small pause is needed between
> +			 * setting the voltage and enabling the LDO to give the
> +			 * internal state machine time to process the request.
> +			 */
> +			usleep_range(1000, 5000);
> +			ret |=3D regulator_enable_regmap(rdev);
> +			ret |=3D regulator_set_voltage_sel_regmap(rdev, v_out);
> +
> +			return ret;
> +		}
> +		break;
> +	default:
> +		/* No quirks */
> +		break;
> +	}
> +
> +	return regulator_enable_regmap(rdev);
> +};
> +

This is some pretty generic code, and could be useful to some other
users. I guess a generic function would be better for this.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--xycxlit5uzxdvqgf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/0QEwAKCRDj7w1vZxhR
xfK7AQChUMMNT4uSC1kZ02rxEKq7jj7Aj5OReZePaYE4dhhT3AEAxCb3fgaVByKb
fqP//z/kqitXwJZsC7CqrIwUGFrtUQ0=
=YAe9
-----END PGP SIGNATURE-----

--xycxlit5uzxdvqgf--
