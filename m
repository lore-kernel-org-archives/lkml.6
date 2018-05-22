Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbeEVRJq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 13:09:46 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:51160 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1751240AbeEVRJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 13:09:45 -0400
Date: Tue, 22 May 2018 13:09:44 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: martin_liu <liumartin@google.com>
cc: gregkh@linuxfoundation.org, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] driver core: don't hold dev's parent lock when using async
 probe
In-Reply-To: <20180522141227.GA118442@google.com>
Message-ID: <Pine.LNX.4.44L0.1805221250480.1466-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2018, martin_liu wrote:

> SOC have internal I/O buses that can't be probed for devices. The
> devices on the buses can be accessed directly without additinal
> configuration required. This type of bus is represented as
> "simple-bus". In some platforms, we name "soc" with "simple-bus"
> attribute and many devices are hooked under and desribe them in DT
> (device tree).
> 
> In commit 'bf74ad5bc417 introduce ("[PATCH] Hold the device's
> parent's lock during probe and remove")' to solve USB subsystem
> lock sequence since usb device's characteristic. Thus "soc"
> needs to be locked whenever a device and driver's probing
> happen under "soc" bus. During this period, an async driver
> tries to probe a device which is under the "soc" bus would be
> blocked until previous driver finish the probing and release "soc"
> lock. And the next probing under the "soc" bus need to wait for
> async finish. Because of that, driver's async probe for init
> time improvement will be shadowed.
> 
> Since many devices don't have USB devices' characteristic, they
> actually don't need parent's lock. However, in order to control
> the risk and minimize the impact, we don't request parent's lock
> only when a driver requests async probe.
> 
> Async probe could have more benefit after we have this patch.
> 
> Signed-off-by: martin_liu <liumartin@google.com>
> ---
> This RFC is asked to get some feedback since it involed driver
> core and USB subsystem. I'm not familiar with USB subsystem and
> not sure if we still need 'bf74ad5bc417 ("[PATCH] Hold the
> device's parent's lock during probe and remove")' since it has
> been there over 10 years. If we still need it and hard to fix it
> , the simple way is to find a place not to allow USB subsystem
> drivers to have async probe capability. Any suggestion is welcome.

I don't think the "allows_async_probing" attribute is the best way to 
attack this.  Some other approach, like a special-purpose flag, might 
be better.

Yes, USB still needs to have parent's locks held during probing.  
Here's the reason.  A USB device can have multiple interfaces, each
bound to its own driver.  A driver may sometimes need to issue a reset,
but in USB there's no way to reset a single interface.  Only the entire
device can be reset, and of course this affects all the interfaces.  
Therefore a driver needs to acquire the device lock before it can issue
a reset.

The problem is that the driver's thread may already hold the device
lock.  During a normal probe sequence, for example, the interfaces get
probed by the hub driver while it owns the device lock.  But for probes
under other circumstances (for example, if the user writes to the
driver's "bind" attribute in sysfs), the device lock might not be held.

A driver cannot tell these two cases apart.  The only way to make it
work all the time is to have the caller _always_ hold the device lock
while the driver is probed (or the removed, for that matter).

Alan Stern
