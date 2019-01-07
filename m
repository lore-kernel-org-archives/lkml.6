Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEE5C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1AC720859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfAGKcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:32:05 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:6953 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726454AbfAGKcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:32:05 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id B48398E95DD712E58AE8;
        Mon,  7 Jan 2019 18:32:01 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.43) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Mon, 7 Jan 2019
 18:31:51 +0800
Subject: Re: [PATCH] HISI LPC: Don't fail probe for unrecognised child devices
To:     Olof Johansson <olof@lixom.net>
References: <1546516622-46343-1-git-send-email-john.garry@huawei.com>
 <20190104222521.6r7lmz7so22xu2nj@localhost>
CC:     <xuwei5@huawei.com>, <arm@kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <56e5475d-1663-d96f-f4b6-f0ad53d0ce8e@huawei.com>
Date:   Mon, 7 Jan 2019 10:31:47 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190104222521.6r7lmz7so22xu2nj@localhost>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/2019 22:25, Olof Johansson wrote:
> On Thu, Jan 03, 2019 at 07:57:02PM +0800, John Garry wrote:
>> Currently for ACPI-based FW we fail the probe for an unrecognised child
>> HID.
>>
>> However, there is FW in the field with LPC child devices having fake HIDs,
>> namely "IPI0002", which was an IPMI device invented to support the
>> initial out-of-tree LPC host driver, different from the final mainline
>> version.
>>
>> To provide compatibility support for these dodgy FWs, just discard the
>> unrecognised HIDs instead of failing the probe altogether.
>>
>> Tested-by: Zengruan Ye <yezengruan@huawei.com>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>>
>> diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
>> index d5f8545..19d7b6f 100644
>> --- a/drivers/bus/hisi_lpc.c
>> +++ b/drivers/bus/hisi_lpc.c
>> @@ -522,10 +522,9 @@ static int hisi_lpc_acpi_probe(struct device *hostdev)
>>
>>  		if (!found) {
>>  			dev_warn(hostdev,
>> -				 "could not find cell for child device (%s)\n",
>> +				 "could not find cell for child device (%s), discarding\n",
>>  				 hid);
>> -			ret = -ENODEV;
>> -			goto fail;
>> +			continue;
>>  		}
>

Hi Olof,

> This driver is the equivalent of a board file. Wasn't ACPI supposed to
> spare us from these platform device tables? It even has hardcoded clock
> information in it. :(

For sure, we should not need a look-up table like this. The background 
is complex. I think that if you check these thread+patches then you may 
get a better idea of why we require the table:

https://lkml.org/lkml/2018/4/20/278

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/acpi/scan.c?h=v5.0-rc1&id=dfda4492322ed0a1eb9c4d4715c4b90c9af57352

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/bus/hisi_lpc.c?h=next-20190107&id=e0aa1563f8945d9b8f472426d100bed190a4308f

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/bus/hisi_lpc.c?h=next-20190107&id=adf3457b4ce6940885be3e5ee832c6949fba4166


To summarize:
For child devices, we use indirect-PIO method to access. In this, we 
need to create a new device with updated resources (see call to 
hisi_lpc_acpi_set_io_res() call and 
drivers/acpi/scan.c:acpi_is_indirect_io_slave()) for logical PIO space.

One of the child devices is a 8250-compatible UART. For ACPI, we should 
use the 8250 PNP driver for this device, i.e. use PNP0501. However PNP 
code does not support this indirect-PIO child probe. So we use the 
generic 8250 platform device driver instead. Hence the look-up table.

We saw this as the least disruptive method to support this legacy host 
controller.

As for the clock info in the driver, we're just setting some driver wait 
times depending on fixed clock information. So not configuring clocks or 
the like.

>
> Also, we were told that there'll be expectations for users to update
> their ACPI tables if they're incompatible our out of date. Can that be done
> here as well?

If you're referring to this comment "To provide compatibility support 
for these dodgy FWs", we're saying that if the FW has IPI0001 and 
IPI0002 (this being invalid) child devices, then we can handle it by 
just discarding IPI0002.

Thanks,
John

>
>
> -Olof
>
>


