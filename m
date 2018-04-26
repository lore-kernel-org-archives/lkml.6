Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756820AbeDZQqb convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 12:46:31 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:60322 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754556AbeDZQq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 12:46:28 -0400
Date: Thu, 26 Apr 2018 18:46:23 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] clocksource: rework Atmel TCB timer driver
Message-ID: <20180426164623.tlv6kz5yopk6voxx@breakpoint.cc>
References: <20180418105143.3577-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180418105143.3577-1-alexandre.belloni@bootlin.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-18 12:51:37 [+0200], Alexandre Belloni wrote:
> Hi,

Hi,

please keep on Cc if you intend to repost this.

> This series gets back on the TCB drivers rework. It introduces a new driver to
> handle the clocksource and clockevent devices.

So you don't want the old thing we have in -RT. I remember you (the
atmel folks) wanted something different the last time I posted the
patches.

> As a reminder, this is necessary because:
>  - the current tcb_clksrc driver is probed too late to be able to be used at
>    boot and we now have SoCs that don't have a PIT. They currently are not able
>    to boot a mainline kernel.
>  - using the PIT doesn't work well with preempt-rt because its interrupt is
>    shared (in particular with the UART and their interrupt flags are
>    incompatible)

If you could get rid of this:
| clocksource: Switched to clocksource timer@f0010000:0
| BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:974
| in_atomic(): 1, irqs_disabled(): 128, pid: 1, name: swapper
| Preemption disabled at:
| [<c014f7ac>] __handle_domain_irq+0x40/0xdc
| Hardware name: Atmel SAMA5
| [<c010e14c>] (unwind_backtrace) from [<c010bd74>] (show_stack+0x10/0x14)
| [<c010bd74>] (show_stack) from [<c013b314>] (___might_sleep+0x16c/0x1c0)
| [<c013b314>] (___might_sleep) from [<c06696f0>] (rt_spin_lock+0x40/0x80)
| [<c06696f0>] (rt_spin_lock) from [<c046e030>] (clk_enable_lock+0x30/0xe4)
| [<c046e030>] (clk_enable_lock) from [<c046ea4c>] (clk_core_disable_lock+0xc/0x1c)
| [<c046ea4c>] (clk_core_disable_lock) from [<c059d07c>] (tc_clkevt2_shutdown+0x64/0x6c)
| [<c059d07c>] (tc_clkevt2_shutdown) from [<c059d09c>] (tc_clkevt2_set_oneshot+0x18/0x78)
| [<c059d09c>] (tc_clkevt2_set_oneshot) from [<c0172a00>] (clockevents_switch_state+0xb8/0x130)
| [<c0172a00>] (clockevents_switch_state) from [<c0173a60>] (tick_switch_to_oneshot+0x48/0xb8)
| [<c0173a60>] (tick_switch_to_oneshot) from [<c0165a0c>] (hrtimer_run_queues+0xf0/0x15c)
| [<c0165a0c>] (hrtimer_run_queues) from [<c0164010>] (run_local_timers+0x8/0x38)
| [<c0164010>] (run_local_timers) from [<c0164070>] (update_process_times+0x30/0x60)
| [<c0164070>] (update_process_times) from [<c0173008>] (tick_handle_periodic+0x1c/0x90)
| [<c0173008>] (tick_handle_periodic) from [<c059c954>] (tc_clkevt2_irq+0x38/0x48)
| [<c059c954>] (tc_clkevt2_irq) from [<c014fe6c>] (__handle_irq_event_percpu+0x7c/0x28c)

that would be so awesome.

>  - the current solution is wasting some TCB channels
> 
> The plan is to get this driver upstream, then convert the TCB PWM driver to be
> able to get rid of the tcb_clksrc driver along with atmel_tclib.

The config options are now less than optimal (for me at least). On
oldconfig it asks you for PIT and I say selected no because I wanted the
new one. So I end up with nothing.
Not sure you want do something about it…

Is the resolution more or the same compared what we have in -RT? On an
idle system this clocks goes up to 180us/ 190us while the old clock
started at 160us and moved to around 180us after one hackbench
invocation. This could be nothing, it could be a lower frequency of the
clockevents device.

If you intend to stick with this driver then I would replace the current
hack in -RT with this series.

Sebastian
