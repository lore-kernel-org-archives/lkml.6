Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425BFC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136EE21873
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfA2Mza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:55:30 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48025 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbfA2Mza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 07:55:30 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1goSvG-000300-VU; Tue, 29 Jan 2019 13:55:26 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1goSvF-0008P2-LX; Tue, 29 Jan 2019 13:55:25 +0100
Date:   Tue, 29 Jan 2019 13:55:25 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 3/9] irq/irq_sim: provide irq_sim_fire_type()
Message-ID: <20190129125525.ahgiwaftubs3tlog@pengutronix.de>
References: <20190129084411.30495-1-brgl@bgdev.pl>
 <20190129084411.30495-4-brgl@bgdev.pl>
 <20190129090706.33wcxb6d2c64yx7c@pengutronix.de>
 <CAMRc=Me6bGaGiiwvGNXbcr+fxarYsrgH-3MhQpSKjOjKQ6BtTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Me6bGaGiiwvGNXbcr+fxarYsrgH-3MhQpSKjOjKQ6BtTw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 12:01:37PM +0100, Bartosz Golaszewski wrote:
> wt., 29 sty 2019 o 10:07 Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> napisał(a):
> >
> > Hello Bartosz,
> >
> > On Tue, Jan 29, 2019 at 09:44:05AM +0100, Bartosz Golaszewski wrote:
> > > -void irq_sim_fire(struct irq_sim *sim, unsigned int offset)
> > > +void irq_sim_fire_type(struct irq_sim *sim,
> > > +                    unsigned int offset, unsigned int type)
> > >  {
> > >       struct irq_sim_irq_ctx *ctx = irq_sim_get_ctx(sim, offset);
> > >
> > > -     if (ctx->enabled) {
> > > +     /* Only care about relevant flags. */
> > > +     type &= IRQ_TYPE_SENSE_MASK;
> > > +
> > > +     if (ctx->enabled && (ctx->type & type)) {
> > >               set_bit(offset, sim->work_ctx.pending);
> > >               irq_work_queue(&sim->work_ctx.work);
> > >       }
> > >  }
> > > -EXPORT_SYMBOL_GPL(irq_sim_fire);
> > > +EXPORT_SYMBOL_GPL(irq_sim_fire_type);
> >
> > This looks better than the previous variant. I wonder if it would be
> > still more sensible to have type only in the mockup driver. But I don't
> > have the complete picture here and it might be easier this way.
> >
> 
> I'm afraid I don't follow. Wasn't that the way it was done in v1?

No, in v1 you already had "type" in the irq_sim driver and the logic if
the irq should trigger in mockup. My wondering is about having both in
the mockup driver.

Then you have the tracking of the line's level and the logic if it should
trigger an irq in a single place.

But as I said, I'm not sure if this is better than your proposed
solution in v2.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
