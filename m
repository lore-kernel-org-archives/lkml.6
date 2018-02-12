Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933255AbeBLMCT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 07:02:19 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50518 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932519AbeBLMCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 07:02:16 -0500
Date: Mon, 12 Feb 2018 12:02:13 +0000
From: Mark Brown <broonie@kernel.org>
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wakasugi.jb@om.asahi-kasei.co.jp,
        shengjiu.wang@nxp.com, mihai.serban@gmail.com, cosmin.samoila@nxp.com,
        linux-imx@nxp.com, fabio.estevam@nxp.com, robh@kernel.org,
        andy.shevchenko@gmail.com, Mihai Serban <mihai.serban@nxp.com>
Subject: Re: [PATCH v3 1/2] ASoC: codecs: Add support for AK5558 ADC driver
Message-ID: <20180212120213.GB12976@sirena.org.uk>
References: <1517850115-24340-1-git-send-email-daniel.baluta@nxp.com>
 <1517850115-24340-2-git-send-email-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Content-Disposition: inline
In-Reply-To: <1517850115-24340-2-git-send-email-daniel.baluta@nxp.com>
X-Cookie: What UNIVERSE is this, please??
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 05, 2018 at 07:01:54PM +0200, Daniel Baluta wrote:
> AK5558 is a 32-bit, 768 kHZ sampling, differential input ADC
> for digital audio systems.

> --- /dev/null
> +++ b/sound/soc/codecs/ak5558.c
> @@ -0,0 +1,618 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Audio driver for AK5558 ADC

Please don't mix C++ and C style comments - just make the entire comment
C++.

> +static const char * const tdm_texts[] = {
> +	"Off", "TDM128",  "TDM256", "TDM512",
> +};

This looks like it should be a set_tdm_slot() operation, and indeed
set_tdm_slot() appears to be implemented and duplicate this.

> +static const char * const dsdon_texts[] = {
> +	"PCM", "DSD",
> +};

This looks like it's setting the DAI format?

> +	SND_SOC_DAPM_MUX("AK5558 Ch1 Enable", SND_SOC_NOPM, 0, 0,
> +			 &ak5558_channel1_mux_control),

On/off controls should be switches not muxes, though if this is just
selecting which channels are active (rather than a mute) I'd not expect
it to be a control at all - the board can say if inputs are disabled.

> +static int ak5558_set_mcki(struct snd_soc_codec *codec, int fs, int rclk)
> +{
> +	u8  mode;
> +
> +	mode = snd_soc_read(codec, AK5558_02_CONTROL1);
> +	mode &= ~AK5558_CKS;
> +	mode |= AK5558_CKS_AUTO;
> +
> +	snd_soc_update_bits(codec, AK5558_02_CONTROL1, AK5558_CKS, mode);
> +
> +	return 0;
> +}

This appears to just ignore the parameters?

> +static int ak5558_set_dai_mute(struct snd_soc_dai *dai, int mute)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	struct ak5558_priv *ak5558 = snd_soc_codec_get_drvdata(codec);
> +	int ndt = 0;
> +
> +	if (!mute)
> +		return 0;
> +
> +	if (ak5558->fs != 0)
> +		ndt = 583000 / ak5558->fs;
> +
> +	msleep(max(ndt, 5));
> +
> +	return 0;
> +}

This doesn't appear to interact with the device at all.

> +static int ak5558_set_bias_level(struct snd_soc_codec *codec,
> +				 enum snd_soc_bias_level level)
> +{
> +	switch (level) {
> +	case SND_SOC_BIAS_ON:
> +	case SND_SOC_BIAS_PREPARE:
> +	case SND_SOC_BIAS_STANDBY:
> +		break;
> +	case SND_SOC_BIAS_OFF:
> +		snd_soc_write(codec, AK5558_00_POWER_MANAGEMENT1, 0x00);
> +		break;
> +	}

I'd expect there to be symmetry here - if we disable things when
transitioning to _OFF we should enable them when transitioning out.

> +	reg = snd_soc_read(codec, AK5558_03_CONTROL2);
> +	reg &= ~AK5558_MODE_BITS;
> +	reg |= tdm_mode;
> +	snd_soc_write(codec, AK5558_03_CONTROL2, reg);

snd_soc_update_bits().

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqBgkQACgkQJNaLcl1U
h9C/uQf/a43OXnyCy8+wJ5aqImprGmRz2MeNF77ZGVOiyn9jGn26dOPv7cUcKvr8
I2gvJmXqA9zZSYBXq2DW2Oglj4Rdte1ur6DaDY+GxymiFWmfapnzRdFg0hwwRJK0
nYmiq+trR/Mci6YqERoj/SYHvxyck/YzW17z2Z7pM/GQZq2OoA2wajD/EGskTWxC
5/hM4o90LTAHh1iVymfHWaWFqSXY2Pc6k0/U86uRMnXr8neFqvC+3mu5CF80HmaL
NmGbe7hE2BoqQAMjr/jIR1kE0szTIdTLwK+xgkmtEe8e5twyM5OpYJV6v0fPizrj
0YShetJaeOnH5vPZ+LFUMfQb/jF9sQ==
=qOOt
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--
