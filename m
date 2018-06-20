Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA06C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBA420872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FBA420872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753619AbeFTMrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 08:47:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52668 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750793AbeFTMrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 08:47:53 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C741C20787; Wed, 20 Jun 2018 14:47:50 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1D07520714;
        Wed, 20 Jun 2018 14:47:50 +0200 (CEST)
Date:   Wed, 20 Jun 2018 14:47:50 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v4 01/10] i3c: Add core I3C infrastructure
Message-ID: <20180620144750.521f102a@bbrezillon>
In-Reply-To: <1567bbe1-0f11-4cc8-e501-6c8589570259@ti.com>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
        <20180330074751.25987-2-boris.brezillon@bootlin.com>
        <1567bbe1-0f11-4cc8-e501-6c8589570259@ti.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sekhar,

On Wed, 20 Jun 2018 17:07:53 +0530
Sekhar Nori <nsekhar@ti.com> wrote:

> Hi Boris,
> 
> On Friday 30 March 2018 01:17 PM, Boris Brezillon wrote:
> > Add core infrastructure to support I3C in Linux and document it.
> > 
> > This infrastructure is not complete yet and will be extended over
> > time.
> > 
> > There are a few design choices that are worth mentioning because they
> > impact the way I3C device drivers can interact with their devices:
> > 
> > - all functions used to send I3C/I2C frames must be called in
> >   non-atomic context. Mainly done this way to ease implementation, but
> >   this is still open to discussion. Please let me know if you think
> >   it's worth considering an asynchronous model here
> > - the bus element is a separate object and is not implicitly described
> >   by the master (as done in I2C). The reason is that I want to be able
> >   to handle multiple master connected to the same bus and visible to
> >   Linux.
> >   In this situation, we should only have one instance of the device and
> >   not one per master, and sharing the bus object would be part of the
> >   solution to gracefully handle this case.
> >   I'm not sure we will ever need to deal with multiple masters
> >   controlling the same bus and exposed under Linux, but separating the
> >   bus and master concept is pretty easy, hence the decision to do it
> >   like that.  
> 
> There can only be one current master in I3C, so not sure of this
> scenario.

Yes, there's only one active master at any time, but still, you can
have several masters (one primary and several secondary masters)
connected to the same bus, and you might even have several of them
controlled by the same Linux instance (don't really see a use case for
that right now, but I'm pretty sure this will happen).
The point of having a single bus instance pointed by various I3C masters
in this case is to avoid exposing several times the same I3C device.
If we don't do that we would have one I3C device instance per I3C master
exposed under Linux even though they all control the same physical
device.

> But agree with bus and master separation.
> 
> >   The other benefit of separating the bus and master concepts is that
> >   master devices appear under the bus directory in sysfs.
> > - I2C backward compatibility has been designed to be transparent to I2C
> >   drivers and the I2C subsystem. The I3C master just registers an I2C
> >   adapter which creates a new I2C bus. I'd say that, from a
> >   representation PoV it's not ideal because what should appear as a
> >   single I3C bus exposing I3C and I2C devices here appears as 2
> >   different busses connected to each other through the parenting (the
> >   I3C master is the parent of the I2C and I3C busses).
> >   On the other hand, I don't see a better solution if we want something
> >   that is not invasive.
> > 
> > Missing features in this preliminary version:
> > - I3C HDR modes are not supported
> > - no support for multi-master and the associated concepts (mastership
> >   handover, support for secondary masters, ...)
> > - I2C devices can only be described using DT because this is the only
> >   use case I have. However, the framework can easily be extended with
> >   ACPI and board info support
> > - I3C slave framework. This has been completely omitted, but shouldn't
> >   have a huge impact on the I3C framework because I3C slaves don't see
> >   the whole bus, it's only about handling master requests and generating
> >   IBIs. Some of the struct, constant and enum definitions could be
> >   shared, but most of the I3C slave framework logic will be different
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>  
> 
> > diff --git a/drivers/Makefile b/drivers/Makefile
> > index 24cd47014657..999239dc29d4 100644
> > --- a/drivers/Makefile
> > +++ b/drivers/Makefile
> > @@ -111,7 +111,7 @@ obj-$(CONFIG_SERIO)		+= input/serio/
> >  obj-$(CONFIG_GAMEPORT)		+= input/gameport/
> >  obj-$(CONFIG_INPUT)		+= input/
> >  obj-$(CONFIG_RTC_LIB)		+= rtc/
> > -obj-y				+= i2c/ media/
> > +obj-y				+= i2c/ i3c/ media/
> >  obj-$(CONFIG_PPS)		+= pps/
> >  obj-y				+= ptp/
> >  obj-$(CONFIG_W1)		+= w1/
> > diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
> > new file mode 100644
> > index 000000000000..cf3752412ae9
> > --- /dev/null
> > +++ b/drivers/i3c/Kconfig
> > @@ -0,0 +1,24 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +menuconfig I3C
> > +	tristate "I3C support"
> > +	select I2C
> > +	help
> > +	  I3C is a serial protocol standardized by the MIPI alliance.
> > +
> > +	  It's supposed to be backward compatible with I2C while providing
> > +	  support for high speed transfers and native interrupt support
> > +	  without the need for extra pins.
> > +
> > +	  The I3C protocol also standardizes the slave device types and is
> > +	  mainly design to communicate with sensors.  
> 
> designed

Will fix that.

> 
> > +
> > +	  If you want I3C support, you should say Y here and also to the
> > +	  specific driver for your bus adapter(s) below.
> > +
> > +	  This I3C support can also be built as a module.  If so, the module
> > +	  will be called i3c.
> > +
> > diff --git a/drivers/i3c/core.c b/drivers/i3c/core.c
> > new file mode 100644
> > index 000000000000..d6d938a785a9
> > --- /dev/null
> > +++ b/drivers/i3c/core.c  
> 
> > +static ssize_t bcr_show(struct device *dev,
> > +			struct device_attribute *da,
> > +			char *buf)
> > +{
> > +	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
> > +	struct i3c_bus *bus = i3c_device_get_bus(i3cdev);
> > +	ssize_t ret;
> > +
> > +	i3c_bus_normaluse_lock(bus);
> > +	ret = sprintf(buf, "%x\n", i3cdev->info.bcr);
> > +	i3c_bus_normaluse_unlock(bus);
> > +
> > +	return ret;
> > +}
> > +static DEVICE_ATTR_RO(bcr);
> > +
> > +static ssize_t dcr_show(struct device *dev,
> > +			struct device_attribute *da,
> > +			char *buf)
> > +{
> > +	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
> > +	struct i3c_bus *bus = i3c_device_get_bus(i3cdev);
> > +	ssize_t ret;
> > +
> > +	i3c_bus_normaluse_lock(bus);
> > +	ret = sprintf(buf, "%x\n", i3cdev->info.dcr);
> > +	i3c_bus_normaluse_unlock(bus);
> > +
> > +	return ret;
> > +}
> > +static DEVICE_ATTR_RO(dcr);
> > +
> > +static ssize_t pid_show(struct device *dev,
> > +			struct device_attribute *da,
> > +			char *buf)
> > +{
> > +	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
> > +	struct i3c_bus *bus = i3c_device_get_bus(i3cdev);
> > +	ssize_t ret;
> > +
> > +	i3c_bus_normaluse_lock(bus);
> > +	ret = sprintf(buf, "%llx\n", i3cdev->info.pid);
> > +	i3c_bus_normaluse_unlock(bus);
> > +
> > +	return ret;
> > +}
> > +static DEVICE_ATTR_RO(pid);
> > +
> > +static ssize_t address_show(struct device *dev,
> > +			    struct device_attribute *da,
> > +			    char *buf)
> > +{
> > +	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
> > +	struct i3c_bus *bus = i3c_device_get_bus(i3cdev);
> > +	ssize_t ret;
> > +
> > +	i3c_bus_normaluse_lock(bus);
> > +	ret = sprintf(buf, "%02x\n", i3cdev->info.dyn_addr);
> > +	i3c_bus_normaluse_unlock(bus);
> > +
> > +	return ret;
> > +}
> > +static DEVICE_ATTR_RO(address);  
> 
> should there be separate entries for dynamic and static address?

I didn't think exposing the static address was needed since it's never
used except at initialization time.

> 
> If yes, you could also reduce the boilerplate by using a macro taking
> attribute name and format string.

Hm, don't see the need for that yet, even if we expose both static and
dynamic addresses. It's not like you'll save hundreds lines of code by
doing that, we're talking about 10 lines.

> 
> > +static int i3c_device_uevent(struct device *dev, struct kobj_uevent_env *env)
> > +{
> > +	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
> > +	u16 manuf = I3C_PID_MANUF_ID(i3cdev->info.pid);
> > +	u16 part = I3C_PID_PART_ID(i3cdev->info.pid);
> > +	u16 ext = I3C_PID_EXTRA_INFO(i3cdev->info.pid);
> > +
> > +	if (I3C_PID_RND_LOWER_32BITS(i3cdev->info.pid))
> > +		return add_uevent_var(env, "MODALIAS=i3c:dcr%02Xmanuf%04X",
> > +				      i3cdev->info.dcr, manuf);
> > +
> > +	return add_uevent_var(env,
> > +			      "MODALIAS=i3c:dcr%02Xmanuf%04Xpart%04xext%04x",
> > +			      i3cdev->info.dcr, manuf, part, ext);  
> 
> instance id should also be passed in the non-random case?

MODALIAS is used by user space to know which module should be loaded
when a device is connected on the bus. Why would we need to know the
instance ID? In comparison, the USB subsystem does not pass the
->iSerialNumber value in MODALIAS.

> 
> > +}  
> 
> > +static const struct i3c_device_id *
> > +i3c_device_match_id(struct i3c_device *i3cdev,
> > +		    const struct i3c_device_id *id_table)
> > +{
> > +	const struct i3c_device_id *id;
> > +
> > +	/*
> > +	 * The lower 32bits of the provisional ID is just filled with a random
> > +	 * value, try to match using DCR info.
> > +	 */
> > +	if (!I3C_PID_RND_LOWER_32BITS(i3cdev->info.pid)) {
> > +		u16 manuf = I3C_PID_MANUF_ID(i3cdev->info.pid);
> > +		u16 part = I3C_PID_PART_ID(i3cdev->info.pid);
> > +		u16 ext_info = I3C_PID_EXTRA_INFO(i3cdev->info.pid);
> > +
> > +		/* First try to match by manufacturer/part ID. */
> > +		for (id = id_table; id->match_flags != 0; id++) {
> > +			if ((id->match_flags & I3C_MATCH_MANUF_AND_PART) !=
> > +			    I3C_MATCH_MANUF_AND_PART)
> > +				continue;
> > +
> > +			if (manuf != id->manuf_id || part != id->part_id)
> > +				continue;
> > +
> > +			if ((id->match_flags & I3C_MATCH_EXTRA_INFO) &&
> > +			    ext_info != id->extra_info)
> > +				continue;
> > +
> > +			return id;  
> 
> Here too, instance id is ignored. Seems like done on purpose?

Yes, it's done on purpose, the instance ID does not impact the
driver selection logic, it's just a way to uniquely identify devices of
the same type on an I3C bus.

> 
> > +		}
> > +	}
> > +
> > +	/* Fallback to DCR match. */
> > +	for (id = id_table; id->match_flags != 0; id++) {
> > +		if ((id->match_flags & I3C_MATCH_DCR) &&
> > +		    id->dcr == i3cdev->info.dcr)
> > +			return id;
> > +	}
> > +
> > +	return NULL;
> > +}  
> 
> > +static int i3c_device_probe(struct device *dev)
> > +{
> > +	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
> > +	struct i3c_driver *driver = drv_to_i3cdrv(dev->driver);
> > +
> > +	return driver->probe(i3cdev);  
> 
> Should you pm_runtime enable the device before probe? Like done for PCI
> in local_pci_probe() for example.

Hm, I'm not sure, but I'd say that it's the device driver responsibility
to do that.

> Or I guess thats a problem because I2C
> devices don't expect it?

I2C device probing is not handled here, so that shouldn't be a problem.
Still, I think we should wait for a real need before deciding whether
calling pm_runtime enable() from the core is a wise thing to do or not.

> 
> > diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
> > new file mode 100644
> > index 000000000000..8948d9bdec82
> > --- /dev/null
> > +++ b/drivers/i3c/device.c
> > @@ -0,0 +1,294 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2017 Cadence Design Systems Inc.  
> 
> 2018 now :)

Will change all dates.

> 
> > + *
> > + * Author: Boris Brezillon <boris.brezillon@bootlin.com>
> > + */
> > +
> > +#include <linux/atomic.h>
> > +#include <linux/bug.h>
> > +#include <linux/completion.h>
> > +#include <linux/device.h>
> > +#include <linux/mutex.h>
> > +#include <linux/slab.h>
> > +
> > +#include "internals.h"
> > +
> > +/**
> > + * i3c_device_do_priv_xfers() - do I3C SDR private transfers directed to a
> > + *				specific device
> > + *
> > + * @dev: device with which the transfers should be done
> > + * @xfers: array of transfers
> > + * @nxfers: number of transfers
> > + *
> > + * Initiate one or several private SDR transfers with @dev.
> > + *
> > + * This function can sleep and thus cannot be called in atomic context.
> > + *
> > + * Return: 0 in case of success, a negative error core otherwise.
> > + */  
> 
> Curious why you specifically call out SDR here. It could be HDR too, in
> future. Right?

HDR transfers will be handled through a different function (see the
previous version of this patch series where HDR modes were supported).
Regarding the name itself, I just followed the naming used in the I3C
spec, but I fine changing _priv_ by _sdr_ if you prefer.

> 
> > +int i3c_device_do_priv_xfers(struct i3c_device *dev,
> > +			     struct i3c_priv_xfer *xfers,
> > +			     int nxfers)
> > +{
> > +	struct i3c_master_controller *master;
> > +	int ret, i;
> > +
> > +	if (nxfers < 1)
> > +		return 0;
> > +
> > +	master = i3c_device_get_master(dev);
> > +	if (!master || !xfers)
> > +		return -EINVAL;
> > +
> > +	if (!master->ops->priv_xfers)
> > +		return -ENOTSUPP;
> > +
> > +	for (i = 0; i < nxfers; i++) {
> > +		if (!xfers[i].len || !xfers[i].data.in)
> > +			return -EINVAL;
> > +	}
> > +
> > +	i3c_bus_normaluse_lock(master->bus);
> > +	ret = master->ops->priv_xfers(dev, xfers, nxfers);
> > +	i3c_bus_normaluse_unlock(master->bus);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(i3c_device_do_priv_xfers);  
> 
> > +/**
> > + * struct i3c_device_info - I3C device information
> > + * @pid: Provisional ID
> > + * @bcr: Bus Characteristic Register
> > + * @dcr: Device Characteristic Register
> > + * @static_addr: static/I2C address
> > + * @dyn_addr: dynamic address
> > + * @hdr_cap: supported HDR modes  
> 
> This is just for querying and display device capability. We dont
> actually enter HDR mode at the moment, right?

Right now it is, but is will be used when we'll later add HDR
support (see v3 of this series if you want to have an idea of what
the HDR API looks like) ;-).

> 
> > + * @max_read_ds: max read speed information
> > + * @max_write_ds: max write speed information
> > + * @max_ibi_len: max IBI payload length
> > + * @max_read_turnaround: max read turn-around time in micro-seconds
> > + * @max_read_len: max private SDR read length in bytes
> > + * @max_write_len: max private SDR write length in bytes
> > + *
> > + * These are all basic information that should be advertised by an I3C device.
> > + * Some of them are optional depending on the device type and device
> > + * capabilities.
> > + * For each I3C slave attached to a master with
> > + * i3c_master_add_i3c_dev_locked(), the core will send the relevant CCC command
> > + * to retrieve these data.
> > + */
> > +struct i3c_device_info {
> > +	u64 pid;
> > +	u8 bcr;
> > +	u8 dcr;
> > +	u8 static_addr;
> > +	u8 dyn_addr;
> > +	u8 hdr_cap;
> > +	u8 max_read_ds;
> > +	u8 max_write_ds;
> > +	u8 max_ibi_len;
> > +	u32 max_read_turnaround;
> > +	u16 max_read_len;
> > +	u16 max_write_len;
> > +};  
> 

Thanks for your review.

Boris

