Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752777AbeA3GVa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 01:21:30 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2447 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752325AbeA3GV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 01:21:29 -0500
From: "zhangheng (AC)" <heng.z@huawei.com>
To: Lai Jiangshan <jiangshanlai+lkml@gmail.com>,
        "lianglihao@huawei.com" <lianglihao@huawei.com>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "Chenhaibo (Haibo, OS Lab)" <hb.chen@huawei.com>,
        "lihao.liang@gmail.com" <lihao.liang@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFC 01/16] prcu: Add PRCU implementation
Thread-Topic: [PATCH RFC 01/16] prcu: Add PRCU implementation
Thread-Index: AQHTlCFdZVEps8k4qEi1V4BR0MIw1qOKE7yAgAHb7IA=
Date: Tue, 30 Jan 2018 06:21:05 +0000
Message-ID: <3FF961283AE1E144A2F945F1AD5573FD014E002B@dggeml508-mbx.china.huawei.com>
References: <1516694381-20333-1-git-send-email-lianglihao@huawei.com>
 <1516694381-20333-2-git-send-email-lianglihao@huawei.com>
 <CAJhGHyC3_W+=kZkNdpDps6iq+XsEMnruxSmrX5-Y=6cBJtX6Wg@mail.gmail.com>
In-Reply-To: <CAJhGHyC3_W+=kZkNdpDps6iq+XsEMnruxSmrX5-Y=6cBJtX6Wg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.142.78.241]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w0U6LfEj028016

>-----Original Message-----
>From: jiangshanlai@gmail.com [mailto:jiangshanlai@gmail.com] On Behalf Of Lai Jiangshan
>Sent: 2018年1月29日 17:11
>To: lianglihao@huawei.com
>Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>; Guohanjun (Hanjun Guo) <guohanjun@huawei.com>; zhangheng (AC) <heng.z@huawei.com>; Chenhaibo (Haibo, OS Lab) <hb.chen@huawei.com>; lihao.liang@gmail.com; LKML <linux-kernel@vger.kernel.org>
>Subject: Re: [PATCH RFC 01/16] prcu: Add PRCU implementation
>
>On Tue, Jan 23, 2018 at 3:59 PM,  <lianglihao@huawei.com> wrote:
>> From: Heng Zhang <heng.z@huawei.com>
>>
>> This RCU implementation (PRCU) is based on a fast consensus protocol 
>> published in the following paper:
>>
>> Fast Consensus Using Bounded Staleness for Scalable Read-mostly Synchronization.
>> Haibo Chen, Heng Zhang, Ran Liu, Binyu Zang, and Haibing Guan.
>> IEEE Transactions on Parallel and Distributed Systems (TPDS), 2016.
>> https://dl.acm.org/citation.cfm?id=3024114.3024143
>>
>> Signed-off-by: Heng Zhang <heng.z@huawei.com>
>> Signed-off-by: Lihao Liang <lianglihao@huawei.com>
>> ---
>>  include/linux/prcu.h |  37 +++++++++++++++
>>  kernel/rcu/Makefile  |   2 +-
>>  kernel/rcu/prcu.c    | 125 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  kernel/sched/core.c  |   2 +
>>  4 files changed, 165 insertions(+), 1 deletion(-)  create mode 100644 
>> include/linux/prcu.h  create mode 100644 kernel/rcu/prcu.c
>>
>> diff --git a/include/linux/prcu.h b/include/linux/prcu.h new file mode 
>> 100644 index 00000000..653b4633
>> --- /dev/null
>> +++ b/include/linux/prcu.h
>> @@ -0,0 +1,37 @@
>> +#ifndef __LINUX_PRCU_H
>> +#define __LINUX_PRCU_H
>> +
>> +#include <linux/atomic.h>
>> +#include <linux/mutex.h>
>> +#include <linux/wait.h>
>> +
>> +#define CONFIG_PRCU
>> +
>> +struct prcu_local_struct {
>> +       unsigned int locked;
>> +       unsigned int online;
>> +       unsigned long long version;
>> +};
>> +
>> +struct prcu_struct {
>> +       atomic64_t global_version;
>> +       atomic_t active_ctr;
>> +       struct mutex mtx;
>> +       wait_queue_head_t wait_q;
>> +};
>> +
>> +#ifdef CONFIG_PRCU
>> +void prcu_read_lock(void);
>> +void prcu_read_unlock(void);
>> +void synchronize_prcu(void);
>> +void prcu_note_context_switch(void);
>> +
>> +#else /* #ifdef CONFIG_PRCU */
>> +
>> +#define prcu_read_lock() do {} while (0) #define prcu_read_unlock() 
>> +do {} while (0) #define synchronize_prcu() do {} while (0) #define 
>> +prcu_note_context_switch() do {} while (0)
>> +
>> +#endif /* #ifdef CONFIG_PRCU */
>> +#endif /* __LINUX_PRCU_H */
>> diff --git a/kernel/rcu/Makefile b/kernel/rcu/Makefile index 
>> 23803c7d..8791419c 100644
>> --- a/kernel/rcu/Makefile
>> +++ b/kernel/rcu/Makefile
>> @@ -2,7 +2,7 @@
>>  # and is generally not a function of system call inputs.
>>  KCOV_INSTRUMENT := n
>>
>> -obj-y += update.o sync.o
>> +obj-y += update.o sync.o prcu.o
>>  obj-$(CONFIG_CLASSIC_SRCU) += srcu.o
>>  obj-$(CONFIG_TREE_SRCU) += srcutree.o
>>  obj-$(CONFIG_TINY_SRCU) += srcutiny.o diff --git a/kernel/rcu/prcu.c 
>> b/kernel/rcu/prcu.c new file mode 100644 index 00000000..a00b9420
>> --- /dev/null
>> +++ b/kernel/rcu/prcu.c
>> @@ -0,0 +1,125 @@
>> +#include <linux/smp.h>
>> +#include <linux/prcu.h>
>> +#include <linux/percpu.h>
>> +#include <linux/compiler.h>
>> +#include <linux/sched.h>
>> +
>> +#include <asm/barrier.h>
>> +
>> +DEFINE_PER_CPU_SHARED_ALIGNED(struct prcu_local_struct, prcu_local);
>> +
>> +struct prcu_struct global_prcu = {
>> +       .global_version = ATOMIC64_INIT(0),
>> +       .active_ctr = ATOMIC_INIT(0),
>> +       .mtx = __MUTEX_INITIALIZER(global_prcu.mtx),
>> +       .wait_q = __WAIT_QUEUE_HEAD_INITIALIZER(global_prcu.wait_q)
>> +};
>> +struct prcu_struct *prcu = &global_prcu;
>> +
>> +static inline void prcu_report(struct prcu_local_struct *local) {
>> +       unsigned long long global_version;
>> +       unsigned long long local_version;
>> +
>> +       global_version = atomic64_read(&prcu->global_version);
>> +       local_version = local->version;
>> +       if (global_version > local_version)
>> +               cmpxchg(&local->version, local_version, 
>> + global_version);
>
>It is called with irq-disabled, and local->version can't be modified on other cpu. why cmpxchg is needed?

No, it will also be called by prcu_read_unlock in this implementation.

>> +}
>> +
>> +void prcu_read_lock(void)
>> +{
>> +       struct prcu_local_struct *local;
>> +
>> +       local = get_cpu_ptr(&prcu_local);
>> +       if (!local->online) {
>> +               WRITE_ONCE(local->online, 1);
>> +               smp_mb();
>
>What's is the paired code?

It is paired with the mutex_lock in synchronize_prcu.
It is used to ensure that if writer see the online is false, there must be no online reader on this core.

>
>> +       }
>> +
>> +       local->locked++;
>> +       put_cpu_ptr(&prcu_local);
>> +}
>> +EXPORT_SYMBOL(prcu_read_lock);
>> +
>> +void prcu_read_unlock(void)
>> +{
>> +       int locked;
>> +       struct prcu_local_struct *local;
>> +
>> +       barrier();
>> +       local = get_cpu_ptr(&prcu_local);
>> +       locked = local->locked;
>> +       if (locked) {
>> +               local->locked--;
>> +               if (locked == 1)
>> +                       prcu_report(local);
>> +               put_cpu_ptr(&prcu_local);
>> +       } else {
>> +               put_cpu_ptr(&prcu_local);
>> +               if (!atomic_dec_return(&prcu->active_ctr))
>> +                       wake_up(&prcu->wait_q);
>> +       }
>> +}
>> +EXPORT_SYMBOL(prcu_read_unlock);
>> +
>> +static void prcu_handler(void *info)
>> +{
>> +       struct prcu_local_struct *local;
>> +
>> +       local = this_cpu_ptr(&prcu_local);
>> +       if (!local->locked)
>> +               WRITE_ONCE(local->version, 
>> +atomic64_read(&prcu->global_version));
>> +}
>> +
>> +void synchronize_prcu(void)
>> +{
>> +       int cpu;
>> +       cpumask_t cpus;
>
>It might overflow the stack if the cpumask is large, please move it to struct prcu.
OK, thank you.

>> +       unsigned long long version;
>> +       struct prcu_local_struct *local;
>> +
>> +       version = atomic64_add_return(1, &prcu->global_version);
>
>I think this line of code at least causes the following problem.
>
>> +       mutex_lock(&prcu->mtx);
>> +
>> +       local = get_cpu_ptr(&prcu_local);
>> +       local->version = version;
>
>The successful orders of mutex_lock() might not be the same the orders of atomic64_add_return(). In this case,
>local->version will be decreased.

Yes, it should read the global_version again.
But I think it is also correct.

>
>prcu_report() can also happen here now. It is unsure who will change successfully the local->version.
>
>> +       put_cpu_ptr(&prcu_local);
>> +
>> +       cpumask_clear(&cpus);
>> +       for_each_possible_cpu(cpu) {
>> +               local = per_cpu_ptr(&prcu_local, cpu);
>> +               if (!READ_ONCE(local->online))
>> +                       continue;
>
>It seems like reading on local->online is unreliable.

Any problem?

>
>> +               if (READ_ONCE(local->version) < version) {
>
>please handle the cases when version wraps around the maximum.

That's why I just want to use 64bit counters.
Resetting counters needs a full system synchronization, which needs to involve a complex protocol.

>
>> +                       smp_call_function_single(cpu, prcu_handler, 
>> + NULL, 0);
>
>it smells bad when it is in for_each_possible_cpu() loop.
>
>> +                       cpumask_set_cpu(cpu, &cpus);
>> +               }
>> +       }
>> +
>> +       for_each_cpu(cpu, &cpus) {
>> +               local = per_cpu_ptr(&prcu_local, cpu);
>> +               while (READ_ONCE(local->version) < version)
>> +                       cpu_relax();
>> +       }
>>
>
>Ouch, the cpu_relax() loop would take a long time.
>Since it will wait until all the relevant cpus scheduled.
>relevant cpus: prcu reader active cpus.
>So this block of code equals to synchronze_sched() in many cases when prcu is massively used. isn't it?

No, it waits for all online readers to do unlocking. I think the read CS should not be long.
If prcu can be massively used (I don't believe...), I plan to split the singleton prcu into multiple allocable instances.
Because each instance only sents ipis to its own online readers, I think it could work better.

>
>
>smp_mb() /* A paired with B */
>
>> +       if (atomic_read(&prcu->active_ctr))
>> +               wait_event(prcu->wait_q, 
>> + !atomic_read(&prcu->active_ctr));
>> +
>> +       mutex_unlock(&prcu->mtx);
>> +}
>> +EXPORT_SYMBOL(synchronize_prcu);
>> +
>> +void prcu_note_context_switch(void)
>> +{
>> +       struct prcu_local_struct *local;
>> +
>> +       local = get_cpu_ptr(&prcu_local);
>> +       if (local->locked) {
>> +               atomic_add(local->locked, &prcu->active_ctr);
>
>smp_mb() /* B paired with A */

Thank you, I should consider more for non-TSO arch.

>
>> +               local->locked = 0;
>> +       }
>> +       local->online = 0;
>> +       prcu_report(local);
>> +       put_cpu_ptr(&prcu_local);
>> +}
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c index 
>> 326d4f88..a308581b 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -15,6 +15,7 @@
>>  #include <linux/init_task.h>
>>  #include <linux/context_tracking.h>
>>  #include <linux/rcupdate_wait.h>
>> +#include <linux/prcu.h>
>>
>>  #include <linux/blkdev.h>
>>  #include <linux/kprobes.h>
>> @@ -3383,6 +3384,7 @@ static void __sched notrace __schedule(bool 
>> preempt)
>>
>>         local_irq_disable();
>>         rcu_note_context_switch(preempt);
>> +       prcu_note_context_switch();
>>
>>         /*
>>          * Make sure that signal_pending_state()->signal_pending() 
>> below
>> --
>> 2.14.1.729.g59c0ea183
>>
>
