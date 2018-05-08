Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932315AbeEHN3E convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 09:29:04 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53844 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753368AbeEHN3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 09:29:02 -0400
Date: Tue, 8 May 2018 15:28:51 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <contact@paulk.fr>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ARM: dts: sun7i: Add support for the Ainol AW1
 tablet
Message-ID: <20180508132851.cvthykob5mw6v6yy@flea>
References: <20180506214901.23429-1-contact@paulk.fr>
 <20180506214901.23429-3-contact@paulk.fr>
 <20180507071931.tebv45yxrojxxkeb@flea>
 <d8de7d2237a74388ac8c8152eded3477e7fd56a4.camel@paulk.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <d8de7d2237a74388ac8c8152eded3477e7fd56a4.camel@paulk.fr>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 10:15:46PM +0200, Paul Kocialkowski wrote:
> > > +	backlight: backlight {
> > > +		compatible = "pwm-backlight";
> > > +		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
> > > +		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
> > 
> > The increase in perceived brightness should be linear. Usually, for
> > PWMs backed backlight, an exponential list is a much better
> > approximation.
> 
> Thanks for the hint, it never occurred to me that pwm duty cycle was not
> linear with brightness, but that makes sense. I'll give that a try (on
> 255 values instead of 10 to keep some level of precision in low
> brightness). The way to go here is probably use a base-255 logarithm
> such as: duty cycle = range * log(i+1)/log(255) with i the linear
> brightness value (0 to 255) and range the amplitude of our values (that
> gets divided by the maximum brightness, so it's really up to hardware
> precision at this point). I'll go with a range of 255 as well.

Without going into something so complicated, usually a list with power
of two ending at 255 is a good approximation :)

> > > +&mmc0 {
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&mmc0_pins_a>;
> > > +	vmmc-supply = <&reg_vcc3v3>;
> > 
> > You have the regulators described in your DT, you'd better use them
> > instead of the one coming from sunxi-common-regulators.dtsi.
> 
> Well, according to the reference A20 design, the mmc pins and the card
> are powered by the 3.3V power rail, that comes from a regular step-down
> regulator sourcing from IPSOUT, so I don't see what regulator I should
> better use. Do you have a suggestion?

That works for me then.

> > > +&pio {
> > > +	panel_power_pin: panel_power_pin@0 {
> > > +		pins = "PH8";
> > > +		function = "gpio_out";
> > > +	};
> > > +};
> > 
> > You don't need that pinctrl node.
> 
> I'll get rid of it then. You mentioned that regulator-simple uses the
> old GPIO API, so I assumed it meant that a pinctrl node is still needed.
> For reference, it uses of_get_named_gpio (not the devm-managed fashion).

This is only relevant for the polarity of the pins, not the pinctrl part.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
