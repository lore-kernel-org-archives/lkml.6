Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D66C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 13:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF60B217F9
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 13:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="jjmkWitk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbeLPNgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 08:36:15 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:38846 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729822AbeLPNgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 08:36:15 -0500
Date:   Sun, 16 Dec 2018 14:36:03 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v8 12/26] pwm: jz4740: Allow selection of PWM channels 0
 and 1
To:     Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, od@zcrc.me
Message-Id: <1544967364.1649.0@crapouillou.net>
In-Reply-To: <20181213203243.ucjwqtkyp6aboxp4@pengutronix.de>
References: <20181212220922.18759-1-paul@crapouillou.net>
        <20181212220922.18759-13-paul@crapouillou.net>
        <20181213091822.r5ilpsllfhzaiqw4@pengutronix.de>
        <1544709511.18952.0@crapouillou.net>
        <20181213203243.ucjwqtkyp6aboxp4@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1544967370; bh=EpvwbTzVnoITU+649SqQ6u7xrC4bWXqNFlURw2eu7A8=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=jjmkWitk8ktM+EB+a7sSlaUUhAWz55Y89wD/RHBZ3mODykJ+kVxewxE72no6ys7AI0PiSHB6T6NlQYnodpoQ5dM61DNzyeqm8U2xhiA/QPa9GCIXYXAUwwrfwz/2FvUhUbTW3nSqx2XXqsJMYu/DlVRsn3YhzLGoXBB2zLdPZt0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le jeu. 13 d=E9c. 2018 =E0 21:32, Uwe Kleine-K=F6nig=20
<u.kleine-koenig@pengutronix.de> a =E9crit :
> On Thu, Dec 13, 2018 at 02:58:31PM +0100, Paul Cercueil wrote:
>>  Hi,
>>=20
>>  Le jeu. 13 d=E9c. 2018 =E0 10:18, Uwe Kleine-K=F6nig
>>  <u.kleine-koenig@pengutronix.de> a =E9crit :
>>  > On Wed, Dec 12, 2018 at 11:09:07PM +0100, Paul Cercueil wrote:
>>  > >  The TCU channels 0 and 1 were previously reserved for system=20
>> tasks,
>>  > > and
>>  > >  thus unavailable for PWM.
>>  > >
>>  > >  The driver will now only allow a PWM channel to be requested if
>>  > > memory
>>  > >  resources corresponding to the register area of the channel=20
>> were
>>  > >  supplied to the driver. This allows the TCU channels to be=20
>> reserved
>>  > > for
>>  > >  system tasks from within the devicetree.
>>  > >
>>  > >  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  >
>>  > While there is someone caring for this driver I'd like to=20
>> complete (a
>>  > bit) my picture about the different capabilities and specialities=20
>> of the
>>  > supported PWMs. So I have a few questions:
>>  >
>>  > Is there a publicly available reference manual for this device?=20
>> (If
>>  > yes, adding a link to the driver would be great.)
>>=20
>>  I have them here: https://zcrc.me/~paul/jz_docs/
>=20
> Is this link good enough to add it to the driver? From a quick view=20
> I'd
> say this is another pwm implementation that gets active on=20
> pwm_disable().
> Can you confirm this?

It's my website, so if these get moved, I can update the link.

What do you mean it gets active on pwm_disable()? If pwm_disable() gets=20
called
the PWM line goes back to inactive state, which is what it should do.

>>  > jz4740_pwm_config looks as if the currently running period isn't
>>  > completed before the new config is in effect. Is that correct? If=20
>> yes,
>>  > can this be fixed? A similar question for set_polarity: Does=20
>> setting the
>>  > JZ_TIMER_CTRL_PWM_ACTIVE_LOW bit in the control register take=20
>> effect
>>  > immediately or is this shadowed until the next period starts?
>>=20
>>  I don't really know. We only use this driver for a rumble motor and
>>  backlight.
>>  Somebody would have to check with a logic analyzer.
>=20
> depending on the possible timings you might also be able to test this
> e.g. by setting:
>=20
> 	duty_cycle=3D1ms, period=3D5s
>=20
> and then
>=20
> 	duty_cycle=3D5s, period=3D5s
>=20
> . If the implementation is right your display should be dark for=20
> nearly
> 5 seconds. (And the second call to pwm_apply should also block until=20
> the
> display is on.)

So it switches to full ON as soon as I set the duty cycle to 5s. Same=20
for
the polarity, it is updated as soon as the register is written. So the
registers are not shadowed.

>>  > How does the device's output behave after the PWM is disabled?
>>  > Does it complete the currently running period? How does the output
>>  > behave then? (active/inactive/high/low/high-z?)
>>=20
>>  There's a bit to toggle between "graceful" shutdown (bit clear) and=20
>> "abrupt"
>>  shutdown (bit set). TCSR bit 9. I think that graceful shutdown will=20
>> complete
>>  the running period, then keep the level active. Abrupt shutdown=20
>> will keep
>>  the
>>  current level of the line.
>=20
> Can you confirm the things you think above? I'd like to have them
> eventually documented in the driver.

 From what I can see, with "abrupt" shutdown the line will always=20
return to
its inactive state (be it low or high, depending on the polarity).=20
Setting
this bit to "graceful" shutdown, the only difference is that the=20
hardware
will keep its current state, active or inactive. That's why we use the
"abrupt" shutdown in the PWM driver.

>>  > >  @@ -42,11 +68,7 @@ static int jz4740_pwm_request(struct=20
>> pwm_chip
>>  > > *chip, struct pwm_device *pwm)
>>  > >   	char clk_name[16];
>>  > >   	int ret;
>>  > >
>>  > >  -	/*
>>  > >  -	 * Timers 0 and 1 are used for system tasks, so they are
>>  > > unavailable
>>  > >  -	 * for use as PWMs.
>>  > >  -	 */
>>  > >  -	if (pwm->hwpwm < 2)
>>  > >  +	if (!jz4740_pwm_can_use_chn(jz, pwm->hwpwm))
>>  > >   		return -EBUSY;
>>  >
>>  > Maybe EBUSY isn't the best choice here. If the needed register=20
>> space for
>>  > the requested pwm is not included in the memory resources=20
>> provided to
>>  > the device I'd prefer ENXIO or ENODEV.
>>=20
>>  The idea was that if we don't get the register space we need, that=20
>> means
>>  the channel is used for something else, hence the EBUSY. Should I=20
>> switch
>>  it to ENXIO?
>=20
> I understand your reasoning, but I think it's misleading. If I get
> -EBUSY from a PWM driver I'd start searching for another user of said
> resource. With ENXIO or ENODEV it's more obvious that the driver isn't
> responsible for the resource that was requested.

OK.

> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig       =20
>     |
> Industrial Linux Solutions                 |=20
> http://www.pengutronix.de/  |
=

