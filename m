Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751147AbeEKPW6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 11:22:58 -0400
Received: from foss.arm.com ([217.140.101.70]:43430 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbeEKPW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 11:22:57 -0400
Subject: Re: [PATCH v6 1/2] iommu - Enable debugfs exposure of IOMMU driver
 internals
To: Gary R Hook <gary.hook@amd.com>, iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
References: <152604905217.106201.15533883255216330970.stgit@sosxen2.amd.com>
 <152604925157.106201.5299224478351644530.stgit@sosxen2.amd.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <474751d1-02ec-9e00-26c8-36988ad83092@arm.com>
Date: Fri, 11 May 2018 16:22:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <152604925157.106201.5299224478351644530.stgit@sosxen2.amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gary,

Just a few trivial nitpicks below, otherwise:

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

On 11/05/18 15:34, Gary R Hook wrote:
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
>   drivers/iommu/Kconfig         |   11 ++++++
>   drivers/iommu/Makefile        |    1 +
>   drivers/iommu/iommu-debugfs.c |   70 +++++++++++++++++++++++++++++++++++++++++
>   drivers/iommu/iommu.c         |    2 +
>   include/linux/iommu.h         |   10 ++++++
>   5 files changed, 94 insertions(+)
>   create mode 100644 drivers/iommu/iommu-debugfs.c
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index f3a21343e636..ff511fa8ca7d 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -60,6 +60,17 @@ config IOMMU_IO_PGTABLE_ARMV7S_SELFTEST
>   
>   endmenu
>   
> +config IOMMU_DEBUGFS
> +	bool "Export IOMMU internals in DebugFS"
> +	depends on DEBUG_FS
> +	default n

bool implicitly defaults to n anyway, so you don't really need to say it.

> +	help
> +	  Allows exposure of IOMMU device internals. This option enables
> +	  the use of debugfs by IOMMU drivers as required. Devices can,
> +	  at initialization time, cause the IOMMU code to create a top-level
> +	  debug/iommu directory, and then populate a subdirectory with
> +	  entries as required.
> +
>   config IOMMU_IOVA
>   	tristate
>   
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 1fb695854809..74cfbc392862 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -2,6 +2,7 @@
>   obj-$(CONFIG_IOMMU_API) += iommu.o
>   obj-$(CONFIG_IOMMU_API) += iommu-traces.o
>   obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
> +obj-$(CONFIG_IOMMU_DEBUGFS) += iommu-debugfs.o
>   obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
>   obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
>   obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
> diff --git a/drivers/iommu/iommu-debugfs.c b/drivers/iommu/iommu-debugfs.c
> new file mode 100644
> index 000000000000..9df3b44aef55
> --- /dev/null
> +++ b/drivers/iommu/iommu-debugfs.c
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * IOMMU driver

"driver"? ;) I'd have thought something like "IOMMU debugfs core 
infrastructure", but arguably it's self-evident enough that it doesn't 
necessarily need describing at all.

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
> + * directory for that driver. The return value is the dentry for the requested
> + * vendor directory, or NULL in case of failure.

According to kernel-doc.rst, return values should be in a dedicated 
section (i.e. "Return: The dentry...") rather than as part of the 
function description.

> + */
> +struct dentry *iommu_debugfs_new_driver_dir(char *vendor)

const char *?

> +{
> +	struct dentry *d_new;
> +
> +	d_new = debugfs_create_dir(vendor, iommu_debugfs_dir);
> +
> +	return d_new;
> +}
> +EXPORT_SYMBOL_GPL(iommu_debugfs_new_driver_dir);
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index d2aa23202bb9..350819f1c5e1 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1747,6 +1747,8 @@ static int __init iommu_init(void)
>   					       NULL, kernel_kobj);
>   	BUG_ON(!iommu_group_kset);
>   
> +	iommu_debugfs_setup();
> +
>   	return 0;
>   }
>   core_initcall(iommu_init);
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 19938ee6eb31..25018ac0fdab 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -698,4 +698,14 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
>   
>   #endif /* CONFIG_IOMMU_API */
>   
> +#ifdef CONFIG_IOMMU_DEBUGFS
> +void iommu_debugfs_setup(void);
> +struct dentry *iommu_debugfs_new_driver_dir(char *vendor);
> +#else
> +static inline void iommu_debugfs_setup(void) {}
> +static inline struct dentry *iommu_debugfs_new_driver_dir(char *vendor) { \

Since this is a function, not a macro, it doesn't really need the line 
continuations.

Robin.

> +	return NULL; \
> +}
> +#endif
> +
>   #endif /* __LINUX_IOMMU_H */
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
