Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754181AbeCRRWH (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 13:22:07 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:36311 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751750AbeCRRWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 13:22:03 -0400
X-Google-Smtp-Source: AG47ELv8mXPowkHhzecx5I/SyIqrnu8Rp49H/ueZFGlcBMEa3nMr+pEORNkkRMVCZnyQwnZmUT0V6w==
Date: Sun, 18 Mar 2018 13:21:59 -0400
From: Matt Porter <mporter@konsulko.com>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: add tda7419 audio processor driver
Message-ID: <20180318172159.cp3qfyprfkk6rueb@bacon.ohporter.com>
References: <20180227225128.17815-1-mporter@konsulko.com>
 <20180227225128.17815-3-mporter@konsulko.com>
 <20180228110038.GA6722@sirena.org.uk>
 <20180309143548.xuajwfhiwuua7jg5@bacon.ohporter.com>
 <20180309152912.GF5252@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309152912.GF5252@sirena.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 03:29:12PM +0000, Mark Brown wrote:
> On Fri, Mar 09, 2018 at 09:35:48AM -0500, Matt Porter wrote:
> > On Wed, Feb 28, 2018 at 11:00:38AM +0000, Mark Brown wrote:
> > > On Tue, Feb 27, 2018 at 05:51:28PM -0500, Matt Porter wrote:
> 
> > > > +static struct snd_kcontrol_new tda7419_controls[] = {
> > > > +SOC_ENUM("Main Source Select", soc_enum_main_src_sel),
> 
> > > Should this be a DAPM route?
> 
> > Ultimately yes. I initially took the path of ignoring DAPM support in
> > interests of getting some clean done. Is it ok to merge DAPM support
> > later or do you prefer just having it in the intitial driver? For
> > routes, it'll include Main/Second source selects, the Rear Source
> > switch, and Mix enable at least.
> 
> You definitely shouldn't be implementing things that should be in DAPM
> as non-DAPM controls.

Ok, I addressed this by adding DAPM support in v2.

> > > > +	regmap_write(tda7419->regmap, TDA7419_ATTENUATOR_SUB_REG, 0xe0);
> 
> > > This looks like it's setting default volumes - just leave those at the
> > > chip defaults and let userspace handle setting them, what works for one
> > > board may be totally inappropriate on another board and using the chip
> > > default means we've got some fixed thing we don't need to discuss.
> 
> > This is actually setting the default/cache to the first mute value due
> > to the assumption in my implementation of the tda7419-specific get/set
> > for these registers. It simplified the code a bit to have these
> > initialized like this. e.g. for the attenuator group of registers,
> > x11xxxxx are all mute values, so 0xe0 is setting these regs to that
> > first mute value to simplify things. I'll take another look at
> > eliminating this. As it is, it does not change the fact that the actual
> > reset value of 0xff is also mute from a user POV.
> 
> If it is useful it definitely needs a comment explaining what's
> happening and that there's no practical change to the configuration.  It
> would be nicer to be robust against the device getting a wider range of
> values in the register but that seems plausible.

I did some rework to make this unnecessary in v2.

Thanks,
Matt
