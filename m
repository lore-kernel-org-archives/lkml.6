Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA99EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947AF21916
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GgHfOp2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390588AbeLUNU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 08:20:58 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38564 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390546AbeLUNU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 08:20:58 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so4709084lja.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 05:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UpYgmDKLNNKvJPCOccXOf6lekehYzAffVI2buOwkTAc=;
        b=GgHfOp2jdxN1VnDGAJr3mECszxR+9dX7jsvKckX0EB9A+KGMjsQMwJqfTsPafXpqlX
         709dNquvMvpigwPsDfUtGojW3Z3a6wz5o1zrWYZ0Vo/VHv6B7YFOO9G9SpCfKC0j1NDk
         f0r/Et1OymqOlqhF/n4pmLy8VevHypt1ie+6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UpYgmDKLNNKvJPCOccXOf6lekehYzAffVI2buOwkTAc=;
        b=hVcraFhWvP1bonYNH2m88KXs44G4oCegJSNaJ4nz1zLZJnBJCMoYXPK6LfYYSK/w5M
         5cGmbF3rfWrk2RuOTb4fP4tWrpv130ladyIKZ+iGH8x61dCa3t6S9rP4QoJUDTFXWWjl
         0Jzo6tth3mUHJGu6yINB5OZezklz+kFELjjAEhCIOQhTkctBuUM51dC3m2RbvxltGYA4
         W/rnMupURIyV3fjxJeWmRAjVIIcETKZmJvDqTAK8cgwLywyOoGelCPRXTPhn9LR+RG2p
         FU1n0pL3r05qG25zl8RB5Fq6Y+lT39192Yfno2RYBMTbT+cnX5+lWXpqqcTYWc5Iyycf
         U4xQ==
X-Gm-Message-State: AJcUukd3Rw5sNMopCw76jTwjHy+/Z2+YhxOZTKoBQvRp8mZiE2c9Nerd
        huyNJneM4M351+Wg61QuYoa1lps3hoAno/Rvc+bWIw==
X-Google-Smtp-Source: ALg8bN6zz5ikxFK7EwwdG4l8fq5O09X9+bqo5Jstk3KFnoXUfi4kfmosqXP6RgqCQjaHev4Z0s9KxjwJXbnzsCBMXzE=
X-Received: by 2002:a2e:7e04:: with SMTP id z4-v6mr642138ljc.97.1545398453504;
 Fri, 21 Dec 2018 05:20:53 -0800 (PST)
MIME-Version: 1.0
References: <20181129170312.23625-1-thierry.reding@gmail.com>
 <20181129170312.23625-2-thierry.reding@gmail.com> <CACRpkdYhgCsr2w-MgwdLDvcZXDhkvn2_sgvGW8VskK1=3kVASw@mail.gmail.com>
 <20181218220652.GB4227@mithrandir>
In-Reply-To: <20181218220652.GB4227@mithrandir>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Dec 2018 14:20:41 +0100
Message-ID: <CACRpkdY-mfADtyxhR1LRDSrOidrekRao-M97niBi9cwpf+cstg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] gpio: Add support for hierarchical IRQ domains
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brian Masney <masneyb@onstation.org>,
        NeilBrown <neil@brown.name>, Marc Zyngier <marc.zyngier@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc:ing Neil Brown who might hit me on the fingers for
some statements here, let's see :)

On Tue, Dec 18, 2018 at 11:06 PM Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Fri, Dec 14, 2018 at 02:41:01PM +0100, Linus Walleij wrote:

> > > -       gpiochip->to_irq = gpiochip_to_irq;
> > > +       /*
> > > +        * Allow GPIO chips to override the ->to_irq() if they really need to.
> > > +        * This should only be very rarely needed, the majority should be fine
> > > +        * with gpiochip_to_irq().
> > > +        */
> > > +       if (!gpiochip->to_irq)
> > > +               gpiochip->to_irq = gpiochip_to_irq;
> >
> > And I see this is what your driver does, which leaves the default
> > domain hierarchy callback path unused.
>
> Actually this is only temporary until the patch that uses a sparse
> number space (with the valid masks). After the last patch in the series
> the need to override this goes away, so I could follow-up with a patch
> to revert this. Or alternatively we could squash the two Tegra patches.
> I think keeping them separate is slightly nicer.

OK then!

> Of course, I would even prefer to not move to the sparse number space,
> but you seemed to feel very strongly about it last time we discussed
> this.

Admittedly it is one of those things where I am working on intuition
and as such it may be wrong.

The main reason in this case is to keep interfaces simple.
Of course "simple" is a bit subjective. But keeping to a
certain predictable pattern makes things easier to understand
as long as the pattern is somewhat reasonable.

This pattern I think it is related to the irqdomains: in the
irqdomains a linear irqdomain with dynamically allocated
IRQ descriptors from a sparse number space is clearly
preferred.

By similarity and the fact that we are mapping GPIOs to
IRQs here, I think it is more intuitive and less confusing
to use a linear GPIO offset range and dynamically
allocated GPIO descriptors.

Today we do not allocate GPIO descriptors
dynamically, they are allocated as part of the gpiochip
struct. But I do see it as an end goal to allocate them
dynamically or at least not allocate GPIO descriptors for
the "holes" in the .valid_mask.

> > It's better if you indirect the pointer like we do with some other
> > irqchip stuff (see Hans Verkuils patches), i.e. if ->to_irq
> > is defined, we save that function pointer and call that at the
> > end of the gpiochip_to_irq() pointer, then we override it
> > with our own.
> >
> > Since the Tegra186 clearly .to_irq() clearly is mostly the
> > same plus some extra, this should work fine and give
> > lesser lines of code in that driver.
>
> That sounds an awful lot like a midlayer. I'm not a big fan of that at
> all. There are various reasons for this, but others have described it in
> much better detail than I could. See here for example:
>
>         https://lwn.net/Articles/336262/

Reading that article I do not think gpiolib qualifies as midlayer,
since it is after all optional and not every driver uses it, so
it is available on a case-by-case basis. The article even says:

"That common functionality which it is so tempting to put in a
midlayer should instead be provided as library routines which
can used, augmented, or ignored by each bottom level
driver independently."

Contrast that by the SCSI emulation in libata: is it even
possible to bypass? Not really, no. gpiolib is not like that.

> In this particular case one potential problem is that gpiochip_to_irq()
> might not always do the right things for everyone, and that it turn may
> incentivize people to work around it creatively. For example, one driver
> may want to perform some operation before gpiochip_to_irq() is called,
> while another driver may have to perform an operation after the call. If
> you move towards a midlayer there's no way to satisfy both, unless you
> go and add pre- and post-operations of some sort.

I don't really buy into that.

gpiochip_to_irq() is *ONLY* a translation mechanism. The main
abstraction is and should be irqchip.

In usecases like device tree the same device exposes a
gpiochip API and an irqchip API and those two are supposed
to be orthogonal. The Documentation/driver-api/gpio/driver.rst
says:

--------8<----------8<--------8<--------8<--------
It is legal for any IRQ consumer to request an IRQ from any irqchip no matter
if that is a combined GPIO+IRQ driver. The basic premise is that gpio_chip and
irq_chip are orthogonal, and offering their services independent of each
other.

gpiod_to_irq() is just a convenience function to figure out the IRQ for a
certain GPIO line and should not be relied upon to have been called before
the IRQ is used.

So always prepare the hardware and make it ready for action in respective
callbacks from the GPIO and irqchip APIs. Do not rely on gpiod_to_irq() having
been called first.

This orthogonality leads to ambiguities that we need to solve: if there is
competition inside the subsystem which side is using the resource (a certain
GPIO line and register for example) it needs to deny certain operations and
keep track of usage inside of the gpiolib subsystem. This is why the API
below exists.
--------8<----------8<--------8<--------8<--------

So now indeed it seems that your implementation actually
has a bug here. I didn't see it before: if we make use of
the irq off the irqchip without gpiochip_to_irq() having
been called before, will the (hierarchical) IRQ still work?

Much of the idea and reason behind GPIOLIB_IRQCHIP is
to make sure this can hold true.

So this hunk of your original patch:

+       if (irq_domain_is_hierarchy(domain)) {
+               struct irq_fwspec spec;
+
+               spec.fwnode = domain->fwnode;
+               spec.param_count = 2;
+               spec.param[0] = offset;
+               spec.param[1] = 0;
+
+               return irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, &spec);
+       }

Is probably misplaced: gpiochip_to_irq() should really
only contain irq_create_mapping() which is what will
also be done by the device tree (or ACPI, I hope) core
when providing an irq as a resource.

The snippet above needs to go somewhere else, if it
needs to happen before any of the irqchip callbacks
then just loop over all the IRQs in
gpiochip_add_irqchip() and allocate IRQs for all valid
IRQs from the start as a last resort I suppose.

A last alternative would be to assume that all other ways
an IRQ is mapped (besides using gpiochip_to_irq()) will
also do the same thing. E.g, you would have to go into
drivers/of/irq.c and patch irq_of_parse_and_map()
to do the same thing. This is the site that creates the
mapping when .to_irq() is not called in the DT case.

Maybe the DT or irqchip maintainers can give a better
answer to how this should happen. Relying on .to_irq()
to always be called is certainly not the answer. We already
did that mistake in the past :(

> I'd like to propose that we instead provide gpiochip_to_irq() as a
> helper that drivers can call into.

>        static int foo_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
>        {
>                /* do something before */
>                ...
>
>               err = gpiochip_to_irq(chip, offset);
>               if (err < 0)
>                       return err;
>
>               /* do something after */
>               ...
>       }

Under your assumptions that is fine, and the same reason as to
why we control pins and regulators and clock in callbacks from
say .suspend() instead of enforcing a certain order. It could be
necessary if the translation gets complicated enough.

But right now I am mostly worried that this implementation does
not cover for the fact that we have to make sure that hierarchical
irqchips in gpiolib work even if .to_irq() was not called first.

Yours,
Linus Walleij
