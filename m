Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751957AbeFEPqj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:46:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751880AbeFEPqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:46:36 -0400
X-Google-Smtp-Source: ADUXVKJmRniyN4SuiWezhnn5KCipQS9gloAK3HmZH/Rz4iIJ/gsXAR4y3kfg46/XKq+HjcN8w+m7m1P3m9jeiHkXzs0=
MIME-Version: 1.0
In-Reply-To: <20180604113225.GE5150@localhost.localdomain>
References: <cover.1527669443.git.matti.vaittinen@fi.rohmeurope.com>
 <3b05ca98a671a762013c312f8b70543402ee7556.1527669443.git.matti.vaittinen@fi.rohmeurope.com>
 <20180531030129.GA16122@rob-hp-laptop> <20180531071717.GG13528@localhost.localdomain>
 <20180531102315.GA5150@localhost.localdomain> <CAL_Jsq+33G7zMEDOUXHQijxqqbvqykxZENLe1-52ECkXwo2o4g@mail.gmail.com>
 <20180601062540.GB5150@localhost.localdomain> <CAL_JsqJNMxR=zdwR41iLfWU=u3J_=_VkxVL+g3a12_4vvNwBtw@mail.gmail.com>
 <20180604113225.GE5150@localhost.localdomain>
From: Rob Herring <robh@kernel.org>
Date: Tue, 5 Jun 2018 10:46:14 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL3Z_o2CFeYDvb3PqgiskTSHuOVqwdUP+gFymLDTKhn2g@mail.gmail.com>
Message-ID: <CAL_JsqL3Z_o2CFeYDvb3PqgiskTSHuOVqwdUP+gFymLDTKhn2g@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] mfd: bd71837: Devicetree bindings for ROHM BD71837 PMIC
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-clk <linux-clk@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 4, 2018 at 6:32 AM, Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
> On Fri, Jun 01, 2018 at 12:32:16PM -0500, Rob Herring wrote:
>> On Fri, Jun 1, 2018 at 1:25 AM, Matti Vaittinen
>> <mazziesaccount@gmail.com> wrote:
>> > On Thu, May 31, 2018 at 09:07:24AM -0500, Rob Herring wrote:
>> >> On Thu, May 31, 2018 at 5:23 AM, Matti Vaittinen
>> >> <mazziesaccount@gmail.com> wrote:
>> >> > On Thu, May 31, 2018 at 10:17:17AM +0300, Matti Vaittinen wrote:
>> >> >> On Wed, May 30, 2018 at 10:01:29PM -0500, Rob Herring wrote:
>> >> >> > On Wed, May 30, 2018 at 11:42:03AM +0300, Matti Vaittinen wrote:
>> >> >> > > Document devicetree bindings for ROHM BD71837 PMIC MFD.
>> >> >> > > + - interrupts            : The interrupt line the device is connected to.
>> >> >> > > + - interrupt-controller  : Marks the device node as an interrupt controller.
>> >> >> >
>> >> >> > What sub blocks have interrupts?
>> >> >>
>> >> >> The PMIC can generate interrupts from events which cause it to reset.
>> >> >> Eg, irq from watchdog line change, power button pushes, reset request
>> >> >> via register interface etc. I don't know any generic handling for these
>> >> >> interrupts. In "normal" use-case this PMIC is powering the processor
>> >> >> where driver is running and I do not see reasonable handling because
>> >> >> power-reset is going to follow the irq.
>> >> >>
>> >> >
>> >> > Oh, but when reading this I understand that the interrupt-controller
>> >> > property should at least be optional.
>> >>
>> >> I don't think it should. The h/w either has an interrupt controller or
>> >> it doesn't.
>> >
>> > I hope this explains why I did this interrupt controller - please tell
>> > me if this is legitimate use-case and what you think of following:
>> >
>> > +Optional properties:
>> > + - interrupt-controller        : Marks the device node as an interrupt controller.
>> > +                         BD71837MWV can report different power state change
>> > +                         events to other devices. Different events can be seen
>> > +                         as separate BD71837 domain interrupts.
>>
>> To what other devices?
>
> Would it be better if I wrote "other drivers" instead? I think I've seen
> examples where MFD driver is just providing the interrupts for other
> drivers - like power-button input driver. Currently I have no such "irq
> consumer" drivers written. Still I would like to expose these interrupts
> so that they are ready for using if any platform using PMIC needs them.

No, worse. Interrupt binding describes interrupt connections between a
controller and devices (which could be sub-blocks in a device), not to
drivers.

I'm just curious as to what sub-blocks/devices there are. You don't
have to have a driver (yet) to define the devices.

>
> I think there are other similar drivers in tree. For example TPS6591x
> driver seems to be doing this. (Has MFD driver exposing the interrupts
> but no driver handling those). Maybe explanation like this would help:
>
> "The BD71837 driver only provides the infrastructure for the IRQs. The
> users can write his own driver to convert the IRQ into the event they
> wish. The IRQ can be used with the standard
> request_irq/enable_irq/disable_irq API inside the kernel." (I found this
> text from NXP forums and ruthlessly copied and modified it over here)

That's all OS details that have nothing to do with the binding. The
binding describes the h/w.

> If this is not feasible, then I will remove the irq handling from MFD
> (or leave code there but remove the binding information?) as I don't
> know what the irq handles should do in generic case.

I don't understand what you mean by generic. An IRQ has to be wired to
something. The only generic IRQs are GPIOs.

>> > + - #interrupt-cells    : The number of cells to describe an IRQ should be 1.
>> > +                           The first cell is the IRQ number.
>> > +                           masks from ../interrupt-controller/interrupts.txt.
>
> Sorry this "masks from ../interrupt-controller/interrupts.txt." was
> accidentally pasted here. I should have deleted it.
>
>> I'm still not clear. Generally in a PMIC, you'd define an interrupt
>> controller when there's a common set of registers to manage sub-block
>> interrupts (typical mask/unmask, ack regs) and the subblocks
>> themselves have control of masking/unmasking interrupts. If there's
>> not a need to have these 2 levels of interrupt handling, then you
>> don't really need to define an interrupt controller.
>
> And to clarify - the PMIC can generate irq via one irq line. This is
> typical ACTIVE_LOW irq with 8 bit "write 1 to clear" status register and
> 8 bit mask register. The role of interrupt-controller code here is just
> to allow these 8 irq reasons to be seen as individual BD71837 domain
> interrupts. I just don't have the driver(s) for handling these
> interrupts.

If what I'm asking for above is still not clear, what are the 8 bits
defined as or what are those 8 lines connected to?

>
>> >> My concern is you added it but nothing uses it which tells
>> >> me your binding is incomplete. I'd rather see complete bindings even
>> >> if you don't have drivers.
>> >
>> > So this makes me wonder if my use-case for interrupt controller is
>> > valid. I thought making this PMIC as interrupt controller is a nice way
>> > of hiding the irq register and i2c access from other potential drivers
>> > using these interrupts. But as I don't know what could be the potential
>> > user for these irqs, I don't know how to complete binding. This is why I
>> > also thought of making this optional, so that the potential for using
>> > the interrupts would be there but it was not required when interrupts
>> > are not needed.
>>
>> The only drivers getting these interrupts would be drivers for this
>> PMIC. Interrupts are handled by the driver owning the h/w that
>> generated the interrupt. I think that is the disconnect here.
>>
>> Take a power button. We don't create a generic power button interrupt
>> and then have some generic power button interrupt handler. We have a
>> handler for specifically for that device and then it generates a power
>> button press event.
>
> I think I understand this. Here we also have a 'power button' interrupt
> from PMIC (as one of the interrupts) here. But what happens when button
> is pressed depends on PMIC configuration. I guess we might want a power
> button driver here - and this power button driver might be correct user
> for the irq. So are you stating that I should write the power button
> driver (or some other "IRQ consumer") before adding the
> interrupt-controller property to bindings for MFD?

No. Bindings come before drivers.

>  Or should I just
> somehow state that irq X in BD71837 is a "power button short push"
> event and power button driver should be the consumer for it?

Yes, at least, but who is the consumer is an OS detail that is not
relevant to the binding. Ideally, you would describe the node with the
interrupts property for "irq X".

> Rest of the interrupts are not so obvious. I have no idea how I should
> handle rest of the interrupts. Those are interrupts which cause the PMIC
> to reset and cut the powers from most of the regulators too. I can
> easily think setup where one processor is controlling PMIC which powers
> for the other processor. And getting IRQ if for example watchdog reset
> the other processor would probably be very usefull. But doing any
> 'de-facto' handler for this is hard. Only generally usefull thing would
> be notifying the user-space but I don't think I should invent any new
> kernelspace - userspace interfaces for this. I believe that when such
> are needed those should be implemented by ones knowing the platform.

Don't think about the OS or driver details. Think about sub-blocks of
the hardware and the connections between them (like irqs) and to board
that need to be described in DT.

If you can't describe that, then you just probably shouldn't have
sub-nodes in DT (ever). Though adding later is easier than trying to
remove them.

>
> So please bear with me but do you mean I should
> a) document what conditions generate which IRQ
>    or
> b)  should I tell what kind of driver is needed for handling the IRQs
>    or
> c) should I first write code using IRQs before addinf MFD binding?

A.

> a) I can do.
> b) I think I can't do this for most of the irqs as in normal use-case
> the processor won't catch these as it is going to be powered down.
> c) I might be able to do this for power button IRQ but it might not be
> what user wants in the end.
>
>> >> My concern is you added it but nothing uses it which tells
>> >> me your binding is incomplete. I'd rather see complete bindings even
>> >> if you don't have drivers.
>
> Can you please tell if I misunderstood this?
>
> Br,
>     Matti Vaittinen
>
