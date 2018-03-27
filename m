Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752066AbeC0La1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 07:30:27 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52933 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbeC0LaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 07:30:25 -0400
X-Google-Smtp-Source: AG47ELs08R8A+L6PUgEbxTDFxvP87xVG3wAJGMhTuK2GivGA8JPBBu8F5CFs1s6ZuAr7vWCWX/N9cg==
Subject: Re: [PATCH v3 0/6] clocksource: rework Atmel TCB timer driver
To: Alexander Dahl <ada@thorsis.com>, linux-arm-kernel@lists.infradead.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20180223171558.7037-1-alexandre.belloni@bootlin.com>
 <9761072.pX2B0LJlSJ@ada>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <989df8a3-462a-c645-87f1-9f956e1b22c9@linaro.org>
Date: Tue, 27 Mar 2018 13:30:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <9761072.pX2B0LJlSJ@ada>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2018 12:41, Alexander Dahl wrote:
> Hello Alexandre,
> 
> Am Freitag, 23. Februar 2018, 18:15:52 CEST schrieb Alexandre Belloni:
>>  - using the PIT doesn't work well with preempt-rt because its interrupt is
>>    shared (in particular with the UART and their interrupt flags are
>>    incompatible)
> 
> This is actually quite annoying when using the UART as a serial console, 
> producing garbage when you type too fast. That's why I tested this patch 
> series (on top of v4.16-rc7). Target is a at91sam9g20 based board, quite close 
> to, but not actually an at91sam9g20-ek.
> 
> First test was with the previous kernel config updated by oldconfig, so 
> basically still using the PIT:
> 
>   +CONFIG_ATMEL_CLOCKSOURCE_PIT=y
> 
> On the serial console with v4.16 and the patch set without switching to the 
> new options, I see this on boot (no surprise, this is what it also prints with 
> v4.9):
> 
>   clocksource: pit: mask: 0xfffffff max_cycles: 0xfffffff, max_idle_ns: 
> 14468723050 ns
>   …
>   clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 
> 19112604462750000 ns
>   …
>   clocksource: tcb_clksrc: mask: 0xffffffff max_cycles: 0xffffffff, 
> max_idle_ns: 115749784805 ns
>   …
>   clocksource: Switched to clocksource tcb_clksrc
> 
> Interrupts here:
> 
>   $ cat /proc/interrupts 
>              CPU0       
>    16:       4802  atmel-aic   1 Level     at91_tick, rtc0, ttyS0
>    19:      24041  atmel-aic  19 Level     tc_clkevt
>    26:        124  atmel-aic  21 Level     eth0
>    28:          1      GPIO  11 Edge      reset
>   Err:          0
> 
> Second test with tcb block added to dts like in 
> 32ce250b0af3b6971fc746445fce87861a9f5628 and with changed kernel config 
> according to defconfig changes in patch 5 and 6:
> 
>   +# CONFIG_ATMEL_CLOCKSOURCE_PIT is not set
>   +CONFIG_ATMEL_CLOCKSOURCE_TCB=y
>   -CONFIG_ATMEL_TCLIB=y
>   -CONFIG_ATMEL_TCB_CLKSRC=y
>   -CONFIG_ATMEL_TCB_CLKSRC_BLOCK=0
>   +# CONFIG_ATMEL_TCLIB is not set
>   -CONFIG_ATMEL_PIT=y
>   +CONFIG_ATMEL_ARM_TCB_CLKSRC=y
>   -CONFIG_PWM_ATMEL_TCB=m
> 
> The output on the serial console contains this:
> 
>   clocksource: timer@fffa0000:0,1: mask: 0xffffffff max_cycles: 0xffffffff, 
> max_idle_ns: 115749784805 ns
>   …
>   clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 
> 19112604462750000 ns
>   …
>   clocksource: Switched to clocksource timer@fffa0000:0,1
> 
> Interrupts here:
> 
>   $ cat /proc/interrupts 
>              CPU0       
>    17:    5727291  atmel-aic  19 Level     timer@fffa0000:2
>    18:       5523  atmel-aic   1 Level     rtc0, ttyS0
>    26:       5031  atmel-aic  21 Level     eth0
>    28:          1      GPIO  11 Edge      reset
>   Err:          0
> 
> So, the board boots and runs like usual. I don't know if that qualifies for a 
> Tested-by? Hope that helps.

Can you can give a rough amount for the irq rate on the timer ?




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
