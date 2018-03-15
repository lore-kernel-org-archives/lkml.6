Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751626AbeCOJfT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 05:35:19 -0400
Received: from mout.web.de ([212.227.17.11]:47959 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750731AbeCOJfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 05:35:16 -0400
Subject: Re: [media] ov5645: Move an error code assignment in ov5645_probe()
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org
Cc: Hans Verkuil <hansverk@cisco.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <4efad917-ca08-f257-e9a1-b5bcb7df2df2@users.sourceforge.net>
 <20180314221702.5rtdttyqjcpysjkd@kekkonen.localdomain>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <21b0f618-4f54-633a-6411-0790628d6498@users.sourceforge.net>
Date: Thu, 15 Mar 2018 10:34:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314221702.5rtdttyqjcpysjkd@kekkonen.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:jDpGrablxB6u+B5tem/5L2VkV/qAed2Gmsn/RP5JdcU4u4+1Vp7
 ROKayPVCo5KV+X9TP+VtvLAlAYS/paWrqSm7N6j8r1HrVQuK1448Ob7kgqB85bMZtKmZ/64
 hMhuRvsYDy4Ai/YM3tzoYebBj4brMxgstxwnGaWjuf8U6zt6V03rs7Nr2xjy8BS2oULIqhe
 I9PyH7BLOacQyP4E2nwsQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tvxiTyaIlAM=:LsdOZgxGLC53wdrEFM6J/C
 Ivy63eFqTYv4ttzWFSLwWNge7NpSlgiMmHxUwWUdV088837GbytsBHiekrkpqZEGC6eOHRt76
 LX8iwSLfZD7byMcxEgaP0oWBCKsqwRDD8Az6gAg7BCjRZSUJAWkkMTKawlsilVvVgPQ+RwYTT
 6qAj/8kpIg8irXmW5EMfVdAiFB2WkA/ZG/EbsFpvFs0oN0TLtBw0sylQAzpeVO95RBiDjw/xb
 MZvz1Us6jPKtxGvw3be9FwKYZtHHvjTzGg1eYHbyXEGygwfYC/5n5Dck00nSlkHk39fT/Oays
 xR3H64t8d1bdKwaSmCLlJbvHwXaC/+T8TO1ZzSd96xPjVOkDKDpMkTXUPMSIpi6XenF3v/L/X
 kVNy9nQvp6k97OAyvsIF8RroXUwo232gFBqWlfemmq2Msg/4jlqefRPUte7SJdZBlNoGAkI2X
 30k5bmjjoZsPbivXsEtyB59FE8xz8qKmhnGzG2KB5DPEEe0GHMf5WYj/wHCzHR1C4/MEqshDb
 w7k7BS8grm8dQ8wWvUYdUKIX02yE01BpRDh0kvKECSQiGIjfkYniTWIB15e7uKs/pW6EImv1h
 lZcZz8JByGfJAeEzrLJozgtG0xobyPBHT+puhCOFjmIpx/tXO68PU/DsFu3+OHDJQleInrcjS
 USKW0ymvE9/zu10+D0RsJBTHJ1EFmZ51U+jfgOQTsaKfPucI2j64WomLFQKbYwkw7V3hRhidV
 w42/BQR0bj+5KafBrn5HWmO5DfGSB53zv3JZErDW2yi42wYYvLjCToGFq4wahUt5LCASgsaTM
 OY+D/cYNrnh/P6vOWL0Gxbz94vi9u+s6ytA0mIJWDAcuOKpqFI=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Move an assignment for a specific error code so that it is stored only once
>> in this function implementation.
>>
>> This issue was detected by using the Coccinelle software.
> 
> How?

Would you like to experiment a bit more with the following approach
for the semantic patch language?

show_same_statements3.cocci:

@duplicated_code@
identifier work;
statement s1, s2;
type T;
@@
 T work(...)
 {
 ... when any
*if ((...) < 0)
*{
    ...
*   s1
*   s2
*}
 ... when any
*if ((...) < 0)
*{
    ...
*   s1
*   s2
*}
 ... when any
 }


>> @@ -1334,6 +1329,7 @@ static int ov5645_probe(struct i2c_client *client,
>>  
>>  power_down:
>>  	ov5645_s_power(&ov5645->sd, false);
>> +	ret = -ENODEV;
> 
> I don't think this is where people would expect you to set the error code
> in general.

This can be. - The view depends on some factors.


> It should rather take place before goto, not after it.

I proposed another software design direction.


> That'd mean another variable,

To which detail do you refer here?


> and I'm not convinced the result would improve the driver.

Can you see the relevance of a small code reduction in this function?

Regards,
Markus
