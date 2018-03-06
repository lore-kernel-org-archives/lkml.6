Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932974AbeCFO4N (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:56:13 -0500
Received: from mga09.intel.com ([134.134.136.24]:21347 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932448AbeCFO4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:56:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,431,1515484800";
   d="scan'208";a="35033616"
Message-ID: <1520348165.10722.438.camel@linux.intel.com>
Subject: Re: [PATCH] pinctrl: intel: Implement intel_gpio_get_direction
 callback
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Javier Arteaga <javier@emutex.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Tue, 06 Mar 2018 16:56:05 +0200
In-Reply-To: <3585081b-70af-5c31-08c0-84e96b6055bc@emutex.com>
References: <20180306134213.16898-1-javier@emutex.com>
         <3585081b-70af-5c31-08c0-84e96b6055bc@emutex.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-03-06 at 14:31 +0000, Javier Arteaga wrote:
> (Fix Andy's Cc: - apologies)
> 
> On 06/03/2018 13:42, Javier Arteaga wrote:
> > Allows querying GPIO direction from the pad config register.
> > If the pad is not in GPIO mode, return an error.
> > 
> > Signed-off-by: Javier Arteaga <javier@emutex.com>
> > ---
> > This is needed by the drivers for the UP Squared board, an APL-based
> > platform. (For now, these drivers are out-of-tree.)
> > 
> > An earlier version of this patch was reviewed some time ago by Andy
> > Shevchenko outside of the mailing lists:
> > <https://github.com/emutex/ubilinux-kernel/commit/708a776f2ffd1b1c>
> > 

Yes, this one look good!

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> >  drivers/pinctrl/intel/pinctrl-intel.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/drivers/pinctrl/intel/pinctrl-intel.c
> > b/drivers/pinctrl/intel/pinctrl-intel.c
> > index 96e73e30204e..1e24a6b8a64e 100644
> > --- a/drivers/pinctrl/intel/pinctrl-intel.c
> > +++ b/drivers/pinctrl/intel/pinctrl-intel.c
> > @@ -788,6 +788,24 @@ static void intel_gpio_set(struct gpio_chip
> > *chip, unsigned offset, int value)
> >  	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
> >  }
> >  
> > +static int intel_gpio_get_direction(struct gpio_chip *chip,
> > unsigned int offset)
> > +{
> > +	struct intel_pinctrl *pctrl = gpiochip_get_data(chip);
> > +	void __iomem *reg;
> > +	u32 padcfg0;
> > +
> > +	reg = intel_get_padcfg(pctrl, offset, PADCFG0);
> > +	if (!reg)
> > +		return -EINVAL;
> > +
> > +	padcfg0 = readl(reg);
> > +

> > +	if (padcfg0 & PADCFG0_PMODE_MASK)
> > +		return -EINVAL;

Actually we might return direction of GPIO function while pin is in some
other mode, though it would probably make not much sense in practice.

> > +
> > +	return !!(padcfg0 & PADCFG0_GPIOTXDIS);
> > +}
> > +
> >  static int intel_gpio_direction_input(struct gpio_chip *chip,
> > unsigned offset)
> >  {
> >  	return pinctrl_gpio_direction_input(chip->base + offset);
> > @@ -804,6 +822,7 @@ static const struct gpio_chip intel_gpio_chip =
> > {
> >  	.owner = THIS_MODULE,
> >  	.request = gpiochip_generic_request,
> >  	.free = gpiochip_generic_free,
> > +	.get_direction = intel_gpio_get_direction,
> >  	.direction_input = intel_gpio_direction_input,
> >  	.direction_output = intel_gpio_direction_output,
> >  	.get = intel_gpio_get,
> > 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
