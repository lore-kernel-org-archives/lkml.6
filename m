Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28470C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29FE2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437521AbfBNIeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:34:37 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58787 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfBNIeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:34:36 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1guCTU-0002aD-Bm; Thu, 14 Feb 2019 09:34:28 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1guCTT-0005Wn-Hx; Thu, 14 Feb 2019 09:34:27 +0100
Date:   Thu, 14 Feb 2019 09:34:27 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v6 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Message-ID: <20190214083427.oal3nmcfalqralbk@pengutronix.de>
References: <1550049978-20705-1-git-send-email-yash.shah@sifive.com>
 <1550049978-20705-3-git-send-email-yash.shah@sifive.com>
 <20190213103459.t5bvemxrb2x6iagm@pengutronix.de>
 <CAJ2_jOH7WaceLVY6KhMmSbwjo3-5tgbiSZYtbRmUxS-4Rf2WLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ2_jOH7WaceLVY6KhMmSbwjo3-5tgbiSZYtbRmUxS-4Rf2WLA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Feb 14, 2019 at 01:25:27PM +0530, Yash Shah wrote:
> On Wed, Feb 13, 2019 at 4:05 PM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Wed, Feb 13, 2019 at 02:56:18PM +0530, Yash Shah wrote:
> > > +static int pwm_sifive_enable(struct pwm_chip *chip, struct pwm_device *dev,
> > > +                          bool enable)
> > > +{
> > > +     struct pwm_sifive_ddata *pwm = pwm_sifive_chip_to_ddata(chip);
> > > +     u32 val;
> > > +     int ret;
> > > +
> > > +     if (enable) {
> > > +             ret = clk_enable(pwm->clk);
> > > +             if (ret) {
> > > +                     dev_err(pwm->chip.dev, "Enable clk failed:%d\n", ret);
> > > +                     return ret;
> > > +             }
> > > +     }
> > > +
> > > +     val = readl(pwm->regs + PWM_SIFIVE_PWMCFG);
> > > +
> > > +     if (enable)
> > > +             val |= BIT(PWM_SIFIVE_PWMCFG_EN_ALWAYS);
> > > +     else
> > > +             val &= ~BIT(PWM_SIFIVE_PWMCFG_EN_ALWAYS);
> > > +
> > > +     writel(val, pwm->regs + PWM_SIFIVE_PWMCFG);
> > > +
> > > +     if (!enable)
> > > +             clk_disable(pwm->clk);
> >
> > A disabled PWM is supposed to output an inactive signal. If the PWM runs
> > at (near) 100% and you disable it, does it reliably give that inactive
> > signal after completing the currently running period?
> 
> Yes, you are right, it just freezes at that state (100%).
> What if I set duty cycle = 0 if (!state->enabled) before disabling the PWM?

Then you only need to be sure that the inactive level is already latched
to the pwmcmpXip output (which should only need one clock cycle if I'm
not mistaken) before disabling the clock.

> > > +     return 0;
> > > +}
> > > +
> > > +static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *dev,
> > > +                         struct pwm_state *state)
> > > +{
> > > +     struct pwm_sifive_ddata *pwm = pwm_sifive_chip_to_ddata(chip);
> > > +     unsigned int duty_cycle;
> > > +     u32 frac, val;
> > > +     struct pwm_state cur_state;
> > > +     bool enabled;
> > > +     int ret;
> > > +
> > > +     pwm_get_state(dev, &cur_state);
> > > +     enabled = cur_state.enabled;
> > > +
> > > +     if (state->polarity != PWM_POLARITY_INVERSED)
> > > +             return -EINVAL;
> > > +
> > > +     if (state->period != cur_state.period) {
> > > +             if (pwm->user_count != 1)
> > > +                     return -EINVAL;
> >
> > I think we need locking here. Consider two pwm users on two CPUs:
> >
> >         CPU1                                    CPU2
> >         pwm_sifive_apply(pwm0, period=A, ...)
> >          check user_count==1 -> good
> >          ...                                    pwm1 = pwm_get(...)
> >          ...                                    pwm_sifive_apply(pwm1, period=B...)
> >          ...                                      configure based on B
> >          pwm_sifive_update_clock()
> 
> mutex_lock();
>   if (pwm->user_count != 1)
>                   return -EINVAL;
> mutex_unlock();
> Something like this?

No, the lock needs to protect more. You must at least cover increasing
and decreasing of user_count and you must hold the lock until the period
update is completed.

> > Also I wonder if we should change the period if the user requested
> > enabled=false.
> 
> You want me to NOT update period if enabled=false, right?

I don't know for sure. Given that period is shared for all four PWM
outputs it might be sensible to change it at least in a shadow variable
and only do it when actually needed. (But maybe we can postpone that as
it doesn't matter for correctness of the driver.)

The question here is: In the following snippet:

	pwm0 = pwm_get(... the first pwm ...)

	pwm_apply_state(pwm0, { .enabled = true, .period = 4000 });
	pwm_apply_state(pwm0, { .enabled = false, .period = 8000 });

	pwm1 = pwm_get(... the second pwm ...)
	pwm_apply_state(pwm1, { .enabled = true, .period = 4000 });
	pwm_apply_state(pwm0, { .enabled = true, .period = 8000 });

Which of the two last commands should fail?

> > > +             pwm->real_period = state->period;
> > > +             pwm_sifive_update_clock(pwm, clk_get_rate(pwm->clk));
> >
> > If you change from
> >
> >         .period = A
> >         .duty_cycle = B
> >
> > to
> >
> >         .period = C
> >         .duty_cycle = D
> >
> > the output pin might see a period with
> >
> >         .period = C
> >         .duty_cycle = B
> >
> > right? I think this is not fixable, but this needs a prominent comment.
> 
> Good point. Is the below comment good enough?
> /* When changing both duty cycle and period, the old duty cycle might
> be active with new the period settings for a period */

I'd add some blame on the hardware. Something like:

	/*
	 * When changing both duty cycle and period, we cannot prevent in
	 * software that the output might produce a period with mixed
	 * settings (new period length and old duty cycle).
	 */

I'd say it makes sense to put this information at the top of the driver
to have it in a prominent place. Also point out the inability to provide
100% duty cycle and that the hardware is limited to inverted output.
Then all limitations are summarized in a single place.

Maybe this mismatch could be made less likely by changing the order of
the register accesses and a delay depending on pwms and old and new
settings. But I'd say this is too much for now and can be addressed
later when and if necessary.

> > > +     }
> > > +
> > > +     if (!state->enabled && enabled) {
> > > +             ret = pwm_sifive_enable(chip, dev, false);
> > > +             if (ret)
> > > +                     return ret;
> > > +             enabled = false;
> > > +     }
> > > +
> > > +     duty_cycle = state->duty_cycle;
> > > +     frac = div_u64((u64)duty_cycle * (1 << PWM_SIFIVE_CMPWIDTH) +
> > > +                    (1 << PWM_SIFIVE_CMPWIDTH) / 2, state->period);
> > > +     /* The hardware cannot generate a 100% duty cycle */
> >
> > @Thierry: Do you consider this bad enough that pwm_apply_state should
> > fail if 100% is requested?

This question is still open.

> > > +     frac = min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
> > > +
> > > +     val = readl(pwm->regs + PWM_SIFIVE_PWMCFG);
> > > +     val |= BIT(PWM_SIFIVE_PWMCFG_DEGLITCH);
> > > +     writel(val, pwm->regs + PWM_SIFIVE_PWMCFG);
> > > +
> > > +     writel(frac, pwm->regs + PWM_SIFIVE_PWMCMP0 + dev->hwpwm *
> > > +            PWM_SIFIVE_SIZE_PWMCMP);
> > > +
> > > +     val &= ~BIT(PWM_SIFIVE_PWMCFG_DEGLITCH);
> >
> > Doesn't that come too early? I thought the right thing was to keep it
> > set all the time. With this code I think you might see a duty cycle of
> > 50 when going from 60 to 40.
> 
> We cannot set it all the time.
> Setting it all the time makes every alternate period to remain high
> (latched state).
> As per the manual, it needs to be set when reprogramming and must be
> cleared afterwards.

I didn't find this in the manual. When looking at Figure 6 and the
description of pwmdeglitch I have the impression that your statement is
wrong.

Setting pwmdeglitch only prevents the output from getting low during a
period, it can only go low when pwms overflows (i.e. the start of a
period). That's exactly what we want. Where is the misunderstanding?

If however you clear pwmdeglitch after an update, consider the following
series of events:

 - Assume pwmcmpX is 0x4000 and pwms is 0x5000, so pwmcmpXip is high.
 - You set pwmdeglitch and change pwmcmpX to 0x8000 while pwms advanced
   only little. Then pwmcmpXip remains high.
 - Then you clear pwmdeglitch at say pwms = 0x5020, this makes pwmcmpXip
   fall which we should prevent.

Also note that when setting pwmdeglitch while configuring pwm0---if it
really had the behaviour you pointed out---would interfere with the
maybe running pwm1.

So I'm convinced keeping pwmdeglitch active always is the right thing to
do.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
