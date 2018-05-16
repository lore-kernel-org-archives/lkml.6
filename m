Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752289AbeEPHef (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 03:34:35 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:57435 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751040AbeEPHec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 03:34:32 -0400
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
 <b7116836-28e0-f6a5-8791-b62a66774aff@st.com>
 <152642091618.237094.8294094887191293130@swboyd.mtv.corp.google.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <a49b89ee-2aee-274d-ccc0-3eaf7d9a3755@st.com>
Date: Wed, 16 May 2018 09:34:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <152642091618.237094.8294094887191293130@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-16_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/15/2018 11:48 PM, Stephen Boyd wrote:
> Quoting Alexandre Torgue (2018-05-14 05:45:57)
>>
>>
>> On 05/05/2018 04:45 AM, Stephen Boyd wrote:
>>> Quoting Alexandre Torgue (2018-05-04 00:54:16)
>>>> Stephen
>>>>
>>>> On 05/03/2018 08:40 AM, gabriel.fernandez@st.com wrote:
>>>>> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>>>>>
>>>>> Clock driver is mandatory if the machine is selected.
>>>>> Then don't use 'bool' and 'depends on' commands, but 'def_bool'
>>>>> with the machine(s).
>>>>>
>>>>> Fixes: da32d3539fca ("clk: stm32: add configuration flags for each of the stm32 drivers")
>>>>>
>>>>
>>>> Sorry to insist but we need it to have STM32 MCUs booting on Kernel v4.17.
>>>
>>> Thanks for the bump. I missed this one. Of course, the user can still select
>>> the configs now, just it's annoying for upgrade path.
>>>
>>>>
>>>>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
>>>>> Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
>>>>> ---
>>>>>     drivers/clk/Kconfig | 6 ++----
>>>>>     1 file changed, 2 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
>>>>> index 24a5bc3..721572a 100644
>>>>> --- a/drivers/clk/Kconfig
>>>>> +++ b/drivers/clk/Kconfig
>>>>> @@ -266,15 +266,13 @@ config COMMON_CLK_STM32MP157
>>>>>           Support for stm32mp157 SoC family clocks
>>>>>     
>>>>>     config COMMON_CLK_STM32F
>>>>> -     bool "Clock driver for stm32f4 and stm32f7 SoC families"
>>>>> -     depends on MACH_STM32F429 || MACH_STM32F469 || MACH_STM32F746
>>>>> +     def_bool COMMON_CLK && (MACH_STM32F429 || MACH_STM32F469 || MACH_STM32F746)
>>>
>>> But the point of the change this patch is fixing was to expose these to
>>> the user to turn off they wanted. You'll need to do something like that
>>> again here, instead of removing the prompt and replacing it with a
>>> def_bool.
>>>
>>
>> Sorry I don't understand. Clock driver is mandatory to boot each
>> platform and depends on machine type. Do you see a use case where we
>> could need to disable the clock driver? (it would impose to change
>> devicetree to use fixed clocks and to have a booloader which configures
>> all PLL and clocks).
> 
> No. My understanding of the patch that introduced the options was to
> allow the user to disable these drivers if they wanted to. I'm just
> reiterating the spirit of that patch. That must be wrong?
> 
Actually initial patch is a mistake. You can't boot STM32 platform 
without clock driver. This patch fixes that, and offers the possibility 
to not build the clock driver of the machine which are not used 
(currently all machine are selected but to reduce memory footprint you 
could disable not used machine in defconfig).
