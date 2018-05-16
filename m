Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752837AbeEPNOF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 09:14:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:64164 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751914AbeEPNOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 09:14:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="scan'208";a="49714492"
Message-ID: <354db10f9a239e04087ba7cf7d731d3fbe2ec066.camel@linux.intel.com>
Subject: Re: [PATCH] gpio: pca953x: Clear irq trigger type on irq shutdown
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Walleij <linus.walleij@linaro.org>,
        Grigoryev Denis <grigoryev@fastwel.ru>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Steve Longerbeam <slongerbeam@gmail.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Wed, 16 May 2018 16:14:00 +0300
In-Reply-To: <CACRpkdbn_8WUQ8oqn2+M6KpEEogLTMMqbJrp-d2=HEkjJ-XtDQ@mail.gmail.com>
References: <no_message-id@ru>
         <CACRpkdbn_8WUQ8oqn2+M6KpEEogLTMMqbJrp-d2=HEkjJ-XtDQ@mail.gmail.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-16 at 14:51 +0200, Linus Walleij wrote:
> On Fri, May 4, 2018 at 6:53 PM, Grigoryev Denis <grigoryev@fastwel.ru>
> wrote:
> 

If it's full context below, the patch looks good enough to me (assuming
it works and doesn't break things on other chips like PCAL variants).

Though, I didn't read the code carefully (not enough time this week).
Thus, FWIW, 

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

with above caveats in mind.

> > The driver stores the result of irq_set_type() in the internal
> > variables
> > irq_trig_raise and irq_trig_fall, which later are used to determine
> > the GPIOs that must be re-configured as input. These variables
> > retain their
> > value between gpiolib's  export / unexport, resulting in an
> > incorrect
> > state in some cases. The corresponding bits in the variables
> > irq_trig_raise and irq_trig_fall should be cleared in
> > irq_shutdown().
> > 
> > Signed-off-by: Denis Grigoryev <grigoryev@fastwel.ru>
> > ---
> >  drivers/gpio/gpio-pca953x.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-
> > pca953x.c
> > index d2ead4b..b41be8c 100644
> > --- a/drivers/gpio/gpio-pca953x.c
> > +++ b/drivers/gpio/gpio-pca953x.c
> > @@ -522,6 +522,15 @@ static int pca953x_irq_set_type(struct irq_data
> > *d, unsigned int type)
> >         return 0;
> >  }
> > 
> > +static void pca953x_irq_shutdown(struct irq_data *d)
> > +{
> > +       struct pca953x_chip *chip = irq_data_get_irq_chip_data(d);
> > +       u8 mask = 1 << (d->hwirq % BANK_SZ);
> > +
> > +       chip->irq_trig_raise[d->hwirq / BANK_SZ] &= ~mask;
> > +       chip->irq_trig_fall[d->hwirq / BANK_SZ] &= ~mask;
> > +}
> > +
> >  static struct irq_chip pca953x_irq_chip = {
> >         .name                   = "pca953x",
> >         .irq_mask               = pca953x_irq_mask,
> > @@ -529,6 +538,7 @@ static struct irq_chip pca953x_irq_chip = {
> >         .irq_bus_lock           = pca953x_irq_bus_lock,
> >         .irq_bus_sync_unlock    = pca953x_irq_bus_sync_unlock,
> >         .irq_set_type           = pca953x_irq_set_type,
> > +       .irq_shutdown           = pca953x_irq_shutdown,
> >  };
> 
> This driver has a big set of users, so putting some maintainers
> in the loop so we can get some patch review.
> 
> Yours,
> Linus Walleij

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
