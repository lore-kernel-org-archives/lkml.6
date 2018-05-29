Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936998AbeE2Sjj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:39:39 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42425 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754671AbeE2Sjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:39:37 -0400
X-ME-Proxy: <xmx:aZ4NW_7idUL87vGC4X3jasAnyetiPZT3adBiBnsiWZ6duUBNJ2VX0Q>
X-ME-Proxy: <xmx:aZ4NWxOky2mJrx9gUmtaOrBwJ6-gYY01leAcN1845ug5JRKvjLxa9w>
X-ME-Proxy: <xmx:aZ4NW4GQl3aMhi5NHyx_1yCV5JbjDelg9PvcREbLpNAih-tss7bBBQ>
X-ME-Proxy: <xmx:aZ4NW9QrjQhdULkih9tUxhiRxdFn6F-5iA6TaUXEo7w6vWZBtQC2yA>
X-ME-Proxy: <xmx:aZ4NW4S9zXuY8Zs7t6NCZVQZFE_WMiPtrzUqAuV5d2Z54N5a8heYcQ>
X-ME-Proxy: <xmx:aZ4NW8d5-Fzjzg6SPPxNCBz8XPVccZv0FUN2smX81wpn0NAcUkfVfQ>
X-ME-Sender: <xms:aZ4NWyfIgkgwokiCmFCe73TEO8IqGXmBVPMhPd4gWNhI8-JRzF5kaw>
Date: Tue, 29 May 2018 20:39:17 +0200
From: Greg KH <greg@kroah.com>
To: Gary R Hook <gary.hook@amd.com>
Cc: iommu@lists.linux-foundation.org, joro@8bytes.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
Message-ID: <20180529183917.GA10618@kroah.com>
References: <152761784341.2654.8609366076331539902.stgit@sosgrh1.amd.com>
 <152761820371.2654.4551405686504157036.stgit@sosgrh1.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152761820371.2654.4551405686504157036.stgit@sosgrh1.amd.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 01:23:23PM -0500, Gary R Hook wrote:
> Implement a skeleton framework for debugfs support in the
> AMD IOMMU. Add a hidden boolean to Kconfig that is defined
> for the AMD IOMMU when general IOMMY DebugFS support is
> enabled.
> 
> Signed-off-by: Gary R Hook <gary.hook@amd.com>
> ---
>  drivers/iommu/Kconfig             |    4 ++++
>  drivers/iommu/Makefile            |    1 +
>  drivers/iommu/amd_iommu_debugfs.c |   39 +++++++++++++++++++++++++++++++++++++
>  drivers/iommu/amd_iommu_init.c    |    6 ++++--
>  drivers/iommu/amd_iommu_proto.h   |    6 ++++++
>  drivers/iommu/amd_iommu_types.h   |    5 +++++
>  6 files changed, 59 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/iommu/amd_iommu_debugfs.c
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index f9af25ac409f..ec223f6f4ad4 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -137,6 +137,10 @@ config AMD_IOMMU
>  	  your BIOS for an option to enable it or if you have an IVRS ACPI
>  	  table.
>  
> +config AMD_IOMMU_DEBUGFS
> +	def_bool y

Why default y?  Can you not boot a box without this?  If not, it should
not be Y.

> +	depends on AMD_IOMMU && IOMMU_DEBUGFS
> +
>  config AMD_IOMMU_V2
>  	tristate "AMD IOMMU Version 2 driver"
>  	depends on AMD_IOMMU
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 74cfbc392862..47fd6ea9de2d 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_IOMMU_IOVA) += iova.o
>  obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
>  obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
>  obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
> +obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += amd_iommu_debugfs.o
>  obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
>  obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
>  obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
> diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd_iommu_debugfs.c
> new file mode 100644
> index 000000000000..6dff98552969
> --- /dev/null
> +++ b/drivers/iommu/amd_iommu_debugfs.c
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AMD IOMMU driver
> + *
> + * Copyright (C) 2018 Advanced Micro Devices, Inc.
> + *
> + * Author: Gary R Hook <gary.hook@amd.com>
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/iommu.h>
> +#include <linux/pci.h>
> +#include "amd_iommu_proto.h"
> +#include "amd_iommu_types.h"
> +
> +static struct dentry *amd_iommu_debugfs;
> +static DEFINE_MUTEX(amd_iommu_debugfs_lock);
> +
> +#define	MAX_NAME_LEN	20
> +
> +void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
> +{
> +	char name[MAX_NAME_LEN + 1];
> +
> +	mutex_lock(&amd_iommu_debugfs_lock);
> +	if (!amd_iommu_debugfs)
> +		amd_iommu_debugfs = iommu_debugfs_new_driver_dir("amd");
> +	mutex_unlock(&amd_iommu_debugfs_lock);
> +
> +	if (amd_iommu_debugfs) {

Do not test this.

> +		snprintf(name, MAX_NAME_LEN, "iommu%02d", iommu->index);
> +		iommu->debugfs = debugfs_create_dir(name,
> +						    amd_iommu_debugfs);
> +		if (!iommu->debugfs) {

No, you don't care about the return value of any debugfs call.  Just
save the directory and move on.  If it's not correct, find, nothing is
wrong, just keep going.

thanks,

greg k-h
