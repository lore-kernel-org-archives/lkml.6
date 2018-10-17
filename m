Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A0DECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7361C21476
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7361C21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeJRA7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 20:59:17 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51185 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbeJRA7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 20:59:17 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1gCpDS-0001oK-TB; Wed, 17 Oct 2018 19:02:38 +0200
Message-ID: <1539795757.4729.15.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] ASoC: max98927: Add reset-gpio support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Cheng-yi Chiang <cychiang@chromium.org>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ryan Lee <ryans.lee@maximintegrated.com>,
        alsa-devel@alsa-project.org, Dylan Reid <dgreid@chromium.org>,
        tzungbi@chromium.org
Date:   Wed, 17 Oct 2018 19:02:37 +0200
In-Reply-To: <20181012134620.fhhkyvvdgoq4sxqi@flea>
References: <20180912121955.33048-1-cychiang@chromium.org>
         <20180912121955.33048-2-cychiang@chromium.org>
         <20180920161905.GM2471@sirena.org.uk>
         <CAFv8NwLpS9r=jD2wyBsVgJJofkS1xJNo6YssgYXuVHDmGDLogg@mail.gmail.com>
         <1539338716.6204.2.camel@pengutronix.de>
         <20181012134620.fhhkyvvdgoq4sxqi@flea>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Fri, 2018-10-12 at 15:46 +0200, Maxime Ripard wrote:
> On Fri, Oct 12, 2018 at 12:05:16PM +0200, Philipp Zabel wrote:
[...]
> > What I would like better would be to let the consumers keep their reset-
> > gpios bindings, but add an optional hold time override in the DT:
> > 
> > 	c1 {
> > 		reset-gpios = <&gpio0 15 GPIO_ACTIVE_LOW>;
> > 		reset-delays-us = <10000>;
> > 	};
> > 
> > 	c2 {
> > 		reset-gpios = <&gpio0 15 GPIO_ACTIVE_LOW>;
> > 		reset-delays-us = <10000>;
> > 	};
> > 
> > The reset framework could create a reset_control backed by a gpio
> > instead of a rcdev. I have an unfinished patch for this, but without the
> > sharing requirement adding the reset framework abstraction between gpiod
> > and drivers never seemed really worth it.
> 
> I don't remember the exact details of our past discussion, but I
> (still) don't really think that this would work well.

It has been a while :) Thanks for jumping back in.

> I see two main shortcomings with that approach:
> 
>   - I guess that the main reason you want to do that would be to have
>     easy DT backward compatibility.

Yes, that is true. The other reason is that I'd like devices to have a
single binding, regardless of whether somebody decided to put them onto
a board with shared reset lines.

I'd find it hard to advocate for changing the thankfully common case
of device-exclusive reset gpios from:

	some-device {
		reset-gpios = <&gpiox y>;
	};

to:

	rstc: reset-controller {
		compatible = "gpio-reset";
		reset-gpios <&gpiox y>;
	};

	some-device {
		resets = <&rstc 0>;
	};

even for new bindings.

If the reset framework only supports the latter, and not the former,
drivers for devices which already have reset-gpios would have to handle
both reset_control and gpiod functionality, which I think should not be
necessary.

Note that this is not really an argument against a "gpio-reset"
controller driver, but an argument for reset-gpios support integrated
into the reset framework.
My argument against a "gpio-reset" device node in the DT is only that it
is basically a virtual device that would only be used to work around
missing reset-gpios support in the reset framework. Physically, this
"device" consists of no more than a few PCB traces.

>     Yet, the addition of the
>     reset-delay-us would break that compatibility, since drivers that
>     would have been converted now need to have it somehow, but older
>     DTs wouldn't have it

That is why such a property would have to be optional, and the drivers
would have to keep providing the reset delay themselves, as they
currently do when handling GPIOs directly.
It would only serve to override the driver default in case of additional
delay requirements due to board specifics (such as delay elements, or
shared resets).

>   - There's so many variations of the reset-gpios property name that
>     you wouldn't be able to cover all the cases anyhow, at least
>     without breaking the compatibility (again).

This is true, and I do not have a solution for this. Especially for
those cases that don't use gpiod yet.

	of_get_named_gpio(node, "reset-gpio")

is still quite common, but I'd really like on gpiolib for polarity
support.

> But I also see your point, and you're right that converting everyone
> to a gpio-reset node will not happen (even though I'd still really
> like to have that binding).

See above. I'd be a lot less reluctant to support this binding if
somebody could demonstrate a real gpio controlled reset controller
device of some kind. And even then I would not want to have to use
this device just to connect a single GPIO with a single reset input.

> What about having a function that would be called by the consumer to
> instantiate that reset controller from a GPIO for us, instead of
> trying to do it automatically? That function could take the property
> name that holds the GPIO, which would cover the second drawback, and
> the delay, which would cover the first.

I like this idea.

I'd like to avoid having to fall back from gpiod to of_get_named_gpio if
possible, so maybe we'd have to extend gpiolib-of.c with an
of_find_reset_gpio function, as is done for SPI and regulators already.

We probably would have to support delay ranges. I see a lot of
usleep_range calls between reset GPIO toggles in the drivers.

> And in order to cover shared GPIO reset lines, we could just look at
> the one already created by other drivers, and if one has been created,
> we just give the reference to that one instead of creating it.
> 
> Does that make sense?

I'm not quite sure how to match an already requested reset control from
the list given of_node and gpio property name at the moment - this might
involve exporting gpiod_find from gpiolib, but API wise I think this is
a sane proposal.

I would not want to add reset controller devices for each of these GPIO
reset controls, but rather store the gpio_desc reference in the
reset_control instead of the rcdev reference.

regards
Philipp
