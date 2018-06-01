Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751385AbeFAGZ7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 02:25:59 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35704 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeFAGZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 02:25:56 -0400
X-Google-Smtp-Source: ADUXVKI/o55n1GNrd76XaCkuD0+9tda0DBrTVg/kiQBmOSyUbWsGbk6PSWqYmfuLbJcM9p52/pKQXw==
From: Matti Vaittinen <mazziesaccount@gmail.com>
X-Google-Original-From: Matti Vaittinen <mvaittin@localhost.localdomain>
Date: Fri, 1 Jun 2018 09:25:40 +0300
To: Rob Herring <robh@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-clk <linux-clk@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v4 2/6] mfd: bd71837: Devicetree bindings for ROHM
 BD71837 PMIC
Message-ID: <20180601062540.GB5150@localhost.localdomain>
References: <cover.1527669443.git.matti.vaittinen@fi.rohmeurope.com>
 <3b05ca98a671a762013c312f8b70543402ee7556.1527669443.git.matti.vaittinen@fi.rohmeurope.com>
 <20180531030129.GA16122@rob-hp-laptop>
 <20180531071717.GG13528@localhost.localdomain>
 <20180531102315.GA5150@localhost.localdomain>
 <CAL_Jsq+33G7zMEDOUXHQijxqqbvqykxZENLe1-52ECkXwo2o4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+33G7zMEDOUXHQijxqqbvqykxZENLe1-52ECkXwo2o4g@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 09:07:24AM -0500, Rob Herring wrote:
> On Thu, May 31, 2018 at 5:23 AM, Matti Vaittinen
> <mazziesaccount@gmail.com> wrote:
> > On Thu, May 31, 2018 at 10:17:17AM +0300, Matti Vaittinen wrote:
> >> On Wed, May 30, 2018 at 10:01:29PM -0500, Rob Herring wrote:
> >> > On Wed, May 30, 2018 at 11:42:03AM +0300, Matti Vaittinen wrote:
> >> > > Document devicetree bindings for ROHM BD71837 PMIC MFD.
> >> > > + - interrupts            : The interrupt line the device is connected to.
> >> > > + - interrupt-controller  : Marks the device node as an interrupt controller.
> >> >
> >> > What sub blocks have interrupts?
> >>
> >> The PMIC can generate interrupts from events which cause it to reset.
> >> Eg, irq from watchdog line change, power button pushes, reset request
> >> via register interface etc. I don't know any generic handling for these
> >> interrupts. In "normal" use-case this PMIC is powering the processor
> >> where driver is running and I do not see reasonable handling because
> >> power-reset is going to follow the irq.
> >>
> >
> > Oh, but when reading this I understand that the interrupt-controller
> > property should at least be optional.
> 
> I don't think it should. The h/w either has an interrupt controller or
> it doesn't.

I hope this explains why I did this interrupt controller - please tell
me if this is legitimate use-case and what you think of following:

+Optional properties:
+ - interrupt-controller	: Marks the device node as an interrupt controller.
+			  BD71837MWV can report different power state change
+			  events to other devices. Different events can be seen
+			  as separate BD71837 domain interrupts.
+ - #interrupt-cells	: The number of cells to describe an IRQ should be 1.
+			    The first cell is the IRQ number.
+			    masks from ../interrupt-controller/interrupts.txt.

> My concern is you added it but nothing uses it which tells
> me your binding is incomplete. I'd rather see complete bindings even
> if you don't have drivers.

So this makes me wonder if my use-case for interrupt controller is
valid. I thought making this PMIC as interrupt controller is a nice way
of hiding the irq register and i2c access from other potential drivers
using these interrupts. But as I don't know what could be the potential
user for these irqs, I don't know how to complete binding. This is why I
also thought of making this optional, so that the potential for using
the interrupts would be there but it was not required when interrupts
are not needed.

> For example, as-is, there's not really any
> need for the clocks child node. You can just make the parent a clock
> provider.

This sounds correct. I just lack of knowledge on how to handle clocks
in "standard way" using the clock framework and this was a result of
my first attempt. (Funny, I have written clk / synchronization drivers
for work in the past but still I have no idea on how to do this in
"standard way").

> But we need a complete picture of the h/w to make that
> determination.

My attempt is to create generic driver for this PMIC. I would rather not
limit it's use to any particular board/soc. The example binding is based
on my test environment where I simply connected this PMIC break out
board to beagle bone black. (I do also have a test board where i.MX8 and
peripherials are powered by this PMIC but I rather not limit this driver
to such single setup. Besides the linux running on that board is not
'standard')

The PMIC itself just has this 32.768 KHz clock output. Clock can be
enabled/disabled via register interface. I think this is intended to be
used for RTC but I thought this driver does not need to care about that.
I thought it is just a good idea to provide control via clk subsystem
and to not make assumptions on use-cases in this driver.

Best Regards
    Matti Vaittinen
