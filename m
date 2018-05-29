Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933828AbeE2MR6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 08:17:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52574 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933576AbeE2MRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 08:17:54 -0400
Date: Tue, 29 May 2018 13:17:46 +0100
From: Mark Brown <broonie@kernel.org>
To: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel][PATCH v1] ASoC: TSCS454: Add Support
Message-ID: <20180529121746.GH23509@sirena.org.uk>
References: <20180529105147.GA32219@t7-ThinkPad-E560>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="82evfD9Ogz2JrdWZ"
Content-Disposition: inline
In-Reply-To: <20180529105147.GA32219@t7-ThinkPad-E560>
X-Cookie: Variables don't
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--82evfD9Ogz2JrdWZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 29, 2018 at 05:52:00AM -0500, Steven Eckhoff wrote:

> +static char const * const in_bst_txt[] = {
> +		"0 dB", "10 dB", "20 dB", "30 dB"};
> +

This looks like just a regular volume control, it should be a normal
SOC_SINGLE_TLV().

> +	SOC_SINGLE("Input Channel 1 Mute En",
> +			R_ICTL0, FB_ICTL0_IN1MUTE, 1, 0),

All these En controls (I'm guessing Enable?) are just simple on/off
controls and should end in Switch as per ControlNames.txt.

> +	/* R_ICH0VOL PG 1 ADDR 0x12 */
> +	SOC_SINGLE_TLV("Input Channel 0", R_ICH0VOL,
> +			FB_ICHVOL_ICHVOL, FM_ICHVOL_ICHVOL, 0, in_vol_tlv_arr),

All volume controls should end in Volume.

> +static int tscs454_hw_params(struct snd_pcm_substream *substream,
> +		struct snd_pcm_hw_params *params,
> +		struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_component *component = dai->component;
> +	struct tscs454 *tscs454 = snd_soc_component_get_drvdata(component);
> +	unsigned int fs = params_rate(params);

> +	mutex_lock(&aif->lock);
> +	config_aif = aif->users == 0;
> +	aif->users++;
> +	mutex_unlock(&aif->lock);
> +
> +	if (!config_aif)
> +		return 0;

We silently ignore attempts to configure the parameters?  That's broken,
userspace won't know.  You should be setting more of the symmetry flags
on the DAIs (for things that are relevant) and returning an error if
there's an attempt to configure an incompatible parameter.

> +	mutex_lock(&tscs454->active_aifs_lock);
> +	res_ir_pll = tscs454->active_aifs == 0;

Please write normal if statements, these comparisons within assignments
are easy to miss and look like attempts to combine multiple
initializations in a single line due to the mix of = and ==.

--82evfD9Ogz2JrdWZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsNROkACgkQJNaLcl1U
h9CNUwf8CmICB1Kmq854Tm6vc1zv73K9wuGMNRaTHSruYq+n7B1kHwlbBB7u8Ca5
lDkiSXt+StcJwQYKM9YVtWwd88MmAsEkPMCzmtYDHxeAE068/C+KhPyrdPStZAqz
ixQEeYA9rRROrxb9SBpNz2AOH4febKsE+cRhNoimwsvAbuNO6FNDQYJIfOAqLREG
WrnsL69PvKfyIfBRCPiB2Tw4Q2kAGCoNBbJ9tRQGc7aPkeoh7A25sKq6BWylotUK
JEqLBtdUHGQd/gdrrqcPdvrk7e8IxEEtkalyMaDIcYBw98IR+5dXU0UPpHuF1TOy
CeWm3ZyGpmo+GZolmUljvNPYJSYxUA==
=Y94q
-----END PGP SIGNATURE-----

--82evfD9Ogz2JrdWZ--
