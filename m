Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751292AbeDNLYp (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 07:24:45 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:39919 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751144AbeDNLYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 07:24:41 -0400
X-Google-Smtp-Source: AIpwx4+YpNLBFB9b7AounlUp/xLiKmR6H6qEboZuuqOxjsMDBOfrK2Luszy8vsfFeiXpigJbqVJ2zQ32oaDk8wZ0al0=
MIME-Version: 1.0
In-Reply-To: <20180412223904.GJ12256@bigcity.dyn.berto.se>
References: <20180412091822.GG12256@bigcity.dyn.berto.se> <CAKfTPtAE3qeWcTdT-WL8nrbZmP_+OaxPyyjUfVCzn=rax9tQZQ@mail.gmail.com>
 <20180412111519.GH12256@bigcity.dyn.berto.se> <20180412133031.GA551@linaro.org>
 <20180412223904.GJ12256@bigcity.dyn.berto.se>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Sat, 14 Apr 2018 13:24:20 +0200
Message-ID: <CAKfTPtDRtto7w806gYgdS_bCJ77EY0RRtszycB+TnG6aQ6ve4Q@mail.gmail.com>
Subject: Re: Potential problem with 31e77c93e432dec7 ("sched/fair: Update
 blocked load when newly idle")
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: i@linaro.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3EBOqrP003475

Hi Niklas,

On 13 April 2018 at 00:39, Niklas Söderlund
<niklas.soderlund@ragnatech.se> wrote:
> Hi Vincent,
>
> Thanks for helping trying to figure this out.
>
> On 2018-04-12 15:30:31 +0200, Vincent Guittot wrote:
>
> [snip]
>
>>
>> I'd like to narrow the problem a bit more with the 2 patchies aboves. Can you try
>> them separatly on top of c18bb396d3d261eb ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net"))
>> and check if one of them fixes the problem ?i
>
> I tried your suggested changes based on top of c18bb396d3d261eb.
>
>>
>> (They should apply on linux-next as well)
>>
>> First patch always kick ilb instead of doing ilb on local cpu before entering idle
>>
>> ---
>>  kernel/sched/fair.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 0951d1c..b21925b 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -9739,8 +9739,7 @@ static void nohz_newidle_balance(struct rq *this_rq)
>>        * candidate for ilb instead of waking up another idle CPU.
>>        * Kick an normal ilb if we failed to do the update.
>>        */
>> -     if (!_nohz_idle_balance(this_rq, NOHZ_STATS_KICK, CPU_NEWLY_IDLE))
>> -             kick_ilb(NOHZ_STATS_KICK);
>> +     kick_ilb(NOHZ_STATS_KICK);
>>       raw_spin_lock(&this_rq->lock);
>>  }
>
> This change don't seem to effect the issue. I can still get the single
> ssh session and the system to lockup by hitting the return key. And
> opening a second ssh session immediately unblocks both the first ssh
> session and the serial console. And I can still trigger the console
> warning by just letting the system be once it locks-up. I do have
> just as before reset the system a few times to trigger the issue.

You results are similar to Heiner's ones. The problem is still there
even if we only kick ilb which mainly send an IPI reschedule to the
other CPU if Idle

>
> [  245.351693] INFO: rcu_sched detected stalls on CPUs/tasks:
> [  245.357199]  0-...!: (1 GPs behind) idle=93c/0/0 softirq=2224/2225 fqs=0
> [  245.363988]  (detected by 1, t=3025 jiffies, g=337, c=336, q=10)
> [  245.370003] Sending NMI from CPU 1 to CPUs 0:
> [  245.374368] NMI backtrace for cpu 0
> [  245.374377] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.16.0-10930-ged741fb4567c816f #42
> [  245.374379] Hardware name: Generic R8A7791 (Flattened Device Tree)
> [  245.374393] PC is at arch_cpu_idle+0x24/0x40
> [  245.374397] LR is at arch_cpu_idle+0x34/0x40
> [  245.374400] pc : [<c0108554>]    lr : [<c0108564>]    psr: 60050013
> [  245.374403] sp : c0b01f40  ip : c0b01f50  fp : c0b01f4c
> [  245.374405] r10: c0a56a38  r9 : e7fffbc0  r8 : c0b04c00
> [  245.374407] r7 : c0b04c78  r6 : c0b04c2c  r5 : ffffe000  r4 : 00000001
> [  245.374410] r3 : c0119100  r2 : e77813a8  r1 : 0002d93c  r0 : 00000000
> [  245.374414] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [  245.374417] Control: 10c5387d  Table: 6662006a  DAC: 00000051
> [  245.374421] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.16.0-10930-ged741fb4567c816f #42
> [  245.374423] Hardware name: Generic R8A7791 (Flattened Device Tree)
> [  245.374425] Backtrace:
> [  245.374435] [<c010c170>] (dump_backtrace) from [<c010c3f0>] (show_stack+0x18/0x1c)
> [  245.374440]  r7:c0b47278 r6:60050193 r5:00000000 r4:c0b73d80
> [  245.374450] [<c010c3d8>] (show_stack) from [<c074b824>] (dump_stack+0x84/0xa4)
> [  245.374456] [<c074b7a0>] (dump_stack) from [<c01087e8>] (show_regs+0x14/0x18)
> [  245.374460]  r7:c0b47278 r6:c0b01ef0 r5:00000000 r4:c0bc62c8
> [  245.374468] [<c01087d4>] (show_regs) from [<c0751938>] (nmi_cpu_backtrace+0xfc/0x118)
> [  245.374475] [<c075183c>] (nmi_cpu_backtrace) from [<c010ef34>] (handle_IPI+0x22c/0x294)
> [  245.374479]  r7:c0b47278 r6:c0b01ef0 r5:00000007 r4:c0a775fc
> [  245.374488] [<c010ed08>] (handle_IPI) from [<c037cd68>] (gic_handle_irq+0x8c/0x98)
> [  245.374492]  r10:c0a56a38 r9:c0b00000 r8:f0803000 r7:c0b47278 r6:c0b01ef0 r5:c0b05244
> [  245.374495]  r4:f0802000 r3:00000407
> [  245.374501] [<c037ccdc>] (gic_handle_irq) from [<c0101a0c>] (__irq_svc+0x6c/0x90)
> [  245.374504] Exception stack(0xc0b01ef0 to 0xc0b01f38)
> [  245.374507] 1ee0:                                     00000000 0002d93c e77813a8 c0119100
> [  245.374512] 1f00: 00000001 ffffe000 c0b04c2c c0b04c78 c0b04c00 e7fffbc0 c0a56a38 c0b01f4c
> [  245.374516] 1f20: c0b01f50 c0b01f40 c0108564 c0108554 60050013 ffffffff
> [  245.374521]  r9:c0b00000 r8:c0b04c00 r7:c0b01f24 r6:ffffffff r5:60050013 r4:c0108554
> [  245.374528] [<c0108530>] (arch_cpu_idle) from [<c076512c>] (default_idle_call+0x30/0x34)
> [  245.374535] [<c07650fc>] (default_idle_call) from [<c014b834>] (do_idle+0xd8/0x128)
> [  245.374540] [<c014b75c>] (do_idle) from [<c014baf0>] (cpu_startup_entry+0x20/0x24)
> [  245.374543]  r7:c0b04c08 r6:ffffffff r5:c0b80380 r4:000000c2
> [  245.374549] [<c014bad0>] (cpu_startup_entry) from [<c075fb14>] (rest_init+0x9c/0xbc)
> [  245.374555] [<c075fa78>] (rest_init) from [<c0a00dc4>] (start_kernel+0x368/0x3ec)
> [  245.374558]  r5:c0b80380 r4:c0b803c0
> [  245.374563] [<c0a00a5c>] (start_kernel) from [<00000000>] (  (null))
> [  245.375369] rcu_sched kthread starved for 3028 jiffies! g337 c336 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=1
> [  245.641242] RCU grace-period kthread stack dump:
> [  245.645859] rcu_sched       I    0     9      2 0x00000000
> [  245.651350] Backtrace:
> [  245.653804] [<c07603f0>] (__schedule) from [<c0760b44>] (schedule+0x94/0xb8)
> [  245.660857]  r10:e77903c0 r9:e77903c0 r8:ffffffff r7:e709bed4 r6:ffffded7 r5:00000000
> [  245.668689]  r4:ffffe000
> [  245.671227] [<c0760ab0>] (schedule) from [<c0764500>] (schedule_timeout+0x380/0x3dc)
> [  245.678973]  r5:00000000 r4:00000000
> [  245.682557] [<c0764180>] (schedule_timeout) from [<c017b620>] (rcu_gp_kthread+0x668/0xe2c)
> [  245.690826]  r10:c0b79018 r9:00000151 r8:00000150 r7:00000001 r6:00000000 r5:c0b10ad0
> [  245.698658]  r4:c0b10980
> [  245.701197] [<c017afb8>] (rcu_gp_kthread) from [<c013ddd8>] (kthread+0x148/0x160)
> [  245.708682]  r7:c0b10980
> [  245.711218] [<c013dc90>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
> [  245.718443] Exception stack(0xe709bfb0 to 0xe709bff8)
> [  245.723495] bfa0:                                     00000000 00000000 00000000 00000000
> [  245.731677] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [  245.739858] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [  245.746476]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c013dc90
> [  245.754307]  r4:e7026f40
> [  335.351162] INFO: rcu_sched detected stalls on CPUs/tasks:
> [  335.356682]  0-...!: (0 ticks this GP) idle=b0a/1/1073741824 softirq=2226/2226 fqs=0
> [  335.364521]  (detected by 1, t=6027 jiffies, g=340, c=339, q=77)
> [  335.370545] Sending NMI from CPU 1 to CPUs 0:
> [  345.374803] NMI backtrace for cpu 1
> [  345.378295] CPU: 1 PID: 1926 Comm: bash Not tainted 4.16.0-10930-ged741fb4567c816f #42
> [  345.386215] Hardware name: Generic R8A7791 (Flattened Device Tree)
> [  345.392395] Backtrace:
> [  345.394855] [<c010c170>] (dump_backtrace) from [<c010c3f0>] (show_stack+0x18/0x1c)
> [  345.402430]  r7:00000000 r6:600f0193 r5:00000000 r4:c0b73d80
> [  345.408097] [<c010c3d8>] (show_stack) from [<c074b824>] (dump_stack+0x84/0xa4)
> [  345.415329] [<c074b7a0>] (dump_stack) from [<c0751940>] (nmi_cpu_backtrace+0x104/0x118)
> [  345.423337]  r7:00000000 r6:00000000 r5:00000001 r4:c0bc62c8
> [  345.429001] [<c075183c>] (nmi_cpu_backtrace) from [<c07519e0>] (nmi_trigger_cpumask_backtrace+0x8c/0x10c)
> [  345.438572]  r7:00000000 r6:c010e4d4 r5:00000001 r4:c0b08158
> [  345.444237] [<c0751954>] (nmi_trigger_cpumask_backtrace) from [<c010f0ec>] (arch_trigger_cpumask_backtrace+0x14/0x1c)
> [  345.454850]  r7:c0b10980 r6:c0b04cd0 r5:00000001 r4:c0b10980
> [  345.460519] [<c010f0d8>] (arch_trigger_cpumask_backtrace) from [<c017f9ac>] (rcu_dump_cpu_stacks+0xb0/0xd0)
> [  345.470268] [<c017f8fc>] (rcu_dump_cpu_stacks) from [<c017e73c>] (rcu_check_callbacks+0x584/0x71c)
> [  345.479232]  r10:0000004d r9:c0b03d00 r8:ffffe000 r7:00000001 r6:c0b10940 r5:e7795080
> [  345.487065]  r4:c0b10980 r3:f181863e
> [  345.490648] [<c017e1b8>] (rcu_check_callbacks) from [<c0184a60>] (update_process_times+0x38/0x64)
> [  345.499524]  r10:e7fa9ea0 r9:e67e8000 r8:e7795e00 r7:0000004e r6:00000000 r5:e72d0640
> [  345.507356]  r4:ffffe000
> [  345.509903] [<c0184a28>] (update_process_times) from [<c0195bf0>] (tick_nohz_handler+0xc8/0x114)
> [  345.518693]  r7:0000004e r6:146afc64 r5:e67e9d70 r4:e77917a0
> [  345.524362] [<c0195b28>] (tick_nohz_handler) from [<c05c16ac>] (arch_timer_handler_virt+0x30/0x40)
> [  345.533325]  r8:c0b05244 r7:00000013 r6:e7017a40 r5:00000000 r4:e7015c00
> [  345.540033] [<c05c167c>] (arch_timer_handler_virt) from [<c016ecd4>] (handle_percpu_devid_irq+0xf0/0x224)
> [  345.549607] [<c016ebe4>] (handle_percpu_devid_irq) from [<c016a208>] (generic_handle_irq+0x20/0x30)
> [  345.558657]  r10:e7fa9ea0 r9:e67e8000 r8:e7008800 r7:00000013 r6:c0a775fc r5:00000000
> [  345.566489]  r4:00000000 r3:c016ebe4
> [  345.570067] [<c016a1e8>] (generic_handle_irq) from [<c016a2c0>] (__handle_domain_irq+0xa8/0xbc)
> [  345.578777] [<c016a218>] (__handle_domain_irq) from [<c037cd3c>] (gic_handle_irq+0x60/0x98)
> [  345.587132]  r9:e67e8000 r8:f0803000 r7:c0b47278 r6:e67e9d70 r5:c0b05244 r4:f0802000
> [  345.594883] [<c037ccdc>] (gic_handle_irq) from [<c0101a0c>] (__irq_svc+0x6c/0x90)
> [  345.602368] Exception stack(0xe67e9d70 to 0xe67e9db8)
> [  345.607421] 9d60:                                     00000000 e6c433e8 00182b08 00000000
> [  345.615603] 9d80: e6c429b4 00000087 e67e9e34 e6c434c4 00000000 00000087 e7fa9ea0 e67e9e14
> [  345.623784] 9da0: 00000000 e67e9dc0 c01e0f34 c01e0f88 600f0113 ffffffff
> [  345.630401]  r9:e67e8000 r8:00000000 r7:e67e9da4 r6:ffffffff r5:600f0113 r4:c01e0f88
> [  345.638156] [<c01e0d84>] (filemap_map_pages) from [<c02141f0>] (handle_mm_fault+0x5c8/0x93c)
> [  345.646599]  r10:e5dc5380 r9:80000007 r8:00000080 r7:b6e02000 r6:c0b04c08 r5:0000008f
> [  345.654431]  r4:00000000
> [  345.656968] [<c0213c28>] (handle_mm_fault) from [<c011404c>] (do_page_fault+0x17c/0x324)
> [  345.665063]  r10:e5dc5380 r9:80000007 r8:e72d0640 r7:00000054 r6:e5d030c0 r5:b6e023dc
> [  345.672895]  r4:e67e9fb0
> [  345.675431] [<c0113ed0>] (do_page_fault) from [<c0114470>] (do_PrefetchAbort+0x4c/0xc8)
> [  345.683439]  r10:00000010 r9:00179207 r8:c0b0a434 r7:e67e9fb0 r6:b6e023dc r5:c0b04c08
> [  345.691271]  r4:00000007
> [  345.693807] [<c0114424>] (do_PrefetchAbort) from [<c010204c>] (ret_from_exception+0x0/0x14)
> [  345.702160] Exception stack(0xe67e9fb0 to 0xe67e9ff8)
> [  345.707213] 9fa0:                                     00000000 000e9600 00000001 bec86544
> [  345.715395] 9fc0: 00000001 bec86544 00000000 00000000 bec8654c 00179207 00000010 000e9600
> [  345.723576] 9fe0: 000c8140 bec86538 0002847c b6e023dc 200f0010 ffffffff
> [  345.730192]  r8:10c5387d r7:10c5387d r6:ffffffff r5:200f0010 r4:b6e023dc
> [  345.737364] nfs: server 10.0.1.1 not responding, still trying
> [  345.743294] nfs: server 10.0.1.1 not responding, still trying
> [  345.744534] nfs: server 10.0.1.1 not responding, still trying
> [  345.749262] nfs: server 10.0.1.1 OK
> [  345.755391] nfs: server 10.0.1.1 OK
> [  345.758641] nfs: server 10.0.1.1 OK
>
>>
>> --
>> 2.7.4
>>
>>
>> The 2nd patch does the opposite and never kick ilb. I have always made the
>> assumtpion that the problem was coming from _nohz_idle_balance() and I just
>> wanted to check that's the case
>>
>> ---
>>  kernel/sched/fair.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 0951d1c..1766594 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -9739,8 +9739,7 @@ static void nohz_newidle_balance(struct rq *this_rq)
>>        * candidate for ilb instead of waking up another idle CPU.
>>        * Kick an normal ilb if we failed to do the update.
>>        */
>> -     if (!_nohz_idle_balance(this_rq, NOHZ_STATS_KICK, CPU_NEWLY_IDLE))
>> -             kick_ilb(NOHZ_STATS_KICK);
>> +     _nohz_idle_balance(this_rq, NOHZ_STATS_KICK, CPU_NEWLY_IDLE);
>>       raw_spin_lock(&this_rq->lock);
>>  }
>
> With this change it seem more difficult to trigger the issue, I usually
> can trigger it within 2-3 rests of the system but with this applied I
> had to reset it over 5 times to trigger it. But I can still reproduce
> the lockup reliably multiple times. I would not trust my feeling that
> it's harder to reproduce with this change as the method to trigger it is
> kind of spotty and most likely due to circumstantial circumstances :-)
>
> I can still unlock the system by starting a second ssh session and
> trigger the output on the serial console.
>
> [  193.741481] INFO: rcu_sched detected stalls on CPUs/tasks:
> [  193.746991]  1-...!: (0 ticks this GP) idle=83c/0/0 softirq=2445/2445 fqs=0
> [  193.754041]  (detected by 0, t=4096 jiffies, g=611, c=610, q=31)
> [  193.760054] NMI backtrace for cpu 0
> [  193.763546] CPU: 0 PID: 2193 Comm: bash Not tainted 4.16.0-10929-gc18bb396d3d261eb-dirty #43
> [  193.771984] Hardware name: Generic R8A7791 (Flattened Device Tree)
> [  193.778163] Backtrace:
> [  193.780625] [<c010c170>] (dump_backtrace) from [<c010c3f0>] (show_stack+0x18/0x1c)
> [  193.788198]  r7:00000000 r6:60010193 r5:00000000 r4:c0b73d80
> [  193.793865] [<c010c3d8>] (show_stack) from [<c074b864>] (dump_stack+0x84/0xa4)
> [  193.801093] [<c074b7e0>] (dump_stack) from [<c0751980>] (nmi_cpu_backtrace+0x104/0x118)
> [  193.809098]  r7:00000000 r6:00000000 r5:00000000 r4:c0bc62c8
> [  193.814761] [<c075187c>] (nmi_cpu_backtrace) from [<c0751a20>] (nmi_trigger_cpumask_backtrace+0x8c/0x10c)
> [  193.824329]  r7:00000000 r6:c010e4d4 r5:00000000 r4:c0b08158
> [  193.829992] [<c0751994>] (nmi_trigger_cpumask_backtrace) from [<c010f0ec>] (arch_trigger_cpumask_backtrace+0x14/0x1c)
> [  193.840603]  r7:c0b10980 r6:c0b04cd0 r5:00000000 r4:c0b10980
> [  193.846268] [<c010f0d8>] (arch_trigger_cpumask_backtrace) from [<c017f9ec>] (rcu_dump_cpu_stacks+0xb0/0xd0)
> [  193.856015] [<c017f93c>] (rcu_dump_cpu_stacks) from [<c017e77c>] (rcu_check_callbacks+0x584/0x71c)
> [  193.864977]  r10:0000001f r9:c0b03d00 r8:ffffe000 r7:00000001 r6:c0b10940 r5:e7786080
> [  193.872810]  r4:c0b10980 r3:f181863e
> [  193.876392] [<c017e1f8>] (rcu_check_callbacks) from [<c0184aa0>] (update_process_times+0x38/0x64)
> [  193.885268]  r10:00000000 r9:00180b98 r8:e7786e00 r7:0000002d r6:00000001 r5:e5d86180
> [  193.893100]  r4:ffffe000
> [  193.895642] [<c0184a68>] (update_process_times) from [<c0195c30>] (tick_nohz_handler+0xc8/0x114)
> [  193.904431]  r7:0000002d r6:1bcdda00 r5:e66c7fb0 r4:e77827a0
> [  193.910099] [<c0195b68>] (tick_nohz_handler) from [<c05c16ec>] (arch_timer_handler_virt+0x30/0x40)
> [  193.919062]  r8:c0b05244 r7:00000013 r6:e7017a40 r5:00000000 r4:e7015c00
> [  193.925769] [<c05c16bc>] (arch_timer_handler_virt) from [<c016ed14>] (handle_percpu_devid_irq+0xf0/0x224)
> [  193.935343] [<c016ec24>] (handle_percpu_devid_irq) from [<c016a248>] (generic_handle_irq+0x20/0x30)
> [  193.944394]  r10:00000000 r9:00180b98 r8:e7008800 r7:00000013 r6:c0a775fc r5:00000000
> [  193.952225]  r4:00000000 r3:c016ec24
> [  193.955803] [<c016a228>] (generic_handle_irq) from [<c016a300>] (__handle_domain_irq+0xa8/0xbc)
> [  193.964513] [<c016a258>] (__handle_domain_irq) from [<c037cd7c>] (gic_handle_irq+0x60/0x98)
> [  193.972869]  r9:00180b98 r8:f0803000 r7:c0b47278 r6:e66c7fb0 r5:c0b05244 r4:f0802000
> [  193.980619] [<c037cd1c>] (gic_handle_irq) from [<c0101dd4>] (__irq_usr+0x54/0x80)
> [  193.988105] Exception stack(0xe66c7fb0 to 0xe66c7ff8)
> [  193.993157] 7fa0:                                     00000000 00000000 b6e8b79c 00000000
> [  194.001339] 7fc0: 00178378 000134e0 b6e8b794 b6e8b000 b6e8b794 00180b98 00000000 b6e8b7c4
> [  194.009520] 7fe0: be955190 be955170 00000000 b6db5c58 20010010 ffffffff
> [  194.016137]  r9:00180b98 r8:10c5387d r7:10c5387d r6:ffffffff r5:20010010 r4:b6db5c58
> [  194.023888] Sending NMI from CPU 0 to CPUs 1:
> [  204.028147] NMI backtrace for cpu 1
> [  204.028152] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.16.0-10929-gc18bb396d3d261eb-dirty #43
> [  204.028155] Hardware name: Generic R8A7791 (Flattened Device Tree)
> [  204.028164] PC is at _raw_spin_unlock_irqrestore+0x28/0x2c
> [  204.028169] LR is at rcu_report_qs_rnp+0x4c/0x20c
> [  204.028172] pc : [<c07653d8>]    lr : [<c01796d4>]    psr: 200e0113
> [  204.028175] sp : e70a3db0  ip : e70a3dc0  fp : e70a3dbc
> [  204.028177] r10: 00000264  r9 : c0b787eb  r8 : 00000001
> [  204.028179] r7 : 00000002  r6 : c0b10980  r5 : c0b10980  r4 : c0b10980
> [  204.028182] r3 : 000022a3  r2 : 00000264  r1 : 600e0113  r0 : c0b10980
> [  204.028187] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [  204.028189] Control: 10c5387d  Table: 66b9806a  DAC: 00000051
> [  204.028193] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.16.0-10929-gc18bb396d3d261eb-dirty #43
> [  204.028195] Hardware name: Generic R8A7791 (Flattened Device Tree)
> [  204.028197] Backtrace:
> [  204.028204] [<c010c170>] (dump_backtrace) from [<c010c3f0>] (show_stack+0x18/0x1c)
> [  204.028209]  r7:c0b47278 r6:600e0193 r5:00000000 r4:c0b73d80
> [  204.028215] [<c010c3d8>] (show_stack) from [<c074b864>] (dump_stack+0x84/0xa4)
> [  204.028228] [<c074b7e0>] (dump_stack) from [<c01087e8>] (show_regs+0x14/0x18)
> [  204.028231]  r7:c0b47278 r6:e70a3d60 r5:00000001 r4:c0bc62c8
> [  204.028238] [<c01087d4>] (show_regs) from [<c0751978>] (nmi_cpu_backtrace+0xfc/0x118)
> [  204.028244] [<c075187c>] (nmi_cpu_backtrace) from [<c010ef34>] (handle_IPI+0x22c/0x294)
> [  204.028247]  r7:c0b47278 r6:e70a3d60 r5:00000007 r4:c0a775fc
> [  204.028254] [<c010ed08>] (handle_IPI) from [<c037cda8>] (gic_handle_irq+0x8c/0x98)
> [  204.028259]  r10:00000264 r9:e70a2000 r8:f0803000 r7:c0b47278 r6:e70a3d60 r5:c0b05244
> [  204.028261]  r4:f0802000 r3:00000007
> [  204.028267] [<c037cd1c>] (gic_handle_irq) from [<c0101a0c>] (__irq_svc+0x6c/0x90)
> [  204.028270] Exception stack(0xe70a3d60 to 0xe70a3da8)
> [  204.028275] 3d60: c0b10980 600e0113 00000264 000022a3 c0b10980 c0b10980 c0b10980 00000002
> [  204.028280] 3d80: 00000001 c0b787eb 00000264 e70a3dbc e70a3dc0 e70a3db0 c01796d4 c07653d8
> [  204.028283] 3da0: 200e0113 ffffffff
> [  204.028287]  r9:e70a2000 r8:00000001 r7:e70a3d94 r6:ffffffff r5:200e0113 r4:c07653d8
> [  204.028295] [<c07653b0>] (_raw_spin_unlock_irqrestore) from [<c01796d4>] (rcu_report_qs_rnp+0x4c/0x20c)
> [  204.028301] [<c0179688>] (rcu_report_qs_rnp) from [<c017c188>] (rcu_process_callbacks+0x364/0x8cc)
> [  204.028305]  r10:c0b03080 r9:00000000 r8:00000002 r7:600e0113 r6:c0b10980 r5:c0b10980
> [  204.028306]  r4:e7795080
> [  204.028312] [<c017be24>] (rcu_process_callbacks) from [<c010236c>] (__do_softirq+0x23c/0x338)
> [  204.028316]  r10:c0b03080 r9:00000100 r8:c0b80ec0 r7:00000002 r6:00000009 r5:c0b030a4
> [  204.028318]  r4:ffffe000
> [  204.028325] [<c0102130>] (__do_softirq) from [<c0125b90>] (irq_exit+0x6c/0xd4)
> [  204.028329]  r10:00000000 r9:e70a2000 r8:e7008800 r7:00000013 r6:c0a775fc r5:00000000
> [  204.028331]  r4:00000000
> [  204.028336] [<c0125b24>] (irq_exit) from [<c016a2e0>] (__handle_domain_irq+0x88/0xbc)
> [  204.028338]  r5:00000000 r4:00000000
> [  204.028344] [<c016a258>] (__handle_domain_irq) from [<c037cd7c>] (gic_handle_irq+0x60/0x98)
> [  204.028348]  r9:e70a2000 r8:f0803000 r7:c0b47278 r6:e70a3f40 r5:c0b05244 r4:f0802000
> [  204.028354] [<c037cd1c>] (gic_handle_irq) from [<c0101a0c>] (__irq_svc+0x6c/0x90)
> [  204.028356] Exception stack(0xe70a3f40 to 0xe70a3f88)
> [  204.028361] 3f40: 00000000 00013844 e77903a8 c0119100 00000002 ffffe000 c0b04c2c c0b04c78
> [  204.028367] 3f60: 4000406a 413fc0f2 00000000 e70a3f9c e70a3fa0 e70a3f90 c0108564 c0108554
> [  204.028370] 3f80: 600e0013 ffffffff
> [  204.028374]  r9:e70a2000 r8:4000406a r7:e70a3f74 r6:ffffffff r5:600e0013 r4:c0108554
> [  204.028381] [<c0108530>] (arch_cpu_idle) from [<c076516c>] (default_idle_call+0x30/0x34)
> [  204.028388] [<c076513c>] (default_idle_call) from [<c014b834>] (do_idle+0xd8/0x128)
> [  204.028392] [<c014b75c>] (do_idle) from [<c014baf0>] (cpu_startup_entry+0x20/0x24)
> [  204.028396]  r7:c0b80750 r6:10c0387d r5:00000051 r4:00000085
> [  204.028401] [<c014bad0>] (cpu_startup_entry) from [<c010eacc>] (secondary_start_kernel+0x10c/0x12c)
> [  204.028406] [<c010e9c0>] (secondary_start_kernel) from [<4010250c>] (0x4010250c)
> [  204.028408]  r5:00000051 r4:6709406a
>
>>
>> --
>> 2.7.4
>>
>>
>> Thanks,
>> Vincent
>>
>> > >
>> > >
>> > > Regards,
>> > > Vincent
>> > > >
>> > > > 1. c18bb396d3d261eb ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net"))
>> > > > 2. 31e77c93e432dec7 ("sched/fair: Update blocked load when newly idle")
>> > > >
>> > > > --
>> > > > Regards,
>> > > > Niklas Söderlund
>> >
>> > --
>> > Regards,
>> > Niklas Söderlund
>
> --
> Regards,
> Niklas Söderlund
