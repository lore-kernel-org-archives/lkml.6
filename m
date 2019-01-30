Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5BBC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2FE2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbfA3Pja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:39:30 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41557 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfA3Pj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:39:29 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gorxT-0003O4-Cs; Wed, 30 Jan 2019 16:39:23 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gorxR-00078q-30; Wed, 30 Jan 2019 16:39:21 +0100
Date:   Wed, 30 Jan 2019 16:39:21 +0100
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
Message-ID: <20190130153921.met3kipvdsoctjoa@pengutronix.de>
References: <1544103655-104466-1-git-send-email-michal.vokac@ysoft.com>
 <1544103655-104466-3-git-send-email-michal.vokac@ysoft.com>
 <20181212080154.kcfh57mulypwuscu@pengutronix.de>
 <52ed0614-d1f5-81cb-3b17-8eb137967872@ysoft.com>
 <20181212121255.yg6b4pw7qord7ebi@pengutronix.de>
 <4b0356b7-bc7d-a026-ac90-3f0c5754ed29@ysoft.com>
 <20190124092215.zbu62lhxf667rzvs@pengutronix.de>
 <4004896e-34fc-7160-2f21-30280d96f750@ysoft.com>
 <20190124104435.e6paqwcuz3hizwnv@pengutronix.de>
 <72bad040-05f4-607f-f210-468e46ea3228@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72bad040-05f4-607f-f210-468e46ea3228@ysoft.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michal,

On Wed, Jan 30, 2019 at 03:42:29PM +0100, Michal Vokáč wrote:
> On 24.1.2019 11:44, Uwe Kleine-König wrote:
> > On Thu, Jan 24, 2019 at 11:12:12AM +0100, Michal Vokáč wrote:
> > > On 24.1.2019 10:22, Uwe Kleine-König wrote:
> > > > I think it might be beneficial to allow (or require) that disable acts
> > > > immediately. But this is not how it used to be and in my discussion with
> > > > Thierry (IIRC) he required to complete the currently running period.
> > > 
> > > I am confused here. IFAIK it always used to be that:
> > > 
> > > 	pwm_apply_state(pwm, { .enabled = 0 });
> > > 
> > > immediately stops the PWM with:
> > > 
> > > 	writel(0, imx->mmio_base + MX3_PWMCR);
> > > 
> > > regardless of the period (for pwm-imx).
> > 
> > Then is is a bug since forever (well, or a fact that resulted from the
> > intended semantic not being documented and the driver author not caring
> > or knowing better).
> 
> Hi Uwe, I skimmed all the PWM drivers trying to find out how others are
> waiting for the end of a period before disabling PWM.
> 
> There is 50 PWM drivers in total and I could find only two drivers that
> do something that resembles waiting for an end of a period:
> 
>  - pwm-atmel.c
>    https://elixir.bootlin.com/linux/v5.0-rc3/source/drivers/pwm/pwm-atmel.c#L176
> 	
>  - pwm-sun4i.c
>    https://elixir.bootlin.com/linux/v5.0-rc3/source/drivers/pwm/pwm-sun4i.c#L284

There are quite some drivers known (to me) being buggy here. My feeling
is that Thierry doesn't share that impression and I think the only
reasonable path forward is to first fix the requirements for drivers and
when this is done, look at the implementations and fix them or conclude
that the requirements are not practical and shift them accordingly.

From my POV the situation is as follows: I suggested a few changes that
seemed reasonable to me (e.g.: don't rely on the pin state to be
inactive after disable; don't rely on a driver to block in .apply until
the new configuration is active; thought about dropping .disable
altogether) and Thierry shot them down indicating that he is not willing
to change the API and all affected users for only one or a few
implementations. My consequence is to be strict about the requirements
because that's the only way to show the resulting pain (or see there
isn't so much pain).

> I did not delve into that too much but I believe there are some HW
> requirements on those platforms to stop the PWM that way. Others
> simply stop the PWM straight away. So I am confused even more
> and wonder where your requirements came from?

I'm aware that many drivers don't adhere to these requirements. IMHO
this is related to the poor situation regarding documentation for
pwm-driver authors and lack of time for in-deep reviews by Thierry.
Never the less: The requirement to complete the currently running period
comes from Thierry. There is a patch by me waiting for review that
targets improving the documentation and you already have to suffer from
my plan to spend some time on pwm-reviews :-)

> Anyway, as I could not find any real example I tried to solve it
> according to your earlier suggestion. That is configure duty_cycle=0
> and some time later disable PWM.
> 
> It generates additional problems. The PWM block has a FIFO with four
> slots. Before adding the sample with duty cycle=0 into the FIFO it
> is wise to wait for a free slot in the FIFO. Then when the sample is
> added it may actually happen that the sample is the fourth in the
> FIFO. So it may take up to four periods until we can disable the PWM.
> These four periods can take up to 16s. Hmmm :(

No it cannot. Because if you put a new configuration into the FIFO you
have to block until the requested configuration is active, so it must
not happen that you hit the FIFO with 4 busy entries. (Unless a user
calls pwm_apply_state() in four contexts in parallel, which should not
happen. And if it does, we should implement serialization in the
pwm-framework such that pwm-drivers doesn't need to care.)

> I agree there are bugs in the driver and it is far from providing
> complete support of the i.MX PWM HW. Still, I believe those are totally
> independent problems from the pinctrl stuff and so should not block
> the discussion/inclusion of this series.

I think while there are people who care about a driver, the known
problems should be addressed before a change is "sneaked" in that makes
the contributor happy and care about other stuff.
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
