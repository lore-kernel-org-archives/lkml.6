Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751238AbeEEHFU (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 03:05:20 -0400
Received: from dd26836.kasserver.com ([85.13.145.193]:51296 "EHLO
        dd26836.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbeEEHFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 03:05:19 -0400
Date: Sat, 5 May 2018 09:05:13 +0200
From: Danny Milosavljevic <dannym@scratchpost.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
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
Message-ID: <20180505090513.7e3f02c2@scratchpost.org>
In-Reply-To: <20180503143319.4vyh2y5sluatssnv@flea>
References: <20180502210800.1971-1-dannym@scratchpost.org>
        <20180502210800.1971-3-dannym@scratchpost.org>
        <20180503143319.4vyh2y5sluatssnv@flea>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Thu, 3 May 2018 16:33:19 +0200
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> > +struct sun4i_codec_quirks {
> > +	const struct regmap_config *regmap_config;
> > +	const struct snd_soc_component_driver *codec;
> > +	struct snd_soc_card * (*create_card)(struct device *dev);
> > +	struct reg_field reg_adc_fifoc;	/* used for regmap_field */
> > +	unsigned int reg_dac_txdata;	/* TX FIFO offset for DMA config */
> > +	unsigned int reg_adc_rxdata;	/* RX FIFO offset for DMA config */
> > +	bool has_reset;
> > +	const struct snd_kcontrol_new *controls;
> > +	unsigned int num_controls;
> > +};
> > +
> > +static int sun4i_codec_component_driver_probe(struct snd_soc_component *codec)
> > +{
> > +	const struct sun4i_codec_quirks *quirks;
> > +
> > +	quirks = of_device_get_match_data(codec->dev);
> > +	return snd_soc_add_component_controls(codec,
> > +					      quirks->controls,
> > +					      quirks->num_controls);  
> 
> Why not just extending the sun4i_codec_controls to add it, and create
> a duplicate one for the A20?

Because sun4i_codec_controls has five controls shared between A10 and A20,
and only two not shared.

And if we extended sun4i_codec_controls, we'd also have to duplicate
sun4i_codec_codec in order to use sun4i_codec_controls vs. sun7i_codec_controls,
which really contains exactly the same data otherwise.

The quirks here are just for two controls, Mic1 Boost Volume and Mic2 Boost Volume,
and there not even for the names or anything - just for some reason the register
moved away.

The simplest way was to add it to the quirks - which already have a variant
selection etc.
