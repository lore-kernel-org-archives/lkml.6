Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751792AbeEDJ13 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 05:27:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53740 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751755AbeEDJ10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 05:27:26 -0400
Subject: Re: [PATCH 1/2] HISI LPC: Reference static MFD cells for ACPI support
To: Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <1525360119-102166-1-git-send-email-john.garry@huawei.com>
 <1525360119-102166-2-git-send-email-john.garry@huawei.com>
 <1525366486.21176.653.camel@linux.intel.com> <20180504090216.GC3928@dell>
CC: <xuwei5@huawei.com>, <mika.westerberg@linux.intel.com>,
        <rjw@rjwysocki.net>, <linux-kernel@vger.kernel.org>, <arnd@arndb.de>,
        <graeme.gregory@linaro.org>, <helgaas@kernel.org>,
        <z.liuxinliang@hisilicon.com>, <linuxarm@huawei.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <4a15b0b4-5707-d51b-4762-02df8e153bd9@huawei.com>
Date: Fri, 4 May 2018 10:27:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180504090216.GC3928@dell>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2018 10:02, Lee Jones wrote:
> On Thu, 03 May 2018, Andy Shevchenko wrote:
>
>> On Thu, 2018-05-03 at 23:08 +0800, John Garry wrote:
>>> Currently for ACPI support the driver models the host as
>>> an MFD. For a device connected to the LPC bus, we dynamically
>>> create an MFD cell for that device, configuring the cell
>>> name and ACPI match parameters manually. This makes supporting
>>> named devices and also special setup handling for certain devices
>>> awkward, as we would need to introduce some special ACPI device
>>> handling according to device HID.
>>>
>>> To avoid this, create reference static MFD cells for known
>>> child devices, so when adding an MFD cell we can fix the cell
>>> platform data as required. For this, a setup callback function
>>> is added.
>>>
>>> For now, only the IPMI cell is added.
>>
>>> +static const struct mfd_cell *hisi_lpc_acpi_mfd_get_cell(const char
>>> *hid)
>>> +{
>>> +	const struct hisi_lpc_acpi_mfd_cell *cell =
>>> hisi_lpc_acpi_mfd_cells;
>>> +
>>> +	for (; cell && cell->mfd_cell.name; cell++) {
>>> +		const struct mfd_cell *mfd_cell = &cell->mfd_cell;
>>> +		const struct mfd_cell_acpi_match *acpi_match;
>>> +
>>> +		acpi_match = mfd_cell->acpi_match;
>>> +		if (!strcmp(acpi_match->pnpid, hid))
>>> +			return mfd_cell;
>>> +	}
>>> +
>>> +	return NULL;
>>> +}
>>
>> I'm not sure I understand why MFD core can't do it (as seen in lines
>> drivers/mfd/core.c:105 and below).
>

Hi Lee,

> You shouldn't be using the MFD API outside of MFD anyway.  Either it
> is an MFD driver, or it isn't.  If it is, please move it. If it's not,
> please don't use the API.

We're modelling as an MFD, but it's not an MFD in the classic sense. 
We're just using the MFD API for convenience (and to avoid code 
duplication), as the MFD API does what we require for this driver.

>
> My current suspicion is that the driver needs splitting and only part
> of it ends up in MFD.
>

How would you propose splitting the driver? By adding a lib function 
specific for this driver for the ACPI probe?

Cheers,
John
