Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B992C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B365C25115
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B365C25115
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933296AbeFZT4y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:56:54 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48061 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752109AbeFZT4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:56:51 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 05DAD2079D; Tue, 26 Jun 2018 21:56:49 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3E11D203B0;
        Tue, 26 Jun 2018 21:56:48 +0200 (CEST)
Date:   Tue, 26 Jun 2018 21:56:48 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Przemyslaw Gaj <pgaj@cadence.com>
Subject: Re: [PATCH v5 09/10] gpio: Add a driver for Cadence I3C GPIO
 expander
Message-ID: <20180626215648.1472b96e@bbrezillon>
In-Reply-To: <CAHp75Vdxg49q6aQj0dDpzM4q2WnQbGoCECWR1roda7aMR+u4gg@mail.gmail.com>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com>
        <20180622104930.32050-10-boris.brezillon@bootlin.com>
        <CAHp75Vdxg49q6aQj0dDpzM4q2WnQbGoCECWR1roda7aMR+u4gg@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, 26 Jun 2018 22:07:03 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Jun 22, 2018 at 1:49 PM, Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> > Add a driver for Cadence I3C GPIO expander.
> >
> > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>  
> 
> > +       scratchbuf = kmalloc(sizeof(*scratchbuf) * 2, GFP_KERNEL);  
> 
> kmalloc_array() ?
> 
> > +       ret = i3c_device_do_priv_xfers(gpioc->i3cdev, xfers,
> > +                                      ARRAY_SIZE(xfers));  
> 
> One line?
> 
> 
> > +static void cdns_i3c_gpio_set_multiple(struct gpio_chip *g,
> > +                                      unsigned long *mask,
> > +                                      unsigned long *bits)
> > +{
> > +       struct cdns_i3c_gpio *gpioc = gpioc_to_cdns_gpioc(g);
> > +       u8 newovr;
> > +       int ret;
> > +
> > +       newovr = (gpioc->ovr & ~(*mask)) | (*bits & *mask);
> > +       if (newovr == gpioc->ovr)
> > +               return;
> > +
> > +       ret = cdns_i3c_gpio_write_reg(gpioc, OVR, newovr);
> > +       if (!ret)
> > +               gpioc->ovr = newovr;  
> 
> You don't change mask here, why do you need a pointer to it?

What are you talking about??!!! This is part of the gpio_chip interface
that drivers have to implement. You can't decide that mask should not be
a pointer. And if you actually look at the code, you'll probably see
that the reason we're passed a pointer here is that the GPIO chip might
expose more GPIOs than can be represented by an unsigned long, hence
the array of unsigned long.

I'll say it here because this is not the first time I'm pissed off by
one of your review. You seem to review everything that is posted on the
LKML, and most of the time your reviews are superficial (focused on tiny
details or coding style issues). Don't you have better things to do?

I mean, I'm fine when I get such comments from people that also do
useful comments, but yours are most of the time useless and sometime
even wrong because you didn't time to look at the code in details.

> 
> > +}  
> 
> > +static int cdns_i3c_gpio_get_multiple(struct gpio_chip *g,
> > +                                     unsigned long *mask,
> > +                                     unsigned long *bits)
> > +{
> > +       struct cdns_i3c_gpio *gpioc = gpioc_to_cdns_gpioc(g);
> > +       int ret;
> > +       u8 ivr;
> > +
> > +       ret = cdns_i3c_gpio_read_reg(gpioc, IVR, &ivr);
> > +       if (ret)
> > +               return ret;
> > +
> > +       *bits = ivr & *mask & gpioc->dir;
> > +       *bits |= gpioc->ovr & *mask & ~gpioc->dir;  
> 
> Ditto.
> 
> > +
> > +       return 0;
> > +}  
> 
> > +static void cdns_i3c_gpio_ibi_handler(struct i3c_device *i3cdev,
> > +                                     const struct i3c_ibi_payload *payload)
> > +{
> > +       struct cdns_i3c_gpio *gpioc = i3cdev_get_drvdata(i3cdev);  
> 
> > +       u8 isr = 0;  
> 
> Perhaps you need to check the result of _read_reg() below instead of
> dummy assignment?
> 
> > +       int i;
> > +
> > +       cdns_i3c_gpio_read_reg(gpioc, ISR, &isr);  
> 
> > +       for (i = 0; i < 8; i++) {
> > +               unsigned int irq;
> > +
> > +               if (!(BIT(i) & isr & gpioc->imr))
> > +                       continue;  
> 
> for_each_set_bit() ?
> 
> > +
> > +               irq = irq_find_mapping(gpioc->gpioc.irq.domain, i);
> > +               handle_nested_irq(irq);
> > +       }
> > +}  
> 
> > +static const struct i3c_device_id cdns_i3c_gpio_ids[] = {
> > +       I3C_DEVICE(0x1c9, 0x0, NULL),  
> 
> > +       { /* sentinel */ },  
> 
> Slightly better without comma.
> 
> > +};
> > +MODULE_DEVICE_TABLE(i3c, cdns_i3c_gpio_ids);  
> 

