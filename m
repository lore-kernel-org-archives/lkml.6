Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE28FC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDEB20824
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DDEB20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbeJZVdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 17:33:55 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53725 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbeJZVdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 17:33:55 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gG1fT-0004EI-2v; Fri, 26 Oct 2018 14:56:47 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gG1fR-0005mx-3I; Fri, 26 Oct 2018 14:56:45 +0200
Date:   Fri, 26 Oct 2018 14:56:45 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Claudiu.Beznea@microchip.com
Cc:     mark.rutland@arm.com, linux-pwm@vger.kernel.org,
        alexandre.belloni@bootlin.com, shc_work@mail.ru, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH v5 0/9] extend PWM framework to support PWM modes
Message-ID: <20181026125644.ivfw6xefc7wqt2vw@pengutronix.de>
References: <1535461286-12308-1-git-send-email-claudiu.beznea@microchip.com>
 <20181022082910.uw6i64h3w7jwxyx5@pengutronix.de>
 <f19251eb-80e1-aea1-2d8a-971fe53242d0@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f19251eb-80e1-aea1-2d8a-971fe53242d0@microchip.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Claudiu,

On Fri, Oct 26, 2018 at 10:44:43AM +0000, Claudiu.Beznea@microchip.com wrote:
> Thank you for your inputs and sorry for the late response. Please see my
> answers inline.

No problems, I didn't held my breath :-)

> On 22.10.2018 11:29, Uwe Kleine-König wrote:
> > On Tue, Aug 28, 2018 at 04:01:17PM +0300, Claudiu Beznea wrote:
> >> Since PWMs with more than one output per channel could be used as one
> >> output PWM the normal mode is the default mode for all PWMs (if not
> >> specified otherwise).
> >>
> >> Complementary mode - for PWM channels with two outputs; output waveforms
> >> for a PWM channel in complementary mode looks line this:
> >>              __    __    __    __
> >>     PWMH1 __|  |__|  |__|  |__|  |__
> >>           __    __    __    __    __
> >>     PWML1   |__|  |__|  |__|  |__|
> >>             <--T-->
> >>
> >>     Where T is the signal period.
> > 
> > So this translates to (I think):
> > 
> >            __       __       __       __       __
> >  PWMH   __/  \_____/  \_____/  \_____/  \_____/  \_____/
> >         __    _____    _____    _____    _____    _____
> >  PWML     \__/     \__/     \__/     \__/     \__/     \
> >           ^        ^        ^        ^        ^        ^
> > 
> > That is PWML always pulls in the opposite direction of PWMH. Maybe we
> > could come up with better terms than PWMH and PWML (which might be
> > specific for the Atmel implementation?).
> 
> Yes, this is Atmel implementation naming.
> 
> > Maybe "normal" and
> > "complement"?
> 
> I will think about it try to come with new naming. Normal and Complement
> may be confusing for users with regards to PWM modes.
> 
> > 
> >> Push-pull mode - for PWM channels with two outputs; output waveforms for a
> >> PWM channel in push-pull mode with normal polarity looks like this:
> >>             __          __
> >>     PWMH __|  |________|  |________
> >>                   __          __
> >>     PWML ________|  |________|  |__
> >>            <--T-->
> > 
> > That again with the alternative display method and duty cycle 1/3:
> > 
> >            __                __                __
> >  PWMA   __/  \______________/  \______________/  \______
> >                     __                __
> >  PWMB   ___________/  \______________/  \______________/
> >           ^        ^        ^        ^        ^        ^
> Ok.
> 
> > That is PWMA and PWMB are active only every 2nd period taking alternate
> > turns, right?
> 
> Yes.
> 
> > 
> > 
> >>     If polarity is inversed:
> >>          __    ________    ________
> >>     PWMH   |__|        |__|
> >>          ________    ________    __
> >>     PWML         |__|        |__|
> >>            <--T-->
> > 
> > That's again with duty cycle 1/3:
> > 
> >         __    ______________    ______________    ______
> >  PWMA     \__/              \__/              \__/
> >         ___________    ______________    ______________
> >  PWMB              \__/              \__/              \
> >           ^        ^        ^        ^        ^        ^
> > 
> 
> Ok.
> 
> > Given that the start of period isn't externally visible this is
> > equivalent to using a duty cycle 2/3 and not inverting which results in:
> > 
> >         __    ______________    ______________    ______
> >  PWMA     \__/              \__/              \__/
> >         ___________    ______________    ______________
> >  PWMB              \__/              \__/              \
> >              ^        ^        ^        ^        ^
> > 
> > I would really like if a more detailed description of the modes would be
> > created as part of this series.
> 
> Sure, I will try to document it better.

Note here I just leaked my belief that the PWM framework shouldn't
necessarily expose inversion to users which is part of my discussion
with Thierry. I think it would be sensible to drop it here.

> > Currently there are a few implied
> > properties hidden in the PWM API (unrelated to this series) which I try
> > to resolve together with Thierry. Getting this documented right from the
> > start would be great here.
> 
> Could you tell me if you want something specific to be touch as part of
> documentation process for these PWM modes?

At least having something about the expectations in Documenation/ would
be great.

> > I didn't look in detail into the driver implementation, but from the
> > PWMs implemented in the STM32F4 family I would have chosen a different
> > model which makes me wonder if we should stick to a more general way to
> > describe two outputs from a single PWM channel.
> > 
> > I would use four values with nanosecond resolution to describe these:
> > 
> >   .period
> >   .duty_cycle
> >   .alt_duty_cycle
> >   .alt_offset
> > 
> > period and duty_cycle is as before for the primary output and then the
> > alt_* values describe offset and duty cycle of the secondary output.
> > 
> > What you called "normal mode" would then be specified using
> > 
> >   .period = $period
> >   .duty_cycle = $duty_cycle
> >   .alt_duty_cycle = 0
> >   .alt_offset = dontcare
> > 
> > Your "push pull mode" would be:
> > 
> >   .period = 2 * $period
> >   .duty_cycle = $duty_cycle
> >   .alt_duty_cycle = $duty_cycle
> >   .alt_offset = $period
> > 
> > and complementary mode would be specified using:
> > 
> >   .period = $period
> >   .duty_cycle = $duty_cycle
> >   .alt_duty_cycle = $period - $duty_cycle
> >   .alt_offset = $duty_cycle
> > 
> 
> On Atmel PWM controller the push-pull mode is hardware generated based on
> period and duty cycles that are setup for only one channel. The hardware
> will take care of the synchronization b/w the outputs so that the push-pull
> characteristic to be generated.
> 
> Having different configuration for every output part of the push-pull
> waveform will allow users to generate every kind of outputs. But for IPs
> that are capable of push-pull or complementary modes the generation of the
> 2 outputs are done in hardware (true in case of Atmel PWM controller). In
> case of STM32F4 as far as I can see from [1] "The advanced-control timers
> (TIM1 and TIM8 ) can output two complementary signals and
> manage the switching-off and the switching-on instants of the outputs."
> Maybe, in this case, if there are 2 hardware blocks that could be synced to
> work together, e.g. in complementary mode, the setting of these two timers
> should be done in driver so that the hardware blocks to be configured
> together, atomically, so that the complementary characteristics to be obtained.

The upside I see in my approach with .alt_duty_cycle and .alt_offset
over your .mode is that it allows to describe more use-cases. If I
wanted to support complementary with dead-time I'd need another member
in pwm_state to specify the dead time. Then the next controller can only
add dead time on one end of secondary output needing yet another mode
enum. With my approach I think you can specify all sensible(TM)
waveforms already now. Then a driver must not be adapted again when
someone adds support for another mode.

The downside is that if your PWM only supports complementary mode with
no dead-time you have to find out from .alt_duty_cycle and .alt_offset
that the specified wave form is indeed matching complementary mode. From
from the framework's POV this is more elegant though (but YMMV).

> > With this abstraction stuff like "complementary output with dead-time
> > insertion" (something like:
> > 
> >            __                __                __
> >  PWMA   __/  \______________/  \______________/  \______
> >                 __________        __________          __
> >  PWMB   _______/          \______/          \______/
> >           ^                 ^                 ^
> > 
> > ) could be modelled.
> 
> Same for this, my opinion is that we should implement generic things in
> core and drivers should configure properly the IP so that it generates the
> proper signals.

This is common to both our approaches. Just the way the PWM user
specifies his/her wishes (and so the input for hw drivers) is different.
 
> >> The PWM working modes are per PWM channel registered as PWM's capabilities.
> >> The driver registers itself to PWM core a get_caps() function, in
> >> struct pwm_ops, that will be used by PWM core to retrieve PWM capabilities.
> >> If this function is not registered in driver's probe, a default function
> >> will be used to retrieve PWM capabilities. Currently, the default
> >> capabilities includes only PWM normal mode.
> > 
> > In the i2c framework this is a function, too, and I wonder if simplicity
> > is better served when this is just a flags member in the pwm_ops
> > structure.
> 
> Thierry proposed this so that we could retrieve capabilities per PWM channel.

I don't have a complete overview over the different hardware
implementations, but I'd expect that if two different implementations
share the operations then the return value of .get_caps is shared by
both. As long this is the case not introducing a callback for that is
the easier path. Adding a callback later when (and if) this is required
is trivial then.
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
