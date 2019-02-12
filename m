Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6156C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD26217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbfBLLFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 06:05:08 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35331 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfBLLFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 06:05:07 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gtVs7-0003oz-4f; Tue, 12 Feb 2019 12:05:03 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gtVs6-0005IS-09; Tue, 12 Feb 2019 12:05:02 +0100
Date:   Tue, 12 Feb 2019 12:05:01 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/9] irq/irq_sim: provide irq_sim_fire_type()
Message-ID: <20190212110501.wd7ks7vms7pi63dk@pengutronix.de>
References: <20190129084411.30495-1-brgl@bgdev.pl>
 <20190129084411.30495-4-brgl@bgdev.pl>
 <656763ec-41b9-cdee-22bd-1f32d74473a0@arm.com>
 <CAMpxmJXdyiSLyx7O5G41GzfJQktOS1JeuRUoHejVB3ZOmCFMLQ@mail.gmail.com>
 <c562c67d-d6e3-15c3-b10b-315e8fb181a5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c562c67d-d6e3-15c3-b10b-315e8fb181a5@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 10:27:54AM +0000, Marc Zyngier wrote:
> On 12/02/2019 09:19, Bartosz Golaszewski wrote:
> > When userspace wants to monitor GPIO line interrupts, the GPIO
> > framework requests a threaded interrupt with IRQF_TRIGGER_FALLING,
> > IRQF_TRIGGER_RISING or both. The testing module tries to act like real
> > hardware and so if we pass only one of the *_TRIGGER_* flags, we want
> > the simulated interrupt of corresponding type to be fired.
> 
> Well, that's not how HW works.

I cannot follow. I agree with Bartosz here. If you configure your SoC's
irq-controller to only fire on a raising edge, you don't get an event
when the line falls.
 
> > Another solution - if you don't like this one -  would be to have more
> > specialized functions: irq_sim_fire_rising() and
> > irq_sim_fire_falling(). How about that?
> 
> I think you're missing the point. So far, your API has been "an
> interrupt has fired", no matter what the trigger is, and that's fine.
> That's just modeling the output of an abstract interrupt controller into
> whatever the irqsim is simulating.
> 
> Now, what you're exposing is "this is how the line changed". Which is an
> entirely different business, as you're now exposing the device output
> line. Yes, you can model it with raising/falling, but you need at least
> resampling for level interrupts, and actual edge detection (raising
> followed by raising only generates a single interrupt, while
> raising-falling-raising generates two).

This matches my concern and that's why I suggested somewhere else in
this thread to put the configuration of the sensitiveness and the actual
tracking of the line in the same component (either irqsim or
gpio-mockup). Given that there are only two irqsim users and the other
one (something in iio) doesn't need that sensitiveness stuff (and I
cannot imagine another user of irqsim with the sensitiveness support) I
think it is best to move this to the mockup driver. That's how "normal"
hardware drivers have to do it, too.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
