Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754936AbeDTNKT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:10:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48832 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754805AbeDTNKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:10:17 -0400
Subject: Re: [RFC PATCH 2/2] HISI LPC: Add PNP device support
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <rjw@rjwysocki.net>, <linux-acpi@vger.kernel.org>, <lenb@kernel.org>,
        <mika.westerberg@linux.intel.com>, <lorenzo.pieralisi@arm.com>
References: <1524218846-169934-1-git-send-email-john.garry@huawei.com>
 <1524218846-169934-3-git-send-email-john.garry@huawei.com>
 <1524228606.21176.472.camel@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <arnd@arndb.de>,
        <graeme.gregory@linaro.org>, <helgaas@kernel.org>,
        <linuxarm@huawei.com>, <z.liuxinliang@hisilicon.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <e838b3ef-5cf8-ac12-6b44-a1f8001f8b94@huawei.com>
Date: Fri, 20 Apr 2018 14:09:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1524228606.21176.472.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2018 13:50, Andy Shevchenko wrote:
> On Fri, 2018-04-20 at 18:07 +0800, John Garry wrote:
>> Currently the driver creates an per-ACPI device mfd_cell
>> for child devices. This does not suit devices which are
>> PNP-compatible, as we expect PNP-compatible devices to
>> derive PNP devices.
>>
>> To add PNP device support, we continue to allow the PNP
>> scan code to create the PNP device (which have the
>> enumeration_by_parent flag set), but expect the PNP
>> scan to defer adding the device to allow the host probe
>> code to do this. In addition, no longer do we create an
>> mfd_cell (platform_device) for PNP-compatible devices.
>>
>> We take this approach so that host probe code can
>> translate the IO resources of the PNP device prior
>> to adding the device.
>

Hi Andy,

Thanks for checking this.

>> +	list_for_each_entry(child, &adev->children, node) {
>> +		if (acpi_is_pnp_device(child))
>> +			continue;
>
> This is good candidate for a separate helper macro
>
> #define for_each_acpi_non_pnp_device(child, adev) \
> ...

Right, I did consider this, but was holding off refining until I get 
past RFC stage. In fact, we could also process each child entry in one 
loop, like this:

list_for_each_entry(child, &adev->children, node) {
	if (acpi_is_pnp_device(child)) {
		/* Do PNP compatible device work */

	} else {
		/* otherwise, make an MFD cell ... */
	}

>
> (see, for example, for_each_pci_bridge() implementation as an example)
>
>
>> +	list_for_each_entry(child, &adev->children, node) {
>
>> +		if (!acpi_is_pnp_device(child))
>> +			continue;
>
> Ditto.
>

ok

>> +		/*
>> +		 * Prior to adding the device, we need to translate
>> the
>> +		 * resources to logical PIO addresses.
>> +		 */
>> +		list_for_each_entry(pnp_res, &pnp_dev->resources,
>> list) {
>> +			struct resource *res = &pnp_res->res;
>> +
>
>> +			if (res->flags | IORESOURCE_IO)
>
> What does this mean?

Here we check the resource flag for each resource for this PNP device - 
for IO resources we must translate the resource value from the bus 
address to the logical PIO address.

>
>> +				hisi_lpc_acpi_xlat_io_res(child,
>> adev, res);
>> +		}
>

Regards,
John
