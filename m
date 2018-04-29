Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754156AbeD2TJ7 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 15:09:59 -0400
Received: from foss.arm.com ([217.140.101.70]:53394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753719AbeD2TJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 15:09:58 -0400
Subject: Re: [PATCHv2,1/7] sched: Add static_key for asymmetric cpu capacity
 optimizations
To: Jiada Wang <jiada_wang@mentor.com>, morten.rasmussen@arm.com
Cc: dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        gaku.inami.xh@renesas.com, linux-kernel@vger.kernel.org
References: <1521125224-15434-2-git-send-email-morten.rasmussen@arm.com>
 <20180427140438.7433-1-jiada_wang@mentor.com>
From: Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <c75a8a4a-a624-6022-4448-188c0ba69434@arm.com>
Date: Sun, 29 Apr 2018 20:09:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427140438.7433-1-jiada_wang@mentor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27/04/18 15:04, Jiada Wang wrote:
> Hi
> 
> with this patch, if enable CONFIG_DEBUG_ATOMIC_SLEEP=y,
> then I am getting following BUG report during early startup
> 

Thanks for bringing that up.

> Backtrace caused by [1] during early kernel startup:
> [ 5.325288] CPU: All CPU(s) started at EL2
> [ 5.325700] alternatives: patching kernel code
> [ 5.329255] BUG: sleeping function called from invalid context at ./include/linux/percpu-rwsem.h:34
> [ 5.329525] in_atomic(): 0, irqs_disabled(): 0, pid: 1, name: swapper/0
> [ 5.329657] 2 locks held by swapper/0/1:
> [ 5.329744] #0: (sched_domains_mutex){+.+.}, at: [<ffff20000957f244>] sched_init_smp+0x88/0x158
> [ 5.329993] #1: (rcu_read_lock){....}, at: [<ffff200008159794>] build_sched_domains+0x9cc/0x2f08
> [ 5.330233] Preemption disabled at:
> [ 5.330256] [<ffff200008157b5c>] rq_attach_root+0x28/0x1d8
> [ 5.330511] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.14.17+ #123
> [ 5.330635] Hardware name: Renesas Salvator-X board based on r8a7795 ES2.0+ (DT)
> [ 5.330779] Call trace:
> [ 5.330853] [<ffff20000808fe88>] dump_backtrace+0x0/0x364
> [ 5.330968] [<ffff200008090200>] show_stack+0x14/0x1c
> [ 5.331080] [<ffff200008f365d8>] dump_stack+0x108/0x174
> [ 5.331194] [<ffff200008113170>] ___might_sleep+0x43c/0x44c
> [ 5.331310] [<ffff2000081132e4>] __might_sleep+0x164/0x178
> [ 5.331429] [<ffff2000080b2338>] cpus_read_lock+0x38/0x12c
> [ 5.331547] [<ffff2000082d5860>] static_key_enable+0x14/0x2c
> [ 5.331665] [<ffff20000815bcac>] build_sched_domains+0x2ee4/0x2f08
> [ 5.331789] [<ffff20000815cc9c>] sched_init_domains+0xcc/0xe8
> [ 5.331908] [<ffff20000957f250>] sched_init_smp+0x94/0x158
> [ 5.332026] [<ffff200009571560>] kernel_init_freeable+0x1ec/0x4c4
> [ 5.332153] [<ffff200008f593a8>] kernel_init+0x10/0x128
> [ 5.332264] [<ffff2000080865d4>] ret_from_fork+0x10/0x18
> [ 5.343400] devtmpfs: initialized
> 

I tried reproducing this on my HiKey960, and I do get a BUG pointing at a 
static_key_enable but at a completely different place...

[    0.158072] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:238
[    0.158074] in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper/4
[    0.158080] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G S               4.16.0-linaro-hikey960 #4
[    0.158081] Hardware name: HiKey960 (DT)
[    0.158083] Call trace:
[    0.158098]  dump_backtrace+0x0/0x188
[    0.158102]  show_stack+0x14/0x20
[    0.158108]  dump_stack+0x98/0xbc
[    0.158113]  ___might_sleep+0xf0/0x118
[    0.158115]  __might_sleep+0x50/0x88
[    0.158118]  mutex_lock+0x24/0x60
[    0.158124]  static_key_enable_cpuslocked+0x50/0xc0
[    0.158130]  arch_timer_check_ool_workaround+0x1ac/0x228
[    0.158133]  arch_timer_starting_cpu+0xfc/0x2e8
[    0.158137]  cpuhp_invoke_callback+0xa0/0x228
[    0.158140]  notify_cpu_starting+0x70/0x90
[    0.158143]  secondary_start_kernel+0x128/0x1c8



I went and had a look at the documentation for the static keys, and it mentions
fun stuff can happen with hotplug. I gave it a try and got this:

root@linaro-developer:~# echo 0 > /sys/devices/system/cpu/cpu4/online 
[ 1893.765366] CPU4: shutdown
[ 1893.768077] psci: CPU4 killed.
[ 1893.771890] BUG: sleeping function called from invalid context at ./include/linux/percpu-rwsem.h:34
[ 1893.773361] crct10dif_ce: Unknown symbol _mcount (err 0)
[ 1893.777754] in_atomic(): 0, irqs_disabled(): 0, pid: 3392, name: kworker/4:0
[ 1893.799136] CPU: 0 PID: 3392 Comm: kworker/4:0 Tainted: G S      W        4.16.0-linaro-hikey960 #4
[ 1893.808180] Hardware name: HiKey960 (DT)
[ 1893.812110] Workqueue: events cpuset_hotplug_workfn
[ 1893.816984] Call trace:
[ 1893.819430]  dump_backtrace+0x0/0x188
[ 1893.823088]  show_stack+0x14/0x20
[ 1893.826401]  dump_stack+0x98/0xbc
[ 1893.829712]  ___might_sleep+0xf0/0x118
[ 1893.833455]  __might_sleep+0x50/0x88
[ 1893.837028]  cpus_read_lock+0x1c/0x90
[ 1893.840689]  static_key_enable+0x14/0x30
[ 1893.844608]  build_sched_domains+0xe4c/0xf00
[ 1893.848874]  partition_sched_domains+0x2c8/0x410
[ 1893.853486]  rebuild_sched_domains_locked+0xe4/0x430
[ 1893.858446]  rebuild_sched_domains+0x20/0x38
[ 1893.862712]  cpuset_hotplug_workfn+0x28c/0x6b8
[ 1893.867153]  process_one_work+0x114/0x330
[ 1893.871158]  worker_thread+0x130/0x470
[ 1893.874903]  kthread+0x104/0x130
[ 1893.878126]  ret_from_fork+0x10/0x18


This seems to be complaining about holding 'sched_domains_mutex' while
taking the hotplug lock before flipping the static key.

Thing is, both callers of build_sched_domains():

- sched_init_domains()
- partition_sched_domains()

mention that they must be called with the hotplug lock held, so I figured
we could use that information to change the static key call (see snippet
below).

It does suppress the warning, and I *think* it's not completely insane - 
assuming the comments about the hotplug lock are still up to date, and with
the exception of sched_init_smp() which doesn't care about hotplugs it seems
to be the case.

SMT also uses a static key but avoids this issue by being enabled outside of
sched_init_domains(), and from what I see it's just set once and for all.
I'm not sure we can use the same approach since we might not always be able
to detect asymmetry this early.

> Thanks,
> Jiada
> 

Cheers,
Valentin

--->8---

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index b023a5b..89e502e 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -428,8 +428,10 @@ static void update_top_cache_domain(int cpu)
 
 static void update_asym_cpucapacity(int cpu)
 {
-       if (lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY))
-               static_branch_enable(&sched_asym_cpucapacity);
+       if (lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY)) {
+               /* This expects the hotplug lock to be held */
+               static_branch_enable_cpuslocked(&sched_asym_cpucapacity);
+       }
 }
 
 /*
