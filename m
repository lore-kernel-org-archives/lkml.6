Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751152AbeC0KrX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 06:47:23 -0400
Received: from mail.thorsis.com ([92.198.35.195]:55000 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750881AbeC0KrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 06:47:22 -0400
From: Alexander Dahl <ada@thorsis.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 0/6] clocksource: rework Atmel TCB timer driver
Date: Tue, 27 Mar 2018 12:41:08 +0200
Message-ID: <9761072.pX2B0LJlSJ@ada>
In-Reply-To: <20180223171558.7037-1-alexandre.belloni@bootlin.com>
References: <20180223171558.7037-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2RAlUSn002527

Hello Alexandre,

Am Freitag, 23. Februar 2018, 18:15:52 CEST schrieb Alexandre Belloni:
>  - using the PIT doesn't work well with preempt-rt because its interrupt is
>    shared (in particular with the UART and their interrupt flags are
>    incompatible)

This is actually quite annoying when using the UART as a serial console, 
producing garbage when you type too fast. That's why I tested this patch 
series (on top of v4.16-rc7). Target is a at91sam9g20 based board, quite close 
to, but not actually an at91sam9g20-ek.

First test was with the previous kernel config updated by oldconfig, so 
basically still using the PIT:

  +CONFIG_ATMEL_CLOCKSOURCE_PIT=y

On the serial console with v4.16 and the patch set without switching to the 
new options, I see this on boot (no surprise, this is what it also prints with 
v4.9):

  clocksource: pit: mask: 0xfffffff max_cycles: 0xfffffff, max_idle_ns: 
14468723050 ns
  …
  clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 
19112604462750000 ns
  …
  clocksource: tcb_clksrc: mask: 0xffffffff max_cycles: 0xffffffff, 
max_idle_ns: 115749784805 ns
  …
  clocksource: Switched to clocksource tcb_clksrc

Interrupts here:

  $ cat /proc/interrupts 
             CPU0       
   16:       4802  atmel-aic   1 Level     at91_tick, rtc0, ttyS0
   19:      24041  atmel-aic  19 Level     tc_clkevt
   26:        124  atmel-aic  21 Level     eth0
   28:          1      GPIO  11 Edge      reset
  Err:          0

Second test with tcb block added to dts like in 
32ce250b0af3b6971fc746445fce87861a9f5628 and with changed kernel config 
according to defconfig changes in patch 5 and 6:

  +# CONFIG_ATMEL_CLOCKSOURCE_PIT is not set
  +CONFIG_ATMEL_CLOCKSOURCE_TCB=y
  -CONFIG_ATMEL_TCLIB=y
  -CONFIG_ATMEL_TCB_CLKSRC=y
  -CONFIG_ATMEL_TCB_CLKSRC_BLOCK=0
  +# CONFIG_ATMEL_TCLIB is not set
  -CONFIG_ATMEL_PIT=y
  +CONFIG_ATMEL_ARM_TCB_CLKSRC=y
  -CONFIG_PWM_ATMEL_TCB=m

The output on the serial console contains this:

  clocksource: timer@fffa0000:0,1: mask: 0xffffffff max_cycles: 0xffffffff, 
max_idle_ns: 115749784805 ns
  …
  clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 
19112604462750000 ns
  …
  clocksource: Switched to clocksource timer@fffa0000:0,1

Interrupts here:

  $ cat /proc/interrupts 
             CPU0       
   17:    5727291  atmel-aic  19 Level     timer@fffa0000:2
   18:       5523  atmel-aic   1 Level     rtc0, ttyS0
   26:       5031  atmel-aic  21 Level     eth0
   28:          1      GPIO  11 Edge      reset
  Err:          0

So, the board boots and runs like usual. I don't know if that qualifies for a 
Tested-by? Hope that helps.

Greets
Alex
