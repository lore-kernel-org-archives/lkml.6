Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141A1C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F23520857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SsQwp5Y1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F23520857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbeIEQRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 12:17:50 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33697 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbeIEQRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 12:17:49 -0400
Received: by mail-lj1-f196.google.com with SMTP id s12-v6so5978800ljj.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 04:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uqxwdeF80pnL4ZrMY2quJA85Zqd/l39wg20v7ZbV7MM=;
        b=SsQwp5Y17Vp6B5qkK2wzdzC6fyuW8m5+ia/gKU3UMSOAHI3YZdAMhzKAIubXf2Cbot
         3aeWnF4qLLG/BLrbzkyyJVcBLBQiZhHE4XoEFkyRKR+XBoyZ2p23Q/SxtXOc5CJQfSRl
         y6+GVri8i+ujX3hcIKHv8dMIfKSS6GcVlP1Zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uqxwdeF80pnL4ZrMY2quJA85Zqd/l39wg20v7ZbV7MM=;
        b=LnGO9hYuA0CyhUVhXeru4UqfN8JdtvXzucvv2VC07AUiuyKQB66F2sFR1LazQggeEF
         M6yzi7/9SoPk+cmiCE/rYqvh7wxWhL7mn5aXglB6E3xUCnEfyk++TdxFVVw3jFNssXGS
         eYq4rGkThXKf6PfOgJbikFYkI86iJrDNANqCHt+e+Ryrn5p41cmAQUMn9L/FVWNzTCbt
         fcWGO2wwLEM1I41jRNSVlxjw/nFD1/L3YiLXgYMNorB9zj1MlRm57nT2arI6IOJo3nta
         OfH7WkdRInrbBJPrWRFhPry03g2xz1XIfKRTGxDMnNmrMrtzZBru0pOU1wnE224veFC9
         kzZQ==
X-Gm-Message-State: APzg51Am/cYTC2LWZLwadloKGeDNQZN+HjleaHKVq+JYoJy3DbIrS9uv
        ExOWgP9nzv2mRKaI8fTzXki8sQ==
X-Google-Smtp-Source: ANB0Vdb1TeQtIY0bfpX/cvRFFqhMmSqUS+z/ZV38/jrJx2RX+K8LDkRjsot3Kz07TU0kcguTWzKCZw==
X-Received: by 2002:a2e:5d57:: with SMTP id r84-v6mr22735819ljb.89.1536148071672;
        Wed, 05 Sep 2018 04:47:51 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id d6-v6sm280605lfb.30.2018.09.05.04.47.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 04:47:51 -0700 (PDT)
Date:   Wed, 5 Sep 2018 13:47:49 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org
Subject: Re: stop_machine() soft lockup
Message-ID: <20180905114749.GA5345@centauri.lan>
References: <20180904190322.GA21835@centauri.lan>
 <20180905084241.GS24082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905084241.GS24082@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 10:42:41AM +0200, Peter Zijlstra wrote:
> On Tue, Sep 04, 2018 at 09:03:22PM +0200, Niklas Cassel wrote:
> > Hello Peter,
> >
> > I'm seeing some lockups when booting linux-next on a db820c arm64 board.
> > I've tried to analyze, but I'm currently stuck.
>
> Please see (should be in your Inbox too):
>
>   https://lkml.kernel.org/r/20180905084158.GR24124@hirez.programming.kicks-ass.net

I'm sorry if I mislead you by replying to your other mail thread,
both of them have timekeeping_notify() in the call trace,
but my problem has this call trace:

[  128.747853]  wait_for_common+0xe0/0x1a0
[  128.752023]  wait_for_completionx+0x28/0x38
[  128.755677]  __stop_cpus+0xd4/0xf8
[  128.759837]  stop_cpus+0x70/0xa8
[  128.762958]  stop_machine_cpuslocked+0x124/0x130
[  128.766345]  stop_machine+0x54/0x70
[  128.771373]  timekeeping_notify+0x44/0x70
[  128.774158]  __clocksource_select+0xa8/0x1d8
[  128.778605]  clocksource_done_booting+0x4c/0x64
[  128.782931]  do_one_initcall+0x94/0x3f8
[  128.786921]  kernel_init_freeable+0x47c/0x528
[  128.790742]  kernel_init+0x18/0x110
[  128.795673]  ret_from_fork+0x10/0x1c


while your other mail thread has this call trace:

* stop_machine()
* timekeeping_notify()
* __clocksource_select()
* clocksource_select()
* clocksource_watchdog_work()


So my problem is not related to the watchdog, I tried your revert anyway,
but unfortunately my problem persists.


In my problem, what appears to happen is that in the end of multi_cpu_stop(),
local_irq_restore() is called, and an irq comes directly after that,
then after 22 seconds soft lockup detector kicks in (so I appear to still
get timer ticks). The PC that the soft lockup detector prints is the line
after local_irq_restore(). Without any prints, that is simply end brace of
the function.

I'm booting with kernel command line: "earlycon ftrace=irqsoff"
I can't seem to reproduce the problem without ftrace=irqsoff,
not sure if it because of timing or because ftrace is involved.

I managed to get another call trace with ftrace included,
unfortunately both CPUs appear to be printing at the same time.

[   32.703910] watchdog: BUG: soft lockup - CPU#2 stuck for 22s! [migration/2:22]
[   32.728589] Modules linked in:
[   32.747176] irq event stamp: 154
[   32.758851] hardirqs last  enabled at (153): [<ffff0000081bb59c>] multi_cpu_stop+0xfc/0x168
[   32.770736] hardirqs last disabled at (154): [<ffff000008083e2c>] el1_irq+0xac/0x198
[   32.774911] watchdog: BUG: soft lockup - CPU#3 stuck for 22s! [kworker/3:0H:30]
[   32.779946] Modules linked in:
[   32.786425] softirqs last  enabled at (114): [<ffff000008082164>] __do_softirq+0x47c/0x574
[   32.795450] irq event stamp: 62
[   32.805549] softirqs last disabled at (95): [<ffff0000080ca41c>] irq_exit+0x134/0x148
[   32.810450] hardirqs last  enabled at (61): [<ffff00000908efe8>] _raw_spin_unlock_irq+0x38/0x78
[   32.816075] hardirqs last disabled at (62): [<ffff000008083e2c>] el1_irq+0xac/0x198
[   32.821812] softirqs last  enabled at (0): [<ffff0000080bdb68>] copy_process.isra.5.part.6+0x338/0x1ac$
[   32.829394] CPU: 2 PID: 22 Comm: migration/2 Tainted: G        W         4.19.0-rc2-next-20180904-0000$
-gd2e5ea917660 #47
[   32.836772] softirqs last disabled at (0): [<0000000000000000>]           (null)
[   32.846193] Hardware name: Qualcomm Technologies, Inc. DB820c (DT)
[   32.857546] CPU: 3 PID: 30 Comm: kworker/3:0H Tainted: G        W         4.19.0-rc2-next-20180904-000$
2-gd2e5ea917660 #47
[   32.864532] pstate: 60400005 (nZCv daif +PAN -UAO)
[   32.870789] Hardware name: Qualcomm Technologies, Inc. DB820c (DT)
[   32.881909] pc : multi_cpu_stop+0x100/0x168
[   32.887583] lr : multi_cpu_stop+0xfc/0x168
[   32.892723] sp : ffff00000ae33d70
[   32.897717] x29: ffff00000ae33d70 x28: 0000000000000000
[   32.906981] pstate: 60400005 (nZCv daif +PAN -UAO)
[   32.916202] x27: 0000000000000002 x26: ffff00000803bc80
[   32.923256] pc : _raw_spin_unlock_irq+0x3c/0x78
[   32.933817] x25: ffff0000081bb4a0
[   32.937340] lr : _raw_spin_unlock_irq+0x38/0x78
[   32.942465] sp : ffff00000ae73c60
[   32.947455] x29: ffff00000ae73c60 x28: ffff00000978b000
[   32.953060] x24: 0000000000000000
[   32.967484] x23: 0000000000000000
[   32.971265] x27: ffff8000d958db00
[   32.976343] x22: 0000000000000000
[   32.982508] x26: 0000000000000001
[   32.996862] x21: ffff00000803bca4
[   33.000630] x25: ffff8000d9e8a328
[   33.005754] x20: ffff00000803bc80
[   33.011888] x24: ffff000009087f88
[   33.026057] x19: 0000000000000004
[   33.029982] x23: ffff8000d971ad80
[   33.035127] x18: 00000000000008bd
[   33.041263] x22: ffff000009cbf000
[   33.055312] x17: 00000000000008bc
[   33.059310] x21: ffff8000d958db00
[   33.064303] x16: ffff000009fd1360
[   33.070605] x20: ffff0000080fc20c
[   33.084645] x15: ffff000009f2a300
[   33.088605] x19: ffff8000da7f4d40
[   33.093572] x14: 00000000000017fc
[   33.099943] x18: ffffffffffffffff
[   33.114000] x13: 00000000c04846ac
[   33.117948] x17: 0000000000000693
[   33.122855] x12: ffff8000d9fc63b0
[   33.129195] x16: ffff000009fcf7e0
[   33.143370] x11: 0000000000000000
[   33.147294] x15: ffff000009cbe1c8
[   33.152152] x10: 0000000000000348
[   33.158535] x14: 0000000000002fff
[   33.172812] x9 : ffff8000d9590400
[   33.176620] x13: 0000000016163b60
[   33.181506] x8 : 000000000000001c
[   33.187866] x12: ffff8000d971b630
[   33.202251] x7 : ffff8000d9c08400
[   33.205880] x11: 0000000000000000
[   33.210939] x6 : 0000000000000364
[   33.217236] x10: 0000000000000a48
[   33.231721] x5 : 0000000000005356
[   33.235281] x9 : ffff8000d9590c00
[   33.240397] x4 : 0000000000000000
[   33.246592] x8 : 000000000000001c
[   33.261065] x3 : 0000000000000000
[   33.264749] x7 : ffff8000d9c08400
[   33.269874] x2 : ffff00000aabb000
[   33.276019] x6 : 0000000000000a64
[   33.290389] x1 : 0000000000000001
[   33.294192] x5 : 000000000000cf1a
[   33.299235] x0 : ffff8000d9fc5b00
[   33.305452] x4 : 0000000000000000
[   33.319989] Call trace:
[   33.324715] x3 : 0000000000000000 x2 : ffff00000aabb000
[   33.331717]  multi_cpu_stop+0x100/0x168
[   33.341973] x1 : 0000000000000001
[   33.345891]  cpu_stopper_thread+0xa8/0x118
[   33.351777]  smpboot_thread_fn+0x1bc/0x2c0
[   33.357845] x0 : ffff8000d971ad80
[   33.362176]  kthread+0x134/0x138
[   33.371281] Call trace:
[   33.377420]  ret_from_fork+0x10/0x1c
[   33.382212]  _raw_spin_unlock_irq+0x3c/0x78
[   33.387685]  finish_task_switch+0xa4/0x200
[   33.396875]  __schedule+0x350/0xc90
[   33.408272]  preempt_schedule_notrace+0x5c/0x130
[   33.419484]  ftrace_ops_no_ops+0xf4/0x180
[   33.430795]  ftrace_graph_call+0x0/0xc
[   33.442095]  preempt_count_add+0x1c/0x130
[   33.453259]  schedule+0x2c/0x98
[   33.464586]  worker_thread+0xdc/0x478
[   33.475886]  kthread+0x134/0x138
[   33.487099]  ret_from_fork+0x10/0x1c
[   34.464807] rcu: INFO: rcu_preempt self-detected stall on CPU
[   34.487238] rcu:     2-...0: (2757 ticks this GP) idle=20e/1/0x4000000000000002 softirq=120/120 fqs=316
5
[   34.509364] rcu:      (t=6514 jiffies g=-1095 q=1250)
[   34.528505] Task dump for CPU 2:
[   34.539317] migration/2     R  running task        0    22      2 0x0000002a
[   34.565716] Call trace:
[   34.577387]  dump_backtrace+0x0/0x200
[   34.588782]  show_stack+0x24/0x30
[   34.600098]  sched_show_task+0x20c/0x2d8
[   34.611726]  dump_cpu_task+0x48/0x58
[   34.623109]  rcu_dump_cpu_stacks+0xa0/0xe0
[   34.634637]  rcu_check_callbacks+0x85c/0xb60
[   34.646324]  update_process_times+0x34/0x60
[   34.657569]  tick_periodic+0x58/0x110
[   34.669169]  tick_handle_periodic+0x94/0xc8
[   34.680719]  arch_timer_handler_virt+0x38/0x58
[   34.692090]  handle_percpu_devid_irq+0xe4/0x458
[   34.703783]  generic_handle_irq+0x34/0x50
[   34.715121]  __handle_domain_irq+0x8c/0xf8
[   34.726529]  gic_handle_irq+0x84/0x180
[   34.738131]  el1_irq+0xec/0x198
[   34.749285]  multi_cpu_stop+0x100/0x168
[   34.760840]  cpu_stopper_thread+0xa8/0x118
[   34.772384]  smpboot_thread_fn+0x1bc/0x2c0
[   34.783587]  kthread+0x134/0x138
[   34.795188]  ret_from_fork+0x10/0x1c



Could perhaps
[   32.821812] softirqs last  enabled at (0): [<ffff0000080bdb68>] copy_process.isra.5.part.6+0x338/0x1ac
be involved in why the execution appears to never continue after the irq?


Kind regards,
Niklas
