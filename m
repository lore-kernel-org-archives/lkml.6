Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752038AbeDZCim (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 22:38:42 -0400
Received: from bert.emutex.com ([91.103.1.109]:54919 "EHLO bert.emutex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751710AbeDZCik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 22:38:40 -0400
Date: Thu, 26 Apr 2018 03:38:36 +0100
From: Javier Arteaga <javier@emutex.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        "Dan O'Donovan" <dan@emutex.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH RESEND 3/3] pinctrl: upboard: Add UP2 pinctrl and
 gpio driver
Message-ID: <20180426023836.udbeoocp76tsv7vu@localhost>
References: <20180421085009.28773-1-javier@emutex.com>
 <20180421085009.28773-4-javier@emutex.com>
 <1524674952.21176.610.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1524674952.21176.610.camel@linux.intel.com>
X-Spam-Score: -1.0 (-)
X-Spam-Report: Spam detection software, running on the system "statler.emutex.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Wed, Apr 25, 2018 at 07:49:12PM +0300, Andy Shevchenko
   wrote: > > For reference, here's the relevant ASL from the UP2 platform >
   > controller. > > It should be in Documentation file or in commit message.
    [...]
 Content analysis details:   (-1.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 07:49:12PM +0300, Andy Shevchenko wrote:
> > For reference, here's the relevant ASL from the UP2 platform
> > controller.
> 
> It should be in Documentation file or in commit message.

Perfect, I just wasn't sure whether dumping ASL this way would be
acceptable in commit history. In that case, I think I prefer the commit
body over keeping a Documentation/ file elsewhere that's easy to miss.

> >  static const struct mfd_cell upboard_up2_mfd_cells[] = {
> > +	{ .name = "upboard-pinctrl" },
> 
> I guess it should be 3 lines.

> 
> >  	UPBOARD_LED_CELL(upboard_up2_led_data, 0),
> >  	UPBOARD_LED_CELL(upboard_up2_led_data, 1),
> >  	UPBOARD_LED_CELL(upboard_up2_led_data, 2),
> 
> ...and honestly I would not use this macro and put 4 cells explicitly
> here.

The idea was to avoid repeating .platform_data + .pdata_size over and
over as there's a few LEDs per board, but explicit is good too.

May just go with your suggestion as that seems to be more popular than
macros in other mfd drivers.

> > +static int upboard_gpio_request_enable(struct pinctrl_dev *pctldev,
> > +				       struct pinctrl_gpio_range
> > *range,
> > +				       unsigned int pin)
> > +{
> > +	const struct pin_desc * const pd = pin_desc_get(pctldev,
> > pin);
> > +	const struct upboard_pin *p;
> > +	int ret;
> > +
> 
> > +	if (!pd)
> > +		return -EINVAL;
> 
> When it's possible?

Just reread pin_request() from pinctrl core. You're right, it isn't.
I'll take out the check.

> > +	if (!pd)
> > +		return -EINVAL;
> 
> Ditto.

As above.

> 
> > +	struct upboard_pinctrl *pctrl =
> > +		container_of(gc, struct upboard_pinctrl, chip);
> 
> Do define and use to_upboard_pinctrl().

Will do.

> > +	if (offset + 1 > pctrl->nsoc_gpios || !pctrl-
> > >soc_gpios[offset])
> > +		return ERR_PTR(-ENODEV);
> 
> When this is a case?

Another unnecessary check if gpiolib already guarantees valid inputs.

> > +static int upboard_gpio_get_direction(struct gpio_chip *gc, unsigned
> > int offset)
> > +{
> > +	struct gpio_desc *desc = upboard_offset_to_soc_gpio(gc,
> > offset);
> > +
> 
> Split above to definition and assignment pieces. Put assignment
> immediately before condition.
> 
> > +	if (IS_ERR(desc))
> > +		return PTR_ERR(desc);

I'll do that.

> > +static struct regmap_field * __init upboard_field_alloc(struct device
> > *dev,
> > +							struct regmap
> > *regmap,
> > +							unsigned int
> > base,
> > +							unsigned int
> > number)
> 
> You should really understand what __init means and when it's appropriate
> to use it.

As in the other email: the intention was to drop probe() and funcs only
used on module init, but I appear to have misunderstood something here.

> > +static int __init upboard_pinctrl_probe(struct platform_device *pdev)
> > +{
> > +	struct acpi_device * const adev = ACPI_COMPANION(&pdev->dev);
> 
> Huh, const in that place? Why?

You're right, it isn't a usual pattern. Dropped.

> > +	if (!pdev->dev.parent)
> > +		return -EINVAL;
> > +
> > +	upboard = dev_get_drvdata(pdev->dev.parent);
> > +	if (!upboard)
> > +		return -EINVAL;
> 
> Same comment as per LED driver.

I'll address that too.

> > +	if (strcmp(acpi_device_hid(adev), "AANT0F01"))
> > +		return -ENODEV;
> 
> Huh?

Ugh, this is left over from a bit of code that selected the right
pinctrl_desc* for each UP HID. Of course, it doesn't make sense now.

I'll take that out.

> > +		((struct pinctrl_pin_desc *)pd)->drv_data = pin;
> 
> What is that?! I mean ugly casting.

I agree, it's an eyesore. The intention was to drop const from
pinctrl_desc->pins as we're replacing the pins' drv_data on init.

It does look like I'm going at this the wrong way though. I'll take
another stab at it (pointers welcome of course).

> > +MODULE_LICENSE("GPL");
> 
> License mismatch.

Will fix.

Thanks again for your time Andy! I really appreciate your help :)
