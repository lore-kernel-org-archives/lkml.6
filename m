Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAD2C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 11:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A0F20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 11:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="d/wupTu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83A0F20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754104AbeFTLim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 07:38:42 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:42934 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751841AbeFTLij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 07:38:39 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelnx193.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5KBc6cA010465;
        Wed, 20 Jun 2018 06:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529494686;
        bh=W+PYgsAVeEtBRJZxBbt+k088gelZTSd4Umcpypm39rk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=d/wupTu134g4rAn9O0t8T78M/URwSwmYQMf45HT0TiqJCsluh4K/UMQ+2aHRbI1e5
         78s0cXqLB5DlmgGltNBLT8ZpPGRx0pexQQCEyCqKOvjeX9Jw1ajukYmvSQiQwY/j5B
         44TVKGF6hRD9MoBhUszwkJpSt+eQghww2z/z6s7Q=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5KBc6ho016378;
        Wed, 20 Jun 2018 06:38:06 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 20
 Jun 2018 06:38:01 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 20 Jun 2018 06:38:02 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5KBbrm5028902;
        Wed, 20 Jun 2018 06:37:54 -0500
Subject: Re: [PATCH v4 01/10] i3c: Add core I3C infrastructure
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Przemyslaw Sroka <psroka@cadence.com>,
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
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
 <20180330074751.25987-2-boris.brezillon@bootlin.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <1567bbe1-0f11-4cc8-e501-6c8589570259@ti.com>
Date:   Wed, 20 Jun 2018 17:07:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180330074751.25987-2-boris.brezillon@bootlin.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Friday 30 March 2018 01:17 PM, Boris Brezillon wrote:
> Add core infrastructure to support I3C in Linux and document it.
> 
> This infrastructure is not complete yet and will be extended over
> time.
> 
> There are a few design choices that are worth mentioning because they
> impact the way I3C device drivers can interact with their devices:
> 
> - all functions used to send I3C/I2C frames must be called in
>   non-atomic context. Mainly done this way to ease implementation, but
>   this is still open to discussion. Please let me know if you think
>   it's worth considering an asynchronous model here
> - the bus element is a separate object and is not implicitly described
>   by the master (as done in I2C). The reason is that I want to be able
>   to handle multiple master connected to the same bus and visible to
>   Linux.
>   In this situation, we should only have one instance of the device and
>   not one per master, and sharing the bus object would be part of the
>   solution to gracefully handle this case.
>   I'm not sure we will ever need to deal with multiple masters
>   controlling the same bus and exposed under Linux, but separating the
>   bus and master concept is pretty easy, hence the decision to do it
>   like that.

There can only be one current master in I3C, so not sure of this
scenario. But agree with bus and master separation.

>   The other benefit of separating the bus and master concepts is that
>   master devices appear under the bus directory in sysfs.
> - I2C backward compatibility has been designed to be transparent to I2C
>   drivers and the I2C subsystem. The I3C master just registers an I2C
>   adapter which creates a new I2C bus. I'd say that, from a
>   representation PoV it's not ideal because what should appear as a
>   single I3C bus exposing I3C and I2C devices here appears as 2
>   different busses connected to each other through the parenting (the
>   I3C master is the parent of the I2C and I3C busses).
>   On the other hand, I don't see a better solution if we want something
>   that is not invasive.
> 
> Missing features in this preliminary version:
> - I3C HDR modes are not supported
> - no support for multi-master and the associated concepts (mastership
>   handover, support for secondary masters, ...)
> - I2C devices can only be described using DT because this is the only
>   use case I have. However, the framework can easily be extended with
>   ACPI and board info support
> - I3C slave framework. This has been completely omitted, but shouldn't
>   have a huge impact on the I3C framework because I3C slaves don't see
>   the whole bus, it's only about handling master requests and generating
>   IBIs. Some of the struct, constant and enum definitions could be
>   shared, but most of the I3C slave framework logic will be different
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>

> diff --git a/drivers/Makefile b/drivers/Makefile
> index 24cd47014657..999239dc29d4 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -111,7 +111,7 @@ obj-$(CONFIG_SERIO)		+= input/serio/
>  obj-$(CONFIG_GAMEPORT)		+= input/gameport/
>  obj-$(CONFIG_INPUT)		+= input/
>  obj-$(CONFIG_RTC_LIB)		+= rtc/
> -obj-y				+= i2c/ media/
> +obj-y				+= i2c/ i3c/ media/
>  obj-$(CONFIG_PPS)		+= pps/
>  obj-y				+= ptp/
>  obj-$(CONFIG_W1)		+= w1/
> diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
> new file mode 100644
> index 000000000000..cf3752412ae9
> --- /dev/null
> +++ b/drivers/i3c/Kconfig
> @@ -0,0 +1,24 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +menuconfig I3C
> +	tristate "I3C support"
> +	select I2C
> +	help
> +	  I3C is a serial protocol standardized by the MIPI alliance.
> +
> +	  It's supposed to be backward compatible with I2C while providing
> +	  support for high speed transfers and native interrupt support
> +	  without the need for extra pins.
> +
> +	  The I3C protocol also standardizes the slave device types and is
> +	  mainly design to communicate with sensors.

designed

> +
> +	  If you want I3C support, you should say Y here and also to the
> +	  specific driver for your bus adapter(s) below.
> +
> +	  This I3C support can also be built as a module.  If so, the module
> +	  will be called i3c.
> +
> diff --git a/drivers/i3c/core.c b/drivers/i3c/core.c
> new file mode 100644
> index 000000000000..d6d938a785a9
> --- /dev/null
> +++ b/drivers/i3c/core.c

> +static ssize_t bcr_show(struct device *dev,
> +			struct device_attribute *da,
> +			char *buf)
> +{
> +	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
> +	struct i3c_bus *bus = i3c_device_get_bus(i3cdev);
> +	ssize_t ret;
> +
> +	i3c_bus_normaluse_lock(bus);
> +	ret = sprintf(buf, "%x\n", i3cdev->info.bcr);
> +	i3c_bus_normaluse_unlock(bus);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RO(bcr);
> +
> +static ssize_t dcr_show(struct device *dev,
> +			struct device_attribute *da,
> +			char *buf)
> +{
> +	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
> +	struct i3c_bus *bus = i3c_device_get_bus(i3cdev);
> +	ssize_t ret;
> +
> +	i3c_bus_normaluse_lock(bus);
> +	ret = sprintf(buf, "%x\n", i3cdev->info.dcr);
> +	i3c_bus_normaluse_unlock(bus);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RO(dcr);
> +
> +static ssize_t pid_show(struct device *dev,
> +			struct device_attribute *da,
> +			char *buf)
> +{
> +	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
> +	struct i3c_bus *bus = i3c_device_get_bus(i3cdev);
> +	ssize_t ret;
> +
> +	i3c_bus_normaluse_lock(bus);
> +	ret = sprintf(buf, "%llx\n", i3cdev->info.pid);
> +	i3c_bus_normaluse_unlock(bus);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RO(pid);
> +
> +static ssize_t address_show(struct device *dev,
> +			    struct device_attribute *da,
> +			    char *buf)
> +{
> +	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
> +	struct i3c_bus *bus = i3c_device_get_bus(i3cdev);
> +	ssize_t ret;
> +
> +	i3c_bus_normaluse_lock(bus);
> +	ret = sprintf(buf, "%02x\n", i3cdev->info.dyn_addr);
> +	i3c_bus_normaluse_unlock(bus);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RO(address);

should there be separate entries for dynamic and static address?

If yes, you could also reduce the boilerplate by using a macro taking
attribute name and format string.

> +static int i3c_device_uevent(struct device *dev, struct kobj_uevent_env *env)
> +{
> +	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
> +	u16 manuf = I3C_PID_MANUF_ID(i3cdev->info.pid);
> +	u16 part = I3C_PID_PART_ID(i3cdev->info.pid);
> +	u16 ext = I3C_PID_EXTRA_INFO(i3cdev->info.pid);
> +
> +	if (I3C_PID_RND_LOWER_32BITS(i3cdev->info.pid))
> +		return add_uevent_var(env, "MODALIAS=i3c:dcr%02Xmanuf%04X",
> +				      i3cdev->info.dcr, manuf);
> +
> +	return add_uevent_var(env,
> +			      "MODALIAS=i3c:dcr%02Xmanuf%04Xpart%04xext%04x",
> +			      i3cdev->info.dcr, manuf, part, ext);

instance id should also be passed in the non-random case?

> +}

> +static const struct i3c_device_id *
> +i3c_device_match_id(struct i3c_device *i3cdev,
> +		    const struct i3c_device_id *id_table)
> +{
> +	const struct i3c_device_id *id;
> +
> +	/*
> +	 * The lower 32bits of the provisional ID is just filled with a random
> +	 * value, try to match using DCR info.
> +	 */
> +	if (!I3C_PID_RND_LOWER_32BITS(i3cdev->info.pid)) {
> +		u16 manuf = I3C_PID_MANUF_ID(i3cdev->info.pid);
> +		u16 part = I3C_PID_PART_ID(i3cdev->info.pid);
> +		u16 ext_info = I3C_PID_EXTRA_INFO(i3cdev->info.pid);
> +
> +		/* First try to match by manufacturer/part ID. */
> +		for (id = id_table; id->match_flags != 0; id++) {
> +			if ((id->match_flags & I3C_MATCH_MANUF_AND_PART) !=
> +			    I3C_MATCH_MANUF_AND_PART)
> +				continue;
> +
> +			if (manuf != id->manuf_id || part != id->part_id)
> +				continue;
> +
> +			if ((id->match_flags & I3C_MATCH_EXTRA_INFO) &&
> +			    ext_info != id->extra_info)
> +				continue;
> +
> +			return id;

Here too, instance id is ignored. Seems like done on purpose?

> +		}
> +	}
> +
> +	/* Fallback to DCR match. */
> +	for (id = id_table; id->match_flags != 0; id++) {
> +		if ((id->match_flags & I3C_MATCH_DCR) &&
> +		    id->dcr == i3cdev->info.dcr)
> +			return id;
> +	}
> +
> +	return NULL;
> +}

> +static int i3c_device_probe(struct device *dev)
> +{
> +	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
> +	struct i3c_driver *driver = drv_to_i3cdrv(dev->driver);
> +
> +	return driver->probe(i3cdev);

Should you pm_runtime enable the device before probe? Like done for PCI
in local_pci_probe() for example. Or I guess thats a problem because I2C
devices don't expect it?

> diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
> new file mode 100644
> index 000000000000..8948d9bdec82
> --- /dev/null
> +++ b/drivers/i3c/device.c
> @@ -0,0 +1,294 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2017 Cadence Design Systems Inc.

2018 now :)

> + *
> + * Author: Boris Brezillon <boris.brezillon@bootlin.com>
> + */
> +
> +#include <linux/atomic.h>
> +#include <linux/bug.h>
> +#include <linux/completion.h>
> +#include <linux/device.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +
> +#include "internals.h"
> +
> +/**
> + * i3c_device_do_priv_xfers() - do I3C SDR private transfers directed to a
> + *				specific device
> + *
> + * @dev: device with which the transfers should be done
> + * @xfers: array of transfers
> + * @nxfers: number of transfers
> + *
> + * Initiate one or several private SDR transfers with @dev.
> + *
> + * This function can sleep and thus cannot be called in atomic context.
> + *
> + * Return: 0 in case of success, a negative error core otherwise.
> + */

Curious why you specifically call out SDR here. It could be HDR too, in
future. Right?

> +int i3c_device_do_priv_xfers(struct i3c_device *dev,
> +			     struct i3c_priv_xfer *xfers,
> +			     int nxfers)
> +{
> +	struct i3c_master_controller *master;
> +	int ret, i;
> +
> +	if (nxfers < 1)
> +		return 0;
> +
> +	master = i3c_device_get_master(dev);
> +	if (!master || !xfers)
> +		return -EINVAL;
> +
> +	if (!master->ops->priv_xfers)
> +		return -ENOTSUPP;
> +
> +	for (i = 0; i < nxfers; i++) {
> +		if (!xfers[i].len || !xfers[i].data.in)
> +			return -EINVAL;
> +	}
> +
> +	i3c_bus_normaluse_lock(master->bus);
> +	ret = master->ops->priv_xfers(dev, xfers, nxfers);
> +	i3c_bus_normaluse_unlock(master->bus);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(i3c_device_do_priv_xfers);

> +/**
> + * struct i3c_device_info - I3C device information
> + * @pid: Provisional ID
> + * @bcr: Bus Characteristic Register
> + * @dcr: Device Characteristic Register
> + * @static_addr: static/I2C address
> + * @dyn_addr: dynamic address
> + * @hdr_cap: supported HDR modes

This is just for querying and display device capability. We dont
actually enter HDR mode at the moment, right?

> + * @max_read_ds: max read speed information
> + * @max_write_ds: max write speed information
> + * @max_ibi_len: max IBI payload length
> + * @max_read_turnaround: max read turn-around time in micro-seconds
> + * @max_read_len: max private SDR read length in bytes
> + * @max_write_len: max private SDR write length in bytes
> + *
> + * These are all basic information that should be advertised by an I3C device.
> + * Some of them are optional depending on the device type and device
> + * capabilities.
> + * For each I3C slave attached to a master with
> + * i3c_master_add_i3c_dev_locked(), the core will send the relevant CCC command
> + * to retrieve these data.
> + */
> +struct i3c_device_info {
> +	u64 pid;
> +	u8 bcr;
> +	u8 dcr;
> +	u8 static_addr;
> +	u8 dyn_addr;
> +	u8 hdr_cap;
> +	u8 max_read_ds;
> +	u8 max_write_ds;
> +	u8 max_ibi_len;
> +	u32 max_read_turnaround;
> +	u16 max_read_len;
> +	u16 max_write_len;
> +};

Thanks,
Sekhar
