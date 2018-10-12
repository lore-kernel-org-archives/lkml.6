Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A232CC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A9C20835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56A9C20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbeJLVSy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 17:18:54 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49904 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728574AbeJLVSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 17:18:53 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8D70B207B4; Fri, 12 Oct 2018 15:46:19 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-7-245.w90-88.abo.wanadoo.fr [90.88.129.245])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5A9A720701;
        Fri, 12 Oct 2018 15:46:19 +0200 (CEST)
Date:   Fri, 12 Oct 2018 15:46:20 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Cheng-yi Chiang <cychiang@chromium.org>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ryan Lee <ryans.lee@maximintegrated.com>,
        alsa-devel@alsa-project.org, Dylan Reid <dgreid@chromium.org>,
        tzungbi@chromium.org
Subject: Re: [PATCH 2/2] ASoC: max98927: Add reset-gpio support
Message-ID: <20181012134620.fhhkyvvdgoq4sxqi@flea>
References: <20180912121955.33048-1-cychiang@chromium.org>
 <20180912121955.33048-2-cychiang@chromium.org>
 <20180920161905.GM2471@sirena.org.uk>
 <CAFv8NwLpS9r=jD2wyBsVgJJofkS1xJNo6YssgYXuVHDmGDLogg@mail.gmail.com>
 <1539338716.6204.2.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1539338716.6204.2.camel@pengutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 12:05:16PM +0200, Philipp Zabel wrote:
> Hi Cheng-yi,
> 
> [adding Maxime, devicetree to Cc:, the old discussion about GPIO resets
> in [4] has never been resolved]
> 
> On Tue, 2018-10-09 at 21:46 +0800, Cheng-yi Chiang wrote:
> > +reset controller maintainer Philipp
> > 
> > Hi Mark,
> >   Sorry for the late reply. It took me a while to investigate reset
> > controller and its possible usage. I would like to figure out the
> > proper way of reset handling because it is common to have a shared
> > reset line for two max98927 codecs for left and right channels.
> > Without supporting this usage, a simple reset-gpios change for single
> > codec would not be useful, and perhaps will be duplicated if reset
> > controller is a better way.
> > 
> > Hi Philipp,
> >   I would like to seek your advice about whether we can use reset
> > controller to support the use case where multiple devices share the
> > same reset line.
> >
> > Let me summarize the use case:
> > There are two max98927 codecs sharing the same reset line.
> > The reset line is controlled by a GPIO.
> > The goal is to toggle reset line once and only once.
> > 
> > There was a similar scenario in tlv320aic3x codec driver [1].
> > A static list is used in the codec driver so probe function can know
> > whether it is needed to toggle reset line.
> > Mark pointed out that it is not suitable to handle the shared reset
> > line inside codec driver.
> > A point is that this only works for multiple devices using the same
> > device driver.
> > He suggested to look into reset controller so I searched through the
> > usage for common reset line.
> >
> > Here I found a shared reset line use case [2].
> > With the patch [2], reset_control_reset can support this “reset once
> > and for all” use case.
> 
> This patch was applied as 7da33a37b48f. So the reset framework has
> support for shared reset controls where only the first reset request
> actually causes a reset pulse, and all others are no-ops.
> 
> > However, I found that there are some missing pieces:
> > 
> > Let’s assume there are two codecs c1 and c2 sharing a reset line
> > controlled by GPIO.
> > 
> > c1’s spec:
> > Hold time: The minimum time to assert the reset line is t_a1.
> > Release time: The minimum time to access the chip after deassert of
> > the reset line is t_d1.
> > 
> > c2’s spec:
> > Hold time: The minimum time to assert the reset line is t_a2.
> > Release time: The minimum time to access the chip after deassert of
> > the reset line is t_d2.
> > 
> > For both c1 and c2 to work properly, we need a reset controller that
> > can assert the reset line for
> > T = max(t_a1, t_a2).
> > 
> > 1. We need reset controller to support GPIO.
> 
> I still don't like the idea of describing a separate gpio reset
> controller "device" in DT very much, as this is really just a software
> abstraction, not actual hardware. For example:
> 
> 	gpio_reset: reset-controller {
> 		compatible = "gpio-reset";
> 		reset-gpios = <&gpio0 15 GPIO_ACTIVE_LOW>,
> 			      <&gpio1
> 16 GPIO_ACTIVE_HIGH>;
> 		reset-delays-us = <10000>, <500>;
> 	};
> 
> 	c1 {
> 		resets = <&gpio_reset 0>; /* maps to <&gpio0 15 ...> */
> 	};
> 
> 	c2 {
> 		resets = <&gpio_reset 0>;
> 	};
> 
> What I would like better would be to let the consumers keep their reset-
> gpios bindings, but add an optional hold time override in the DT:
> 
> 	c1 {
> 		reset-gpios = <&gpio0 15 GPIO_ACTIVE_LOW>;
> 		reset-delays-us = <10000>;
> 	};
> 
> 	c2 {
> 		reset-gpios = <&gpio0 15 GPIO_ACTIVE_LOW>;
> 		reset-delays-us = <10000>;
> 	};
> 
> The reset framework could create a reset_control backed by a gpio
> instead of a rcdev. I have an unfinished patch for this, but without the
> sharing requirement adding the reset framework abstraction between gpiod
> and drivers never seemed really worth it.

I don't remember the exact details of our past discussion, but I
(still) don't really think that this would work well. I see two main
shortcomings with that approach:

  - I guess that the main reason you want to do that would be to have
    easy DT backward compatibility. Yet, the addition of the
    reset-delay-us would break that compatibility, since drivers that
    would have been converted now need to have it somehow, but older
    DTs wouldn't have it

  - There's so many variations of the reset-gpios property name that
    you wouldn't be able to cover all the cases anyhow, at least
    without breaking the compatibility (again).

But I also see your point, and you're right that converting everyone
to a gpio-reset node will not happen (even though I'd still really
like to have that binding).

What about having a function that would be called by the consumer to
instantiate that reset controller from a GPIO for us, instead of
trying to do it automatically? That function could take the property
name that holds the GPIO, which would cover the second drawback, and
the delay, which would cover the first.

And in order to cover shared GPIO reset lines, we could just look at
the one already created by other drivers, and if one has been created,
we just give the reference to that one instead of creating it.

Does that make sense?

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
