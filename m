Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755053AbeDTOJ6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:09:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7189 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754895AbeDTOJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:09:56 -0400
Subject: Re: [RFC PATCH 1/2] ACPI / PNP: Don't add "enumeration_by_parent"
 devices
To: Mika Westerberg <mika.westerberg@linux.intel.com>
References: <1524218846-169934-1-git-send-email-john.garry@huawei.com>
 <1524218846-169934-2-git-send-email-john.garry@huawei.com>
 <20180420130727.GV2173@lahna.fi.intel.com>
 <27c3f84e-4d53-4b6b-7382-04908082ed01@huawei.com>
 <20180420135222.GY2173@lahna.fi.intel.com>
CC: <rjw@rjwysocki.net>, <andriy.shevchenko@linux.intel.com>,
        <linux-acpi@vger.kernel.org>, <lenb@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <linux-kernel@vger.kernel.org>,
        <arnd@arndb.de>, <graeme.gregory@linaro.org>, <helgaas@kernel.org>,
        <linuxarm@huawei.com>, <z.liuxinliang@hisilicon.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <75eae3ac-228f-d6a4-bb0e-4bd27e35c55d@huawei.com>
Date: Fri, 20 Apr 2018 15:09:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180420135222.GY2173@lahna.fi.intel.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2018 14:52, Mika Westerberg wrote:
> On Fri, Apr 20, 2018 at 02:24:18PM +0100, John Garry wrote:
>> Hi Mika,
>>
>> On 20/04/2018 14:07, Mika Westerberg wrote:
>>> On Fri, Apr 20, 2018 at 06:07:25PM +0800, John Garry wrote:
>>>> +	} else {
>>>> +		device->driver_data = dev;
>>>
>>> I think this deserves a comment explaining why we (ab)use driver_data
>>> like this.
>>
>> Sure, could add. I didn't see any other way for the acpi_device structure to
>> reference the derived PNP device.
>>
>> TBH, This overall approach is not good since we are creating the PNP device
>> in the scan, and then leaving the device in limbo, waiting for the parent to
>> add it, if at all. There's no rule for this.
>>
>> So I'm looking for ideas on how to improve this.
>

Hi Mika,

> One idea is to make pnpacpi_add_device() available outside of PNP and
> call it directly (or some variation) in hisi_lpc.c when it walks over
> its children.
>

I did consider this initially and it seems quite straightforward.

However I think the problem is that we would need to modify the 
acpi_device child resources from FW with kernel-specific resources, 
which does not seem right (I think that is what you meant). As I see, 
this is one reason that we went in the direction of modelling the host 
as an MFD, as we could set the resources of the mfd_cells.

So adding a variant of pnpacpi_add_device() could work, or modifying 
pnpacpi_add_device() to accept a callback to translate the resources. 
But this feature is specific to our very special requirement...

Thanks,
John

> .
>
