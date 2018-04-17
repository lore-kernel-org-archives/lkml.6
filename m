Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752744AbeDQLzF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 07:55:05 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:61271 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752546AbeDQLzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 07:55:03 -0400
Subject: Re: [PATCH v4 2/6] mfd: stm32-timers: add support for dmas
To: Lee Jones <lee.jones@linaro.org>
CC: <alexandre.torgue@st.com>, <thierry.reding@gmail.com>,
        <benjamin.gaignard@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <mcoquelin.stm32@gmail.com>, <benjamin.gaignard@st.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
References: <1523895561-4073-1-git-send-email-fabrice.gasnier@st.com>
 <1523895561-4073-3-git-send-email-fabrice.gasnier@st.com>
 <20180417071250.yhgl7c7apn7w53xf@dell>
 <34e30463-6236-a8e4-fd1f-6217612375eb@st.com>
 <20180417101009.do42adq24ltgw4lt@dell>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <72e211c8-7342-7722-e3e8-75442560bdfe@st.com>
Date: Tue, 17 Apr 2018 13:54:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417101009.do42adq24ltgw4lt@dell>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.123]
X-ClientProxiedBy: GPXDAG1NODE5.st.com (10.75.127.66) To GPXDAG5NODE6.st.com
 (10.75.127.79)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/2018 12:10 PM, Lee Jones wrote:
> On Tue, 17 Apr 2018, Fabrice Gasnier wrote:
> 
>> On 04/17/2018 09:12 AM, Lee Jones wrote:
>>> On Mon, 16 Apr 2018, Fabrice Gasnier wrote:
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
>>>> Changes in v4:
>>>> - Lee's comments: Add kerneldoc header, better format comments.
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
>>>>  drivers/mfd/stm32-timers.c       | 227 ++++++++++++++++++++++++++++++++++++++-
>>>>  include/linux/mfd/stm32-timers.h |  32 ++++++
>>>>  2 files changed, 257 insertions(+), 2 deletions(-)
>>>
>>> [...]
>>>
>>>> diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
>>>> index 2aadab6..a04d7a1 100644
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
>>>> +struct stm32_timers_dma;
>>>> +
>>>>  struct stm32_timers {
>>>>  	struct clk *clk;
>>>>  	struct regmap *regmap;
>>>>  	u32 max_arr;
>>>> +	struct stm32_timers_dma *dma; /* Only to be used by the parent */
>>>
>>> I'm confused.  I thought the point of putting this comment in was so
>>> that you could place the definition of 'stm32_timers_dma' and remove
>>> the forward declaration?
>>
>> Hi Lee,
>>
>> Sorry, if I miss-understood the point then. So, do you wish I both:
>> - move the full struct definition in above header ?
>> - and keep this comment ?
> 
> That was what I thought we agreed.

Hi Lee,

Ok, I'll update this in v5.
BTW, I'll fix warning reported by Dan:
> smatch warnings:
drivers/mfd/stm32-timers.c:165 stm32_timers_dma_burst_read() warn: warn:
dma_mapping_error() doesn't return an error code

Thanks,
Fabrice

> However, I left the final decision to you.  If you do not think this
> is a reasonable i.e. the comment alone will not be enough to prevent
> people from abusing the API, then leave it as it is.
> 
> Bear in mind that I think this introduces a build dependency on the
> MFD driver for *each and every* other source file which includes this
> header.  If you choose the current solution, you will need to handle
> that accordingly.
> 
>> +/**
>> + * struct stm32_timers_dma - STM32 timer DMA handling.
>> + * @completion:		end of DMA transfer completion
>> + * @phys_base:		control registers physical base address
>> + * @lock:		protect DMA access
>> + * @chan:		DMA channel in use
>> + * @chans:		DMA channels available for this timer instance
>> + */
>> +struct stm32_timers_dma {
>> +	struct completion completion;
>> +	phys_addr_t phys_base;
>> +	struct mutex lock;
>> +	struct dma_chan *chan;
>> +	struct dma_chan *chans[STM32_TIMERS_MAX_DMAS];
>> +};
>>
>> This will basically expose the struct to child drivers. But I'm ok if
>> you think this is acceptable.
>>
>> I can send a V5 if you wish...
>>
>> Please advise,
>> Best regards,
>> Fabrice
>>
>>>
>>>>  };
>>>> +
>>>> +int stm32_timers_dma_burst_read(struct device *dev, u32 *buf,
>>>> +				enum stm32_timers_dmas id, u32 reg,
>>>> +				unsigned int num_reg, unsigned int bursts,
>>>> +				unsigned long tmo_ms);
>>>>  #endif
>>>
> 
