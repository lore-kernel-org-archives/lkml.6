Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932076AbeB1Jzi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 04:55:38 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48295 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752173AbeB1Jzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 04:55:37 -0500
Date: Wed, 28 Feb 2018 10:55:47 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Felipe Balbi <felipe.balbi@linux.intel.com>
cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: HRTimer causing rtctest to fail
In-Reply-To: <87muzt5usg.fsf@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1802281043050.1886@nanos.tec.linutronix.de>
References: <87vaei601x.fsf@linux.intel.com> <alpine.DEB.2.21.1802271640010.1886@nanos.tec.linutronix.de> <87muzt5usg.fsf@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2018, Felipe Balbi wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
> > Enable the hrtimer and scheduling tracepoints. That should give you a hint
> > what's going on.
> 
> Thanks, that does give me a lot more information. So here you go:
> 
>          rtctest-1348  [003] d..2   313.766141: hrtimer_start: hrtimer=00000000667ce595 function=rtc_pie_update_irq expires=313573983010 softexpires=313573983010 mode=REL
>           <idle>-0     [003] d.h1   313.767189: hrtimer_expire_entry: hrtimer=00000000667ce595 function=rtc_pie_update_irq now=313574053764
> 
> We still have a 70754 nS deviation. After changing to absolute time,
> the deviation remains:
>
>           <idle>-0     [000] dNh2    29.303251: hrtimer_start: hrtimer=000000006858b496 function=rtc_pie_update_irq expires=28765551360 softexpires=28765551360 mode=ABS
>           <idle>-0     [000] d.h1    29.303565: hrtimer_expire_entry: hrtimer=000000006858b496 function=rtc_pie_update_irq now=28765621916

Changing REL/ABS in the kernel does not make a difference because periodic
mode just forwards by period so even if the first timer is started with REL
it results in a absolute timeline. What I meant is the user space
measurement as it cannot figure out when the first event was supposed to
happen so it's hard to calculate latency information.

The interesting information is that the timer fires late and the system is
idle. Now the question is in which idle state did the machine go?

Wake up from deeper C-states can be slow. On my laptop the wakeup latencies
are:

POLL	   0
C1	   2
C1E	  10
C3	  33
C6	 133
C7S	 166
C8	 300
C9	 600
C10	2600

All numbers in micro seconds! What happens if you load the system or
restrict C-States?

Thanks,

	tglx
