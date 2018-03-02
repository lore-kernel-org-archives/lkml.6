Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427845AbeCBMvJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 07:51:09 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49900 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424020AbeCBMvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 07:51:06 -0500
Date: Fri, 2 Mar 2018 12:50:54 +0000
From: Mark Brown <broonie@kernel.org>
To: srinivas.kandagatla@linaro.org
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com,
        plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz,
        tiwai@suse.com, linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rohkumar@qti.qualcomm.com, spatakok@qti.qualcomm.com
Subject: Re: [PATCH v3 14/25] ASoC: qcom: qdsp6: Add support to q6afe dai
 driver
Message-ID: <20180302125054.GH6255@sirena.org.uk>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-15-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sClP8c1IaQxyux9v"
Content-Disposition: inline
In-Reply-To: <20180213165837.1620-15-srinivas.kandagatla@linaro.org>
X-Cookie: He who laughs last didn't get the joke.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sClP8c1IaQxyux9v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 13, 2018 at 04:58:26PM +0000, srinivas.kandagatla@linaro.org wrote:

> +static int q6hdmi_format_put(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct q6afe_dai_data *dai_data = kcontrol->private_data;
> +	int value = ucontrol->value.integer.value[0];
> +
> +	dai_data->port_config[AFE_PORT_HDMI_RX].hdmi.datatype = value;
> +
> +	return 0;
> +}

No validation, and do we not need to tell a currently running stream if
the format changed on it (or block such changes if they're not going to
work, which seems more likely)?

> +static int q6hdmi_hw_params(struct snd_pcm_substream *substream,
> +				struct snd_pcm_hw_params *params,
> +				struct snd_soc_dai *dai)
> +{
> +	struct q6afe_dai_data *dai_data = q6afe_get_dai_data(dai->dev);
> +	int channels = params_channels(params);
> +	struct q6afe_hdmi_cfg *hdmi = &dai_data->port_config[dai->id].hdmi;
> +
> +	hdmi->sample_rate = params_rate(params);
> +	switch (params_format(params)) {
> +	case SNDRV_PCM_FORMAT_S16_LE:
> +		hdmi->bit_width = 16;
> +		break;
> +	case SNDRV_PCM_FORMAT_S24_LE:
> +		hdmi->bit_width = 24;
> +		break;
> +	}

This silently accepts invalid values.

> +	/*refer to HDMI spec CEA-861-E: Table 28 Audio InfoFrame Data Byte 4*/

Coding style, spaces around the /* */.

> +static int q6afe_dai_startup(struct snd_pcm_substream *substream,
> +				struct snd_soc_dai *dai)
> +{
> +	struct q6afe_dai_data *dai_data = q6afe_get_dai_data(dai->dev);
> +
> +	dai_data->is_port_started[dai->id] = false;
> +
> +	return 0;
> +}

If this is needed it makes me a bit worried that we've got some kind of
bug with not shutting things down properly somewhere - what's going on
here?

> +static void q6afe_dai_shutdown(struct snd_pcm_substream *substream,
> +				struct snd_soc_dai *dai)
> +{
> +	struct q6afe_dai_data *dai_data = q6afe_get_dai_data(dai->dev);
> +	int rc;
> +
> +	rc = q6afe_port_stop(dai_data->port[dai->id]);
> +	if (rc < 0)
> +		dev_err(dai->dev, "fail to close AFE port\n");

Better to print the error code so users have more information to debug
the problem.

> +			.stream_name = "HDMI Playback",
> +			.rates = SNDRV_PCM_RATE_48000 |
> +				 SNDRV_PCM_RATE_96000 |
> +			 SNDRV_PCM_RATE_192000,

Indentation again.

> +static int q6afe_of_xlate_dai_name(struct snd_soc_component *component,
> +				   struct of_phandle_args *args,
> +				   const char **dai_name)
> +{
> +	int id = args->args[0];
> +	int i, ret = -EINVAL;

Coding style, don't mix initialization in with other variable
declarations on the same line like this.

> +int q6afe_dai_dev_remove(struct device *dev)
> +{
> +	return 0;
> +}

Remove empty functions, if they can't be removed it's probably not OK
for them to be empty either.

--sClP8c1IaQxyux9v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqZSK0ACgkQJNaLcl1U
h9CX4wf9FyO3+9VdszcJuUMqWPGnm25kNgL5Q/LXibxkdzUI05azL7NAuYsrbbYl
oVS99PY9j+ssXfxaxx1Juiqf0qrnomKZXnbyp6iTLA0TlrNzc8Mwph+b1mbwfge3
wtLZBZZXLOZ2zIut+wi6OjACdJ7to2RtbCzB5zTjDAEhe8VN3lXEG0RnQnurOEaM
HK7pdQKLjMc1B2xVQaV0boaVau+Tnqv7c+662SBuCOWWX1qHFCh9ijZ8TdP2kJrR
Ir6SR/Kzhy/9KfaRmCuKeQqBTp1TKTXgMFd6NDMnUU4ckfPpF1PuUgQQszKtbwkM
TTk6x5PTIPeZTvwpdx0IFTno5tdRRg==
=AW+P
-----END PGP SIGNATURE-----

--sClP8c1IaQxyux9v--
