Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EF3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41FC206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F41FC206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732551AbeKVFur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:50:47 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47183 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729634AbeKVFuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:50:46 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gPXxu-0001Sr-SG; Wed, 21 Nov 2018 20:15:10 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gPXxt-0000aF-Pm; Wed, 21 Nov 2018 20:15:09 +0100
Date:   Wed, 21 Nov 2018 20:15:09 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 1/2] irq/irq_sim: provide irq_sim_fire_edge()
Message-ID: <20181121191509.ia2vcklvx4q2rh56@pengutronix.de>
References: <20181120134032.31645-1-brgl@bgdev.pl>
 <20181120134032.31645-2-brgl@bgdev.pl>
 <20181120171742.gkwb4s4qbcqvnefj@pengutronix.de>
 <CAMRc=MfKf_f+x3Wt5gScA5yb78kbpphL87bi2arxcKKGjg1S7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfKf_f+x3Wt5gScA5yb78kbpphL87bi2arxcKKGjg1S7Q@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Bartosz,

On Wed, Nov 21, 2018 at 05:34:32PM +0100, Bartosz Golaszewski wrote:
> wt., 20 lis 2018 o 18:17 Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> napisał(a):
> >
> > On Tue, Nov 20, 2018 at 02:40:31PM +0100, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > The irq_sim irqchip doesn't allow to configure the sensitivity so every
> > > call to irq_sim_fire() fires a dummy interrupt. This used to not matter
> > > for gpio-mockup (one of the irq_sim users) until commit fa38869b0161
> > > ("gpiolib: Don't support irq sharing for userspace") which made it
> > > impossible for gpio-mockup to ignore certain events (e.g. only receive
> > > notifications about rising edge events).
> > >
> > > Introduce a specialized variant of irq_sim_fire() which takes another
> > > argument called edge. allowing to specify the trigger type for the
> > > dummy interrupt.
> >
> > I wonder if it's worth the effort to fix irq_sim. If you take a look in
> > my gpio-simulator patch, it is trivial to get it right without external
> > help with an amount of code that is usual for a driver that handles
> > irqs.
> 
> You're basically recommending handcrafting another local piece of code
> for simulating interrupts - something that multiple users may be
> interested in. You did that in your proposed gpio-simulator and I
> still can't understand why you couldn't reuse the existing solution.
> Even if it's broken for your use-case, it's surely easier to fix it
> than to rewrite and duplicate it? There are very few cases where code
> consolidation is not a good thing and I don't think this is one of
> them.

I don't say that factoring out common stuff is bad. But if in the end
you call

	irq_sim_something(some, parameters, offset);

with the simulator and if you don't use the irq simulator you do

	irq = irq_find_mapping(irqdomain, offset);
	generic_handle_irq(irq);

I prefer the latter because it's only a single additional line and in
return it's more obvious what it does because it's the same that many
other drivers (for real hardware) also do.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
