Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751859AbeC2Ow6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 10:52:58 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:51944 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750979AbeC2Ow4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 10:52:56 -0400
Date: Thu, 29 Mar 2018 16:52:29 +0200
From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 7/8] clocksource: Add a new timer-ingenic driver
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>,
        James Hogan <jhogan@kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org
Message-Id: <1522335149.1792.0@smtp.crapouillou.net>
In-Reply-To: <af33e522-7f87-d62a-0a35-d56a403387b7@linaro.org>
References: <20180110224838.16711-2-paul@crapouillou.net>
        <20180317232901.14129-1-paul@crapouillou.net>
        <20180317232901.14129-8-paul@crapouillou.net>
        <a8d28b2b-4e40-83b9-d65e-beecbd36ad33@linaro.org>
        <06976e4ae275c4cc0bddacc5e0c0c9a9@crapouillou.net>
        <af33e522-7f87-d62a-0a35-d56a403387b7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2TEr4jh020656



Le mer. 28 mars 2018 à 18:25, Daniel Lezcano 
<daniel.lezcano@linaro.org> a écrit :
> On 28/03/2018 17:15, Paul Cercueil wrote:
>>  Le 2018-03-24 07:26, Daniel Lezcano a écrit :
>>>  On 18/03/2018 00:29, Paul Cercueil wrote:
>>>>  This driver will use the TCU (Timer Counter Unit) present on the 
>>>> Ingenic
>>>>  JZ47xx SoCs to provide the kernel with a clocksource and timers.
>>> 
>>>  Please provide a more detailed description about the timer.
>> 
>>  There's a doc file for that :)
> 
> Usually, when there is a new driver I ask for a description in the
> changelog for reference.
> 
>>>  Where is the clocksource ?
>> 
>>  Right, there is no clocksource, just timers.
>> 
>>>  I don't see the point of using channel idx and pwm checking here.
>>> 
>>>  There is one clockevent, why create multiple channels ? Can't you 
>>> stick
>>>  to the usual init routine for a timer.
>> 
>>  So the idea is that we use all the TCU channels that won't be used 
>> for PWM
>>  as timers. Hence the PWM checking. Why is this bad?
> 
> It is not bad but arguable. By checking the channels used by the pwm 
> in
> the code, you introduce an adherence between two subsystems even if it
> is just related to the DT parsing part.
> 
> As it is not needed to have more than one timer in the time framework
> (at least with the same characteristics), the pwm channels check is
> pointless. We can assume the author of the DT file is smart enough to
> prevent conflicts and define a pwm and a timer properly instead of
> adding more code complexity.
> 
> In addition, simplifying the code will allow you to use the timer-of
> code and reduce very significantly the init function.

That's what I had in my V1 and V2, my DT node for the timer-ingenic 
driver
had a "timers" property (e.g. "timers = <4 5>;") to select the channels 
that
should be used as timers. Then Rob told me I shouldn't do that, and 
instead
detect the channels that will be used for PWM.

>>>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>>>  ---
>>>>   drivers/clocksource/Kconfig         |   8 ++
>>>>   drivers/clocksource/Makefile        |   1 +
>>>>   drivers/clocksource/timer-ingenic.c | 278
>>>>  ++++++++++++++++++++++++++++++++++++
>>>>   3 files changed, 287 insertions(+)
>>>>   create mode 100644 drivers/clocksource/timer-ingenic.c
>>>> 
>>>>   v2: Use SPDX identifier for the license
>>>>   v3: - Move documentation to its own patch
>>>>       - Search the devicetree for PWM clients, and use all the TCU
>>>>         channels that won't be used for PWM
>>>>   v4: - Add documentation about why we search for PWM clients
>>>>       - Verify that the PWM clients are for the TCU PWM driver
>>>> 
>>>>  diff --git a/drivers/clocksource/Kconfig 
>>>> b/drivers/clocksource/Kconfig
>>>>  index d2e5382821a4..481422145fb4 100644
>>>>  --- a/drivers/clocksource/Kconfig
>>>>  +++ b/drivers/clocksource/Kconfig
>>>>  @@ -592,4 +592,12 @@ config CLKSRC_ST_LPC
>>>>         Enable this option to use the Low Power controller timer
>>>>         as clocksource.
>>>> 
>>>>  +config INGENIC_TIMER
>>>>  +    bool "Clocksource/timer using the TCU in Ingenic JZ SoCs"
>>>>  +    depends on MACH_INGENIC || COMPILE_TEST
>>> 
>>>  bool "Clocksource/timer using the TCU in Ingenic JZ SoCs" if 
>>> COMPILE_TEST
>>> 
>>>  Remove the depends MACH_INGENIC.
>> 
>>  This driver is not useful on anything else than Ingenic SoCs, why 
>> should I
>>  remove MACH_INGENIC then?
> 
> For COMPILE_TEST on x86.

Well that's a logical OR right here, so it will work...

>>>>  +    select CLKSRC_OF
>>>>  +    default y
>>> 
>>>  No default, Kconfig platform selects the timer.
>> 
>>  Alright.
> [ ... ]
> 
> --
>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM 
> SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 
