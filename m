Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbeFDXJq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 19:09:46 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33420 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751409AbeFDXJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 19:09:45 -0400
Date: Tue, 5 Jun 2018 01:09:32 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Richard Weinberger <richard@nod.at>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 5/6 v2] mtd: rawnand: ams-delta: use GPIO lookup table
Message-ID: <20180605010932.5c97b1de@bbrezillon>
In-Reply-To: <1716431.jBl9UCSIdH@z50>
References: <CAHp75Ved2nw1JKnXT2Jxnw4XLsby1eVJU6cfBjE2sp4LP4Kwmg@mail.gmail.com>
        <1582841.uoaVdad1fL@z50>
        <20180604115543.3be75717@bbrezillon>
        <1716431.jBl9UCSIdH@z50>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Jun 2018 18:48:08 +0200
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> On Monday, June 4, 2018 11:55:43 AM CEST Boris Brezillon wrote:
> > On Wed, 30 May 2018 22:39:03 +0200
> > 
> > Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:  
> > > On Wednesday, May 30, 2018 7:52:20 PM CEST Boris Brezillon wrote:  
> > > > On Wed, 30 May 2018 19:43:09 +0200
> > > > 
> > > > Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:  
> > > > > On Wednesday, May 30, 2018 11:05:00 AM CEST Boris Brezillon wrote:  
> > > > > > Hi Janusz,  
> > > > > 
> > > > > Hi Boris,
> > > > >   
> > > > > > On Sat, 26 May 2018 00:20:45 +0200
> > > > > > 
> > > > > > Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:  
> > > > > > > ...
> > > > > > > Changes since v1:
> > > > > > > - fix handling of devm_gpiod_get_optional() return values - thanks
> > > > > > > to
> > > > > > > 
> > > > > > >   Andy Shevchenko.  
> > > > > > 
> > > > > > Can you put the changelog after the "---" separator so that it does
> > > > > > not
> > > > > > appear in the final commit message?  
> > > > > 
> > > > > Yes, sure, sorry for that.
> > > > >   
> > > > > > > +err_gpiod:
> > > > > > > +	if (err == -ENODEV || err == -ENOENT)
> > > > > > > +		err = -EPROBE_DEFER;  
> > > > > > 
> > > > > > Hm, isn't it better to make gpiod_find() return
> > > > > > ERR_PTR(-EPROBE_DEFER)
> > > > > > here [1]? At least, ENOENT should not be turned into EPROBE_DEFER,
> > > > > > because it's returned when there's no entry matching the requested
> > > > > > gpio
> > > > > > in the lookup table, and deferring the probe won't solve this
> > > > > > problem.  
> > > > > 
> > > > > ENOENT is also returned when no matching lookup table is found. That
> > > > > may
> > > > > happen if consumer dev_name stored in the table differs from dev_name
> > > > > assigned to the consumer by its bus, the platform bus in this case.
> > > > > For
> > > > > that reason I think the consumer dev_name should be initialized in the
> > > > > table after the device is registered, when its actual dev_name can be
> > > > > obtained. If that device registration happens after the driver is
> > > > > already
> > > > > registered, e.g., at late_initcall, the device is probed before its
> > > > > lookup table is ready. For that reason returning EPROBE_DEFER seems
> > > > > better to me even in the ENOENT case.  
> > > > 
> > > > Sorry, I don't get it. Aren't GPIO lookup tables supposed to be declared
> > > > in board files, especially if the GPIO is used by a platform device?
> > > > When would you have a lookup table registered later in the init/boot
> > > > process?  
> > > 
> > > When e.g. I'd like to register my GPIO consumer platform device at
> > > late_initcall for some reason, and I'm not sure what exact dev_name my
> > > consomer will be registered with by the platform bus.  
> > 
> > You should know the name before the device is registered.  
> 
> What if I use PLATFORM_DEVID_AUTO?

In this case, the id assigned to the device will be dependent on the
device registration order, which in case of C board files should be
predictable. Am I missing something?

> 
> For other cases, if bus specific names of devices were supposed to be known 
> before registration, bus drivers should export functions returning those names 
> from initialized bus specific device structures or their components while they 
> don't. Under such circumstances, we end up hardcoding device names based on 
> our knowledge of bus internals if we need to specify them in advance, and 
> those internals are not guaranteed to never change.

But, when it comes to C board files, device names are known ahead of
time, right? And the only use case I see for those gpio_lookup_table is
non-DT platforms.

I had a quick look at a few call-sites of gpiod_add_lookup_table() and
couldn't find an example where the gpio lookup table was registered
after the platform device it was meant to be used by. If you have such
an example, can you point it to me?

> 
> > > In that case I think I
> > > should assign dev_name to the lookup table after the consumer device is
> > > registered and its exact dev_name can be obtained, then register the
> > > table,  
> > 
> > I'm pretty sure it's not supposed to work like that. Resources attached
> > to a device should be defined before the device is registered, not
> > after,  
> 
> What do you mean by resources attached to a device? I don't think we should 
> consider GPIO lookup tables as consumer device resources.

Why? If the device requires a GPIO to be controlled by the SoC, why
shouldn't we consider the GPIO as a resource. Sure, it's not part of
the struct resource array attached to the platform_device, but it's
still a resource that needs to be available for the driver to correctly
probe the device.

> Those tables are 
> registered separately from consumer device registration and I know of no 
> requirement for registering them in advance. Maybe I'm missing something.

But that doesn't make sense. Why would you register a device, and only
then attach it the description of the GPIOs it needs. Think about
the DT case, and imagine you support DT overlays, it's like having an
overlay that defines your device, and then another overlay that adds the
xx-gpios props to this device on top.

> 
> Let's have a look at regulators. There are no separately registered regulator 
> lookup tables, instead regulator consumer supply tables are attached to bus 
> specific device structures of regulator devices, not their consumers, hence 
> registered together with providers, not consumers. Will you still call those 
> tables 'resources attached to' consumers?

Except the gpio-lookup tables are not here to describe GPIOs, but to
give consumer-oriented friendly names so that the consumer can then do

	 devm_gpiod_get(&pdev->dev, "foo", GPIOD_OUT_LOW);

Here "foo" is only meaningful to pdev, and not globally exposed, and
another driver might pretty well request the exact same GPIO using a
different name.

> 
> As far as I can see, regulator_get() never returns -EINVAL, only -ENODEV or -
> EPROBE_DEFER. However, gpiod_get() can also return -EINVAL. Maybe it 
> shouldn't, but it does, and I'm just trying to adopt to that in order to not 
> break a driver I'm trying to update.

Well, IMO it should return EINVAL if no entry in the registered lookup
tables is matching the requested "dev_name(dev) + con_id" pair. I'm
bringing back my analogy with the DT case. What you're suggesting
would be similar to waiting for a new xxx-gpios prop to magically
appear in the DT.

Note that the GPIO itself is not necessarily ready to be used when the
consumer calls devm_gpio_get(), because the GPIO chip might not be
probed yet or it might be missing a dependency. And that's all fine, we
have EPROBE_DEFER for that. But that's different than saying "we don't
have a GPIO description attached to the device, let's wait for someone
to create one".

> 
> > simply because when you call platform_device_register(), the
> > device might be directly bind to the driver before the
> > platform_device_register() calls return, and the driver will fail to
> > probe the device if it doesn't find the GPIO it needs.  
> 
> That's exactly the case I'm talking about, but my conclusion is different: the 
> driver should fail softly so the device is probed again later, as long as I'm 
> not wrong the no requirement exists for registering GPIO lookup tables before 
> related consumers are registered.

How long. Why should we wait only after late init calls? What if the
lookup table is created after that?

> 
> If I' missing something or you are still not convinced, I'll try to resolve 
> issues with the device I see in a different way and submit a new patch that 
> hopefully matches your requirements.

Maybe I'm wrong, but I still think that registering a lookup table
after the pdev it will be used by is a bad idea.

Regards,

Boris
