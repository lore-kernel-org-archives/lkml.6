Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8E4C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 21:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E852190A
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 21:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfAEV1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 16:27:25 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45333 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfAEV1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 16:27:24 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gftTN-0006fL-0m; Sat, 05 Jan 2019 22:27:13 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gftTL-0000Ds-FK; Sat, 05 Jan 2019 22:27:11 +0100
Date:   Sat, 5 Jan 2019 22:27:11 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v9 14/27] pwm: jz4740: Improve algorithm of clock
 calculation
Message-ID: <20190105212711.s765knwwerceytvk@pengutronix.de>
References: <20181227181319.31095-1-paul@crapouillou.net>
 <20181227181319.31095-15-paul@crapouillou.net>
 <20190105195725.cuxfge6zkpbt3cyk@pengutronix.de>
 <1546722339.30174.0@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1546722339.30174.0@crapouillou.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul,

On Sat, Jan 05, 2019 at 06:05:38PM -0300, Paul Cercueil wrote:
> On Sat, Jan 5, 2019 at 4:57 PM, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > You are assuming stuff here about the parent clk which isn't guaranteed
> > (AFAICT) by the clk framework: If you call clk_round_rate(clk, rate - 1)
> > this might well return rate even if the clock could run slower than
> > rate.
> 
> It may not be guaranteed by the clock framework itself, but it is guaranteed
> to behave like that on this family of SoCs.

You shouldn't rely on that. Experience shows that people will start
copying code to machines where this is not guaranteed. Even if they
don't copy and only learn from reading this is bad. Also how do you
guarantee that this won't change in the future making the pwm code break
without noticing?

If you use an API better don't assume more things given than are
guaranteed by the API.

Having said that I would consider it sensible to introduce something
like clk_roundup_rate() and clk_rounddown_rate() which would allow
calculations like that.

> > Wouldn't it make sense to start iterating with rate = 0xffff * 1e9 /
> > period? Otherwise you get bad configurations if rate is considerable
> > slower than necessary.
> 
> The algorithm will start with 'rate' being the parent clock's rate, which
> will always be the highest rate that the child clock will support.

Ah right, I missed that bit.
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
