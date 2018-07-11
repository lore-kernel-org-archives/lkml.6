Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C50AC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391E720C0D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 391E720C0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390117AbeGKRRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 13:17:33 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36133 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388374AbeGKRRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 13:17:33 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 09D4B20766; Wed, 11 Jul 2018 19:12:14 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4C945203D9;
        Wed, 11 Jul 2018 19:12:13 +0200 (CEST)
Date:   Wed, 11 Jul 2018 19:12:12 +0200
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
Message-ID: <20180711191212.3855bb25@bbrezillon>
In-Reply-To: <CAK8P3a2EZB_tMS_47wv6M2Qpm79ZocxxhG5zLxXsBM_YjZgkyA@mail.gmail.com>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
        <20180330074751.25987-2-boris.brezillon@bootlin.com>
        <CAK8P3a1aZXf2sQW2mgwJScycKPhdoOAwxRjm5cQG83513uc3fg@mail.gmail.com>
        <20180711164120.3e32fb08@bbrezillon>
        <CAK8P3a2EZB_tMS_47wv6M2Qpm79ZocxxhG5zLxXsBM_YjZgkyA@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 17:39:56 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Wed, Jul 11, 2018 at 4:41 PM, Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> > On Wed, 11 Jul 2018 16:01:56 +0200 Arnd Bergmann <arnd@arndb.de> wrote:  
> >> > - the bus element is a separate object and is not implicitly described
> >> >   by the master (as done in I2C). The reason is that I want to be able
> >> >   to handle multiple master connected to the same bus and visible to
> >> >   Linux.
> >> >   In this situation, we should only have one instance of the device and
> >> >   not one per master, and sharing the bus object would be part of the
> >> >   solution to gracefully handle this case.
> >> >   I'm not sure we will ever need to deal with multiple masters
> >> >   controlling the same bus and exposed under Linux, but separating the
> >> >   bus and master concept is pretty easy, hence the decision to do it
> >> >   like that.
> >> >   The other benefit of separating the bus and master concepts is that
> >> >   master devices appear under the bus directory in sysfs.  
> >>
> >> I'm not following here at all, sorry for missing prior discussion if this
> >> was already explained. What is the "multiple master" case? Do you
> >> mean multiple devices that are controlled by Linux and that each talk
> >> to other devices on the same bus, multiple operating systems that
> >> have talk to are able to own the bus with the kernel being one of
> >> them, a controller that controls multiple independent buses,
> >> or something else?  
> >
> > I mean several masters connected to the same bus and all exposed to the
> > same Linux instance. In this case, the question is, should we have X
> > I3C buses exposed (X being the number of masters) or should we only
> > have one?
> >
> > Having a bus represented as a separate object allows us to switch to
> > the "one bus : X masters" representation if we need too.  
> ...
> >>
> >> This feels a bit odd: so you have bus_type that can contain devices
> >> of three (?) different device types: i3c_device_type, i3c_master_type
> >> and i3c_busdev_type.
> >>
> >> Generally speaking, we don't have a lot of subsystems that even
> >> use device_types. I assume that the i3c_device_type for a
> >> device that corresponds to an endpoint on the bus, but I'm
> >> still confused about the other two, and why they are part of
> >> the same bus_type.  
> >
> > i3c_busdev is just a virtual device representing the bus itself.
> > i3c_master is representing the I3C master driving the bus. The reason
> > for having a different type here is to avoid attaching this device to a
> > driver but still being able to see the master controller as a device on
> > the bus. And finally, i3c_device are all remote devices that can be
> > accessed through a given i3c_master.
> >
> > This all comes from the design choice I made to represent the bus as a
> > separate object in order to be able to share it between different
> > master controllers exposed through the same Linux instance. Since
> > master controllers are also remote devices for other controllers, we
> > need to represent them.  
> 
> Ok, so I think this is the most important question to resolve: do we
> actually need to control multiple masters on a single bus from one OS
> or not?
> 
> The problem that I see is that it breaks the tree abstraction that
> we use in the dtb interface, in the driver model and in sysfs.
> If we need to deal with a hardware bus structure like
> 
>               cpu
>              /   \
>             /     \
>        platdev   platdev
>            |        |
>      i3c-master   i3c-master
>             \      /
>              \    /
>             i3c-bus
>              /    \
>          device   device
> 
> then that abstraction no longer holds. Clearly you could build
> a system like that, and if we have to support it, the i3c infrastructure
> should be prepared for it, since we wouldn't be able to retrofit
> it later.

Exactly. For the DT representation I thought we could have the primary
master hold the device nodes, and then have secondary masters reference
the main master with a phandle (i3c-bus = <&main_i3c_master>;). For the
sysfs representation, it would be the same. Only one of the master
would create the i3c_bus object and the other masters would just
reference it.

> 
> What would be the point of building such a system though?

This, I don't know. But as you said, if we go for a "one bus per
master" representation, going back will be difficult.

> Is this for performance, failover, or something else?

No, I don't think so, especially since the mastership handover
operation is not free. So keeping the same master in control is
probably better in term of perfs.

One case I can think of is when the primary master does not have enough
resources to address all devices on the bus, and let the secondary
master handle all transactions targeting those devices.

> IOW, what feature would we lose if we were to declare that
> setup above invalid (and ensure you cannot represent it in DT)?

That's exactly the sort of discussion I wanted to trigger. Maybe we
shouldn't care and expose this use case as if it was X different I3C
buses (with all devices present on the bus being exposed X times to the
system).

> 
> >> > +/**
> >> > + * struct i3c_ccc_mwl - payload passed to SETMWL/GETMWL CCC
> >> > + *
> >> > + * @len: maximum write length in bytes
> >> > + *
> >> > + * The maximum write length is only applicable to SDR private messages or
> >> > + * extended Write CCCs (like SETXTIME).
> >> > + */
> >> > +struct i3c_ccc_mwl {
> >> > +       __be16 len;
> >> > +} __packed;  
> >>
> >> I would suggest only marking structures as __packed that are not already
> >> naturally packed. Note that a side-effect of __packed is that here
> >> alignof(struct i3c_ccc_mwl) will be '1', and architectures without efficient
> >> unaligned access will have to access the field one byte at a time because
> >> they assume that it may be misaligned.  
> >
> > These are structure used to create packets to be sent on the wire.
> > Making sure that everything is packed correctly is important, so I'm
> > not sure I can remove the __packed everywhere.  
> 
> I mean just the ones for which the __packed attribute only changes
> the alignment of the outer structure but not the layout inside of the
> structure. Alternatively, set both __packed and __aligned().

Ok.

> 
> >> > +/**
> >> > + * struct i3c_i2c_dev - I3C/I2C common information
> >> > + * @node: node element used to insert the device into the I2C or I3C device
> >> > + *       list
> >> > + * @bus: I3C bus this device is connected to
> >> > + * @master: I3C master that instantiated this device. Will be used to send
> >> > + *         I2C/I3C frames on the bus
> >> > + * @master_priv: master private data assigned to the device. Can be used to
> >> > + *              add master specific information
> >> > + *
> >> > + * This structure is describing common I3C/I2C dev information.
> >> > + */
> >> > +struct i3c_i2c_dev {
> >> > +       struct list_head node;
> >> > +       struct i3c_bus *bus;
> >> > +       struct i3c_master_controller *master;
> >> > +       void *master_priv;
> >> > +};  
> >>
> >> I find this hard to follow, which means either this has to be complicated
> >> and I just didn't take enough time to think it through, or maybe it can
> >> be simplified.
> >>
> >> The 'node' field seems particularly odd, can you explain what it's
> >> for? Normally all children of a bus device can be enumerated by
> >> walking the device model structures. Are you doing this just so
> >> you can walk a single list rather than walking the i3c and i2c
> >> devices separately?  
> >
> > The devices discovered on the bus are not directly registered to the
> > device model, and I need to store them in a list to do some operations
> > before exposing them. Once everything is ready to be used, I then
> > iterate the list and register all not-yet-registered I3C devs.  
> 
> Can you explain what those operations are and why we can't
> register everything directly? This seems rather unconventional,
> so I want to make sure it's done for a good reason.

When we start a DAA operation (used to discover all devices on the
bus), we have the bus lock held in maintenance mode (AKA exclusive
mode). During this DAA the controller will add all the devices it has
discovered on the bus and let the core query information about those
devices (PID, DCR, HDR capabilies, SDR speed limitations, ...). It
might also happen that a device that had been discovered previously is
re-discovered because it had lost its dynamic address (i.e. when
the device had been reset but not by Linux). In this case the I3C
framework does not expose a new device but instead updates the dynamic
address of the device already registered to the device model, so that
new transactions initiated by the I3C device driver work correctly.
This is the very reason we hold the lock in exclusive mode (we want all
transactions to be stopped until we have updated dynamic addresses if
needed).

Now, let's imagine you register the device when the bus lock is held in
exclusive mode, and the ->probe() function of the I3C driver needs to
do an I3C transfer => you end up with a deadlock.

So what we do instead is add new devices to the i3c bus list, release
the bus lock and then register all new devices.
