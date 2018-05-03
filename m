Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbeECOdW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 10:33:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56950 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751027AbeECOdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 10:33:21 -0400
Date: Thu, 3 May 2018 16:33:19 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Danny Milosavljevic <dannym@scratchpost.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Andrea Bondavalli <andrea.bondavalli74@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v14 2/8] ASoC: sun4i-codec: Add Mic1 Boost Volume, Mic2
 Boost Volume
Message-ID: <20180503143319.4vyh2y5sluatssnv@flea>
References: <20180502210800.1971-1-dannym@scratchpost.org>
 <20180502210800.1971-3-dannym@scratchpost.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vviupd6fljapnitc"
Content-Disposition: inline
In-Reply-To: <20180502210800.1971-3-dannym@scratchpost.org>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vviupd6fljapnitc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 02, 2018 at 11:07:54PM +0200, Danny Milosavljevic wrote:
> Add Mic1 Boost Volume and Mic2 Boost Volume for Allwinner A10 and Allwinn=
er
> A20.  Also add support for extra controls to the sun4i_codec_quirks becau=
se
> the A10 and A20 have Mic1 Boost Volume at different places (likewise for
> Mic2 Boost Volume).

A good rule of thumb is that when you have "also" in your commit log,
you should do another patch instead doing that instead.

>=20
> Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
> ---
>  sound/soc/sunxi/sun4i-codec.c | 66 ++++++++++++++++++++++++++++++++++++-=
------
>  1 file changed, 56 insertions(+), 10 deletions(-)
>=20
> diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
> index 060a40b45ab0..4af286f44a67 100644
> --- a/sound/soc/sunxi/sun4i-codec.c
> +++ b/sound/soc/sunxi/sun4i-codec.c
> @@ -95,6 +95,8 @@
>  #define SUN4I_CODEC_ADC_ACTL_PREG1EN			(29)
>  #define SUN4I_CODEC_ADC_ACTL_PREG2EN			(28)
>  #define SUN4I_CODEC_ADC_ACTL_VMICEN			(27)
> +#define SUN4I_CODEC_ADC_ACTL_PREG1			(25)
> +#define SUN4I_CODEC_ADC_ACTL_PREG2			(23)
>  #define SUN4I_CODEC_ADC_ACTL_VADCG			(20)
>  #define SUN4I_CODEC_ADC_ACTL_ADCIS			(17)
>  #define SUN4I_CODEC_ADC_ACTL_PA_EN			(4)
> @@ -111,6 +113,9 @@
>  /* Microphone controls (sun7i only) */
>  #define SUN7I_CODEC_AC_MIC_PHONE_CAL		(0x3c)
> =20
> +#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG1		(29)
> +#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG2		(26)
> +
>  /*
>   * sun6i specific registers
>   *
> @@ -676,6 +681,12 @@ static const struct snd_kcontrol_new sun4i_codec_pa_=
mute =3D
>  static DECLARE_TLV_DB_SCALE(sun4i_codec_pa_volume_scale, -6300, 100, 1);
>  static DECLARE_TLV_DB_SCALE(sun4i_codec_micin_loopback_gain_scale, -450,=
 150,
>  			    0);
> +static DECLARE_TLV_DB_RANGE(sun4i_codec_micin_preamp_gain_scale,
> +			    0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
> +			    1, 7, TLV_DB_SCALE_ITEM(3500, 300, 0));
> +static DECLARE_TLV_DB_RANGE(sun7i_codec_micin_preamp_gain_scale,
> +			    0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
> +			    1, 7, TLV_DB_SCALE_ITEM(2400, 300, 0));
> =20
>  static const struct snd_kcontrol_new sun4i_codec_controls[] =3D {
>  	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
> @@ -686,6 +697,24 @@ static const struct snd_kcontrol_new sun4i_codec_con=
trols[] =3D {
>  		       sun4i_codec_micin_loopback_gain_scale),
>  };
> =20
> +static const struct snd_kcontrol_new sun4i_codec_extra_controls[] =3D {
> +	SOC_SINGLE_TLV("Mic1 Boost Volume", SUN4I_CODEC_ADC_ACTL,
> +		       SUN4I_CODEC_ADC_ACTL_PREG1, 3, 0,
> +		       sun4i_codec_micin_preamp_gain_scale),
> +	SOC_SINGLE_TLV("Mic2 Boost Volume", SUN4I_CODEC_ADC_ACTL,
> +		       SUN4I_CODEC_ADC_ACTL_PREG2, 3, 0,
> +		       sun4i_codec_micin_preamp_gain_scale),
> +};
> +
> +static const struct snd_kcontrol_new sun7i_codec_extra_controls[] =3D {
> +	SOC_SINGLE_TLV("Mic1 Boost Volume", SUN7I_CODEC_AC_MIC_PHONE_CAL,
> +		       SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG1, 7, 0,
> +		       sun7i_codec_micin_preamp_gain_scale),
> +	SOC_SINGLE_TLV("Mic2 Boost Volume", SUN7I_CODEC_AC_MIC_PHONE_CAL,
> +		       SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG2, 7, 0,
> +		       sun7i_codec_micin_preamp_gain_scale),
> +};
> +
>  static const struct snd_kcontrol_new sun4i_codec_left_mixer_controls[] =
=3D {
>  	SOC_DAPM_SINGLE("Left DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
>  			SUN4I_CODEC_DAC_ACTL_LDACLMIXS, 1, 0),
> @@ -807,7 +836,30 @@ static const struct snd_soc_dapm_route sun4i_codec_c=
odec_dapm_routes[] =3D {
>  	{ "Mic2", NULL, "VMIC" },
>  };
> =20
> +struct sun4i_codec_quirks {
> +	const struct regmap_config *regmap_config;
> +	const struct snd_soc_component_driver *codec;
> +	struct snd_soc_card * (*create_card)(struct device *dev);
> +	struct reg_field reg_adc_fifoc;	/* used for regmap_field */
> +	unsigned int reg_dac_txdata;	/* TX FIFO offset for DMA config */
> +	unsigned int reg_adc_rxdata;	/* RX FIFO offset for DMA config */
> +	bool has_reset;
> +	const struct snd_kcontrol_new *controls;
> +	unsigned int num_controls;
> +};
> +
> +static int sun4i_codec_component_driver_probe(struct snd_soc_component *=
codec)
> +{
> +	const struct sun4i_codec_quirks *quirks;
> +
> +	quirks =3D of_device_get_match_data(codec->dev);
> +	return snd_soc_add_component_controls(codec,
> +					      quirks->controls,
> +					      quirks->num_controls);

Why not just extending the sun4i_codec_controls to add it, and create
a duplicate one for the A20?


--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--vviupd6fljapnitc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrrHa4ACgkQ0rTAlCFN
r3TZbw//ScafJ0bpt8z1a9daE5QqpRdIZbuMkW1KXP66STvu++Lpr6aqkluQD3G9
MfKiMocXGHTSURLuSZlzv8hl9CBzkLnvCKLcUXG6brWH/vrpCLJ74dzmRD98d89c
I/PyGukcD5IKtJ2jwp5dK/I06q0ABaDEqPtUKPzC6sS4r2waF9MTZtHoEMyLFZm5
30OknMCn3anAoRKTyxorEwqCxhPdZEcXwGcU0ltfoNc+pSpbzlt7HSPiwtGvh59r
4q7zDDSbbs3o2xty1HJ4lv0kgQHZfeYGPeF98NREvNo85mwWMkWb7D9gtRaouWXs
t/jVnSoTbO7bRhHNjvgaU49vAmU06jOFa4xi8cHA77+kG3uHRTDUkZyqNVv/6clq
DYdR3gRBDX55Nz+lG1oXdzIykfN5FcdkjiM9Iu/uwcBx+UQUwMHTWfTp0ldMXbYA
agAhG2NI4clJ0sGQXiHTLm9yWKp90VeRdHlOVpht9cfZl080nHPOHrgoppVIin/1
tZDsZQwdb3HqRoMw4KGbL7FRiiqPkIG1smmkTMTDqEUxhny+H1dQrLvv9oxB7FaM
5xO65tY4WvSdwcHhJ1SCqli4Z+dPKA1XP5uT3YlsdZDzJ7Tacq+rZvi+uEYDB13v
9vXpENH3BV5PINluAuPyXUzcNwFdt+BG3rj33gGRXBByhjbAab4=
=T39u
-----END PGP SIGNATURE-----

--vviupd6fljapnitc--
