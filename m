Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751218AbeDPPN2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 11:13:28 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:50030 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750917AbeDPPN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 11:13:26 -0400
Subject: Re: [PATCH v3 2/6] mfd: stm32-timers: add support for dmas
To: Lee Jones <lee.jones@linaro.org>
CC: <thierry.reding@gmail.com>, <alexandre.torgue@st.com>,
        <benjamin.gaignard@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <mcoquelin.stm32@gmail.com>, <benjamin.gaignard@st.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
References: <1522404084-24903-1-git-send-email-fabrice.gasnier@st.com>
 <1522404084-24903-3-git-send-email-fabrice.gasnier@st.com>
 <20180416122217.u7h3wawpdx3kj4wd@dell>
 <7531300c-7b7e-75c9-ea5b-8ca01b684c45@st.com>
 <20180416144753.parny6fhvpd3tryf@dell>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <f5e7b9b3-7013-1c80-482b-40a1a17b3490@st.com>
Date: Mon, 16 Apr 2018 17:12:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180416144753.parny6fhvpd3tryf@dell>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.122]
X-ClientProxiedBy: GPXDAG8NODE4.st.com (10.75.127.86) To GPXDAG5NODE6.st.com
 (10.75.127.79)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-16_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/16/2018 04:47 PM, Lee Jones wrote:
> On Mon, 16 Apr 2018, Fabrice Gasnier wrote:
> 
>> On 04/16/2018 02:22 PM, Lee Jones wrote:
>>> On Fri, 30 Mar 2018, Fabrice Gasnier wrote:
>>>
>>>> STM32 Timers can support up to 7 DMA requests:
>>>> - 4 channels, update, compare and trigger.
>>>> Optionally request part, or all DMAs from stm32-timers MFD core.
>>>>
>>>> Also add routine to implement burst reads using DMA from timer registers.
>>>> This is exported. So, it can be used by child drivers, PWM capture
>>>> for instance (but not limited to).
>>>>
>>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>>>> Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
>>>> ---
>>>> Changes in v3:
>>>> - Basically Lee's comments:
>>>> - rather create a struct stm32_timers_dma, and place a reference to it
>>>>   in existing ddata (instead of adding priv struct).
>>>> - rather use a struct device in exported routine prototype, and use
>>>>   standard helpers instead of ddata. Get rid of to_stm32_timers_priv().
>>>> - simplify error handling in probe (remove a goto)
>>>> - comment on devm_of_platform_*populate() usage.
>>>>
>>>> Changes in v2:
>>>> - Abstract DMA handling from child driver: move it to MFD core
>>>> - Add comments on optional dma support
>>>> ---
>>>>  drivers/mfd/stm32-timers.c       | 219 ++++++++++++++++++++++++++++++++++++++-
>>>>  include/linux/mfd/stm32-timers.h |  32 ++++++
>>>>  2 files changed, 249 insertions(+), 2 deletions(-)
> 
> [...]
> 
>>>> diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
>>>> index 2aadab6..585a4de 100644
>>>> --- a/include/linux/mfd/stm32-timers.h
>>>> +++ b/include/linux/mfd/stm32-timers.h
>>>> @@ -8,6 +8,8 @@
>>>>  #define _LINUX_STM32_GPTIMER_H_
>>>>  
>>>>  #include <linux/clk.h>
>>>> +#include <linux/dmaengine.h>
>>>> +#include <linux/dma-mapping.h>
>>>>  #include <linux/regmap.h>
>>>
>>> [...]
>>>
>>>> +enum stm32_timers_dmas {
>>>> +	STM32_TIMERS_DMA_CH1,
>>>> +	STM32_TIMERS_DMA_CH2,
>>>> +	STM32_TIMERS_DMA_CH3,
>>>> +	STM32_TIMERS_DMA_CH4,
>>>> +	STM32_TIMERS_DMA_UP,
>>>> +	STM32_TIMERS_DMA_TRIG,
>>>> +	STM32_TIMERS_DMA_COM,
>>>> +	STM32_TIMERS_MAX_DMAS,
>>>> +};
>>>> +
>>>> +struct stm32_timers_dma;
>>>
>>> Why don't you move the declaration into here?
>>
>> To follow previous discussions we had in V1 and V2, this is to avoid
>> sharing all the information with child drivers, e.g. passing physical
>> address of parent MFD into child devices.
>>
>> I should probably add a comment there ? Something like:
>>
>> /* STM32 timers MFD parent internal struct to handle DMA transfers */
>> struct stm32_timers_dma;
>>
>> Do you agree with this ?
>>
>> Thanks for reviewing,
>> BR,
>> Fabrice
>>
>>>
>>> Then you don't need to forward declare.
> 
> Yes, I remember our previous conversation.
> 
> Perhaps you could always put a comment like:
> 
>>>>  struct stm32_timers {
>>>>  	struct clk *clk;
>>>>  	struct regmap *regmap;
>>>>  	u32 max_arr;
>>>> +	struct stm32_timers_dma *dma; /* Only to be used by the parent */
>>>>  };
> 
> If this is not acceptable, then the current solution will do.

Hi Lee,

I'll update it with your proposal,

Many thanks,
Fabrice

> 
