Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D38C65BAE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454B22145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 454B22145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbeLCJth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:49:37 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51035 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeLCJtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:49:36 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gTkqk-0007kI-En; Mon, 03 Dec 2018 10:49:10 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gTkqi-0000Mw-3M; Mon, 03 Dec 2018 10:49:08 +0100
Date:   Mon, 3 Dec 2018 10:49:08 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Hao Zhang <hao5781286@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, mturquette@baylibre.com,
        sboyd@kernel.org, thierry.reding@gmail.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 6/6] ARM: PWM: add allwinner sun8i R40/T3/V40 PWM
 support.
Message-ID: <20181203094908.lga2r56gelaghrej@pengutronix.de>
References: <20181125162319.GA5422@arx-s1>
 <20181126213158.q5m5bbwnmewud2gb@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181126213158.q5m5bbwnmewud2gb@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Nov 26, 2018 at 10:31:58PM +0100, Uwe Kleine-König wrote:
> > +static int sun8i_pwm_config(struct sun8i_pwm_chip *sun8i_pwm, u8 ch,
> > +			    struct pwm_state *state)
> > +{
> > +[...]
> > +		clk_rate = clk_get_rate(clk);
> > +		val = state->period * clk_rate;
> > +		do_div(val, NSEC_PER_SEC);
> > +		if (val <= 1) {
> > +			dev_err(sun8i_pwm->chip.dev,
> > +				"Period expects a larger value\n");
> > +			return -EINVAL;
> > +		}
> > +
> > +		/* change clock source to "mux-1" */
> > +		clk_disable_unprepare(sun8i_pwm->clk);
> > +		devm_clk_put(sun8i_pwm->chip.dev, sun8i_pwm->clk);
> > +		sun8i_pwm->clk = clk;
> 
> sun8i_pwm is shared for all 8 PWMs, right? So if you assign mux-1 here
> for the second mux, how does this influence the first PWM?

To clearify my question:

after the first pwm is used and enabled (maybe using mux-0) changing
sun8i_pwm->clk for the second pwm is broken because then when the first
pwm is disabled the wrong clock is stopped.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
