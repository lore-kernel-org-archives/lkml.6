Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935618AbeCAHr3 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 02:47:29 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60450 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934908AbeCAHr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 02:47:27 -0500
Date: Thu, 1 Mar 2018 08:47:13 +0100
From: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexandre.belloni@bootlin.com
Subject: Re: [PATCH v1 2/4] ASoC: codecs: pcm179x: Add support for PCM1789
Message-ID: <20180301084713.24bdda4e@dell-desktop.home>
In-Reply-To: <20180227225629.5cc4e802@windsurf.lan>
References: <20180227212433.2189-1-mylene.josserand@bootlin.com>
        <20180227212433.2189-3-mylene.josserand@bootlin.com>
        <20180227225629.5cc4e802@windsurf.lan>
Organization: Bootlin
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, 27 Feb 2018 22:56:29 +0100
Thomas Petazzoni <thomas.petazzoni@bootlin.com> wrote:

> Hello,
> 
> On Tue, 27 Feb 2018 22:24:31 +0100, Mylène Josserand wrote:
> 
> > diff --git a/sound/soc/codecs/pcm179x-i2c.c b/sound/soc/codecs/pcm179x-i2c.c
> > index 795a0657c097..83a2e1508df8 100644
> > --- a/sound/soc/codecs/pcm179x-i2c.c
> > +++ b/sound/soc/codecs/pcm179x-i2c.c
> > @@ -26,10 +26,13 @@
> >  static int pcm179x_i2c_probe(struct i2c_client *client,
> >  			      const struct i2c_device_id *id)
> >  {
> > -	struct regmap *regmap;
> > +	struct regmap *regmap = NULL;  
> 
> I don't think this change is useful, since regmap is always initialized
> below anyway.

okay.

> 
> 
> > +	if (mute)
> > +		val = ~(PCM1789_MUTE_L_EN | PCM1789_MUTE_R_EN);  
> 
> That's not really useful with regmap_update_bits() which already does
> the masking, no?

Yep

> 
> > +	else
> > +		val = PCM1789_MUTE_L_EN | PCM1789_MUTE_R_EN;
> > +	ret = regmap_update_bits(priv->regmap, PCM1789_SOFT_MUTE,
> > +				 PCM1789_MUTE_MASK, val);  
> 
> Couldn't this be:
> 
> 	if (mute)
> 		val = 0;
> 	else
> 		val = PCM1789_MUTE_MASK;
> 
> 	ret = regmap_update_bits(priv->regmap, PCM1789_SOFT_MUTE,
> 				 PCM1789_MUTE_MASK, val);
> 

I will update my V2 with it.

> 
> > +static struct snd_soc_dai_driver pcm1789_dai = {
> > +	.name = "pcm1789-hifi",
> > +	.playback = {
> > +		.stream_name = "Playback",
> > +		.channels_min = 2,
> > +		.channels_max = 2,
> > +		.rates = SNDRV_PCM_RATE_CONTINUOUS,
> > +		.rate_min = 10000,
> > +		.rate_max = 200000,
> > +		.formats = PCM1792A_FORMATS, },  
> 
> Nit: the closing curly brace should be on a separate line.

Yep, thanks.

> 
> 
> > +	if (type == PCM1789)
> > +		return devm_snd_soc_register_component(dev,
> > +						       &soc_component_dev_pcm1789,
> > +						       &pcm1789_dai, 1);
> > +  
> 
> Perhaps a "else" here ?

Sure

> 
> >  	return devm_snd_soc_register_component(dev,
> >  			&soc_component_dev_pcm179x, &pcm179x_dai, 1);  
> 
> Thanks!
> 
> Thomas

Thank you,

Mylène

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
