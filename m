Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754053AbeEaH1m (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 03:27:42 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40085 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753846AbeEaH1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 03:27:37 -0400
X-Google-Smtp-Source: ADUXVKLamS7I/fCeYALVUXph5iWkm7egUx1UB6n3KZg29lwJmO6G3v0FYCsUc4Fq5RgbTQkL1ouhXA==
Date: Thu, 31 May 2018 15:27:32 +0800
From: Martin Liu <liumartin@google.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
        heikki.krogerus@linux.intel.com, johan@kernel.org,
        andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, jenhaochen@google.com
Subject: Re: [PATCH v4] driver core: hold dev's parent lock when needed
Message-ID: <20180531072732.GA90146@google.com>
References: <20180530163135.50081-1-liumartin@google.com>
 <Pine.LNX.4.44L0.1805301319430.1502-100000@iolanthe.rowland.org>
 <20180531063118.GA7554@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531063118.GA7554@kroah.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 08:31:18AM +0200, Greg KH wrote:
> On Wed, May 30, 2018 at 01:21:02PM -0400, Alan Stern wrote:
> > On Thu, 31 May 2018, Martin Liu wrote:
> > 
> > > SoC have internal I/O buses that can't be proved for devices. The
> > > devices on the buses can be accessed directly without additinal
> > > configuration required. This type of bus is represented as
> > > "simple-bus". In some platforms, we name "soc" with "simple-bus"
> > > attribute and many devices are hooked under it described in DT
> > > (device tree).
> > > 
> > > In commit bf74ad5bc417 ("Hold the device's parent's lock during
> > > probe and remove") to solve USB subsystem lock sequence since
> > > USB device's characteristic. Thus "soc" needs to be locked
> > > whenever a device and driver's probing happen under "soc" bus.
> > > During this period, an async driver tries to probe a device which
> > > is under the "soc" bus would be blocked until previous driver
> > > finish the probing and release "soc" lock. And the next probing
> > > under the "soc" bus need to wait for async finish. Because of
> > > that, driver's async probe for init time improvement will be
> > > shadowed.
> > > 
> > > Since many devices don't have USB devices' characteristic, they
> > > actually don't need parent's lock. Thus, we introduce a lock flag
> > > in bus_type struct and driver core would lock the parent lock base
> > > on the flag. For USB, we set this flag in usb_bus_type to keep
> > > original lock behavior in driver core.
> > > 
> > > Async probe could have more benefit after this patch.
> > > 
> > > Signed-off-by: Martin Liu <liumartin@google.com>
> > > ---
> > > Changes in v4:
> > >  -fix comment and wording.
> > >  -follow the suggestion.
> > > 
> > > [v3]: https://lkml.org/lkml/2018/5/29/876
> > > [v2]: https://lkml.org/lkml/2018/5/29/108
> > > [v1]: https://lkml.org/lkml/2018/5/22/545
> > > 
> > >  drivers/base/bus.c        | 16 ++++++++--------
> > >  drivers/base/dd.c         |  8 ++++----
> > >  drivers/usb/core/driver.c |  1 +
> > >  include/linux/device.h    |  3 +++
> > >  4 files changed, 16 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> > > index ef6183306b40..8bfd27ec73d6 100644
> > > --- a/drivers/base/bus.c
> > > +++ b/drivers/base/bus.c
> > > @@ -184,10 +184,10 @@ static ssize_t unbind_store(struct device_driver *drv, const char *buf,
> > >  
> > >  	dev = bus_find_device_by_name(bus, NULL, buf);
> > >  	if (dev && dev->driver == drv) {
> > > -		if (dev->parent)	/* Needed for USB */
> > > +		if (dev->parent && dev->bus->need_parent_lock)
> > >  			device_lock(dev->parent);
> > >  		device_release_driver(dev);
> > > -		if (dev->parent)
> > > +		if (dev->parent && dev->bus->need_parent_lock)
> > >  			device_unlock(dev->parent);
> > >  		err = count;
> > >  	}
> > > @@ -211,12 +211,12 @@ static ssize_t bind_store(struct device_driver *drv, const char *buf,
> > >  
> > >  	dev = bus_find_device_by_name(bus, NULL, buf);
> > >  	if (dev && dev->driver == NULL && driver_match_device(drv, dev)) {
> > > -		if (dev->parent)	/* Needed for USB */
> > > +		if (dev->parent && bus->need_parent_lock)
> > >  			device_lock(dev->parent);
> > >  		device_lock(dev);
> > >  		err = driver_probe_device(drv, dev);
> > >  		device_unlock(dev);
> > > -		if (dev->parent)
> > > +		if (dev->parent && bus->need_parent_lock)
> > >  			device_unlock(dev->parent);
> > >  
> > >  		if (err > 0) {
> > > @@ -735,10 +735,10 @@ static int __must_check bus_rescan_devices_helper(struct device *dev,
> > >  	int ret = 0;
> > >  
> > >  	if (!dev->driver) {
> > > -		if (dev->parent)	/* Needed for USB */
> > > +		if (dev->parent && dev->bus->need_parent_lock)
> > >  			device_lock(dev->parent);
> > >  		ret = device_attach(dev);
> > > -		if (dev->parent)
> > > +		if (dev->parent && dev->bus->need_parent_lock)
> > >  			device_unlock(dev->parent);
> > >  	}
> > >  	return ret < 0 ? ret : 0;
> > > @@ -770,10 +770,10 @@ EXPORT_SYMBOL_GPL(bus_rescan_devices);
> > >  int device_reprobe(struct device *dev)
> > >  {
> > >  	if (dev->driver) {
> > > -		if (dev->parent)        /* Needed for USB */
> > > +		if (dev->parent && dev->bus->need_parent_lock)
> > >  			device_lock(dev->parent);
> > >  		device_release_driver(dev);
> > > -		if (dev->parent)
> > > +		if (dev->parent && dev->bus->need_parent_lock)
> > >  			device_unlock(dev->parent);
> > >  	}
> > >  	return bus_rescan_devices_helper(dev, NULL);
> > > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > > index c9f54089429b..7c09f73b96f3 100644
> > > --- a/drivers/base/dd.c
> > > +++ b/drivers/base/dd.c
> > > @@ -817,13 +817,13 @@ static int __driver_attach(struct device *dev, void *data)
> > >  		return ret;
> > >  	} /* ret > 0 means positive match */
> > >  
> > > -	if (dev->parent)	/* Needed for USB */
> > > +	if (dev->parent && dev->bus->need_parent_lock)
> > >  		device_lock(dev->parent);
> > >  	device_lock(dev);
> > >  	if (!dev->driver)
> > >  		driver_probe_device(drv, dev);
> > >  	device_unlock(dev);
> > > -	if (dev->parent)
> > > +	if (dev->parent && dev->bus->need_parent_lock)
> > >  		device_unlock(dev->parent);
> > >  
> > >  	return 0;
> > > @@ -919,7 +919,7 @@ void device_release_driver_internal(struct device *dev,
> > >  				    struct device_driver *drv,
> > >  				    struct device *parent)
> > >  {
> > > -	if (parent)
> > > +	if (parent && dev->bus->need_parent_lock)
> > >  		device_lock(parent);
> > >  
> > >  	device_lock(dev);
> > > @@ -927,7 +927,7 @@ void device_release_driver_internal(struct device *dev,
> > >  		__device_release_driver(dev, parent);
> > >  
> > >  	device_unlock(dev);
> > > -	if (parent)
> > > +	if (parent && dev->bus->need_parent_lock)
> > >  		device_unlock(parent);
> > >  }
> > >  
> > > diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> > > index 9792cedfc351..e76e95f62f76 100644
> > > --- a/drivers/usb/core/driver.c
> > > +++ b/drivers/usb/core/driver.c
> > > @@ -1922,4 +1922,5 @@ struct bus_type usb_bus_type = {
> > >  	.name =		"usb",
> > >  	.match =	usb_device_match,
> > >  	.uevent =	usb_uevent,
> > > +	.need_parent_lock =	true,
> > >  };
> > > diff --git a/include/linux/device.h b/include/linux/device.h
> > > index 477956990f5e..beca424395dd 100644
> > > --- a/include/linux/device.h
> > > +++ b/include/linux/device.h
> > > @@ -98,6 +98,8 @@ extern void bus_remove_file(struct bus_type *, struct bus_attribute *);
> > >   * @lock_key:	Lock class key for use by the lock validator
> > >   * @force_dma:	Assume devices on this bus should be set up by dma_configure()
> > >   * 		even if DMA capability is not explicitly described by firmware.
> > > + * @need_parent_lock:	When probing or removing a device on this bus, the
> > > + *			device core should lock the device's parent.
> > >   *
> > >   * A bus is a channel between the processor and one or more devices. For the
> > >   * purposes of the device model, all devices are connected via a bus, even if
> > > @@ -138,6 +140,7 @@ struct bus_type {
> > >  	struct lock_class_key lock_key;
> > >  
> > >  	bool force_dma;
> > > +	bool need_parent_lock;
> > >  };
> > >  
> > >  extern int __must_check bus_register(struct bus_type *bus);
> > 
> > This looks okay to me.
> > 
> > Acked-by: Alan Stern <stern@rowland.harvard.edu>
> > 
> > Greg, any more comments?
> 
> Looks sane to me.  Martin, thanks for all of the changes.
> 
> greg k-h

Great thank Alan, Greg and Andy for helpful hints and feedback.
Many Thanks!

Martin
