Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E75C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4522320855
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="XBMg4IDq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbfBLKh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:37:58 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33645 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfBLKh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:37:57 -0500
Received: by mail-ot1-f67.google.com with SMTP id i20so3648160otl.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1XrINfiykEItjpkj9w/akl+IWNcNz4ULWAKxX25eP+o=;
        b=XBMg4IDqI9/0xng1Ga7XXJd5PZJSBUlvr21ts27NbxquTpY7Ca0ULjAHMKxl58ahEF
         /GalBcRXUzdW700de8hcsamlo7m36OtKHGLr9wL+NBSXxsjaVZkaE25HzR1J9eoNuM89
         Kd2lk5O0pCE23wVVM86PXqz6QD6/gzyPkMUYynjm42Go4IQcCq9F3jiMKLP55l3A8oLg
         dMfiI504oHEOZhImbwJ8h/KnxNAhoDNLx9t8o0cTDCDqgOGqz6WFHWhd3e8hFIUwqad/
         ORXRSC6xOF12PFXmfTliV4ZUGr2UmfHg2oxvM3SPi4Mr0VZIPy10S/rC7uMR6sjCMWIc
         SUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1XrINfiykEItjpkj9w/akl+IWNcNz4ULWAKxX25eP+o=;
        b=jgQxwX2Z1LwwuAkqsaMS0T/Tq3dOkA4EZMSFRDXLCFLQ8PRbh5GojxhscIW0FpwH9J
         a2HWb+uJ688WF/J2tlOtHDWk4bgWEleGy0d+Fmn0HW3HehQwMBnecBQl4o8XihOyVYM7
         DKMSI5ZQuBCyFuOjIBbPFckIblTaGuc4bp8yOofDFni9U4OZfJ76eLkqyoKGTY04DLRy
         lkQJ3aLEjlNhl7lMZf0tLwAwcHhtr5IQUhdjI/0UPi5oTJBFhU7Vk2K9Bf5KjHIHjZxZ
         uHpaQf2rXM55oNh1zSAnM6v8mNT3UTTD4yRi8dQOnoMF9sXaN7tOCA1Dw1FQOBjVJ8A5
         rL4Q==
X-Gm-Message-State: AHQUAuZOpnlllxE0K661IZATJxkNQeh+bjKW652R57t04VMiP4bzL284
        zC41wxKg9OIiiAtR7Y6bsfm6Va3+4ImPINNVXmAKlg==
X-Google-Smtp-Source: AHgI3IbVGlB8RoByxbKt67QJ5ebMCO2BOBiVvtRHMgylxHvq6peitmvROKI1dvBxX54MLqTIfBTU0cZ/762K3OUYj4k=
X-Received: by 2002:a9d:32c7:: with SMTP id u65mr2925784otb.236.1549967876645;
 Tue, 12 Feb 2019 02:37:56 -0800 (PST)
MIME-Version: 1.0
References: <20190129084411.30495-1-brgl@bgdev.pl> <20190129084411.30495-4-brgl@bgdev.pl>
 <656763ec-41b9-cdee-22bd-1f32d74473a0@arm.com> <CAMpxmJXdyiSLyx7O5G41GzfJQktOS1JeuRUoHejVB3ZOmCFMLQ@mail.gmail.com>
 <c562c67d-d6e3-15c3-b10b-315e8fb181a5@arm.com>
In-Reply-To: <c562c67d-d6e3-15c3-b10b-315e8fb181a5@arm.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 12 Feb 2019 11:37:45 +0100
Message-ID: <CAMpxmJWyxhjWrUVCePeg=g6uA=LEEbVBHGXTMQJ95jav4Zhyvg@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] irq/irq_sim: provide irq_sim_fire_type()
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

wt., 12 lut 2019 o 11:27 Marc Zyngier <marc.zyngier@arm.com> napisa=C5=82(a=
):
>
> On 12/02/2019 09:19, Bartosz Golaszewski wrote:
> > wt., 12 lut 2019 o 10:10 Marc Zyngier <marc.zyngier@arm.com> napisa=C5=
=82(a):
> >>
> >> On 29/01/2019 08:44, Bartosz Golaszewski wrote:
> >>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>>
> >>> Provide a more specialized variant of irq_sim_fire() that allows to
> >>> specify the type of the fired interrupt. The type is stored in the
> >>> dummy irq context struct via the set_type callback.
> >>>
> >>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>> ---
> >>>  include/linux/irq_sim.h |  9 ++++++++-
> >>>  kernel/irq/irq_sim.c    | 26 ++++++++++++++++++++++----
> >>>  2 files changed, 30 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/include/linux/irq_sim.h b/include/linux/irq_sim.h
> >>> index b96c2f752320..647a6c8ffb31 100644
> >>> --- a/include/linux/irq_sim.h
> >>> +++ b/include/linux/irq_sim.h
> >>> @@ -23,6 +23,7 @@ struct irq_sim_work_ctx {
> >>>
> >>>  struct irq_sim_irq_ctx {
> >>>       bool                    enabled;
> >>> +     unsigned int            type;
> >>>  };
> >>>
> >>>  struct irq_sim {
> >>> @@ -37,7 +38,13 @@ int irq_sim_init(struct irq_sim *sim, unsigned int=
 num_irqs);
> >>>  int devm_irq_sim_init(struct device *dev, struct irq_sim *sim,
> >>>                     unsigned int num_irqs);
> >>>  void irq_sim_fini(struct irq_sim *sim);
> >>> -void irq_sim_fire(struct irq_sim *sim, unsigned int offset);
> >>> +void irq_sim_fire_type(struct irq_sim *sim,
> >>> +                    unsigned int offset, unsigned int type);
> >>>  int irq_sim_irqnum(struct irq_sim *sim, unsigned int offset);
> >>>
> >>> +static inline void irq_sim_fire(struct irq_sim *sim, unsigned int of=
fset)
> >>> +{
> >>> +     irq_sim_fire_type(sim, offset, IRQ_TYPE_DEFAULT);
> >>> +}
> >>> +
> >>>  #endif /* _LINUX_IRQ_SIM_H */
> >>> diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
> >>> index 2bcdbab1bc5a..e3160b5e59b8 100644
> >>> --- a/kernel/irq/irq_sim.c
> >>> +++ b/kernel/irq/irq_sim.c
> >>> @@ -25,6 +25,15 @@ static void irq_sim_irqunmask(struct irq_data *dat=
a)
> >>>       irq_ctx->enabled =3D true;
> >>>  }
> >>>
> >>> +static int irq_sim_set_type(struct irq_data *data, unsigned int type=
)
> >>> +{
> >>> +     struct irq_sim_irq_ctx *irq_ctx =3D irq_data_get_irq_chip_data(=
data);
> >>> +
> >>> +     irq_ctx->type =3D type;
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>>  static void irq_sim_handle_irq(struct irq_work *work)
> >>>  {
> >>>       struct irq_sim_work_ctx *work_ctx;
> >>> @@ -107,6 +116,7 @@ int irq_sim_init(struct irq_sim *sim, unsigned in=
t num_irqs)
> >>>       sim->chip.name =3D "irq_sim";
> >>>       sim->chip.irq_mask =3D irq_sim_irqmask;
> >>>       sim->chip.irq_unmask =3D irq_sim_irqunmask;
> >>> +     sim->chip.irq_set_type =3D irq_sim_set_type;
> >>>
> >>>       sim->work_ctx.pending =3D bitmap_zalloc(num_irqs, GFP_KERNEL);
> >>>       if (!sim->work_ctx.pending) {
> >>> @@ -192,21 +202,29 @@ irq_sim_get_ctx(struct irq_sim *sim, unsigned i=
nt offset)
> >>>  }
> >>>
> >>>  /**
> >>> - * irq_sim_fire - Enqueue an interrupt.
> >>> + * irq_sim_fire_type - Enqueue an interrupt.
> >>>   *
> >>>   * @sim:        The interrupt simulator object.
> >>>   * @offset:     Offset of the simulated interrupt which should be fi=
red.
> >>> + * @type:    Type of the fired interrupt. Must be one of the followi=
ng:
> >>> + *           IRQ_TYPE_EDGE_RISING, IRQ_TYPE_EDGE_FALLING,
> >>> + *           IRQ_TYPE_EDGE_BOTH, IRQ_TYPE_LEVEL_HIGH,
> >>> + *           IRQ_TYPE_LEVEL_LOW, IRQ_TYPE_DEFAULT
> >>>   */
> >>> -void irq_sim_fire(struct irq_sim *sim, unsigned int offset)
> >>> +void irq_sim_fire_type(struct irq_sim *sim,
> >>> +                    unsigned int offset, unsigned int type)
> >>>  {
> >>>       struct irq_sim_irq_ctx *ctx =3D irq_sim_get_ctx(sim, offset);
> >>>
> >>> -     if (ctx->enabled) {
> >>> +     /* Only care about relevant flags. */
> >>> +     type &=3D IRQ_TYPE_SENSE_MASK;
> >>> +
> >>> +     if (ctx->enabled && (ctx->type & type)) {
> >>
> >> I wonder how realistic this is, given that you do not track the releas=
e
> >> of a level. In short, mo matter what the type is, you treat everything
> >> as edge.
> >>
> >> What is the point of this?
> >>
> >
> > When userspace wants to monitor GPIO line interrupts, the GPIO
> > framework requests a threaded interrupt with IRQF_TRIGGER_FALLING,
> > IRQF_TRIGGER_RISING or both. The testing module tries to act like real
> > hardware and so if we pass only one of the *_TRIGGER_* flags, we want
> > the simulated interrupt of corresponding type to be fired.
>
> Well, that's not how HW works.
>
> >
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
>

This logic is later taken care of in the gpio-mockup driver in this
series. It checks the line state changes and decides if the interrupt
should be fired.

Bart

> At the moment, I don't see any of that so I seriously doubt the validity
> of the approach.
>
