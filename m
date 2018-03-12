Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932205AbeCLNee (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:34:34 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:48778 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751242AbeCLNed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:34:33 -0400
Subject: Re: [PATCH v9] mmc: Export host capabilities to debugfs.
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Vladimir_Zapolskiy@mentor.com" <Vladimir_Zapolskiy@mentor.com>
References: <1520829090-3567-1-git-send-email-harish_kandiga@mentor.com>
 <1520849262.10722.582.camel@linux.intel.com>
 <DM5PR04MB10854C79897A80023EF37F76FCD30@DM5PR04MB1085.namprd04.prod.outlook.com>
 <540fef96-aa2f-e6c3-467d-bc1d021dd55b@mentor.com>
 <DM5PR04MB10859F389CA2D1F2370C02CFFCD30@DM5PR04MB1085.namprd04.prod.outlook.com>
 <329d521d-1776-43ee-2f0e-e9690c29a693@mentor.com>
 <1520859807.10722.591.camel@linux.intel.com>
From: Harish Jenny K N <harish_kandiga@mentor.com>
Message-ID: <5e038945-a09c-5c64-2152-5d2783a249ec@mentor.com>
Date: Mon, 12 Mar 2018 19:04:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520859807.10722.591.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [137.202.0.87]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday 12 March 2018 06:33 PM, Andy Shevchenko wrote:
> On Mon, 2018-03-12 at 18:00 +0530, Harish Jenny K N wrote:
>
>
>>>>>>> +	for_each_set_bit(bit, (const unsigned long *)&caps,
>>>>>>> BITS_PER_LONG)
>>>>>>> +	for_each_set_bit(bit, (const unsigned long
>>>>>>> *)&caps2,
>>>>>>> BITS_PER_LONG)
>>>>>> Explicit casting is not needed anymore in both cases.
>>>>> Also maybe use sizeof(mmc_host_capabilities) instead of
>>>>> BITS_PER_LONG?
>>>> You mean sizeof(caps) and not sizeof(mmc_host_capabilities) .
>>>> Right ?
>>> meant ARRAY_SIZE(mmc_host_capabilities)
>> ARRAY_SIZE(mmc_host_capabilities) will be 32 and this will be my old
>> change for which I got a comment from Andy Shevchenko asking me to
>> replace u32 with unsigned long.
>>
>> This is the old comment:
>>
>>>> +    int size = sizeof(u32) * BITS_PER_BYTE;
>>> This is redundant. Use BITS_PER_LONG (why's that, see below) in the
> There is nothing about ARRAY_SIZE().
> ARRAY_SIZE() will work quite good as well.

Yes. Definitely it works. I was only mentioning about changing u32 to unsigned long for caps and passing BITS_PER_LONG  as size in for_each_set_bit.
>
>> for_each_set_bit().
>>
>>>> +    for_each_set_bit(bit, (const unsigned long *)&caps, size)
>>>> +    for_each_set_bit(bit, (const unsigned long *)&caps2, size)
>>> These are UB cases.
>>> Fix is simple, replace u32 by unsigned long in (1) above.
>> Note: Without typecasting &caps to(const unsigned long *) will give
>> compilation error in this case.
> What kind of?
>

Sorry for I was not clear that the compilation error is for the following case
> u32 caps = host->caps;
> for_each_set_bit(bit, &caps, ARRAY_SIZE(mmc_host_capabilities))


example: compilation for arm gives this error for the following lines:

drivers/mmc/core/debugfs.c: In function 'mmc_caps_show':
./include/linux/bitops.h:41:30: error: passing argument 1 of '_find_first_bit_le' from incompatible pointer type [-Werror=incompatible-pointer-types]
  for ((bit) = find_first_bit((addr), (size));  \
                              ^
./arch/arm/include/asm/bitops.h:202:50: note: in definition of macro 'find_first_bit'
 #define find_first_bit(p,sz)  _find_first_bit_le(p,sz)
                                                  ^
drivers/mmc/core/debugfs.c:318:2: note: in expansion of macro 'for_each_set_bit'
  for_each_set_bit(bit, &caps, ARRAY_SIZE(mmc_host_capabilities))
  ^
./arch/arm/include/asm/bitops.h:165:12: note: expected 'const long unsigned int *' but argument is of type 'u32 * {aka unsigned int *}'
 extern int _find_first_bit_le(const unsigned long *p, unsigned size);
            ^





Thanks,
Harish Jenny K N
