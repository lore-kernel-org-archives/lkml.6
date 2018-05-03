Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbeECQyv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 12:54:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:61249 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750954AbeECQyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 12:54:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,359,1520924400";
   d="scan'208";a="52949643"
Message-ID: <1525366486.21176.653.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] HISI LPC: Reference static MFD cells for ACPI
 support
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Garry <john.garry@huawei.com>, xuwei5@huawei.com,
        mika.westerberg@linux.intel.com, lee.jones@linaro.org
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, arnd@arndb.de,
        graeme.gregory@linaro.org, helgaas@kernel.org,
        z.liuxinliang@hisilicon.com, linuxarm@huawei.com
Date: Thu, 03 May 2018 19:54:46 +0300
In-Reply-To: <1525360119-102166-2-git-send-email-john.garry@huawei.com>
References: <1525360119-102166-1-git-send-email-john.garry@huawei.com>
         <1525360119-102166-2-git-send-email-john.garry@huawei.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-03 at 23:08 +0800, John Garry wrote:
> Currently for ACPI support the driver models the host as
> an MFD. For a device connected to the LPC bus, we dynamically
> create an MFD cell for that device, configuring the cell
> name and ACPI match parameters manually. This makes supporting
> named devices and also special setup handling for certain devices
> awkward, as we would need to introduce some special ACPI device
> handling according to device HID.
> 
> To avoid this, create reference static MFD cells for known
> child devices, so when adding an MFD cell we can fix the cell
> platform data as required. For this, a setup callback function
> is added.
> 
> For now, only the IPMI cell is added.

> +static const struct mfd_cell *hisi_lpc_acpi_mfd_get_cell(const char
> *hid)
> +{
> +	const struct hisi_lpc_acpi_mfd_cell *cell =
> hisi_lpc_acpi_mfd_cells;
> +
> +	for (; cell && cell->mfd_cell.name; cell++) {
> +		const struct mfd_cell *mfd_cell = &cell->mfd_cell;
> +		const struct mfd_cell_acpi_match *acpi_match;
> +
> +		acpi_match = mfd_cell->acpi_match;
> +		if (!strcmp(acpi_match->pnpid, hid))
> +			return mfd_cell;
> +	}
> +
> +	return NULL;
> +}

I'm not sure I understand why MFD core can't do it (as seen in lines
drivers/mfd/core.c:105 and below).

> +	/* allocate the mfd cells, one per child */
> +	size = sizeof(*mfd_cells);
>  	mfd_cells = devm_kcalloc(hostdev, cell_num, size,
> GFP_KERNEL);
>  	if (!mfd_cells)
>  		return -ENOMEM;

And since you have structures already, I'm not sure why you need another
allocation for them. Only what you would need is to apply resources and
call devm_mfd_add_devices() per each found device.

> +		cell = container_of(mfd_cell_ref, typeof(*cell),
> mfd_cell);

Why we can't iterate over inherited type of objects directly?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
