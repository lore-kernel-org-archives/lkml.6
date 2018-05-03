Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751527AbeECQ04 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 12:26:56 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:18533 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbeECQ0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 12:26:53 -0400
Subject: Re: [PATCH 1/2] i2c: sprd: Prevent i2c accesses after suspend is
 called
To: Baolin Wang <baolin.wang@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
CC: Mark Brown <broonie@kernel.org>, <linux-i2c@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <99031524fa147e72451d26f54b24f36093c0d3fa.1523255712.git.baolin.wang@linaro.org>
 <20180427121417.auv4ppryegkprv32@ninjato>
 <CAMz4kuK3fyBhdrUcLvY0s0N-0yY9_0MrAAi9cWdX1ZfdNW+R0w@mail.gmail.com>
 <20180502052336.i5f4yv2ho3za7qa7@tetsubishi>
 <CAMz4kuJAzr-ybCCmjx_Tcdw6qNYN0wLGQgWsb1H0WEkR4ZpyYg@mail.gmail.com>
From: Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <3485f73f-e356-6db0-89fc-d51bf8bdab71@ti.com>
Date: Thu, 3 May 2018 11:26:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAMz4kuJAzr-ybCCmjx_Tcdw6qNYN0wLGQgWsb1H0WEkR4ZpyYg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/02/2018 12:48 AM, Baolin Wang wrote:
> On 2 May 2018 at 13:23, Wolfram Sang <wsa@the-dreams.de> wrote:
>>
>>>> We should maybe handle this in the core somewhen, though. Or?
>>>
>>> Thanks. Yes, It will more helpful if we can handle this in the i2c core.
>>
>> To understand the issue better: which kind of devices in your system
>> still send I2C transfers when the system is going to suspend? Do you
>> know?
> 
> Now we found the touch screen device will trigger I2C transfers when
> the system is going to suspend.
> 

And you have to fix it (touch screen) - not your i2c driver. Otherwise, you can get
situation when set of I2C transfers (executed from some kthread/work/threaded_irq/..)
will be just interrupted in the middle - usual behavior after this is (I2C timeout) [and/or
not-functional I2C client device [and/or I2C bus stuck (worst case)].

In case, somebody is trying to access I2C after .suspend_noirq() stage I2C bus driver 
should produce big fat warning and, most probably, abort suspend.
Above, in general, can be part of I2C core functionality.

-- 
regards,
-grygorii
