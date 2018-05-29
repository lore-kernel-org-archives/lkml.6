Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934871AbeE2OHL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:07:11 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:45510 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S934175AbeE2OHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:07:09 -0400
Date: Tue, 29 May 2018 10:07:07 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: martin_liu <liumartin@google.com>
cc: heikki.krogerus@linux.intel.com, <johan@kernel.org>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <jenhaochen@google.com>
Subject: Re: [RFC PATCH v2] driver core: hold dev's parent lock when needed
In-Reply-To: <20180529070719.164626-1-liumartin@google.com>
Message-ID: <Pine.LNX.4.44L0.1805291003470.1458-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 May 2018, martin_liu wrote:

> SOC have internal I/O buses that can't be proved for devices. The
> devices on the buses can be accessed directly without additinal
> configuration required. This type of bus is represented as
> "simple-bus". In some platforms, we name "soc" with "simple-bus"
> attribute and many devices are hooked under it desribed in DT
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
> actually don't need parent's lock. Thus, we introduce a lock flag
> in device struct and driver core would lock the parent lock base
> on the flag. For usbsystem, we set this flag when its device and
> driver is matched and to keep original lock behavior in driver
> core.
> 
> Async probe could have more benefit after this patch.
> 
> Signed-off-by: martin_liu <liumartin@google.com>
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> ---
> Changes in v2:
>  - take Alan's suggestion to introudce a flag to guide driver
>    core to hold device parent's lock.
> 
> [v1]: https://lkml.org/lkml/2018/5/22/545
> 
> Currently, I have the flag set in USB subsystem match function.
> Since I'm not familar with USB part, need some feedback to know
> if they cover all the cases that original case driver core
> protects.

The match function is not the right place.  Take Greg's suggestion and 
put the new flag in the bus_type structure instead.

>  drivers/base/bus.c          | 16 ++++++++--------
>  drivers/base/dd.c           |  8 ++++----
>  drivers/usb/common/ulpi.c   | 16 ++++++++++++----
>  drivers/usb/core/driver.c   |  9 +++++++--
>  drivers/usb/core/usb-acpi.c |  6 +++++-
>  drivers/usb/serial/bus.c    |  4 +++-
>  include/linux/device.h      |  1 +
>  7 files changed, 40 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index ef6183306b40..18ea94caec02 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -184,10 +184,10 @@ static ssize_t unbind_store(struct device_driver *drv, const char *buf,
>  
>  	dev = bus_find_device_by_name(bus, NULL, buf);
>  	if (dev && dev->driver == drv) {
> -		if (dev->parent)	/* Needed for USB */
> +		if (dev->parent && dev->need_parent_lock)/* Needed for USB */

The new need_parent_lock flag is self-explanatory.  You can remove the 
"Needed for USB" comments here and elsewhere; instead just have a 
single comment where the flag is defined.

Alan Stern
