Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C23C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BF520870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65BF520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbeLMUOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:14:52 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50383 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbeLMUOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 15:14:52 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gXXNg-0000ic-L7; Thu, 13 Dec 2018 21:14:48 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gXXNf-0000R5-TJ; Thu, 13 Dec 2018 21:14:47 +0100
Date:   Thu, 13 Dec 2018 21:14:47 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 3/3] pwm: imx: Implement get_state() function for
 hardware readout
Message-ID: <20181213201447.v2ivule5q6knxqyp@pengutronix.de>
References: <1538403588-68850-1-git-send-email-michal.vokac@ysoft.com>
 <1538403588-68850-3-git-send-email-michal.vokac@ysoft.com>
 <20181212105432.GD17654@ulmo>
 <20181213085213.7k5ihn7bdrtess3g@pengutronix.de>
 <20181213170000.GA14581@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181213170000.GA14581@ulmo>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thierry,

On Thu, Dec 13, 2018 at 06:00:00PM +0100, Thierry Reding wrote:
> On Thu, Dec 13, 2018 at 09:52:13AM +0100, Uwe Kleine-König wrote:
> > On Wed, Dec 12, 2018 at 11:54:32AM +0100, Thierry Reding wrote:
> > > On Mon, Oct 01, 2018 at 04:19:48PM +0200, Michal Vokáč wrote:
> > > > Implement the get_state() function and set the initial state to reflect
> > > > real state of the hardware. This allows to keep the PWM running if it was
> > > > enabled in bootloader. It is very similar to the GPIO behavior. GPIO pin
> > > > set as output in bootloader keep the same setting in Linux unless it is
> > > > reconfigured.
> > > > 
> > > > If we find the PWM block enabled we need to prepare and enable its source
> > > > clock otherwise the clock will be disabled late in the boot as unused.
> > > > That will leave the PWM in enabled state but with disabled clock. That has
> > > > a side effect that the PWM output is left at its current level at which
> > > > the clock was disabled. It is totally non-deterministic and it may be LOW
> > > > or HIGH.
> > > > 
> > > > Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> > > > ---
> > > >  drivers/pwm/pwm-imx.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 53 insertions(+)
> > > 
> > > Applied, thanks.
> > 
> > Did you miss my feedback for this patch or did you choose to ignore it?
> 
> Don't have anything in my inbox, but I see that it's there on patchwork,
> so I suspect it was eaten by the spam filter.

:-|

> Let me copy-paste here and go through it.
> 
> > > @@ -93,6 +96,55 @@ struct imx_chip {
> > >
> > >  #define to_imx_chip(chip) container_of(chip, struct imx_chip, chip)
> > >
> > > +static void imx_pwm_get_state(struct pwm_chip *chip,
> > > +  struct pwm_device *pwm, struct pwm_state *state)
> > 
> > broken alignment.
> 
> I can fix that up, no need to resend for that.

fine.

> > > +{
> > > + struct imx_chip *imx = to_imx_chip(chip);
> > > + u32 period, prescaler, pwm_clk, ret, val;
> > > + u64 tmp;
> > > +
> > > + val = readl(imx->mmio_base + MX3_PWMCR);
> > > +
> > > + if (val & MX3_PWMCR_EN) {
> > > +  state->enabled = true;
> > > +  ret = clk_prepare_enable(imx->clk_per);
> > > +  if (ret)
> > > +   return;
> > > + } else {
> > > +  state->enabled = false;
> > > + }
> > > +
> > > + switch (FIELD_GET(MX3_PWMCR_POUTC, val)) {
> > > + case MX3_PWMCR_POUTC_NORMAL:
> > > +  state->polarity = PWM_POLARITY_NORMAL;
> > > +  break;
> > > + case MX3_PWMCR_POUTC_INVERTED:
> > > +  state->polarity = PWM_POLARITY_INVERSED;
> > > +  break;
> > > + default:
> > > +  dev_warn(chip->dev, "can't set polarity, output disconnected");
> > 
> > Should we return an error here?
> 
> We can't return an error here because the function has a void return
> type. I'm not sure what it means if the POUTC is neither "normal" nor
> "inverted", but perhaps a good idea would be to default to either of
> those two in that case, or perhaps forcibly disable the PWM so that
> we get known-good values in the registers?

The manual says "PWM output is disconnected". So I think the right thing
to do is to consider the pwm as disabled. (But checking how the output
actually behaves would be great.) (Maybe this setting is even the
solution to our "Make the output high-Z on disable" discussion?)

> I'm tempted not to treat this as a blocker because it's not actually
> a bug or anything. Prior to this patch we also ignore whatever this
> field was set to.

Prior to this patch this field was never read as this is only needed in
.get_state. And in .apply the value is correctly written.

> > > + }
> > > +
> > > + prescaler = MX3_PWMCR_PRESCALER_GET(val);
> > > + pwm_clk = clk_get_rate(imx->clk_per);
> > > + pwm_clk = DIV_ROUND_CLOSEST_ULL(pwm_clk, prescaler);
> > > + val = readl(imx->mmio_base + MX3_PWMPR);
> > 
> > It would be more cautionous to not rely on the reserved bits to read as
> > zero. So I suggest to mask the value with 0xffff.
> 
> If that's what the documentation says I think it's okay to rely on it.
> But I can add the mask if we want to play it extra safe.

The PERIOD field only covers bits 0 to 15 and the upper 16 bits of this
register are reserved. The registers are documented to read as 0, still
I'd prefer to mask them out for maximal correctness.

> > > + period = val >= MX3_PWMPR_MAX ? MX3_PWMPR_MAX : val;
> > > +
> > > + /* PWMOUT (Hz) = PWMCLK / (PWMPR + 2) */
> > > + tmp = NSEC_PER_SEC * (u64)(period + 2);
> > > + state->period = DIV_ROUND_CLOSEST_ULL(tmp, pwm_clk);
> > 
> > Would it make sense to introduce a policy about how to round in this
> > case? (Similarily for .apply?) This is of course out of scope for this
> > patch.
> 
> I'm not sure what you means by policy. The above already does round to
> closest. Is that not an appropriate policy?

I mean to document the expectation of the pwm framework how the driver
is supposed to configure the hardware when it should program the PWM
with say duty_cycle=100ns/period=300ns and but the hardware can only
implement both duty_cycle and period in steps of 3ns. So the (IMHO) good
candidates are:

	duty_cycle = 99ns / period = 297ns
	duty_cycle = 99ns / period = 300ns
	duty_cycle = 102ns / period = 300ns
	duty_cycle = 102ns / period = 306ns

As it's not obvious which is the best here (or is it?) and taking into
account that the PWM user might care, it would be right to specify
something like:

  The driver is supposed to configure the biggest duty_cycle that
  is not greater than the requested duty_cycle. Similarily it should
  pick the biggest possible period that is not greater than the
  requested period.

To actually allow the user to find the setting that he or she prefers
something like the clk framework provides with clk_round_rate() would be
needed of course.

And for .get_state I'd specify something similar that ensures that in
the sequence

	myops->get_state(chip, pwm, state);
	myops->apply(chip, pwm, state);

the latter is a noop.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
