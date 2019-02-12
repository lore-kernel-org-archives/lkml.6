Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F13BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC702186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbfBLKGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:06:14 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59743 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbfBLKGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:06:14 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gtUx7-0004g9-5U; Tue, 12 Feb 2019 11:06:09 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gtUx5-0003F8-RD; Tue, 12 Feb 2019 11:06:07 +0100
Date:   Tue, 12 Feb 2019 11:06:07 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/9] irq/irq_sim: provide irq_sim_fire_type()
Message-ID: <20190212100607.4etnqytsrtxtcqvc@pengutronix.de>
References: <20190129084411.30495-1-brgl@bgdev.pl>
 <20190129084411.30495-4-brgl@bgdev.pl>
 <656763ec-41b9-cdee-22bd-1f32d74473a0@arm.com>
 <CAMpxmJXdyiSLyx7O5G41GzfJQktOS1JeuRUoHejVB3ZOmCFMLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMpxmJXdyiSLyx7O5G41GzfJQktOS1JeuRUoHejVB3ZOmCFMLQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 10:19:20AM +0100, Bartosz Golaszewski wrote:
> wt., 12 lut 2019 o 10:10 Marc Zyngier <marc.zyngier@arm.com> napisał(a):
> >
> > On 29/01/2019 08:44, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > Provide a more specialized variant of irq_sim_fire() that allows to
> > > specify the type of the fired interrupt. The type is stored in the
> > > dummy irq context struct via the set_type callback.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > ---
> > >  include/linux/irq_sim.h |  9 ++++++++-
> > >  kernel/irq/irq_sim.c    | 26 ++++++++++++++++++++++----
> > >  2 files changed, 30 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/include/linux/irq_sim.h b/include/linux/irq_sim.h
> > > index b96c2f752320..647a6c8ffb31 100644
> > > --- a/include/linux/irq_sim.h
> > > +++ b/include/linux/irq_sim.h
> > > @@ -23,6 +23,7 @@ struct irq_sim_work_ctx {
> > >
> > >  struct irq_sim_irq_ctx {
> > >       bool                    enabled;
> > > +     unsigned int            type;
> > >  };
> > >
> > >  struct irq_sim {
> > > @@ -37,7 +38,13 @@ int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs);
> > >  int devm_irq_sim_init(struct device *dev, struct irq_sim *sim,
> > >                     unsigned int num_irqs);
> > >  void irq_sim_fini(struct irq_sim *sim);
> > > -void irq_sim_fire(struct irq_sim *sim, unsigned int offset);
> > > +void irq_sim_fire_type(struct irq_sim *sim,
> > > +                    unsigned int offset, unsigned int type);
> > >  int irq_sim_irqnum(struct irq_sim *sim, unsigned int offset);
> > >
> > > +static inline void irq_sim_fire(struct irq_sim *sim, unsigned int offset)
> > > +{
> > > +     irq_sim_fire_type(sim, offset, IRQ_TYPE_DEFAULT);
> > > +}
> > > +
> > >  #endif /* _LINUX_IRQ_SIM_H */
> > > diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
> > > index 2bcdbab1bc5a..e3160b5e59b8 100644
> > > --- a/kernel/irq/irq_sim.c
> > > +++ b/kernel/irq/irq_sim.c
> > > @@ -25,6 +25,15 @@ static void irq_sim_irqunmask(struct irq_data *data)
> > >       irq_ctx->enabled = true;
> > >  }
> > >
> > > +static int irq_sim_set_type(struct irq_data *data, unsigned int type)
> > > +{
> > > +     struct irq_sim_irq_ctx *irq_ctx = irq_data_get_irq_chip_data(data);
> > > +
> > > +     irq_ctx->type = type;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > >  static void irq_sim_handle_irq(struct irq_work *work)
> > >  {
> > >       struct irq_sim_work_ctx *work_ctx;
> > > @@ -107,6 +116,7 @@ int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs)
> > >       sim->chip.name = "irq_sim";
> > >       sim->chip.irq_mask = irq_sim_irqmask;
> > >       sim->chip.irq_unmask = irq_sim_irqunmask;
> > > +     sim->chip.irq_set_type = irq_sim_set_type;
> > >
> > >       sim->work_ctx.pending = bitmap_zalloc(num_irqs, GFP_KERNEL);
> > >       if (!sim->work_ctx.pending) {
> > > @@ -192,21 +202,29 @@ irq_sim_get_ctx(struct irq_sim *sim, unsigned int offset)
> > >  }
> > >
> > >  /**
> > > - * irq_sim_fire - Enqueue an interrupt.
> > > + * irq_sim_fire_type - Enqueue an interrupt.
> > >   *
> > >   * @sim:        The interrupt simulator object.
> > >   * @offset:     Offset of the simulated interrupt which should be fired.
> > > + * @type:    Type of the fired interrupt. Must be one of the following:
> > > + *           IRQ_TYPE_EDGE_RISING, IRQ_TYPE_EDGE_FALLING,
> > > + *           IRQ_TYPE_EDGE_BOTH, IRQ_TYPE_LEVEL_HIGH,
> > > + *           IRQ_TYPE_LEVEL_LOW, IRQ_TYPE_DEFAULT
> > >   */
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
> >
> > I wonder how realistic this is, given that you do not track the release
> > of a level. In short, mo matter what the type is, you treat everything
> > as edge.
> >
> > What is the point of this?
> >
> 
> When userspace wants to monitor GPIO line interrupts, the GPIO
> framework requests a threaded interrupt with IRQF_TRIGGER_FALLING,
> IRQF_TRIGGER_RISING or both.

I think the background of the question was: Why is there no support for
level sensitive irqs?

The userspace API has this limitation (also for no good reason I think).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
