Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932078AbeENMqG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:46:06 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:16227 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752891AbeENMqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:46:04 -0400
Subject: Re: [RESEND PATCH] clk: stm32: fix: stm32 clock drivers are not
 compiled by default
To: Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        <gabriel.fernandez@st.com>
CC: <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Loic PALLARDY <loic.pallardy@st.com>
References: <1525329609-7291-1-git-send-email-gabriel.fernandez@st.com>
 <0066b4db-8da6-007d-780d-a8ffc4884ad0@st.com>
 <152548833044.138124.7516235724401510636@swboyd.mtv.corp.google.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <b7116836-28e0-f6a5-8791-b62a66774aff@st.com>
Date: Mon, 14 May 2018 14:45:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <152548833044.138124.7516235724401510636@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/05/2018 04:45 AM, Stephen Boyd wrote:
> Quoting Alexandre Torgue (2018-05-04 00:54:16)
>> Stephen
>>
>> On 05/03/2018 08:40 AM, gabriel.fernandez@st.com wrote:
>>> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>>>
>>> Clock driver is mandatory if the machine is selected.
>>> Then don't use 'bool' and 'depends on' commands, but 'def_bool'
>>> with the machine(s).
>>>
>>> Fixes: da32d3539fca ("clk: stm32: add configuration flags for each of the stm32 drivers")
>>>
>>
>> Sorry to insist but we need it to have STM32 MCUs booting on Kernel v4.17.
> 
> Thanks for the bump. I missed this one. Of course, the user can still select
> the configs now, just it's annoying for upgrade path.
> 
>>
>>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
>>> Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
>>> ---
>>>    drivers/clk/Kconfig | 6 ++----
>>>    1 file changed, 2 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
>>> index 24a5bc3..721572a 100644
>>> --- a/drivers/clk/Kconfig
>>> +++ b/drivers/clk/Kconfig
>>> @@ -266,15 +266,13 @@ config COMMON_CLK_STM32MP157
>>>          Support for stm32mp157 SoC family clocks
>>>    
>>>    config COMMON_CLK_STM32F
>>> -     bool "Clock driver for stm32f4 and stm32f7 SoC families"
>>> -     depends on MACH_STM32F429 || MACH_STM32F469 || MACH_STM32F746
>>> +     def_bool COMMON_CLK && (MACH_STM32F429 || MACH_STM32F469 || MACH_STM32F746)
> 
> But the point of the change this patch is fixing was to expose these to
> the user to turn off they wanted. You'll need to do something like that
> again here, instead of removing the prompt and replacing it with a
> def_bool.
> 

Sorry I don't understand. Clock driver is mandatory to boot each 
platform and depends on machine type. Do you see a use case where we 
could need to disable the clock driver? (it would impose to change 
devicetree to use fixed clocks and to have a booloader which configures 
all PLL and clocks).

> So this patch instead? It leaves it around for the whole arch, but
> limits the default to be the machines that matter. I suppose we could
> put an 'if EXPERT' on the bool part too if we don't even want to expose
> the options to normal users.
> 
> -----8<-----
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> Date: Thu, 3 May 2018 08:40:09 +0200
> Subject: [PATCH] clk: stm32: fix: stm32 clock drivers are not compiled by
>   default
> Cc: <linux-kernel@vger.kernel.org>,
>      <linux-arm-kernel@lists.infradead.org>
> 
> Clock driver is mandatory if the machine is selected. Add a default
> of the machines that need the clk driver, so that the user can turn it
> off if they want, but otherwise it's exposed on the SoCs the driver
> is for.
> 
> Fixes: da32d3539fca ("clk: stm32: add configuration flags for each of the stm32 drivers")
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>   drivers/clk/Kconfig | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 41492e980ef4..ac3f0e2bc03f 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -267,15 +267,16 @@ config COMMON_CLK_STM32MP157
>   
>   config COMMON_CLK_STM32F
>   	bool "Clock driver for stm32f4 and stm32f7 SoC families"
> -	depends on MACH_STM32F429 || MACH_STM32F469 || MACH_STM32F746
> +	depends on ARCH_STM32
> +	default MACH_STM32F429 || MACH_STM32F469 || MACH_STM32F746
>   	help
>   	---help---
>   	  Support for stm32f4 and stm32f7 SoC families clocks
>   
>   config COMMON_CLK_STM32H7
>   	bool "Clock driver for stm32h7 SoC family"
> -	depends on MACH_STM32H743
> -	help
> +	depends on ARCH_STM32
> +	default MACH_STM32H743
>   	---help---
>   	  Support for stm32h7 SoC family clocks
>   
> 
