Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966035AbeE2SlX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:41:23 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34487 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932798AbeE2SlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:41:21 -0400
X-ME-Proxy: <xmx:0Z4NW4DDW4tlUfrXPx1xXBlWDWRXDh2ecKcPDRLib_Bdow3l8Y78SA>
X-ME-Proxy: <xmx:0Z4NW-wJ39OL77uk2LPpLECHgoi9IFydvRFRGBV234IKHzqDZbq_8w>
X-ME-Proxy: <xmx:0Z4NW4j5WHAGgIobv8rT3YDESh_c8DEex7rJcAAz3kqUGlQnpgYILw>
X-ME-Proxy: <xmx:0Z4NW9fvAaMYmAisz1AYq65o_3_Ms9yoZcITbWevN1LaVDXqVY_7Mw>
X-ME-Proxy: <xmx:0Z4NW3WTYLzHgxGY8HZt9L-TcSCxZQjnlEg6mqVn16pPRj_2lgYfHQ>
X-ME-Proxy: <xmx:0Z4NW2ASUkONUMdNcG3vlo423iVvJ0kEeauAXHqwSGxZlGOFzNao8w>
X-ME-Sender: <xms:0Z4NW5-ERUk4gcjPBzjZtMXMlt-WXfjHXwuX0gOvCKyMdEODTWLqPw>
Date: Tue, 29 May 2018 20:41:01 +0200
From: Greg KH <greg@kroah.com>
To: Gary R Hook <gary.hook@amd.com>
Cc: iommu@lists.linux-foundation.org, joro@8bytes.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/2] iommu - Enable debugfs exposure of IOMMU driver
 internals
Message-ID: <20180529184101.GB10618@kroah.com>
References: <152761784341.2654.8609366076331539902.stgit@sosgrh1.amd.com>
 <152761819480.2654.5371070582955429468.stgit@sosgrh1.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152761819480.2654.5371070582955429468.stgit@sosgrh1.amd.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 01:23:14PM -0500, Gary R Hook wrote:
> Provide base enablement for using debugfs to expose internal data of an
> IOMMU driver. When called, create the /sys/kernel/debug/iommu directory.
> 
> Emit a strong warning at boot time to indicate that this feature is
> enabled.
> 
> This function is called from iommu_init, and creates the initial DebugFS
> directory. Drivers may then call iommu_debugfs_new_driver_dir() to
> instantiate a device-specific directory to expose internal data.
> It will return a pointer to the new dentry structure created in
> /sys/kernel/debug/iommu, or NULL in the event of a failure.
> 
> Since the IOMMU driver can not be removed from the running system, there
> is no need for an "off" function.
> 
> Signed-off-by: Gary R Hook <gary.hook@amd.com>
> ---
>  drivers/iommu/Kconfig         |   10 ++++++
>  drivers/iommu/Makefile        |    1 +
>  drivers/iommu/iommu-debugfs.c |   72 +++++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/iommu.c         |    2 +
>  include/linux/iommu.h         |   11 ++++++
>  5 files changed, 96 insertions(+)
>  create mode 100644 drivers/iommu/iommu-debugfs.c
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index c76157e57f6b..f9af25ac409f 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -60,6 +60,16 @@ config IOMMU_IO_PGTABLE_ARMV7S_SELFTEST
>  
>  endmenu
>  
> +config IOMMU_DEBUGFS
> +	bool "Export IOMMU internals in DebugFS"
> +	depends on DEBUG_FS
> +	help
> +	  Allows exposure of IOMMU device internals. This option enables
> +	  the use of debugfs by IOMMU drivers as required. Devices can,
> +	  at initialization time, cause the IOMMU code to create a top-level
> +	  debug/iommu directory, and then populate a subdirectory with
> +	  entries as required.

You didn't put a big enough warning here, like I asked last time :(



> +
>  config IOMMU_IOVA
>  	tristate
>  
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 1fb695854809..74cfbc392862 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_IOMMU_API) += iommu.o
>  obj-$(CONFIG_IOMMU_API) += iommu-traces.o
>  obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
> +obj-$(CONFIG_IOMMU_DEBUGFS) += iommu-debugfs.o
>  obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
>  obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
>  obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
> diff --git a/drivers/iommu/iommu-debugfs.c b/drivers/iommu/iommu-debugfs.c
> new file mode 100644
> index 000000000000..bb1bf2d0ac51
> --- /dev/null
> +++ b/drivers/iommu/iommu-debugfs.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * IOMMU debugfs core infrastructure
> + *
> + * Copyright (C) 2018 Advanced Micro Devices, Inc.
> + *
> + * Author: Gary R Hook <gary.hook@amd.com>
> + */
> +
> +#include <linux/pci.h>
> +#include <linux/iommu.h>
> +#include <linux/debugfs.h>
> +
> +static struct dentry *iommu_debugfs_dir;
> +
> +/**
> + * iommu_debugfs_setup - create the top-level iommu directory in debugfs
> + *
> + * Provide base enablement for using debugfs to expose internal data of an
> + * IOMMU driver. When called, this function creates the
> + * /sys/kernel/debug/iommu directory.
> + *
> + * Emit a strong warning at boot time to indicate that this feature is
> + * enabled.
> + *
> + * This function is called from iommu_init; drivers may then call
> + * iommu_debugfs_new_driver_dir() to instantiate a vendor-specific
> + * directory to be used to expose internal data.
> + */
> +void iommu_debugfs_setup(void)
> +{
> +	if (!iommu_debugfs_dir) {
> +		iommu_debugfs_dir = debugfs_create_dir("iommu", NULL);
> +		if (iommu_debugfs_dir) {

Again, no, never test a return value from a debugfs call.  You do not
care, you should do the same exact thing if it is enabled or disabled or
somehow failing.  Just keep moving on.

> +			pr_warn("\n");
> +			pr_warn("*************************************************************\n");
> +			pr_warn("**     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **\n");
> +			pr_warn("**                                                         **\n");
> +			pr_warn("**  IOMMU DebugFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL  **\n");
> +			pr_warn("**                                                         **\n");
> +			pr_warn("** This means that this kernel is built to expose internal **\n");
> +			pr_warn("** IOMMU data structures, which may compromise security on **\n");
> +			pr_warn("** your system.                                            **\n");
> +			pr_warn("**                                                         **\n");
> +			pr_warn("** If you see this message and you are not debugging the   **\n");
> +			pr_warn("** kernel, report this immediately to your vendor!         **\n");
> +			pr_warn("**                                                         **\n");
> +			pr_warn("**     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **\n");
> +			pr_warn("*************************************************************\n");
> +		}
> +	}
> +}
> +
> +/**
> + * iommu_debugfs_new_driver_dir - create a vendor directory under debugfs/iommu
> + * @vendor: name of the vendor-specific subdirectory to create
> + *
> + * This function is called by an IOMMU driver to create the top-level debugfs
> + * directory for that driver.
> + *
> + * Return: upon success, a pointer to the dentry for the new directory.
> + *         NULL in case of failure.
> + */
> +struct dentry *iommu_debugfs_new_driver_dir(const char *vendor)
> +{
> +	struct dentry *d_new;
> +
> +	d_new = debugfs_create_dir(vendor, iommu_debugfs_dir);
> +
> +	return d_new;
> +}
> +EXPORT_SYMBOL_GPL(iommu_debugfs_new_driver_dir);

Why are you wrapping a debugfs call?  Why not just export
iommu_debugfs_dir instead?

thanks,

greg k-h
