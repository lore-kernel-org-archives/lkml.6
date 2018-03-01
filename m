Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AG47ELtevXnlx7J2BV9ScZjqfT6U/R/ImBwNAd+MpkNv4F10Hg79JjObzvJagjmVh1DFp4sfgXIM
ARC-Seal: i=1; a=rsa-sha256; t=1519933864; cv=none;
        d=google.com; s=arc-20160816;
        b=fbxpCe142TjoYa0nYPNGygqJug7jN6+Ys4tTjFPdYnRgPo4DeLWyT+cFXC2jG4Hxwy
         Txx/NZIQkO1dqkH5s9ZhvdjPC1RlwijBV0mX2ig8MFKSqefidwqIxrsKA1F97fl0Igly
         MfRkymyK/Y9icpGiUQoP7YqSye20HJGcP3AefK4+x8GbLWxRPnW4J4I43bMWKYZg8iHC
         nAZA9h3q39rm8u2m3/GIf1md2KxF3CWBqMZTKwyW0F3xHoZROkiSK5bpRcdWBNN7ehiy
         nJnFxH92nXUSsUwmYcu0VyUWCG57PHO+o4kRry/AYlB45O8/wc1maATs411zlnERkAaB
         2TQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=yJHjrm7JpL6qYmj49/nG+jzqkKllbHGLxLoVTa4eepg=;
        b=nOT8r9PnIVsPiHWYKSLF0TByOafSvOReX3/Sy5X4HrhqqSmI7IAAw2mGq77RZZZkpL
         xLCecUMUEJn/bLrqE+BXXpJ1pUDFUbKlkfy1E6U+8anEDguBeLIDsUbgK+/HUjC31hsa
         ydXR+IUPZSpbU19VVj6RuaUpVw5ruI8cfDqpnYUch94xACYAdqNZB0eucq3yNN1QwLfA
         sNHB98p/XqXyBeunRVh3kTrwpGwaigPlLRRzS3N05DDgMeS46exe0/pHgLfI9XkG/Jve
         H7ya9mu1/ZrpVGrMk50rRK2h8vv/Ow4wqil/ogDX5ho0OqMQWKl0MnT7mTzcv+NGjuKm
         Yc8w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,409,1515484800";
   d="scan'208";a="31728767"
Message-ID: <1519933855.10722.364.camel@linux.intel.com>
Subject: Re: [PATCH v15 8/9] HISI LPC: Add ACPI support
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Garry <john.garry@huawei.com>, mika.westerberg@linux.intel.com,
 rafael@kernel.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net,
 hanjun.guo@linaro.org, robh+dt@kernel.org, bhelgaas@google.com,
 arnd@arndb.de,  mark.rutland@arm.com, olof@lixom.net,
 dann.frazier@canonical.com,  andy.shevchenko@gmail.com, robh@kernel.org
Cc: joe@perches.com, benh@kernel.crashing.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linuxarm@huawei.com,  minyard@acm.org, devicetree@vger.kernel.org,
 linux-arch@vger.kernel.org,  rdunlap@infradead.org,
 gregkh@linuxfoundation.org, akpm@linux-foundation.org,
 frowand.list@gmail.com, agraf@suse.de
Date: Thu, 01 Mar 2018 21:50:55 +0200
In-Reply-To: <1519663249-9850-9-git-send-email-john.garry@huawei.com>
References: <1519663249-9850-1-git-send-email-john.garry@huawei.com>
	 <1519663249-9850-9-git-send-email-john.garry@huawei.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593479230024368492?=
X-GMAIL-MSGID: =?utf-8?q?1593766172298488218?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-02-27 at 00:40 +0800, John Garry wrote:
> Based on the previous patches, this patch supports the
> LPC host on hip06/hip07 for ACPI FW.
> 
> It is the responsibility of the LPC host driver to
> enumerate the child devices, as the ACPI scan code will
> not enumerate children of "indirect IO" hosts.
> 
> The ACPI table for the LPC host controller and the child
> devices is in the following format:
>   Device (LPC0) {
>     Name (_HID, "HISI0191")  // HiSi LPC
>     Name (_CRS, ResourceTemplate () {
>       Memory32Fixed (ReadWrite, 0xa01b0000, 0x1000)
>     })
>   }
> 
>   Device (LPC0.IPMI) {
>     Name (_HID, "IPI0001")
>     Name (LORS, ResourceTemplate() {
>       QWordIO (
>         ResourceConsumer,
> 	MinNotFixed,     // _MIF
> 	MaxNotFixed,     // _MAF
> 	PosDecode,
> 	EntireRange,
> 	0x0,             // _GRA
> 	0xe4,            // _MIN
> 	0x3fff,          // _MAX
> 	0x0,             // _TRA
> 	0x04,            // _LEN
> 	, ,
> 	BTIO
>       )
>     })
> 
> Since the IO resources of the child devices need to be
> translated from LPC bus addresses to logical PIO addresses,
> and we shouldn't modify the resources of the devices
> generated in the FW scan, a per-child MFD is created as
> a substitute. The MFD IO resources will be the translated
> bus addresses of the ACPI child.

Ok, this needs to be thought about a bit more.

I guess I understand what's is the problem with PNP IDs in the driver.

You probe your LPC device quite late.
One option is to move from classical probe to a event-driven model, i.e.
via registering a notifier (see acpi_lpss.c), preparing necessary stuff
at earlier stages and then register devices by their enumeration and
appearance.

Though, if I would be you I would seek a opinion from Rafael and Mika
(maybe others as well).

See also some comments below.

> +#ifdef CONFIG_ACPI
> +#define MFD_CHILD_NAME_PREFIX DRV_NAME"-"

> +#define MFD_CHILD_NAME_LEN (ACPI_ID_LEN +
> sizeof(MFD_CHILD_NAME_PREFIX))

..._PREFIX) - 1)

?

> +static int hisi_lpc_acpi_xlat_io_res(struct acpi_device *adev,
> +				     struct acpi_device *host,
> +				     struct resource *res)
> +{
> +	unsigned long sys_port;

> +	resource_size_t len = res->end - res->start;

resource_size()

> +	return 0;
> +}


> +static int hisi_lpc_acpi_set_io_res(struct device *child,
> +				    struct device *hostdev,
> +				    const struct resource **res,
> +				    int *num_res)
> +{

> +	/*
> +	 * The following code segment to retrieve the resources is
> common to
> +	 * acpi_create_platform_device(), so consider a common helper
> function
> +	 * in future.
> +	 */
> +	count = acpi_dev_get_resources(adev, &resource_list, NULL,
> NULL);
> +	if (count <= 0) {
> +		dev_dbg(child, "failed to get resources\n");

> +		return count ? count : -EIO;

count == 0 --> return 0;

Is it by design? (I didn't check acpi_create_platform_device() though)

> +	}
> +
> +	resources = devm_kcalloc(hostdev, count, sizeof(*resources),
> +				 GFP_KERNEL);
> +	if (!resources) {
> +		dev_warn(hostdev, "could not allocate memory for %d
> resources\n",
> +			 count);
> +		acpi_dev_free_resource_list(&resource_list);
> +		return -ENOMEM;
> +	}
> +	count = 0;
> +	list_for_each_entry(rentry, &resource_list, node)
> +		resources[count++] = *rentry->res;
> +
> +	acpi_dev_free_resource_list(&resource_list);

> +
> +	return 0;
> +}

> +
> +/*
> + * hisi_lpc_acpi_probe - probe children for ACPI FW
> + * @hostdev: LPC host device pointer
> + *
> + * Returns 0 when successful, and a negative value for failure.
> + *
> + * Scan all child devices and create a per-device MFD with
> + * logical PIO translated IO resources.
> + */
> +static int hisi_lpc_acpi_probe(struct device *hostdev)
> +{
> +	struct acpi_device *adev = ACPI_COMPANION(hostdev);
> +	struct hisi_lpc_mfd_cell *hisi_lpc_mfd_cells;
> +	struct mfd_cell *mfd_cells;
> +	struct acpi_device *child;
> +	int size, ret, count = 0, cell_num = 0;
> +
> +	list_for_each_entry(child, &adev->children, node)
> +		cell_num++;
> +
> +	/* allocate the mfd cell and companion acpi info, one per
> child */
> +	size = sizeof(*mfd_cells) + sizeof(*hisi_lpc_mfd_cells);
> +	mfd_cells = devm_kcalloc(hostdev, cell_num, size,
> GFP_KERNEL);
> +	if (!mfd_cells)
> +		return -ENOMEM;
> +

> +	hisi_lpc_mfd_cells = (struct hisi_lpc_mfd_cell *)
> +					&mfd_cells[cell_num];

One line, please.

Just noticed that calloc() memory layout is not the same how you are
using it.

> +	/* Only consider the children of the host */
> +	list_for_each_entry(child, &adev->children, node) {
> +		struct mfd_cell *mfd_cell = &mfd_cells[count];
> +		struct hisi_lpc_mfd_cell *hisi_lpc_mfd_cell =
> +					&hisi_lpc_mfd_cells[count];
> +		struct mfd_cell_acpi_match *acpi_match =
> +					&hisi_lpc_mfd_cell-
> >acpi_match;
> +		char *name = hisi_lpc_mfd_cell[count].name;
> +		char *pnpid = hisi_lpc_mfd_cell[count].pnpid;
> +		struct mfd_cell_acpi_match match = {
> +			.pnpid = pnpid,
> +		};
> +

> +		snprintf(name, MFD_CHILD_NAME_LEN,
> MFD_CHILD_NAME_PREFIX"%s",
> +			 acpi_device_hid(child));

No possibility of identical devices?

> +		snprintf(pnpid, ACPI_ID_LEN, "%s",
> acpi_device_hid(child));
> +
> +		memcpy(acpi_match, &match, sizeof(*acpi_match));
> +		mfd_cell->name = name;
> +		mfd_cell->acpi_match = acpi_match;
> +
> +		ret = hisi_lpc_acpi_set_io_res(&child->dev, &adev-
> >dev,
> +					       &mfd_cell->resources,
> +					       &mfd_cell-
> >num_resources);
> +		if (ret) {
> +			dev_warn(&child->dev, "set resource
> fail(%d)\n", ret);
> +			return ret;
> +		}
> +		count++;
> +	}
> +
> +	ret = mfd_add_devices(hostdev, 

> PLATFORM_DEVID_NONE,

You mean it's not possible to have more than one identical device?

> +			      mfd_cells, cell_num, NULL, 0, NULL);
> +	if (ret) {
> +		dev_err(hostdev, "failed to add mfd cells (%d)\n",
> ret);
> +		return ret;
> +	}


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
