Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD5EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B4721852
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbeLRPEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:04:02 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:52862 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726947AbeLRPEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:04:00 -0500
Received: (qmail 2561 invoked by uid 2102); 18 Dec 2018 10:03:59 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Dec 2018 10:03:59 -0500
Date:   Tue, 18 Dec 2018 10:03:59 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrew Worsley <amworsley@gmail.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jon Flatley <jflat@chromium.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bin Liu <b-liu@ti.com>, Benson Leung <bleung@chromium.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent race condition between USB authorisation and
 USB discovery events
In-Reply-To: <CA+Y=x3mHS4h13dTe4549Zcir5w3U54wJjyuaAa802=brp_FpeQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1812180957040.1402-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018, Andrew Worsley wrote:

> On Tue, 18 Dec 2018 at 03:21, Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Mon, 17 Dec 2018, Andrew Worsley wrote:
> >
> > > A sysfs driven USB authorisation change can trigger a usb_set_configuration
> > > while a hub_event worker thread is running. This can result in a USB device
> > > being disabled just after it was configured and bringing down all the
> > > devices and impacting hardware and user processes that were established on
> > > top of this these interfaces. In some cases the USB disable never completed
> > > and the whole system hung.
> >
> > Can you be more specific about this?  Disabling a USB device shouldn't
> > cause these kinds of problems, regardless of whether or not the device
> > was just configured.
> 
> I can't say too much about the hardware - but there was an SPI bus and
> an i2c bus built
> on top of USB devices on a bus. It appears the SPI bus shutdown was
> the item that was prone
> to problems when being torn down.
> 
> I understand it would be better if the dependant systems shutdown
> cleanly, which it
> did about 75% of the time but then it was rather messy sequence. So
> the current system
> is far from ideal. The crux of the issue is the usb_disable_device()
> (line 1874 of drivers/usb/core/message.c)
> call in usb_set_configuration() is applied to a configured device and
> triggers the
> tear down of all the devices built on that USB device and is very disruptive.

This is intentional.  When a USB device is disabled, nothing that
depends on it is supposed to survive.  However in spite of all the
disruption, nothing should hang.

> > > At my work I had an occasional hang due to this race condition. Roughly 1
> > > in 50 boots had the race occurrence and 1 in 4 of those resulted in a hang.
> > > This patch fixed the problem and I had no problems (spurious disables
> > > or hangs) in 750+ boots.
> >
> > usb_authorize_device, usb_deauthorize_device, and hub_event all acquire
> > the device mutex.  Why should adding another mutex make any difference?
> 
> I believe the new usb_authorize_mutex prevents the cascade of USB
> device bus scans,
> discoveries and probes from colliding with those caused a change in
> USB bus authorisation.
> The individual device / hub locks are not across the whole system,
> only an individual
> component hub/device so any logic that gives an orderly USB device
> scanning and probing is
> undermined. The idea of the mutex is to keep the USB device discovery
> work when a device is
> added/removed/powered up is separated from those that are caused by
> authorisation changes.
> 
> I don't pretend to understand all the logic and sequencing of the
> current code which works works
> faultlessly when these threads are serialised by the mutex (750+
> times) in boot ups which
> build up the system and shutdowns which bring down the system.
> Likewise if I endlessly run
> the authorisation off / on by itself it is faultless over hundreds of
> iterations.

Can you post a dmesg log that illustrates the problem with dynamic
debugging enabled for the usbcore module?

> > In fact there's an actual disadvantage: Making hub_event acquire a
> > global mutex will prevent us from handling multiple hubs concurrently.
> > Although we don't do this now, we might want to in the future.
> >
> > Alan Stern
> 
> This is true - I am not trying to serialise the hub_event() threads -
> but to prevent the authorisation changes
> from happening during the hub_event threads. So perhaps there would be
> a way of allowing multiple
> concurrent hub_events from happening but only one authorisation thread
> at a time. Assuming multiple
> hub_event()s are deemed ok. Something like a lock which allows
> multiple readers but only a single exclusive
> writer lock?

It's not that simple.  There are other ways a USB device can be
disabled that don't involve authorization.  For example, the user can
do:

	echo 0 >/sys/bus/usb/devices/.../bConfigurationValue

(the ... gets filled in with the device's path).  This should cause
just as much disruption.

The locking we already have is supposed to prevent the sort of problem 
you are seeing.  To find out why it doesn't, we need more information.

Alan Stern

