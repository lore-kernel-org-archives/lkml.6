Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932130AbeCIOgG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 09:36:06 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:35140 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbeCIOfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 09:35:52 -0500
X-Google-Smtp-Source: AG47ELvEayz5RYqYuTec0NxzhXKTDzSOc86iceqk2dWLg9+NORFzUz4nBaUouUmgnPg08Wm2gl9alQ==
Date: Fri, 9 Mar 2018 09:35:48 -0500
From: Matt Porter <mporter@konsulko.com>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: add tda7419 audio processor driver
Message-ID: <20180309143548.xuajwfhiwuua7jg5@bacon.ohporter.com>
References: <20180227225128.17815-1-mporter@konsulko.com>
 <20180227225128.17815-3-mporter@konsulko.com>
 <20180228110038.GA6722@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228110038.GA6722@sirena.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 11:00:38AM +0000, Mark Brown wrote:
> On Tue, Feb 27, 2018 at 05:51:28PM -0500, Matt Porter wrote:
> 
> > +static bool tda7419_writeable_reg(struct device *dev, unsigned int reg)
> > +{
> > +	return true;
> > +}
> 
> This is the default behaviour, may as well omit it (but equally it does
> no harm).

Ok.

> 
> > +static inline int tda7419_vol_get_value(int val, unsigned int mask,
> > +					int thresh, unsigned int invert)
> > +{
> > +	val &= mask;
> > +	if (val < thresh) {
> > +		if (invert)
> > +			val = 0 - val;
> > +	} else if (val > thresh) {
> 
> This feels like something some other device might want to use so might
> warrant pulling out into a general control at some point but I'd not
> insist on doing it now.

Ok, yeah, I was also thinking it should be moved to a general helper
when the next user shows up. The most likely case is another part in
this family may have a similar register layout.

> > +static struct snd_kcontrol_new tda7419_controls[] = {
> > +SOC_ENUM("Main Source Select", soc_enum_main_src_sel),
> 
> Should this be a DAPM route?

Ultimately yes. I initially took the path of ignoring DAPM support in
interests of getting some clean done. Is it ok to merge DAPM support
later or do you prefer just having it in the intitial driver? For
routes, it'll include Main/Second source selects, the Rear Source
switch, and Mix enable at least.

> > +SOC_SINGLE("Main Source AutoZero", TDA7419_MAIN_SRC_REG,
> > +	   TDA7419_MAIN_SRC_AUTOZERO, 1, 1),
> 
> There's a lot of on/off switches for various things in here - these
> should all have Switch at the end of their names so that userspace can
> see how it's expected to display them.  Most of the controls with a max
> value of 1 probably fall into this category.

I see. I'll fix that.

> > +SOC_SINGLE("Clock Fast Mode", TDA7419_MUTE_CLK_REG,
> > +	   TDA7419_CLK_FAST_MODE, 1, 1),
> 
> What does this do - should it be in set_sysclk() or something?

This is where things get hazy, unfortunately. The datasheet is partially
garbage. So there's no description or guidance on clock management at
all. It's not clear what clock this is or what specifically "fast" does.
Because there's no concept of an external clock, the sysclk is clearly
internally generated. Because of the register labeling of clock
generator, it's probably sysclk but I'm not 100% sure what the relevance
is of fast mode. The working settings were divined from trial and error
as well a couple microcontroller projects scattered across the
interwebs.

On second look at this, I think I should at least remove this switch
and hard code it for now or move to set_sysclk(). I'm hesistant of the
latter because of the lack of information on this setting.

> > +	/* Configure registers */
> > +	regmap_write(tda7419->regmap, TDA7419_VOLUME_REG, 0xe0);
> > +	regmap_write(tda7419->regmap, TDA7419_MIXING_GAIN_REG, 0x0f);
> > +	regmap_write(tda7419->regmap, TDA7419_ATTENUATOR_LF_REG, 0xe0);
> > +	regmap_write(tda7419->regmap, TDA7419_ATTENUATOR_RF_REG, 0xe0);
> > +	regmap_write(tda7419->regmap, TDA7419_ATTENUATOR_LR_REG, 0xe0);
> > +	regmap_write(tda7419->regmap, TDA7419_ATTENUATOR_RR_REG, 0xe0);
> > +	regmap_write(tda7419->regmap, TDA7419_MIXING_LEVEL_REG, 0xe0);
> > +	regmap_write(tda7419->regmap, TDA7419_ATTENUATOR_SUB_REG, 0xe0);
> 
> This looks like it's setting default volumes - just leave those at the
> chip defaults and let userspace handle setting them, what works for one
> board may be totally inappropriate on another board and using the chip
> default means we've got some fixed thing we don't need to discuss.

This is actually setting the default/cache to the first mute value due
to the assumption in my implementation of the tda7419-specific get/set
for these registers. It simplified the code a bit to have these
initialized like this. e.g. for the attenuator group of registers,
x11xxxxx are all mute values, so 0xe0 is setting these regs to that
first mute value to simplify things. I'll take another look at
eliminating this. As it is, it does not change the fact that the actual
reset value of 0xff is also mute from a user POV.

> > +static int tda7419_remove(struct i2c_client *i2c)
> > +{
> > +	int i;
> > +	struct tda7419_data *tda7419 = i2c_get_clientdata(i2c);
> > +
> > +	/* Reset registers to defaults */
> > +	for (i = 0; i < ARRAY_SIZE(tda7419_regmap_defaults); i++)
> > +		regmap_write(tda7419->regmap,
> > +			     tda7419_regmap_defaults[i].reg,
> > +			     tda7419_regmap_defaults[i].def);
> 
> Why are we doing this?  Other drivers don't do it...  if anything I'd
> expect a reset on probe in case the bootloader or something left the
> chip configured.

Good point, I'll move this into probe. The part doesn't have a soft
reset provision so we need to do it manually like this.

-Matt
