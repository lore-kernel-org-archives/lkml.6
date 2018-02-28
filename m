Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752293AbeB1LAz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 06:00:55 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57606 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752155AbeB1LAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 06:00:52 -0500
Date: Wed, 28 Feb 2018 11:00:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Matt Porter <mporter@konsulko.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: add tda7419 audio processor driver
Message-ID: <20180228110038.GA6722@sirena.org.uk>
References: <20180227225128.17815-1-mporter@konsulko.com>
 <20180227225128.17815-3-mporter@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <20180227225128.17815-3-mporter@konsulko.com>
X-Cookie: TANSTAAFL
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 27, 2018 at 05:51:28PM -0500, Matt Porter wrote:

> +static bool tda7419_writeable_reg(struct device *dev, unsigned int reg)
> +{
> +	return true;
> +}

This is the default behaviour, may as well omit it (but equally it does
no harm).

> +static inline int tda7419_vol_get_value(int val, unsigned int mask,
> +					int thresh, unsigned int invert)
> +{
> +	val &= mask;
> +	if (val < thresh) {
> +		if (invert)
> +			val = 0 - val;
> +	} else if (val > thresh) {

This feels like something some other device might want to use so might
warrant pulling out into a general control at some point but I'd not
insist on doing it now.

> +static struct snd_kcontrol_new tda7419_controls[] = {
> +SOC_ENUM("Main Source Select", soc_enum_main_src_sel),

Should this be a DAPM route?

> +SOC_SINGLE("Main Source AutoZero", TDA7419_MAIN_SRC_REG,
> +	   TDA7419_MAIN_SRC_AUTOZERO, 1, 1),

There's a lot of on/off switches for various things in here - these
should all have Switch at the end of their names so that userspace can
see how it's expected to display them.  Most of the controls with a max
value of 1 probably fall into this category.

> +SOC_SINGLE("Clock Fast Mode", TDA7419_MUTE_CLK_REG,
> +	   TDA7419_CLK_FAST_MODE, 1, 1),

What does this do - should it be in set_sysclk() or something?

> +	/* Configure registers */
> +	regmap_write(tda7419->regmap, TDA7419_VOLUME_REG, 0xe0);
> +	regmap_write(tda7419->regmap, TDA7419_MIXING_GAIN_REG, 0x0f);
> +	regmap_write(tda7419->regmap, TDA7419_ATTENUATOR_LF_REG, 0xe0);
> +	regmap_write(tda7419->regmap, TDA7419_ATTENUATOR_RF_REG, 0xe0);
> +	regmap_write(tda7419->regmap, TDA7419_ATTENUATOR_LR_REG, 0xe0);
> +	regmap_write(tda7419->regmap, TDA7419_ATTENUATOR_RR_REG, 0xe0);
> +	regmap_write(tda7419->regmap, TDA7419_MIXING_LEVEL_REG, 0xe0);
> +	regmap_write(tda7419->regmap, TDA7419_ATTENUATOR_SUB_REG, 0xe0);

This looks like it's setting default volumes - just leave those at the
chip defaults and let userspace handle setting them, what works for one
board may be totally inappropriate on another board and using the chip
default means we've got some fixed thing we don't need to discuss.

> +static int tda7419_remove(struct i2c_client *i2c)
> +{
> +	int i;
> +	struct tda7419_data *tda7419 = i2c_get_clientdata(i2c);
> +
> +	/* Reset registers to defaults */
> +	for (i = 0; i < ARRAY_SIZE(tda7419_regmap_defaults); i++)
> +		regmap_write(tda7419->regmap,
> +			     tda7419_regmap_defaults[i].reg,
> +			     tda7419_regmap_defaults[i].def);

Why are we doing this?  Other drivers don't do it...  if anything I'd
expect a reset on probe in case the bootloader or something left the
chip configured.

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqWi9UACgkQJNaLcl1U
h9BvNAf+Kt7wqrYcDAbhkitQVbfFcMWKs9ptkQUJ7gUfe51CTL3LXCUKMaERhR6r
sU9mECFOm/0cDskE6XyuVDwcvh3IaWyeJ3rM0DoV97DtDQpYBvpuzk5ISBZMlp71
igzd+rGERaO1u5Hx7nEYJBWdcMUAdJcCeXuQmQPwUY9nTux1YlyCTR+OwpnM+VC9
lzcB5hJDCQ/Aig0l8d/200magEc/VKG3GA//5yUYjw71pSnt2SEHdScldzMQTL1m
xASe/cFZtONv3S/SzLBffyJovPTdIWtJVlGvvZfmv2S22b/hqFfEqELHLZC+eHIZ
YibWqZ27mK7kjkYMzLHUno04OkIF2A==
=7vZJ
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
