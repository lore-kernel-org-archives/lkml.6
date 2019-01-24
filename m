Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBCBC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9730218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfAXJWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:22:25 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40231 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfAXJWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 04:22:24 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gmbDG-0000mV-QO; Thu, 24 Jan 2019 10:22:18 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gmbDD-0006XB-Is; Thu, 24 Jan 2019 10:22:15 +0100
Date:   Thu, 24 Jan 2019 10:22:15 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Majewski <l.majewski@majess.pl>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@karo-electronics.de>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH v3 2/2] pwm: imx: Configure output to GPIO in
 disabled state
Message-ID: <20190124092215.zbu62lhxf667rzvs@pengutronix.de>
References: <1544103655-104466-1-git-send-email-michal.vokac@ysoft.com>
 <1544103655-104466-3-git-send-email-michal.vokac@ysoft.com>
 <20181212080154.kcfh57mulypwuscu@pengutronix.de>
 <52ed0614-d1f5-81cb-3b17-8eb137967872@ysoft.com>
 <20181212121255.yg6b4pw7qord7ebi@pengutronix.de>
 <4b0356b7-bc7d-a026-ac90-3f0c5754ed29@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b0356b7-bc7d-a026-ac90-3f0c5754ed29@ysoft.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 09:59:47AM +0100, Michal Vokáč wrote:
> On 12.12.2018 13:12, Uwe Kleine-König wrote:
> > On Wed, Dec 12, 2018 at 11:42:17AM +0000, Vokáč Michal wrote:
> > > On 12.12.2018 09:01, Uwe Kleine-König wrote:
> > > > On Thu, Dec 06, 2018 at 01:41:31PM +0000, Vokáč Michal wrote:
> > > > > Normally the PWM output is held LOW when PWM is disabled. This can cause
> > > > > problems when inverted PWM signal polarity is needed. With this behavior
> > > > > the connected circuit is fed by 100% duty cycle instead of being shut-off.
> > > > > 
> > > > > Allow users to define a "pwm" and a "gpio" pinctrl states. The pwm pinctrl
> > > > > state is selected when PWM is enabled and the gpio pinctrl state is
> > > > > selected when PWM is disabled. In the gpio state the new pwm-gpios GPIO is
> > > > > configured as input and the internal pull-up resistor is used to pull the
> > > > > output level high.
> > > > > 
> > > > > If all the pinctrl states and the pwm-gpios GPIO are not correctly
> > > > > specified in DT the PWM work as usual.
> > > > > 
> > > > > As an example, with this patch a PWM controlled backlight with inversed
> > > > > signal polarity can be used in full brightness range. Without this patch
> > > > > the backlight can not be turned off as brightness = 0 disables the PWM
> > > > > and that in turn set PWM output LOW, that is full brightness.
> > > > > 
> > > > > Inverted output of the PWM with "default" and with "pwm"+"gpio" pinctrl:
> > > > > 
> > > > > +--------------+------------+---------------+----------- +-------------+
> > > > > | After reset  | Bootloader |   PWM probe   |     PWM    |     PWM     |
> > > > > | 100k pull-up |            |               | enable 30% |   disable   |
> > > > > +--------------+------------+---------------+------------+-------------+
> > > > > | pinctrl      |    none    |    default    |   default  |   default   |
> > > > > | out H   __________________                   __   __                 |
> > > > > | out L                     \_________________/  \_/  \_/\____________ |
> > > > > |                                           ^    ^    ^                |
> > > > > +--------------+------------+---------------+------------+-------------+
> > > > > | pinctrl      |    none    |      gpio     |     pwm    |     gpio    |
> > > > > | out H   __________________________________   __   __   _____________ |
> > > > > | out L                                     \_/  \_/  \_/              |
> > > > > |                                           ^    ^    ^                |
> > > > > +----------------------------------------------------------------------+
> > > > > 
> > > > > Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> > > > > ---
> > > > > Changes in v3:
> > > > >    - Commit message update.
> > > > >    - Minor fix in code comment (Uwe)
> > > > >    - Align function arguments to the opening parentheses. (Uwe)
> > > > >    - Do not test devm_pinctrl_get for NULL. (Thierry)
> > > > >    - Convert all messages to dev_dbg() (Thierry)
> > > > >    - Do not actively drive the pin in gpio state. Configure it as input
> > > > >      and rely solely on the internal pull-up. (Thierry)
> > > > > 
> > > > > Changes in v2:
> > > > >    - Utilize the "pwm" and "gpio" pinctrl states.
> > > > >    - Use the pwm-gpios signal to drive the output in "gpio" pinctrl state.
> > > > >    - Select the right pinctrl state in probe.
> > > > > 
> > > > >    drivers/pwm/pwm-imx.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++
> > > > >    1 file changed, 77 insertions(+)
> > > > > 
> > > 
> > > [ snip ]
> > > 
> > > > On thing I noticed while looking at the rcar driver is: This doesn't
> > > > wait for the current period to end. Is this supposed to happen? Also for
> > > > the enable case the hardware is configured for the desired duty cycle
> > > > and only then the pinctrl is switched to pwm. Both might result in a
> > > > spike that is not desired.
> > > 
> > > The behavior should not change from how imx-pwm was working before.
> > > When PWM is disabled the output is immediately gated off (put into
> > > the idle state) independently on the period. I measured this.
> > 
> > Oh really, I wasn't aware of that. This is another bug in the imx pwm
> > then (I think).
> 
> I kind of expect that when hit a disable button the output is immediately
> put into the idle state. To me it does not seem appropriate to wait the
> whole period, or even just the active part of the period. If duty=100%
> and period=4s (current maximum), in the worst case you would have to wait
> 4s until you stop the PWM. Quite a long time of driving something you
> actually wanted to be shut off.

I think it might be beneficial to allow (or require) that disable acts
immediately. But this is not how it used to be and in my discussion with
Thierry (IIRC) he required to complete the currently running period.

Then if a user requires a "smooth disable" (i.e. with completing the
currently running period) they can do:

	pwm_apply_state(pwm, { .duty_cycle = 0, ... });
	pwm_apply_state(pwm, { .enabled = 0 });

to get the delayed disable.

But having said this, this should be a concious decision with the
requirements properly documented and the drivers users reviewed and adapted.

> > > For the enable case you would certainly not get any additional spikes.
> > 
> > Yes, there is a possibility for a spike: If you configure for say 40%:
> >                    _    _
> > pwm output   : ___/ \__/ \__
> > muxing       : GPIO| PWM_
> > actual output: ____/\__/ \__
> 
> OK, you are right.
> 
> > > The worst thing that may happen is that the first period will be
> > > slightly shorter depending on how long it takes to test the pinctrl
> > > and switch the muxing. And this is unavoidable, it would happen even
> > > if you wait for the start of a period. The test + muxing still takes
> > > some time.
> > 
> > You could first configure for duty_cycle 0 and a short period, then mux
> > to PWM and then configure the correct duty cycle. Ditto for disable.
> 
> I agree it can be solved for the enable case but I do not see the
> point in doing so for the disable case. Can you elaborate on how it
> could be useful?

Assuming we stick to "disable should complete the currently running
period" it is all about preventing spikes. So if you switch the mux from
PWM to GPIO when the output just raised, that might (depending on the
use case) be bad and so it should be possible for the user to prevent
this.

> This is what I came up with:
> 
> [...]
> 
> What do you think?

I'm missing context. Your patch is on top of your last patch I assume.
Would you mind to send the squashed result?

(I'm unsure when I find time (and nerve) for a proper review, but I will
try to at least look over your suggestions.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
