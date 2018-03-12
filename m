Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751361AbeCLMaw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 08:30:52 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:41248 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbeCLMau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 08:30:50 -0400
Subject: Re: [PATCH v9] mmc: Export host capabilities to debugfs.
To: Avri Altman <Avri.Altman@wdc.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
From: Harish Jenny K N <harish_kandiga@mentor.com>
Message-ID: <329d521d-1776-43ee-2f0e-e9690c29a693@mentor.com>
Date: Mon, 12 Mar 2018 18:00:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <DM5PR04MB10859F389CA2D1F2370C02CFFCD30@DM5PR04MB1085.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [137.202.0.87]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday 12 March 2018 05:02 PM, Avri Altman wrote:
>
>> -----Original Message-----
>> From: Harish Jenny K N [mailto:harish_kandiga@mentor.com]
>> Sent: Monday, March 12, 2018 1:17 PM
>> To: Avri Altman <Avri.Altman@wdc.com>; Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com>; ulf.hansson@linaro.org;
>> linus.walleij@linaro.org; adrian.hunter@intel.com; shawn.lin@rock-chips.com
>> Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org;
>> Vladimir_Zapolskiy@mentor.com
>> Subject: Re: [PATCH v9] mmc: Export host capabilities to debugfs.
>>
>>
>>
>> On Monday 12 March 2018 04:15 PM, Avri Altman wrote:
>>>> -----Original Message-----
>>>> From: Andy Shevchenko [mailto:andriy.shevchenko@linux.intel.com]
>>>> Sent: Monday, March 12, 2018 12:08 PM
>>>> To: Harish Jenny K N <harish_kandiga@mentor.com>;
>>>> ulf.hansson@linaro.org; linus.walleij@linaro.org;
>>>> adrian.hunter@intel.com; shawn.lin@rock- chips.com; Avri Altman
>>>> <Avri.Altman@wdc.com>
>>>> Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org;
>>>> Vladimir_Zapolskiy@mentor.com
>>>> Subject: Re: [PATCH v9] mmc: Export host capabilities to debugfs.
>>>>
>>>> On Mon, 2018-03-12 at 10:01 +0530, Harish Jenny K N wrote:
>>>>> This patch exports the host capabilities to debugfs
>>>>>
>>>>> This idea of sharing host capabilities over debugfs came up from
>>>>> Abbas Raza <Abbas_Raza@mentor.com> Earlier discussions:
>>>>> https://lkml.org/lkml/2018/3/5/357
>>>>> https://www.spinics.net/lists/linux-mmc/msg48219.html
>>>>>
>>>> Address below minors and, FWIW, take mine
>>>>
>>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>>
>>>>> +	for_each_set_bit(bit, (const unsigned long *)&caps,
>>>>> BITS_PER_LONG)
>>>>> +	for_each_set_bit(bit, (const unsigned long *)&caps2,
>>>>> BITS_PER_LONG)
>>>> Explicit casting is not needed anymore in both cases.
>>> Also maybe use sizeof(mmc_host_capabilities) instead of BITS_PER_LONG?
>> You mean sizeof(caps) and not sizeof(mmc_host_capabilities) . Right ?
> meant ARRAY_SIZE(mmc_host_capabilities)
>
> Thanks,
> Avri
>

ARRAY_SIZE(mmc_host_capabilities) will be 32 and this will be my old change for which I got a comment from Andy Shevchenko asking me to replace u32 with unsigned long.

This is the old comment:

>> +    int size = sizeof(u32) * BITS_PER_BYTE;
> This is redundant. Use BITS_PER_LONG (why's that, see below) in the
for_each_set_bit().

>> +    for_each_set_bit(bit, (const unsigned long *)&caps, size)
>> +    for_each_set_bit(bit, (const unsigned long *)&caps2, size)
> These are UB cases.
> Fix is simple, replace u32 by unsigned long in (1) above.

Note: Without typecasting &caps to(const unsigned long *) will give compilation error in this case.


Thanks,
Harish Jenny K N
