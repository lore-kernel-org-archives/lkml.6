Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEFEC43A1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 22:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDDC420C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 22:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDDC420C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389533AbeGKWQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 18:16:04 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42927 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732561AbeGKWQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 18:16:04 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 73A74207B4; Thu, 12 Jul 2018 00:09:36 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id B33432069C;
        Thu, 12 Jul 2018 00:09:35 +0200 (CEST)
Date:   Thu, 12 Jul 2018 00:09:32 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 01/10] i3c: Add core I3C infrastructure
Message-ID: <20180712000932.3b04ee9d@bbrezillon>
In-Reply-To: <CAK8P3a2djk8c6STaxJC0MCkBddyOafk4WbG2LdfPf0V1EYiqmQ@mail.gmail.com>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
        <20180330074751.25987-2-boris.brezillon@bootlin.com>
        <CAK8P3a1aZXf2sQW2mgwJScycKPhdoOAwxRjm5cQG83513uc3fg@mail.gmail.com>
        <20180711164120.3e32fb08@bbrezillon>
        <CAK8P3a2EZB_tMS_47wv6M2Qpm79ZocxxhG5zLxXsBM_YjZgkyA@mail.gmail.com>
        <20180711191212.3855bb25@bbrezillon>
        <CAK8P3a2djk8c6STaxJC0MCkBddyOafk4WbG2LdfPf0V1EYiqmQ@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 22:10:26 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> n Wed, Jul 11, 2018 at 7:12 PM, Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> > On Wed, 11 Jul 2018 17:39:56 +0200 Arnd Bergmann <arnd@arndb.de> wrote:  
> >> On Wed, Jul 11, 2018 at 4:41 PM, Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> >>
> >> The problem that I see is that it breaks the tree abstraction that
> >> we use in the dtb interface, in the driver model and in sysfs.
> >> If we need to deal with a hardware bus structure like
> >>
> >>               cpu
> >>              /   \
> >>             /     \
> >>        platdev   platdev
> >>            |        |
> >>      i3c-master   i3c-master
> >>             \      /
> >>              \    /
> >>             i3c-bus
> >>              /    \
> >>          device   device
> >>
> >> then that abstraction no longer holds. Clearly you could build
> >> a system like that, and if we have to support it, the i3c infrastructure
> >> should be prepared for it, since we wouldn't be able to retrofit
> >> it later.  
> >
> > Exactly. For the DT representation I thought we could have the primary
> > master hold the device nodes, and then have secondary masters reference
> > the main master with a phandle (i3c-bus = <&main_i3c_master>;). For the
> > sysfs representation, it would be the same. Only one of the master
> > would create the i3c_bus object and the other masters would just
> > reference it.  
> 
> Ok.
> 
> >> What would be the point of building such a system though?  
> >
> > This, I don't know. But as you said, if we go for a "one bus per
> > master" representation, going back will be difficult.
> >  
> >> Is this for performance, failover, or something else?  
> >
> > No, I don't think so, especially since the mastership handover
> > operation is not free. So keeping the same master in control is
> > probably better in term of perfs.  
> 
> Right.
> 
> > One case I can think of is when the primary master does not have enough
> > resources to address all devices on the bus, and let the secondary
> > master handle all transactions targeting those devices.
> >  
> 
> 
> I've read the specification a bit more, and from what I found there,
> it seems extremely unlikely that there was an intended use case where
> one OS instance would control more than one master on a single bus
> and flip them between primary and secondary mode.
> 
> In particular, the protocol for the handover is defined in a way that
> intentionally avoids requiring a side channel to communicate data
> about the slave devices, and instead the secondary master(s) get
> informed about any changes of the topology as they happen
> through explicit messages.
> 
> The description of the secondary master labels the introduction section
> of says
> 
>      "I3C Smart Sensor(s) / Hub(s) / Engine(s)"
> 
> which sounds like some microcontroller that can act as a master of
> some sort, rather than being part of the OS itself.
> 
> I can see several use cases for this, e.g.
> 
> * A baseboard management controller booting first, reading all
>   the sensors and possibly loading its own OS from an i3c flash
>   before handing off control to the main CPU of a server and
>   no longer being a master
> 
> * A fan controller that occasionally wants to read temperature
>   sensors and control fan speed, while normally being a
>   secondary master. It periodically asks the OS to become
>   a master to read the sensors and then immediately hands back
>   control to the host OS as the master
> 
> * Two controllers inside of the same SoC, but one of them owned
>   by ARM Trustzone firmware or the Intel equivalent, the other
>   owned by the OS, both accessing the same slaves.
> 
> All of these require implementing handover between primary
> and secondary master, but Linux would still see a hierarchical
> bus structure, with the secondary masters looking like slave
> devices that might request being masters during some time.
> 
> We may also run into the requirement that a master we probe
> is currently the secondary master and has to probe the bus
> by asking the current master for the available devices, and
> then taking over.
> 
> >> IOW, what feature would we lose if we were to declare that
> >> setup above invalid (and ensure you cannot represent it in DT)?  
> >
> > That's exactly the sort of discussion I wanted to trigger. Maybe we
> > shouldn't care and expose this use case as if it was X different I3C
> > buses (with all devices present on the bus being exposed X times
> > to the system).  
> 
> That's probably fine for many slave devices (you could read a
> single sensor multiple times if you iterate through all i2c sensors
> on all buses) but might not work for others (a slave device sending
> an interrupt to the current master for a request that was started
> from the previous master).
> My impression however is that this is actually a corner case that
> we can leave to be undefined, and not prepare to handle well,
> as long as we can deal with the interesting examples above.

Mastership handover/takeover is something I already thought about.
Actually, that's the reason for the i3c_bus->cur_master field (so that
the master being asked to do a transfer on the bus can request bus
ownership it bus->cur_master != master->this->info.pid).

I guess this would be replaced by something simpler if we get rid of
the i3c_bus object (just a bool i3c_master->owns_bus). 

> 
> >> > The devices discovered on the bus are not directly registered to the
> >> > device model, and I need to store them in a list to do some operations
> >> > before exposing them. Once everything is ready to be used, I then
> >> > iterate the list and register all not-yet-registered I3C devs.  
> >>
> >> Can you explain what those operations are and why we can't
> >> register everything directly? This seems rather unconventional,
> >> so I want to make sure it's done for a good reason.  
> >
> > When we start a DAA operation (used to discover all devices on the
> > bus), we have the bus lock held in maintenance mode (AKA exclusive
> > mode). During this DAA the controller will add all the devices it has
> > discovered on the bus and let the core query information about those
> > devices (PID, DCR, HDR capabilies, SDR speed limitations, ...). It
> > might also happen that a device that had been discovered previously is
> > re-discovered because it had lost its dynamic address (i.e. when
> > the device had been reset but not by Linux). In this case the I3C
> > framework does not expose a new device but instead updates the dynamic
> > address of the device already registered to the device model, so that
> > new transactions initiated by the I3C device driver work correctly.
> > This is the very reason we hold the lock in exclusive mode (we want all
> > transactions to be stopped until we have updated dynamic addresses if
> > needed).
> >
> > Now, let's imagine you register the device when the bus lock is held in
> > exclusive mode, and the ->probe() function of the I3C driver needs to
> > do an I3C transfer => you end up with a deadlock.
> >
> > So what we do instead is add new devices to the i3c bus list, release
> > the bus lock and then register all new devices.  
> 
> Ok, but maybe you could you put the information about those devices
> on a local list on the stack rather than the controller? I suppose this
> would not change the logic much, but it would slightly simplify the
> data structures for the bus and stop others from wondering about
> them. ;-)

This has changed a bit in the v6 I'm about to send (probably next week).
I now have 2 different objects which do not necessarily have the same
lifetime:

* i3c_dev_desc: an I3C device descriptor. This is the representation
  exposed to I3C master controller drivers which usually reserve one
  slot in the HW device table per-device on the bus. Since the same
  device can be re-discovered with a different address, we have a short
  period in time during which the controller will have 2
  slots/descriptors used to control the same device, except one would
  be inactive (any transfer to the old dynamic address would fail) and
  the other one would be active. The core then takes care of releasing
  the old descriptor/slot and attaching the new one to the i3c_device
  object exposed to I3C device drivers

* i3c_device: this is the object exposed to I3C device drivers. It's
  lifetime is usually the same as the i3c_dev_desc it's attached to,
  except when the device lose its dynamic address and get a new one
  assigned. In this case we keep the same i3c_device object, but
  dynamically re-attach it to a new i3c_dev_desc before releasing the
  old dev desc. This way the I3C does not even see that the device
  address has changed and can keep doing transfers to it.

With these 2 distinct representations, the handling on the controller
side is greatly simplified: the core takes care of the resource
migration steps, while it was up to the controller to do that my
previous versions (look at the ->reattach_i3c_dev() hook in the Cadence
driver, and I think it's even more complicated with other controllers,
like the HCI one).

> This is a really minor point though, let's work out the problem of the
> multiple masters first.

I agree. This being said, moving to a representation where the bus is
implicitly represented by the master_controller instance shouldn't be
too difficult. So, if you think we should try this approach I can do
the modifications in my v6.
