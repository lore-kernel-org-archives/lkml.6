Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965972AbeE2StK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:49:10 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:46568 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S965610AbeE2StH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:49:07 -0400
Date: Tue, 29 May 2018 14:49:06 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Martin Liu <liumartin@google.com>
cc: gregkh@linuxfoundation.org, <heikki.krogerus@linux.intel.com>,
        <johan@kernel.org>, <andy.shevchenko@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <jenhaochen@google.com>
Subject: Re: [RFC PATCH v3] driver core: hold dev's parent lock when needed
In-Reply-To: <20180529163428.234106-1-liumartin@google.com>
Message-ID: <Pine.LNX.4.44L0.1805291441110.1458-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2018, Martin Liu wrote:

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
> in bus_type struct and driver core would lock the parent lock base
> on the flag. For usbsystem, we set this flag in usb relatvie
> bus_type struct to keep original lock behavior in driver core.
> 
> Async probe could have more benefit after this patch.
> 
> Signed-off-by: Martin Liu <liumartin@google.com>
> ---
> Changes in v3:
>  -move lock flag to bus_type struct and set the flag in usb
>  relative bus_type struct to keep original lock behavior.
>  -fix sign name.
> 
> [v2]: https://lkml.org/lkml/2018/5/29/108
> [v1]: https://lkml.org/lkml/2018/5/22/545
> 
> Currently, I have the flag set in USB relatvie bus_type struct.
> Since I'm not familar with USB part, need some feedback to know
> if they cover all the cases that original case driver core
> protects. Thanks.

As far as I know, only usb_bus_type needs the flag.  Not ulpi_bus or
usb_serial_bus_type.  However, you should check with the maintainers to
make sure.

> diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
> index 9a2ab6751a23..073954a1a1c5 100644
> --- a/drivers/usb/common/ulpi.c
> +++ b/drivers/usb/common/ulpi.c
> @@ -94,6 +94,7 @@ static struct bus_type ulpi_bus = {
>  	.uevent = ulpi_uevent,
>  	.probe = ulpi_probe,
>  	.remove = ulpi_remove,
> +	.need_parent_lock = 1,
>  };
>  
>  /* -------------------------------------------------------------------------- */
> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index 9792cedfc351..209ee5d8a92d 100644
> --- a/drivers/usb/core/driver.c
> +++ b/drivers/usb/core/driver.c
> @@ -1922,4 +1922,5 @@ struct bus_type usb_bus_type = {
>  	.name =		"usb",
>  	.match =	usb_device_match,
>  	.uevent =	usb_uevent,
> +	.need_parent_lock =	1,
>  };
> diff --git a/drivers/usb/serial/bus.c b/drivers/usb/serial/bus.c
> index 9e265eb92611..55b2636b2804 100644
> --- a/drivers/usb/serial/bus.c
> +++ b/drivers/usb/serial/bus.c
> @@ -166,6 +166,7 @@ struct bus_type usb_serial_bus_type = {
>  	.probe =	usb_serial_device_probe,
>  	.remove =	usb_serial_device_remove,
>  	.drv_groups = 	usb_serial_drv_groups,
> +	.need_parent_lock =	1,
>  };
>  
>  int usb_serial_bus_register(struct usb_serial_driver *driver)
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 477956990f5e..019b193aeb24 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -98,6 +98,8 @@ extern void bus_remove_file(struct bus_type *, struct bus_attribute *);
>   * @lock_key:	Lock class key for use by the lock validator
>   * @force_dma:	Assume devices on this bus should be set up by dma_configure()
>   * 		even if DMA capability is not explicitly described by firmware.
> + * @need_parent_lock:	Assume devices on this bus should hold its' parent's
> + *			lock during probe and remove. Currently, USB needs it.

This comment is not written very well.  Suggested improvement:

 * @need_parent_lock:	When probing or removing a device on this bus, the 
			device core should lock the device's parent.

If you want, you can say that usb_bus_type sets the flag.  I don't
think it's really necessary to mention this.

Alan Stern
