Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935117AbeEIOtA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 10:49:00 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37025 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751000AbeEIOs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 10:48:59 -0400
Subject: Re: [PATCH v2 0/3] HISI LPC ACPI UART support
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <xuwei5@huawei.com>
References: <1525775252-239214-1-git-send-email-john.garry@huawei.com>
 <1f8dd53826554a113b03b7c0fb2d131bb315eefd.camel@linux.intel.com>
CC: <mika.westerberg@linux.intel.com>, <lee.jones@linaro.org>,
        <rjw@rjwysocki.net>, <linux-kernel@vger.kernel.org>, <arnd@arndb.de>,
        <graeme.gregory@linaro.org>, <helgaas@kernel.org>,
        <z.liuxinliang@hisilicon.com>, <linuxarm@huawei.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <bffb33bd-525f-ae78-b8c0-844a83184f99@huawei.com>
Date: Wed, 9 May 2018 15:48:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1f8dd53826554a113b03b7c0fb2d131bb315eefd.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2018 12:17, Andy Shevchenko wrote:
> On Tue, 2018-05-08 at 18:27 +0800, John Garry wrote:
>> This patchset adds ACPI FW support for the UART on
>> the LPC bus on the Huawei D03 development board.
>>
>> It also drops MFD API usage. It's not right to use MFD
>> APIs outside drivers/mfd. As the alternate solution, we
>> use platform device APIs directly.
>>
>> The UART is 8250-compatible, and has the following
>> profile:
>> - IO space iotype
>> - no interrupt, so polling mode required
>> - 16550 type
>>
>> Currently no platform driver exists for the UART. Indeed,
>> for PNP-compatible devices - like this UART - it would be
>> better to create a PNP device so that we may use the
>> existing PNP driver. Thus, we should use the 8250 PNP
>> driver.
>>
>> However this host driver does not support PNP devices.
>> An RFC was sent for PNP support in [1]. However it was
>> deemed impractical to follow this path.
>>
>> So to provide this UART support we use the 8250 generic
>> isa driver. For this, we need to set the UART platform
>> device name to match the 8250 isa driver. This means
>> passing the 8250 serial config in the child pdev platform
>> data.
>>
>> 1. https://lkml.org/lkml/2018/4/20/278
>>
>
> I'm fine with this least invasive approach. It seems it has minimum
> duplication of code, which is anyway unavoidable when we are speaking of
> instantiating platform devices.
>
> FWIW,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks Andy!

Hi xuwei,

Unless there are any more comments, can you please pick up this series 
(with Andy's review tags) for merging through the arm soc tree?

All the best,
John

>
>> Differences:
>> v1 -> v2:
>> - drop MFD API usage and use platform device APIs
>>   directly for ACPI support
>>
>> RFC -> v1:
>> - drop PNP support
>> - use static MFD cells
>> - add 8250 setup
>>
>> John Garry (3):
>>   HISI LPC: Stop using MFD APIs
>>   HISI LPC: Re-Add ACPI child enumeration support
>>   HISI LPC: Add ACPI UART support
>>
>>  drivers/bus/Kconfig    |   1 -
>>  drivers/bus/hisi_lpc.c | 159 ++++++++++++++++++++++++++++++--------
>> -----------
>>  2 files changed, 97 insertions(+), 63 deletions(-)
>>
>
