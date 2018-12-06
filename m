Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F62C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B63120700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B63120700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbeLFQQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:16:31 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35351 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeLFQQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:16:30 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gUwK8-0007Hh-Bm; Thu, 06 Dec 2018 17:16:24 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gUwK6-0005sL-Qc; Thu, 06 Dec 2018 17:16:22 +0100
Date:   Thu, 6 Dec 2018 17:16:22 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
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
Message-ID: <20181206161622.okpfiecfphar77jk@pengutronix.de>
References: <1544103655-104466-1-git-send-email-michal.vokac@ysoft.com>
 <1544103655-104466-3-git-send-email-michal.vokac@ysoft.com>
 <20181206135902.un2nbreqfmi6mpd6@pengutronix.de>
 <01aaa6ff-fb3e-37a7-0e72-099ad013ee2a@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01aaa6ff-fb3e-37a7-0e72-099ad013ee2a@ysoft.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 03:37:55PM +0000, Vokáč Michal wrote:
> On 6.12.2018 14:59, Uwe Kleine-König wrote:
> > On Thu, Dec 06, 2018 at 01:41:31PM +0000, Vokáč Michal wrote:
> >> +{
> >> +	imx_chip->pinctrl = devm_pinctrl_get(&pdev->dev);
> >> +	if (IS_ERR(imx_chip->pinctrl)) {
> >> +		dev_dbg(&pdev->dev, "can not get pinctrl\n");
> >> +		return PTR_ERR(imx_chip->pinctrl);
> >> +	}
> >> +
> >> +	imx_chip->pinctrl_pins_pwm = pinctrl_lookup_state(imx_chip->pinctrl,
> >> +							  "pwm");
> >> +	imx_chip->pinctrl_pins_gpio = pinctrl_lookup_state(imx_chip->pinctrl,
> >> +							   "gpio");
> >> +	imx_chip->pwm_gpiod = devm_gpiod_get_optional(&pdev->dev, "pwm",
> >> +						      GPIOD_IN);
> >> +
> >> +	if (PTR_ERR(imx_chip->pwm_gpiod) == -EPROBE_DEFER) {
> >> +		return -EPROBE_DEFER;
> >> +	} else if (IS_ERR(imx_chip->pwm_gpiod) ||
> >> +		   IS_ERR(imx_chip->pinctrl_pins_pwm) ||
> >> +		   IS_ERR(imx_chip->pinctrl_pins_gpio)) {
> >> +		dev_dbg(&pdev->dev, "PWM pinctrl information incomplete\n");
> >> +		devm_pinctrl_put(imx_chip->pinctrl);
> >> +		imx_chip->pinctrl = NULL;
> > 
> > Can it happen, that pinctrl_pins_pwm is PTR_ERR(-EPROBE_DEFER)?
> 
> No. The pinctrl_lookup_state either returns pointer to the pinctrl state
> or ERR_PTR(-ENODEV). But I do not explicitly test the pinctrl_pins_pwm
> for PTR_ERR(-EPROBE_DEFER), or do I?

You don't, I just wondered if this could happen and the function should
return -EPROBE_DEFER in this case, too.

> > Maybe you only want to ignore PTR_ERR(-ENODEV) and for example propagate
> > -EIO? I think you want to put the gpio if the failure is because there
> > is a pinctrl related error.
> 
> I think that is what I am doing. In case the GPIO is not ready the probe
> is deferred. In case of any other error with the GPIO or pinctrl failure
> I put the pinctrl. Or maybe I do not really understand what you mean.

Yes, you put the pinctrl, but not the GPIO. I.e. you're not undoing
devm_gpiod_get_optional(). Maybe only do this if the pinctrl stuff
succeeded to not touch the GPIO if it won't be used?

> > ISTR that there was a patch that implements get_state for imx. Is there
> > a dependency on that one? Otherwise the state returned by
> > pwm_get_state() might not be what is actually configured.
> 
> No, it should be independent. One can go without the other. I tested all
> three combinations (mainline with .get_state, mainline with this series,
> mainline with .get_state AND this series) and got the expected results.
> Without the .get_state() patch the core always returns the default which
> is disabled state so the gpio pinctrl state is selected in probe.

Without .get_state it won't be possible to smoothly take over a running
PWM. It doesn't hurt if the PWM isn't running though. Still I'd like to
see the .get_state patch to go in first to not get this (admittedly
small) regression.

> > Do you know if this is required for the old i.MX pwm, e.g. on i.MX21?
> > I ask because of https://patchwork.ozlabs.org/patch/1000071/
> 
> Yep, I am aware of that patch. IMHO this is not needed for the v1 on
> older i.MX SoCs but I do not have a hands-on experience with those.

OK. If you agree with my split and as you have to rework your patch
anyhow: Would you mind to rebase on top of my patch series? (Unless
Thierry disagrees with my patches, but unfortunately he didn't comment
yet.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
