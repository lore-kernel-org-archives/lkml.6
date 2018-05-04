Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752031AbeEDMh4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 08:37:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7654 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751480AbeEDMeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 08:34:01 -0400
Subject: Re: [PATCH 2/2] HISI LPC: Add ACPI UART support
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <xuwei5@huawei.com>, <mika.westerberg@linux.intel.com>,
        <lee.jones@linaro.org>
References: <1525360119-102166-1-git-send-email-john.garry@huawei.com>
 <1525360119-102166-3-git-send-email-john.garry@huawei.com>
 <1525366584.21176.654.camel@linux.intel.com>
CC: <rjw@rjwysocki.net>, <linux-kernel@vger.kernel.org>, <arnd@arndb.de>,
        <graeme.gregory@linaro.org>, <helgaas@kernel.org>,
        <z.liuxinliang@hisilicon.com>, <linuxarm@huawei.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <3fd88684-7bdd-b3b4-cddc-a551d5d820ff@huawei.com>
Date: Fri, 4 May 2018 13:33:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1525366584.21176.654.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2018 17:56, Andy Shevchenko wrote:
> On Thu, 2018-05-03 at 23:08 +0800, John Garry wrote:
>> On the Huawei D03 development board the system UART is
>> the UART connected on the LPC bus.
>>
>> The profile for the device driver required for this HW
>> would be as follows:
>> - platform driver
>> - supports 16550
>> - supports ACPI
>> - supports polling mode
>> - supports IO space
>>
>> In principle we should use the PNP driver (8250_dw.c) for
>> 8250-devices with ACPI FW. However since this host driver
>> does not support PNP devices, and modifying the PNP core
>> code to support it is not worth the effort, use the generic
>> 8250 isa driver.
>>
>> For this, we need to setup the MFD cell platform data for
>> a serial 8250 Port.
>>
>> In addition to this change, we also make the following
>> changes:
>> - set child ACPI device as enumerated. This fixes a conflict
>>   in serdev setup for the UART
>> - use platform device ID auto for creating the uart child
>>   platform device to avoid conflict with platform devices
>>   created for serial8250_isa_devs from 8250_core.c
>

Hi Andy,

>> +	mfd_cell->platform_data = devm_kmemdup(hostdev, &ref_port,
>> +					       sizeof(ref_port),
>> GFP_KERNEL);
>
> Isn't this done by MFD core?

It does, but what we are copying from is on the stack and could be 
overwritten by the point we call the mfd_add_devices(). But this could 
be improved.

BTW, As seen in other discussion, future of MFD usage is in doubt, so 
all this may be dropped.

Thanks very much,
John

>
>
