Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4DBC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 19:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6FD20685
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 19:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2rWTLuf6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A6FD20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbeKQGBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 01:01:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:38844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725753AbeKQGBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 01:01:20 -0500
Received: from localhost (unknown [205.169.26.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B6D620685;
        Fri, 16 Nov 2018 19:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542397654;
        bh=+P76cbHUebU/69oYds/s3inbcw7dtMadL00T9U2EQ7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2rWTLuf6cdBS/aEJInH4UcUCfEGeLSBKerfVm9VSGe47/s+nZ3TSg0V5AAkgruhxS
         kDuN2qU49EjcQ42EPBHDopGmmG8wINjaxxpeOFYnVc71qxtGAkqu1aEsDZ8E6lwOnc
         7qMyOMCMZIxwItAEjNSDthOsI21FyKt4BKp0W8YY=
Date:   Fri, 16 Nov 2018 11:47:33 -0800
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev-owner@vger.kernel.org" <netdev-owner@vger.kernel.org>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Leo Li <leoyang.li@nxp.com>
Subject: Re: [PATCH v2 2/4] bus: fsl-mc: add fsl-mc userspace support
Message-ID: <20181116194733.GA7785@kroah.com>
References: <1542390890-3270-1-git-send-email-ioana.ciornei@nxp.com>
 <1542390890-3270-3-git-send-email-ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542390890-3270-3-git-send-email-ioana.ciornei@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 05:55:41PM +0000, Ioana Ciornei wrote:
> Adding userspace support for the MC (Management Complex) means exporting
> an ioctl capable device file representing the root resource container.
> 
> This new functionality in the fsl-mc bus driver intends to provide
> userspace applications an interface to interact with the MC firmware.
> 
> Commands that are composed in userspace are sent to the MC firmware
> through the FSL_MC_SEND_MC_COMMAND ioctl.  By default the implicit MC
> I/O portal is used for this operation, but if the implicit one is busy,
> a dynamic portal is allocated and then freed upon execution.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Overall, this looks almost sane :)

But I do have some minor comments below on the code after only a quick
review.


> ---
> Changes in v2:
>    - use root dprc MC portal by default
>    - create the uapi misc device from the root dprc probe function
> 
>  Documentation/ioctl/ioctl-number.txt |   1 +
>  drivers/bus/fsl-mc/Kconfig           |   7 ++
>  drivers/bus/fsl-mc/Makefile          |   3 +
>  drivers/bus/fsl-mc/dprc-driver.c     |  14 ++-
>  drivers/bus/fsl-mc/fsl-mc-private.h  |  41 ++++++++
>  drivers/bus/fsl-mc/fsl-mc-uapi.c     | 179 +++++++++++++++++++++++++++++++++++
>  include/uapi/linux/fsl_mc.h          |   9 ++
>  7 files changed, 253 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/bus/fsl-mc/fsl-mc-uapi.c
> 
> diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
> index af6f6ba..eaae7bf 100644
> --- a/Documentation/ioctl/ioctl-number.txt
> +++ b/Documentation/ioctl/ioctl-number.txt
> @@ -171,6 +171,7 @@ Code  Seq#(hex)	Include File		Comments
>  'R'	00-1F	linux/random.h		conflict!
>  'R'	01	linux/rfkill.h		conflict!
>  'R'	C0-DF	net/bluetooth/rfcomm.h
> +'R'	E0	uapi/linux/fsl_mc.h
>  'S'	all	linux/cdrom.h		conflict!
>  'S'	80-81	scsi/scsi_ioctl.h	conflict!
>  'S'	82-FF	scsi/scsi.h		conflict!
> diff --git a/drivers/bus/fsl-mc/Kconfig b/drivers/bus/fsl-mc/Kconfig
> index c23c77c..cde6f40 100644
> --- a/drivers/bus/fsl-mc/Kconfig
> +++ b/drivers/bus/fsl-mc/Kconfig
> @@ -14,3 +14,10 @@ config FSL_MC_BUS
>  	  architecture.  The fsl-mc bus driver handles discovery of
>  	  DPAA2 objects (which are represented as Linux devices) and
>  	  binding objects to drivers.
> +
> +config FSL_MC_UAPI_SUPPORT
> +	bool "Management Complex (MC) userspace support"
> +	depends on FSL_MC_BUS
> +	help
> +	  Provides userspace support for creating/destroying/configuring
> +	  DPAA2 objects in the Management Complex.
> diff --git a/drivers/bus/fsl-mc/Makefile b/drivers/bus/fsl-mc/Makefile
> index 3c518c7..4ae292a 100644
> --- a/drivers/bus/fsl-mc/Makefile
> +++ b/drivers/bus/fsl-mc/Makefile
> @@ -16,3 +16,6 @@ mc-bus-driver-objs := fsl-mc-bus.o \
>  		      fsl-mc-allocator.o \
>  		      fsl-mc-msi.o \
>  		      dpmcp.o
> +
> +# MC userspace support
> +obj-$(CONFIG_FSL_MC_UAPI_SUPPORT) += fsl-mc-uapi.o
> diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
> index 52c7e15..3919d9b 100644
> --- a/drivers/bus/fsl-mc/dprc-driver.c
> +++ b/drivers/bus/fsl-mc/dprc-driver.c
> @@ -593,6 +593,7 @@ static int dprc_probe(struct fsl_mc_device *mc_dev)
>  	struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc_dev);
>  	bool mc_io_created = false;
>  	bool msi_domain_set = false;
> +	bool uapi_created = false;

I dont understand this "created" need/use.  Why is that needed?

>  	u16 major_ver, minor_ver;
>  
>  	if (!is_fsl_mc_bus_dprc(mc_dev))
> @@ -647,6 +648,11 @@ static int dprc_probe(struct fsl_mc_device *mc_dev)
>  		} else {
>  			dev_set_msi_domain(&mc_dev->dev, mc_msi_domain);
>  			msi_domain_set = true;
> +
> +			error = fsl_mc_uapi_create_device_file(mc_bus);
> +			if (error < 0)
> +				goto error_cleanup_msi_domain;
> +			uapi_created = true;

Why are you setting this, can't you always just "know" if the misc file
was created so when you clean up from errors you can remove it?  Or is
the logic here just too complex?


>  		}
>  	}
>  
> @@ -654,7 +660,7 @@ static int dprc_probe(struct fsl_mc_device *mc_dev)
>  			  &mc_dev->mc_handle);
>  	if (error < 0) {
>  		dev_err(&mc_dev->dev, "dprc_open() failed: %d\n", error);
> -		goto error_cleanup_msi_domain;
> +		goto error_cleanup_uapi;
>  	}
>  
>  	error = dprc_get_attributes(mc_dev->mc_io, 0, mc_dev->mc_handle,
> @@ -706,6 +712,10 @@ static int dprc_probe(struct fsl_mc_device *mc_dev)
>  error_cleanup_open:
>  	(void)dprc_close(mc_dev->mc_io, 0, mc_dev->mc_handle);
>  
> +error_cleanup_uapi:
> +	if (uapi_created)
> +		fsl_mc_uapi_remove_device_file(mc_bus);
> +
>  error_cleanup_msi_domain:
>  	if (msi_domain_set)
>  		dev_set_msi_domain(&mc_dev->dev, NULL);
> @@ -774,6 +784,8 @@ static int dprc_remove(struct fsl_mc_device *mc_dev)
>  	if (!fsl_mc_is_root_dprc(&mc_dev->dev)) {
>  		fsl_destroy_mc_io(mc_dev->mc_io);
>  		mc_dev->mc_io = NULL;
> +	} else {
> +		fsl_mc_uapi_remove_device_file(mc_bus);

You aren't checkig that bool flag here, which kind of implies that you
didn't need it above as well.

>  	}
>  
>  	dev_info(&mc_dev->dev, "DPRC device unbound from driver");
> diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
> index ea11b4f..16902f9 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-private.h
> +++ b/drivers/bus/fsl-mc/fsl-mc-private.h
> @@ -10,6 +10,8 @@
>  
>  #include <linux/fsl/mc.h>
>  #include <linux/mutex.h>
> +#include <linux/ioctl.h>
> +#include <linux/miscdevice.h>
>  
>  /*
>   * Data Path Management Complex (DPMNG) General API
> @@ -492,6 +494,24 @@ struct fsl_mc_resource_pool {
>  };
>  
>  /**
> + * struct fsl_mc_uapi - information associated with a device file
> + * @misc: struct miscdevice linked to the root dprc
> + * @device: newly created device in /dev
> + * @mutex: mutex lock to serialize the open/release operations
> + * @local_instance_in_use: local MC I/O instance in use or not
> + * @dynamic_instance_count: number of dynamically created MC I/O instances
> + * @static_mc_io: pointer to the static MC I/O object
> + */
> +struct fsl_mc_uapi {
> +	struct miscdevice misc;
> +	struct device *device;
> +	struct mutex mutex; /* serialize open/release operations */
> +	u32 local_instance_in_use;

Why do you care/need to know if it is in use or not?
Why does it matter, that's a userspace decision to make, not the
kernel's.


> +	u32 dynamic_instance_count;
> +	struct fsl_mc_io *static_mc_io;
> +};
> +
> +/**
>   * struct fsl_mc_bus - logical bus that corresponds to a physical DPRC
>   * @mc_dev: fsl-mc device for the bus device itself.
>   * @resource_pools: array of resource pools (one pool per resource type)
> @@ -500,6 +520,7 @@ struct fsl_mc_resource_pool {
>   * @irq_resources: Pointer to array of IRQ objects for the IRQ pool
>   * @scan_mutex: Serializes bus scanning
>   * @dprc_attr: DPRC attributes
> + * @uapi_misc: struct that abstracts the interaction with userspace
>   */
>  struct fsl_mc_bus {
>  	struct fsl_mc_device mc_dev;
> @@ -507,6 +528,7 @@ struct fsl_mc_bus {
>  	struct fsl_mc_device_irq *irq_resources;
>  	struct mutex scan_mutex;    /* serializes bus scanning */
>  	struct dprc_attributes dprc_attr;
> +	struct fsl_mc_uapi uapi_misc;
>  };
>  
>  #define to_fsl_mc_bus(_mc_dev) \
> @@ -561,4 +583,23 @@ int __must_check fsl_create_mc_io(struct device *dev,
>  
>  bool fsl_mc_is_root_dprc(struct device *dev);
>  
> +#ifdef CONFIG_FSL_MC_UAPI_SUPPORT
> +
> +int fsl_mc_uapi_create_device_file(struct fsl_mc_bus *mc_bus);
> +
> +void fsl_mc_uapi_remove_device_file(struct fsl_mc_bus *mc_bus);
> +
> +#else
> +
> +static inline int fsl_mc_uapi_create_device_file(struct fsl_mc_bus *mc_bus)
> +{
> +	return 0;
> +}
> +
> +static inline void fsl_mc_uapi_remove_device_file(struct fsl_mc_bus *mc_bus)
> +{
> +}
> +
> +#endif
> +
>  #endif /* _FSL_MC_PRIVATE_H_ */
> diff --git a/drivers/bus/fsl-mc/fsl-mc-uapi.c b/drivers/bus/fsl-mc/fsl-mc-uapi.c
> new file mode 100644
> index 0000000..8c9debb
> --- /dev/null
> +++ b/drivers/bus/fsl-mc/fsl-mc-uapi.c
> @@ -0,0 +1,179 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Management Complex (MC) userspace support
> + *
> + * Copyright 2018 NXP
> + *
> + */
> +
> +#include <linux/slab.h>
> +#include <linux/fs.h>
> +#include <linux/uaccess.h>
> +#include <linux/miscdevice.h>
> +
> +#include "fsl-mc-private.h"
> +
> +struct uapi_priv_data {
> +	struct fsl_mc_uapi *uapi;
> +	struct fsl_mc_io *mc_io;
> +};
> +
> +static int fsl_mc_uapi_send_command(unsigned long arg,
> +				    struct fsl_mc_io *mc_io)
> +{
> +	struct fsl_mc_command mc_cmd;
> +	int error;
> +
> +	error = copy_from_user(&mc_cmd, (void __user *)arg, sizeof(mc_cmd));
> +	if (error)
> +		return -EFAULT;
> +
> +	error = mc_send_command(mc_io, &mc_cmd);

Is there no need for any type of validation of the command at all?
Previously you were always sending "known good" commands from within the
kernel.  THat is suddenly changed here, how good and robust is your
error handling in this function?


> +	if (error)
> +		return error;
> +
> +	error = copy_to_user((void __user *)arg, &mc_cmd, sizeof(mc_cmd));
> +	if (error)
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static int fsl_mc_uapi_dev_open(struct inode *inode, struct file *filep)
> +{
> +	struct fsl_mc_device *root_mc_device;
> +	struct uapi_priv_data *priv_data;
> +	struct fsl_mc_io *dynamic_mc_io;
> +	struct fsl_mc_uapi *mc_uapi;
> +	struct fsl_mc_bus *mc_bus;
> +	int error;
> +
> +	priv_data = kzalloc(sizeof(*priv_data), GFP_KERNEL);
> +	if (!priv_data)
> +		return -ENOMEM;
> +
> +	mc_uapi = container_of(filep->private_data, struct fsl_mc_uapi, misc);
> +	mc_bus = container_of(mc_uapi, struct fsl_mc_bus, uapi_misc);
> +	root_mc_device = &mc_bus->mc_dev;
> +
> +	mutex_lock(&mc_uapi->mutex);
> +
> +	if (!mc_uapi->local_instance_in_use) {
> +		priv_data->mc_io = mc_uapi->static_mc_io;
> +		mc_uapi->local_instance_in_use = true;

You are setting a u32 to "true"?  The compiler did not complain?

And again, why is this needed, I don't understand the distinction.

> +	} else {
> +		error = fsl_mc_portal_allocate(root_mc_device, 0,
> +					       &dynamic_mc_io);
> +		if (error) {
> +			pr_err("Could not allocate MC portal\n");
> +			goto error_portal_allocate;
> +		}
> +
> +		mc_uapi->dynamic_instance_count++;

Why care about the "count"?


> +		priv_data->mc_io = dynamic_mc_io;
> +	}
> +	priv_data->uapi = mc_uapi;
> +	filep->private_data = priv_data;
> +
> +	mutex_unlock(&mc_uapi->mutex);
> +
> +	return 0;
> +
> +error_portal_allocate:
> +	mutex_unlock(&mc_uapi->mutex);
> +
> +	return error;
> +}
> +
> +static int fsl_mc_uapi_dev_release(struct inode *inode, struct file *filep)
> +{
> +	struct uapi_priv_data *priv_data;
> +	struct fsl_mc_uapi *mc_uapi;
> +	struct fsl_mc_io *mc_io;
> +
> +	priv_data = filep->private_data;
> +	mc_uapi = priv_data->uapi;
> +	mc_io = priv_data->mc_io;
> +
> +	mutex_lock(&mc_uapi->mutex);
> +
> +	if (WARN_ON(!mc_uapi->local_instance_in_use &&
> +		    mc_uapi->dynamic_instance_count == 0)) {
> +		mutex_unlock(&mc_uapi->mutex);
> +		return -EINVAL;

Never have a WARN_ON() on a path that userspace can generate, otherwise
when you run with panic_on_warn enabled, you just crashed the machine.

If this really is such a horrible error, do a "dev_warn()" and move on.
But again, do not print something if userspace can trigger it all the
time, that's a local DoS.


> +	}
> +
> +	if (mc_io == mc_uapi->static_mc_io) {
> +		mc_uapi->local_instance_in_use = false;
> +	} else {
> +		fsl_mc_portal_free(mc_io);
> +		mc_uapi->dynamic_instance_count--;
> +	}
> +
> +	kfree(filep->private_data);
> +	filep->private_data =  NULL;
> +
> +	mutex_unlock(&mc_uapi->mutex);
> +
> +	return 0;
> +}
> +
> +static long fsl_mc_uapi_dev_ioctl(struct file *file,
> +				  unsigned int cmd,
> +				  unsigned long arg)
> +{
> +	struct uapi_priv_data *priv_data = file->private_data;
> +	int error;
> +
> +	switch (cmd) {
> +	case FSL_MC_SEND_MC_COMMAND:
> +		error = fsl_mc_uapi_send_command(arg, priv_data->mc_io);
> +		break;
> +	default:
> +		pr_err("%s: unexpected ioctl call number\n", __func__);
> +		error = -EINVAL;

dev_err()?  Same for all of your pr_* calls, use the dev_* calls
instead.

And again, this is something that userspace can easily trigger, do not
spam the logs with this type of message.  Make it dev_dbg() instead for
your own debugging use.


> +	}
> +
> +	return error;
> +}
> +
> +static const struct file_operations fsl_mc_uapi_dev_fops = {
> +	.owner = THIS_MODULE,
> +	.open = fsl_mc_uapi_dev_open,
> +	.release = fsl_mc_uapi_dev_release,
> +	.unlocked_ioctl = fsl_mc_uapi_dev_ioctl,
> +};
> +
> +int fsl_mc_uapi_create_device_file(struct fsl_mc_bus *mc_bus)
> +{
> +	struct fsl_mc_device *mc_dev = &mc_bus->mc_dev;
> +	struct fsl_mc_uapi *mc_uapi = &mc_bus->uapi_misc;
> +	int error;
> +
> +	mc_uapi->misc.minor = MISC_DYNAMIC_MINOR;
> +	mc_uapi->misc.name = dev_name(&mc_dev->dev);
> +	mc_uapi->misc.fops = &fsl_mc_uapi_dev_fops;
> +
> +	error = misc_register(&mc_uapi->misc);
> +	if (error)
> +		return -EPROBE_DEFER;

No, return the error given to you, don't eat it and make up a new one.

> +
> +	mc_uapi->static_mc_io = mc_bus->mc_dev.mc_io;
> +
> +	mutex_init(&mc_uapi->mutex);
> +
> +	return 0;
> +}
> +
> +void fsl_mc_uapi_remove_device_file(struct fsl_mc_bus *mc_bus)
> +{
> +	struct fsl_mc_uapi *mc_uapi = &mc_bus->uapi_misc;
> +
> +	if (WARN_ON(mc_uapi->local_instance_in_use))
> +		return;
> +
> +	if (WARN_ON(mc_uapi->dynamic_instance_count != 0))
> +		return;

Same comments as above on the WARN_ON(), don't do it.  make it
dev_dbg() if you really just want to make sure your code is correct.  If
it can happen "in the wild", then you need to refactor the code to
prevent this from ever happening (hint, can it ever happen?  I don't
think so but I might be wrong...)

thanks,

greg k-h
