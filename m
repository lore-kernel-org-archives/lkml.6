Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751716AbeDJCQh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 22:16:37 -0400
Received: from mail-pl0-f42.google.com ([209.85.160.42]:34269 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751568AbeDJCQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 22:16:34 -0400
X-Google-Smtp-Source: AIpwx4/fU84lyp5p8c3O7mXmRbrOqLJ+BbKM1+a+Q9R737M6kVasKNRvsVf/6UgrEpp3rYUnpAVoTw==
Date: Tue, 10 Apr 2018 12:16:18 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
        kvm-ppc@vger.kernel.org
Subject: Occasionally losing the tick_sched_timer
Message-ID: <20180410121618.4fffffcc@roar.ozlabs.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are seeing rare hard lockup watchdog timeouts, a CPU seems to have no
more timers scheduled, despite hard and soft lockup watchdogs should have
their heart beat timers and probably many others.

The reproducer we have is running a KVM workload. The lockup is in the
host kernel, quite rare but we may be able to slowly test things.

I have a sysrq+q snippet. CPU3 is the stuck one, you can see its tick has
stopped for a long time and no hrtimer active. Included CPU4 for what the
other CPUs look like.

Thomas do you have any ideas on what we might look for, or if we can add
some BUG_ON()s to catch this at its source?

- CPU3 is sitting in its cpuidle loop (polling idle with all other idle
  states disabled).

- `taskset -c 3 ls` basically revived the CPU and got timers running again.

- May not be a new bug because we have just in the past few releases
  enabled the hard lockup detector by default

- KVM is being used. This switches various registers like timebase and
  decrementer. Possibly that's involved, but we can't say the bug does
  not happen without KVM.

cpu: 3
 clock 0:
  .base:       00000000df30f5ab
  .index:      0
  .resolution: 1 nsecs
  .get_time:   
ktime_get

  .offset:     0 nsecs
active timers:
 clock 1:
  .base:       00000000520cc304
  .index:      1
  .resolution: 1 nsecs
  .get_time:   
ktime_get_real

  .offset:     1523263049759155857 nsecs
active timers:
 clock 2:
  .base:       00000000706e6277
  .index:      2
  .resolution: 1 nsecs
  .get_time:   
ktime_get_boottime

  .offset:     0 nsecs
active timers:
 clock 3:
  .base:       00000000e2ae2811
  .index:      3
  .resolution: 1 nsecs
  .get_time:   
ktime_get_clocktai

  .offset:     1523263049759155857 nsecs
active timers:
 clock 4:
  .base:       00000000c93e2f8e
  .index:      4
  .resolution: 1 nsecs
  .get_time:   
ktime_get

  .offset:     0 nsecs
active timers:
 clock 5:
  .base:       000000007b726c6a
  .index:      5
  .resolution: 1 nsecs
  .get_time:   
ktime_get_real

  .offset:     1523263049759155857 nsecs
active timers:
 clock 6:
  .base:       00000000f17c2d4f
  .index:      6
  .resolution: 1 nsecs
  .get_time:   
ktime_get_boottime

  .offset:     0 nsecs
active timers:
 clock 7:
  .base:       000000006c57ef89
  .index:      7
  .resolution: 1 nsecs
  .get_time:   
ktime_get_clocktai

  .offset:     1523263049759155857 nsecs
active timers:
  .expires_next   : 9223372036854775807 nsecs
  .hres_active    : 1
  .nr_events      : 1446533
  .nr_retries     : 1434
  .nr_hangs       : 0
  .max_hang_time  : 0
  .nohz_mode      : 2
  .last_tick      : 17763120000000 nsecs
  .tick_stopped   : 1
  .idle_jiffies   : 4296713609
  .idle_calls     : 2573133
  .idle_sleeps    : 1957794
  .idle_entrytime : 17763129999625 nsecs
  .idle_waketime  : 59550238131639 nsecs
  .idle_exittime  : 17763110009176 nsecs
  .idle_sleeptime : 17504617295679 nsecs
  .iowait_sleeptime: 719978688 nsecs
  .last_jiffies   : 4296713608
  .next_timer     : 17763130000000
  .idle_expires   : 17763130000000 nsecs
jiffies: 4300892324

cpu: 4
 clock 0:
  .base:       0000000007d8226b
  .index:      0
  .resolution: 1 nsecs
  .get_time:   
ktime_get

  .offset:     0 nsecs
active timers:
 #0: 
<00000000a73e543a>
, 
tick_sched_timer
, S:01

 # expires at 59552950000000-59552950000000 nsecs [in 2685654802 to 2685654802 nsecs]
 #1: 
<000000009b4a3b88>
, 
hrtimer_wakeup
, S:01

 # expires at 59602585423025-59602642458243 nsecs [in 52321077827 to 52378113045 nsecs]
 clock 1:
  .base:       00000000d2ae50c4
  .index:      1
  .resolution: 1 nsecs
  .get_time:   
ktime_get_real

  .offset:     1523263049759155857 nsecs
active timers:
 clock 2:
  .base:       000000001a80e123
  .index:      2
  .resolution: 1 nsecs
  .get_time:   
ktime_get_boottime

  .offset:     0 nsecs
active timers:
 clock 3:
  .base:       000000005c97ab69
  .index:      3
  .resolution: 1 nsecs
  .get_time:   
ktime_get_clocktai

  .offset:     1523263049759155857 nsecs
active timers:
 clock 4:
  .base:       0000000075ac8f03
  .index:      4
  .resolution: 1 nsecs
  .get_time:   
ktime_get

  .offset:     0 nsecs
active timers:
 clock 5:
  .base:       00000000db06f6ce
  .index:      5
  .resolution: 1 nsecs
  .get_time:   
ktime_get_real

  .offset:     1523263049759155857 nsecs
active timers:
 clock 6:
  .base:       00000000fa63fbce
  .index:      6
  .resolution: 1 nsecs
  .get_time:   
ktime_get_boottime

  .offset:     0 nsecs
active timers:
 clock 7:
  .base:       0000000041de439c
  .index:      7
  .resolution: 1 nsecs
  .get_time:   
ktime_get_clocktai

  .offset:     1523263049759155857 nsecs
active timers:
  .expires_next   : 59552950000000 nsecs
  .hres_active    : 1
  .nr_events      : 294282
  .nr_retries     : 16138
  .nr_hangs       : 0
  .max_hang_time  : 0
  .nohz_mode      : 2
  .last_tick      : 59545620000000 nsecs
  .tick_stopped   : 1
  .idle_jiffies   : 4300891859
  .idle_calls     : 553259
  .idle_sleeps    : 536396
  .idle_entrytime : 59547990019145 nsecs
  .idle_waketime  : 59547990000281 nsecs
  .idle_exittime  : 59545550189113 nsecs
  .idle_sleeptime : 59355272715835 nsecs
  .iowait_sleeptime: 846852479 nsecs
  .last_jiffies   : 4300892096
  .next_timer     : 59552950000000
  .idle_expires   : 59552950000000 nsecs
jiffies: 4300892324
