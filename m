Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751399AbeDYJU6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 05:20:58 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:54991 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751069AbeDYJUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 05:20:54 -0400
Subject: Re: [RESEND PATCH v2 3/4] ARM: davinci: add aemif & nand support to
 da850-lcdk in legacy mode
To: Bartosz Golaszewski <brgl@bgdev.pl>
CC: Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180417102917.7794-1-brgl@bgdev.pl>
 <20180417102917.7794-4-brgl@bgdev.pl>
 <df39067d-a941-4099-2cfe-7602d4047c6f@ti.com>
 <CAMRc=MfU4xBcbOevviV9vo8Oq5mtGkcjv8zCEacZXB0twhxUuQ@mail.gmail.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <9c1cd548-29a1-8f4a-d05c-ec4884f60b72@ti.com>
Date: Wed, 25 Apr 2018 14:50:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAMRc=MfU4xBcbOevviV9vo8Oq5mtGkcjv8zCEacZXB0twhxUuQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 April 2018 02:44 PM, Bartosz Golaszewski wrote:
> 2018-04-17 16:09 GMT+02:00 Sekhar Nori <nsekhar@ti.com>:
>> On Tuesday 17 April 2018 03:59 PM, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> We now have support for aemif & nand from board files. As an example
>>> add support for nand to da850-lcdk in legacy mode.
>>
>> Hawkboard is a separate board of its own, although closely related to
>> LCDK. Lets refer to it as hawkboard itself, instead of "LCDK in legacy
>> mode". So:
>>
>> ARM: davinci: omapl138-hawk: ...
>>
>>>
>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>> ---
>>>  arch/arm/mach-davinci/board-omapl138-hawk.c | 132 ++++++++++++++++++++
>>>  1 file changed, 132 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
>>> index 6c997c59a3cd..9c3de56b54e4 100644
>>> --- a/arch/arm/mach-davinci/board-omapl138-hawk.c
>>> +++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
>>> @@ -16,6 +16,11 @@
>>>  #include <linux/gpio.h>
>>>  #include <linux/gpio/machine.h>
>>>  #include <linux/platform_data/gpio-davinci.h>
>>> +#include <linux/platform_data/ti-aemif.h>
>>> +#include <linux/mtd/rawnand.h>
>>> +#include <linux/mtd/partitions.h>
>>> +#include <linux/platform_data/mtd-davinci.h>
>>> +#include <linux/platform_data/mtd-davinci-aemif.h>
>>>  #include <linux/regulator/machine.h>
>>>
>>>  #include <asm/mach-types.h>
>>> @@ -162,6 +167,129 @@ static __init void omapl138_hawk_mmc_init(void)
>>>       gpiod_remove_lookup_table(&mmc_gpios_table);
>>>  }
>>>
>>> +static struct mtd_partition omapl138_hawk_nandflash_partition[] = {
>>> +     {
>>> +             .name           = "u-boot env",
>>> +             .offset         = 0,
>>> +             .size           = SZ_128K,
>>> +             .mask_flags     = MTD_WRITEABLE,
>>> +      },
>>> +     {
>>> +             .name           = "u-boot",
>>> +             .offset         = MTDPART_OFS_APPEND,
>>> +             .size           = SZ_128K,
>>
>> Can you make it 512K as it is in da850-lcdk.dts ?
>>
>>> +             .mask_flags     = MTD_WRITEABLE,
>>> +     },
>>> +     {
>>> +             .name           = "free space",
>>> +             .offset         = MTDPART_OFS_APPEND,
>>> +             .size           = MTDPART_SIZ_FULL,
>>> +             .mask_flags     = 0,
>>> +     },
>>> +};
>>
>>> +static struct aemif_abus_data omapl138_hawk_aemif_abus_data[] = {
>>> +     {
>>> +             .cs     = 3,
>>> +     }
>>> +};
>>> +
>>> +static struct platform_device omapl138_hawk_aemif_devices[] = {
>>> +     {
>>> +             .name           = "davinci_nand",
>>> +             .id             = 1,
>>
>> Is there a reason for .id to be set to 1 here? Ideally it should be -1,
>> I think since there is a single NAND on the board.
>>
> 
> The davinci nand driver uses pdev->id as the chipselect number. I
> guess this should be in the platform data. I'll send a patch for that.

I remember that now. No need to change that, I think. Just a comment
here would suffice.

Thanks,
Sekhar
