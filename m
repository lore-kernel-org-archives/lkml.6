Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397DBC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010772086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:05:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010772086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbeJLRg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:36:58 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45547 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbeJLRg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:36:58 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1gAuJp-0001by-1k; Fri, 12 Oct 2018 12:05:17 +0200
Message-ID: <1539338716.6204.2.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] ASoC: max98927: Add reset-gpio support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Cheng-yi Chiang <cychiang@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ryan Lee <ryans.lee@maximintegrated.com>,
        alsa-devel@alsa-project.org, Dylan Reid <dgreid@chromium.org>,
        tzungbi@chromium.org
Date:   Fri, 12 Oct 2018 12:05:16 +0200
In-Reply-To: <CAFv8NwLpS9r=jD2wyBsVgJJofkS1xJNo6YssgYXuVHDmGDLogg@mail.gmail.com>
References: <20180912121955.33048-1-cychiang@chromium.org>
         <20180912121955.33048-2-cychiang@chromium.org>
         <20180920161905.GM2471@sirena.org.uk>
         <CAFv8NwLpS9r=jD2wyBsVgJJofkS1xJNo6YssgYXuVHDmGDLogg@mail.gmail.com>
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

Hi Cheng-yi,

[adding Maxime, devicetree to Cc:, the old discussion about GPIO resets
in [4] has never been resolved]

On Tue, 2018-10-09 at 21:46 +0800, Cheng-yi Chiang wrote:
> +reset controller maintainer Philipp
> 
> Hi Mark,
>   Sorry for the late reply. It took me a while to investigate reset
> controller and its possible usage. I would like to figure out the
> proper way of reset handling because it is common to have a shared
> reset line for two max98927 codecs for left and right channels.
> Without supporting this usage, a simple reset-gpios change for single
> codec would not be useful, and perhaps will be duplicated if reset
> controller is a better way.
> 
> Hi Philipp,
>   I would like to seek your advice about whether we can use reset
> controller to support the use case where multiple devices share the
> same reset line.
>
> Let me summarize the use case:
> There are two max98927 codecs sharing the same reset line.
> The reset line is controlled by a GPIO.
> The goal is to toggle reset line once and only once.
> 
> There was a similar scenario in tlv320aic3x codec driver [1].
> A static list is used in the codec driver so probe function can know
> whether it is needed to toggle reset line.
> Mark pointed out that it is not suitable to handle the shared reset
> line inside codec driver.
> A point is that this only works for multiple devices using the same
> device driver.
> He suggested to look into reset controller so I searched through the
> usage for common reset line.
>
> Here I found a shared reset line use case [2].
> With the patch [2], reset_control_reset can support this “reset once
> and for all” use case.

This patch was applied as 7da33a37b48f. So the reset framework has
support for shared reset controls where only the first reset request
actually causes a reset pulse, and all others are no-ops.

> However, I found that there are some missing pieces:
> 
> Let’s assume there are two codecs c1 and c2 sharing a reset line
> controlled by GPIO.
> 
> c1’s spec:
> Hold time: The minimum time to assert the reset line is t_a1.
> Release time: The minimum time to access the chip after deassert of
> the reset line is t_d1.
> 
> c2’s spec:
> Hold time: The minimum time to assert the reset line is t_a2.
> Release time: The minimum time to access the chip after deassert of
> the reset line is t_d2.
> 
> For both c1 and c2 to work properly, we need a reset controller that
> can assert the reset line for
> T = max(t_a1, t_a2).
> 
> 1. We need reset controller to support GPIO.

I still don't like the idea of describing a separate gpio reset
controller "device" in DT very much, as this is really just a software
abstraction, not actual hardware. For example:

	gpio_reset: reset-controller {
		compatible = "gpio-reset";
		reset-gpios = <&gpio0 15 GPIO_ACTIVE_LOW>,
			      <&gpio1
16 GPIO_ACTIVE_HIGH>;
		reset-delays-us = <10000>, <500>;
	};

	c1 {
		resets = <&gpio_reset 0>; /* maps to <&gpio0 15 ...> */
	};

	c2 {
		resets = <&gpio_reset 0>;
	};

What I would like better would be to let the consumers keep their reset-
gpios bindings, but add an optional hold time override in the DT:

	c1 {
		reset-gpios = <&gpio0 15 GPIO_ACTIVE_LOW>;
		reset-delays-us = <10000>;
	};

	c2 {
		reset-gpios = <&gpio0 15 GPIO_ACTIVE_LOW>;
		re
set-delays-us = <10000>;
	};

The reset framework could create a reset_control backed by a gpio
instead of a rcdev. I have an unfinished patch for this, but without the
sharing requirement adding the reset framework abstraction between gpiod
and drivers never seemed really worth it.

> 2. We need to specify hold time T to reset controller in device tree
> so it knows that it needs hold reset line for that long in its
> implementation of reset_control_reset.

Agreed. Ideally, I'd like to make this optional, and have the drivers
continue to provide the hold time if they think they know it.

> 3. Assuming we have 1 and 2 in place. In codec driver of c1, it can
> call reset_control_reset and wait for t_a1 + t_d1. In codec driver of
> c2, it can call reset_control_reset and wait for t_a2 + t_d2.

The reset framework should wait for the configured assertion time,
max(t_a1, t_a2). The drivers only should only have to wait for
t_d1 / t_d2 after reset_control_reset returns.

>     We need to wait for hold time + release time because
> triggered_count is increased before reset ops is called. When the
> second driver finds that triggered_count is 1 and skip the real reset
> operation, reset ops might just begin doing its work a short time ago.

That is a good point. Maybe the reset framework should just wait for the
hold time even for the second reset. Another possibility would be to
serialize them with a mutex.

>     I am not sure whether we would need a flag in reset controller to
> mark that "reset is done". When driver sees this flag is done, it can
> just wait for release time instead of hold time + release time.

Let's not complicate the drivers with this too much. I think
reset_control_reset should guarantee that the reset line is not asserted
anymore upon return.

> And I found that you already solved 1 and mentioned the
> possible usage of 2 in [3].
> There were discussion about letting device driver to deal with
> reset-gpios by itself in [4], but it seems that reset controller can
> better deal with the shared reset line situation.
> Maybe we could revive the patch of GPIO support for reset controller ?

The discussion with Maxime in [4] hasn't really been resolved. I still
think the reset-gpios property should be kept, and the reset framework
could adapt to it. This is something the device tree maintainers' input
would be welcome on.

> Please let me know what direction I should look into.
> Thanks a lot!
> 
> [1] http://mailman.alsa-project.org/pipermail/alsa-devel/2010-November/033246.html
> https://patchwork.kernel.org/patch/9424123/
> 
> [2] https://patchwork.kernel.org/patch/9424123/
> 
> [3] https://lore.kernel.org/patchwork/patch/455839/
> 
> [4] https://patchwork.kernel.org/patch/3978121/

regards
Philipp
