Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81618C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A214218AD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NICQXShg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbfBLIap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:30:45 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38544 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728308AbfBLIap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:30:45 -0500
Received: by mail-ot1-f65.google.com with SMTP id m1so3062399otf.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 00:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=16loYNCxNXhK0LW1hhYGqx21VdfAizBNu31on3M8f3M=;
        b=NICQXShg69gy1ZZu0ZMbTwOByTkHymkJHrn72ftBiksdu+pbVbJHmwX7/s/VIUnoCX
         sxsBF4r6g3JVJxeRWm4TiR/EHUfAgFFd95B8kBKbmihqKWn4de8ofsXfKoJmKY0EhBLW
         yJiOXc4lHzhjVwfPXtgl6+Y+gMG0Rr/ACp7AJeZAJEsdi5PiNonQEmqs+1AhCLU09W6D
         ZGWhcWDQSaHdzAisA6xwLaMolCdT8m/3F0u5W5rnat+AoTYeqw1h9E6msy5531OqokP7
         nm7/Xs7Djl+MFqTjwXN66jojo8AsomQEldEYzQa3RxRd+zjlJbclBSolagO+JMnfOC+U
         cTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=16loYNCxNXhK0LW1hhYGqx21VdfAizBNu31on3M8f3M=;
        b=TLkJHH3bF2h/hrwLzeGs7DhVJeKhDVAUPFLyWcgzKpyOXmJl5lkcCgTDi9xrkUJsGG
         3kqxB4Em7uEtBWkWtBO40tJHhnaSheawlzkH3oV0Ho15dXafC1ZCVGrN/EZkz8UViTsO
         LTHetWptFOPkw41G+fAK4t5bRjw0n4PaS6du0PKDaXSbL0qE+K6/DE13K9eFYcq6kNYd
         iJjtxJTaSTQeWsj2E8apIrhlY0vmN3amAwjjjQp5jB5b2VediC4IguvRWOOgVLiwrLeq
         03MwOAGMNGaOjxqQyB6x8nBmSNYjSdgsu68nnpPJkpoHaLqGc0c3P+vYYyizHG3gDzGP
         4wew==
X-Gm-Message-State: AHQUAuYc+6IJjDtJoWKK20mz/CsBu8MNfYELnyz5lALrJxFadN3wq9+k
        I8YIDE/+sjpVmg/CsGeG5M3FnR9Yj90V7ii2Y12rag==
X-Google-Smtp-Source: AHgI3IbW5GhME41MMfU4dU/oNRBPMDW6ZjSnCBdRXF94AGuA+lWJ0EtFC1mUlsWF0uJBc320EhYpAgyLjG1fmOhRy4s=
X-Received: by 2002:a9d:635a:: with SMTP id y26mr2451012otk.27.1549960243668;
 Tue, 12 Feb 2019 00:30:43 -0800 (PST)
MIME-Version: 1.0
References: <20190129084411.30495-1-brgl@bgdev.pl> <20190129084411.30495-3-brgl@bgdev.pl>
 <20190211222610.42e9189b@why.wild-wind.fr.eu.org>
In-Reply-To: <20190211222610.42e9189b@why.wild-wind.fr.eu.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 12 Feb 2019 09:30:32 +0100
Message-ID: <CAMpxmJXN0g10BMd1Mj1yx2_F6HuoKEyjHPoW+jS9pgmk-uNs8g@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] irq/irq_sim: use irq domain
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 11 lut 2019 o 23:26 Marc Zyngier <marc.zyngier@arm.com> napisa=C5=82(=
a):
>
> On Tue, 29 Jan 2019 09:44:04 +0100
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Delegate the offset to virq number mapping to the provided framework
> > instead of handling it locally. Use the legacy domain as we want to
> > preallocate the irq descriptors.
>
> Why?
>
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  include/linux/irq_sim.h |  6 +--
> >  kernel/irq/irq_sim.c    | 94 +++++++++++++++++++++++++++++------------
> >  2 files changed, 71 insertions(+), 29 deletions(-)
> >
> > diff --git a/include/linux/irq_sim.h b/include/linux/irq_sim.h
> > index eda132c22b57..b96c2f752320 100644
> > --- a/include/linux/irq_sim.h
> > +++ b/include/linux/irq_sim.h
> > @@ -8,6 +8,7 @@
> >
> >  #include <linux/irq.h>
> >  #include <linux/irq_work.h>
> > +#include <linux/irqdomain.h>
> >  #include <linux/device.h>
> >
> >  /*
> > @@ -21,16 +22,15 @@ struct irq_sim_work_ctx {
> >  };
> >
> >  struct irq_sim_irq_ctx {
> > -     int                     irqnum;
> >       bool                    enabled;
> >  };
> >
> >  struct irq_sim {
> >       struct irq_chip         chip;
> > +     struct irq_domain       *domain;
> >       struct irq_sim_work_ctx work_ctx;
> > -     int                     irq_base;
> > +     int                     virq_base;
> >       unsigned int            irq_count;
> > -     struct irq_sim_irq_ctx  *irqs;
> >  };
> >
> >  int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs);
> > diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
> > index b732e4e2e45b..2bcdbab1bc5a 100644
> > --- a/kernel/irq/irq_sim.c
> > +++ b/kernel/irq/irq_sim.c
> > @@ -44,6 +44,43 @@ static void irq_sim_handle_irq(struct irq_work *work=
)
> >       }
> >  }
> >
> > +static int irq_sim_domain_map(struct irq_domain *domain,
> > +                           unsigned int virq, irq_hw_number_t hw)
> > +{
> > +     struct irq_sim *sim =3D domain->host_data;
> > +     struct irq_sim_irq_ctx *ctx;
> > +
> > +     ctx =3D kzalloc(sizeof(*ctx), GFP_KERNEL);
> > +     if (!ctx)
> > +             return -ENOMEM;
> > +
> > +     irq_set_chip(virq, &sim->chip);
> > +     irq_set_chip_data(virq, ctx);
> > +     irq_set_handler(virq, handle_simple_irq);
>
> Consider using modern APIs such as irq_domain_set_info().
>
> > +     irq_modify_status(virq, IRQ_NOREQUEST | IRQ_NOAUTOEN, IRQ_NOPROBE=
);
>
> Where is this requirement coming from?
>
> > +
> > +     return 0;
> > +}
> > +
> > +static void irq_sim_domain_free(struct irq_domain *domain,
> > +                             unsigned int virq, unsigned int num_irqs)
> > +{
> > +     struct irq_sim_irq_ctx *ctx;
> > +     struct irq_data *irq;
> > +     int i;
> > +
> > +     for (i =3D 0; i < num_irqs; i++) {
> > +             irq =3D irq_domain_get_irq_data(domain, virq + i);
> > +             ctx =3D irq_data_get_irq_chip_data(irq);
> > +             kfree(ctx);
> > +     }
> > +}
> > +
> > +static const struct irq_domain_ops irq_sim_domain_ops =3D {
> > +     .map =3D irq_sim_domain_map,
> > +     .free =3D irq_sim_domain_free,
>
> The intended use of the v2 API is to have alloc and free as a pair, and
> no map. So please choose which version of the API you're using here.
> The safest bet would be to move what you do on map into alloc.
>
> > +};
> > +
> >  /**
> >   * irq_sim_init - Initialize the interrupt simulator: allocate a range=
 of
> >   *                dummy interrupts.
> > @@ -56,16 +93,15 @@ static void irq_sim_handle_irq(struct irq_work *wor=
k)
> >   */
> >  int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs)
> >  {
> > -     int i;
> > -
> > -     sim->irqs =3D kmalloc_array(num_irqs, sizeof(*sim->irqs), GFP_KER=
NEL);
> > -     if (!sim->irqs)
> > +     sim->virq_base =3D irq_alloc_descs(-1, 0, num_irqs, 0);
> > +     if (sim->virq_base < 0)
> > +             return sim->virq_base;
> > +
> > +     sim->domain =3D irq_domain_add_legacy(NULL, num_irqs, sim->virq_b=
ase,
> > +                                         0, &irq_sim_domain_ops, sim);
>
> Why do you need a legacy domain? As far as I can tell, this is new
> code, hence it has no legacy.
>
> > +     if (!sim->domain) {
> > +             irq_free_descs(sim->virq_base, num_irqs);
> >               return -ENOMEM;
> > -
> > -     sim->irq_base =3D irq_alloc_descs(-1, 0, num_irqs, 0);
> > -     if (sim->irq_base < 0) {
> > -             kfree(sim->irqs);
> > -             return sim->irq_base;
> >       }
> >
> >       sim->chip.name =3D "irq_sim";
> > @@ -74,25 +110,15 @@ int irq_sim_init(struct irq_sim *sim, unsigned int=
 num_irqs)
> >
> >       sim->work_ctx.pending =3D bitmap_zalloc(num_irqs, GFP_KERNEL);
> >       if (!sim->work_ctx.pending) {
> > -             kfree(sim->irqs);
> > -             irq_free_descs(sim->irq_base, num_irqs);
> > +             irq_domain_remove(sim->domain);
> > +             irq_free_descs(sim->virq_base, num_irqs);
> >               return -ENOMEM;
> >       }
> >
> > -     for (i =3D 0; i < num_irqs; i++) {
> > -             sim->irqs[i].irqnum =3D sim->irq_base + i;
> > -             sim->irqs[i].enabled =3D false;
> > -             irq_set_chip(sim->irq_base + i, &sim->chip);
> > -             irq_set_chip_data(sim->irq_base + i, &sim->irqs[i]);
> > -             irq_set_handler(sim->irq_base + i, &handle_simple_irq);
> > -             irq_modify_status(sim->irq_base + i,
> > -                               IRQ_NOREQUEST | IRQ_NOAUTOEN, IRQ_NOPRO=
BE);
> > -     }
> > -
> >       init_irq_work(&sim->work_ctx.work, irq_sim_handle_irq);
> >       sim->irq_count =3D num_irqs;
> >
> > -     return sim->irq_base;
> > +     return sim->virq_base;
> >  }
> >  EXPORT_SYMBOL_GPL(irq_sim_init);
> >
> > @@ -106,8 +132,8 @@ void irq_sim_fini(struct irq_sim *sim)
> >  {
> >       irq_work_sync(&sim->work_ctx.work);
> >       bitmap_free(sim->work_ctx.pending);
> > -     irq_free_descs(sim->irq_base, sim->irq_count);
> > -     kfree(sim->irqs);
> > +     irq_domain_free_irqs(sim->virq_base, sim->irq_count);
> > +     irq_domain_remove(sim->domain);
> >  }
> >  EXPORT_SYMBOL_GPL(irq_sim_fini);
> >
> > @@ -151,6 +177,20 @@ int devm_irq_sim_init(struct device *dev, struct i=
rq_sim *sim,
> >  }
> >  EXPORT_SYMBOL_GPL(devm_irq_sim_init);
> >
> > +static struct irq_sim_irq_ctx *
> > +irq_sim_get_ctx(struct irq_sim *sim, unsigned int offset)
> > +{
> > +     struct irq_sim_irq_ctx *ctx;
> > +     struct irq_data *irq;
> > +     int virq;
> > +
> > +     virq =3D irq_find_mapping(sim->domain, offset);
> > +     irq =3D irq_domain_get_irq_data(sim->domain, virq);
> > +     ctx =3D irq_data_get_irq_chip_data(irq);
> > +
> > +     return ctx;
> > +}
> > +
> >  /**
> >   * irq_sim_fire - Enqueue an interrupt.
> >   *
> > @@ -159,7 +199,9 @@ EXPORT_SYMBOL_GPL(devm_irq_sim_init);
> >   */
> >  void irq_sim_fire(struct irq_sim *sim, unsigned int offset)
> >  {
> > -     if (sim->irqs[offset].enabled) {
> > +     struct irq_sim_irq_ctx *ctx =3D irq_sim_get_ctx(sim, offset);
> > +
> > +     if (ctx->enabled) {
> >               set_bit(offset, sim->work_ctx.pending);
> >               irq_work_queue(&sim->work_ctx.work);
> >       }
> > @@ -175,6 +217,6 @@ EXPORT_SYMBOL_GPL(irq_sim_fire);
> >   */
> >  int irq_sim_irqnum(struct irq_sim *sim, unsigned int offset)
> >  {
> > -     return sim->irqs[offset].irqnum;
> > +     return irq_find_mapping(sim->domain, offset);
> >  }
> >  EXPORT_SYMBOL_GPL(irq_sim_irqnum);
>
>
> Thanks,
>
>         M.
> --
> Without deviation from the norm, progress is not possible.

Hi Marc,

since we're so late in the release cycle and I really only need patch
3/9 from this series - I'll drop this patch and 1/9 as well in v3. We
can come back to this in the next cycle.

Bart
