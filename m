Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754811AbeDTMuM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 08:50:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:39216 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754717AbeDTMuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 08:50:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,301,1520924400";
   d="scan'208";a="35742869"
Message-ID: <1524228606.21176.472.camel@linux.intel.com>
Subject: Re: [RFC PATCH 2/2] HISI LPC: Add PNP device support
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Garry <john.garry@huawei.com>, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org, lenb@kernel.org,
        mika.westerberg@linux.intel.com, lorenzo.pieralisi@arm.com
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, graeme.gregory@linaro.org,
        helgaas@kernel.org, linuxarm@huawei.com, z.liuxinliang@hisilicon.com
Date: Fri, 20 Apr 2018 15:50:06 +0300
In-Reply-To: <1524218846-169934-3-git-send-email-john.garry@huawei.com>
References: <1524218846-169934-1-git-send-email-john.garry@huawei.com>
         <1524218846-169934-3-git-send-email-john.garry@huawei.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-04-20 at 18:07 +0800, John Garry wrote:
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

> +	list_for_each_entry(child, &adev->children, node) {
> +		if (acpi_is_pnp_device(child))
> +			continue;

This is good candidate for a separate helper macro

#define for_each_acpi_non_pnp_device(child, adev) \
...

(see, for example, for_each_pci_bridge() implementation as an example)

 
> +	list_for_each_entry(child, &adev->children, node) {

> +		if (!acpi_is_pnp_device(child))
> +			continue;

Ditto.

> +		/*
> +		 * Prior to adding the device, we need to translate
> the
> +		 * resources to logical PIO addresses.
> +		 */
> +		list_for_each_entry(pnp_res, &pnp_dev->resources,
> list) {
> +			struct resource *res = &pnp_res->res;
> +

> +			if (res->flags | IORESOURCE_IO)

What does this mean?

> +				hisi_lpc_acpi_xlat_io_res(child,
> adev, res);
> +		}

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
