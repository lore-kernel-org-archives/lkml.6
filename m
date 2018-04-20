Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754874AbeDTNMi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:12:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:53858 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754764AbeDTNMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:12:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,301,1520924400";
   d="scan'208";a="43387110"
Date: Fri, 20 Apr 2018 16:12:29 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: John Garry <john.garry@huawei.com>
Cc: rjw@rjwysocki.net, andriy.shevchenko@linux.intel.com,
        linux-acpi@vger.kernel.org, lenb@kernel.org, lorenzo.pieralisi@arm.com,
        linux-kernel@vger.kernel.org, arnd@arndb.de, graeme.gregory@linaro.org,
        helgaas@kernel.org, linuxarm@huawei.com, z.liuxinliang@hisilicon.com
Subject: Re: [RFC PATCH 2/2] HISI LPC: Add PNP device support
Message-ID: <20180420131229.GW2173@lahna.fi.intel.com>
References: <1524218846-169934-1-git-send-email-john.garry@huawei.com>
 <1524218846-169934-3-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524218846-169934-3-git-send-email-john.garry@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 06:07:26PM +0800, John Garry wrote:
> Currently the driver creates an per-ACPI device mfd_cell
> for child devices. This does not suit devices which are
> PNP-compatible, as we expect PNP-compatible devices to
> derive PNP devices.
> 
> To add PNP device support, we continue to allow the PNP
> scan code to create the PNP device (which have the
> enumeration_by_parent flag set), but expect the PNP
> scan to defer adding the device to allow the host probe
> code to do this. In addition, no longer do we create an
> mfd_cell (platform_device) for PNP-compatible devices.
> 
> We take this approach so that host probe code can
> translate the IO resources of the PNP device prior
> to adding the device.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/bus/hisi_lpc.c | 38 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
> index 2d4611e..d228bc5 100644
> --- a/drivers/bus/hisi_lpc.c
> +++ b/drivers/bus/hisi_lpc.c
> @@ -17,8 +17,11 @@
>  #include <linux/of_address.h>
>  #include <linux/of_platform.h>
>  #include <linux/pci.h>
> +#include <linux/pnp.h>
>  #include <linux/slab.h>
>  
> +#include "../pnp/base.h"
> +
>  #define DRV_NAME "hisi-lpc"
>  
>  /*
> @@ -469,8 +472,11 @@ static int hisi_lpc_acpi_probe(struct device *hostdev)
>  	struct acpi_device *child;
>  	int size, ret, count = 0, cell_num = 0;
>  
> -	list_for_each_entry(child, &adev->children, node)
> +	list_for_each_entry(child, &adev->children, node) {
> +		if (acpi_is_pnp_device(child))
> +			continue;
>  		cell_num++;
> +	}
>  
>  	/* allocate the mfd cell and companion ACPI info, one per child */
>  	size = sizeof(*mfd_cells) + sizeof(*hisi_lpc_mfd_cells);
> @@ -492,6 +498,9 @@ static int hisi_lpc_acpi_probe(struct device *hostdev)
>  			.pnpid = pnpid,
>  		};
>  
> +		if (acpi_is_pnp_device(child))
> +			continue;
> +
>  		/*
>  		 * For any instances of this host controller (Hip06 and Hip07
>  		 * are the only chipsets), we would not have multiple slaves
> @@ -523,6 +532,33 @@ static int hisi_lpc_acpi_probe(struct device *hostdev)
>  		return ret;
>  	}
>  
> +	list_for_each_entry(child, &adev->children, node) {
> +		struct pnp_resource *pnp_res;
> +		struct pnp_dev *pnp_dev;
> +		int rc;
> +
> +		if (!acpi_is_pnp_device(child))
> +			continue;
> +
> +		pnp_dev = child->driver_data;

...or better yet a PNP helper function that makes this more
understandable.

> +
> +		/*
> +		 * Prior to adding the device, we need to translate the
> +		 * resources to logical PIO addresses.
> +		 */
> +		list_for_each_entry(pnp_res, &pnp_dev->resources, list) {
> +			struct resource *res = &pnp_res->res;
> +
> +			if (res->flags | IORESOURCE_IO)

I think you should use

	if (resource_type(res) == IORESOURCE_IO)

instead.

> +				hisi_lpc_acpi_xlat_io_res(child, adev, res);
> +		}
> +		rc = pnp_add_device(pnp_dev);
> +		if (rc) {
> +			put_device(&pnp_dev->dev);
> +			return rc;
> +		}
> +	}
> +
>  	return 0;
>  }
>  
> -- 
> 1.9.1
