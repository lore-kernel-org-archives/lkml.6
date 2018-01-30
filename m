Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751821AbeA3KnA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 05:43:00 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2448 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751457AbeA3Km6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 05:42:58 -0500
From: "zhangheng (AC)" <heng.z@huawei.com>
To: Boqun Feng <boqun.feng@gmail.com>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "lianglihao@huawei.com" <lianglihao@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "Chenhaibo (Haibo, OS Lab)" <hb.chen@huawei.com>,
        "lihao.liang@gmail.com" <lihao.liang@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFC 01/16] prcu: Add PRCU implementation
Thread-Topic: [PATCH RFC 01/16] prcu: Add PRCU implementation
Thread-Index: AQHTlCFdZVEps8k4qEi1V4BR0MIw1qODmaYAgAAUv4CACDoBUP//k8yAgADGq4A=
Date: Tue, 30 Jan 2018 10:42:47 +0000
Message-ID: <3FF961283AE1E144A2F945F1AD5573FD014E118C@dggeml508-mbx.china.huawei.com>
References: <1516694381-20333-1-git-send-email-lianglihao@huawei.com>
 <1516694381-20333-2-git-send-email-lianglihao@huawei.com>
 <20180125061618.GU3741@linux.vnet.ibm.com>
 <20180125073033.4rl7bun62newplb3@tardis>
 <3FF961283AE1E144A2F945F1AD5573FD014DF00C@dggeml508-mbx.china.huawei.com>
 <20180130064057.bzswn6qkz2wlv776@tardis>
In-Reply-To: <20180130064057.bzswn6qkz2wlv776@tardis>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w0UAh5Ql005554

-----Original Message-----
>From: Boqun Feng [mailto:boqun.feng@gmail.com] 
>Sent: 2018Äê1ÔÂ30ÈÕ 14:41
>To: zhangheng (AC) <heng.z@huawei.com>
>Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>; lianglihao@huawei.com; Guohanjun (Hanjun Guo) <guohanjun@huawei.com>; Chenhaibo (Haibo, OS Lab) <hb.chen@huawei.com>; lihao.liang@gmail.com; linux-kernel@vger.kernel.org
>Subject: Re: [PATCH RFC 01/16] prcu: Add PRCU implementation
>
>On Tue, Jan 30, 2018 at 05:34:03AM +0000, zhangheng (AC) wrote:
>[...]
>> >> > +static void prcu_handler(void *info) {
>> >> > +	struct prcu_local_struct *local;
>> >> > +
>> >> > +	local = this_cpu_ptr(&prcu_local);
>> >> > +	if (!local->locked)
>> >
>> >And I think a smp_mb() is needed here, because in the following case:
>> >
>> >	CPU 0				          CPU 1
>> >	==================		==========================
>> >	{X is initially 0}
>> >
>> >	WRITE_ONCE(X, 1);
>> >
>> >	                      prcu_read_unlock(void):
>> >	                      if (locked) {
>> >	  				              synchronize_prcu(void):
>> >					                ...
>> >					                <send IPI to CPU 0>
>> >	local->locked--;
>> >	                      # switch to IPI
>> > WRITE_ONCE(local->version,....)
>> >	  				            <read CPU 0 version to be latest>
>> >					              <return>
>> >
>> >					              r1 = READ_ONCE(X);
>> >
>> >r1 could be 0, which breaks RCU guarantees.
>> >
>> 
>> Thank you.
>> As I know,
>> it guarantees that the interrupt to be handled after all write instructions issued before have complete in x86 arch.
>> So the smp_mb is meaningless in x86 arch.
>
>Sure. x86 is TSO, and we are talking about reordering of two stores here, and that can not happen on TSO.
>
>> But I am not sure whether other archs guarantee this feature. If not, we do need a smp_mb here.
>> 
>
>I think most of the weak memory model don't have this gaurantee, so you need a smp_mb() or use smp_store_release().

Agree.

>
>> >> > +		WRITE_ONCE(local->version, 
>> >> > +atomic64_read(&prcu->global_version));
>> >> > +}
>> >> > +
>> >> > +void synchronize_prcu(void)
>> >> > +{
>> >> > +	int cpu;
>> >> > +	cpumask_t cpus;
>> >> > +	unsigned long long version;
>> >> > +	struct prcu_local_struct *local;
>> >> > +
>> >> > +	version = atomic64_add_return(1, &prcu->global_version);
>> >> > +	mutex_lock(&prcu->mtx);
>> >> > +
>> >> > +	local = get_cpu_ptr(&prcu_local);
>> >> > +	local->version = version;
>> >> > +	put_cpu_ptr(&prcu_local);
>> >> > +
>> >> > +	cpumask_clear(&cpus);
>> >> > +	for_each_possible_cpu(cpu) {
>> >> > +		local = per_cpu_ptr(&prcu_local, cpu);
>> >> > +		if (!READ_ONCE(local->online))
>> >> > +			continue;
>> >> > +		if (READ_ONCE(local->version) < version) {
>> >> 
>> >> On 32-bit systems, given that ->version is long long, you might see 
>> >> load tearing.  And on some 32-bit systems, the cmpxchg() in
>> >> prcu_hander() might not build.
>> >> 
>> >
>> >/me curious about why an atomic64_t is used here for global version. I think maybe 32bit global version still suffices.
>> >
>> >Regards,
>> >Boqun
>> 
>> Because the synchronization latency is low, it can have higher gp frequency.
>> It seems that 32bit can only correctly work for several years if there are 20+ gps per second.
>> 
>
>Because PRCU doesn't handle gp number overflow? May I ask why this is difficult? Currently RCU could tolerate counter wrap for grace period:
>
>	https://lwn.net/Articles/652677/ (Details in "Parallelism facts of life")
>
>Is there any subtle difference I'm missing?
>
>Regards,
>Boqun
>

Yes, you are right. Currently prcu hasn't given a solution for overflow thus it needs a 64-bit counter.
Giving a solution is not that difficult. I just didn't consider it when I use 64-bit counter.
Since 64-bit counter isn't friendly for 32-bit system, I agree that 32-bit counter + overflow handler is necessary.
Thank you.

>> >
>> >> Or is the idea that only prcu_handler() updates ->version?  But in 
>> >> that case, you wouldn't need the READ_ONCE() above.  What am I missing here?
>> >> 
>> >> > +			smp_call_function_single(cpu, prcu_handler, NULL, 0);
>> >> > +			cpumask_set_cpu(cpu, &cpus);
>> >> > +		}
>> >> > +	}
>> >> > +
>> >> > +	for_each_cpu(cpu, &cpus) {
>> >> > +		local = per_cpu_ptr(&prcu_local, cpu);
>> >> > +		while (READ_ONCE(local->version) < version)
>> >> 
>> >> This ->version read can also tear on some 32-bit systems, and this 
>> >> one most definitely can race with the prcu_handler() above.  Does 
>> >> the algorithm operate correctly in that case?  (It doesn't look 
>> >> that way to me, but I might be missing something.) Or are 32-bit systems excluded?
>> >> 
>> >> > +			cpu_relax();
>> >> > +	}
>> >> 
>> >> I might be missing something, but I believe we need a memory 
>> >> barrier here on non-TSO systems.  Without that, couldn't we miss a preemption?
>> >> 
>> >> > +
>> >> > +	if (atomic_read(&prcu->active_ctr))
>> >> > +		wait_event(prcu->wait_q, !atomic_read(&prcu->active_ctr));
>> >> > +
>> >> > +	mutex_unlock(&prcu->mtx);
>> >> > +}
>> >> > +EXPORT_SYMBOL(synchronize_prcu);
>> >> > +
>> >> > +void prcu_note_context_switch(void) {
>> >> > +	struct prcu_local_struct *local;
>> >> > +
>> >> > +	local = get_cpu_ptr(&prcu_local);
>> >> > +	if (local->locked) {
>> >> > +		atomic_add(local->locked, &prcu->active_ctr);
>> >> > +		local->locked = 0;
>> >> > +	}
>> >> > +	local->online = 0;
>> >> > +	prcu_report(local);
>> >> > +	put_cpu_ptr(&prcu_local);
>> >> > +}
>> >> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c index 
>> >> > 326d4f88..a308581b 100644
>> >> > --- a/kernel/sched/core.c
>> >> > +++ b/kernel/sched/core.c
>> >> > @@ -15,6 +15,7 @@
>> >> >  #include <linux/init_task.h>
>> >> >  #include <linux/context_tracking.h>  #include 
>> >> > <linux/rcupdate_wait.h>
>> >> > +#include <linux/prcu.h>
>> >> > 
>> >> >  #include <linux/blkdev.h>
>> >> >  #include <linux/kprobes.h>
>> >> > @@ -3383,6 +3384,7 @@ static void __sched notrace __schedule(bool
>> >> > preempt)
>> >> > 
>> >> >  	local_irq_disable();
>> >> >  	rcu_note_context_switch(preempt);
>> >> > +	prcu_note_context_switch();
>> >> > 
>> >> >  	/*
>> >> >  	 * Make sure that signal_pending_state()->signal_pending() 
>> >> > below
>> >> > --
>> >> > 2.14.1.729.g59c0ea183
>> >> > 
>> >> 
>> >
>
