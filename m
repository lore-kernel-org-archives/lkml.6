Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752660AbeA3D7G (ORCPT <rfc822;w@1wt.eu>);
        Mon, 29 Jan 2018 22:59:06 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2446 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752596AbeA3D7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jan 2018 22:59:04 -0500
From: "zhangheng (AC)" <heng.z@huawei.com>
To: "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>,
        "lianglihao@huawei.com" <lianglihao@huawei.com>
CC: "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "Chenhaibo (Haibo, OS Lab)" <hb.chen@huawei.com>,
        "lihao.liang@gmail.com" <lihao.liang@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFC 01/16] prcu: Add PRCU implementation
Thread-Topic: [PATCH RFC 01/16] prcu: Add PRCU implementation
Thread-Index: AQHTlCFdZVEps8k4qEi1V4BR0MIw1qODmaYAgAJMvaCABe150A==
Date: Tue, 30 Jan 2018 03:58:52 +0000
Message-ID: <3FF961283AE1E144A2F945F1AD5573FD014DDF57@dggeml508-mbx.china.huawei.com>
References: <1516694381-20333-1-git-send-email-lianglihao@huawei.com>
 <1516694381-20333-2-git-send-email-lianglihao@huawei.com>
 <20180125061618.GU3741@linux.vnet.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.142.78.241]
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w0U3xAix021043

Very sorry for late response, I found this email has been blocked after Lihao mentioned this morning.

-----Original Message-----
From: zhangheng (AC) 
Sent: 2018年1月26日 18:30
To: 'paulmck@linux.vnet.ibm.com' <paulmck@linux.vnet.ibm.com>; lianglihao@huawei.com
Cc: Guohanjun (Hanjun Guo) <guohanjun@huawei.com>; Chenhaibo (Haibo, OS Lab) <hb.chen@huawei.com>; lihao.liang@gmail.com; linux-kernel@vger.kernel.org
Subject: RE: [PATCH RFC 01/16] prcu: Add PRCU implementation

Hi Paul, thanks a lot for pointing out the problems of the implementation. Here's my understanding.

Best Regards,
Heng

-----Original Message-----
>From: Paul E. McKenney [mailto:paulmck@linux.vnet.ibm.com]
>Sent: 2018年1月25日 14:16
>To: lianglihao@huawei.com
>Cc: Guohanjun (Hanjun Guo) <guohanjun@huawei.com>; zhangheng (AC) 
><heng.z@huawei.com>; Chenhaibo (Haibo, OS Lab) <hb.chen@huawei.com>; 
>lihao.liang@gmail.com; linux-kernel@vger.kernel.org
>Subject: Re: [PATCH RFC 01/16] prcu: Add PRCU implementation

>On Tue, Jan 23, 2018 at 03:59:26PM +0800, lianglihao@huawei.com wrote:
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

>A few comments and questions interspersed.

>							Thanx, Paul

>> ---
>>  include/linux/prcu.h |  37 +++++++++++++++
>>  kernel/rcu/Makefile  |   2 +-
>>  kernel/rcu/prcu.c    | 125 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  kernel/sched/core.c  |   2 +
>>  4 files changed, 165 insertions(+), 1 deletion(-)  create mode 
>> 100644 include/linux/prcu.h  create mode 100644 kernel/rcu/prcu.c
>> 
>> diff --git a/include/linux/prcu.h b/include/linux/prcu.h new file 
>> mode
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
>> +	unsigned int locked;
>> +	unsigned int online;
>> +	unsigned long long version;
>> +};
>> +
>> +struct prcu_struct {
>> +	atomic64_t global_version;
>> +	atomic_t active_ctr;
>> +	struct mutex mtx;
>> +	wait_queue_head_t wait_q;
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

>If CONFIG_PRCU=n and some code is built that uses PRCU, shouldn't you get a build error rather than an error-free but inoperative PRCU?

>Of course, Peter's question about purpose of the patch set applies here as well.

Yes, we should handle this case more carefully.
And in my personal opinion, prcu is designed for some modules that have a few threads and require low synchronization latency (because it just sends IPIs to online readers). I think if a module that uses synchronize_rcu_expedited, it may need prcu.

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
>> +	.global_version = ATOMIC64_INIT(0),
>> +	.active_ctr = ATOMIC_INIT(0),
>> +	.mtx = __MUTEX_INITIALIZER(global_prcu.mtx),
>> +	.wait_q = __WAIT_QUEUE_HEAD_INITIALIZER(global_prcu.wait_q)
>> +};
>> +struct prcu_struct *prcu = &global_prcu;
>> +
>> +static inline void prcu_report(struct prcu_local_struct *local) {
>> +	unsigned long long global_version;
>> +	unsigned long long local_version;
>> +
>> +	global_version = atomic64_read(&prcu->global_version);
>> +	local_version = local->version;
>> +	if (global_version > local_version)
>> +		cmpxchg(&local->version, local_version, global_version); }
>> +
>> +void prcu_read_lock(void)
>> +{
>> +	struct prcu_local_struct *local;
>> +
>> +	local = get_cpu_ptr(&prcu_local);
>> +	if (!local->online) {
>> +		WRITE_ONCE(local->online, 1);
>> +		smp_mb();
>> +	}
>> +
>> +	local->locked++;
>> +	put_cpu_ptr(&prcu_local);
>> +}
>> +EXPORT_SYMBOL(prcu_read_lock);
>> +
>> +void prcu_read_unlock(void)
>> +{
>> +	int locked;
>> +	struct prcu_local_struct *local;
>> +
>> +	barrier();
>> +	local = get_cpu_ptr(&prcu_local);
>> +	locked = local->locked;
>> +	if (locked) {
>> +		local->locked--;
>> +		if (locked == 1)
>> +			prcu_report(local);

>Is ordering important here?  It looks to me that the compiler could rearrange some of the accesses within prcu_report() with the local->locked decrement.  There appears to be some potential for load and store tearing, though perhaps you have verified that your compiler avoids this on the architecture that you are using.

You are right. I should add a barrier() here. If the prcu_report() does effect (update local_version) when locked != 1 because of the rearrange, the prcu must cause problem.

>> +		put_cpu_ptr(&prcu_local);
>> +	} else {

>Hmmm...  We get here if the RCU read-side critical section was preempted.
>If none of them are preempted, ->active_ctr remains zero.

Yeah, unless the user calls prcu_read_unlock without prcu_read_lock, the activer_ctr must be non-zero.

>> +		put_cpu_ptr(&prcu_local);
>> +		if (!atomic_dec_return(&prcu->active_ctr))
>> +			wake_up(&prcu->wait_q);
>> +	}
>> +}
>> +EXPORT_SYMBOL(prcu_read_unlock);
>> +
>> +static void prcu_handler(void *info) {
>> +	struct prcu_local_struct *local;
>> +
>> +	local = this_cpu_ptr(&prcu_local);
>> +	if (!local->locked)
>> +		WRITE_ONCE(local->version, atomic64_read(&prcu->global_version));
>> +}
>> +
>> +void synchronize_prcu(void)
>> +{
>> +	int cpu;
>> +	cpumask_t cpus;
>> +	unsigned long long version;
>> +	struct prcu_local_struct *local;
>> +
>> +	version = atomic64_add_return(1, &prcu->global_version);
>> +	mutex_lock(&prcu->mtx);
>> +
>> +	local = get_cpu_ptr(&prcu_local);
>> +	local->version = version;
>> +	put_cpu_ptr(&prcu_local);
>> +
>> +	cpumask_clear(&cpus);
>> +	for_each_possible_cpu(cpu) {
>> +		local = per_cpu_ptr(&prcu_local, cpu);
>> +		if (!READ_ONCE(local->online))
>> +			continue;
>> +		if (READ_ONCE(local->version) < version) {

>On 32-bit systems, given that ->version is long long, you might see load tearing.  And on some 32-bit systems, the cmpxchg() in prcu_hander() might not build.

>Or is the idea that only prcu_handler() updates ->version?  But in that case, you wouldn't need the READ_ONCE() above.  What am I missing here?

Thanks, I didn't consider the problems on 32-bit systems, so this comments are really helpful.
I must use 64-bit counter to avoid overflow. So if it doesn't work on 32-bit system, I think I should add a spinlock for each local->version.

>> +			smp_call_function_single(cpu, prcu_handler, NULL, 0);
>> +			cpumask_set_cpu(cpu, &cpus);
>> +		}
>> +	}
>> +
>> +	for_each_cpu(cpu, &cpus) {
>> +		local = per_cpu_ptr(&prcu_local, cpu);
>> +		while (READ_ONCE(local->version) < version)

>This ->version read can also tear on some 32-bit systems, and this one most definitely can race with the prcu_handler() above.  Does the algorithm operate correctly in that case?  (It doesn't look that way to me, but I might be missing something.) Or are 32-bit systems excluded?

>> +			cpu_relax();
>> +	}

>I might be missing something, but I believe we need a memory barrier here on non-TSO systems.  Without that, couldn't we miss a preemption?

Yes, a memory barrier is reasonable here for non-TSO. Otherwise the following atomic_read may be reordered before all CPUs' report.

>> +
>> +	if (atomic_read(&prcu->active_ctr))
>> +		wait_event(prcu->wait_q, !atomic_read(&prcu->active_ctr));
>> +
>> +	mutex_unlock(&prcu->mtx);
>> +}
>> +EXPORT_SYMBOL(synchronize_prcu);
>> +
>> +void prcu_note_context_switch(void)
>> +{
>> +	struct prcu_local_struct *local;
>> +
>> +	local = get_cpu_ptr(&prcu_local);
>> +	if (local->locked) {
>> +		atomic_add(local->locked, &prcu->active_ctr);
>> +		local->locked = 0;
>> +	}
>> +	local->online = 0;
>> +	prcu_report(local);
>> +	put_cpu_ptr(&prcu_local);
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
>>  	local_irq_disable();
>>  	rcu_note_context_switch(preempt);
>> +	prcu_note_context_switch();
>> 
>>  	/*
>>  	 * Make sure that signal_pending_state()->signal_pending() below
>> --
>> 2.14.1.729.g59c0ea183
>> 
