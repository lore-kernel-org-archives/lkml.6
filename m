Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751461AbeEDMaT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 08:30:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7653 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751272AbeEDMaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 08:30:18 -0400
Subject: Re: [PATCH 1/2] HISI LPC: Reference static MFD cells for ACPI support
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <xuwei5@huawei.com>, <mika.westerberg@linux.intel.com>,
        <lee.jones@linaro.org>
References: <1525360119-102166-1-git-send-email-john.garry@huawei.com>
 <1525360119-102166-2-git-send-email-john.garry@huawei.com>
 <1525366486.21176.653.camel@linux.intel.com>
CC: <rjw@rjwysocki.net>, <linux-kernel@vger.kernel.org>, <arnd@arndb.de>,
        <graeme.gregory@linaro.org>, <helgaas@kernel.org>,
        <z.liuxinliang@hisilicon.com>, <linuxarm@huawei.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <8c2627fa-a350-9a39-6a54-c789b6a3546a@huawei.com>
Date: Fri, 4 May 2018 13:29:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1525366486.21176.653.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2018 17:54, Andy Shevchenko wrote:
> On Thu, 2018-05-03 at 23:08 +0800, John Garry wrote:
>> Currently for ACPI support the driver models the host as
>> an MFD. For a device connected to the LPC bus, we dynamically
>> create an MFD cell for that device, configuring the cell
>> name and ACPI match parameters manually. This makes supporting
>> named devices and also special setup handling for certain devices
>> awkward, as we would need to introduce some special ACPI device
>> handling according to device HID.
>>
>> To avoid this, create reference static MFD cells for known
>> child devices, so when adding an MFD cell we can fix the cell
>> platform data as required. For this, a setup callback function
>> is added.

Hi Andy,

>>
>> For now, only the IPMI cell is added.
>
>> +static const struct mfd_cell *hisi_lpc_acpi_mfd_get_cell(const char
>> *hid)
>> +{
>> +	const struct hisi_lpc_acpi_mfd_cell *cell =
>> hisi_lpc_acpi_mfd_cells;
>> +
>> +	for (; cell && cell->mfd_cell.name; cell++) {
>> +		const struct mfd_cell *mfd_cell = &cell->mfd_cell;
>> +		const struct mfd_cell_acpi_match *acpi_match;
>> +
>> +		acpi_match = mfd_cell->acpi_match;
>> +		if (!strcmp(acpi_match->pnpid, hid))
>> +			return mfd_cell;
>> +	}
>> +
>> +	return NULL;
>> +}
>
> I'm not sure I understand why MFD core can't do it (as seen in lines
> drivers/mfd/core.c:105 and below).
>

Right, I think MFD core does the same.

>> +	/* allocate the mfd cells, one per child */
>> +	size = sizeof(*mfd_cells);
>>  	mfd_cells = devm_kcalloc(hostdev, cell_num, size,
>> GFP_KERNEL);
>>  	if (!mfd_cells)
>>  		return -ENOMEM;
>
> And since you have structures already, I'm not sure why you need another
> allocation for them. Only what you would need is to apply resources and
> call devm_mfd_add_devices() per each found device.

I was creating a copy as the originals are in the hisi_lpc_acpi_mfd_cell 
struct type, while we would require an array of mfd_cells.

>
>> +		cell = container_of(mfd_cell_ref, typeof(*cell),
>> mfd_cell);
>
> Why we can't iterate over inherited type of objects directly?
>

We could do.

Thanks,
John
