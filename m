Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbeC0Buf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 21:50:35 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56266 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbeC0Bue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 21:50:34 -0400
X-Google-Smtp-Source: AG47ELuGaZnc+r/+k/Zs4ME65/7Gwqx4mc3+rmxNPgxJOKmC90LBPLsDgd/UJKGLjSAhXEeJjeRmKMCs7eUlemA7wxE=
MIME-Version: 1.0
In-Reply-To: <20180323150241.878778199@goodmis.org>
References: <20180323150241.878778199@goodmis.org>
From: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>
Date: Mon, 26 Mar 2018 18:50:32 -0700
Message-ID: <CAEi0qNnm0uor5T7KWVmA9sUg21FJkvP0HWzCPcRz5QzO4M5Fjw@mail.gmail.com>
Subject: Re: [PATCH 0/3] [RFC] init, tracing: Add initcall trace events
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>,
        =?UTF-8?B?QW3Dg8KpcmljbyBXYW5n?= <xiyou.wangcong@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Fri, Mar 23, 2018 at 8:02 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> A while ago we had a boot tracer. But it was eventually removed:
>  commit 30dbb20e68e6f ("tracing: Remove boot tracer").
>
> The rational was because there is already a initcall_debug boot option
> that causes printk()s of all the initcall functions.
>
> The problem with the initcall_debug option is that printk() is awfully slow,
> and makes it difficult to see the real impact of initcalls. Mainly because
> a single printk() is usually slower than most initcall functions.
>
> Instead of bringing back the boot tracer, adding trace events around the
> initcall functions, and even one to denote which level the initcall
> functions are being called from, adds the necessary information to
> analyze the initcalls without the high overhead of printk()s, that
> can substantially slow down the boot process.
>
> Another positive, is that the console initcall functions themselves
> can also be traced. The timestamps are not operational at that time
> but you can see which consoles are being registered. I saw this on
> one of my test boxes:
>
> <idle>-0     [000] ...1     0.000000: initcall_level: level=console
> <idle>-0     [000] ...1     0.000000: initcall_start: func=con_init+0x0/0x224
> <idle>-0     [000] ...1     0.000000: initcall_finish: func=con_init+0x0/0x224 ret=0
> <idle>-0     [000] ...1     0.000000: initcall_start: func=hvc_console_init+0x0/0x19
> <idle>-0     [000] ...1     0.000000: initcall_finish: func=hvc_console_init+0x0/0x19 ret=0
> <idle>-0     [000] ...1     0.000000: initcall_start: func=xen_cons_init+0x0/0x60
> <idle>-0     [000] ...1     0.000000: initcall_finish: func=xen_cons_init+0x0/0x60 ret=0
> <idle>-0     [000] ...1     0.000000: initcall_start: func=univ8250_console_init+0x0/0x2d
> <idle>-0     [000] ...1     0.000000: initcall_finish: func=univ8250_console_init+0x0/0x2d ret=0

Will this make initcall_debug not work if CONFIG_TRACEPOINTS is turned
off? Although it builds but I think this initcall_debug feature will
fail, maybe CONFIG_TRACEPOINTS should be selected somewhere?

I recently ran into some issues like this for my preemptirq
tracepoints patch (which I will post again soon :D) where lockdep
needed the tracepoints and I had to select it.

thanks,

- Joel
